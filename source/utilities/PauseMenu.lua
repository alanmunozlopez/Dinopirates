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
			lampImg:draw(13, 168)
			Graphics.popContext()
		end
		if PlayerData.hasBag == true then
			Graphics.pushContext(menuImg)
			crewBagImg:draw(22, 139)
			Graphics.popContext()
		end
		
		playdate.setMenuImage(menuImg)
	else
		playdate.setMenuImage(nil)
	end
end

local function formatNumberK(n)
	if n >= 1000000 then
		return string.format("%.1fM", n / 1000000):gsub("%.0M", "M")
	elseif n >= 1000 then
		return string.format("%.1fk", n / 1000):gsub("%.0k", "k")
	else
		return tostring(n)
	end
end

function drawStatusText()
	local xPos = 160
	local yPos = 128
	Graphics.pushContext(menuImg)
	
	-- Clear text areas
	Graphics.setColor(Graphics.kColorWhite)
	Graphics.fillRect(xPos, yPos, 100, 12)
	Graphics.fillRect(xPos, yPos + 12, 100, 12)
	Graphics.fillRect(xPos, yPos + 25, 100, 12)
	
	local smallFont = Graphics.font.new('assets/fonts/Mini Sans')
	Graphics.setFont(smallFont)
	
	-- Apply formatting to steps
	local sanityText = ": " .. tostring(PlayerData.sanity)
	local caloriesText = ": " .. tostring(PlayerData.calories)
	local stepsText = ": " .. formatNumberK(PlayerData.totalSteps)

	Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
	Graphics.drawText(sanityText, xPos, yPos)
	Graphics.drawText(caloriesText, xPos, yPos + 12)
	Graphics.drawText(stepsText, xPos, yPos + 25)

	Graphics.popContext()
end

function mapFillingAndChecking()
	-- Configuration for each floor
	local floorConfig = {
		[1] = { cols = 5, rows = 3, posX = 150, posY = 70, startRoom = 66 },  -- Level 4: 5x3 from room_66 to room_80
		[2] = { cols = 7, rows = 5, posX = 139, posY = 15, startRoom = 31 },  -- Level 3: 7x5 from room_31 to room_65
		[3] = { cols = 5, rows = 3, posX = 40, posY = 62, startRoom = 16 },  -- Level 2: 5x3 from room_16 to room_30
		[4] = { cols = 5, rows = 3, posX = 40, posY = 26, startRoom = 1 }   -- Level 1: 5x3 from room_1 to room_15
	}
	
	local alpha = 0.5
	local roomSize = 7
	local spacing = 6  
	
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
		
		-- Calculate position in grid relative to the floor's starting room
		local totalRooms = config.cols * config.rows
		local roomIndexOnFloor = roomNumber - config.startRoom
		
		if roomIndexOnFloor < 0 or roomIndexOnFloor >= totalRooms then
			print("⚠️  Room", roomNumber, "out of bounds for floor", level)
			goto continue
		end
		
		local col = roomIndexOnFloor % config.cols
		local row = math.floor(roomIndexOnFloor / config.cols)
		
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