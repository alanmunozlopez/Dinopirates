DanceScene = {}
class("DanceScene").extends(NobleScene)
local scene = DanceScene
scene.backgroundColor = Graphics.kColorBlack

import "entities/UI/battle/buttonPress"
import "entities/UI/battle/hitZone"
import "entities/UI/battle/playerDance"
import "entities/UI/battle/backgroundDance"
import "entities/UI/battle/enemyDance"
import "entities/UI/battle/buttonCover"
import "entities/UI/battle/lifes"

local lifes = nil

function scene:init()
	scene.super.init(self)
    
    self.bpm = 16
    self.ButtonPressed = nil
    self.buttonText = "none"
    self.accuracy = 0
    self.totalAccuracy = 0
    self.enemyHP = 100
    self.evadePower = 30
    
    lifes = 3
    
    self.correctButtonPresses = {
        aButton = 0,
        bButton = 0,
        leftButton = 0,
        rightButton = 0,
        upButton = 0,
        downButton = 0
    }
    
    self.balancePosition = 0 -- rango -max a +max
    self.balanceMaxOffset = 50
    
end


function scene:enter()
	scene.super.enter(self)
    local startPoint = 400
	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start()
    --
    button = ButtonPress(self.bpm,startPoint+self.bpm)
    button2 = ButtonPress(self.bpm,startPoint+self.bpm)
    button3 = ButtonPress(self.bpm,startPoint+self.bpm)
    button4 = ButtonPress(self.bpm,startPoint+self.bpm)
    -- 
    hitzone = HitZone(40,30, self.bpm)
    playerDance = PlayerDance(self.bpm)
    enemyDance = EnemyDance(self.bpm)
    hearts = Lifes(50,60)
    buttonCover = ButtonCover()
    backgroundDance = BackgroundDance()
end

function scene:start()
	scene.super.start(self)
    
    button:movementDelay(0)
    button2:movementDelay(300)
    button3:movementDelay(600)
    button4:movementDelay(900)

end

function scene:drawBackground()
	scene.super.drawBackground(self)
    -- local background = Graphics.image.new('assets/test/roomBg.png')
	background:draw(0, 0)
end

function scene:update()
	scene.super.update(self)
    
    
    local collisions = hitzone:overlappingSprites()
    if table.getsize(collisions) > 0 then
        if self.ButtonPressed == nil then
            
            self.accuracy += 1
            self.buttonText = "miss"
            
        elseif collisions[1].buttonKey == self.ButtonPressed then
            
            if self.ButtonPressed == "aButton" or self.ButtonPressed == "bButton" then
                print(self.ButtonPressed .. " punch")
                self.enemyHP -= 10
                self.balancePosition += 5 -- punch empuja fuerte hacia la derecha
            elseif self.ButtonPressed == "leftButton" or self.ButtonPressed == "rightButton" or self.ButtonPressed == "downButton" or self.ButtonPressed == "upButton" then
                print("evade")
                self.balancePosition += 1 
                self.totalAccuracy += self.accuracy
                self.evadePower = self.totalAccuracy-- evade empuja más débilmente
            end
            
            -- Mark: change animation player and enemies
            playerDance:changeAnimation(self.ButtonPressed)
            
            collisions[1]:hit()
            
            self:incrementCorrectPress(self.ButtonPressed)
        else
            self.buttonText = "wrong"
            collisions[1]:hit()
            lifes -= 1
            self.balancePosition -= 5 -- fallo empuja fuerte hacia la izquierda
        end
        self.ButtonPressed = nil
    else
        self.accuracy = 0
    end
    
    hearts:checkHealth(lifes)
    
    
    -- Mark: debug rendering
    debugTextX = 240
    if debug == true then
        
        Graphics.drawText(PlayerData.lastEnemyTouched.id,debugTextX,30)
        Graphics.drawText(PlayerData.lastEnemyTouched.type,debugTextX+30,30)
        Graphics.drawText(lifes,debugTextX,50)
        Graphics.drawText(self.buttonText,debugTextX,70)
        Graphics.drawText(self.accuracy,debugTextX,90)
        Graphics.drawText(self.totalAccuracy,debugTextX,110)
        
        local y = 130
        for btn, count in pairs(self.correctButtonPresses) do
            Graphics.drawText(btn .. ": " .. count, debugTextX, y)
            y += 15
        end
    end
    
    
    -- Mark: lose condition
    if self.lifes == 0 then
        
    end
    
    if self.evadePower == 0 then
        
    end
    
    -- Mark: win condition TEST
    if self.totalAccuracy > 20 and debug==true then
        self.totalAccuracy = 0
        
        
        -- Find an enemy and kill it
        findAndKillEnemyById(PlayerData.lastEnemyTouched.id)
        -- captures player position and goes back to the original room
        PlayerData.playerSpawn.x = PlayerData.playerExit.x
        PlayerData.playerSpawn.y = PlayerData.playerExit.y
        
        -- transition to the original room
        self.returnRoom = RoomTranslate(PlayerData.saveLevel)
        Noble.transition(self.returnRoom, 0.5, Noble.Transition.Default)  
    end
   
   -- Balance bar: player life vs enemy HP
   local screenCenterX = 200 -- assuming 400px wide screen
   local barWidth = 20
   local barHeight = 10
   local barY = 50
   
   -- Normalize values (assume max enemy HP = 100, max lifes = 3)
   local enemyFactor = (100 - self.enemyHP) / 100 -- closer to 1 as enemy weakens
   local playerFactor = (3 - lifes) / 3           -- closer to 1 as player weakens
   
   -- Calculate final X offset: enemyFactor pulls right, playerFactor pulls left
   local balanceOffset = (enemyFactor - playerFactor) * 50 -- range -50 to +50
   
   -- Clamp to -50, +50
   balanceOffset = math.max(-50, math.min(50, balanceOffset))
   
   -- Draw anchors as images instead of circles
   if not self.winIcon then
       self.winIcon = Graphics.image.new(12, 12, Graphics.kColorWhite)
       Graphics.pushContext(self.winIcon)
           Graphics.setColor(Graphics.kColorBlack)
           Graphics.fillCircleAtPoint(6, 6, 6)
       Graphics.popContext()
   end
   
   if not self.loseIcon then
       self.loseIcon = Graphics.image.new(12, 12, Graphics.kColorWhite)
       Graphics.pushContext(self.loseIcon)
           Graphics.setColor(Graphics.kColorBlack)
           Graphics.fillRect(2, 2, 8, 8)
       Graphics.popContext()
   end
   
   self.winIcon:draw(screenCenterX + 50 - 6, barY + barHeight / 2 - 6)
   self.loseIcon:draw(screenCenterX - 50 - 6, barY + barHeight / 2 - 6)
   
   -- Generate balance bar image if needed
   if not self.balanceBarImage then
       self.balanceBarImage = Graphics.image.new(barWidth, barHeight, Graphics.kColorClear)
       Graphics.pushContext(self.balanceBarImage)
           Graphics.setColor(Graphics.kColorBlack)
           Graphics.fillRoundRect(0, 0, barWidth, barHeight, 2)
       Graphics.popContext()
   end
   -- Clamp balancePosition to max range
   self.balancePosition = math.max(-self.balanceMaxOffset, math.min(self.balanceMaxOffset, self.balancePosition))
   local balanceOffset = self.balancePosition
   -- Draw the image-based bar instead of fillRect
   self.balanceBarImage:draw(screenCenterX + balanceOffset - barWidth / 2, barY)
   
   -- Check win or lose condition based on position
   if self.balancePosition >= self.balanceMaxOffset then
       print("win")
   end
   
   if self.balancePosition <= -self.balanceMaxOffset then
       print("lose")
   end
    
