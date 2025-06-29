
itemMenu = {}
class("itemMenu").extends(NobleSprite)

function itemMenu:init(__item,__zindex)
	itemMenu.super.init(self,'assets/images/ui/menu/menuitems', true)
	self.item = __item
	self.index = nil
	
	for i, name in ipairs(PlayerData.items) do
		if name == __item then
			self.index = i
			break
		end
	end
	
	self.animation:addState('first',1,1)
	self.animation:addState('firstSelected',2,2)
	self.animation:addState('second',3,3)
	self.animation:addState('secondSelected',4,4)
	self.animation:setState(__item)
	self:setZIndex(__zindex)
	self:setSize(32, 32)
	self:setCenter(0,0)
	
end
function itemMenu:update()
	if self.item == "first" then
		if PlayerData.activeItem == 1 then
			self.animation:setState('firstSelected')
		else
			self.animation:setState('first')
		end
	elseif self.item == "second" then
		if PlayerData.activeItem == 2 then
			self.animation:setState('secondSelected')
		else
			self.animation:setState('second')
		end
	end
end
function itemMenu:show(__x,__y)
	self:add(__x,__y)
end