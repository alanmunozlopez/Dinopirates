--
-- Mazescene.lua
--
-- Use this as a starting point for your game's scenes.
-- Copy this file to your root "scenes" directory,
-- and rename it.
--

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- !!! Rename "scene" to your scene's name in these first three lines. !!!
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

MazeScene = {
}
class("MazeScene").extends(NobleScene)

local scene = MazeScene
local room = nil -- Level in table position

import "entities/player/init"

import "assets/comics/comicsData"

import "entities/enemies/brocorat"
import "entities/enemies/bosscolli"
import "entities/enemies/crewmember"

import 'entities/props/propItem'
import 'entities/props/door'
import 'entities/props/trigger'

import 'entities/items/Items'

import "entities/FX/FXshadow"
import "entities/UI/playerHud"
import "entities/UI/inGameMenu"

-- It is recommended that you declare, but don't yet define,
-- your scene-specific variables and methods here. Use "local" where possible.
--
-- local variable1 = nil	-- local variable
-- scene.variable2 = nil	-- Scene variable.
--							   When accessed outside this file use `scene.variable2`.
-- ...
--



-- Mark: player related
local player = nil
local shadow = nil
local inGameMenuActive = nil
-- Mark: UI
local uiScreen = nil
local inGameEquip = nil
-- Mark: Utilities
local cheat = CheatCode("up", "up", "up", "down")
-- This is the background color of this scene.
scene.backgroundColor = Graphics.kColorWhite

-- This runs when your scene's object is created, which is the
-- first thing that happens when transitioning away from another scene.
function scene:init()
	scene.super.init(self)
	cheat.onComplete = function()
		PlayerData.hasLamp = true
	end
	-- Your code here
	
end
function scene:setFloor(levelNumber, roomNumber)
	for i, levelData in ipairs(levelsLDTK) do
		print(i)
		print(levelData.customFields.level)
		print(levelData.customFields.roomNumber)
		if levelData.customFields.level == levelNumber and levelData.customFields.roomNumber == roomNumber then
			room = i
			print(levelData.customFields.level)
			return
		end
	end
	print("Warning: Level " .. levelNumber .. ", Room " .. roomNumber .. " not found")
	print(room)
	
end

