local menuImg = Graphics.image.new('assets/images/ui/menu/menu.png')
local lampImg = Graphics.image.new('assets/images/ui/menu/lamp.png')
local radioImg = Graphics.image.new('assets/images/ui/menu/radio.png')
local notesImg = Graphics.image.new('assets/images/ui/menu/notes.png')
local crewBagImg = Graphics.image.new('assets/images/ui/menu/crewbag.png')

import 'utilities/MapDrawer'

function playdate.gameWillPause()
	if PlayerData.isGaming == true and PlayerData.items.hasNotes == true then
		mapFillingAndChecking()
		drawStatusText()
		if PlayerData.items.hasLamp == true then
			Graphics.pushContext(menuImg)
			lampImg:draw(13, 168)
			Graphics.popContext()
		end
		if PlayerData.items.hasBag == true then
			Graphics.pushContext(menuImg)
			crewBagImg:draw(22, 139)
			Graphics.popContext()
		end
		
		playdate.setMenuImage(menuImg)
	else
		playdate.setMenuImage(nil)
	end
end

local function formatNumberK(n)
	if n >= 1000000 then
		return string.format("%.1fM", n / 1000000):gsub("%.0M", "M")
	elseif n >= 1000 then
		return string.format("%.1fk", n / 1000):gsub("%.0k", "k")
	else
		return tostring(n)
	end
end
function drawStatusText()
	local xPos = 160
	local yPos = 128
	Graphics.pushContext(menuImg)
	
	-- Clear text areas
	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRect(xPos, yPos, 100, 12)
	Graphics.fillRect(xPos, yPos + 12, 100, 12)
	Graphics.fillRect(xPos, yPos + 25, 100, 12)
	Graphics.fillRect(xPos, yPos + 38, 100, 12)
	
	local smallFont = Graphics.font.new('assets/fonts/Mini Sans')
	Graphics.setFont(smallFont)
	
	-- Apply formatting to steps
	local sanityText = ": " .. tostring(PlayerData.sanity)
	local caloriesText = ": " .. tostring(PlayerData.calories)
	local stepsText = ": " .. formatNumberK(PlayerData.totalSteps)
	local mapPercent = ": " .. MapDrawer.calculateMapPercent().."%"

	Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
	Graphics.drawText(sanityText, xPos, yPos)
	Graphics.drawText(caloriesText, xPos, yPos + 12)
	Graphics.drawText(stepsText, xPos, yPos + 25)
	Graphics.drawText(mapPercent, xPos, yPos + 38)
	Graphics.popContext()
end

function mapFillingAndChecking()
	MapDrawer.drawMap(menuImg)
end