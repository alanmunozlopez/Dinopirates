# CrewMember and Collision Screen Documentation

This document explains how the `CrewMember` entity works and how to show custom screens within the `collisions.lua` system.

---

## 🏴‍☠️ CrewMember Logic

The `CrewMember` is a specialized enemy entity with complex behavior for escaping the player and hiding when trapped.

### 1. Movement & AI
- **Escape Mode**: In its `update` loop, if not hiding or blinded, the `CrewMember` calculates a path away from the player.
- **Movement Tokens**: Movement is throttled by a token system.
    - `addMovementTokens(amount)`: Adds frames of movement based on tokens (1 token ≈ 30 frames).
    - `addMovementFrames(frames)`: Adds raw frames of movement (capped at 90).
    - The `update` loop only processes AI search/movement if `movementFrames > 0`.

### 2. Collision & Bouncing
In `moveCollision(movementX, movementY, player)`, the entity detects if its movement is blocked by walls or props:
- **Slide Response**: Returns `'slide'` for walls/props to allow moving along surfaces.
- **Bounce Mechanic**: If blocked, it increments `recentBounceCount`.
- **Direction Redirect**: If a collision is detected, it enters a "bounce" state for 20 frames, choosing a perpendicular direction (up/down if horizontal block, left/right if vertical block).

### 3. Hiding State
If the `CrewMember` bounces 3 times in quick succession (`bouncesRequiredToHide`), it enters the **Hiding State**:
- **Invisibility**: Sprite sets its state to `'hide'`.
- **Non-collidable**: `setCollideRect(0, 0, 0, 0)` and groups are cleared.
- **Exit Conditions**:
    1. Player must be outside `hidingVisionRange` (80 pixels).
    2. Enough movement tokens must be accumulated (`hidingMovementTokensRequired = 3`).

### 4. Special Interactions
- **Blinding**: `blind(frames)` stops the entity for a duration.
- **Taking**: `taken()` marks the crew member as captured in `PlayerData`, updates the UI count, and removes the sprite.

---

## 📺 Custom Screens in Collisions

Screens (dialogs/UI overlays) are managed via `PlayerData` and the `dialogUI` component.

### 1. The Collision Hook
In `source/entities/player/collisions.lua`, the `Player:collisionResponse(other)` function handles interactions.

To show a custom screen when hitting a specific `CrewMember`:
```lua
elseif other:isa(CrewMember) then
    -- Example logic: Show a unique screen for a specific Crew ID
    if other.crewId == 'CM001' then
        self.dialogUI:addScreen("unique_intro_screen")
    end
    
    -- Generic screen for capture
    if PlayerData.CrewMemberData.amountTaken == 0 then
        self.dialogUI:addScreen("gotcha", other.sourceFeed)
    end
    
    other:taken()
end
```

### 2. How `addScreen` Works
The `dialogUI` (instance of `dialogScreen.lua`) uses `addScreen(scriptName)`:
- It searches the `script` table (loaded globally, usually from `assets/data/scripts.lua`) for an entry with a matching `name`.
- It sets `PlayerData.isTalking = true`, which pauses normal gameplay logic.
- It displays the associated text, video feed, or images defined in the script.

### 3. Customizing the Screen
To add a new screen:
1.  **Define the Script**: Add an entry to your scripts data file.
    ```lua
    {
        name = "my_custom_screen",
        dialog = {
            { text = "LEVEL_UP_TEXT", video = "celebration", screen = someImage }
        }
    }
    ```
2.  **Call it in `collisions.lua`**: Use `self.dialogUI:addScreen("my_custom_screen")`.

> [!TIP]
> Use `other.sourceFeed` as the second argument if you want to pass a specific video feed index to the dialog system.
