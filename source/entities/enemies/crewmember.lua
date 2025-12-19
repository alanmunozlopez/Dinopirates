import 'entities/props/hats'

CrewMember = {}
class('CrewMember').extends('NobleSprite')
-- TODO check animation
function CrewMember:init(x, y, moveSpeed, Zindex, player, iid, room, crewId)
	CrewMember.super.init(self, 'assets/images/enemies/crewmember', true)
	
	-- error handling
	if moveSpeed == nil then
		moveSpeed = 1
	end
	-- MARK: Animation states
	self.animation:addState('idle', 1, 4)
	self.animation.idle.frameDuration = 8
	self.animation:addState('walk', 1, 4)
	self.animation.walk.frameDuration = 6
	self.animation:addState('empty', 1, 4)
	self.animation.empty.frameDuration = 6
		
	self:setSize(48, 48)
	self:moveTo(x, y)
	self:setCollideRect(12, 24, 24, 24)
	self.hatDelta = 15
	self.room = room
	self.position = position
	self.moveSpeed = moveSpeed
	self.initialSpeed = moveSpeed
	self.player = player
	self.Zindex = Zindex
	self.crewId = crewId  -- Store the crew member ID
	
	-- Performance: Frame counter for throttling updates
	self.updateFrameCounter = math.random(0, 2) -- Random offset to stagger enemy updates
	
	self:setGroups(CollideGroups.enemy)
	self:setCollidesWithGroups({
		CollideGroups.player,
		CollideGroups.props,
		CollideGroups.wall,
		CollideGroups.enemy
	})
	self.iid = iid
	self:setZIndex(self.Zindex)
	self:add(x, y)
	self.hat = Hats(x,y - self.hatDelta, crewId, 2)
	print("🧩 CrewMember spawned with IID:", self.iid, "CrewID:", crewId)
end

function CrewMember:search(player)
	self:escape(player)
end

function CrewMember:collisionResponse(other)
	if other:isa(Player) then -- only works if the crewmember collide with the player, not the other way around
		print('PLAAAYER')
	end
end
function CrewMember:moveCollision(movementX, movementY, player) 
	if PlayerData.battery < 10 and PlayerData.isInDarkness == true then
		self.moveSpeed = 0
	elseif PlayerData.battery > 60 and PlayerData.isInDarkness == true then
		self.moveSpeed = self.initialSpeed
	end
	self.hat:moveTo(movementX, movementY - self.hatDelta)
	
	local actualX, actualY, collisions, lenght = self:moveWithCollisions(movementX, movementY)
	-- if lenght > 0 then
	-- 	for index, collision in pairs(collisions) do
	-- 		local collideObject = collision['other']
	-- 		if collideObject:isa(Player) then -- not being used
	-- 			print('enemy collision')
	-- 			if self.player.isAlive then
	-- 				self:taken(PlayerData.actualRoom)
	-- 			end
	-- 		end
	-- 	end
	-- end
	
end

function CrewMember:taken()
	local roomData = levelsLDTK[self.room]
	if not roomData or not roomData.entities or not roomData.entities.CrewMember then
		print("⚠️ No CrewMember data found for room:", self.room)
		return
	end

	for _, crewData in ipairs(roomData.entities.CrewMember) do
		local cf = crewData.customFields or {}
		local currentIID = crewData.iid
	
		-- Search for the corresponding CrewMember by its IID (unique LDtk identifier)
		if currentIID == self.iid then
			cf.isTaken = true
			PlayerData.CrewMemberData.amountTaken += 1
			-- Mark the specific crew member as captured in PlayerData using stored crewId
			if self.crewId then
				PlayerData.CrewMemberData.idNumbers[self.crewId] = true
				print("🟢 CrewMember marked as taken:", currentIID, "ID:", self.crewId)
			else
				print("🟢 CrewMember marked as taken:", currentIID, "(no crewId)")
			end
			break
		end
	end

	self:remove()
	if self.hat then
		self.hat:remove()
	end
end

function CrewMember:escape(player)
	self.player = player
	local movementX = self.player.x <= self.x and self.x + self.moveSpeed or self.x - self.moveSpeed
	local movementY = self.player.y <= self.y and self.y + self.moveSpeed or self.y - self.moveSpeed

	self.animation:setState('walk')
	self:moveCollision(movementX, movementY, self.player)
	
end

function CrewMember:update()
	-- Performance: Only update AI every 3 frames
	self.updateFrameCounter = (self.updateFrameCounter + 1) % 3
	
	if self.updateFrameCounter == 0 and PlayerData.isActive == true then
		self:escape(self.player)
	end
	--self:sonar()
end