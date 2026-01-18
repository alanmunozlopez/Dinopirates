Battery = {}
class('Battery').extends(Graphics.sprite)

import 'entities/UI/batteryCanister'

function Battery:init(x, y, player, Zindex)
    self.player = player
    batteryCanister = BatteryCanister(x,y,Zindex)
    self:setZIndex(Zindex)
    self:moveTo(x,y)
    self:add(0,0)
end

function Battery:update()
    if PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true then
        self.battery = PlayerData.battery
        
        local padding = 2
        local fillWidth = batteryCanister.width - (padding * 2)
        local fillHeight = batteryCanister.height - (padding * 2)
        local batteryPercent = (self.battery * fillWidth) / 100
        
        local batteryFill = Graphics.image.new(fillWidth, fillHeight)
        
        Graphics.pushContext(batteryFill)
            Graphics.setColor(Graphics.kColorBlack)
            Graphics.fillRect(0, 0, batteryPercent, fillHeight)
        Graphics.popContext()
        self:setImage(batteryFill)
        batteryCanister:add()
    else
        batteryCanister:remove()
    end
end



