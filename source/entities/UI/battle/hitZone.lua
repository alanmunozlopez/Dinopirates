HitZone ={}
class('HitZone').extends(NobleSprite)

function HitZone:init(bpm)
	HitZone.super.init(self, 'assets/images/ui/battle/hitzone',true)
	
	if bpm == nil then
		bpm = 6
	end
	local frameduration = bpm
	-- Mark: animation states
	self.animation:addState('checker',1,8)
	self.animation.checker.frameDuration = frameduration
	
	self.animation:setState('checker')
	self.range = 100
	self:setSize(10, 40)
	self:setCollideRect(0, 0, 10, 40)
	self:add(64, 30)
	
end
function HitZone:hit(pressedButton)
	
	-- local collisions = self:overlappingSprites()
	-- if table.getsize(collisions) > 0 then
	-- 	if pressedButton == nil then
	-- 		buttonText = "miss"
	-- 	elseif collisions[1].buttonKey == pressedButton then
	-- 		buttonText = "right"
	-- 	else
	-- 		buttonText = "wrong"
	-- 	end
	-- end

	

end

function HitZone:update()
	
end