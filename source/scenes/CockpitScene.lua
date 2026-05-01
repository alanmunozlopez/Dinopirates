import "entities/UI/cockpit/CockpitButton"
import "entities/UI/cockpit/CockpitPointer"

CockpitScene = {}
class("CockpitScene").extends(NobleScene)
local scene = CockpitScene

scene.backgroundColor = Graphics.kColorWhite

local buttons    = {}
local pointer    = nil
local pointerX   = 200
local pointerY   = 120
local baseAx     = 0
local baseAy     = 0
local calibrated = false
local bgImage    = nil

-- Add or modify entries here to create new sequences with different outcomes.
local sequences = {
    {
        pattern = { "1", "3", "2", "4" },
        action  = function() Noble.transition(CreditsScene, 0.3, Noble.Transition.MetroNexus) end,
        index   = 1,
    },
    {
        pattern = { "A", "B", "G", "5", "9" },
        action  = function() Noble.transition(TitleScene, 0.3, Noble.Transition.MetroNexus) end,
        index   = 1,
    },
}

local function resetAllSequences()
    for _, seq in ipairs(sequences) do
        seq.index = 1
    end
end

local function pressButton(label)
    for _, seq in ipairs(sequences) do
        if label == seq.pattern[seq.index] then
            seq.index += 1
            if seq.index > #seq.pattern then
                resetAllSequences()
                seq.action()
                return
            end
        else
            seq.index = 1
        end
    end
end

-- Returns the sequence currently most advanced (for the progress bar)
local function leadingSequence()
    local best = sequences[1]
    for _, seq in ipairs(sequences) do
        if seq.index > best.index then best = seq end
    end
    return best
end

local function isOverAnyButton()
    for _, btn in ipairs(buttons) do
        if btn:isHovered(pointerX, pointerY) then return true end
    end
    return false
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
    BButtonDown = function()
        pointerX   = 200
        pointerY   = 120
        calibrated = false
    end,
}

function scene:init()
    scene.super.init(self)
end

function scene:enter()
    scene.super.enter(self)

    calibrated = false
    baseAx     = 0
    baseAy     = 0
    pointerX   = 200
    pointerY   = 120
    buttons    = {}
    resetAllSequences()

    bgImage = Graphics.image.new('assets/images/ui/cockpit/cockpit_background')

    playdate.startAccelerometer()

    local btnDefs = {
        -- panel: two large left rectangles
        { x=144, y=142,  w=44, h=32, label="1" },
        { x=146, y=176, w=44, h=22, label="2" },
        -- panel: small center-left boxes
        { x=174, y=84,  w=26, h=26, label="3" },
        { x=174, y=116, w=26, h=26, label="4" },
        -- panel: three dot indicators
        { x=206, y=87,  w=16, h=16, label="A" },
        { x=222, y=87,  w=16, h=16, label="B" },
        { x=238, y=87,  w=16, h=16, label="C" },
        -- panel: center rectangles
        { x=229, y=122, w=58, h=44, label="5" },
        { x=229, y=170, w=58, h=30, label="6" },
        -- panel: right section
        { x=278, y=84,  w=28, h=26, label="7" },
        { x=289, y=127, w=46, h=46, label="8" },
        { x=281, y=170, w=34, h=26, label="9" },
        -- far right keypad
        { x=371, y=68,  w=26, h=20, label="D" },
        { x=371, y=92,  w=26, h=20, label="E" },
        { x=371, y=116, w=26, h=20, label="F" },
        { x=371, y=140, w=26, h=20, label="G" },
        -- bottom center element
        { x=208, y=202, w=28, h=22, label="ESC" },
    }

    for _, cfg in ipairs(btnDefs) do
        table.insert(buttons, CockpitButton(cfg.x, cfg.y, cfg.w, cfg.h, cfg.label))
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

    if pointer then
        pointer:moveTo(pointerX, pointerY)
        if isOverAnyButton() then
            pointer:setHover()
        else
            pointer:setIdle()
        end
    end
end

function scene:drawBackground()
    scene.super.drawBackground(self)

    if bgImage then bgImage:draw(0, 0) end

    local leading  = leadingSequence()
    local barY     = 8
    local barH     = 6
    local margin   = 40
    local gap      = 2
    local segments = #leading.pattern
    local totalW   = 400 - margin * 2
    local segW     = math.floor((totalW - gap * (segments - 1)) / segments)
    local filled   = leading.index - 1

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
    bgImage = nil

    for _, btn in ipairs(buttons) do btn:remove() end
    buttons = {}

    if pointer then pointer:remove() pointer = nil end
end

function scene:finish()
    scene.super.finish(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end
