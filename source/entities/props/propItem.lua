import 'entities/props/propCollider'
PropItem = {}
class('PropItem').extends(NobleSprite)

function PropItem:init(x, y, type, zIndex, nocollide, id)
  PropItem.super.init(self,'assets/images/props/props', true)
  self.type = type
  self.id = id
  --- animation states
  self.animation:addState('chair', 1, 1)
  self.animation:addState('fellchair', 2, 2)
  self.animation:addState('box', 3, 3)
  self.animation:addState('trash', 4, 4)
  self.animation:addState('toxic', 5, 5)
  self.animation:addState('table', 6, 6)
  self.animation:addState('fellTable', 7, 7)
  self.animation:addState('blood', 8,8)
  self.animation:addState('blood2', 9, 9)
  self.animation:addState('deadrat', 10, 10)
  self.animation:addState('xtree-1', 11, 11)
  self.animation:addState('xtree-2', 12, 12)
  self.animation:addState('xtree-3', 13, 13)
  self.animation:addState('xtree-4', 14, 14)
  self.animation:addState('microwave', 15, 15)
  self.animation:addState('gifts', 16, 16)
  self.animation:addState('gift', 17, 17)
  self.animation:addState('smallTable', 18, 18)
  self.animation:addState('fridge1', 19, 19)
  self.animation:addState('fridge2', 20, 20)
  self.animation:addState('kitchenStorage', 21, 21)
  self.animation:addState('pot', 22, 22)
  self.animation:addState('knifeKettle', 23, 23)
  self.animation:addState('holeLeft', 24, 24)
  self.animation:addState('holeRight', 25, 25)
  self.animation:addState('holeTop', 26, 26)
  self.animation:addState('holeDown', 27, 27)
  self.animation:addState('debris', 28, 28)
  self.animation:setState(type)
  -- is edible
  self.isEdible = true
  -- position and z-index
  self:setSize(32, 32)
  
  if nocollide == nil then
    self:setCollideRect(0, 0, 32, 32)
    self.propcollider = PropCollider( x, y, 32, 20)
  end
  if type == 'holeDown' or type == 'holeTop' then
    self.isEdible = false
    self:clearCollideRect()
  end
  if type == 'holeLeft' then
    self.isEdible = false
    self:setCollideRect(10, 8, 22, 24)
  end
  if  type == 'holeRight' then
    self.isEdible = false
    self:setCollideRect(0, 8, 22, 24)
  end
  
  self:setZIndex(zIndex)
  self:setGroups(3)
  self:add(x,y)
  -- check type and add a flag to identify during collisions
end

function PropItem:destroyProp(id)
  findAndDestroyPropById(id) 
  self:clearCollideRect()
  self.animation:setState('debris')
end
