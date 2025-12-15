-- Light Burst ability for player
-- Activates when lamp is equipped and affects entities within light cone

function Player:lightBurst()
    -- Validate that lamp is equipped (activeItem == 1)
    if PlayerData.activeItem ~= 1 then
        print("Light burst requires lamp to be equipped!")
        return
    end
    
    -- Check if light burst is on cooldown
    if self.lightBurstCooldown and playdate.getCurrentTimeMilliseconds() < self.lightBurstCooldown then
        print("Light burst on cooldown!")
        return
    end
    
    -- Check if player is in valid state
    if not self.isAlive or PlayerData.isGaming ~= true then
        return
    end
    
    -- Check if lamp has battery
    if not PlayerData.items.hasLamp then
        print("No lamp available!")
        return
    end
    
    print("💡 Light burst activated!")
    
    -- Get the current direction
    local direction = PlayerData.direction
    
    -- Create light cone polygon
    local lightPolygon = self:createLightCone(direction)
    
    if not lightPolygon then
        print("Cannot create light cone in idle state")
        return
    end
    
    -- Get entities within light cone
    local affectedEntities = self:getEntitiesInLightCone(lightPolygon)
    
    -- Apply effects to affected entities
    for _, entity in ipairs(affectedEntities) do
        self:affectEntity(entity)
    end
    
    if #affectedEntities == 0 then
        print("No entities affected by light burst")
    end
    
    -- Set cooldown (1000ms = 1 second)
    self.lightBurstCooldown = playdate.getCurrentTimeMilliseconds() + 1000
    
    print("✅ Light burst completed!")
end

function Player:createLightCone(direction)
    -- Don't create cone if idle
    if direction == 'idle' or direction == nil then
        return nil
    end
    
    -- Use same parameters as FXshadow.lua
    local ix = PlayerData.x
    local iy = PlayerData.y
    local d = 120     -- Distance the light reaches forward
    local h = 8       -- Height scaling for the cone shape
    
    -- Adjust distance depending on direction
    if direction == 'left' or direction == 'down' then
        d = d * -1
    end
    
    -- Create polygon based on direction
    local lightCone
    if direction == 'left' or direction == 'right' then
        lightCone = playdate.geometry.polygon.new(
            ix, iy,
            ix + d, iy - 4*h,
            ix + 1.1*d, iy - 3.5*h,
            ix + 1.2*d, iy - 2*h,
            ix + 1.25*d, iy,
            ix + 1.2*d, iy + 2*h,
            ix + 1.1*d, iy + 3.5*h,
            ix + d, iy + 4*h,
            ix, iy
        )
    elseif direction == 'up' or direction == 'down' then
        lightCone = playdate.geometry.polygon.new(
            ix, iy,
            ix - 4*h, iy - d,
            ix - 3.5*h, iy - 1.1*d,
            ix - 2*h, iy - 1.2*d,
            ix, iy - 1.25*d,
            ix + 2*h, iy - 1.2*d,
            ix + 3.5*h, iy - 1.1*d,
            ix + 4*h, iy - d,
            ix, iy
        )
    end
    
    if lightCone then
        lightCone:close()
    end
    
    return lightCone
end

function Player:getEntitiesInLightCone(lightPolygon)
    local affectedEntities = {}
    local allSprites = Graphics.sprite.getAllSprites()
    
    for _, sprite in ipairs(allSprites) do
        -- Check if sprite is an enemy or crew member
        if sprite:isa(Brocorat) or sprite:isa(Bosscolli) or sprite:isa(CrewMember) then
            -- Check if entity is within the light cone
            if lightPolygon:containsPoint(sprite.x, sprite.y) then
                table.insert(affectedEntities, sprite)
            end
        end
    end
    
    return affectedEntities
end

function Player:affectEntity(entity)
    if entity:isa(Brocorat) or entity:isa(Bosscolli) then
        -- For enemies, print that they were blinded with their ID
        local enemyId = entity.id or "unknown"
        print("👁️ Enemy blinded! ID: " .. tostring(enemyId))
    elseif entity:isa(CrewMember) then
        -- For crew members, print that they were blinded with their ID
        local crewId = entity.crewId or entity.iid or "unknown"
        print("👁️ Crew member blinded! ID: " .. tostring(crewId))
    end
end
