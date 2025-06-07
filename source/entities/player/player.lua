Player = {}
class('Player').extends(NobleSprite)
import "entities/UI/dialog/dialogScreen"

local dialogUI = nil

function Player:init(x, y, speed, Zindex)
  Player.super.init(self,'assets/images/player/player', true)
  
  -- Mark: animation states
  self.animation:addState('idle', 1, 4)
  self.animation.idle.frameDuration = 24
  
  self.animation:addState('right', 5, 7)
  self.animation.right.frameDuration = 12
  
  self.animation:addState('left', 8, 10)
  self.animation.left.frameDuration = 12
  
  self.animation:addState('down', 11, 13)
  self.animation.down.frameDuration = 12
  
  self.animation:addState('up', 14, 16)
  self.animation.up.frameDuration = 12
  
  self.animation:addState('deadBrocolli', 17, 18)
  self.animation.deadBrocolli.frameDuration = 12
  
  self.animation:addState('lampIdle', 19, 22)
  self.animation.lampIdle.frameDuration = 24
  
  self.animation:addState('lampRight', 23, 25)
  self.animation.lampRight.frameDuration = 12
  
  self.animation:addState('lampLeft', 26, 28)
  self.animation.lampLeft.frameDuration = 12
  
  self.animation:addState('lampDown', 29, 31)
  self.animation.lampDown.frameDuration = 12
  
  self.animation:addState('charge', 32, 35)
  self.animation.charge.frameDuration = 12
  
  if (PlayerData.hasLamp == true and PlayerData.isInDarkness == true) then
    self.animation:setState('lampIdle')
  else
    self.animation:setState('idle')
  end
  
  -- Mark: basic properties
  self:setSize(48, 52)
  self:setZIndex(Zindex)
  self:moveTo(x,y)
  self:setCollideRect(10, 24, 30, 24)
  self:setCollidesWithGroups(
    {
      CollideGroups.enemy,
      CollideGroups.props,
      CollideGroups.items,
      CollideGroups.wall
    })
  self:setGroups(CollideGroups.player)
  
  -- Mark: Custom properties
  self.initialSpeed = speed
  self.speed = speed
  self.initialSanity = PlayerData.sanity
  self.initialBattery = PlayerData.battery
  self.sanityLoss = 1
  self.sanity = PlayerData.sanity
  
  PlayerData.isActive = false
  self.loadingPower = false
  self.isAlive = true
  
  -- Mark: Custom items properties
  PlayerData.battery = PlayerData.battery
  self.hasKey = false
  PlayerData.hasLamp = PlayerData.hasLamp
  PlayerData.isInDarkness = PlayerData.isInDarkness
  
  -- Mark: add to scene
  dialogUI = dialogScreen()
  self:sanityCheck()
  self:add(x, y)   
  
end 

function Player:collisionResponse(other)
  
  if other:isa(Enemy) then
    if other:isa(Brocorat) then -- validate candance also
      -- other:empty()
      --other.animation:setState('empty')  -- Set enemy animation to empty state
      --self.animation:setState('deadBrocolli')
      PlayerData.lastEnemyTouched.type = "Brocorat"
      PlayerData.lastEnemyTouched.id = other.id
      PlayerData.lastEnemyTouched.x = other.x
      PlayerData.lastEnemyTouched.y = other.y
      self:fight()
      return 'overlap'
      
    end
    
  elseif other:isa(CrewMember) then
    other:taken() 
    
  elseif other:isa(Box) then
    return 'freeze' 
  elseif other:isa(Trigger) then
    
    if other.type == nil and other.type ~= "cutscene" then
      PlayerData.isTalking = true
      dialogUI:addScreen(other:returnScript(),other.sourceFeed)
    end
    
    if other.type == "cutscene" then
      PlayerData.isCutscene = true
      other:returnScript()
      other:remove()
    end
    
    Utilities.grantAchievementIfNeeded(other.script)
    
    return 'freeze'
  elseif other:isa(Items) and other.type == 'keycard' then
    other:removeAll()
    self:grabKey()
    return 'overlap'
  elseif other:isa(Items) and other.type == 'lamp' then
    other:removeAll()
    self:grabLamp()
    return 'overlap'
  elseif other:isa(Items) and other.type == 'radio' then
    other:removeAll()
    self:grabRadio()
    return 'overlap'
  elseif other:isa(Items) and other.type == 'notes' then
    other:removeAll()
    self:grabNotes()
    return 'overlap'
  elseif other:isa(Items) and other.type == 'bag' then
    other:removeAll()
    self:grabBag()
    return 'overlap'
  elseif other:isa(Items) and other.type == 'tools' then
    other:removeAll()
    self:grabTools()
    return 'overlap'
  elseif other:isa(PropItem) and (other.type == 'holeLeft' or other.type == 'holeRight')then
    
    if (PlayerData.hasBoots == true and PlayerData.battery == 0) or PlayerData.hasBoots == false  then
      print('falling')
      self:fallBelow()
      return 'overlap'
    elseif PlayerData.hasBoots == true then
      
      self:drainBattery(1)
      print('fly')
    return 'overlap'
    end

  elseif other:isa(Door) then
    
    if (PlayerData.hasKey == true and other.status == 'closed') or other.status =='open' then
      other:prevRoom(other.direction)
      other:goTo()
      return 'overlap'
    else
      PlayerData.isTalking = true
      dialogUI:addScreen("nokeys")
      return 'freeze'
    end
  
  end
  
