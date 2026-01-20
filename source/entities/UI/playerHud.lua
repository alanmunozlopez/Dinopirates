playerHud = {}
class("playerHud").extends(NobleSprite)

import "entities/UI/battery"
import "entities/UI/keyHud"
import "entities/UI/sanityHud"

local batteryIndicator = nil
local keyIndicator = nil
local sanityIndicator = nil

-- local background <const> = Graphics.image.new('assets/images/ui/statusbar.png')

function playerHud:init(player)	
	playerHud.super.init(self,'assets/images/ui/statusbar', true)
	self.player = player
	
	-- Mark: animation states
	self.animation:addState('1item', 1, 1)
	self.animation:addState('2item', 2, 2)
	self.animation:addState('3item', 3, 3)
	self.animation:setState('1item')
	
	self:setSize(84,22)
	self:setCenter(0.5, 0.5)
	self:setZIndex(ZIndex.hud)
	
	local x = 0
	local y = 0
	if player then
		x = player.x
		y = player.y - 40
	end
	
	self:moveTo(x, y)
	
	self.batteryIndicator = Battery(x + 8, y, player, ZIndex.hud+1)
	self.sanityIndicator = sanityHud(x + 24, y, ZIndex.hud+1, player)
	--keyIndicator = keyHud(x+32, 11, ZIndex.hud+1, player, userUI)
	self:add()
end

function playerHud:update()
	if self.player then
		local tx = self.player.x
		local ty = self.player.y - 40
		self:moveTo(tx, ty)
		
		if self.batteryIndicator then
			self.batteryIndicator:moveTo(tx + 8, ty)
		end
		if self.sanityIndicator then
			self.sanityIndicator:moveTo(tx + 24, ty)
		end
	end

	if PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true then
		self.animation:setState('2item')
	end
	if (PlayerData.hasKey == true) and (PlayerData.items.hasLamp == true or PlayerData.items.hasBoots == true) then
		self.animation:setState('3item')
	end
end

function playerHud:removeAll()
	if self.batteryIndicator then
		self.batteryIndicator:remove()
	end
	if self.sanityIndicator then
		self.sanityIndicator:remove()
	end
	self:remove()
end

