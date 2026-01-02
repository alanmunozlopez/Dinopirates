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
	
	-- ============================================
	-- HIDING STATE CONFIGURATION (Fine-tuning variables)
	-- ============================================
	self.isHiding = false -- Whether the CrewMember is currently hiding
	self.hidingMovementTokensRequired = 3 -- Movement tokens needed to exit hiding (adjust for timing)
	self.hidingMovementTokensAccumulated = 0 -- Accumulated movement tokens while hiding
	self.hidingVisionRange = 80 -- Distance player must be to be considered "out of vision" (pixels)
	self.cornerDetectionThreshold = 0.5 -- Threshold for detecting blocked movement (pixels)
	
	-- Corner/Trapped detection: count bounces to detect being stuck
	self.recentBounceCount = 0 -- How many bounces happened recently  
	self.bounceCountDecayFrames = 0 -- Frames until bounce count decays
	self.bounceCountDecayRate = 30 -- Frames before bounce count resets (if no new bounces)
	self.bouncesRequiredToHide = 3 -- Number of bounces in quick succession to trigger hiding
	-- ============================================
	
	-- Store original collide rect for restoration
	self.originalCollideRect = {x = 12, y = 24, w = 24, h = 24}
	
	print("🧩 CrewMember spawned with IID:", self.iid, "CrewID:", crewId)
end

function CrewMember:addMovementTokens(amount)
	local FRAMES_PER_TOKEN = 30
	
	-- If hiding, accumulate tokens for exit check instead of normal movement
	if self.isHiding then
		self.hidingMovementTokensAccumulated = self.hidingMovementTokensAccumulated + amount
		self:checkExitHiding()
	else
		self.movementFrames = self.movementFrames + (amount * FRAMES_PER_TOKEN)
	end
end

-- Add raw frames directly (for player movement sync)
function CrewMember:addMovementFrames(frames)
	-- If hiding, convert frames to tokens and accumulate
	if self.isHiding then
		-- Convert frames to approximate tokens (30 frames = 1 token)
		local tokenEquivalent = frames / 30
		self.hidingMovementTokensAccumulated = self.hidingMovementTokensAccumulated + tokenEquivalent
		self:checkExitHiding()
	else
		-- Cap at reasonable max to prevent accumulation (3 seconds = 90 frames)
		self.movementFrames = math.min(self.movementFrames + frames, 90)
	end
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
	
	-- Detect if movement was blocked by comparing intended vs actual position
	local blockedX = math.abs(actualX - movementX) > self.cornerDetectionThreshold
	local blockedY = math.abs(actualY - movementY) > self.cornerDetectionThreshold
	
	-- Decay bounce count over time (if no bounces happen)
	if self.bounceCountDecayFrames > 0 then
		self.bounceCountDecayFrames = self.bounceCountDecayFrames - 1
	else
		-- Reset bounce count if enough time passed without bounces
		if self.recentBounceCount > 0 then
			self.recentBounceCount = 0
			-- print("🔄 Bounce count reset") -- Debug
		end
	end
	
	-- Only trigger bounce if we hit something and aren't already bouncing
	if (blockedX or blockedY) and self.bounceFrames <= 0 then
		-- Increment bounce count and reset decay timer
		self.recentBounceCount = self.recentBounceCount + 1
		self.bounceCountDecayFrames = self.bounceCountDecayRate
		
		print("💥 Bounce detected! Count:", self.recentBounceCount, "/ Required:", self.bouncesRequiredToHide) -- Debug
		
		-- Check if enough bounces to trigger hiding (trapped in corner)
		if self.recentBounceCount >= self.bouncesRequiredToHide then
			print("🙈 Too many bounces - entering hiding!") -- Debug
			self:enterHiding()
			return
		end
		
		-- Calculate escape direction from player
		local playerToLeft = self.player.x < self.x
		local playerBelow = self.player.y > self.y
		
		if blockedX and blockedY then
			-- Corner collision - try a random perpendicular direction
			if math.random() > 0.5 then
				self.bounceDirection = playerBelow and 'up' or 'down'
			else
				self.bounceDirection = playerToLeft and 'right' or 'left'
			end
		elseif blockedX then
			-- Horizontal collision (hit left/right wall)
			-- Move up or down, away from player
			self.bounceDirection = playerBelow and 'up' or 'down'
		elseif blockedY then
			-- Vertical collision (hit top/bottom wall)
			-- Move left or right, away from player
			self.bounceDirection = playerToLeft and 'right' or 'left'
		end
		
		-- Set bounce frames (how long to maintain this direction)
		self.bounceFrames = 20
	end
