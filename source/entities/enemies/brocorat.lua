import 'enemy'

Brocorat = {}
class('Brocorat').extends('Enemy')
-- TODO check animation
function Brocorat:init(x, y, moveSpeed, Zindex, player, ID)
	Brocorat.super.init(self, 'assets/images/enemies/brocorat', true)
	
	-- Mark: animation states
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
	
	self.hitCounter = 0
	self.stepCount = moveSpeed * 20 -- if speed is below 0.5 the enemy doesnt move
	self.player = player
	self.Zindex = Zindex
	if moveSpeed == nil then
		self.moveSpeed = 0.6
	end
	self.moveSpeed = moveSpeed
	self.initialSpeed = moveSpeed
	
	
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
	if self.stepCount > 10 then -- stun idea
		self:blindSearch(player)
	end
end

function Brocorat:empty()
	self.animation:setState('empty')
end

function Brocorat:update()
	if PlayerData.isActive == true then
		self:search(self.player)
	end
	-- self:sonar()
end