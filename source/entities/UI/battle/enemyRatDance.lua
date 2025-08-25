EnemyRatDance = {}
class('EnemyRatDance').extends(NobleSprite)

function EnemyRatDance:init(bpm)
	EnemyRatDance.super.init(self, 'assets/images/ui/battle/enemyDance',true)
	self.lvl = lvl
	if bpm == nil or bpm == 0 then
		bpm = 6
	end
	local frameduration = bpm/2
	-- Mark: animation states
	self.animation:addState('idle', 1, 3)
	self.animation.idle.frameDuration = frameduration
	self.animation:addState('upAttack', 6, 9,'idle')
	self.animation.upAttack.frameDuration = frameduration
	self.animation:addState('leftAttack', 10, 13,'idle')
	self.animation.leftAttack.frameDuration = frameduration
	
	self.animation:setState('idle')
	
	
	self:setZIndex(2)
	self:setSize(214, 214)
	self:setCenter(0,0)
	self:add(158, 26)
	
end
function EnemyRatDance:changeAnimation(input)
	local animationMap = {
		downButton = "upAttack",
		-- downButton = "crouch",
		leftButton = "leftAttack",
		-- rightButton = "right"
	}
	
	local newState = animationMap[input]
	if newState then
		self.animation:setState(newState)
	end
end
function EnemyRatDance:update()
	
end