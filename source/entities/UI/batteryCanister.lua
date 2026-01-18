
class('BatteryCanister').extends(Graphics.sprite)

-- local canister <const> = Graphics.image.new("assets/images/ui/BatterySmall.png")

function BatteryCanister:init(x,y,Zindex)
	self:moveTo(x,y)
	-- self:setImage(canister)
	self.width = 300
	self.height = 12
	
	local canisterImage = Graphics.image.new(self.width, self.height)
	Graphics.pushContext(canisterImage)
		Graphics.setColor(Graphics.kColorBlack)
		Graphics.drawRect(0, 0, self.width, self.height)
	Graphics.popContext()
	
	self:setImage(canisterImage)
	self:setZIndex(Zindex+1)
	self:add()	
end