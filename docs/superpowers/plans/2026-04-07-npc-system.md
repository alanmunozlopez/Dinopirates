# NPC System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add static NPC entities (computers, phones, terminals) to MazeScene that show conditional dialog and optionally grant items or keys when the player presses A.

**Architecture:** New `NPC` class extending `Graphics.sprite` (same pattern as `Trigger`). NPCs live in LDtk as entities of type `NPC`, are spawned in `MazeScene:enter()`, register as `player.currentTrigger` on player overlap, and expose a `returnScript()` method so the existing A-button handler in MazeScene works without changes. Grant logic runs inside `returnScript()` before returning the dialog script name.

**Tech Stack:** Playdate SDK (Lua), Noble Engine, LDtk level data via `levelsLDTK` global, `PlayerData` global, `dialogUI:addScreen()` for dialog.

**No test runner exists** — validation is: compile with `pdc source "DinoPirates from inner space Brocolation.pdx"` and verify in the Playdate Simulator.

---

## File Map

| Action | File | Responsibility |
|---|---|---|
| Create | `source/entities/props/npc.lua` | NPC class: init, collision groups, condition evaluator, grants, `returnScript()` |
| Modify | `source/scenes/MazeScene.lua` | `import 'entities/props/npc'` + spawn block for `entities.NPC` |
| Modify | `source/entities/player/collisions.lua` | `elseif other:isa(NPC)` → set `currentTrigger`, return `'overlap'` |

No changes needed to: `SaveSystem.lua`, `MazeScene` A-button handler, `playerHud`, `state.lua`, `Config.lua`.

---

## Task 1: Create `entities/props/npc.lua`

**Files:**
- Create: `source/entities/props/npc.lua`

- [ ] **Step 1: Create the file with the full NPC class**

Create `source/entities/props/npc.lua` with this exact content:

