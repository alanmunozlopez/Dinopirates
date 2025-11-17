local menuImg = Graphics.image.new('assets/images/ui/menu/menu.png')
local lampImg = Graphics.image.new('assets/images/ui/menu/lamp.png')
local radioImg = Graphics.image.new('assets/images/ui/menu/radio.png')
local notesImg = Graphics.image.new('assets/images/ui/menu/notes.png')
local crewBagImg = Graphics.image.new('assets/images/ui/menu/crewbag.png')

function playdate.gameWillPause()
	if PlayerData.isGaming == true and PlayerData.hasNotes == true then
		mapFillingAndChecking()
		drawStatusText()
		if PlayerData.hasLamp == true then
			Graphics.pushContext(menuImg)
			lampImg:draw(13, 110)
			Graphics.popContext()
		end
		if PlayerData.hasRadio == true then
			Graphics.pushContext(menuImg)
			radioImg:draw(50, 108)
			Graphics.popContext()
		end
		if PlayerData.hasBag == true then
			Graphics.pushContext(menuImg)
			crewBagImg:draw(130, 111)
			Graphics.popContext()
		end
		
		playdate.setMenuImage(menuImg)
	else
		playdate.setMenuImage(nil)
	end
end

function drawStatusText()
	Graphics.pushContext(menuImg)
	
	-- Clear the text areas first (draw white rectangles)
	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRect(80, 183, 100, 12)  -- Clear sanity text area
	Graphics.fillRect(80, 197, 100, 12)  -- Clear calories text area
	Graphics.fillRect(80, 212, 100, 12)  -- Clear steps text area
	
	local smallFont = Graphics.font.new('assets/fonts/Mini Sans')
	Graphics.setFont(smallFont)
	
	-- Draw sanity text
	local sanityText = ": " .. tostring(PlayerData.sanity)
	local caloriesText = ": " .. tostring(PlayerData.calories)
	local stepsText = ": " .. tostring(PlayerData.totalSteps)
	Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
	Graphics.drawText(sanityText, 80, 183)
	Graphics.drawText(caloriesText, 80, 197)
	Graphics.drawText(stepsText, 80, 212)
	Graphics.popContext()
end
function mapFillingAndChecking()
	-- Configuration for each floor
	local floorConfig = {
		[1] = { cols = 5, rows = 3, posX = 150, posY = 70 },  -- Level 1: 5x3
		[2] = { cols = 5, rows = 3, posX = 40, posY = 62 },  -- Level 2: 5x3
		[3] = { cols = 7, rows = 5, posX = 139, posY = 15 },  -- Level 3: 7x5 (ajusta posX/posY según tu diseño)
		[4] = { cols = 5, rows = 3, posX = 40, posY = 26 }   -- Level 4: 5x3
	}
	
	local alpha = 0.5
	local roomSize = 7
	local spacing = 6  -- Espaciado entre celdas (incluyendo el tamaño de la celda)
	
	-- Draw background grid for each floor
	for level, config in pairs(floorConfig) do
		local totalRooms = config.cols * config.rows
		
		for i = 1, totalRooms do
			local col = (i - 1) % config.cols
			local row = math.floor((i - 1) / config.cols)
			
			Graphics.pushContext(menuImg)
			Graphics.setColor(Graphics.kColorBlack)
			Graphics.setDitherPattern(alpha, Graphics.image.kDitherTypeBayer8x8)
			Graphics.fillRect(
				config.posX + (col * spacing), 
				config.posY + (row * spacing), 
				roomSize, 
				roomSize
			)
			Graphics.popContext()
		end
	end
	
	-- Safety check: ensure levelsLDTK exists
	if not levelsLDTK then
		print("⚠️  levelsLDTK not loaded")
		return
	end
	
	-- Iterate through all levels in levelsLDTK and mark visited rooms
	for _, levelData in ipairs(levelsLDTK) do
		local cf = levelData.customFields or {}
		local level = cf.level
		local roomNumber = cf.roomNumber
		local visited = cf.visited or false
		
		-- Skip if essential data is missing
		if not level or not roomNumber then
			print("⚠️  Skipping level - missing level or roomNumber")
			goto continue
		end
		
		-- Check if this floor is configured
		local config = floorConfig[level]
		if not config then
			print("⚠️  Floor", level, "not configured, skipping")
			goto continue
		end
		
		-- Calculate position in grid (roomNumber 1-15 for 5x3, 1-35 for 7x5, etc.)
		local totalRooms = config.cols * config.rows
		if roomNumber < 1 or roomNumber > totalRooms then
			print("⚠️  Room", roomNumber, "out of bounds for floor", level)
			goto continue
		end
		
		local col = (roomNumber - 1) % config.cols
		local row = math.floor((roomNumber - 1) / config.cols)
		
		-- Only draw if visited
		if visited then
			Graphics.pushContext(menuImg)
			
			-- Check if this is the player's current position
			if PlayerData.actualLevel == level and PlayerData.actualRoom == roomNumber then
				-- Mark current player position (white outline, black center)
				Graphics.setColor(Graphics.kColorWhite)
				Graphics.fillRect(
					config.posX + 1 + (col * spacing), 
					config.posY + 1 + (row * spacing), 
					5, 
					5
				)
				
				Graphics.setColor(Graphics.kColorBlack)
				Graphics.fillRect(
					config.posX + 2 + (col * spacing), 
					config.posY + 2 + (row * spacing), 
					3, 
					3
				)
			else
				-- Reveal visited room (white square)
				Graphics.setColor(Graphics.kColorWhite)
				Graphics.fillRect(
					config.posX + 1 + (col * spacing), 
					config.posY + 1 + (row * spacing), 
					5, 
					5
				)
			end
			
			Graphics.popContext()
		end
		
		::continue::
	end
end