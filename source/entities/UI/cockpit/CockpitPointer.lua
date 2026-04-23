class("CockpitPointer").extends(NobleSprite)

function CockpitPointer:init()
    CockpitPointer.super.init(self)
    local r   = Config.Cockpit.pointerRadius
    local d   = r * 2
    local img = Graphics.image.new(d, d, Graphics.kColorClear)
    Graphics.pushContext(img)
        Graphics.setColor(Graphics.kColorBlack)
        Graphics.fillCircleAtPoint(r, r, r)
    Graphics.popContext()
    self:setImage(img)
    self:setZIndex(ZIndex.ui + 10)
end
