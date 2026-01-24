# Props & Items Documentation

This document details the environment objects (Props) and collectibles (Items) that populate the game world.

---

## 📦 Items (Pickups)
Items are specialized sprites that grant the player new abilities or resources upon contact.

### 1. Item Types
- **`keycard`**: Grants access to doors with matching `keyNumber`.
- **`lamp`**: Enables visibility in dark rooms and triggers sanity regen logic.
- **`radio` / `notes`**: Story-relevant items.
- **`bag`**: Required to capture CrewMembers.
- **`boots`**: Prevents falling into holes if battery is available.
- **`plunger`**: Prevents sliding on slime if battery is available.

### 2. Interaction Flow
In `collisions.lua`:
- Hitting an item usually calls `other:removeAll()`.
- It then calls a corresponding "grab" function on the player (e.g., `self:grabKey(num)` or `self:grabLamp()`).
- Grabbing an item typically updates a boolean in `PlayerData.items` or `PlayerData.keys`.

---

## 🖼️ PropItem System
Props represent the interactive furniture and environmental details.

### 1. Visuals and States
Props share a single image sheet (`props.png`) and use animation states like `chair`, `table`, `microwave`, `fridge`, etc.
- **Debris**: When a prop is destroyed, its state changes to `debris`.
- **Z-Index**: Props dynamically update their Z-Index based on their Y position (`update()` loop) unless they are "flat" (like blood or holes).

### 2. Environmental Hazards & Utility
- **Holes**: Defined by type (e.g., `holeCenter`, `holeLeft`).
    - **Falling**: In `collisions.lua`, hitting a hole without boots/battery triggers `self:fallBelow()`.
    - **Walking**: With boots, the player drains battery but remains in the room.
- **Minifiers**: Special pods used to change the player's size via a crank interaction (`isTiny`).
- **Slime (Tile 46)**: Environmental hazard that causes the player to slide.
    - **Sliding**: When stepped on, the player automatically moves in a straight line at a fixed speed (`slidingSpeed = 4`).
    - **Stopping**: The slide ends if the player hits a solid obstacle (wall, solid prop) or exits the slime patch.
    - **Antislip Protection**: If the player has **plunger**, they can walk over slime normally while draining battery (0.5 units, or 0.2 if Tiny).
    - **Control**: Manual movement is disabled during a slide.

### 3. Destruction & Persistence
Props can be destroyed by certain enemies or effects.
- **`destroyProp(id)`**: Uses the unique LDtk IID to find and mark the prop as destroyed in the global level data.
- **Persistence**: `MazeScene.lua` checks the `destroyed` custom field when spawning props, ensuring they remain rubble if previously broken.

---

## 🌍 World Rendering
- **Z-Ordering**: Static props and the player use Y-sorting to handle depth correctly.
- **Occlusion**: `FXshadow` uses prop positions to determine visibility, though mostly it centers on the player's light source.

> [!TIP]
> Items use a `FXsonar` instance to "ping" their location, helping the player find them in low-visibility or dark areas.
