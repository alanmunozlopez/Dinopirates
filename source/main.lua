import 'libraries/noble/Noble'
import 'libraries/panels/Panels'
import 'achievements/all'

import 'utilities/Utilities'
import 'utilities/PauseMenu'

import 'scenes/DeadScene'
import 'scenes/MazeScene'
import 'scenes/DanceScene'
import 'scenes/Floors'
--import 'scenes/StarScene'
import 'scenes/TestScene'
import 'scenes/TitleScene'

import 'assets/data/PlayerDataTables'
import 'assets/data/levels'
import 'assets/data/script'

achievementData = import 'assets/data/achievements'
local configToast = import 'assets/data/toastConfig'

achievements.initialize(achievementData)
achievements.forceSaveOnGrantOrRevoke=true
local config = {
   toastOnGrant = true, -- automatically show toasts for granted achievements
   miniMode = true, -- use tiny toasts to avoid blocking gameplay
   toastFromTop = true,
   -- renderMode = "sprite" -- show black cards with white text, for added contrast
   -- ...
}

achievements.toasts.initialize(configToast)

Noble.Settings.setup({
	Difficulty = "Medium",
	playerSlot = 1
})

Noble.showFPS = false

Noble.GameData.setup({
	Score = 0,
	Lang = "en",
},1)

Noble.GameData.set("Lang", "en", 1)

debug = false
diagonalMovement = true -- TODO: fix movement stuck after entering a new room
shinonome = Graphics.font.new('assets/fonts/shinonome/JF-Dot-Shinonome16')
Graphics.setFont(shinonome, 'normal')

Panels.Settings.path = ""
ZIndex = {
	player = 4,
	enemy = 3,
	props = 3,
	items = 4,
	fx = 6,
	ui = 10,
	alert = 12
}
CollideGroups = {
	player = 1,
	enemy = 2,
	props = 3,
	items = 4,
	wall = 5
}
playdate.datastore.write(levels, 'levelOriginal', true) 
playdate.datastore.write(PlayerDataOriginal, 'playerOriginal', true)-- DEBUG

local menu = playdate.getSystemMenu()

local menuItem, error = menu:addMenuItem("Title", function()
	Noble.transition(TitleScene,0.3, Noble.Transition.MetroNexus)
end)
local menuItem, error = menu:addMenuItem("Lang", function()
	Utilities.switchLang()
end)
local menuItem, error = menu:addMenuItem("debug", function()
	if debug == false then
		debug = true
	end
	if Noble.showFPS == false then
		Noble.showFPS = true
	else 
		Noble.showFPS = false
	end
end)

playdate.display.setRefreshRate(50)
timers = playdate.timer

Noble.new(TitleScene, 0.3, Noble.Transition.MetroNexus) --- TODO: add custom transition