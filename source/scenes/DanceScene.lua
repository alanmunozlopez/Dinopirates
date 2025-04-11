DanceScene = {}
class("DanceScene").extends(NobleScene)
local scene = DanceScene
--scene.backgroundColor = Graphics.kColorWhite

import "entities/UI/battle/buttonPress"
import "entities/UI/battle/hitZone"
import "entities/UI/battle/playerDance"


function scene:init()
	scene.super.init(self)
    
    bpm = 16
    self.ButtonPressed = nil
    self.buttonText = "none"
    self.accuracy = 0
    self.totalAccuracy = 0
    
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

	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start()
    
    button = ButtonPress('aButton', self.bpm)
    button2 = ButtonPress('bButton', self.bpm)
    button3 = ButtonPress('upButton', self.bpm)
    button4 = ButtonPress('leftButton', self.pm)
    -- 
    hitzone = HitZone(self.bpm)
    playerDance = PlayerDance(self.bpm)
    
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
            
            collisions[1]:hit()
            self:incrementCorrectPress(self.ButtonPressed)
        else
            self.buttonText = "wrong"
            collisions[1]:hit()
        end
        self.ButtonPressed = nil
    else
        self.accuracy = 0
    end
    
    Graphics.drawText(self.buttonText,290,70)
    Graphics.drawText(self.accuracy,290,90)
    Graphics.drawText(self.totalAccuracy,290,110)
    
    local y = 130
    for btn, count in pairs(self.correctButtonPresses) do
        Graphics.drawText(btn .. ": " .. count, 290, y)
        y += 15
    end
end

function scene:exit()
	scene.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();

end

function scene:finish()
	scene.super.finish(self)
end

function scene:incrementCorrectPress(button)
    print("Incrementing correct press for:", button)
    if self.correctButtonPresses[button] ~= nil then
        self.correctButtonPresses[button] += 1
    end
end
function scene:clearButton()
    print("clear button press")
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