end

function Player:fallBelow()
  local level = PlayerData.actualLevel + 1
  local room = PlayerData.actualRoom
  local sceneName = "Floor" .. tostring(level) .. tostring(room)
  local nextScene = _G[sceneName]

  if nextScene then
    Noble.transition(nextScene, 1.5, Noble.Transition.Default)
  else
    print("Scene " .. sceneName .. " not found.")
  end
end

function Player:displayDialog(script)
  dialogUI:nextDialog()
end

function Player:idle()
  if self.isAlive == true then
    if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
      self.animation:setState('lampIdle')
    else
      self.animation:setState('idle')
    end
    PlayerData.direction = 'idle'
  end
end

function Player:sanityCheck()

  local function checkSanity()
    local lastSanity = PlayerData.sanity 
    if PlayerData.battery < 20 and PlayerData.isInDarkness == true then 
      PlayerData.sanity -= 2 * self.sanityLoss
    elseif PlayerData.battery < 40 and PlayerData.isInDarkness == true then
      PlayerData.sanity -= self.sanityLoss
    end

    -- Check if sanity just reached zero
    if PlayerData.sanity <= 0 and lastSanity > 0 then
      PlayerData.sanityCounter += 1
      PlayerData.sanity = 0
    end

    if PlayerData.battery > 50 or PlayerData.isInDarkness == false then
      PlayerData.sanity += 2 * self.sanityLoss
    end

    if PlayerData.sanity >= 100 then
      PlayerData.sanity = 100
    end

    -- Update lastSanity for the next check
    lastSanity = PlayerData.sanity
  end

  playdate.timer.keyRepeatTimerWithDelay(2000, 2000, checkSanity)
end

function Player:fight()
  PlayerData.amountDances += 1
  PlayerData.isDancing = true 
  Noble.transition(DanceScene)
end

function Player:dead() -- unused
  self.isAlive = false
  self.animation:setState('deadBrocolli')
  local function deathScreen()
  
    Noble.transition(DeadScene)
  
  end
  playdate.timer.performAfterDelay(1000, deathScreen)
end

function Player:move(direction)
  if self.isAlive == true and PlayerData.isCharging == false then
    PlayerData.isActive = true
    self.direction = direction
    local movementX = 0
    local movementY = 0
    if PlayerData.isInDarkness == true then
      self:drainBattery(0.5)
    end
    if (direction == "left") then
      if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
        self.animation:setState('lampLeft')
      else
        self.animation:setState('left')
      end
      movementX = self.x - self.speed
      movementY = self.y
    elseif (direction == "right") then
      if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
        self.animation:setState('lampRight')
      else
        self.animation:setState('right')
      end
      movementX = self.x + self.speed
      movementY = self.y
    elseif (direction == "up") then
      if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
        self.animation:setState('up')
      else
        self.animation:setState('up')
      end
      movementX = self.x 
      movementY = self.y - self.speed
    elseif (direction == "down") then
      if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
        self.animation:setState('lampDown')
      else
        self.animation:setState('down')
      end
      movementX = self.x 
      movementY = self.y + self.speed
    end
    local actualX, actualY, collisions, lenght = self:moveWithCollisions(movementX, movementY )
    PlayerData.direction = direction
  end
end


function Player:focus() -- unused
  if PlayerData.sanity > 20 then
    PlayerData.sanity -= 20 
    PlayerData.isFocused = true
  end
end

function Player:deFocus() -- unused
  if PlayerData.isFocused == true then
    PlayerData.isFocused = false
  end
end

function Player:drainBattery(amount)
  PlayerData.battery -= amount
end

function Player:chargeBattery(amount)
  if PlayerData.battery < 100 and PlayerData.hasLamp == true then
    self.animation:setState('charge')
  elseif (PlayerData.hasLamp == true) then
    self.animation:setState('lampIdle')
  end
  PlayerData.battery += amount
  PlayerData.isActive = true
end

function Player:fillBattery()
    PlayerData.battery = 100
end

function Player:grabBoots()
  PlayerData.hasBoots = true
end

function Player:grabBag()
  PlayerData.hasBag = true
end

function Player:grabTools()
  PlayerData.hasTools = true
end

function Player:grabKey()
  PlayerData.hasKey = true
end

function Player:grabLamp()
  PlayerData.hasLamp = true
  self:fillBattery()
end

function Player:grabRadio()
  PlayerData.hasRadio = true
end

function Player:grabNotes()
  PlayerData.hasNotes = true
  Utilities.grantAchievementIfNeeded("notebook")
end

function Player:update()
  -- Mark: save actual position
  PlayerData.x = self.x
  PlayerData.y = self.y
  -- Mark: battery bounds
  if PlayerData.battery < 0 then
    PlayerData.battery = 0
  elseif PlayerData.battery >= 100 then
    PlayerData.battery = 100
  end
  -- Mark: Reduce speed in the dark
  if PlayerData.hasLamp == true and PlayerData.isInDarkness == true then
    if PlayerData.battery < 20 then 
      self.speed = 0.5 * self.initialSpeed
    elseif PlayerData.battery > 20 then
      self.speed = self.initialSpeed
    end
  end
  if PlayerData.isInDarkness == true and PlayerData.hasLamp == false then
    self.speed = 0.5 * self.initialSpeed
  end
  PlayerData.isActive = false
  Utilities.checkSanityAchievements()
end