```lua
NPC = {}
class('NPC').extends(Graphics.sprite)

function NPC:init(x, y, npcType, iid, room, sourceFeed)
    NPC.super.init(self)

    self.npcType   = npcType
    self.iid       = iid
    self.room      = room
    self.sourceFeed = sourceFeed or 0
    self.script    = nil  -- Required: MazeScene calls grantAchievementIfNeeded(trigger.script)
    self.type      = nil  -- Required: state.lua checks self.currentTrigger.type; nil → setPressA() HUD

    -- Load sprite image. If missing, NPC is invisible but still functional.
    local img = Graphics.image.new('assets/images/props/npc_' .. npcType)
    if img then
        self:setImage(img)
        local w, h = self:getSize()
        self:setCollideRect(0, 0, w, h)
    else
        -- Fallback: 32x32 invisible collision zone so interaction still works
        self:setCollideRect(0, 0, 32, 32)
        printDebug("⚠️ NPC image not found: assets/images/props/npc_" .. npcType)
    end

    self:setZIndex(ZIndex.props)
    self:setGroups(CollideGroups.props)   -- Player's collidesWithGroups includes props(3)
    self:setCollidesWithGroups({})        -- NPC doesn't need to detect anything
    self:moveTo(x, y)
    self:add()

    printDebug("🖥️ NPC spawned - type:", npcType, "iid:", iid)
end

-- Called by MazeScene's AButtonDown handler when player presses A near this NPC.
-- Evaluates conditionalScripts, applies grants (once), returns dialog script name.
function NPC:returnScript()
    local scriptName, grantsStr = self:evaluateConditions()

    if grantsStr and not self:hasGranted() then
        self:applyGrant(grantsStr)
        self:markGranted()
    end

    return scriptName or ""
end

-- Evaluates conditionalScripts top-to-bottom. Returns (scriptName, grantsStr) for first match.
-- grantsStr is nil if no grants in the matching entry.
function NPC:evaluateConditions()
    local npcData = self:getLDTKData()
    if not npcData then return nil, nil end

    local cf = npcData.customFields or {}
    local conditionalScripts = cf.conditionalScripts or {}

    for _, entry in ipairs(conditionalScripts) do
        -- Split on ':' — supports "condition:script" or "condition:script:grantKey:grantVal"
        local parts = {}
        for part in entry:gmatch("[^:]+") do
            parts[#parts + 1] = part
        end

        local conditionExpr = parts[1]
        local scriptName    = parts[2]
        -- Rebuild grants string from parts 3+4 if present
        local grantsStr = nil
        if parts[3] and parts[4] then
            grantsStr = parts[3] .. ":" .. parts[4]
        end

        if conditionExpr and scriptName and self:evaluateCondition(conditionExpr) then
            return scriptName, grantsStr
        end
    end

    return nil, nil
end

-- Evaluates a single condition expression against PlayerData.
-- Supports: literal "true", numerical comparisons (>/</>=/<==/!=), boolean paths, !negation.
function NPC:evaluateCondition(conditionExpr)
    -- Special case: literal "true" always matches (catch-all fallback)
    if conditionExpr == "true" then return true end

    -- Numerical comparison: "path>N", "path<=N", etc.
    local path, op, valStr = conditionExpr:match("^([%w%.]+)%s*([<>!=]=?)%s*([%d%-%.]+)$")
    if path and op and valStr then
        local current = PlayerData
        for part in path:gmatch("[^%.]+") do
            if current then current = current[part] end
        end
        local val        = tonumber(valStr)
        local currentVal = tonumber(current) or 0
        if     op == ">"  then return currentVal > val
        elseif op == "<"  then return currentVal < val
        elseif op == ">=" then return currentVal >= val
        elseif op == "<=" then return currentVal <= val
        elseif op == "==" then return currentVal == val
        elseif op == "!=" then return currentVal ~= val
        end
    end

    -- Boolean path: "items.hasLamp", "!isTiny", etc.
    local invert    = false
    local cleanPath = conditionExpr
    if cleanPath:sub(1, 1) == "!" then
        invert    = true
        cleanPath = cleanPath:sub(2)
    end
    local current = PlayerData
    for part in cleanPath:gmatch("[^%.]+") do
        if current then current = current[part] end
    end
    local result = (current == true)
    if invert then result = not result end
    return result
end

-- Applies a grant string to PlayerData. Supported formats:
--   "key:N"          → PlayerData.keys[N] = true
--   "fieldName:true" → PlayerData.items[fieldName] = true
function NPC:applyGrant(grantsStr)
    local grantKey, grantVal = grantsStr:match("^([^:]+):(.+)$")
    if not grantKey or not grantVal then
        printDebug("⚠️ NPC: invalid grants format:", grantsStr)
        return
    end

    grantKey = grantKey:gsub("%s+", "")

    if grantKey == "key" then
        local keyNum = tonumber(grantVal)
        if keyNum then
            PlayerData.keys[keyNum] = true
            printDebug("🎁 NPC granted key:", keyNum)
        end
    elseif grantVal == "true" then
        PlayerData.items[grantKey] = true
        printDebug("🎁 NPC granted item:", grantKey)
    end
end

-- Returns true if grants have already been applied for this NPC.
function NPC:hasGranted()
    local npcData = self:getLDTKData()
    if not npcData then return false end
    return (npcData.customFields or {}).hasGranted == true
end

-- Marks hasGranted = true in levelsLDTK. SaveSystem.save() persists this on room exit.
function NPC:markGranted()
    local npcData = self:getLDTKData()
    if not npcData then return end
    if not npcData.customFields then npcData.customFields = {} end
    npcData.customFields.hasGranted = true
    printDebug("✅ NPC grants marked as used:", self.iid)
end

-- Finds this NPC's entry in levelsLDTK by iid.
function NPC:getLDTKData()
    local roomData = levelsLDTK[self.room]
    if not roomData or not roomData.entities or not roomData.entities.NPC then return nil end
    for _, data in ipairs(roomData.entities.NPC) do
        if data.iid == self.iid then return data end
    end
    return nil
end
```

- [ ] **Step 2: Compile to verify no syntax errors**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: compiles without errors. The NPC class is defined but not yet used.

- [ ] **Step 3: Commit**

```bash
git add source/entities/props/npc.lua
git commit -m "feat: add NPC entity class with conditional dialog and grants"
```

---

## Task 2: Spawn NPCs in MazeScene

**Files:**
- Modify: `source/scenes/MazeScene.lua`

The spawn block goes after the `-- MARK: Dialog triggers` block (around line 326). NPCs always spawn — they are never removed. `hasGranted` is tracked internally, not used as a spawn gate.

- [ ] **Step 1: Add the import at the top of MazeScene.lua**

Find this block near the top of MazeScene.lua:

```lua
import 'entities/items/Items'
```

Add the NPC import directly after it:

```lua
import 'entities/items/Items'
import 'entities/props/npc'
```

- [ ] **Step 2: Add the NPC spawn block**

Find this block near the end of `scene:enter()`:

```lua
-- MARK: Dialog triggers
	local entities = levelsLDTK[room].entities
	
	if entities and entities.Triggers then
```

