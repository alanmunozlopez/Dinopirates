Enemy = {}
class('Enemy').extends(NobleSprite)

import 'entities/FX/FXsonar'

function Enemy:blindSearch(player)
    self.player = player
    local movementX = self.player.x <= self.x and self.x - self.moveSpeed or self.x + self.moveSpeed
    local movementY = self.player.y <= self.y and self.y - self.moveSpeed or self.y + self.moveSpeed

    self.animation:setState('walk')
    self:moveCollision(movementX, movementY, self.player)
end

function Enemy:linealSearch(player)
    if PlayerData.battery == 0 then
        self.moveSpeed = 0
    elseif PlayerData.battery > 60 then
        self.moveSpeed = self.initialSpeed
    end
    self.player = player
    local movementX = self.x
    local movementY = self.y
    
    if math.abs(self.y - self.player.y) < self.viewRange then
        movementX = self.player.x <= self.x and self.x - self.moveSpeed or self.x + self.moveSpeed
        self:moveCollision(movementX, self.y, self.player)
    end
    
    if math.abs(self.x - self.player.x) < self.viewRange then
        movementY = self.player.y <= self.y and self.y - self.moveSpeed or self.y + self.moveSpeed
        self:moveCollision(self.x, movementY, self.player)
    end
end

function Enemy:moveCollision(movementX, movementY, player)
    if PlayerData.battery < 10 and PlayerData.isInDarkness == true then
        self.moveSpeed = 0
    elseif PlayerData.battery > 60 and PlayerData.isInDarkness == true then
        self.moveSpeed = self.initialSpeed
    end
    
    local actualX, actualY, collisions, lenght = self:moveWithCollisions(movementX, movementY)
    if lenght > 0 then
        for index, collision in pairs(collisions) do
            local collideObject = collision['other']
            if collideObject:isa(Player) then
                if self.player.isAlive then
                    self.animation:setState('empty')
                    self.player:dead()
                end
            end
        end
    end
end

function Enemy:collisionResponse(other)
    if other:isa(Items) or other:isa(Trigger) then
        return 'overlap'
    elseif other:isa(Box) or other:isa(PropItem) then
        return 'freeze'
    elseif other:isa(Enemy) then
        -- Empty condition
    else
        return 'freeze'
    end
end

function Enemy:sonar()
    if (PlayerData.x - 60) > (self.x) or (PlayerData.x + 60) < (self.x) then
        if PlayerData.isFocused == true and PlayerData.isInDarkness == true and PlayerData.sanity > 0 then
            self.animation.shine.frameDuration = math.random(1,16)
            self.animation:setState('shine')
            self:setZIndex(10)
        else
            self:setZIndex(self.Zindex)
            self.animation:setState('idle')
        end
    end
end