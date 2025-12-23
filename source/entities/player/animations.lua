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
  
  self.animation:addState('dashLeft', 69, 72)
  self.animation.dashLeft.frameDuration = 3
  
  self.animation:addState('dashUp', 65, 68)
  self.animation.dashUp.frameDuration = 3
  
  self.animation:addState('dashDown', 65, 68)
  self.animation.dashDown.frameDuration = 3
  
  self.animation:addState('tinyIdle', 73, 81)
  self.animation.tinyIdle.frameDuration = 3
  
  self.animation:addState('tinyRight', 82, 84)
  self.animation.tinyRight.frameDuration = 3
  
  self.animation:addState('tinyLeft', 85, 87)
  self.animation.tinyLeft.frameDuration = 3
  
  self.animation:addState('tinyDown', 88, 90)
  self.animation.tinyDown.frameDuration = 3
  
  self.animation:addState('tinyUp', 91, 93)
  self.animation.tinyUp.frameDuration = 3
  
  self.animation:addState('transformTo', 94, 99, 'tinyIdle')
  self.animation.transformTo.frameDuration = 3
  
  self.animation:addState('transformCycle', 100, 105)
  self.animation.transformCycle.frameDuration = 3
  
  if (PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true and  PlayerData.isTiny == false) then
    self.animation:setState('lampIdle')
  elseif PlayerData.isTiny == true then
    self.animation:setState('tinyIdle')
  else
    self.animation:setState('idle')
  end
  
end

