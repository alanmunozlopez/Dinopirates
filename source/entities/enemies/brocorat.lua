import 'enemy'

Brocorat = {}
class('Brocorat').extends('Enemy')
-- TODO check animation
function Brocorat:init(x, y, moveSpeed, Zindex, player, ID)
	Brocorat.super.init(self, 'assets/images/enemies/brocorat', true)
	
	-- MARK: Animation states
	self.animation:addState('idle', 4, 4)
	self.animation.idle.frameDuration = 6
	self.animation:addState('walk', 1, 8, 'idle')
	self.animation.walk.frameDuration = 6
	self.animation:addState('empty', 15, 15)
	self.animation.empty.frameDuration = 6
	self.animation:addState('shine', 9, 14)
	self.animation.shine.frameDuration = 6
	self.animation:addState('eaten', 16, 16)
	self.animation.eaten.frameDuration = 6
	
	self.type = "Enemy"
	self.id = ID
	
	self.powerLevel = PlayerData.EnemiesData.powerLevel + PlayerData.sanityCounter
	self.stunProc = moveSpeed * 20 -- if speed is below 0.5 the enemy doesnt move
	self.player = player
	self.Zindex = Zindex
	if moveSpeed == nil then
		self.moveSpeed = 0.6
	end
	self.moveSpeed = moveSpeed
	self.initialSpeed = moveSpeed
	self.sightRadius = PlayerData.EnemiesData.sightRadius + self.powerLevel * 3 -- this should be calculated according to the level or power of the enemy.
	
	-- Performance: Frame counter for throttling updates
	self.updateFrameCounter = math.random(0, 2) -- Random offset to stagger enemy updates
	
	self:setSize(32, 32)
	self:moveTo(x, y)
	self:setCollideRect(0, 0, 32, 32)
	self:setGroups(CollideGroups.enemy)
	self:setCollidesWithGroups({
		CollideGroups.player,
		CollideGroups.props,
		CollideGroups.wall,
		CollideGroups.enemy
	})
	self:setZIndex(self.Zindex)
	self:add(x, y)
end

function Brocorat:search(player)
	if self.stunProc > 1 then -- stun idea
		if (player.x >= self.x - self.sightRadius) and (player.x <= self.x + self.sightRadius) and 
		   (player.y >= self.y - self.sightRadius) and (player.y <= self.y + self.sightRadius) then
			self:blindSearch(player)
		end
	end
end

function Brocorat:empty()
	self.animation:setState('empty')
end

function Brocorat:update()
	-- Performance: Only update AI every 3 frames
	self.updateFrameCounter = (self.updateFrameCounter + 1) % 3
	
	if self.updateFrameCounter == 0 and PlayerData.isActive == true then
		self:search(self.player)
	end
	-- self:sonar()
end