end

function scene:exit()
	scene.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();
    SaveSystem.save()
end

function scene:finish()
	scene.super.finish(self)
end

function scene:incrementCorrectPress(button)
    if self.correctButtonPresses[button] ~= nil then
        self.correctButtonPresses[button] += 1
    end
end
function scene:clearButton()
    self.ButtonPressed = nil
end
function scene:danceStep(inputStep)
    self.ButtonPressed = inputStep
end

scene.inputHandler = {

    -- A button
    --
    AButtonDown = function()			-- Runs once when button is pressed.
        -- Your code here
        scene:danceStep("aButton")
    end,
    AButtonHold = function()			-- Runs every frame while the player is holding button down.
        -- Your code here
    end,
    AButtonHeld = function()			-- Runs after button is held for 1 second.
        -- Your code here
    end,
    AButtonUp = function()				-- Runs once when button is released.
        -- Your code here
        scene:clearButton()
    end,

    -- B button
    --
    BButtonDown = function()
        -- Your code here
        scene:danceStep("bButton")
    end,
    BButtonHeld = function()
        -- Your code here
    end,
    BButtonHold = function()
        -- Your code here
    end,
    BButtonUp = function()
       scene:clearButton()
    end,

    -- D-pad left
    --
    leftButtonDown = function()
        -- Your code here
        scene:danceStep("leftButton")
    end,
    leftButtonHold = function()
        -- Your code here
    end,
    leftButtonUp = function()
        scene:clearButton()
    end,

    -- D-pad right
    --
    rightButtonDown = function()
        -- Your code here
        scene:danceStep("rightButton")
    end,
    rightButtonHold = function()
        -- Your code here
    end,
    rightButtonUp = function()
        scene:clearButton()
    end,

    -- D-pad up
    --
    upButtonDown = function()
        -- Your code here
        scene:danceStep("upButton")
    end,
    upButtonHold = function()
        -- Your code here
    end,
    upButtonUp = function()
        scene:clearButton()
    end,

    -- D-pad down
    --
    downButtonDown = function()
        -- Your code here
        scene:danceStep("downButton")
    end,
    downButtonHold = function()
        -- Your code here
    end,
    downButtonUp = function()
        scene:clearButton()
    end,

    -- Crank
    --
    cranked = function(change, acceleratedChange)	-- Runs when the crank is rotated. See Playdate SDK documentation for details.
        -- Your code here
    end,
    crankDocked = function()						-- Runs once when when crank is docked.
        -- Your code here
    end,
    crankUndocked = function()						-- Runs once when when crank is undocked.
        -- Your code here
    end
}

