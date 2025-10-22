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
