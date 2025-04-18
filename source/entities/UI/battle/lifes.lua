
Lifes = {}
class("Lifes").extends(NobleSprite)

function Lifes:init(x, y, amount)
	Lifes.super.init(self,'assets/images/ui/battle/heartDance', true)
	
	self.animation:addState("full", 1, 1)
	self.animation.full.frameDuration = 6
	self.animation:addState("half", 2, 2)
	self.animation.half.frameDuration = 6
	self.animation:addState("last", 3, 3)
	self.animation.last.frameDuration = 6
	self.animation:addState("empty", 4, 4)
	self.animation.empty.frameDuration = 6
	self.animation:setState("full")
	
	self:setSize(72, 24)
	self:add(x, y)
end

function Lifes:checkHealth(life)
	if life == 3 then
		self.animation:setState('full')
	end
	if life == 2 then
		self.animation:setState('half')
	end
	if life == 1 then
		self.animation:setState('last')
	end
	if life == 0 then
		self.animation:setState('empty')
	end
end