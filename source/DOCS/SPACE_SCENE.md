# SpaceScene

**File**: `scenes/SpaceScene.lua`  
**Entities**: `entities/space/`

Space escape sequence. The ship operates in two modes toggled by the crank: **fighter** (crank docked) for combat/evasion and **travel** (crank undocked) for energy recharge.

---

## Local State

| Variable | Type | Purpose |
|---|---|---|
| `ship` | Ship | Main ship sprite |
| `crosshair` | Crosshair | Aim reticle, active in fighter mode only |
| `fxspeed` | FXspeed | Fullscreen speed-lines VFX overlay |
| `laser` | Laser | Fullscreen laser-lines overlay |
| `energy` | EnergyMeter | Vertical energy bar HUD (+ EnergyCanister icon) |
| `dangerBar` | DangerBar | Right-edge vertical danger indicator |
| `healthDisplay` | HealthDisplay | 3-circle HP display |
| `meteoritesNear` | table | 14 foreground Meteorite sprites |
| `meteoritesFar` | table | 10 background Meteorite sprites (scale 0.6) |
| `cursorX / cursorY` | number | Current crosshair position |
| `baseAx / baseAy` | number | Accelerometer calibration baseline |
| `calibrated` | bool | Whether the accelerometer has been zeroed |
| `prevAx / prevAy` | number | Previous frame accelerometer values (idle detection) |
| `idleFrames` | number | Consecutive frames without movement (center-return) |
| `danger` | number | 0–1, fills when speed is too low |
| `health` | number | Starts at 3; reaching 0 ends the scene |
| `invFrames` | number | Invincibility frames remaining after a hit |
| `shakeFrames` | number | Screen-shake frames remaining after a hit |
| `shipX / shipY` | number | Fixed home position the ship lerps toward (200, 150) |

---

## Scene Lifecycle

### `init()`
No-op beyond `scene.super.init`.

### `enter()`
Resets all state variables. Creates all sprites and both meteorite pools. Calls `playdate.startAccelerometer()`.

Ship and EnergyMeter spawn at `(shipX, shipY) = (200, 150)`. HealthDisplay is positioned 28 px left of EnergyMeter.

### `exit()`
Calls `playdate.stopAccelerometer()`. Removes and nils every sprite. Clears both meteorite tables.

---

## Ship Modes

The crank determines which mode is active. Transitions play a frame animation before settling.

| Mode | Crank state | Ship target Y | Crosshair | Speed decay |
|---|---|---|---|---|
| `fighter` | docked | 150 | active | yes |
| `travel` | undocked | 170 (`shipY + 20`) | hidden | no |

Mode switch (crank callbacks set `ship.changeMode = true` so `Ship:update()` skips the idle animation reset for one frame):

- `crankDocked` → `ship.mode = 'fighter'`, state `travelToFighter`, recalibrate accelerometer
- `crankUndocked` → `ship.mode = 'travel'`, state `fighterToTravel`, reset cursor to center

---

## Crosshair & Accelerometer (fighter mode)

The crosshair combines D-pad input and accelerometer tilt, both lerped to `cursorX/Y`.

**Calibration**: `baseAx/baseAy` record the resting tilt. On first non-zero accelerometer read, they are set and `calibrated = true`. When D-pad moves the cursor, `baseAx/baseAy` are re-derived from current ax/ay so the cursor doesn't snap back.

**Per-frame logic:**

1. Read `ax, ay` from accelerometer.
2. Check D-pad: move cursor directly at `crosshairSpeed = 4` px/frame, then recalibrate base.
3. Check idle: if `|ax − prevAx|` and `|ay − prevAy|` are both below `accelIdleThreshold = 0.005`, increment `idleFrames`. Once `idleFrames >= accelIdleFrames = 2`, lerp `baseAx/baseAy` toward current ax/ay at `accelCenterReturnLerp = 0.04` (gradual recentering).
4. Compute target: `targetX = 200 + (ax − baseAx) × 200 × accelSensitivity`.
5. Lerp cursor: `cursorX += (targetX − cursorX) × lerpFactor = 0.08`.

---

## Speed & Danger

`ship.speed` drives how fast meteorites approach and gates the danger bar.

| Action | Effect on speed |
|---|---|
| B held (fighter) | `+1` per frame via `Ship:boost`, capped at `maxSpeed = 20` |
| Passive decay (fighter) | `−speedDecay = 0.05` per frame; floored at 0 |
| Travel mode | speed holds; no decay |

**Danger bar** fills or drains each frame in fighter mode:

```
if speed < minSpeed (3):  danger += dangerFillRate (0.002)
if speed >= minSpeed:     danger -= dangerDrainRate (0.003)
```

When `danger >= 1.0` → `Noble.transition(TitleScene)`.

