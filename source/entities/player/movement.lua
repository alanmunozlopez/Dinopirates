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

function Player:move(direction)
  if PlayerData.isGaming == true then
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
      self:pedometer()
    end
  end
end
