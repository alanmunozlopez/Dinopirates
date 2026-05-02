# Cockpit Layout Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Realign cockpit buttons into clean columns, flip bars to horizontal orientation, and add a dot-grid radar display in the upper-left.

**Architecture:** Three isolated changes — update the draw method in `CockpitBars`, create a new `CockpitRadar` sprite, then wire both into `CockpitScene` with updated button coordinates. No logic changes, only layout and rendering.

**Tech Stack:** Lua, Panic Playdate SDK, Noble Engine. No test runner — validate by compiling with `pdc` and checking in the simulator.

**Spec:** `docs/superpowers/specs/2026-05-02-cockpit-layout-redesign.md`

---

## File Map

| Action | File | What changes |
|--------|------|--------------|
| Modify | `source/entities/UI/cockpit/CockpitBars.lua` | `draw()` rewritten to horizontal bars |
| Create | `source/entities/UI/cockpit/CockpitRadar.lua` | New dot-grid radar sprite |
| Modify | `source/scenes/CockpitScene.lua` | Import, `btnDefs`, bars position, radar lifecycle |

---

## Task 1: Horizontal bars in CockpitBars

**Files:**
- Modify: `source/entities/UI/cockpit/CockpitBars.lua`

- [ ] **Step 1: Replace the `draw()` method**

Open `source/entities/UI/cockpit/CockpitBars.lua`. Replace the entire `draw()` function (lines 35–51) with:

```lua
function CockpitBars:draw(x, y, width, height)
    local n   = #self.bars
    local gap = 2
    local bh  = math.floor((self.bh - 2 - gap * (n - 1)) / n)

    Graphics.setColor(Graphics.kColorWhite)
    Graphics.fillRect(0, 0, self.bw, self.bh)
    Graphics.setColor(Graphics.kColorBlack)
    Graphics.drawRect(0, 0, self.bw, self.bh)

    for i, bar in ipairs(self.bars) do
        local by   = 1 + (i - 1) * (bh + gap)
        local barW = math.max(1, math.floor(bar.current * (self.bw - 4)))
        Graphics.fillRect(2, by, barW, bh)
    end
end
```

Each bar now grows from left to right. `bh` is the height of each bar row; `barW` is the filled width.

- [ ] **Step 2: Compile and verify no syntax errors**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: no errors, `.pdx` package updated.

- [ ] **Step 3: Commit**

```bash
git add source/entities/UI/cockpit/CockpitBars.lua
git commit -m "refactor(cockpit): horizontal bars in CockpitBars"
```

---

## Task 2: Create CockpitRadar

**Files:**
- Create: `source/entities/UI/cockpit/CockpitRadar.lua`

- [ ] **Step 1: Create the file**

Create `source/entities/UI/cockpit/CockpitRadar.lua` with this content:

```lua
CockpitRadar = {}
class("CockpitRadar").extends(Graphics.sprite)

local COLS        = 8
local ROWS        = 5
local APPEAR_RATE = 0.04
local FADE_RATE   = 0.03

-- dot geometry (fits inside 80×60 with 1px border)
-- inner area: 76×56 px
-- 8 cols × 4px + 7 gaps × 4px = 60 → 8px padding each side
-- 5 rows × 8px + 4 gaps × 4px = 56 → 0px padding top/bottom
local DOT_W  = 4
local DOT_H  = 8
local GAP_X  = 4
local GAP_Y  = 4
local PAD_X  = 8
local PAD_Y  = 0

function CockpitRadar:init(x, y, w, h)
    CockpitRadar.super.init(self)
    self.rw   = w
    self.rh   = h
    self.dots = {}

    for row = 1, ROWS do
        self.dots[row] = {}
        for col = 1, COLS do
            self.dots[row][col] = math.random() < 0.3
        end
    end

    self:setSize(w, h)
    self:setZIndex(ZIndex.ui)
    self:moveTo(x, y)
    self:add()
end

function CockpitRadar:update()
    local dirty = false
    for row = 1, ROWS do
        for col = 1, COLS do
            if self.dots[row][col] then
                if math.random() < FADE_RATE then
                    self.dots[row][col] = false
                    dirty = true
                end
            else
                if math.random() < APPEAR_RATE then
                    self.dots[row][col] = true
                    dirty = true
                end
            end
        end
    end
    if dirty then self:markDirty() end
end

function CockpitRadar:draw(x, y, width, height)
    Graphics.setColor(Graphics.kColorWhite)
    Graphics.fillRect(0, 0, self.rw, self.rh)
    Graphics.setColor(Graphics.kColorBlack)
    Graphics.drawRect(0, 0, self.rw, self.rh)

    local startX = 2 + PAD_X
    local startY = 2 + PAD_Y

    for row = 1, ROWS do
        for col = 1, COLS do
            if self.dots[row][col] then
                local dx = startX + (col - 1) * (DOT_W + GAP_X)
                local dy = startY + (row - 1) * (DOT_H + GAP_Y)
                Graphics.fillRect(dx, dy, DOT_W, DOT_H)
            end
        end
    end
end
```

