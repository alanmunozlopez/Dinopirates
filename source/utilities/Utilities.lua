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

--- Crea las paredes de una habitación basándose en sus vecinos LDTK
-- Las paredes se ajustan dinámicamente según las conexiones con habitaciones vecinas
-- @param currentRoom table Los datos de la habitación actual de levelsLDTK
-- @return table Tabla con las 4 paredes creadas {top, bottom, left, right}
function CreateWallsFromLDTK(currentRoom)
	printDebug("🧱 ===== CREANDO PAREDES =====")

	if not currentRoom or not currentRoom.neighbourLevels then
		printDebug("❌ ERROR: currentRoom o neighbourLevels es nil")
		return
	end

	local neighbours = {}
	for _, n in ipairs(currentRoom.neighbourLevels) do
		if n.dir then
			neighbours[n.dir] = true
		end
	end

	printDebug("👀 Analizando vecinos:")
	for dir, _ in pairs(neighbours) do
		printDebug("   🔹 Vecino en dirección:", dir)
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
		printDebug("⬆️ No hay vecino al norte → moviendo pared superior +Y")
		wallTopY = wallTopY + offset
	end

	-- SOUTH (no s, sw, se)
	if not (neighbours["s"] or neighbours["sw"] or neighbours["se"]) then
		printDebug("⬇️ No hay vecino al sur → moviendo pared inferior -Y")
		wallBottomY = wallBottomY - offset
	end

	-- WEST (no w, nw, sw)
	if not (neighbours["w"] or neighbours["nw"] or neighbours["sw"]) then
		printDebug("⬅️ No hay vecino al oeste → moviendo pared izquierda +X")
		wallLeftX = wallLeftX + offset
	end

	-- EAST (no e, ne, se)
	if not (neighbours["e"] or neighbours["ne"] or neighbours["se"]) then
		printDebug("➡️ No hay vecino al este → moviendo pared derecha -X")
		wallRightX = wallRightX - offset
	end

	-- Create walls
	local wallTop = Box(0, wallTopY, 400, 12)
	local wallDown = Box(0, wallBottomY - 4, 400, 12)
	local wallLeft = Box(wallLeftX, 12, 12, 216)
	local wallRight = Box(wallRightX, 12, 12, 216)

	printDebug("✅ Paredes creadas con offsets:")
	printDebug("   Top Y:", wallTopY, "| Bottom Y:", wallBottomY, "| Left X:", wallLeftX, "| Right X:", wallRightX)
	printDebug("🧱 ===== FIN CREACIÓN PAREDES =====")

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
-- door utilities
--- Encuentra una habitación por su uniqueIdentifer (iid)
-- Usa un índice hash para búsqueda O(1)
-- @param iid string El uniqueIdentifer de la habitación a buscar
-- @return table|nil Los datos de la habitación o nil si no se encuentra
function FindRoomByIid(iid)
	if not iid then
		printDebug("❌ iid es nil")
		return nil
	end
	
	-- Usar índice hash para búsqueda rápida O(1)
	if roomsByIid and roomsByIid[iid] then
		printDebug("✅ Room encontrado (hash):", roomsByIid[iid].identifier)
		return roomsByIid[iid]
	end
	
	-- Fallback: búsqueda lineal si el índice no está disponible
	if not levelsLDTK then
		printDebug("❌ levelsLDTK no está inicializado")
		return nil
	end
	
	printDebug("🔍 Buscando room con iid (fallback):", iid)
	for i, room in ipairs(levelsLDTK) do
		if room and room.uniqueIdentifer == iid then
			printDebug("✅ Room encontrado:", room.identifier)
			return room
		end
	end
	printDebug("❌ Room NO encontrado con iid:", iid)
	return nil
end