-- When transitioning from another scene, this runs as soon as this
-- scene needs to be visible (this moment depends on which transition type is used).
function scene:enter()
	scene.super.enter(self)
	-- Your code here
	
	
	PlayerData.isGaming = false
	PlayerData.isEquiping = false
	sequence = Sequence.new():from(0):to(50, 1.5, Ease.outBounce)
	sequence:start()
	
	PlayerData.room = levelsLDTK[room].customFields.roomNumber
	PlayerData.isInDarkness = levelsLDTK[room].customFields.shadow
	PlayerData.floor = room
	
	PlayerData.actualLevel = levelsLDTK[room].customFields.level
	PlayerData.actualRoom = levelsLDTK[room].customFields.roomNumber
	PlayerData.actualTilemap = levelsLDTK[room].customFields.tile -- aca tengo que ver como conectar el tile con el csv
	levels[room].floor.visited = true
	
	-- Mark: floor
	tilesMap = Graphics.imagetable.new('assets/images/tile/tile')
	map = Graphics.tilemap.new()
	map:setImageTable(tilesMap) 
	-- map:setSize(16,9)
	
	-- Mark: UI
	uiScreen = playerHud()
	inGameEquip = inGameMenu()
	-- Mark: floor 
	map:setSize(25, 15) -- 25 tiles wide, 15 tiles tall
	
	renderTileMap(tileMapData[PlayerData.actualTilemap], map)
	
	floor = Graphics.sprite.new()
	floor:setZIndex(1)
	floor:setTilemap(map)
	floor:moveTo(0, 0) -- Top-left corner
	floor:setCenter(0, 0) -- Anchor top-left instead of center
	floor:add()
	
	--Mark: Walls (this can be optimized)
	wallTop = Box(0, 0, 400, 20)
	wallDown = Box(0, 228, 400, 12)
	wallLeft = Box(0, 12, 12, 216)
	wallRight = Box(388, 12, 12, 216)
	
	-- Mark: doors
	local arrayData = levels[room].floor.doors -- Used several times to save variables
	if arrayData ~= nil then
		for _, doorData in ipairs(arrayData) do
			local direction = doorData.direction
			local open = doorData.open
			local leads = doorData.leadsTo
		
			Door(direction, open, leads, ZIndex.props)
		end
	end
	
	
	-- Mark: Props 
	local entities = levelsLDTK[room].entities
	
	if entities ~= nil then
		for entityType, entitiesList in pairs(entities) do
			for _, prop in ipairs(entitiesList) do
				local cf = prop.customFields or {}
	
				if cf.destroyed ~= nil or cf.nocollider ~= nil then
					local x, y, id = prop.x, prop.y, prop.id
	
					if cf.destroyed == false or cf.destroyed == nil then
						PropItem(x, y, cf.type , ZIndex.props, cf.nocollider,cf.destroyed, id)
					else
						PropItem(x, y, "debris", ZIndex.props, true, cf.destroyed , id)
					end
				end
			end
		end
	end
	
	-- Mark: Items
	if entities ~= nil then
		for entityType, entitiesList in pairs(entities) do
			for _, item in ipairs(entitiesList) do
				local cf = item.customFields or {}
	
				-- Detectar si pertenece a la capa Items o si es un tipo de ítem
				if item.layer == "Items" or cf.isItem == true then
					local x, y = item.x, item.y
					local type = cf.type or entityType:lower() -- usa el tipo definido o el nombre de la entidad
					
					local itemRequirements = {
						keycard = "hasKey",
						lamp = "hasLamp",
						radio = "hasRadio",
						notes = "hasNotes",
						bag = "hasBag",
						tools = "hasTools"
					}
					
					-- Si el jugador no tiene este ítem, lo genera
					if itemRequirements[type] and PlayerData[itemRequirements[type]] == false then
						Items(x, y, type)
					end
				end
			end
		end
	end
	-- Mark: Player
	local spawnPoint = PlayerData.playerSpawn
	player = Player(spawnPoint.x, spawnPoint.y, PlayerData.speed, ZIndex.player)
	PlayerData.x = player.x
	PlayerData.y = player.y
	PlayerData.direction = 'idle'
	
	-- Mark: FX
	local cf = levelsLDTK[room].customFields or {}
	
	if cf.shadow == true then
		local lightLevel = cf.light or 0
		shadow = FXshadow(player, 70, lightLevel, ZIndex.fx)
		PlayerData.isInDarkness = true
	else
		PlayerData.isInDarkness = false
	end
	
	-- Mark: Comic
	arrayData = levels[room].floor.comic
	if arrayData ~= nil then
		local comicData = comics[arrayData.name]
		if comicData then
			if arrayData.play == "enter" and arrayData.wasPlayed == false then
				PlayerData.isCutscene = true
				PlayerData.isGaming = false
			end
			
			local comicName = arrayData.name
			Panels.startCutscene(comicData, function()
				PlayerData.isGaming = true
				PlayerData.isCutscene = false
				levels[room].floor.comic.wasPlayed = true
				Utilities.checkStoryAchievement(comicName)
			end)
		else
			-- comic not found
		end
	end
	
	
	-- Mark: Enemies
	if entities ~= nil then
		for entityType, entitiesList in pairs(entities) do
			if entityType == "Brocorat" or entityType == "Bosscolli" then
				for _, enemy in ipairs(entitiesList) do
					local cf = enemy.customFields or {}
					local x, y, id = enemy.x, enemy.y, enemy.id
					local speed = cf.speed or 1
					local dead = cf.dead or false
	
					if not dead then
						if entityType == "Brocorat" then
							Brocorat(x, y, speed, ZIndex.enemy, player, id)
						elseif entityType == "Bosscolli" then
							bosscolli(x, y, speed, ZIndex.enemy, player, id)
						end
					else
						PropItem(x, y, "blood2", ZIndex.props, true)
					end
				end
			end
		end
	end
	
	-- Mark: Crew members 
	arrayData = levels[room].floor.items
	
	for i, crewData in ipairs(arrayData) do
		local type = crewData.type
		local x = crewData.x
		local y = crewData.y
		local speed = crewData.speed
		local crewId = crewData.crewId
		if type == "crewmember" then
			if crewData.taken == false then
				CrewMember(x, y, speed, ZIndex.enemy, player, i ,room, crewId)
			end
		end
	end
	
	-- Mark: dialog triggers
	
	arrayData = levels[room].floor.triggers
	for i, triggerData in ipairs(arrayData) do
		if triggerData.usedTrigger == false then
			local x = triggerData.x
			local y = triggerData.y
			local width = triggerData.width
			local height = triggerData.height
			local script = triggerData.script
			local type = triggerData.type
			Trigger(x,y,width,height,script, i, room, type)
		end
	end
	
	SaveSystem.save()
