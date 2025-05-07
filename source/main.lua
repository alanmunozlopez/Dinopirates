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

local achievementData = {
	iconPath = "assets/launcher/icon", -- Update these paths to match your game’s file structure. See below for more details.
	cardPath = "assets/launcher/card",
	description = "The next (r)evolution in cranking technology.",
	achievements = {
		{
			-- these are the only required fields for a basic achievement.
			id = "my_achievement_1",
			name = "Achievement 1",
			description = "Achievement 1 Description",
		},
		
	}
}

achievements.initialize(achievementData)

Noble.Settings.setup({
	Difficulty = "Medium",
})

Noble.showFPS = false

Noble.GameData.setup({
	Score = 0,
})

debug = false
diagonalMovement = true -- TODO: fix movement stuck after entering a new room

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