# HUD System Documentation

The HUD (Heads-Up Display) provides real-time information about the player's status, including battery life, health, and sanity. It is anchored to the player and drawn on top of the game world.

---

## 🖥️ Main Component: `playerHud`
Path: `entities/UI/playerHud.lua`

The `playerHud` is a `NobleSprite` that follows the player and coordinates several sub-indicators.

- **Positioning**: Automatically moves to `(player.x, player.y - 36)`.
- **Sanity States**: The HUD background image changes based on `PlayerData.sanity`.
    - `sanity100`: > 80
    - `sanity80`: > 60
    - `sanity60`: > 40
    - `sanity40`: > 20
    - `sanity20`: > 0
    - `sanity0`: 0

---

## ❤️ Health Representation: `HealthIndicator`
Path: `entities/UI/healthIndicator.lua`

The Health Indicator represents the player's `healthPoints` (default 10) using 5 hearts in the HUD.

- **Logic**: Each heart represents 2 health points. A full heart is filled with two black squares.
- **Coordinates**: The squares are drawn at specific pixel offsets to align with the `UIHud` image:
    - `xPositions = {4, 5, 10, 11, 16, 17, 22, 23, 28, 29}`
    - `yPos = 8`
- **Update**: Redraws whenever `PlayerData.healthPoints` changes.

---

## 🔋 Battery Indicator: `Battery`
Path: `entities/UI/battery.lua`

The Battery Indicator shows the charge level in the canister.

- **Visibility**: Only visible if the player `hasLamp` or `hasBoots`.
- **Logic**: Draws a black bar where the width is calculated as `(battery * 27) / 100`.
- **Position**: Offset slightly from the main HUD `(tx, ty - 3)`.

---

## 🗝️ Key Indicator: `keyHud`
Path: `entities/UI/keyHud.lua`

(Document here logic for keys if implemented in this class).

---

## 🛠️ Z-Index Management
The HUD and its children use a layered Z-Index to ensure correct rendering order:
- `ZIndex.hud` (2000): Main HUD background.
- `ZIndex.hud + 1`: Battery Indicator.
- `ZIndex.hud + 2`: Health Indicator.

> [!TIP]
> All indicators read directly from the global `PlayerData` (or `_G.PlayerData`) for synchronization.
