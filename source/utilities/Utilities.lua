-- Put your utilities and other helper functions here.
-- The "Utilities" table is already defined in "noble/Utilities.lua."
-- Try to avoid name collisions.

class('Box').extends(playdate.graphics.sprite)

function Utilities.getZero()
	return 0
end

-- mark: Draw collider boxes (walls)

function Box:init(x, y, width, height) 
	Graphics.setColor(playdate.graphics.kColorWhite)
	Graphics.fillRect(x, y, width, height)
	Graphics.drawRect(x, y, width, height)
	self:setSize(width, height)
	self:moveTo(x, y)
	self:setCenter(0,0)
	self:addSprite()
	self:setCollideRect(0,0,width,height)
	self:setGroups(CollideGroups.wall)
end

--- Creates walls for a room based on its LDTK neighbors
-- Walls are dynamically adjusted according to connections with neighboring rooms
-- @param currentRoom table The current room data from levelsLDTK
-- @return table Table with the 4 created walls {top, bottom, left, right}
function CreateWallsFromLDTK(currentRoom)
	printDebug("🧱 ===== CREATING WALLS =====")

	if not currentRoom or not currentRoom.neighbourLevels then
		printDebug("❌ ERROR: currentRoom or neighbourLevels is nil")
		return
	end

	local neighbours = {}
	for _, n in ipairs(currentRoom.neighbourLevels) do
		if n.dir then
			neighbours[n.dir] = true
		end
	end

	printDebug("👀 Analyzing neighbors:")
	for dir, _ in pairs(neighbours) do
		printDebug("   🔹 Neighbor in direction:", dir)
	end

	-- Base wall positions
	local wallTopY = 0
	local wallBottomY = 228
	local wallLeftX = 0
	local wallRightX = 388

	-- Movement offsets
	local offset = 16

	-- NORTH (no n, nw, ne)
	if not (neighbours["n"] or neighbours["nw"] or neighbours["ne"]) then
		printDebug("⬆️ No neighbor to the north → moving top wall +Y")
		wallTopY = wallTopY + offset
	end

	-- SOUTH (no s, sw, se)
	if not (neighbours["s"] or neighbours["sw"] or neighbours["se"]) then
		printDebug("⬇️ No neighbor to the south → moving bottom wall -Y")
		wallBottomY = wallBottomY - offset
	end

	-- WEST (no w, nw, sw)
	if not (neighbours["w"] or neighbours["nw"] or neighbours["sw"]) then
		printDebug("⬅️ No neighbor to the west → moving left wall +X")
		wallLeftX = wallLeftX + offset
	end

	-- EAST (no e, ne, se)
	if not (neighbours["e"] or neighbours["ne"] or neighbours["se"]) then
		printDebug("➡️ No neighbor to the east → moving right wall -X")
		wallRightX = wallRightX - offset
	end

	-- Create walls
	local wallTop = Box(0, wallTopY, 400, 12)
	local wallDown = Box(0, wallBottomY - 4, 400, 12)
	local wallLeft = Box(wallLeftX, 12, 12, 216)
	local wallRight = Box(wallRightX, 12, 12, 216)

	printDebug("✅ Walls created with offsets:")
	printDebug("   Top Y:", wallTopY, "| Bottom Y:", wallBottomY, "| Left X:", wallLeftX, "| Right X:", wallRightX)
	printDebug("🧱 ===== END WALL CREATION =====")

	return {
		top = wallTop,
		bottom = wallDown,
		left = wallLeft,
		right = wallRight
	}
end


-- MARK: Cheat codes

local keys = {
	a = playdate.kButtonA,
	b = playdate.kButtonB,
	up = playdate.kButtonUp,
	down = playdate.kButtonDown,
	left = playdate.kButtonLeft,
	right = playdate.kButtonRight,
}

-- Mark: Cheatcodes
class("CheatCode").extends()

function CheatCode: init(...)
	local seq = {}
	for _, key in ipairs({...}) do
		local v = keys[key]
		assert(v, "CheatCode: unkwnown key given => "..tostring(key))
		table.insert(seq, v)
	end
	self._seq= seq
	self.progress = 1
	self.run_once = false
	self:setTimerDelay(400)
end

function CheatCode:update()
	if self.run_once and self.completed then return end
	
	local _, pressed, _= playdate.getButtonState()
	
	if pressed == 0 then return end
	
	if pressed == self._seq[self.progress] then
		self.progress += 1
		self._timer:reset()
	
		if self.progress > #self._seq then
		  self.completed = true
		  if type(self.onComplete) == "function" then
			self.onComplete()
		  end
		end
	  else
		self:reset()
	  end
