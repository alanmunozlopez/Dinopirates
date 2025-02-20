PlayerDance ={}
class('PlayerDance').extends(NobleSprite)

function PlayerDance:init(bpm)
	PlayerDance.super.init(self, 'assets/images/ui/battle/playerDance',true)
	
	if bpm == nil then
		bpm = 6
	end
	
	-- Mark: animation states
	self.animation:addState('idle',1,2)
	self.animation.idle.frameDuration = bpm/2
	
	self.animation:setState('idle')
	self:setSize(246, 214)
	--self:setCollideRect(0, 0, 10, 40)
	self:setCenter(0,0)
	self:add(0, 26)
	
end

function PlayerDance:update()
	
end