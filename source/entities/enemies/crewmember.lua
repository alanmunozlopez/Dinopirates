import 'entities/props/hats'

CrewMember = {}
class('CrewMember').extends('NobleSprite')
-- TODO check animation
function CrewMember:init(x, y, moveSpeed, Zindex, player, position, room, crewId)
	CrewMember.super.init(self, 'assets/images/enemies/crewmember', true)
	
	-- error handling
	if moveSpeed == nil then
		moveSpeed = 1
	end
	-- Mark: animation states
	self.animation:addState('idle', 1, 4)
	self.animation.idle.frameDuration = 6
	self.animation:addState('walk', 1, 4)
	self.animation.walk.frameDuration = 6
	self.animation:addState('empty', 1, 4)
	self.animation.empty.frameDuration = 6
		
	self:setSize(48, 48)
	self:moveTo(x, y)
	self:setCollideRect(12, 24, 24, 24)
	
	self.room = room
	self.position = position
	self.moveSpeed = moveSpeed
	self.initialSpeed = moveSpeed
	self.player = player
	self.Zindex = Zindex
	self:setGroups(CollideGroups.enemy)
	self:setCollidesWithGroups({
		CollideGroups.player,
		CollideGroups.props,
		CollideGroups.wall,
		CollideGroups.enemy
	})
	self:setZIndex(self.Zindex)
	self:add(x, y)
	self.hat = Hats(x,y-15, 'chef', 2)
end

function CrewMember:search(player)
	self:escape(player)
end

function CrewMember:moveCollision(movementX, movementY, player) 
	if PlayerData.battery < 10 and PlayerData.isInDarkness == true then
		self.moveSpeed = 0
	elseif PlayerData.battery > 60 and PlayerData.isInDarkness == true then
		self.moveSpeed = self.initialSpeed
	end
	self.hat:moveTo(movementX, movementY-15)
	
	local actualX, actualY, collisions, lenght = self:moveWithCollisions(movementX, movementY)
	if lenght > 0 then
		for index, collision in pairs(collisions) do
			local collideObject = collision['other']
			if collideObject:isa(Player) then -- not being used
				print('player collision')
				if self.player.isAlive then
					self:taken(PlayerData.actualRoom)
					--self:remove()
					
				end
			end
		end
	end
	
end

function CrewMember:taken()
	levels[self.room].floor.items[self.position].taken = true
	self:remove()
	self.hat:remove()
end

function CrewMember:escape(player)
	self.player = player
	local movementX = self.player.x <= self.x and self.x + self.moveSpeed or self.x - self.moveSpeed
	local movementY = self.player.y <= self.y and self.y + self.moveSpeed or self.y - self.moveSpeed

	self.animation:setState('walk')
	self:moveCollision(movementX, movementY, self.player)
	
end

function CrewMember:update()
	if PlayerData.isActive == true then
		self:escape(self.player)
	end
	--self:sonar()
end