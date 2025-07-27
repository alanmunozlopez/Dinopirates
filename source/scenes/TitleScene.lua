import "utilities/SaveSystem"

TitleScene = {}
class("TitleScene").extends(NobleScene)
local scene = TitleScene

local menu
local crankTick = 0
local bg <const> = Graphics.image.new('assets/images/screens/titlescreen.png')
local background <const> = Graphics.sprite.new(bg)
background:moveTo(200,120)


scene.backgroundColor = Graphics.kColorWhite

TitleScene.inputHandler = {
	upButtonDown = function()
		menu:selectPrevious()
	end,
	downButtonDown = function()
		menu:selectNext()
	end,
	cranked = function(change, _)
		crankTick = crankTick + change
		if crankTick > 30 then
			crankTick = 0
			menu:selectNext()
		elseif crankTick < -30 then
			crankTick = 0
			menu:selectPrevious()
		end
	end,
	AButtonDown = function()
		menu:click()
	end
}

-- This runs when your scene's object is created, which is the
-- first thing that happens when transitining away from another scene.
function scene:init()
	scene.super.init(self)
	
	-- Initialize original state if needed
	if not playdate.file.exists('levelOriginal.json') then
		playdate.datastore.write(levels, 'levelOriginal', true)
		playdate.datastore.write(PlayerDataOriginal, 'playerOriginal', true)
	end
	
	menu = Noble.Menu.new(true, Noble.Text.ALIGN_LEFT, false, nil, 2, 16)

	if playdate.file.exists('gameState.json') then
		menu:addItem("Continue", function() 
			SaveSystem.load()
			Noble.transition(
				RoomTranslate(PlayerData.saveLevel),
				1, Noble.Transition.Spotlight, {
				x = 200,
				y = 120,
				xExit = PlayerData.playerSpawn.x,
				yExit = PlayerData.playerSpawn.y,
				holdTime = 0.25,
				ease = Ease.outInQuad}
			) 
		end)
	end
	
	menu:addItem("New Game", function()
	
		SaveSystem.reset()
		Noble.transition(
			Floor107,
			 1, Noble.Transition.Spotlight, {
			x = 200,
			y = 120,
			xExit = PlayerData.playerSpawn.x,
			yExit = PlayerData.playerSpawn.y,
			holdTime = 0.25,
			ease = Ease.outInQuad
		})
	end)
	if playdate.file.exists('gameState.json') then
		menu:addItem("Delete save", function() 
			SaveSystem.delete()
			Utilities.clearAllAchievements()
			Noble.transition(TitleScene,0.3, Noble.Transition.MetroNexus)
		end)
	end
	menu:addItem("Achievements", function()
		Graphics.setImageDrawMode(Graphics.kDrawModeCopy) -- hotfix
		achievements.viewer.launch()
	end)
	-- Add Playground option only if debug is true
	
		-- menu:addItem("Playground", function()
		-- 	PlayerData.hasLamp= true
		-- 	PlayerData.playerSpawn.x = 200
		-- 	PlayerData.playerSpawn.y = 200
		-- 	Noble.transition(Floor121,0.3, Noble.Transition.MetroNexus)  -- Direct transition to room 109
		-- end)
	
	
	menu:select(playdate.file.exists('gameState.json') and "Continue" or "New Game")
end

-- When transitioning from another scene, this runs as soon as this
-- scene needs to be visible (this moment depends on which transition type is used).
function scene:enter()
	scene.super.enter(self)
	-- Your code here
	PlayerData.isGaming = false
	self:addSprite(background)
end

-- This runs once a transition from another scene is complete.
function scene:start()
	scene.super.start(self)
	-- Your code here
	
end

-- This runs once per frame.


function scene:update()
	scene.super.update(self)
	-- Your code here
	menu:draw(8, 120)
	drawVersionNumber()
end

-- This runs once per frame, and is meant for drawing code.
-- function scene:drawBackground()
-- 	scene.super.drawBackground(self)
-- 	-- Your code here
-- end

-- This runs as as soon as a transition to another scene begins.
function scene:exit()
	scene.super.exit(self)
	-- Your code here
	--Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end

-- This runs once a transition to another scene completes.
function scene:finish()
	scene.super.finish(self)
	-- Your code here
	Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end

function scene:pause()
	scene.super.pause(self)
	-- Your code here
end
function scene:resume()
	scene.super.resume(self)
	-- Your code here
end


