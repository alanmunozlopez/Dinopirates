# NPC System — Design Spec
**Date:** 2026-04-07  
**Branch:** new-feat  
**Status:** Approved

---

## Summary

Static NPC entities (computers, phones, terminals) placed in LDtk that the player can interact with by pressing A. They show conditional dialog based on `PlayerData` state and optionally grant items or keys — once, even though the dialog is repeatable.

---

## Scope

- New file: `source/entities/props/npc.lua`
- Modified: `source/scenes/MazeScene.lua` (import + spawn block)
- Modified: `source/entities/player/collisions.lua` (NPC collision response)
- New game doc: `source/DOCS/NPC_SYSTEM.md`

Not in scope: NPC movement, NPC combat, NPC animation states.

---

## Architecture

`NPC` extends `Graphics.sprite` (same as `Trigger` — no Noble, no animation). It is a self-contained entity: visual + interaction logic + grant logic in one file.

Spawned from LDtk entities of type `NPC` in MazeScene:enter(), same pattern as Triggers and Items.

---

## LDtk Custom Fields

| Field | Type | Description |
|---|---|---|
| `type` | String | Visual identifier: `"computer"`, `"phone"`, etc. |
| `conditionalScripts` | Array\<String\> | Condition:script:grants entries (see format below) |
| `sourceFeed` | Int | Portrait index for videoFeed in dialog |
| `hasGranted` | Bool | Default false. Set true after grants fire. Persisted by save system. |

---

## conditionalScripts Format

Each entry: `"condition:script"` or `"condition:script:grants"`

- **condition**: same syntax as Trigger (boolean path, `!` negation, or numerical `>/</>=/<==/!=`)
- **script**: key into `script.lua` dialog table
- **grants** (optional): `"key:N"` for a keycard or `"fieldName:value"` for `PlayerData.items`

Evaluated top-to-bottom. First matching condition wins.

### Examples

```
"items.hasLamp:npc_give_key:key:2"        -- has lamp → dialog + give key 2 (once)
"items.hasBoots:npc_already_equipped"     -- has boots → different dialog, no grant
"mapPercent>50:npc_midgame:hasBoots:true" -- past midgame → dialog + give boots (once)
"true:npc_default"                        -- always → fallback dialog
```

---

## Interaction Flow

1. Player walks into NPC collision zone → `collisionResponse` sets `PlayerData.currentTrigger = npc`
2. MazeScene shows "Press A" HUD icon (existing mechanism, same as Search triggers)
3. Player presses A → MazeScene calls `npc:interact(dialogUI)`
4. NPC evaluates `conditionalScripts` top-to-bottom → first match returns `{script, grants}`
5. `dialogUI:addScreen(script, sourceFeed)` plays dialog
6. If `grants` present AND `hasGranted == false` → apply grant → set `hasGranted = true` in `levelsLDTK` (auto-persisted by save system on room exit)

---

## Grant Types

| Format | Effect |
|---|---|
| `key:N` | `PlayerData.keys[N] = true` |
| `fieldName:true` | `PlayerData.items[fieldName] = true` |

---

## Persistence

`hasGranted` is written directly into `levelsLDTK[room].entities.NPC[i].customFields.hasGranted`. The save system already serializes changed custom fields by entity `iid` — no changes needed to `SaveSystem.lua`.

The NPC itself always spawns (never removed from the scene). Only grants are one-time.

---

## Condition Evaluator

Copied from `trigger.lua:returnScript()` (~40 lines). Supports:
- Boolean paths: `items.hasLamp`, `!isTiny`
- Numerical comparisons: `mapPercent>50`, `battery<20`, `storyCounter==3`
- Hardcoded true: literal `"true"` always matches — **requires a special case** in the evaluator (`if conditionExpr == "true" then isMet = true`), since `PlayerData["true"]` would be nil with the existing boolean resolver