end

function CheatCode:reset()
	self.progress = 1
	self._timer:reset()
	self._timer:pause()
end

function CheatCode:setTimerDelay(ms)
  if self._timer then
	self._timer:remove()
  end
  self._timer = playdate.timer.new(ms, function() self:reset() end)
  self._timer:pause()
  self._timer.discardOnCompletion = false
end

function CheatCode:nextIs(key)
  return keys[key] == self._seq[self.progress]
end

function RandomScreen(axis)
	if axis == "x" then
		return math.random(20,380)
	elseif axis == "y" then
		return math.random(20,220)
	end
end

function checkBool(bool)
	local string
	if bool == true then
		print('true')
	elseif (bool == false) then
		print('false')
	end
end
function printDebug(value)
	if debug == true then
		print(value)
	end
end
function RoomTranslate(roomNumber)
	local floorClass = "Floor" .. roomNumber
	return _G[floorClass]
end
-- Door utilities
--- Finds a room by its uniqueIdentifer (iid)
-- Uses a hash index for O(1) search
-- @param iid string The uniqueIdentifer of the room to search for
-- @return table|nil The room data or nil if not found
function FindRoomByIid(iid)
	if not iid then
		printDebug("❌ iid is nil")
		return nil
	end
	
	-- Use hash index for fast O(1) search
	if roomsByIid and roomsByIid[iid] then
		printDebug("✅ Room found (hash):", roomsByIid[iid].identifier)
		return roomsByIid[iid]
	end
	
	-- Fallback: linear search if index is not available
	if not levelsLDTK then
		printDebug("❌ levelsLDTK is not initialized")
		return nil
	end
	
	printDebug("🔍 Searching room with iid (fallback):", iid)
	for i, room in ipairs(levelsLDTK) do
		if room and room.uniqueIdentifer == iid then
			printDebug("✅ Room found:", room.identifier)
			return room
		end
	end
	printDebug("❌ Room NOT found with iid:", iid)
	return nil
end

--- Converts LDTK direction to door direction
-- @param dir string LDTK direction
-- @return string Door direction
function ConvertLDTKDirection(dir)
	printDebug("🧭 Converting direction:", dir)
	local result
	if dir == ">" then
		result = "down"  -- Staircase up (visually at bottom of screen)
	elseif dir == "<" then
		result = "top"  -- Staircase down (visually at top of screen)
	elseif dir == "n" then
		result = "top"  -- Door up
	elseif dir == "s" then
		result = "down"  -- Door down
	elseif dir == "e" then
		result = "right"  -- Door right
	elseif dir == "w" or dir == "o" then
		result = "left"  -- Door left
	else
		result = dir
	end
	printDebug("   → Result:", result)
	return result
end

--- Calculates the destination room number based on direction
-- @param currentLevel number The current level (1, 2, 3...)
-- @param currentRoomNumber number The current room number (0-99)
-- @param direction string The LDTK direction (">", "<", "n", "s", "e", "w")
-- @param neighborRoom table|nil The neighbor data (optional for stairs)
-- @return number The complete destination room number (e.g. 220)
function CalculateLeadsTo(currentLevel, currentRoomNumber, direction, neighborRoom)
	printDebug("🎯 Calculating leadsTo:")
	printDebug("   Current Level:", currentLevel)
	printDebug("   Current Room:", currentRoomNumber)
	printDebug("   Direction:", direction)
	
	local fullCurrentRoom = currentLevel * 100 + currentRoomNumber
	printDebug("   Full Current Room:", fullCurrentRoom)
	
	local result
	if direction == ">" then
		-- Upper floor: 120 -> 220
		result = (currentLevel + 1) * 100 + currentRoomNumber
		printDebug("   → Staircase UP to:", result)
	elseif direction == "<" then
		-- Lower floor: 120 -> 020
		result = (currentLevel - 1) * 100 + currentRoomNumber
		printDebug("   → Staircase DOWN to:", result)
	else
		-- Normal door: uses neighbor's level and roomNumber
		if neighborRoom then
			local neighborLevel = neighborRoom.customFields.level or 1
			local neighborRoomNum = neighborRoom.customFields.roomNumber or 0
			result = neighborLevel * 100 + neighborRoomNum
			printDebug("   → NORMAL door to:", result, "(level:", neighborLevel, "room:", neighborRoomNum, ")")
		else
			printDebug("   ⚠️  neighborRoom is nil, cannot calculate")
			result = fullCurrentRoom -- Fallback to same room
		end
	end
	return result