- [ ] **Step 2: Compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: no errors. The file won't be used yet — that's fine.

- [ ] **Step 3: Commit**

```bash
git add source/entities/UI/cockpit/CockpitRadar.lua
git commit -m "feat(cockpit): add CockpitRadar dot-grid entity"
```

---

## Task 3: Wire everything into CockpitScene

**Files:**
- Modify: `source/scenes/CockpitScene.lua`

- [ ] **Step 1: Add the import at the top**

In `source/scenes/CockpitScene.lua`, after line 3 (`import "entities/UI/cockpit/CockpitBars"`), add:

```lua
import "entities/UI/cockpit/CockpitRadar"
```

- [ ] **Step 2: Add the `radar` local variable**

After `local bgImage = nil` (line 19), add:

```lua
local radar      = nil
```

- [ ] **Step 3: Reset `radar` in `enter()`**

In `scene:enter()`, in the reset block (after `bars = nil`, around line 105), add:

```lua
radar = nil
```

The reset block should look like:

```lua
calibrated = false
baseAx     = 0
baseAy     = 0
pointerX   = 200
pointerY   = 120
buttons    = {}
bars       = nil
radar      = nil
resetAllSequences()
```

- [ ] **Step 4: Replace `btnDefs` with updated coordinates**

Find the `local btnDefs = { ... }` table (starting around line 120) and replace it entirely:

```lua
local btnDefs = {
    -- left panel: two buttons aligned with central columns
    { x=100, y=137, w=32, h=48, label="1" },
    { x=136, y=137, w=32, h=48, label="2" },
    -- central grid: left column (3, 4, 6 share x=171)
    { x=171, y=137, w=18, h=14, label="3" },
    { x=171, y=154, w=18, h=14, label="4" },
    { x=171, y=170, w=22, h=12, label="6" },
    -- central grid: right column (7, 8, 9 share x=246)
    { x=246, y=137, w=20, h=14, label="7" },
    { x=246, y=154, w=20, h=14, label="8" },
    { x=246, y=170, w=24, h=12, label="9" },
    -- far right keypad
    { x=372, y=63,  w=28, h=22, label="A" },
    { x=372, y=89,  w=28, h=22, label="B" },
    { x=372, y=115, w=28, h=22, label="C" },
    { x=372, y=141, w=28, h=22, label="D" },
    -- ESC
    { x=385, y=228, w=24, h=18, label="ESC" },
}
```

- [ ] **Step 5: Move bars and add radar creation**

Find the two lines that create `bars` and `pointer` (around lines 147–150):

```lua
bars = CockpitBars(208, 145, 50, 31)

pointer = CockpitPointer()
pointer:add(pointerX, pointerY)
```

Replace with:

```lua
bars  = CockpitBars(208, 170, 50, 31)
radar = CockpitRadar(110, 68, 80, 60)

pointer = CockpitPointer()
pointer:add(pointerX, pointerY)
```

- [ ] **Step 6: Clean up radar in `exit()`**

In `scene:exit()`, after the `if bars` line, add:

```lua
if radar   then radar:remove()   radar   = nil end
```

The cleanup block should look like:

```lua
if bars    then bars:remove()    bars    = nil end
if radar   then radar:remove()   radar   = nil end
if pointer then pointer:remove() pointer = nil end
```

- [ ] **Step 7: Compile**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: no errors.

- [ ] **Step 8: Run in simulator and verify visually**

```bash
open "DinoPirates from inner space Brocolation.pdx"
```

Navigate to CockpitScene. Enable debug mode (System Menu → "debug") to see button hit-areas. Verify:

- Buttons 1 and 2 are side by side at the same height as buttons 3 and 7
- Columns 3/4/6 are vertically aligned on the left of the center area
- Columns 7/8/9 are vertically aligned on the right of the center area
- CockpitBars shows horizontal bars between buttons 6 and 9
- Radar dot grid is visible in the upper-left with dots blinking on/off
- All existing sequences (A→B→C→D → TitleScene, 1→3→2→4 → CreditsScene) still work

- [ ] **Step 9: Commit**

```bash
git add source/scenes/CockpitScene.lua
git commit -m "feat(cockpit): redesign panel layout with radar and aligned columns"
```