end

-- This runs once a transition from another scene is complete.
function scene:start()
	scene.super.start(self)
	self:setDiagonalMovement(diagonalMovement)
	PlayerData.isGaming = true
end

-- This runs once per frame.
function scene:update()
	scene.super.update(self)
	-- Mark: cheat code
	cheat:update()
	-- Todo: make this a separate function
	if PlayerData.isCutscene == true then
		-- Disable game input handlers while cutscene is running
		if Noble.Input.getEnabled() then
			Noble.Input.setEnabled(false)
		end
		Panels.update()
	else
		-- Re-enable game input handlers when cutscene ends
		if not Noble.Input.getEnabled() then
			Noble.Input.setEnabled(true)
		end
	end
	
	-- Mark: Crank notification
	if PlayerData.battery == 0 and PlayerData.hasLamp == true and PlayerData.isInDarkness == true and (PlayerData.isTalking == false and PlayerData.isCutscene == false) and PlayerData.isGaming == true then
		playdate.ui.crankIndicator:draw(0, 0)
	end
end


-- This runs once per frame, and is meant for drawing code.
function scene:drawBackground()
	scene.super.drawBackground(self)
	-- Your code here
end

-- This runs as as soon as a transition to another scene begins.
function scene:exit()
	scene.super.exit(self)
	
	uiScreen:removeAll()
	floor:remove()
	if shadow then
		shadow:removeAll()
	end
	
	Graphics.sprite.removeAll()
	
	PlayerData.playerExit.x = player.x
	PlayerData.playerExit.y = player.y
	
end

-- This runs once a transition to another scene completes.
function scene:finish()
	scene.super.finish(self)
	-- Your code here
	PlayerData.isGaming = false
end

function scene:pause()
	scene.super.pause(self)
	-- Your code here
	SaveSystem.save()
	
end

function scene:movePlayer(direction)
	if PlayerData.isTalking == false and PlayerData.isCutscene == false then
		if player.isAlive == true then
			player:move(direction)
			if shadow  then
				shadow:move(direction)
			end
		end
	end
end
function playerFocus()-- improve this with more constrains.
	if PlayerData.isCutscene == false or PlayerData.isCutscene == nil then
		player.loadingPower = true
		player:focus()
	end
end
function playerDefocus()
	if PlayerData.isCutscene == false or PlayerData.isCutscene == nil then
		player.loadingPower = false
		player:deFocus()
	end
end
-- Define the inputHander for this scene here, or use a previously defined inputHandler.

