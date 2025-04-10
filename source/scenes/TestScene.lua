TestScene = {}
class("TestScene").extends(NobleScene)

--TestScene.backgroundColor = Graphics.kColorWhite

import "entities/UI/battle/buttonPress"
import "entities/UI/battle/hitZone"
import "entities/UI/battle/playerDance"


function TestScene:init()
	TestScene.super.init(self)
    bpm = 16
    ButtonPressed = nil
    buttonText = "none"
end


function TestScene:enter()
	TestScene.super.enter(self)
    
    
	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start()
    
    button = ButtonPress('aButton', bpm)
    button2 = ButtonPress('bButton', bpm)
    button3 = ButtonPress('upButton', bpm)
    button4 = ButtonPress('leftButton', bpm)
    
    hitzone = HitZone(bpm)
    playerDance = PlayerDance(bpm)
    
end

function TestScene:start()
	TestScene.super.start(self)
    
    button:movementDelay(0)
    button2:movementDelay(300)
    button3:movementDelay(600)
    button4:movementDelay(900)

end

function TestScene:drawBackground()
	TestScene.super.drawBackground(self)
    -- por alguna razon el bg no se dibuja al entrar a una escena
    local background = Graphics.image.new('assets/test/testbg.png')
	background:draw(0, 0)
end

function TestScene:update()
	TestScene.super.update(self)
    
    
    local collisions = hitzone:overlappingSprites()
    if table.getsize(collisions) > 0 then
        if ButtonPressed == nil then
            buttonText = "miss"
        elseif collisions[1].buttonKey == ButtonPressed then
            buttonText = "right"
            collisions[1]:hit()
        else
            buttonText = "wrong"
            collisions[1]:hit()
        end
        ButtonPressed = nil
    end
    
    Graphics.drawText(buttonText,300,90)
    
    
    end

function TestScene:exit()
	TestScene.super.exit(self)

	Noble.Input.setCrankIndicatorStatus(false)
	sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
	sequence:start();

end

function TestScene:finish()
	TestScene.super.finish(self)
end



TestScene.inputHandler = {

    -- A button
    --
    AButtonDown = function()			-- Runs once when button is pressed.
        -- Your code here
        ButtonPressed = "aButton"
    end,
    AButtonHold = function()			-- Runs every frame while the player is holding button down.
        -- Your code here
    end,
    AButtonHeld = function()			-- Runs after button is held for 1 second.
        -- Your code here
    end,
    AButtonUp = function()				-- Runs once when button is released.
        -- Your code here
    end,

    -- B button
    --
    BButtonDown = function()
        -- Your code here
        ButtonPressed = "bButton"
    end,
    BButtonHeld = function()
        -- Your code here
    end,
    BButtonHold = function()
        -- Your code here
    end,
    BButtonUp = function()
       
    end,

    -- D-pad left
    --
    leftButtonDown = function()
        -- Your code here
        ButtonPressed = "leftButton"
    end,
    leftButtonHold = function()
        -- Your code here
    end,
    leftButtonUp = function()
        
    end,

    -- D-pad right
    --
    rightButtonDown = function()
        -- Your code here
        ButtonPressed = "rightButton"
    end,
    rightButtonHold = function()
        -- Your code here
    end,
    rightButtonUp = function()
    end,

    -- D-pad up
    --
    upButtonDown = function()
        -- Your code here
    end,
    upButtonHold = function()
        -- Your code here
    end,
    upButtonUp = function()
    end,

    -- D-pad down
    --
    downButtonDown = function()
        -- Your code here
        ButtonPressed = "downButton"
    end,
    downButtonHold = function()
        -- Your code here
    end,
    downButtonUp = function()
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