end

--- Generates doors for a room from levelsLDTK
-- Creates doors based on the Doors entities list
-- Each door entity has a DoorsConnection field indicating its direction
-- @param currentRoom table The current room data
function CreateDoorsFromLDTK(currentRoom)
	if not currentRoom then
		printDebug("❌ ERROR: currentRoom is nil")
		return
	end
	
	printDebug("🚪 ===== CREATING DOORS =====")
	printDebug("📍 Current room:", currentRoom.identifier)
	
	-- Check if there are door entities
	local doorEntities = currentRoom.entities and currentRoom.entities.Doors
	if not doorEntities or #doorEntities == 0 then
		printDebug("⚠️  No door entities in this room")
		return
	end
	
	printDebug("📊 Total door entities:", #doorEntities)
	
	local neighbourLevels = currentRoom.neighbourLevels
	if not neighbourLevels then
		printDebug("⚠️  No neighbourLevels in this room")
		return
	end
	
	local currentLevel = currentRoom.customFields.level or 1
	local currentRoomNumber = currentRoom.customFields.roomNumber or 0
	
	printDebug("🏢 Current level:", currentLevel, "| Room:", currentRoomNumber)
	
	-- Create a map of neighbors by direction for quick lookup
	local neighborsByDir = {}
	for _, neighbor in ipairs(neighbourLevels) do
		if neighbor.dir then
			neighborsByDir[neighbor.dir] = neighbor
		end
	end
	
	-- Mapping from door direction names to LDTK directions
	local doorDirectionMap = {
		-- Cardinal directions (north, south, east, west)
		top = "n",      -- North
		down = "s",     -- South
		right = "e",    -- East
		left = "w",     -- West
		-- Stairs
		upper = ">",    -- Stairs up
		lower = "<"     -- Stairs down
	}
	
	-- Process each door entity
	for i, doorEntity in ipairs(doorEntities) do
		printDebug("")
		printDebug("--- Processing door entity", i, "---")
		printDebug("   iid:", doorEntity.iid)
		printDebug("   position: (", doorEntity.x, ",", doorEntity.y, ")")
		
		local doorConnection = doorEntity.customFields and doorEntity.customFields.DoorsConnection
		if not doorConnection then
			printDebug("⚠️  Door entity has no DoorsConnection field, skipping")
		else
			printDebug("🔑 Door direction:", doorConnection)
			
			local doorNameLower = doorConnection:lower()
			local ldtkDir = doorDirectionMap[doorNameLower]
			
			if not ldtkDir then
				printDebug("⚠️  Unknown door direction:", doorConnection)
			else
				printDebug("🔍 Looking for neighbor in LDTK direction:", ldtkDir)
				
				local neighbor = neighborsByDir[ldtkDir]
				
				if not neighbor then
					printDebug("🚫 No neighbor found in direction:", ldtkDir, "- skipping door")
				else
					printDebug("✅ Neighbor found in direction:", ldtkDir)
					printDebug("   levelIid:", neighbor.levelIid)
					
					local direction = ConvertLDTKDirection(ldtkDir)
					
					-- Check if door needs a key
					local needsKey = doorEntity.customFields.NeedsKey or false
					local keyNumber = doorEntity.customFields.KeyNumber
					
					printDebug("🔐 NeedsKey:", needsKey)
					if needsKey and keyNumber then
						printDebug("   KeyNumber:", keyNumber)
					end
					
					-- Handle stairs (upper/lower)
					if ldtkDir == ">" or ldtkDir == "<" then
						printDebug("⚡ It's a STAIRCASE")
						
						local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, ldtkDir, nil)
						local open = needsKey and "closed" or "open"
						
						printDebug("🔧 Creating staircase:")
						printDebug("   direction:", direction)
						printDebug("   open:", open)
						printDebug("   leadsTo:", leadsTo)
						printDebug("   ZIndex:", ZIndex.props)
						
						-- Create the staircase
						--Door(direction, open, leadsTo, ZIndex.props)
						printDebug("✅ Staircase created (commented out)")
						
					-- Handle cardinal directions (north, south, east, west)
					else
						local neighborRoom = FindRoomByIid(neighbor.levelIid)
						
						if neighborRoom then
							printDebug("✅ Neighbor room loaded:", neighborRoom.identifier)
							
							local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, ldtkDir, neighborRoom)
							local open = needsKey and "closed" or "open"
							local keyNumber = needsKey and keyNumber or nil
							
							printDebug("🔧 Creating door:")
							printDebug("   direction:", direction)
							printDebug("   open:", open)
							printDebug("   leadsTo:", leadsTo)
							printDebug("   ZIndex:", ZIndex.props)
							if keyNumber then
								printDebug("   keyNumber:", keyNumber)
							end
							
							-- Create the door
							Door(direction, open, leadsTo, ZIndex.props, keyNumber)
							printDebug("✅ Door created successfully")
						else
							printDebug("⚠️  Neighbor room not loaded in levelsLDTK")
						end
					end
				end
			end
		end
	end
	
	printDebug("🚪 ===== END DOOR CREATION =====")
	printDebug("")
