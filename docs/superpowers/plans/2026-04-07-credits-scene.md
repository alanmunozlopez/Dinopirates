# Credits Scene Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a scrolling credits scene (black bg, white text/images, bottom-to-top) accessible from TitleScene's menu.

**Architecture:** New `CreditsScene` extends `NobleScene`. All drawing happens in `drawBackground()` using immediate-mode Playdate graphics — no sprites. Content is a local Lua array of `text`, `image`, and `space` items. Scroll state lives in module-local variables reset on `enter()`.

**Tech Stack:** Playdate SDK (Lua), Noble Engine (`NobleScene`, `Noble.transition`), `Graphics.drawTextAligned`, `Graphics.image`.

**No test runner** — validate with `pdc source "DinoPirates from inner space Brocolation.pdx"` and Playdate Simulator.

---

## File Map

| Action | File | Responsibility |
|---|---|---|
| Create | `source/scenes/CreditsScene.lua` | Full credits scene + content array |
| Modify | `source/main.lua` | Add `import 'scenes/CreditsScene'` |
| Modify | `source/scenes/TitleScene.lua` | Add Credits menu item in `enter()` |

---

## Task 1: Create CreditsScene.lua

**Files:**
- Create: `source/scenes/CreditsScene.lua`

- [ ] **Step 1: Create the file**

Create `source/scenes/CreditsScene.lua` with this exact content:

```lua
CreditsScene = {}
class("CreditsScene").extends(NobleScene)
local scene = CreditsScene

-- Scroll speeds (px/frame)
local SCROLL_SPEED      = 1
local SCROLL_SPEED_FAST = 3
-- Layout
local LINE_HEIGHT    = 20   -- height of a text item
local ITEM_SPACING   = 16   -- vertical gap between items
local START_OFFSET   = 260  -- initial Y of first item (just below screen bottom)

-- Edit this table to change the credits content.
-- Three item types:
--   { type = "text",  value = "string" }  — white text, centered at x=200
--   { type = "image", path = "assets/..." } — image centered horizontally
--   { type = "space", height = N }          — empty vertical gap
local credits = {
    { type = "space", height = 40 },
    { type = "text",  value = "DinoPirates from inner space" },
    { type = "space", height = 30 },
    { type = "text",  value = "A game by" },
    { type = "space", height = 8 },
    { type = "text",  value = "Sebastian Zuniga" },
    { type = "space", height = 40 },
    { type = "text",  value = "Music" },
    { type = "space", height = 8 },
    { type = "text",  value = "..." },
    { type = "space", height = 60 },
    { type = "text",  value = "Thanks for playing!" },
    { type = "space", height = 80 },
}

scene.backgroundColor = Graphics.kColorBlack

-- Module-local state (reset in enter())
local scrollY        = 0
local isHoldingA     = false
local totalHeight    = 0
local loadedImages   = {}
local isDone         = false  -- guard: prevents Noble.transition from firing every frame

CreditsScene.inputHandler = {
    AButtonDown = function() isHoldingA = true  end,
    AButtonUp   = function() isHoldingA = false end,
    BButtonDown = function() Noble.transition(TitleScene) end,
}

-- Returns the draw height of a single item.
local function itemHeight(item)
    if item.type == "text" then
        return LINE_HEIGHT
    elseif item.type == "image" then
        local img = loadedImages[item.path]
        if img then
            local _, h = img:getSize()
            return h
        end
        return 0
    elseif item.type == "space" then
        return item.height
    end
    return 0
end

function scene:init()
    scene.super.init(self)
end

function scene:enter()
    scene.super.enter(self)

    scrollY      = 0
    isHoldingA   = false
    loadedImages = {}
    isDone       = false

    -- Preload all images so drawBackground() never reads from disk
    for _, item in ipairs(credits) do
        if item.type == "image" and not loadedImages[item.path] then
            local img = Graphics.image.new(item.path)
            if img then
                loadedImages[item.path] = img
            else
                printDebug("⚠️ Credits: image not found:", item.path)
            end
        end
    end

    -- Compute total scroll distance needed
    totalHeight = 0
    for i, item in ipairs(credits) do
        totalHeight = totalHeight + itemHeight(item)
        if i < #credits then
            totalHeight = totalHeight + ITEM_SPACING
        end
    end
end

function scene:update()
    scene.super.update(self)

    local speed = isHoldingA and SCROLL_SPEED_FAST or SCROLL_SPEED
    scrollY = scrollY + speed

    -- All content has scrolled past the top of the screen
    if not isDone and scrollY >= START_OFFSET + totalHeight then
        isDone = true
        Noble.transition(TitleScene)
    end
end

function scene:drawBackground()
    scene.super.drawBackground(self)

    local y = START_OFFSET - scrollY

    for _, item in ipairs(credits) do
        local h = itemHeight(item)

        if y + h >= 0 and y <= 240 then
            if item.type == "text" then
                Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)
                Graphics.drawTextAligned(item.value, 200, y, kTextAlignment.center)
            elseif item.type == "image" then
                local img = loadedImages[item.path]
                if img then
                    local w, _ = img:getSize()
                    img:draw(200 - w // 2, y)
                end
            end
            -- "space": nothing to draw
        end

        y = y + h + ITEM_SPACING
    end
end

function scene:exit()
    scene.super.exit(self)
    loadedImages = {}
end
```

