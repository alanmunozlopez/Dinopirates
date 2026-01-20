Battery = {}
class('Battery').extends(Graphics.sprite)

import 'entities/UI/batteryCanister'

function Battery:init(x, y, player, Zindex)
    self.player = player
    self.batteryCanister = BatteryCanister(x,y,Zindex)
    self:setZIndex(Zindex)
    self:moveTo(x,y)
    self:add(0,0)
end

function Battery:moveTo(x, y)
    Battery.super.moveTo(self, x, y)
    if self.batteryCanister then
        self.batteryCanister:moveTo(x, y)
    end
end

function Battery:update()
    if PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true then
        self.battery = PlayerData.battery
        if self.batteryCanister then
            local fillWidth = self.batteryCanister.width - 8
            local batteryPercent = (self.battery * fillWidth) / 100
            
            local batteryFill = Graphics.image.new(fillWidth, 6)
            
            Graphics.pushContext(batteryFill)
                Graphics.setColor(Graphics.kColorBlack)
                Graphics.fillRect(0, 0, batteryPercent, 6)
            Graphics.popContext()
            self:setImage(batteryFill)
            self.batteryCanister:add()
        end
    else
        if self.batteryCanister then
            self.batteryCanister:remove()
        end
    end
end