-- Función para convertir dirección LDTK a dirección de puerta
function ConvertLDTKDirection(dir)
	printDebug("🧭 Convirtiendo dirección:", dir)
	local result
	if dir == ">" then
		result = "down"  -- Escalera hacia arriba (visualmente está abajo en la pantalla)
	elseif dir == "<" then
		result = "top"  -- Escalera hacia abajo (visualmente está arriba en la pantalla)
	elseif dir == "n" then
		result = "top"  -- Puerta arriba
	elseif dir == "s" then
		result = "down"  -- Puerta abajo
	elseif dir == "e" then
		result = "right"  -- Puerta derecha
	elseif dir == "w" or dir == "o" then
		result = "left"  -- Puerta izquierda
	else
		result = dir
	end
	printDebug("   → Resultado:", result)
	return result
end

--- Calcula el número de habitación destino basado en la dirección
-- @param currentLevel number El nivel actual (1, 2, 3...)
-- @param currentRoomNumber number El número de habitación actual (0-99)
-- @param direction string La dirección LDTK (">", "<", "n", "s", "e", "w")
-- @param neighborRoom table|nil Los datos del vecino (opcional para escaleras)
-- @return number El número completo de la habitación destino (ej. 220)
function CalculateLeadsTo(currentLevel, currentRoomNumber, direction, neighborRoom)
	printDebug("🎯 Calculando leadsTo:")
	printDebug("   Current Level:", currentLevel)
	printDebug("   Current Room:", currentRoomNumber)
	printDebug("   Direction:", direction)
	
	local fullCurrentRoom = currentLevel * 100 + currentRoomNumber
	printDebug("   Full Current Room:", fullCurrentRoom)
	
	local result
	if direction == ">" then
		-- Piso superior: 120 -> 220
		result = (currentLevel + 1) * 100 + currentRoomNumber
		printDebug("   → Escalera ARRIBA a:", result)
	elseif direction == "<" then
		-- Piso inferior: 120 -> 020
		result = (currentLevel - 1) * 100 + currentRoomNumber
		printDebug("   → Escalera ABAJO a:", result)
	else
		-- Puerta normal: usa el level y roomNumber del vecino
		if neighborRoom then
			local neighborLevel = neighborRoom.customFields.level or 1
			local neighborRoomNum = neighborRoom.customFields.roomNumber or 0
			result = neighborLevel * 100 + neighborRoomNum
			printDebug("   → Puerta NORMAL a:", result, "(nivel:", neighborLevel, "room:", neighborRoomNum, ")")
		else
			printDebug("   ⚠️  neighborRoom es nil, no se puede calcular")
			result = fullCurrentRoom -- Fallback a la misma habitación
		end
	end
	return result
end

