ButtonPress ={}
class('ButtonPress').extends(NobleSprite)

local BUTTON_KEYS = { "aButton", "bButton", "leftButton", "upButton", "rightButton", "downButton", "Break" }

function ButtonPress:init(beats)
	ButtonPress.super.init(self, 'assets/images/ui/battle/button', true)

	for i, name in ipairs(BUTTON_KEYS) do
		self.animation:addState(name, i, i)
		self.animation[name].frameDuration = 6
	end

	self.bpm = beats
	self.active = false
	self.range = 100
	self:setSize(32, 32)
	self:setCollideRect(0, 0, 32, 32)
	self:add(250, 30)

	self.buttonKey = ButtonPress.getRandomButtonKey()
	self.animation:setState(self.buttonKey)
end

function ButtonPress:hit()
	local newKey
	repeat
		newKey = ButtonPress.getRandomButtonKey()
	until newKey ~= self.buttonKey
	self.buttonKey = newKey
	self.animation:setState(self.buttonKey)
	self:moveTo(330, self.y)
end

function ButtonPress.getRandomButtonKey()
	local randomIndex = math.random(1, #BUTTON_KEYS)
	return BUTTON_KEYS[randomIndex]
end

function ButtonPress:movementDelay(delay)
	local function movementDelayed()
		self.active = true
	end
	playdate.timer.performAfterDelay(delay, movementDelayed)
end
function ButtonPress:collisionResponse(other)
	if other:isa(ButtonPress)then
		return 'freeze'
	else
		return 'overlap'
	end
end
function ButtonPress:update()
	if self.active == true then
		self:moveBy(-0.5*self.bpm/3, 0)
		-- self:moveBy(-1, 0)
		if self.x <= 60 then
			self:moveTo(330, self.y)
		end
	end
end