end

--- Finds a neighbor by direction
-- @param currentRoom table Current room data
-- @param direction string Direction to search for
-- @return table|nil Neighbor data or nil
function FindNeighborByDirection(currentRoom, direction)
	printDebug("🔍 Searching for neighbor with direction:", direction)
	
	if not currentRoom.neighbourLevels then
		printDebug("❌ No neighbourLevels")
		return nil
	end
	
	for _, neighbor in ipairs(currentRoom.neighbourLevels) do
		if neighbor.dir == direction then
			printDebug("✅ Neighbor found with dir:", direction)
			return neighbor
		end
	end
	
	printDebug("❌ Neighbor not found with dir:", direction)
	return nil
end

--- Validates if you can fall/climb in a direction
-- @param currentRoom table Current room data
-- @param direction string Direction: "<" to fall (down), ">" to climb (up)
-- @return boolean true if movement is allowed
function CanMoveVertically(currentRoom, direction)
	-- direction: "<" to fall (down), ">" to climb (up)
	local doorsConnection = currentRoom.customFields.DoorsConnection or {}
	
	-- Mapping of vertical directions to names in DoorsConnection
	local directionMap = {
		["<"] = "lower",  -- Fall downwards
		[">"] = "upper"   -- Climb upwards
	}
	
	local requiredConnection = directionMap[direction]
	if not requiredConnection then
		printDebug("⚠️  Vertical direction not recognized:", direction)
		return false
	end
	
	-- Check if it's allowed in DoorsConnection
	for _, allowed in ipairs(doorsConnection) do
		if allowed:lower() == requiredConnection:lower() then
			return true
		end
	end
	
	return false
end

--- Gets the lower room (fall)
-- @param currentRoomIndex number Current room index in levelsLDTK
-- @return number|nil, table|nil Room number and room data
function GetLowerRoom(currentRoomIndex)
	printDebug("⬇️  === SEARCHING FOR LOWER ROOM ===")
	local currentRoom = levelsLDTK[currentRoomIndex]
	
	if not currentRoom then
		printDebug("❌ currentRoom not valid")
		return nil
	end
	
	-- Validate if you can fall
	if not CanMoveVertically(currentRoom, "<") then
		printDebug("🚫 Cannot fall from this room (doesn't have 'lower' in DoorsConnection)")
		return nil
	end
	
	-- Search for neighbor with direction "<" (lower floor)
	local lowerNeighbor = FindNeighborByDirection(currentRoom, "<")
	
	if not lowerNeighbor then
		printDebug("❌ No lower room defined in neighbourLevels")
		return nil
	end
	
	-- Search for room by its iid
	local lowerRoom = FindRoomByIid(lowerNeighbor.levelIid)
	
	if lowerRoom then
		local level = lowerRoom.customFields.level or 0
		local roomNum = lowerRoom.customFields.roomNumber or 0
		local roomNumber = level * 100 + roomNum
		
		printDebug("✅ Lower room found:")
		printDebug("   identifier:", lowerRoom.identifier)
		printDebug("   level:", level)
		printDebug("   roomNumber:", roomNum)
		printDebug("   fullRoomNumber:", roomNumber)
		
		return roomNumber, lowerRoom
	else
		printDebug("⚠️  Lower room is not loaded in levelsLDTK")
		-- Calculate expected number even if not loaded
		local currentLevel = currentRoom.customFields.level or 1
		local currentRoomNum = currentRoom.customFields.roomNumber or 0
		local expectedRoom = (currentLevel - 1) * 100 + currentRoomNum
		
		printDebug("📊 Expected room (calculated):", expectedRoom)
		return expectedRoom, nil
	end
end