--- Genera las puertas de una habitación desde levelsLDTK
-- Crea puertas basándose en los vecinos y el campo DoorsConnection
-- @param currentRoom table Los datos de la habitación actual
function CreateDoorsFromLDTK(currentRoom)
	if not currentRoom then
		printDebug("❌ ERROR: currentRoom es nil")
		return
	end
	
	printDebug("🚪 ===== CREANDO PUERTAS =====")
	printDebug("📍 Room actual:", currentRoom.identifier)
	
	local neighbourLevels = currentRoom.neighbourLevels
	if neighbourLevels == nil or #neighbourLevels == 0 then
		printDebug("⚠️  No hay neighbourLevels en esta habitación")
		return
	end
	
	printDebug("📊 Total de vecinos:", #neighbourLevels)
	
	local currentLevel = currentRoom.customFields.level or 1
	local currentRoomNumber = currentRoom.customFields.roomNumber or 0
	local doorsConnection = currentRoom.customFields.DoorsConnection or {}
	
	printDebug("🏢 Nivel actual:", currentLevel, "| Habitación:", currentRoomNumber)
	printDebug("🔑 Puertas permitidas:", table.concat(doorsConnection, ", "))
	
	for i, neighbor in ipairs(neighbourLevels) do
		printDebug("")
		printDebug("--- Procesando vecino", i, "---")
		printDebug("   levelIid:", neighbor.levelIid)
		printDebug("   dir:", neighbor.dir)
		
		local direction = ConvertLDTKDirection(neighbor.dir)
		
		-- Validar si esta puerta está permitida en DoorsConnection
		local isAllowed = false
		local directionCapitalized = direction:sub(1,1):upper() .. direction:sub(2):lower()
		
		for _, allowedDir in ipairs(doorsConnection) do
			if allowedDir:lower() == direction:lower() then
				isAllowed = true
				break
			end
		end
		
		if not isAllowed then
			printDebug("🚫 Puerta NO permitida (no está en DoorsConnection):", direction)
		else
			printDebug("✅ Puerta permitida:", direction)
			
			local neighborRoom = FindRoomByIid(neighbor.levelIid)
			
			-- Para escaleras (> y <), no necesitamos que el vecino exista
			if neighbor.dir == ">" or neighbor.dir == "<" then
				printDebug("⚡ Es una ESCALERA, no se requiere vecino cargado")
				
				local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, neighbor.dir, nil)
				local open = "open"
				
				printDebug("🔧 Creando escalera:")
				printDebug("   direction:", direction)
				printDebug("   open:", open)
				printDebug("   leadsTo:", leadsTo)
				printDebug("   ZIndex:", ZIndex.props)
				
				-- Crea la escalera
				--Door(direction, open, leadsTo, ZIndex.props)
				
				
			elseif neighborRoom then
				printDebug("✅ Vecino encontrado:", neighborRoom.identifier)
				
				local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, neighbor.dir, neighborRoom)
				local open = "open"
				
				printDebug("🔧 Creando puerta:")
				printDebug("   direction:", direction)
				printDebug("   open:", open)
				printDebug("   leadsTo:", leadsTo)
				printDebug("   ZIndex:", ZIndex.props)
				
				-- Crea la puerta
				Door(direction, open, leadsTo, ZIndex.props)
				printDebug("✅ Puerta creada exitosamente")
			else
				print("⚠️  ADVERTENCIA: Vecino no cargado (probablemente la habitación no existe aún)")
			end
		end
	end
	
	printDebug("🚪 ===== FIN CREACIÓN PUERTAS =====")
	printDebug("")
end

-- Función para encontrar el vecino por dirección
function FindNeighborByDirection(currentRoom, direction)
	printDebug("🔍 Buscando vecino con dirección:", direction)
	
	if not currentRoom.neighbourLevels then
		printDebug("❌ No hay neighbourLevels")
		return nil
	end
	
	for _, neighbor in ipairs(currentRoom.neighbourLevels) do
		if neighbor.dir == direction then
			printDebug("✅ Vecino encontrado con dir:", direction)
			return neighbor
		end
	end
	
	printDebug("❌ No se encontró vecino con dir:", direction)
	return nil
end

-- Función para validar si se puede caer/subir en una dirección
function CanMoveVertically(currentRoom, direction)
	-- direction: "<" para caer (bajar), ">" para subir
	local doorsConnection = currentRoom.customFields.DoorsConnection or {}
	
	-- Mapeo de direcciones verticales a nombres en DoorsConnection
	local directionMap = {
		["<"] = "lower",  -- Caer hacia abajo
		[">"] = "upper"   -- Subir hacia arriba
	}
	
	local requiredConnection = directionMap[direction]
	if not requiredConnection then
		printDebug("⚠️  Dirección vertical no reconocida:", direction)
		return false
	end
	
	-- Verificar si está permitido en DoorsConnection
	for _, allowed in ipairs(doorsConnection) do
		if allowed:lower() == requiredConnection:lower() then
			return true
		end
	end
	
	return false
end

