# SpaceScene

Space mini-game scene. Player controls a ship with a crosshair cursor, fires lasers, and manages energy via the crank.

## Scene Lifecycle

`SpaceScene` follows standard Noble Engine lifecycle: `init → enter → start → update → exit`.

- `enter()` — spawns all entities, starts accelerometer
- `update()` — reads accelerometer, moves crosshair via lerp (fighter mode only)
- `exit()` — removes all entities, stops accelerometer

## Entities

| Entity | File | Role |
|--------|------|------|
| `Ship` | `entities/space/Ship.lua` | NobleSprite — animated ship, two-mode system |
| `Crosshair` | `entities/space/Crosshair.lua` | Graphics.sprite — cursor, positioned by scene |
| `FXspeed` | `entities/space/FXspeed.lua` | NobleSprite — full-screen speed effect |
| `Meteorite` | `entities/space/Meteorite.lua` | NobleSprite — scrolling meteorite obstacle |
| `Laser` | `entities/space/Laser.lua` | Graphics.sprite — procedural laser lines |
| `EnergyMeter` | `entities/space/EnergyMeter.lua` | Graphics.sprite — energy bar (owns EnergyCanister) |

## Crank Mode System

The crank controls the ship's mode:

| Crank | Mode | Behavior |
|-------|------|----------|
| Docked | `fighter` | Crosshair active, laser fires, boost available |
| Undocked | `travel` | Crosshair locked at center, crank fills energy |

Mode changes set `ship.changeMode = true` to suppress Ship:update() animation transitions for one frame (prevents interrupting the mode-switch animation).

## Crosshair Movement

Position is owned entirely by `SpaceScene:update()` — the Crosshair entity is a thin sprite.

In fighter mode each frame:
1. D-pad moves `cursorX`/`cursorY` directly (`Config.Space.crosshairSpeed` px/frame)
2. When d-pad moves, the accelerometer base is re-anchored so the lerp doesn't fight the new position
3. Accelerometer target computed as `200 + (ax - baseAx) * 200 * sensitivity`
4. `cursorX` lerps toward the accel target at `Config.Space.lerpFactor` per frame — produces a spring-back-to-center effect when device is flat

In travel mode the crosshair is locked at (200, 120) and the update returns early.

## Energy System

- `ship.energy` starts at 100, max 100
- **Fighter mode:** A button fires laser (costs 10 energy per shot via 6ms timer). B hold boosts speed (costs 1/frame).
- **Travel mode:** Crank rotation fills energy by 1 per crank tick (3-tick threshold).
- `EnergyMeter` displays a vertical bar. `EnergyCanister` is a decorative sprite attached to the meter.

## Config

All tunable values in `Config.Space`:

```lua
Config.Space = {
    crosshairSpeed   = 4,    -- d-pad pixels per frame
    lerpFactor       = 0.08, -- spring smoothing (0=frozen, 1=instant)
    accelSensitivity = 1.2,  -- multiplier on raw accelerometer tilt
}
```