end
function CrewMember:collisionResponse(other)
	-- Allow overlap with minifier props and triggers
	if other:isa(PropItem) and other.type == 'minifier' then
		return 'overlap'
	elseif other:isa(Trigger) then
		return 'overlap'
	elseif other:isa(Wall) then
		-- Use slide for walls so we can move along them
		return 'slide'
	else
		return 'slide'
	end
end

-- ============================================
-- HIDING STATE FUNCTIONS
-- ============================================

-- Enter hiding state when cornered
function CrewMember:enterHiding()
	if self.isHiding then return end -- Already hiding
	
	self.isHiding = true
	self.hidingMovementTokensAccumulated = 0
	self.consecutiveCornerFrames = 0
	
	-- Change to hiding animation/sprite
	-- TODO: Replace 'empty' with actual hiding animation state when sprite is ready
	self.animation:setState('empty') -- Placeholder: use 'empty' state for now
	
	-- Hide the hat
	if self.hat then
		self.hat:setVisible(false)
	end
	
	-- Remove collider so player can't interact
	self:setCollideRect(0, 0, 0, 0)
	
	-- Remove from enemy collision group
	self:setGroups({})
	
	print("🙈 CrewMember entered hiding state - CrewID:", self.crewId)
end

-- Exit hiding state and return to normal
function CrewMember:exitHiding()
	if not self.isHiding then return end -- Not hiding
	
	self.isHiding = false
	self.hidingMovementTokensAccumulated = 0
	self.consecutiveCornerFrames = 0
	
	-- Restore normal animation
	self.animation:setState('idle')
	
	-- Show the hat again
	if self.hat then
		self.hat:setVisible(true)
	end
	
	-- Restore original collider
	self:setCollideRect(
		self.originalCollideRect.x,
		self.originalCollideRect.y,
		self.originalCollideRect.w,
		self.originalCollideRect.h
	)
	
	-- Restore enemy collision group
	self:setGroups(CollideGroups.enemy)
	
	-- Reset bounce state
	self.bounceDirection = nil
	self.bounceFrames = 0
	
	print("👀 CrewMember exited hiding state - CrewID:", self.crewId)
end

-- Check if conditions are met to exit hiding
function CrewMember:checkExitHiding()
	if not self.isHiding then return end
	
	-- Both conditions must be met:
	-- 1. Player must be out of vision range
	-- 2. Enough movement tokens must have accumulated
	if self:isPlayerOutOfVision() and 
	   self.hidingMovementTokensAccumulated >= self.hidingMovementTokensRequired then
		self:exitHiding()
	end
end

-- Check if player is outside the vision range
function CrewMember:isPlayerOutOfVision()
	if not self.player then return true end
	
	local dx = self.player.x - self.x
	local dy = self.player.y - self.y
	local distance = math.sqrt(dx * dx + dy * dy)
	
	return distance > self.hidingVisionRange
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
	self.updateFrameCounter = (self.updateFrameCounter + 1) % 3
	
	-- If hiding, don't move - just check exit conditions periodically
	if self.isHiding then
		-- Check exit conditions every few frames (when tokens are added via addMovementTokens/Frames)
		-- The checkExitHiding is called from those functions, so nothing needed here
		-- Ensure hiding animation stays active
		if self.animation.currentState ~= 'empty' then
			self.animation:setState('empty')
		end
		return
	end
	
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