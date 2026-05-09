import 'entities/space/Ship'
import 'entities/space/Crosshair'
import 'entities/space/FXspeed'
import 'entities/space/Meteorite'
import 'entities/space/Laser'
import 'entities/space/EnergyMeter'

SpaceScene = {}
class('SpaceScene').extends(NobleScene)
local scene = SpaceScene

scene.backgroundColor = Graphics.kColorBlack

local ship      = nil
local crosshair = nil
local fxspeed   = nil
local laser     = nil
local energy    = nil

local cursorX    = 200
local cursorY    = 120
local baseAx     = 0
local baseAy     = 0
local calibrated = false
local prevAx     = 0
local prevAy     = 0
local idleFrames = 0

local shipX = 200
local shipY = 150

function scene:init()
    scene.super.init(self)
end

function scene:enter()
    scene.super.enter(self)

    cursorX    = 200
    cursorY    = 120
    baseAx     = 0
    baseAy     = 0
    calibrated = false
    prevAx     = 0
    prevAy     = 0
    idleFrames = 0

    ship      = Ship(shipX, shipY, 4, 0, ZIndex.player)
    crosshair = Crosshair(200, 134)
    fxspeed   = FXspeed()
    laser     = Laser()
    energy    = EnergyMeter(ship)

    playdate.startAccelerometer()
end

function scene:start()
    scene.super.start(self)
end

function scene:update()
    scene.super.update(self)

    if ship == nil or ship.mode ~= 'fighter' then return end

    local ax, ay = playdate.readAccelerometer()
    ax = ax or 0
    ay = ay or 0

    if not calibrated and (ax ~= 0 or ay ~= 0) then
        baseAx     = ax
        baseAy     = ay
        calibrated = true
    end

    local accelMoving = math.abs(ax - prevAx) >= Config.Space.accelIdleThreshold
                     or math.abs(ay - prevAy) >= Config.Space.accelIdleThreshold

    local spd   = Config.Space.crosshairSpeed
    local moved = false
    if playdate.buttonIsPressed(playdate.kButtonUp)    then cursorY = math.max(0,   cursorY - spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonDown)  then cursorY = math.min(240, cursorY + spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonLeft)  then cursorX = math.max(0,   cursorX - spd) moved = true end
    if playdate.buttonIsPressed(playdate.kButtonRight) then cursorX = math.min(400, cursorX + spd) moved = true end

    local sens = Config.Space.accelSensitivity
    if moved then
        baseAx = ax - (cursorX - 200) / (200 * sens)
        baseAy = ay - (cursorY - 120) / (120 * sens)
        calibrated = true
    end

    if accelMoving or moved then
        idleFrames = 0
    else
        idleFrames = idleFrames + 1
        if idleFrames >= Config.Space.accelIdleFrames and calibrated then
            local lr = Config.Space.accelCenterReturnLerp
            baseAx = baseAx + (ax - baseAx) * lr
            baseAy = baseAy + (ay - baseAy) * lr
        end
    end
    prevAx = ax
    prevAy = ay

    local targetX = math.max(0, math.min(400, 200 + (ax - baseAx) * 200 * sens))
    local targetY = math.max(0, math.min(240, 120 + (ay - baseAy) * 120 * sens))
    local lf      = Config.Space.lerpFactor
    cursorX = cursorX + (targetX - cursorX) * lf
    cursorY = cursorY + (targetY - cursorY) * lf

    crosshair:moveTo(cursorX, cursorY)
end

function scene:exit()
    scene.super.exit(self)

    playdate.stopAccelerometer()

    if ship      then ship:remove()      ship      = nil end
    if crosshair then crosshair:remove() crosshair = nil end
    if fxspeed   then fxspeed:remove()   fxspeed   = nil end
    if laser     then laser:remove()     laser     = nil end
    if energy    then energy:remove()    energy    = nil end
end

function scene:finish()
    scene.super.finish(self)
    Graphics.setImageDrawMode(Graphics.kDrawModeCopy)
end

scene.inputHandler = {
    AButtonDown = function()
        if ship and ship.mode == 'fighter' then
            laser:draw(ship, crosshair, energy)
        end
    end,

    BButtonDown = function()
        if ship and ship.mode == 'fighter' and ship.energy > 1 then
            fxspeed.animation:setState('startSpeed')
        end
    end,
    BButtonHeld = function()
        if ship == nil or ship.mode ~= 'fighter' then return end
        if ship.energy > 0 then
            fxspeed.animation:setState('loopSpeed')
        else
            fxspeed.animation:setState('stopSpeed')
        end
    end,
    BButtonHold = function()
        if ship == nil or ship.mode ~= 'fighter' then return end
        if ship.energy > 0 then
            ship:boost('fighter')
            energy:drain(ship)
        end
        if ship.energy == 0 then
            fxspeed.animation:setState('stopSpeed')
        end
    end,
    BButtonUp = function()
        if ship == nil or ship.mode ~= 'fighter' then return end
        if ship.energy > 0 and ship.speed > 0 then
            fxspeed.animation:setState('stopSpeed')
        elseif ship.energy == 0 then
            fxspeed.animation:setState('initial')
        end
    end,

    leftButtonDown  = function() if ship then ship:move('left')    end end,
    leftButtonUp    = function() if ship then ship:move('default') end end,
    rightButtonDown = function() if ship then ship:move('right')   end end,
    rightButtonUp   = function() if ship then ship:move('default') end end,
    upButtonDown    = function() if ship then ship:move('up')      end end,
    upButtonUp      = function() if ship then ship:move('default') end end,
    downButtonDown  = function() if ship then ship:move('down')    end end,
    downButtonUp    = function() if ship then ship:move('default') end end,

    cranked = function(change, _)
        if ship and ship.mode == 'travel' and ship.energy <= 100 and playdate.getCrankTicks(3) > 0 then
            energy:fill(ship, 1)
        end
    end,

    crankDocked = function()
        if ship == nil then return end
        ship.changeMode = true
        ship.mode       = 'fighter'
        ship.animation:setState('travelToFighter')
        ship:setTarget(shipX, shipY)
        energy:resetPosition(shipX, shipY)
        calibrated = false
    end,

    crankUndocked = function()
        if ship == nil then return end
        ship.changeMode = true
        ship.mode  = 'travel'
        ship.speed = 0
        ship.animation:setState('fighterToTravel')
        ship:setTarget(shipX, shipY + 20)
        energy:resetPosition(shipX, shipY + 20)
        cursorX    = 200
        cursorY    = 120
        calibrated = false
        if crosshair then crosshair:moveTo(200, 120) end
    end,
}