Add the NPC spawn block **above** it:

```lua
	-- MARK: NPCs
	local npcEntities = levelsLDTK[room].entities
	if npcEntities and npcEntities.NPC then
		for _, npcData in ipairs(npcEntities.NPC) do
			local cf = npcData.customFields or {}
			NPC(npcData.x, npcData.y, cf.type or "computer", npcData.iid, room, cf.sourceFeed or 0)
		end
	end

	-- MARK: Dialog triggers
	local entities = levelsLDTK[room].entities
	
	if entities and entities.Triggers then
```

- [ ] **Step 3: Compile**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: compiles without errors. Rooms without NPC entities are unaffected.

- [ ] **Step 4: Commit**

```bash
git add source/scenes/MazeScene.lua
git commit -m "feat: spawn NPC entities from LDtk in MazeScene"
```

---

## Task 3: Add NPC collision response

**Files:**
- Modify: `source/entities/player/collisions.lua`

The player's `collisionResponse` currently has no case for `NPC`. Without this, the player would slide through NPCs (props fallback) without setting `currentTrigger`. We add a case that sets `currentTrigger` and returns `'overlap'` — identical to how Search triggers work.

- [ ] **Step 1: Add NPC case to collisionResponse**

In `source/entities/player/collisions.lua`, find this block:

```lua
  elseif other:isa(PropItem) and other.type == 'minifier' then
```

Add the NPC case **before** it (after the Trigger block, before PropItem):

```lua
  elseif other:isa(NPC) then
    self.currentTrigger = other
    return 'overlap'

  elseif other:isa(PropItem) and other.type == 'minifier' then
```

- [ ] **Step 2: Compile**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
```

Expected: compiles without errors.

- [ ] **Step 3: Commit**

```bash
git add source/entities/player/collisions.lua
git commit -m "feat: add NPC collision response — sets currentTrigger on overlap"
```

---

## Task 4: Add test dialog and smoke test in simulator

**Files:**
- Modify: `source/assets/data/script.lua`
- Modify: `source/en.strings`

This task adds the minimum dialog content to test an NPC in the simulator. It assumes you have LDtk access to place a test NPC entity in one room.

- [ ] **Step 1: Add test dialog scripts to script.lua**

Open `source/assets/data/script.lua` and add these two entries to the `script` table:

```lua
{
    name = "npc_test_has_lamp",
    dialog = {
        { video = 'radioHand', text = "npc-test-auth" }
    }
},
{
    name = "npc_test_default",
    dialog = {
        { video = 'player', text = "npc-test-default" }
    }
},
```

- [ ] **Step 2: Add localization keys to en.strings**

Open `source/en.strings` and add:

```
"npc-test-auth" = "Terminal online. Keycard dispensed."
"npc-test-default" = "Insufficient clearance."
```

- [ ] **Step 3: Place a test NPC in LDtk**

In LDtk, in any accessible room:
1. Create entity type `NPC` if it doesn't exist yet, with these custom fields:
   - `type`: String (default `"computer"`)
   - `conditionalScripts`: Array\<String\>
   - `sourceFeed`: Int (default `0`)
   - `hasGranted`: Bool (default `false`)
2. Place one `NPC` entity.
3. Set `type` = `"computer"`.
4. Set `conditionalScripts` to:
   ```
   ["items.hasLamp:npc_test_has_lamp:key:1", "true:npc_test_default"]
   ```
5. Set `sourceFeed` = `0`.
6. Re-export `levels.lua` from LDtk.

- [ ] **Step 4: Compile and run in simulator**

```bash
cd /Users/dactrtr-mini/Documents/GitHub/Dinopirates
pdc source "DinoPirates from inner space Brocolation.pdx"
open "DinoPirates from inner space Brocolation.pdx"
```

**Manual checks:**
- [ ] Navigate to the room with the test NPC
- [ ] Walk into the NPC area → "Press A" HUD icon appears
- [ ] Walk away → HUD icon disappears
- [ ] Press A without lamp → `"Insufficient clearance."` dialog plays
- [ ] Get the lamp, press A → `"Terminal online. Keycard dispensed."` dialog + `PlayerData.keys[1] = true`
- [ ] Press A again with lamp → same dialog plays but NO second grant (hasGranted = true)
- [ ] Save and reload → hasGranted persists, key stays granted

- [ ] **Step 5: Commit**

```bash
git add source/assets/data/script.lua source/en.strings
git commit -m "test: add NPC smoke test dialog scripts and localization"
```
