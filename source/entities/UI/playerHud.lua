playerHud = {}
class("playerHud").extends(NobleSprite)

import "entities/UI/battery"
import "entities/UI/keyHud"
import "entities/UI/sanityHud"

local batteryIndicator = nil
local keyIndicator = nil
local sanityIndicator = nil

-- local background <const> = Graphics.image.new('assets/images/ui/statusbar.png')

function playerHud:init()	
	playerHud.super.init(self,'assets/images/ui/statusbar', true)
	
	-- Mark: animation states
	self.animation:addState('1item', 1, 1)
	self.animation:addState('2item', 2, 2)
	self.animation:addState('3item', 3, 3)
	self.animation:setState('1item')
	local x = 316
	local y = 0
	
	self:setSize(84,22)
	self:setImage(background)
	self:setCenter(0,0)
	self:moveTo(x, y)
	self:setZIndex(ZIndex.ui)
	batteryIndicator = Battery(x+50, 11, player, ZIndex.ui+1, userUI)
	sanityIndicator = sanityHud(x+66, 11, ZIndex.ui+1, player, userUI)
	--keyIndicator = keyHud(x+32, 11, ZIndex.ui+1, player, userUI)
	self:add(x,y)
end

function playerHud:update()
	if PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true then
		self.animation:setState('2item')
	end
	if (PlayerData.hasKey == true) and (PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true) then
		self.animation:setState('3item')
	end
end

