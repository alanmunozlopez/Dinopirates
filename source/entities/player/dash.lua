-- Dash attack module for player
-- Allows player to dash 10 pixels in their last facing direction
-- Bounces back 5 pixels on collision

function Player:dash()
    -- Check if dash is on cooldown
    if self.dashCooldown and playdate.getCurrentTimeMilliseconds() < self.dashCooldown then
        print("Dash on cooldown!")
        return
    end
    
    -- Check if player is in valid state
    if not self.isAlive or PlayerData.isGaming ~= true then
        return
    end
    
    -- Get the last direction the player was facing
    local direction = PlayerData.direction
    
    -- Don't dash if player is idle or hasn't moved yet
    if direction == 'idle' or direction == nil then
        print("No direction to dash!")
        return
    end
    
    -- Dash parameters
    local dashDistance = 24
    local bounceDistance = 10
    
    -- Calculate target position based on direction
    local targetX = self.x
    local targetY = self.y
    
    if direction == "left" then
        targetX = self.x - dashDistance
    elseif direction == "right" then
        targetX = self.x + dashDistance
    elseif direction == "up" then
        targetY = self.y - dashDistance
    elseif direction == "down" then
        targetY = self.y + dashDistance
    end
    
    -- Attempt to move to target position
    local actualX, actualY, collisions, length = self:moveWithCollisions(targetX, targetY)
    
    -- Update UI position
    self.uiHud:moveTo(actualX + self.playerUIX, actualY - self.playerUIY)
    
    -- Check if we collided (didn't reach target)
    local collided = false
    if direction == "left" or direction == "right" then
        collided = (actualX ~= targetX)
    else -- up or down
        collided = (actualY ~= targetY)
    end
    
    -- If we collided, bounce back
    if collided and length > 0 then
        local bounceX = actualX
        local bounceY = actualY
        
        if direction == "left" then
            bounceX = actualX + bounceDistance
        elseif direction == "right" then
            bounceX = actualX - bounceDistance
        elseif direction == "up" then
            bounceY = actualY + bounceDistance
        elseif direction == "down" then
            bounceY = actualY - bounceDistance
        end
        
        -- Execute bounce
        self:moveWithCollisions(bounceX, bounceY)
        self.uiHud:moveTo(bounceX + self.playerUIX, bounceY - self.playerUIY)
        
        print("Dash collided! Bouncing back.")
    else
        print("Dash successful!")
    end
    
    -- Set cooldown (500ms = 0.5 seconds)
    self.dashCooldown = playdate.getCurrentTimeMilliseconds() + 500
    
    -- Play dash animation or sound effect here if desired
    -- self.animation:setState('dash' .. direction)
end
