ButtonPress ={}
class('ButtonPress').extends(NobleSprite)

local BUTTON_KEYS = { "aButton", "bButton", "leftButton", "upButton", "rightButton", "downButton", "Break" }

function ButtonPress:init(beats)
	ButtonPress.super.init(self, 'assets/images/ui/battle/button', true)

	for i, name in ipairs(BUTTON_KEYS) do
		self.animation:addState(name, i, i)
		self.animation[name].frameDuration = 6
	end
	self.animation:addState("empty", 8, 8)
	self.animation.empty.frameDuration = 6
	
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
	self.buttonKey = "empty"
	self.animation:setState(self.buttonKey)
	self:tryMoveToFreePosition()
	self:changeButtonSprite()
end

function ButtonPress:changeButtonSprite()
	
	local newKey
	repeat
		newKey = ButtonPress.getRandomButtonKey()
	until newKey ~= self.buttonKey
	self.buttonKey = newKey
	self.animation:setState(self.buttonKey)
end

function ButtonPress:tryMoveToFreePosition()
	local goalX = 330
	local goalY = self.y

	local _, _, collisions, count = self:checkCollisions(goalX, goalY)

	local collisionWithButtonPress = false
	for i = 1, count do
		if collisions[i].other:isa(ButtonPress) then
			collisionWithButtonPress = true
			break
		end
	end

	if not collisionWithButtonPress then
		self:moveTo(goalX, goalY)
	else
		local found = false
		for dx = -10, 10, 5 do
			for dy = -10, 10, 5 do
				local testX = goalX + dx
				local testY = goalY + dy
				local _, _, testCollisions, testCount = self:checkCollisions(testX, testY)

				local collisionWithButtonPress = false
				for i = 1, testCount do
					if testCollisions[i].other:isa(ButtonPress) then
						collisionWithButtonPress = true
						break
					end
				end

				if not collisionWithButtonPress then
					self:moveTo(testX, testY)
					found = true
					break
				end
			end
			if found then break end
		end

		if not found then
			self:moveTo(360, self.y)
		end
	end
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

function ButtonPress:update()
	
	if self.active == true then
		self:moveBy(-0.5*self.bpm/3, 0)
		-- self:moveBy(-1, 0)
		if self.x <= 60 then
			self:moveTo(330, self.y)
			self:changeButtonSprite()
		end
	end
    
	
end