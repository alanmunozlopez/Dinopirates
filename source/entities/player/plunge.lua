-- Plunge skill for player
-- Fires a boomerang projectile and locks movement until caught

function Player:plunge()
    -- Check if can plunge
    if not PlayerData.skills.canPlunge then
        print("Skill 'Plunge' not available!")
        return
    end
    
    -- Only one projectile at a time
    if self.isPlunging then
        print("Already plunging!")
        return
    end

    -- Check if player has the projectile
    if not self.hasProjectile then
        print("You lost your boomerang! Go find it.")
        return
    end
    
    -- Check for valid state
    if not self.isAlive or PlayerData.isGaming ~= true then
        return
    end
    
    -- Check direction - don't fire if idle
    local direction = PlayerData.direction
    if direction == 'idle' or direction == nil then
        print("Cannot plunge in idle state")
        return
    end
    
    print("🪠 Plunge skill activated!")
    
    self.isPlunging = true
    
    -- Create the projectile
    self.projectile = Projectile(self, direction)
    
    -- Set animation state to idle while plunging (locked)
    self:idle()
end

function Player:onProjectileCaught()
    self.isPlunging = false
    self.projectile = nil
    print("✅ Plunge skill completed!")
end
