# Doors & Keys Documentation

This document explains how the maze navigation works through doors and the security system using keys.

---

## 🚪 Door System

Doors in this game are more than just sprites; they handle the heavy lifting for level transitions.

### 1. Types & Directions
Doors are initialized based on their location in the room:
- **Directions**: `top`, `down`, `left`, `right` — converted from LDtk cardinal letters (`n`, `s`, `e`, `w`) via `ConvertLDTKDirection`.
- **Stairs / Vertical connections**: LDtk symbols `">"` and `"<"` convert to `top` (upper) and `down` (lower) directions respectively. **Staircase Door sprites are NOT created** — `CreateDoorsFromLDTK` comments out the stair `Door()` instantiation. Vertical navigation is handled by `GetLowerRoom()` / `GetUpperRoom()` in `Utilities.lua`, not by Door entities.
- **Positions**: Spawn coordinates come from `Config.Doors.spawnCoords` per direction: `top→{x=196,y=196}`, `down→{x=196,y=32}`, `right→{x=32,y=116}`, `left→{x=364,y=116}`.

### 2. Room Transitions
Transitions are handled via `Door:goTo()` and `Door:prevRoom(direction, playerX, playerY)`:
- **`prevRoom(direction, playerX, playerY)`**: Calculates where the player should spawn in the **next** room based on where they left the current one (e.g., exiting `"top"` spawns at the bottom — Y=196 — of the next room). The player's live X and Y are passed to preserve position on the orthogonal axis. Also sets `PlayerData.lastRoom`.
- **Navigation**: Uses `Noble.transition` to move to the scene class identified by the room number (e.g. `Floor220`), which is looked up via `RoomTranslate`.
- **`Door:collisionResponse`**: Returns `"overlap"`. All actual transition and key-check logic is in `player/collisions.lua` — the door's own response is a no-op.

### 3. LDtk Loading
Doors are generated dynamically in `MazeScene.lua` via `CreateDoorsFromLDTK(currentRoom)`:
- The primary loop iterates over `currentRoom.entities.Doors` — the LDtk `Doors` entity list defines which doors exist in the room.
- `neighbourLevels` is used as a lookup to find the neighboring room's data once the door entity's `DoorsConnection` field identifies the direction.
- LDtk cardinal letters (`n`, `s`, `e`, `w`) and stair symbols (`>`, `<`) are converted to internal directions via `ConvertLDTKDirection`.

---

## 🔐 Key System

The game features a locking mechanism that gates progress.

### 1. Locking Mechanisms
- A door can be initialized with a `keyNumber`.
- In `collisions.lua`, when a player hits a `closed` door:
    - It checks `PlayerData.keys[requiredKey]`.
    - If `true`, the door allows passage and transitions the player.
    - If `false`, it shows the `"nokeys"` dialog screen and returns `'freeze'` to block the player's movement.

### 2. Global State
Keys are stored in `PlayerData.keys` as a map of indices (e.g., `{[1] = true}`). This ensures that keys collected on one floor or room are available throughout the game world.

> [!NOTE]
> Collision response for doors is actually handled in `player/collisions.lua`, which calls the transition logic directly if the door is open or the key is present.

---

## 🎮 Love2D Porting Notes

### 1. Door Entity → bump.lua Sensor
Replace `NobleSprite` door objects with **bump.lua ghost/sensor rectangles**:
```lua
-- Add door as a sensor
world:add({type="door", direction="top", leadsTo=220}, x, y, w, h)

-- In player collision filter:
local function playerFilter(item, other)
    if other.type == "door" then return "cross" end  -- ghost: detect but don't block
    return "slide"
end
```

### 2. Room Transitions
Replace `Noble.transition` with your scene manager:
```lua
-- On door overlap detected in love.update:
if col.other.type == "door" then
    PlayerData.lastRoom = currentRoom
    PlayerData.playerSpawn = Door.spawnCoords[col.other.direction]
    SceneManager:switchTo(RoomTranslate(col.other.leadsTo), "slide", 0.4)
end
```

### 3. Key System
`PlayerData.keys` is a plain Lua table — it transfers to Love2D unchanged. Check it on door overlap:
```lua
if door.keyNumber and not PlayerData.keys[door.keyNumber] then
    -- Show "nokeys" dialog
    dialogUI:addScreen("nokeys")
    return  -- block transition
end
```

### 4. Spawn Coordinates
Port `Config.Doors.spawnCoords` directly — it is pure data with no Playdate dependencies.

---

## 🌀 Portal Doors

Portal doors teleport the player to any room in the map regardless of adjacency. They are defined as a separate LDtk entity type (`PortalDoors`) and do not interact with the existing `Doors` entity or `CreateDoorsFromLDTK`.

### LDtk Entity: `PortalDoors`

| Field | Type | Description |
|-------|------|-------------|
| `PortalID` | `Int` | Labels a portal pair for identification. No runtime effect — place a second portal in the destination room to enable return travel. |
| `DestLevel` | `Int` | Destination level number. |
| `DestRoom` | `Int` | Destination room number within that level. Combined RoomID = `DestLevel * 100 + DestRoom`. |
| `SpawnX` | `Int` | X coordinate where the player spawns in the destination room. |
| `SpawnY` | `Int` | Y coordinate where the player spawns in the destination room. |
| `Conditions` | `Array<String>` | Entry conditions (same format as Trigger `conditionalScripts`). All must pass. Empty = always open. |
| `BlockedDialog` | `String` | Dialog key shown when entry is blocked. Defaults to `"nokeys"`. |

### Condition examples

The format is `"conditionExpr:label"` — the label after `:` is ignored by portals (it exists only for compatibility with the Trigger condition format).

```
"isTiny:enter"               -- player must be tiny
"!isTiny:enter"              -- player must NOT be tiny
"inventory.tools==1:enter"   -- player must have tools
"healthPoints>=3:enter"      -- player must have at least 3 HP
```

### LDtk setup example

**Scenario:** Portal in room 166 (level 1, sala 66) que lleva a room 408 (level 4, sala 8), solo accesible cuando el jugador es tiny. El portal de regreso está en room 408.

**Portal A** — colocado en room 166:
```
Entity type : PortalDoors
PortalID    : 1
DestLevel   : 4
DestRoom    : 8
SpawnX      : 196
SpawnY      : 116
Conditions  : ["isTiny:enter"]
BlockedDialog: notiny
```

**Portal B** — colocado en room 408 (el de regreso):
```
Entity type : PortalDoors
PortalID    : 1
DestLevel   : 1
DestRoom    : 66
SpawnX      : 196
SpawnY      : 116
Conditions  : []        ← vacío, cualquiera puede regresar
BlockedDialog:          ← dejar vacío usa el default "nokeys"
```

> `SpawnX=196, SpawnY=116` es el centro aproximado de la pantalla (400×240). Ajusta según dónde quieras que aparezca el jugador en la sala destino.

### Code path

1. `MazeScene:enter()` calls `CreatePortalDoorsFromLDTK(currentRoom)` after `CreateDoorsFromLDTK`.
2. `CreatePortalDoorsFromLDTK` iterates `currentRoom.entities.PortalDoors` and instantiates `PortalDoor` per entity.
3. On player collision: `player/collisions.lua` checks `other:isa(PortalDoor)` → calls `canEnter()` → either `setSpawn() + goTo()` or shows blocked dialog.

### Config

`Config.Portals.collideRect` — default collision rect used when LDtk entity has no explicit size.
