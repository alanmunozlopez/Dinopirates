class('Meteorite').extends(NobleSprite)

function Meteorite:init(x, y, speed)
    Meteorite.super.init(self, 'assets/images/space/meteorite', true)

    self.animation:addState('spin', 1, 4)
    self.animation.spin.frameDuration = speed or 4

    self:setGroups(1)
    self:setZIndex(ZIndex.props)
    self:add(x, y)
end

function Meteorite:updateSpeed(speed)
    self.animation.spin.frameDuration = speed
end
