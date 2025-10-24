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
function FindRoomByIid(iid)
	print("🔍 Buscando room con iid:", iid)
	for i, room in ipairs(levelsLDTK) do
		if room.uniqueIdentifer == iid then
			print("✅ Room encontrado:", room.identifier)
			return room
		end
	end
	print("❌ Room NO encontrado con iid:", iid)
	return nil
end
function ConvertLDTKDirection(dir)
	print("🧭 Convirtiendo dirección:", dir)
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
	print("   → Resultado:", result)
	return result
end

function CalculateLeadsTo(currentLevel, currentRoomNumber, direction, neighborRoom)
	print("🎯 Calculando leadsTo:")
	print("   Current Level:", currentLevel)
	print("   Current Room:", currentRoomNumber)
	print("   Direction:", direction)
	
	local fullCurrentRoom = currentLevel * 100 + currentRoomNumber
	print("   Full Current Room:", fullCurrentRoom)
	
	local result
	if direction == ">" then
		-- Piso superior: 120 -> 220
		result = (currentLevel + 1) * 100 + currentRoomNumber
		print("   → Escalera ARRIBA a:", result)
	elseif direction == "<" then
		-- Piso inferior: 120 -> 020
		result = (currentLevel - 1) * 100 + currentRoomNumber
		print("   → Escalera ABAJO a:", result)
	else
		-- Puerta normal: usa el level y roomNumber del vecino
		if neighborRoom then
			local neighborLevel = neighborRoom.customFields.level or 1
			local neighborRoomNum = neighborRoom.customFields.roomNumber or 0
			result = neighborLevel * 100 + neighborRoomNum
			print("   → Puerta NORMAL a:", result, "(nivel:", neighborLevel, "room:", neighborRoomNum, ")")
		else
			print("   ⚠️  neighborRoom es nil, no se puede calcular")
			result = fullCurrentRoom -- Fallback a la misma habitación
		end
	end
	return result
end

function CreateDoorsFromLDTK(currentRoom)
	print("🚪 ===== CREANDO PUERTAS =====")
	print("📍 Room actual:", currentRoom.identifier)
	
	local neighbourLevels = currentRoom.neighbourLevels
	if neighbourLevels == nil or #neighbourLevels == 0 then
		print("⚠️  No hay neighbourLevels en esta habitación")
		return
	end
	
	print("📊 Total de vecinos:", #neighbourLevels)
	
	local currentLevel = currentRoom.customFields.level or 1
	local currentRoomNumber = currentRoom.customFields.roomNumber or 0
	local doorsConnection = currentRoom.customFields.DoorsConnection or {}
	
	print("🏢 Nivel actual:", currentLevel, "| Habitación:", currentRoomNumber)
	print("🔑 Puertas permitidas:", table.concat(doorsConnection, ", "))
	
	for i, neighbor in ipairs(neighbourLevels) do
		print("")
		print("--- Procesando vecino", i, "---")
		print("   levelIid:", neighbor.levelIid)
		print("   dir:", neighbor.dir)
		
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
			print("🚫 Puerta NO permitida (no está en DoorsConnection):", direction)
		else
			print("✅ Puerta permitida:", direction)
			
			local neighborRoom = FindRoomByIid(neighbor.levelIid)
			
			-- Para escaleras (> y <), no necesitamos que el vecino exista
			if neighbor.dir == ">" or neighbor.dir == "<" then
				print("⚡ Es una ESCALERA, no se requiere vecino cargado")
				
				local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, neighbor.dir, nil)
				local open = "open"
				
				print("🔧 Creando escalera:")
				print("   direction:", direction)
				print("   open:", open)
				print("   leadsTo:", leadsTo)
				print("   ZIndex:", ZIndex.props)
				
				-- Crea la escalera
				Door(direction, open, leadsTo, ZIndex.props)
				print("✅ Escalera creada exitosamente")
				
			elseif neighborRoom then
				print("✅ Vecino encontrado:", neighborRoom.identifier)
				
				local leadsTo = CalculateLeadsTo(currentLevel, currentRoomNumber, neighbor.dir, neighborRoom)
				local open = "open"
				
				print("🔧 Creando puerta:")
				print("   direction:", direction)
				print("   open:", open)
				print("   leadsTo:", leadsTo)
				print("   ZIndex:", ZIndex.props)
				
				-- Crea la puerta
				Door(direction, open, leadsTo, ZIndex.props)
				print("✅ Puerta creada exitosamente")
			else
				print("⚠️  ADVERTENCIA: Vecino no cargado (probablemente la habitación no existe aún)")
			end
		end
	end
	
	print("🚪 ===== FIN CREACIÓN PUERTAS =====")
	print("")
end

function GetRoomByNumber(roomNumber)
	local level = math.floor(roomNumber / 100)
	local room = roomNumber % 100
	
	print("🔍 Buscando room por número:", roomNumber, "(nivel:", level, "room:", room, ")")
	
	for _, roomData in ipairs(levelsLDTK) do
		if roomData.customFields.level == level and 
		   roomData.customFields.roomNumber == room then
			print("✅ Room encontrado:", roomData.identifier)
			return roomData
		end
	end
	
	print("❌ Room NO encontrado")
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
		print("⚠️ No entities found in room:", room)
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
						print("💀 Enemy killed:", enemyId, "in", entityType)
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
		print("⚠️ No entities found in room:", room)
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
function printDebug(value)
	if debug == true then 
		print(value)
	end
end
function printEnemies()
	for i, enemy in pairs(playdate.graphics.sprite.getAllSprites()) do
		if enemy.type == "Enemy" then
			print("x:", enemy.x)
			print("y:", enemy.y)
			print("Type:", enemy.type)
			print("ID:", enemy.id)
			print("----")
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
	local floor = PlayerData.actualTilemap
	local x = PlayerData.x
	local y = PlayerData.y

	-- Convertir coordenadas de píxeles a coordenadas de tile
	local tileX = math.floor(x / TILE_SIZE) + 1
	local tileY = math.floor(y / TILE_SIZE) + 1

	-- Obtener referencias seguras
	local floorData = tileMapData[floor]
	if not floorData then
		print("⚠️ Piso no encontrado:", floor)
		return
	end

	local row = floorData[tileY]
	if not row then
		print(string.format("⚠️ Fuera del rango vertical (tileY=%d)", tileY))
		return
	end

	local tileNumber = row[tileX] -- this is the number
	if not tileNumber then
		print(string.format("⚠️ Fuera del rango horizontal (tileX=%d)", tileX))
		return
	end

	print(string.format("🧭 Piso %d | Tile (%d, %d) = %d", floor, tileX, tileY, tileNumber))
end
