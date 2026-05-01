import "entities/UI/cockpit/CockpitButton"
import "entities/UI/cockpit/CockpitPointer"

CockpitScene = {}
class("CockpitScene").extends(NobleScene)
local scene = CockpitScene

scene.backgroundColor = Graphics.kColorWhite

local buttons       = {}
local pointer       = nil
local pointerX      = 200
local pointerY      = 120
local baseAx        = 0
local baseAy        = 0
local calibrated    = false

local correctSequence = { "1", "3", "2", "4" }
local sequenceIndex   = 1

local function resetPointer()
    pointerX   = 200
    pointerY   = 120
    calibrated = false
end

local function resetSequence()
    sequenceIndex = 1
end

local function pressButton(label)
    if label == correctSequence[sequenceIndex] then
        sequenceIndex += 1
        if sequenceIndex > #correctSequence then
            resetSequence()
            Noble.transition(CreditsScene, 0.3, Noble.Transition.MetroNexus)
        end
    else
        resetSequence()
    end
end

scene.inputHandler = {
    AButtonDown = function()
        for _, btn in ipairs(buttons) do
            if btn:isHovered(pointerX, pointerY) then
                if btn.label == "ESC" then
                    Noble.transition(TitleScene, 0.3, Noble.Transition.MetroNexus)
                else
                    pressButton(btn.label)
                end
                break
            end
        end
    end,
    BButtonDown = function() resetPointer() end,
}

function scene:init()
    scene.super.init(self)
end

function scene:enter()
    scene.super.enter(self)

    sequenceIndex = 1
    calibrated    = false
    baseAx      = 0
    baseAy      = 0
    pointerX    = 200
    pointerY    = 120
    buttons     = {}

    playdate.startAccelerometer()

    local btnConfigs = {
        { x=80,  y=70,  size=40, label="1"   },
        { x=320, y=70,  size=40, label="2"   },
        { x=80,  y=170, size=40, label="3"   },
        { x=320, y=170, size=40, label="4"   },
        { x=370, y=220, size=20, label="ESC" },
    }

    for _, cfg in ipairs(btnConfigs) do
        table.insert(buttons, CockpitButton(cfg.x, cfg.y, cfg.size, cfg.label))
    end

    pointer = CockpitPointer()
    pointer:add(pointerX, pointerY)
end

function scene:start()
    scene.super.start(self)
end

function scene:update()
    scene.super.update(self)

    local ax, ay, _ = playdate.readAccelerometer()
    ax = ax or 0
    ay = ay or 0

    if not calibrated and (ax ~= 0 or ay ~= 0) then
        baseAx     = ax
        baseAy     = ay
        calibrated = true
    end

    local sens    = Config.Cockpit.accelSensitivity
    local targetX = math.max(0, math.min(400, 200 + (ax - baseAx) * 200 * sens))
    local targetY = math.max(0, math.min(240, 120 + (ay - baseAy) * 120 * sens))
    local lf      = Config.Cockpit.lerpFactor
    pointerX = pointerX + (targetX - pointerX) * lf
    pointerY = pointerY + (targetY - pointerY) * lf

    if pointer then pointer:moveTo(pointerX, pointerY) end
end

function scene:drawBackground()
    scene.super.drawBackground(self)

    local barY      = 8
    local barH      = 6
    local margin    = 40
    local gap       = 2
    local segments  = #correctSequence
    local totalW    = 400 - margin * 2
    local segW      = math.floor((totalW - gap * (segments - 1)) / segments)
    local filled    = sequenceIndex - 1

    Graphics.setColor(Graphics.kColorBlack)
    for i = 1, segments do
        local x = margin + (i - 1) * (segW + gap)
        if i <= filled then
            Graphics.fillRect(x, barY, segW, barH)
        else
            Graphics.drawRect(x, barY, segW, barH)
        end
    end
end

function scene:exit()
    scene.super.exit(self)

    playdate.stopAccelerometer()

    for _, btn in ipairs(buttons) do
        btn:remove()
    end
    buttons = {}

    if pointer then pointer:remove() pointer = nil end
end

function scene:finish()
    scene.super.finish(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end