--- Gets the upper room (climb)
-- @param currentRoomIndex number Current room index in levelsLDTK
-- @return number|nil, table|nil Room number and room data
function GetUpperRoom(currentRoomIndex)
	printDebug("⬆️  === SEARCHING FOR UPPER ROOM ===")
	local currentRoom = levelsLDTK[currentRoomIndex]
	
	if not currentRoom then
		printDebug("❌ currentRoom not valid")
		return nil
	end
	
	-- Validate if you can climb
	if not CanMoveVertically(currentRoom, ">") then
		printDebug("🚫 Cannot climb from this room (doesn't have 'upper' in DoorsConnection)")
		return nil
	end
	
	-- Search for neighbor with direction ">" (upper floor)
	local upperNeighbor = FindNeighborByDirection(currentRoom, ">")
	
	if not upperNeighbor then
		printDebug("❌ No upper room defined in neighbourLevels")
		return nil
	end
	
	-- Search for room by its iid
	local upperRoom = FindRoomByIid(upperNeighbor.levelIid)
	
	if upperRoom then
		local level = upperRoom.customFields.level or 0
		local roomNum = upperRoom.customFields.roomNumber or 0
		local roomNumber = level * 100 + roomNum
		
		printDebug("✅ Upper room found:")
		printDebug("   identifier:", upperRoom.identifier)
		printDebug("   level:", level)
		printDebug("   roomNumber:", roomNum)
		printDebug("   fullRoomNumber:", roomNumber)
		
		return roomNumber, upperRoom
	else
		printDebug("⚠️  Upper room is not loaded in levelsLDTK")
		-- Calculate expected number even if not loaded
		local currentLevel = currentRoom.customFields.level or 1
		local currentRoomNum = currentRoom.customFields.roomNumber or 0
		local expectedRoom = (currentLevel + 1) * 100 + currentRoomNum
		
		printDebug("📊 Expected room (calculated):", expectedRoom)
		return expectedRoom, nil
	end
end

--- Gets a room by its number
-- @param roomNumber number Complete room number (e.g. 220 = level 2, room 20)
-- @return table|nil Room data or nil
function GetRoomByNumber(roomNumber)
	local level = math.floor(roomNumber / 100)
	local room = roomNumber % 100
	
	printDebug("🔍 Searching room by number:", roomNumber, "(level:", level, "room:", room, ")")
	
	for _, roomData in ipairs(levelsLDTK) do
		if roomData.customFields.level == level and 
		   roomData.customFields.roomNumber == room then
			printDebug("✅ Room found:", roomData.identifier)
			return roomData
		end
	end
	
	printDebug("❌ Room NOT found")
	return nil
end

function drawVersionNumber(x, y, alignment)
	Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)
	
	-- local version = "*"..Panels.vars.lang.."* Demo*" .. playdate.metadata.version .. "*"
	local version = "* Demo " .. playdate.metadata.version .. "*"  -- Wrap version in * for bold
	local versionWidth = Graphics.getTextSize(version)
	
	-- If no x position provided, default to right-aligned at 400 (screen width)
	x = x or 400
	-- If no y position provided, default to 2 (near top)
	y = y or 2
	-- If no alignment provided, default to right alignment with 4px padding
	if alignment == nil then
		x = x - versionWidth - 4
	end
	
	Graphics.drawText(version, x, y)
end 

-- Finds and kills an enemy by its unique ID (LDtk version)
function findAndKillEnemyById(enemyId)
	local room = PlayerData.floor
	local entities = levelsLDTK[room].entities

	if not entities then
		printDebug("⚠️ No entities found in room:", room)
		return
	end

	for entityType, entitiesList in pairs(entities) do
		-- Buscar dentro de tipos de enemigos conocidos
		if entityType == "Brocorat" or entityType == "Bosscolli" then
			for _, enemy in ipairs(entitiesList) do
				if enemy.iid == enemyId then
					local cf = enemy.customFields or {}
					if cf.dead == false or cf.dead == nil then
						cf.dead = true
						-- Actualizamos su posición a donde fue derrotado
						if PlayerData.lastEnemyTouched then
							enemy.x = PlayerData.lastEnemyTouched.x
							enemy.y = PlayerData.lastEnemyTouched.y
						end
						printDebug("💀 Enemy killed:", enemyId, "in", entityType)
					end
					return
				end
			end
		end
	end
end

