function Player:move(direction)
  if PlayerData.isGaming == true then
    -- Don't allow normal movement while dashing
    if self.isDashing then
      return
    end
    
    if self.isAlive == true and PlayerData.isCharging == false then
      PlayerData.isActive = true
      self.direction = direction
      local movementX = 0
      local movementY = 0
      if PlayerData.isInDarkness == true then
        self:drainBattery(0.5)
      end
      if (direction == "left") then
        if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
          self.animation:setState('lampLeft')
        else
          self.animation:setState('left')
        end
        movementX = self.x - self.speed
        movementY = self.y
      elseif (direction == "right") then
        if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
          self.animation:setState('lampRight')
        else
          self.animation:setState('right')
        end
        movementX = self.x + self.speed
        movementY = self.y
      elseif (direction == "up") then
        if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
          self.animation:setState('up')
        else
          self.animation:setState('up')
        end
        movementX = self.x 
        movementY = self.y - self.speed
      elseif (direction == "down") then
        if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
          self.animation:setState('lampDown')
        else
          self.animation:setState('down')
        end
        movementX = self.x 
        movementY = self.y + self.speed
      end
      
      self.uiHud:moveTo(movementX + self.playerUIX, movementY - self.playerUIY)
      
      local actualX, actualY, collisions, lenght = self:moveWithCollisions(movementX, movementY )
      
      PlayerData.direction = direction
      self:pedometer()
    end
  end
end
