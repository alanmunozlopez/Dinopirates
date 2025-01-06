local menuImg = Graphics.image.new('assets/images/ui/menu/menu.png')
local lampImg = Graphics.image.new('assets/images/ui/menu/lamp.png')
local radioImg = Graphics.image.new('assets/images/ui/menu/radio.png')
local notesImg = Graphics.image.new('assets/images/ui/menu/notes.png')

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
	
	for i = 1, 15 do 
		
			posX = 40
			posY = 26
			
		-- mark the position where the player actually is
		if levels[i] ~= nil then
			if levels[i].floor.visited == true and PlayerData.actualLevel == levels[i].floor.level and PlayerData.actualRoom == levels[i].floor.roomNumber and i == levels[i].floor.roomNumber then
				col = (i - 1) % 5 --(01234)
				row = math.floor((i - 1) / 5) --(012)
				
				Graphics.pushContext(menuImg)
				
				Graphics.setColor(Graphics.kColorWhite)
				Graphics.fillRect(posX + 1 + (col * 6), posY + 1 + (row * 6), 5, 5)
				
				Graphics.setColor(Graphics.kColorBlack)
				
				Graphics.fillRect(posX + 2 + (col * 6), posY + 2 + (row * 6), 3, 3)
				
				Graphics.popContext() 
				
			-- clear the fog of a previously visited room		
			elseif levels[i].floor.visited == true and i == levels[i].floor.roomNumber then
				
				col = (i - 1) % 5
				row = math.floor((i - 1) / 5)
				
				Graphics.pushContext(menuImg)
				Graphics.setColor(Graphics.kColorWhite)
				Graphics.fillRect(posX + 1 + (col * 6), posY + 1 + (row * 6), 5, 5)
				
				Graphics.popContext() 
			
			end
		end
	
	end
end