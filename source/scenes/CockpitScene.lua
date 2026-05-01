import "entities/UI/cockpit/CockpitButton"
import "entities/UI/cockpit/CockpitPointer"
import "entities/UI/cockpit/CockpitBars"

CockpitScene = {}
class("CockpitScene").extends(NobleScene)
local scene = CockpitScene

scene.backgroundColor = Graphics.kColorWhite

local buttons    = {}
local bars       = nil
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
        pattern = { "A", "B", "C", "D" },
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
    bars       = nil
    resetAllSequences()

    -- bgImage = Graphics.image.new('assets/images/ui/cockpit/cockpit_background')

    playdate.startAccelerometer()

    --[[
        Central grid layout (grid top-left: x=162, y=130, gap=3):

          ColA(w=18)  ColBCD(w=50)  ColE(w=20)
        Row0(h=14): [3]  [ BARS     ]  [7]
        Row1(h=14): [4]  [ BARS     ]  [8]
        Row2(h=12):      [6:w=22][9:w=24]
    --]]
    local btnDefs = {
        -- left panel rectangles
        { x=118, y=97,  w=62, h=46, label="1" },
        { x=118, y=152, w=62, h=42, label="2" },
        -- central grid: col A
        { x=171, y=137, w=18, h=14, label="3" },
        { x=171, y=154, w=18, h=14, label="4" },
        -- central grid: col E
        { x=246, y=137, w=20, h=14, label="7" },
        { x=246, y=154, w=20, h=14, label="8" },
        -- central grid: row 2 (below bars)
        { x=190, y=170, w=22, h=12, label="6" },
        { x=222, y=170, w=24, h=12, label="9" },
        -- far right keypad
        { x=372, y=63,  w=28, h=22, label="A" },
        { x=372, y=89,  w=28, h=22, label="B" },
        { x=372, y=115, w=28, h=22, label="C" },
        { x=372, y=141, w=28, h=22, label="D" },
        -- ESC bottom-right corner
        { x=385, y=228, w=24, h=18, label="ESC" },
    }

    for _, cfg in ipairs(btnDefs) do
        table.insert(buttons, CockpitButton(cfg.x, cfg.y, cfg.w, cfg.h, cfg.label))
    end

    -- bars occupy col BCD rows 0+1: center=(208,145), w=50, h=31
    bars = CockpitBars(208, 145, 50, 31)

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

    if bars    then bars:remove()    bars    = nil end
    if pointer then pointer:remove() pointer = nil end
end

function scene:finish()
    scene.super.finish(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end
