-- Player hole tile handling.
-- Mirrors the old PropItem isHole collision logic but driven by tile detection.

function Player:checkHoleTile()
    -- Guard: skip if already transitioning or in a special movement state
    if self.isDashing or self.isSliding or self.isPlunging or self.isFalling then
        return
    end

    if not IsPlayerOnHole(self.x, self.y) then
        return
    end

    if PlayerData.items.hasBoots == true and PlayerData.battery > 0 then
        -- Only drain battery when the player is actively moving
        -- (preserves the "time moves when you move" contract)
        if PlayerData.isActive then
            if PlayerData.isTiny == true then
                self:drainBattery(Config.Battery.drainHoleTiny)
            else
                self:drainBattery(Config.Battery.drainHoleNormal)
            end
        end
    else
        -- Set flag BEFORE fallBelow() to block re-entry on subsequent frames
        -- while the Noble.transition() is still in progress.
        self.isFalling = true
        self:fallBelow()
    end
end
