import "entities/UI/cockpit/CockpitButton"
import "entities/UI/cockpit/CockpitPointer"
import "entities/UI/cockpit/CockpitBars"
import "entities/UI/cockpit/CockpitRadar"

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
local radar      = nil

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
    radar      = nil
    resetAllSequences()

    -- bgImage = Graphics.image.new('assets/images/ui/cockpit/cockpit_background')

    playdate.startAccelerometer()

    --[[
        Central grid layout (all centers, gap=1px between elements):

        Left col (x=171): [3 18×14]  [4 18×14]  [6 22×12]
        Right col(x=246): [7 20×14]  [8 20×14]  [9 24×12]
        Bars (x=208,y=170): [BARS 50×31 horizontal] between 6 and 9
        Left panel (y=137): [1 32×48 x=100] [2 32×48 x=136]
    --]]
    local btnDefs = {
        -- left panel: two buttons aligned with central columns
        { x=26, y=140, w=32, h=48, label="1" },
        { x=74, y=140, w=32, h=48, label="2" },
        -- central grid: left column (3, 4, 6 share x=171)
        { x=166, y=200, w=24, h=16, label="3" },
        { x=166, y=220, w=24, h=16, label="4" },
        { x=166, y=180, w=24, h=16, label="6" },
        -- central grid: right column (7, 8, 9 share x=246)
        { x=246, y=200, w=24, h=16, label="7" },
        { x=246, y=220, w=24, h=16, label="8" },
        { x=246, y=180, w=24, h=16, label="9" },
        -- far right keypad
        { x=372, y=63,  w=28, h=22, label="A" },
        { x=372, y=89,  w=28, h=22, label="B" },
        { x=372, y=115, w=28, h=22, label="C" },
        { x=372, y=141, w=28, h=22, label="D" },
        -- ESC
        { x=206, y=228, w=50, h=20, label="ESC" },
    }

    for _, cfg in ipairs(btnDefs) do
        table.insert(buttons, CockpitButton(cfg.x, cfg.y, cfg.w, cfg.h, cfg.label))
    end

    bars  = CockpitBars(206, 190, 50, 31)
    radar = CockpitRadar(50, 200, 80, 60)

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

    -- D-pad moves pointer first; then re-anchor accel base so the
    -- accelerometer lerp doesn't fight the new position next frame.
    local spd   = Config.Cockpit.dpadSpeed
    local moved = false
    if playdate.buttonIsPressed(playdate.kButtonUp)    then pointerY = math.max(0,   pointerY - spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonDown)  then pointerY = math.min(240, pointerY + spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonLeft)  then pointerX = math.max(0,   pointerX - spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonRight) then pointerX = math.min(400, pointerX + spd) moved = true end

    local sens = Config.Cockpit.accelSensitivity
    if moved then
        baseAx     = ax - (pointerX - 200) / (200 * sens)
        baseAy     = ay - (pointerY - 120) / (120 * sens)
        calibrated = true
    end

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
    if radar   then radar:remove()   radar   = nil end
    if pointer then pointer:remove() pointer = nil end
end

function scene:finish()
    scene.super.finish(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end