- [ ] **Step 2: Compile**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: compiles clean. `CreditsScene` is defined but not yet reachable.

- [ ] **Step 3: Commit**

```bash
git add source/scenes/CreditsScene.lua
git commit -m "feat: add CreditsScene with scrolling text and image support"
```

---

## Task 2: Wire up import and TitleScene menu entry

**Files:**
- Modify: `source/main.lua`
- Modify: `source/scenes/TitleScene.lua`

- [ ] **Step 1: Add import to main.lua**

In `source/main.lua`, find this block:

```lua
import 'scenes/TestScene'
import 'scenes/TitleScene'
```

Add the CreditsScene import between them:

```lua
import 'scenes/TestScene'
import 'scenes/CreditsScene'
import 'scenes/TitleScene'
```

(`CreditsScene` must be imported before `TitleScene` since TitleScene will reference it.)

- [ ] **Step 2: Add Credits menu item to TitleScene**

In `source/scenes/TitleScene.lua`, inside `scene:enter()`, find the block that adds the Achievements option and the closing `updateMenuSelection()` call:

```lua
	currentY = currentY + spacing
	
	-- Add Playground option only if debug is true
```

Add the Credits entry **before** the Playground block, after the Achievements `currentY` increment:

```lua
	currentY = currentY + spacing

	-- Add Credits option
	local creditsSprite = MenuTitle(startX, currentY, 'defAchievements', 100)
	table.insert(menuItems, {
		sprite = creditsSprite,
		defaultState = 'defAchievements',
		selectedState = 'selAchievements',
		backgroundState = 'achievements',
		action = function()
			Noble.transition(CreditsScene, 0.3, Noble.Transition.MetroNexus)
		end
	})
	currentY = currentY + spacing

	-- Add Playground option only if debug is true
```

> **Note on placeholder art:** `'defAchievements'` / `'selAchievements'` are reused as placeholder animation states for the Credits menu entry. Once dedicated `'defCredits'` / `'selCredits'` frames are added to the `menuTitle` imagetable asset, replace those three strings. The `backgroundState = 'achievements'` can similarly be replaced with `'credits'` once that background frame exists.

- [ ] **Step 3: Compile**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: compiles clean.

- [ ] **Step 4: Smoke test in simulator**

```bash
open "DinoPirates from inner space Brocolation.pdx"
```

Manual checks:
- [ ] TitleScene shows a Credits entry in the menu (visually uses Achievements art as placeholder)
- [ ] Selecting Credits transitions to CreditsScene
- [ ] Black background, white text scrolls from bottom to top
- [ ] Holding A scrolls faster
- [ ] Pressing B returns to TitleScene immediately
- [ ] Credits reach the end → auto-transition to TitleScene

- [ ] **Step 5: Commit**

```bash
git add source/main.lua source/scenes/TitleScene.lua
git commit -m "feat: wire CreditsScene into main.lua and TitleScene menu"
```
