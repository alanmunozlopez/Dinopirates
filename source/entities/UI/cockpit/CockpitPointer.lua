class("CockpitPointer").extends(NobleSprite)

function CockpitPointer:init()
    CockpitPointer.super.init(self, 'assets/images/ui/cockpit/ui-pointer', true)
    self.animation:addState('idle', 1, 2)
    self.animation.idle.frameDuration = 8
    self.animation:setState('idle')
    self:setSize(28, 28)
    self:setZIndex(ZIndex.ui + 10)
end
