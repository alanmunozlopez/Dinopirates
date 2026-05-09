class('Crosshair').extends(Graphics.sprite)

local crosshairImage = Graphics.image.new('assets/images/ui/crosshair')

function Crosshair:init(x, y)
    self:setImage(crosshairImage)
    self:setZIndex(ZIndex.ui + 10)
    self:moveTo(x, y)
    self:add()
end