-- Función para obtener la habitación inferior (caer)
function GetLowerRoom(currentRoomIndex)
	printDebug("⬇️  === BUSCANDO HABITACIÓN INFERIOR ===")
	local currentRoom = levelsLDTK[currentRoomIndex]
	
	if not currentRoom then
		printDebug("❌ currentRoom no válido")
		return nil
	end
	
	-- Validar si se puede caer
	if not CanMoveVertically(currentRoom, "<") then
		printDebug("🚫 No se puede caer desde esta habitación (no tiene 'lower' en DoorsConnection)")
		return nil
	end
	
	-- Buscar el vecino con dirección "<" (piso inferior)
	local lowerNeighbor = FindNeighborByDirection(currentRoom, "<")
	
	if not lowerNeighbor then
		printDebug("❌ No hay habitación inferior definida en neighbourLevels")
		return nil
	end
	
	-- Buscar la habitación por su iid
	local lowerRoom = FindRoomByIid(lowerNeighbor.levelIid)
	
	if lowerRoom then
		local level = lowerRoom.customFields.level or 0
		local roomNum = lowerRoom.customFields.roomNumber or 0
		local roomNumber = level * 100 + roomNum
		
		printDebug("✅ Habitación inferior encontrada:")
		printDebug("   identifier:", lowerRoom.identifier)
		printDebug("   level:", level)
		printDebug("   roomNumber:", roomNum)
		printDebug("   fullRoomNumber:", roomNumber)
		
		return roomNumber, lowerRoom
	else
		printDebug("⚠️  Habitación inferior no está cargada en levelsLDTK")
		-- Calcular el número esperado aunque no esté cargada
		local currentLevel = currentRoom.customFields.level or 1
		local currentRoomNum = currentRoom.customFields.roomNumber or 0
		local expectedRoom = (currentLevel - 1) * 100 + currentRoomNum
		
		printDebug("📊 Habitación esperada (calculada):", expectedRoom)
		return expectedRoom, nil
	end
end

-- Función para obtener la habitación superior (subir)
function GetUpperRoom(currentRoomIndex)
	printDebug("⬆️  === BUSCANDO HABITACIÓN SUPERIOR ===")
	local currentRoom = levelsLDTK[currentRoomIndex]
	
	if not currentRoom then
		printDebug("❌ currentRoom no válido")
		return nil
	end
	
	-- Validar si se puede subir
	if not CanMoveVertically(currentRoom, ">") then
		printDebug("🚫 No se puede subir desde esta habitación (no tiene 'upper' en DoorsConnection)")
		return nil
	end
	
	-- Buscar el vecino con dirección ">" (piso superior)
	local upperNeighbor = FindNeighborByDirection(currentRoom, ">")
	
	if not upperNeighbor then
		printDebug("❌ No hay habitación superior definida en neighbourLevels")
		return nil
	end
	
	-- Buscar la habitación por su iid
	local upperRoom = FindRoomByIid(upperNeighbor.levelIid)
	
	if upperRoom then
		local level = upperRoom.customFields.level or 0
		local roomNum = upperRoom.customFields.roomNumber or 0
		local roomNumber = level * 100 + roomNum
		
		printDebug("✅ Habitación superior encontrada:")
		printDebug("   identifier:", upperRoom.identifier)
		printDebug("   level:", level)
		printDebug("   roomNumber:", roomNum)
		printDebug("   fullRoomNumber:", roomNumber)
		
		return roomNumber, upperRoom
	else
		printDebug("⚠️  Habitación superior no está cargada en levelsLDTK")
		-- Calcular el número esperado aunque no esté cargada
		local currentLevel = currentRoom.customFields.level or 1
		local currentRoomNum = currentRoom.customFields.roomNumber or 0
		local expectedRoom = (currentLevel + 1) * 100 + currentRoomNum
		
		printDebug("📊 Habitación esperada (calculada):", expectedRoom)
		return expectedRoom, nil
	end
end

function GetRoomByNumber(roomNumber)
	local level = math.floor(roomNumber / 100)
	local room = roomNumber % 100
	
	printDebug("🔍 Buscando room por número:", roomNumber, "(nivel:", level, "room:", room, ")")
	
	for _, roomData in ipairs(levelsLDTK) do
		if roomData.customFields.level == level and 
		   roomData.customFields.roomNumber == room then
			printDebug("✅ Room encontrado:", roomData.identifier)
			return roomData
		end
	end
	
	printDebug("❌ Room NO encontrado")
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
