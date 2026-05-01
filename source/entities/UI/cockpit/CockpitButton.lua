class("CockpitButton").extends(Graphics.sprite)

function CockpitButton:init(x, y, size, label)
    CockpitButton.super.init(self)
    self.label = label
    self.size  = size

    local img = Graphics.image.new(size, size, Graphics.kColorClear)
    Graphics.pushContext(img)
        Graphics.setColor(Graphics.kColorWhite)
        Graphics.fillRect(0, 0, size, size)
        Graphics.setColor(Graphics.kColorBlack)
        Graphics.drawRect(0, 0, size, size)
        Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
        local fontH = shinonome:getHeight()
        Graphics.drawTextAligned(label, size / 2, math.floor(size / 2 - fontH / 2), kTextAlignment.center)
        Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
    Graphics.popContext()

    self:setImage(img)
    self:setZIndex(ZIndex.ui)
    self:moveTo(x, y)
    self:add()
end

function CockpitButton:isHovered(px, py)
    local half = self.size / 2
    local bx, by = self:getPosition()
    return px >= bx - half and px <= bx + half
       and py >= by - half and py <= by + half
end
