ButtonPress ={}
class('ButtonPress').extends(NobleSprite)

function ButtonPress:init(buttonKey, bpm)
	ButtonPress.super.init(self, 'assets/images/ui/battle/button',true)
	
	-- Mark: animation states
	self.animation:addState('aButton',1,1)
	self.animation.aButton.frameDuration = 6
	
	self.animation:addState('bButton',2,2)
	self.animation.bButton.frameDuration = 6
	
	self.animation:addState('leftButton',3,3)
	self.animation.leftButton.frameDuration = 6
	
	self.animation:addState('upButton',4,4)
	self.animation.upButton.frameDuration = 6
	
	self.animation:addState('rightButton',5,5)
	self.animation.rightButton.frameDuration = 6
	
	self.animation:addState('downButton',6,6)
	self.animation.downButton.frameDuration = 6
	
	
	self.buttonKey = buttonKey
	self.bpm = bpm
	self.animation:setState(buttonKey)
	self.range = 100
	self:setSize(32, 32)
	self:setCollideRect(0, 0, 32, 32)
	self:add(250, 30)
	
end
function ButtonPress:hit()
	
end
function ButtonPress:update()
	self:moveBy(-1*bpm/2, 0)
	if self.x <= 64 then
		self:moveTo(330, self.y)
	end
end