The DangerBar is a 4×224 vertical bar at `(390, 120)` (right edge). Fill height = `danger × 224` px drawn bottom-up.

---

## Meteorites

Two independent pools give a parallax depth effect. Each Meteorite uses a single integer counter (0–1000) to simulate approach from deep space.

| Pool | Count | Base speed | Scale | Parallax mult |
|---|---|---|---|---|
| Near | 14 | 3 | 1.0 | 1.0× |
| Far | 10 | 1.5 | 0.6 | 0.5× |

**`Meteorite:step(extraSpeed)`** — advances `counter` by `baseSpeed + extraSpeed`. Extra speed comes from the ship: `ship.speed × meteoriteSpeedMult (0.2)`. When `counter > 1000` it wraps to 1 and repositions at a random screen coordinate.

**`Meteorite:getZDepth()`** — returns `counter / 1000` (0 = distant, 1 = at ship).

**`Meteorite:scrollBy(dx, dy)`** — D-pad applies parallax offset. Near meteorites scroll at `parallaxSpeed = 3`; far at `parallaxSpeed × meteoriteFarParallax = 1.5`.

The displayed animation frame is derived from `counter / 1000 × frameCount` — as counter grows, a later frame is shown, making the meteorite appear to grow and approach.

---

## Collision Detection

Checked every frame when `invFrames == 0`:

```
ship:overlappingSprites()
  for each overlapping sprite:
    if sprite is in meteoritesNear or meteoritesFar:
      if meteorite:getZDepth() >= collisionZoneStart (0.90):
        HIT
```

Meteorites below 90% of their approach counter are visually present but cannot deal damage — the depth gate prevents unfair hits when they first appear on screen.

**On hit:**
- `health -= 1`
- `invFrames = 60` — no collision checks for 60 frames
- `shakeFrames = 25` — shake starts
- `healthDisplay:setHealth(health)` — removes circles right-to-left
- If `health <= 0` → `Noble.transition(TitleScene)`

**Shake:** each frame while `shakeFrames > 0`, ship is nudged by `math.random(-mag, mag)` where `mag` decays linearly from `shakeMagnitude (6)` to 0.

---

## Laser

`Laser:draw(ship, crosshair, energy)` — fires from 4 shooter points on the ship toward the crosshair.

**Shooter positions** (relative to ship home at 200, 150):

| Point | Offset |
|---|---|
| shooter01 | x − 28, y − 8 |
| shooter02 | x + 28, y − 8 |
| shooter03 | x − 28, y + 8 |
| shooter04 | x + 28, y + 8 |

**D-pad lean while firing**: if Left is held, `modY = 8, modX = 2` shifts the shooter Y offsets, angling the beam bundle. Right held is the opposite.

**Procedure:**
1. Draws 4 white 1px lines on a 400×240 fullscreen image sprite.
2. `playdate.timer.performAfterDelay(6)` → clears the image, drains `ship.energy -= 10`, calls `energy:updateEnergy(ship)`.

Can't fire if `ship.energy <= 0`.

---

## Energy System

`ship.energy` starts at 100, max 100.

| Action | Change |
|---|---|
| Laser shot (A button) | −10, applied after 6 ms delay |
| Boost (B held, fighter) | −1 per frame |
| Crank (travel mode, ≥3 ticks/detent) | +1 per tick |

**EnergyMeter**: a vertical bar (8×42 px) at `shipX − 48, shipY − 12`. Fill height = `(energy / energyTotal) × 42`. Lerps to follow the ship at `shipMoveLerp = 0.12` each frame.

`EnergyMeter:drain(ship)` — called each frame B is held; applies a small random shake (±1 px) to bar + canister, then updates fill.

`EnergyMeter:fill(ship, amount)` — called per crank tick in travel mode; rotates bar ±10° randomly as tactile feedback, increments `ship.energy`.

`EnergyMeter:resetPosition(shipX, shipY)` — resets position and rotation on mode switch.

**EnergyCanister**: decorative static image (`assets/images/ui/EnergyTank`, flipped Y) positioned alongside EnergyMeter.

**HealthDisplay**: three 8×8 circle sprites stacked 8 px apart at `EnergyMeter.xPos − 28`. `setHealth(n)` removes circles from top down as health decreases. Not a NobleSprite — it's a plain manager that owns three `Graphics.sprite` instances.

---

## UI Layout

