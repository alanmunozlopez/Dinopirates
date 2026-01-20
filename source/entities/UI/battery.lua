Battery = {}
class('Battery').extends(Graphics.sprite)



function Battery:init(x, y, player, Zindex)
    self.player = player
    
    self:setZIndex(Zindex)
    self:moveTo(x,y)
    self:add(0,0)
end

function Battery:moveTo(x, y)
    Battery.super.moveTo(self, x, y)
end

function Battery:update()
    if PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true then
        self.battery = PlayerData.battery
        
            local fillWidth = 27
            local batteryPercent = (self.battery * fillWidth) / 100
            
            local batteryFill = Graphics.image.new(fillWidth, 6)
            
            Graphics.pushContext(batteryFill)
                Graphics.setColor(Graphics.kColorBlack)
                Graphics.fillRect(0, 0, batteryPercent, 1)
            Graphics.popContext()
            self:setImage(batteryFill)

    end
end



