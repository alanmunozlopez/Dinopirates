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
	playerHud.super.init(self,'assets/images/ui/UIHud', true)
	self.player = player
	
	-- Mark: animation states
	self.animation:addState('100', 1, 1)
	self.animation:setState('100')
	
	self:setSize(35,15)
	self:setCenter(0.5, 0.5)
	self:setZIndex(ZIndex.hud)
	
	local x = 0
	local y = 0
	if player then
		x = player.x
		y = player.y - 36
	end
	
	self:moveTo(x, y)
	
	self.batteryIndicator = Battery(x,y, player, ZIndex.hud+1)
	self:add()
end

function playerHud:update()
	if self.player then
		local tx = self.player.x
		local ty = self.player.y - 36
		self:moveTo(tx, ty)
		
		if self.batteryIndicator then
			self.batteryIndicator:moveTo(tx , ty-3)
		end
	end

	
end

function playerHud:removeAll()
	if self.batteryIndicator then
		self.batteryIndicator:remove()
	end
	self:remove()
end

