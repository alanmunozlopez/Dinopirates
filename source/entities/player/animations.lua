function Player:initAnimations()
  local frameDurationWalk = 6
  self.animation:addState('idle', 41, 52)
  self.animation.idle.frameDuration = 12
  
  self.animation:addState('right', 11, 15)
  self.animation.right.frameDuration = frameDurationWalk 
  
  self.animation:addState('left', 1, 5)
  self.animation.left.frameDuration = frameDurationWalk 
  
  self.animation:addState('down', 26, 30)
  self.animation.down.frameDuration = frameDurationWalk 
  
  self.animation:addState('up', 21, 25)
  self.animation.up.frameDuration = frameDurationWalk 
  
  self.animation:addState('lampIdle', 53, 64)
  self.animation.lampIdle.frameDuration = 24
  
  self.animation:addState('lampRight', 16, 20)
  self.animation.lampRight.frameDuration = 12
  
  self.animation:addState('lampLeft', 6, 10)
  self.animation.lampLeft.frameDuration = 12
  
  self.animation:addState('lampDown', 31, 35)
  self.animation.lampDown.frameDuration = 12
  
  self.animation:addState('charge', 36, 40)
  self.animation.charge.frameDuration = 12
  
  self.animation:addState('dashRight', 65, 68)
  self.animation.dashRight.frameDuration = 3
  
  if (PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true) then
    self.animation:setState('lampIdle')
  else
    self.animation:setState('idle')
  end
end

