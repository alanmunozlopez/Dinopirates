
Hats = {}
class('Hats').extends(NobleSprite)

function Hats:init(x, y, type, zIndex)
  Hats.super.init(self,'assets/images/props/hats', true)
  --- animation states
  self.animation:addState('chef', 2, 2)
  if type == nil then
    type = 'chef'
  end
  self.animation:setState(type)
  -- position and z-index
  self:setSize(20, 16)
  self:setZIndex(zIndex)
  self:setGroups(3)
  self:add(x,y)
end


