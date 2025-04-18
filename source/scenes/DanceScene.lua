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
    lifes = 3
    self.correctButtonPresses = {
        aButton = 0,
        bButton = 0,
        leftButton = 0,
        rightButton = 0,
        upButton = 0,
        downButton = 0
    }
    
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
    local background = Graphics.image.new('assets/test/testbg.png')
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
            self.buttonText = "right"
            self.totalAccuracy += self.accuracy
            
            -- Mark: change animation player and enemies
            playerDance:changeAnimation(self.ButtonPressed)
            
            collisions[1]:hit()
            
            self:incrementCorrectPress(self.ButtonPressed)
        else
            self.buttonText = "wrong"
            -- Mark: change animation
            
            collisions[1]:hit()
            lifes -= 1
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
    
    -- Mark: win condition
    if self.totalAccuracy > 20 then
        self.totalAccuracy = 0
        
        
        -- Find an enemy and kill it
        findAndKillEnemyById(PlayerData.lastEnemyTouched.id)
        -- captures player position and goes back to the original room
        PlayerData.playerSpawn.x = PlayerData.playerExit.x
        PlayerData.playerSpawn.y = PlayerData.playerExit.y
        
        
        self.returnRoom = RoomTranslate(PlayerData.saveLevel)
        Noble.transition(self.returnRoom, 0.5, Noble.Transition.Default)  
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

