import 'enemy'

Frogcolli = {}
class('Frogcolli').extends('Enemy')

function Frogcolli:init(x, y, moveSpeed, Zindex, player)
	Brocorat.super.init(self, 'assets/images/enemies/frogcolli', true)
	
	-- Mark: animation states
	self.animation:addState('idle', 5, 6)
	self.animation.idle.frameDuration = 48
	self.animation:addState('walk', 1, 10, 'idle')
	self.animation.walk.frameDuration = 6
	self.animation:addState('empty', 11, 11)
	self.animation.empty.frameDuration = 6
	
	self:setSize(40, 40)
	self:moveTo(x, y)
	self:setCollideRect(4, 8, 32, 32)
	
	self.moveSpeed = moveSpeed
	self.initialSpeed = moveSpeed
	self.viewRange = 10
	self.player = player
	self:setGroups(CollideGroups.enemy)
	self:setCollidesWithGroups({
		CollideGroups.player,
		CollideGroups.props,
		CollideGroups.wall,
		CollideGroups.enemy
	})
	self:setZIndex(Zindex)
	self:add(x, y)
end

function Frogcolli:search(player)
	self:linealSearch(player)
end

function Frogcolli:update()
	if PlayerData.isActive == true then
		self:search(self.player)
	end
	if PlayerData.sonarActive == true then
		self:sonar()
	end
end