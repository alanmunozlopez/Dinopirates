
TitleBackground = {}
class('TitleBackground').extends(NobleSprite)

function TitleBackground:init(x, y, zIndex)
  TitleBackground.super.init(self,'assets/images/screens/title-background', true)
  
  -- Set size BEFORE animation states (required by NobleEngine)
  self:setSize(400, 240)
  
  -- Set image draw mode for the sprite
  self:setImageDrawMode(Graphics.kDrawModeCopy)
  
  --- animation states - one for each menu option
  self.animation:addState('continue', 1, 1)
  self.animation:addState('newGame', 2, 2)
  self.animation:addState('deleteGame', 3, 3)
  self.animation:addState('achievements', 4, 4)
  
  -- Default to first frame
  self.animation:setState('continue')
  
  -- position and z-index
  self:setZIndex(zIndex)
  self:setCenter(0.5, 0.5)
  self:add(x, y)
end

function TitleBackground:changeState(state)
  if self.animation then
    self.animation:setState(state)
  end
end
