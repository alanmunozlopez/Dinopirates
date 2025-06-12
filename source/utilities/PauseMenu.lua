local menuImg = Graphics.image.new('assets/images/ui/menu/menu.png')
local lampImg = Graphics.image.new('assets/images/ui/menu/lamp.png')
local radioImg = Graphics.image.new('assets/images/ui/menu/radio.png')
local notesImg = Graphics.image.new('assets/images/ui/menu/notes.png')
local crewBagImg = Graphics.image.new('assets/images/ui/menu/crewbag.png')

function playdate.gameWillPause()
	if PlayerData.isGaming == true and PlayerData.hasNotes == true  then
		mapFillingAndChecking()
		
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
		if PlayerData.hasNotes == true then
			Graphics.pushContext(menuImg)
			notesImg:draw(86, 111)
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

function mapFillingAndChecking()
	local alpha = 0.5
	local roomSize = 7
	local row = 0
	local col = 0
	local posX = 0
	local posY = 0
	--fills first floor
	for i = 1, 15 do
		posX = 40
		posY = 26
		col = (i - 1) % 5
		row = math.floor((i - 1) / 5)
		
		Graphics.pushContext(menuImg)
		Graphics.setColor(Graphics.kColorBlack)
		Graphics.setDitherPattern(alpha, Graphics.image.kDitherTypeBayer8x8)
		Graphics.fillRect(posX + (col * 6), posY + (row * 6), roomSize, roomSize)
		
		Graphics.popContext() 
	end
	--fills second floor
	for i = 1, 15 do
		posX = 40
		posY = 62
		col = (i - 1) % 5
		row = math.floor((i - 1) / 5)
		
		Graphics.pushContext(menuImg)
		Graphics.setColor(Graphics.kColorBlack)
		Graphics.setDitherPattern(alpha, Graphics.image.kDitherTypeBayer8x8)
		Graphics.fillRect(posX + (col * 6), posY + (row * 6), roomSize, roomSize)
		
		Graphics.popContext() 
	end
	
	function mapFillingAndChecking()
		local alpha = 0.5
		local roomSize = 7
		local posX = 0
		local posY = 0
	
		-- Fill first floor background (floor 1)
		for i = 1, 15 do
			posX = 40
			posY = 26
			local col = (i - 1) % 5
			local row = math.floor((i - 1) / 5)
	
			Graphics.pushContext(menuImg)
			Graphics.setColor(Graphics.kColorBlack)
			Graphics.setDitherPattern(alpha, Graphics.image.kDitherTypeBayer8x8)
			Graphics.fillRect(posX + (col * 6), posY + (row * 6), roomSize, roomSize)
			Graphics.popContext() 
		end
	
		-- Fill second floor background (floor 2)
		for i = 1, 15 do
			posX = 40
			posY = 62
			local col = (i - 1) % 5
			local row = math.floor((i - 1) / 5)
	
			Graphics.pushContext(menuImg)
			Graphics.setColor(Graphics.kColorBlack)
			Graphics.setDitherPattern(alpha, Graphics.image.kDitherTypeBayer8x8)
			Graphics.fillRect(posX + (col * 6), posY + (row * 6), roomSize, roomSize)
			Graphics.popContext() 
		end
	
		-- Iterate through all levels and mark visited rooms and player position
		for _, level in ipairs(levels) do
			local floor = level.floor
			local roomNumber = floor.roomNumber
	
			local col = (roomNumber - 1) % 5
			local row = math.floor((roomNumber - 1) / 5)
	
			-- Choose vertical offset depending on the floor number
			if floor.level == 1 then
				posY = 26
			elseif floor.level == 2 then
				posY = 62
			end
	
			posX = 40
	
			if floor.visited then
				Graphics.pushContext(menuImg)
	
				if PlayerData.actualLevel == floor.level and PlayerData.actualRoom == roomNumber then
					-- Mark current player position
					Graphics.setColor(Graphics.kColorWhite)
					Graphics.fillRect(posX + 1 + (col * 6), posY + 1 + (row * 6), 5, 5)
	
					Graphics.setColor(Graphics.kColorBlack)
					Graphics.fillRect(posX + 2 + (col * 6), posY + 2 + (row * 6), 3, 3)
				else
					-- Reveal visited room
					Graphics.setColor(Graphics.kColorWhite)
					Graphics.fillRect(posX + 1 + (col * 6), posY + 1 + (row * 6), 5, 5)
				end
	
				Graphics.popContext()
			end
		end
	end

end