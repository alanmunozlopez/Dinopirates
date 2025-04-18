EnemyDance = {}
class('EnemyDance').extends(NobleSprite)

function EnemyDance:init(bpm)
	EnemyDance.super.init(self, 'assets/images/ui/battle/enemyDance',true)
	
	if bpm == nil or bpm == 0 then
		bpm = 6
	end
	frameduration = bpm/2
	-- Mark: animation states
	self.animation:addState('Brocoratidle', 1, 1)
	self.animation.Brocoratidle.frameDuration = frameduration
	
	self.animation:setState('Brocoratidle')
	self:setZIndex(2)
	self:setSize(214, 214)
	self:setCenter(0,0)
	self:add(158, 26)
	
end
function EnemyDance:changeAnimation(input)
	
end
function EnemyDance:update()
	
end