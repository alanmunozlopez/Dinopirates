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

-- TODO
-- [x] add id to every prop to manage "destruction"
-- [x] add boot item
-- [x] fix battery UI
-- [x] fix delete save func
-- [x] enemies eating the holes
-- [x] player falling in random positions.
-- [x] ingame menu
-- [] remove all enemies and make just one big enemy:
	-- [x] enemy should move if you are not in range. and alter depending on the level can change the way it moves
	-- [ ] when you win a fight the enemy get stunned (add the feature)
	-- [ ] everytime it gets stunned its power goes up and maybe shoul be a way yo make it less powerful
	-- [ ] also dependeing on how much props eats gets more powerful
	-- [ ] the more powerful the more difficult its the dance
	-- [ ] the better you dance more stun damage you do to the enemy
-- [ ] create the balance scene that can only be entered with certain amount of crew members


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
},1)

Panels.vars.lang = "en"

debug = false
diagonalMovement = true -- TODO: fix movement stuck after entering a new room
shinonome = Graphics.font.new('assets/fonts/shinonome/JF-Dot-Shinonome16')
Graphics.setFont(shinonome, 'normal')

Panels.Settings.path = ""
ZIndex = {
	player = 4,
	enemy = 3,
	props = 2,
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
	wall = 5,
	noCollide = 6
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
	debug = Utilities.toggle(debug)
	checkBool(debug)
	if Noble.showFPS == false then
		Noble.showFPS = true
	else 
		Noble.showFPS = false
	end
end)

playdate.display.setRefreshRate(50)
timers = playdate.timer

Noble.new(TitleScene, 0.3, Noble.Transition.MetroNexus) --- TODO: add custom transition