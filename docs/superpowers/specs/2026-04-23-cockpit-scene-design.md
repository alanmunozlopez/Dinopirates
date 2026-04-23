# CockpitScene — Design Spec
Date: 2026-04-23

## Overview

A new scene representing the cockpit of a ship. The player moves a pointer with the Playdate accelerometer and presses A to activate buttons. Entry point: TitleScene debug menu. Exit: pressing A on the escape button returns to TitleScene.

---

## Files

```
source/
  scenes/
    CockpitScene.lua
  entities/UI/cockpit/
    CockpitButton.lua
    CockpitPointer.lua
```

**Modifications to existing files:**
- `source/main.lua` — add `import 'scenes/CockpitScene'`
- `source/scenes/TitleScene.lua` — add `"COCKPIT"` entry to the debug menu, same pattern as `"PLAYGROUND"`
- `source/assets/data/Config.lua` — add `Config.Cockpit` section

---

## Config.Cockpit

```lua
Config.Cockpit = {
    lerpFactor       = 0.15,   -- pointer smoothing (0=no movement, 1=instant)
    accelSensitivity = 1.0,    -- multiplier applied to raw accelerometer values
    pointerRadius    = 6,      -- circle radius in px
}
```

---

## CockpitButton (entities/UI/cockpit/CockpitButton.lua)

Extends `Graphics.sprite`.

**Constructor:** `CockpitButton(x, y, size, label, action)`
- `x, y` — center position
- `size` — side length of the square hitbox/visual (40px for placeholders, 20px for escape)
- `label` — string shown on the button (e.g. `"1"`, `"2"`, `"ESC"`)
- `action` — function called when A is pressed while pointer is hovering

**Drawing:** White filled rectangle, black label centered on top. Uses `Graphics.image` drawn into a sprite image.

**Method:** `button:isHovered(px, py)` — returns true if `(px, py)` falls within the button's bounding rect. The scene calls this each frame.

No input handling inside the button; the scene owns all input.

---

## CockpitPointer (entities/UI/cockpit/CockpitPointer.lua)

Extends `NobleSprite` (future-proof for animation).

Draws a filled circle of radius `Config.Cockpit.pointerRadius`. Position is updated externally by the scene via `pointer:moveTo(x, y)`.

No input or accelerometer logic inside — the scene reads the accelerometer and calls `moveTo`.

---

## CockpitScene (scenes/CockpitScene.lua)

### Scene lifecycle

| Hook | Responsibility |
|------|---------------|
| `init()` | Call `scene.super.init(self)` |
| `enter()` | Start accelerometer, create 5 buttons + pointer, reset status text |
| `start()` | `scene.super.start(self)` |
| `update()` | Read accelerometer → lerp pointer → check hover → draw status text |
| `exit()` | Stop accelerometer, remove all sprites |
| `finish()` | `scene.super.finish(self)` |

### Button layout (400×240 screen)

| Button | Position | Size | Label | Action |
|--------|----------|------|-------|--------|
| 1 | (80, 70) | 40×40 | `"1"` | set status to `"1"` |
| 2 | (320, 70) | 40×40 | `"2"` | set status to `"2"` |
| 3 | (80, 170) | 40×40 | `"3"` | set status to `"3"` |
| 4 | (320, 170) | 40×40 | `"4"` | set status to `"4"` |
| Escape | (370, 220) | 20×20 | `"ESC"` | `Noble.transition(TitleScene, ...)` |

### Status text

Drawn with `Graphics.drawTextAligned` at `(200, 120)` each frame in `update()`. Initial value: `"--"`. Updates to the label of the last activated button.

### Pointer movement

```
enter():
    playdate.startAccelerometer()
    pointerX, pointerY = 200, 120   -- center of screen

update():
    ax, ay, _ = playdate.readAccelerometer()
    targetX = 200 + ax * 200 * Config.Cockpit.accelSensitivity
    targetY = 120 - ay * 120 * Config.Cockpit.accelSensitivity
    targetX = math.max(0, math.min(400, targetX))
    targetY = math.max(0, math.min(240, targetY))
    pointerX += (targetX - pointerX) * Config.Cockpit.lerpFactor
    pointerY += (targetY - pointerY) * Config.Cockpit.lerpFactor
    pointer:moveTo(pointerX, pointerY)

exit():
    playdate.stopAccelerometer()
```

### Input handler

Only `AButtonDown` is handled. On press: iterate buttons, call `isHovered(pointerX, pointerY)`, execute the first match's `action`. All other buttons are no-ops.

---

## TitleScene debug menu entry

```lua
table.insert(menuItems, {
    label  = "COCKPIT",
    action = function()
        Noble.transition(CockpitScene, 0.3, Noble.Transition.MetroNexus)
    end
})
```

---

## Out of scope

- Real cockpit background art
- Button animations / hover states
- Sound effects
- Any actual game logic tied to the buttons