-- finds and destroys a prop
function findAndDestroyPropById(propId)
	local room = PlayerData.floor
	local entities = levelsLDTK[room].entities

	if not entities then
		printDebug("⚠️ No entities found in room:", room)
		return
	end

	for entityType, entitiesList in pairs(entities) do
		for _, prop in ipairs(entitiesList) do
			local cf = prop.customFields or {}
			-- Detectar si es un prop por tener 'destroyed' o 'nocollider'
			if cf.destroyed ~= nil or cf.nocollider ~= nil then
				if prop.iid == propId then
					if not cf.destroyed then
						cf.destroyed = true
						print("💥 Prop destroyed:", propId, "in", entityType)
					end
					return
				end
			end
		end
	end
end

-- Grants an achievement if it hasn't been granted yet
function Utilities.grantAchievementIfNeeded(name)
	-- Check if the ID exists in achievementData
	for _, data in ipairs(achievementData.achievements) do
		if data.id == name then
			if not achievements.isGranted(name) then
				achievements.grant(name)
			end
			return -- Found and handled, exit function
		end
	end

end

-- Maps comics to achievements
local storyAchievements = {
	intro = "wakeup",
	["pick-the-device"] = "comms",
}

function Utilities.checkStoryAchievement(comic)
	local achievement = storyAchievements[comic]
	if achievement then
		Utilities.grantAchievementIfNeeded(achievement)
	end
end

-- Sanity-based achievements
function Utilities.checkSanityAchievements()
	local sanityAchievements = {
		[2] = "sanityloss1",
		[5] = "sanityloss2",
		-- Future: add [5] = "sanityloss2", etc.
	}
	
	local achievement = sanityAchievements[PlayerData.sanityCounter]
	if achievement then
		Utilities.grantAchievementIfNeeded(achievement)
	end
end

function renderTileMap(tileData, tilemap)
  local height = #tileData
  local width = #tileData[1]
  tilemap:setSize(width, height)
  for y = 1, height do
	for x = 1, width do
	  tilemap:setTileAtPosition(x, y, tileData[y][x])
	end
  end
end

-- Bulk revoke (delete) achievements
function Utilities.clearAllAchievements()
	for _, data in ipairs(achievementData.achievements) do
		if data.id then
			achievements.revoke(data.id)
		end
	end
end

-- Dev Tools
function printEnemies()
	for i, enemy in pairs(playdate.graphics.sprite.getAllSprites()) do
		if enemy.type == "Enemy" then
			printDebug("x:", enemy.x)
			printDebug("y:", enemy.y)
			printDebug("Type:", enemy.type)
			printDebug("ID:", enemy.id)
			printDebug("----")
		end
	end
end

function Utilities.switchLang()
	if Panels.vars.lang == "en" then
		Panels.vars.lang = "jp"
	else
		Panels.vars.lang = "en"
	end
end

function Utilities.renderLangPanel(panel, offset)
	for i, layer in ipairs(panel.layers) do
		if layer.name == "base" then
			Panels.renderLayerInPanel(layer, panel, offset)
		elseif layer.name == "en" and Panels.vars.lang == "en" then
			Panels.renderLayerInPanel(layer, panel, offset)
		elseif layer.name == "jp" and Panels.vars.lang == "jp" then
			Panels.renderLayerInPanel(layer, panel, offset)
		end
	end
end

function Utilities.toggle(value)
  return not value
end

local TILE_SIZE = 16

function CurrentTile()
	local floor = PlayerData.actualTilemap or 1
	local x = tonumber(PlayerData.x) or 0
	local y = tonumber(PlayerData.y) or 0

	-- Convertir coordenadas de píxeles a coordenadas de tile
	local tileX = math.floor(x / TILE_SIZE) + 1
	local tileY = math.floor(y / TILE_SIZE) + 1

	-- Obtener referencias seguras
	local floorData = tileMapData[floor]
	if not floorData then
		printDebug("⚠️ Piso no encontrado:", floor)
		return
	end

	local row = floorData[tileY]
	if not row then
		printDebug(string.format("⚠️ Fuera del rango vertical (tileY=%.2f)", tileY))
		return
	end

	local tileNumber = row[tileX]
	if not tileNumber then
		printDebug(string.format("⚠️ Fuera del rango horizontal (tileX=%.2f)", tileX))
		return
	end

	-- ✅ Usa %.2f para floats y %d solo para enteros seguros
	printDebug(string.format(
		"🧭 Piso %d | Player (%.1f, %.1f) | Tile (%d, %d) = %d",
		floor, x, y, tileX, tileY, tileNumber
	))
end
