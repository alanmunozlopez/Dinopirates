
Items = {}
class('Items').extends(NobleSprite)

import 'entities/FX/FXsonar'

function Items:init(x, y, type)
  Items.super.init(self,'assets/images/items/item-key', true)
  --- animation states
  self.animation:addState('keycard', 1, 20)
  self.animation.keycard.frameDuration = 8 
  self.animation:addState('lamp', 21, 25)
  self.animation.lamp.frameDuration = 8 
  self.animation:addState('radio', 26, 29)
  self.animation.radio.frameDuration = 8 
  self.animation:addState('notes', 30, 33)
  self.animation.notes.frameDuration = 8
  self.animation:addState('tools', 34, 37)
  self.animation.tools.frameDuration = 8
  self.animation:addState('bag', 38, 41)
  self.animation.bag.frameDuration = 8    
  self:setSize(48, 48)
  self:setCollideRect(0 ,0, 48, 48)
  self:setZIndex(ZIndex.items)
  self.type = type
  self.animation:setState(type)
  sonar = FXsonar(self.x,self.y)
  self:setGroups(3)
  
  self:add(x,y)
end

function Items:sonar(x,y)
 -- sonar:activate(self.x,self.y,'key')
end

function Items:removeAll()
  sonar:disableFX()
  self:remove()
end

function Items:update()
  -- if PlayerData.sonarActive == true  then
  --    self:sonar('key')
  --  end
end


