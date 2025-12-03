
MenuTitle = {}
class('MenuTitle ').extends(NobleSprite)

function MenuTitle :init(x, y, type, zIndex)
  MenuTitle .super.init(self,'assets/images/screens/menuTitle', true)
  --- animation states
  self.animation:addState('defContinue', 1, 1)
  self.animation:addState('selContinue', 2, 2)
  self.animation:addState('defNewGame', 3, 3)
  self.animation:addState('selNewGame', 4, 4)
  self.animation:addState('defDeleteGame', 5, 5)
  self.animation:addState('selDeleteGame', 6, 6)
  self.animation:addState('defAchievements', 7, 7)
  self.animation:addState('selAchievements', 8, 8)
  self.animation:setState(type)
  -- position and z-index
  self:setSize(180, 56)
  self:setZIndex(zIndex)
  self:setGroups(3)
  self:add(x,y)
end


