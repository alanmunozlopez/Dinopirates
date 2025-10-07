PropCollider = {}
class('PropCollider').extends(playdate.graphics.sprite)

function PropCollider:init(x, y, width, height)
    PropCollider.super.init(self)
    self:setCollideRect(-14, -6, width, height)
    self:setGroups(3)
    self:setCollidesWithGroups({1}) -- assuming player is group 1
    self:add()
    self:moveTo(x, y)
end

function PropCollider:collisionResponse(other)
    if other:isa(Player) then
        return "freeze"
    end
end