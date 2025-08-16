function Player:initAnimations()
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
end

