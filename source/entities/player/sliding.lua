-- Sliding module for player when on slime tiles (IDs 89-97)
-- Moves the player in a straight line until they hit a wall or leave the slime

-- Check if the player is standing on a slime tile and start sliding
function Player:checkSlimeTile()
    if self.isSliding or self.isDashing or self.isPlunging then
        return
    end

    local tileID = GetTileUnderPlayer(self.x, self.y)
    if not tileID then return end

    if SLIME_TILE_IDS[tileID] then
        -- Player has plunger = immune to slime
        if PlayerData.items.hasPlunger == true then
            return
        end
        -- Start sliding in current direction
        self:startSliding(self.direction)
    end
end

function Player:startSliding(direction)
    if self.isSliding or self.isDashing then
        return
    end

    -- We need a direction to slide in. If direction is nil, use current facing direction
    local slideDir = direction or self.direction or PlayerData.direction
    if slideDir == "idle" or slideDir == nil then
        return
    end

    printDebug("💧 Slime slide started! Direction:", slideDir)
    self.isSliding = true
    self.slidingDirection = slideDir
    self.slidingSpeed = 4 -- Slower than dash (8), faster than normal (1-2)
end

function Player:updateSliding()
    if not self.isSliding then
        return
    end

    -- Calculate movement for this frame
    local moveX = 0
    local moveY = 0

    if self.slidingDirection == "left" then
        moveX = -self.slidingSpeed
        if PlayerData.isTiny then self.animation:setState('tinyLeft') else self.animation:setState('left') end
    elseif self.slidingDirection == "right" then
        moveX = self.slidingSpeed
        if PlayerData.isTiny then self.animation:setState('tinyRight') else self.animation:setState('right') end
    elseif self.slidingDirection == "up" then
        moveY = -self.slidingSpeed
        if PlayerData.isTiny then self.animation:setState('tinyUp') else self.animation:setState('up') end
    elseif self.slidingDirection == "down" then
        moveY = self.slidingSpeed
        if PlayerData.isTiny then self.animation:setState('tinyDown') else self.animation:setState('down') end
    end

    local targetX = self.x + moveX
    local targetY = self.y + moveY

    local actualX, actualY, collisions, length = self:moveWithCollisions(targetX, targetY)

    -- Update UI position
    self.uiHud:moveTo(actualX + self.playerUIX, actualY - self.playerUIY)

    -- Check if we hit a solid object
    local hitSolid = false
    if length > 0 then
        for i = 1, length do
            local other = collisions[i].other
            if other:isa(PropItem) then
                if not other.isHole and other.type ~= 'minifier' then
                    hitSolid = true
                end
            elseif not other:isa(Items) and not other:isa(Trigger) and not other:isa(Enemy) and not other:isa(CrewMember) then
                hitSolid = true
            end
        end
    end

    -- Check if we are still on a slime tile
    local tileID = GetTileUnderPlayer(actualX, actualY)
    local stillOnSlime = tileID and SLIME_TILE_IDS[tileID]

    if hitSolid or not stillOnSlime then
        printDebug("💧 Slime slide ended. HitSolid:", hitSolid, "StillOnSlime:", tostring(stillOnSlime))
        self:endSliding()
    end
end

function Player:endSliding()
    self.isSliding = false
    self.slidingDirection = nil
    
    -- Restore idle animation
    self:idle()
    printDebug("✅ Slime slide completed!")
end