-- scene.inputHandler = someOtherInputHandler
-- OR
scene.inputHandler = {

	-- A button
	--
	AButtonDown = function()			-- Runs once when button is pressed.
		if PlayerData.isTalking == true then
			player:displayDialog()
		end
		-- if PlayerData.hasRadio == true  then
		-- 	PlayerData.sonarActive = true
		-- end
	end,
	AButtonHold = function()			-- Runs every frame while the player is holding button down.
		-- Your code here
	end,
	AButtonHeld = function()			-- Runs after button is held for 1 second.
		-- Your code here
		if PlayerData.isGaming == true and table.getSize(PlayerData.items) > 0  then
			-- inGameMenu:displayMenu()
		end
	end,
	AButtonUp = function()				-- Runs once when button is released.
		-- Your code here
		-- if PlayerData.hasRadio == true  then
		-- 	PlayerData.sonarActive = false
		-- end
	end,

	-- B button
	--

	BButtonDown = function()
		if PlayerData.isGaming == false and PlayerData.isEquiping == true then
			PlayerData.isGaming = true
			PlayerData.isEquiping = false
			--inGameMenu:closeMenu()
		end
		--CurrentTile() for testing
		playerFocus()
	end,
	BButtonHeld = function()
		
		
	end,
	BButtonHold = function()
		
	end,
	BButtonUp = function()
		playerDefocus()
	end,
	-- D-pad left
	--
	leftButtonDown = function()
		if isDiagonalMovementEnabled or not isPlayerMoving then
			isPlayerMoving = true
			currentMoveDirection = 'left'
			scene:movePlayer('left')
		end
		if PlayerData.isEquiping == true then
			inGameEquip:prevItem()
		end
	end,
	leftButtonHold = function()
		if isDiagonalMovementEnabled or (isPlayerMoving and currentMoveDirection == 'left') then
			scene:movePlayer('left')
		end
	end,
	leftButtonUp = function()
		if currentMoveDirection == 'left' then
			isPlayerMoving = false
			currentMoveDirection = nil
			player:idle()
			if shadow then
				shadow:refresh()
			end
		end
	end,

	-- D-pad right
	--
	rightButtonDown = function()
		if isDiagonalMovementEnabled or not isPlayerMoving then
			isPlayerMoving = true
			currentMoveDirection = 'right'
			scene:movePlayer('right')
		end
		if PlayerData.isEquiping == true then
			inGameEquip:nextItem()
		end
	end,
	rightButtonHold = function()
		if isDiagonalMovementEnabled or (isPlayerMoving and currentMoveDirection == 'right') then
			scene:movePlayer('right')
		end
	end,
	rightButtonUp = function()
		if currentMoveDirection == 'right' then
			isPlayerMoving = false
			currentMoveDirection = nil
			player:idle()
			if shadow then
				shadow:refresh()
			end
		end
	end,

	-- D-pad up
	--
	upButtonDown = function()
		if isDiagonalMovementEnabled or not isPlayerMoving then
			isPlayerMoving = true
			currentMoveDirection = 'up'
			scene:movePlayer('up')
		end
	end,
	upButtonHold = function()
		if isDiagonalMovementEnabled or (isPlayerMoving and currentMoveDirection == 'up') then
			scene:movePlayer('up')
		end
	end,
	upButtonUp = function()
		if currentMoveDirection == 'up' then
			isPlayerMoving = false
			currentMoveDirection = nil
			player:idle()
			if shadow then
				shadow:refresh()
			end
		end
	end,

	-- D-pad down
	--
	downButtonDown = function()
		if isDiagonalMovementEnabled or not isPlayerMoving then
			isPlayerMoving = true
			currentMoveDirection = 'down'
			scene:movePlayer('down')
		end
	end,
	downButtonHold = function()
		if isDiagonalMovementEnabled or (isPlayerMoving and currentMoveDirection == 'down') then
			scene:movePlayer('down')
		end
	end,
	downButtonUp = function()
		if currentMoveDirection == 'down' then
			isPlayerMoving = false
			currentMoveDirection = nil
			player:idle()
			if shadow then
				shadow:refresh()
			end
		end
	end,

	-- Crank
	--
	cranked = function(change, acceleratedChange)
		scene:PowerCrank()
		if playdate.getCrankTicks(2) > 0 then
			player:burnCalories(1)
		end
	end,
	crankDocked = function()						-- Runs once when when crank is docked.
	end,
	crankUndocked = function()						-- Runs once when when crank is undocked.
		
	end
}

function MazeScene:setDiagonalMovement(enabled)
	isDiagonalMovementEnabled = enabled
end

function scene:PowerCrank()
    if not player.isAlive then return end
    if PlayerData.isGaming == true then
    	if playdate.getCrankTicks(4) > 0 then
        	if player.loadingPower then
            	print('powa')  -- Consider removing debug print
        	else
            	player:chargeBattery(3)
            	if shadow then
                	shadow:refresh()
            	end
        	end
    	end
		
	end
    
    if player.battery == 100 then
        player:idle()
    end
end
