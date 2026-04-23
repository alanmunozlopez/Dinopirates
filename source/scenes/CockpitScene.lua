import "entities/UI/cockpit/CockpitButton"
import "entities/UI/cockpit/CockpitPointer"

CockpitScene = {}
class("CockpitScene").extends(NobleScene)
local scene = CockpitScene

scene.backgroundColor = Graphics.kColorBlack

local buttons    = {}
local pointer    = nil
local pointerX   = 200
local pointerY   = 120
local lastPressed = "--"

scene.inputHandler = {
    AButtonDown = function()
        for _, btn in ipairs(buttons) do
            if btn:isHovered(pointerX, pointerY) then
                btn.action()
                break
            end
        end
    end,
}

function scene:init()
    scene.super.init(self)
end

function scene:enter()
    scene.super.enter(self)

    lastPressed = "--"
    pointerX    = 200
    pointerY    = 120
    buttons     = {}

    playdate.startAccelerometer()

    local btnConfigs = {
        { x=80,  y=70,  size=40, label="1",   action=function() lastPressed = "1"   end },
        { x=320, y=70,  size=40, label="2",   action=function() lastPressed = "2"   end },
        { x=80,  y=170, size=40, label="3",   action=function() lastPressed = "3"   end },
        { x=320, y=170, size=40, label="4",   action=function() lastPressed = "4"   end },
        { x=370, y=220, size=20, label="ESC", action=function()
            Noble.transition(TitleScene, 0.3, Noble.Transition.MetroNexus)
        end },
    }

    for _, cfg in ipairs(btnConfigs) do
        table.insert(buttons, CockpitButton(cfg.x, cfg.y, cfg.size, cfg.label, cfg.action))
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
    local sens = Config.Cockpit.accelSensitivity
    local targetX = math.max(0, math.min(400, 200 + ax * 200 * sens))
    local targetY = math.max(0, math.min(240, 120 - ay * 120 * sens))
    local lf = Config.Cockpit.lerpFactor
    pointerX = pointerX + (targetX - pointerX) * lf
    pointerY = pointerY + (targetY - pointerY) * lf

    pointer:moveTo(pointerX, pointerY)
end

function scene:drawBackground()
    scene.super.drawBackground(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)
    Graphics.drawTextAligned(lastPressed, 200, 120, kTextAlignment.center)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
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
