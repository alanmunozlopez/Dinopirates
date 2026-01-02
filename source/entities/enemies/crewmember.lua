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
	self.movementFrames = 0 -- Initialize movement frames
	
	-- Bounce/redirect properties
	self.bounceDirection = nil -- Current bounce direction: 'left', 'right', 'up', 'down'
	self.bounceFrames = 0 -- How many frames to maintain bounce direction
	self.lastCollisionAxis = nil -- Track which axis had collision: 'x', 'y', or 'both'
	
	print("🧩 CrewMember spawned with IID:", self.iid, "CrewID:", crewId)
end

function CrewMember:addMovementTokens(amount)
	local FRAMES_PER_TOKEN = 30
	self.movementFrames = self.movementFrames + (amount * FRAMES_PER_TOKEN)
end

-- Add raw frames directly (for player movement sync)
function CrewMember:addMovementFrames(frames)
	-- Cap at reasonable max to prevent accumulation (3 seconds = 90 frames)
	self.movementFrames = math.min(self.movementFrames + frames, 90)
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
	
	local actualX, actualY, collisions, length = self:moveWithCollisions(movementX, movementY)
	self.hat:moveTo(actualX, actualY - self.hatDelta)
	
	-- Check for collisions with walls or props to trigger bounce
	if length > 0 then
		for index, collision in pairs(collisions) do
			local collideObject = collision['other']
			local normal = collision['normal']
			
			-- Check if collision is with wall or prop (not minifier)
			local isBlockingCollision = collideObject:isa(Wall) or 
				(collideObject:isa(PropItem) and collideObject.type ~= 'minifier')
			
			if isBlockingCollision then
				-- Determine which axis was blocked based on collision normal
				local blockedX = normal.x ~= 0
				local blockedY = normal.y ~= 0
				
				-- Calculate escape direction from player
				local playerToLeft = self.player.x < self.x
				local playerBelow = self.player.y > self.y
				
				if blockedX and blockedY then
					-- Corner collision - pick perpendicular direction away from player
					-- Alternate between up/down based on player position
					if playerBelow then
						self.bounceDirection = 'up'
					else
						self.bounceDirection = 'down'
					end
				elseif blockedX then
					-- Horizontal collision (hit left/right wall)
					-- Move up or down, away from player
					if playerBelow then
						self.bounceDirection = 'up'
					else
						self.bounceDirection = 'down'
					end
				elseif blockedY then
					-- Vertical collision (hit top/bottom wall)
					-- Move left or right, away from player
					if playerToLeft then
						self.bounceDirection = 'right'
					else
						self.bounceDirection = 'left'
					end
				end
				
				-- Set bounce frames (how long to maintain this direction)
				self.bounceFrames = 15 -- About half a second at 30fps
				break -- Only process first blocking collision
			end
		end
	end
	
end
function CrewMember:collisionResponse(other)
	-- Allow overlap with minifier props and triggers
	if other:isa(PropItem) and other.type == 'minifier' then
		return 'overlap'
	elseif other:isa(Trigger) then
		return 'overlap'
	else
		return 'freeze'
	end
end

function CrewMember:taken()
	local roomData = levelsLDTK[self.room]
	if not roomData or not roomData.entities or not roomData.entities.CrewMember then
		printDebug("⚠️ No CrewMember data found for room:", self.room)
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
	local movementX, movementY
	
	-- Check if we're in bounce mode
	if self.bounceFrames > 0 then
		self.bounceFrames = self.bounceFrames - 1
		
		-- Move in the bounce direction
		if self.bounceDirection == 'left' then
			movementX = self.x - self.moveSpeed
			movementY = self.y
		elseif self.bounceDirection == 'right' then
			movementX = self.x + self.moveSpeed
			movementY = self.y
		elseif self.bounceDirection == 'up' then
			movementX = self.x
			movementY = self.y - self.moveSpeed
		elseif self.bounceDirection == 'down' then
			movementX = self.x
			movementY = self.y + self.moveSpeed
		else
			-- Fallback to normal escape
			movementX = self.player.x <= self.x and self.x + self.moveSpeed or self.x - self.moveSpeed
			movementY = self.player.y <= self.y and self.y + self.moveSpeed or self.y - self.moveSpeed
		end
		
		-- Clear bounce direction when frames run out
		if self.bounceFrames <= 0 then
			self.bounceDirection = nil
		end
	else
		-- Normal escape movement (away from player)
		movementX = self.player.x <= self.x and self.x + self.moveSpeed or self.x - self.moveSpeed
		movementY = self.player.y <= self.y and self.y + self.moveSpeed or self.y - self.moveSpeed
	end

	self.animation:setState('walk')
	self:moveCollision(movementX, movementY, self.player)
	
end

function CrewMember:update()
	-- Performance: Only update AI every 3 frames
	-- Performance: Only update AI every 3 frames
	self.updateFrameCounter = (self.updateFrameCounter + 1) % 3
	
	if self.movementFrames > 0 then
		self.movementFrames = self.movementFrames - 1
		
		-- When tokens are available, move regardless of isActive
		if self.updateFrameCounter == 0 then
			self:escape(self.player)
		end
	else
		-- Ensure idle animation
		if self.animation.currentState ~= 'idle' then
			self.animation:setState('idle')
		end
	end
	--self:sonar()
end