| Entity | Position | ZIndex | Notes |
|---|---|---|---|
| Meteorite (far ×10) | random | ZIndex.props | Scale 0.6 |
| Meteorite (near ×14) | random | ZIndex.props | Scale 1.0 |
| Ship | 200, 150 (lerped) | ZIndex.player | 80×60, collide rect 20,10,40,40 |
| Crosshair | cursorX, cursorY | ZIndex.player − 1 | Fighter mode only |
| FXspeed | 200, 120 | ZIndex.fx | 400×240 overlay |
| Laser | 200, 120 | ZIndex.ui | 400×240 overlay |
| EnergyMeter | shipX−48, shipY−12 | ZIndex.ui + 1 | Vertical bar |
| EnergyCanister | alongside EnergyMeter | ZIndex.ui + 2 | Tank icon |
| HealthDisplay circles | EnergyMeter.xPos−28, EnergyMeter.yPos | ZIndex.ui + 2 | 3 circles, 8 px apart |
| DangerBar | 390, 120 | ZIndex.ui + 5 | 4×224, right edge |

---

## Ship Animations (`ship-table-80-60.png`)

| State | Frame(s) | Notes |
|---|---|---|
| `fighter` | 9 | Default fighter idle |
| `travel` | 5 | Default travel idle |
| `fighterup` | 3 | D-pad up, fighter |
| `fighterdown` | 4 | D-pad down, fighter |
| `fighterleft` | 15 | D-pad left, fighter |
| `fighterright` | 14 | D-pad right, fighter |
| `travelup` | 1 | D-pad up, travel |
| `traveldown` | 2 | D-pad down, travel |
| `travelToFighter` | 5 → 9 | Transition, speed 3 → loops `fighter` |
| `fighterToTravel` | 9 → 13 | Transition, speed 3 → loops `travel` |

`Ship:move('default')` returns to the mode's idle state only when direction actually changed (tracked via `lastDirection`).

---

## FXspeed Animations (`fx-speed-table-400-240.png`)

| State | Frames | frameDuration | Next |
|---|---|---|---|
| `initial` | 1 | — | — |
| `startSpeed` | 1–8 | 2 | — |
| `loopSpeed` | 9–14 | 4 | — |
| `stopSpeed` | 15–22 | 4 | → `initial` |

B button triggers: `startSpeed` on BButtonDown → `loopSpeed` on BButtonHeld → `stopSpeed` on BButtonUp (or energy depleted).

---

## Input

| Input | Mode | Effect |
|---|---|---|
| A down | fighter | Fire laser toward crosshair |
| B down | fighter | `startSpeed` animation |
| B held >1 s | fighter | `loopSpeed` + `ship:boost` + `energy:drain` each frame |
| B up | fighter | `stopSpeed` (if speed > 0 and energy > 0) or `initial` |
| D-pad | fighter | Move crosshair + meteorite parallax |
| D-pad | travel | Meteorite parallax only |
| Crank (≥3 ticks) | travel | `energy:fill(ship, 1)` per tick |
| Crank docked | any | Switch to fighter mode |
| Crank undocked | any | Switch to travel mode |

---

## Outcomes

| Condition | Result |
|---|---|
| `danger >= 1.0` | `Noble.transition(TitleScene)` |
| `health <= 0` | `Noble.transition(TitleScene)` |

There is no win condition in the current implementation.

---

## Config Reference (`Config.Space`)

| Key | Value | Purpose |
|---|---|---|
| `crosshairSpeed` | 4 | D-pad cursor px/frame |
| `lerpFactor` | 0.08 | Cursor lerp toward accel target |
| `accelSensitivity` | 1.2 | Accelerometer tilt multiplier |
| `shipMoveLerp` | 0.12 | Ship & EnergyMeter position lerp |
| `accelIdleThreshold` | 0.005 | Min Δ acceleration to count as moving |
| `accelIdleFrames` | 2 | Frames idle before center-return starts |
| `accelCenterReturnLerp` | 0.04 | Rate at which baseline drifts to center |
| `speedDecay` | 0.05 | Speed lost per frame in fighter mode |
| `maxSpeed` | 20 | Boost speed cap |
| `minSpeed` | 3 | Below this, danger bar fills |
| `dangerFillRate` | 0.002 | Danger increase per frame when slow |
| `dangerDrainRate` | 0.003 | Danger decrease per frame when fast |
| `meteoriteNearCount` | 14 | Foreground pool size |
| `meteoriteFarCount` | 10 | Background pool size |
| `meteoriteNearSpeed` | 3 | Foreground base approach speed |
| `meteoriteFarSpeed` | 1.5 | Background base approach speed |
| `meteoriteSpeedMult` | 0.2 | Ship speed → meteorite extra speed |
| `parallaxSpeed` | 3 | D-pad meteorite scroll px/frame |
| `meteoriteFarParallax` | 0.5 | Far pool parallax multiplier |
| `meteoriteFarScale` | 0.6 | Far pool sprite scale |
| `invincibilityFrames` | 60 | Post-hit immunity frames |
| `collisionZoneStart` | 0.90 | Min Z-depth for a live collision |
| `shakeFrames` | 25 | Duration of hit shake |
| `shakeMagnitude` | 6 | Max px offset at shake start |
