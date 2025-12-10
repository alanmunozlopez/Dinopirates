-- Ability system for player
-- Executes different abilities based on the active item selected in the ingame menu

function Player:useAbility()
    -- Check if player is in valid state
    if not self.isAlive or PlayerData.isGaming ~= true then
        return
    end
    
    -- Check if player has items
    if not PlayerData.items or table.getSize(PlayerData.items) == 0 then
        print("No items available!")
        return
    end
    
    -- Get the currently selected item
    local activeItem = PlayerData.activeItem
    
    -- Execute ability based on active item
    if activeItem == 1 then
        -- Lamp ability
        self:useLampAbility()
    elseif activeItem == 2 then
        -- Boot ability (Dash)
        self:useBootAbility()
    else
        print("Unknown item selected: " .. tostring(activeItem))
    end
end

-- Lamp ability - placeholder for now
function Player:useLampAbility()
    print("🔦 Lamp ability activated!")
    -- TODO: Implement lamp ability
    -- Ideas: 
    -- - Reveal hidden items/enemies in radius
    -- - Temporarily increase light radius
    -- - Stun nearby enemies
    -- - Consume battery
end

-- Boot ability - Dash attack
function Player:useBootAbility()
    -- Call the existing dash function
    self:dash()
end
