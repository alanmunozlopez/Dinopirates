function Player:fallBelow()
  local level = PlayerData.actualLevel + 1
  local room = PlayerData.actualRoom
  local sceneName = "Floor" .. tostring(level) .. tostring(room)
  local nextScene = _G[sceneName]
  PlayerData.playerSpawn.x =  self.x
  PlayerData.playerSpawn.y = self.y
  
  if nextScene then
    Noble.transition(nextScene, 1.5, Noble.Transition.Imagetable,
      {
        imagetableEnter = Graphics.imagetable.new('assets/images/screens/transitions/transitionFallEnter'),
        imagetableExit = Graphics.imagetable.new('assets/images/screens/transitions/transitionFallOut'),
    })
    -- Noble.transition(nextScene, 1.5, Noble.Transition.Default)
  else
    print("Scene " .. sceneName .. " not found. did you fall into the void")
  end
end

function Player:displayDialog(script)
  self.dialogUI:nextDialog()
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

function Player:fight()
  PlayerData.amountDances += 1
  Noble.transition(DanceScene)
end

function Player:dead() -- unused
  self.isAlive = false
  local function deathScreen()
  
    Noble.transition(DeadScene)
  
  end
  playdate.timer.performAfterDelay(1000, deathScreen)
end

function Player:focus() -- unused
  if PlayerData.sanity > 20 then
    PlayerData.sanity -= 20 
    PlayerData.isFocused = true
  end
end

function Player:pedometer()
  PlayerData.steps += 0.5
  -- print("steps " .. PlayerData.steps .. "/  steps " .. PlayerData.totalSteps .."/ calories ".. PlayerData.calories)
  if PlayerData.steps >= 200 then
    PlayerData.totalSteps += PlayerData.steps
    PlayerData.steps = 0
    self:burnCalories(10)
  end
end
function Player:burnCalories(calories)
    PlayerData.calories -= calories 
end

function Player:deFocus() -- unused
  if PlayerData.isFocused == true then
    PlayerData.isFocused = false
  end
end

function Player:update()
  -- Check for dialog activation (A button)
  if self.currentTrigger and playdate.buttonJustPressed(playdate.kButtonA) then
      local trigger = self.currentTrigger
  
      PlayerData.isGaming = false
      PlayerData.isTalking = true
      self.dialogUI:addScreen(trigger:returnScript(), trigger.sourceFeed)
  
      Utilities.grantAchievementIfNeeded(trigger.script)
  end
  if self.currentTrigger then
      local stillInside = false
      for _, sprite in ipairs(self:overlappingSprites()) do
          if sprite == self.currentTrigger then
              stillInside = true
              self.uiHud:setVisible(true)
              break
          end
      end
      if not stillInside then
          self.uiHud:setVisible(false)
          self.currentTrigger = nil
      end
  end
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

