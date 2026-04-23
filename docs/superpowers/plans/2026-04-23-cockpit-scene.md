# CockpitScene Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a CockpitScene where the player moves a circle pointer with the accelerometer and presses A to activate buttons.

**Architecture:** One shared `CockpitButton` entity (Graphics.sprite) instantiated 5 times, one `CockpitPointer` entity (NobleSprite) for future animation support, and `CockpitScene` that owns all accelerometer logic, lerp movement, and input routing. The scene is reachable from the TitleScene debug menu.

**Tech Stack:** Lua, Playdate SDK, Noble Engine (NobleScene, NobleSprite)

---

## Files

| Action | Path | Responsibility |
|--------|------|----------------|
| Modify | `source/assets/data/Config.lua` | Add `Config.Cockpit` section |
| Create | `source/entities/UI/cockpit/CockpitButton.lua` | White-square button sprite with hover detection |
| Create | `source/entities/UI/cockpit/CockpitPointer.lua` | Circle pointer as NobleSprite |
| Create | `source/scenes/CockpitScene.lua` | Full scene: accelerometer, lerp, buttons, status text |
| Modify | `source/main.lua` | Import CockpitScene |
| Modify | `source/scenes/TitleScene.lua` | Add COCKPIT entry to debug menu |

---

## Task 1: Add Config.Cockpit

**Files:**
- Modify: `source/assets/data/Config.lua`

- [ ] **Step 1: Add the Config.Cockpit block** — insert before the `return Config` line at the end of the file.

```lua
-- Cockpit scene
Config.Cockpit = {
    lerpFactor       = 0.15,  -- pointer smoothing (0=frozen, 1=instant)
    accelSensitivity = 1.0,   -- multiplier on raw accelerometer tilt
    pointerRadius    = 6,     -- circle radius in px
}
```

- [ ] **Step 2: Verify compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: zero errors.

---

## Task 2: Create CockpitButton entity

**Files:**
- Create: `source/entities/UI/cockpit/CockpitButton.lua`

- [ ] **Step 1: Create the file**

```lua
CockpitButton = {}
class("CockpitButton").extends(Graphics.sprite)

function CockpitButton:init(x, y, size, label, action)
    CockpitButton.super.init(self)
    self.label  = label
    self.action = action
    self.size   = size

    local img = Graphics.image.new(size, size, Graphics.kColorClear)
    Graphics.pushContext(img)
        Graphics.setColor(Graphics.kColorWhite)
        Graphics.fillRect(0, 0, size, size)
        Graphics.setColor(Graphics.kColorBlack)
        Graphics.drawRect(0, 0, size, size)
        Graphics.setImageDrawMode(Graphics.kDrawModeFillBlack)
        Graphics.drawTextAligned(label, size / 2, size / 2 - 8, kTextAlignment.center)
    Graphics.popContext()

    self:setImage(img)
    self:setZIndex(Config.ZIndex.ui)
    self:moveTo(x, y)
    self:add()
end

function CockpitButton:isHovered(px, py)
    local half = self.size / 2
    local bx, by = self:getPosition()
    return px >= bx - half and px <= bx + half
       and py >= by - half and py <= by + half
end
```

- [ ] **Step 2: Verify compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: zero errors.

---

## Task 3: Create CockpitPointer entity

**Files:**
- Create: `source/entities/UI/cockpit/CockpitPointer.lua`

- [ ] **Step 1: Create the file**

```lua
CockpitPointer = {}
class("CockpitPointer").extends(NobleSprite)

function CockpitPointer:init()
    local r   = Config.Cockpit.pointerRadius
    local d   = r * 2
    local img = Graphics.image.new(d, d, Graphics.kColorClear)
    Graphics.pushContext(img)
        Graphics.setColor(Graphics.kColorBlack)
        Graphics.fillCircleAtPoint(r, r, r)
    Graphics.popContext()
    CockpitPointer.super.init(self, img)
    self:setZIndex(Config.ZIndex.ui + 10)
end
```

- [ ] **Step 2: Verify compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: zero errors.

---

## Task 4: Create CockpitScene

**Files:**
- Create: `source/scenes/CockpitScene.lua`

- [ ] **Step 1: Create the file**

```lua
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

    Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)
    Graphics.drawTextAligned(lastPressed, 200, 120, kTextAlignment.center)
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
```

- [ ] **Step 2: Verify compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: zero errors.

---

## Task 5: Register scene and add debug menu entry

**Files:**
- Modify: `source/main.lua` — add one import line
- Modify: `source/scenes/TitleScene.lua` — add COCKPIT menu entry

- [ ] **Step 1: Add import to main.lua**

In `source/main.lua`, after the line `import 'scenes/CreditsScene'`, add:

```lua
import 'scenes/CockpitScene'
```

- [ ] **Step 2: Add COCKPIT to TitleScene debug menu**

In `source/scenes/TitleScene.lua`, inside the `if isDebugMenu then` block (around line 116), after the PLAYGROUND `table.insert` block, add:

```lua
table.insert(menuItems, {
    label  = "COCKPIT",
    action = function()
        Noble.transition(CockpitScene, 0.3, Noble.Transition.MetroNexus)
    end
})
```

- [ ] **Step 3: Compile and smoke-test in Simulator**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
open "DinoPirates from inner space Brocolation.pdx"
```

1. Enable debug mode: System Menu → "debug"
2. Navigate to COCKPIT in the title menu and press A.
3. Confirm the scene loads with a black background, 4 white squares, and a small ESC button in the bottom-right.
4. Tilt the simulator (accelerometer simulation in Playdate Simulator: Hardware → Simulate Accelerometer) — the circle pointer should move smoothly with inertia.
5. Position the pointer over button "1" and press A — confirm `"1"` appears at the center of the screen.
6. Repeat for buttons 2, 3, 4.
7. Position the pointer over ESC and press A — confirm the scene transitions back to TitleScene.

---

## Self-Review Notes

- `Config.Cockpit` is defined before `CockpitScene` is imported, so constants are available at init time.
- `playdate.startAccelerometer()` / `playdate.stopAccelerometer()` are balanced in `enter()` / `exit()`.
- `NobleSprite:add(x, y)` registers the pointer with `Noble.currentScene()` which is `CockpitScene` at call time (inside `enter()`).
- All sprites created in `enter()` are explicitly removed in `exit()`, matching the DanceScene pattern.
- The `lastPressed` text is drawn with `kDrawModeFillWhite` so it's visible on the black background.
- `Graphics.setImageDrawMode(Graphics.kDrawModeCopy)` is restored in `finish()` to avoid bleed into other scenes.
