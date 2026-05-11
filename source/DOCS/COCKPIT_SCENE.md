# CockpitScene — Cockpit Puzzle

**File**: `scenes/CockpitScene.lua`  
**Entities**: `entities/UI/cockpit/`

Interactive cockpit puzzle reached from TitleScene. The player uses the accelerometer (or D-pad) to move a crosshair pointer over physical buttons and press them in the correct sequence. Solving a sequence transitions to another scene; too many wrong presses return to TitleScene.

---

## Local State

| Variable | Type | Purpose |
|---|---|---|
| `buttons` | table | All `CockpitButton` sprites (13 total) |
| `bars` | CockpitBars | Decorative animated horizontal bars widget |
| `radar` | CockpitRadar | Decorative animated dot-grid widget |
| `pointer` | CockpitPointer | Animated cursor sprite |
| `pointerX / pointerY` | number | Current pointer position (screen coords) |
| `baseAx / baseAy` | number | Accelerometer calibration baseline |
| `calibrated` | bool | Whether the accelerometer has been zeroed |
| `failCount` | number | Wrong button presses accumulated this session |
| `sequences` | table | List of sequence definitions (pattern + action + index) |

---

## Scene Lifecycle

### `init()`
No-op beyond `scene.super.init`.

### `enter()`
Resets all pointer and sequence state. Creates all 13 `CockpitButton` sprites, `CockpitBars`, `CockpitRadar`, and `CockpitPointer`. Calls `playdate.startAccelerometer()`.

### `exit()`
Calls `playdate.stopAccelerometer()`. Removes and nils every sprite. Clears `buttons` table.

### `finish()`
Resets draw mode to `kDrawModeCopy`.

---

## Input

| Input | Action |
|---|---|
| Accelerometer tilt | Moves pointer (calibrated to device orientation on first non-zero reading) |
| D-pad | Moves pointer at `Config.Cockpit.dpadSpeed` px/frame; re-anchors accel baseline so the two inputs don't fight |
| A Button | Presses whichever button the pointer is currently hovering; pressing `ESC` transitions to TitleScene |
| B Button | Resets pointer to center (200, 120) and clears calibration |

---

## Pointer Movement

Each frame in `update()`:

1. Read raw accelerometer (`ax`, `ay`). On first non-zero frame, store as `baseAx / baseAy`.
2. Apply D-pad movement first. If the pad moved, shift the baseline so the accelerometer lerp starts from the new position instead of fighting it.
3. Compute `targetX/Y` from `(ax - baseAx) * 200 * accelSensitivity` offset from screen center.
4. Lerp current position toward target at `Config.Cockpit.lerpFactor`.
5. Move `CockpitPointer` sprite; switch animation to `hover` state if over any button, else `idle`.

Config values (`Config.Cockpit`):

| Key | Default | Meaning |
|---|---|---|
| `lerpFactor` | 0.15 | Pointer smoothing (0 = frozen, 1 = instant) |
| `accelSensitivity` | 2.0 | Multiplier on raw tilt delta |
| `dpadSpeed` | 3 | Pixels per frame with D-pad |
| `failLimit` | 10 | Wrong presses before forced return to TitleScene |

---

## Sequence System

`sequences` is a list of tables, each with:
- `pattern` — ordered list of button labels to press (e.g. `{"1","3","2","4"}`)
- `action` — function to call when the full pattern is matched (typically a `Noble.transition`)
- `index` — tracks how far the player has progressed (1 = waiting for first button)

### On each button press (`pressButton(label)`):

1. For every sequence, check if `label == seq.pattern[seq.index]`.
   - **Match**: advance `seq.index`. If index exceeds pattern length → call `seq.action()`, reset all sequences, reset `failCount`.
   - **No match**: reset that sequence's index to 1.
2. If no sequence was advanced by this press, increment `failCount`. If `failCount >= Config.Cockpit.failLimit` → transition to TitleScene.

Multiple sequences run in parallel; pressing a button that matches one sequence but not another resets only the non-matching ones.

### Default sequences

| Pattern | Outcome |
|---|---|
| `1 → 3 → 2 → 4` | Transition to `CreditsScene` (MetroNexus, 0.3 s) |
| `A → B → C → D` | Transition to `TitleScene` (MetroNexus, 0.3 s) |

To add a new sequence, append an entry to the `sequences` table at the top of the file — no other changes needed.

---

## Visual Indicators (drawBackground)

Two indicators are drawn each frame on the background:

**1. Sequence progress circles** — a row of `n` circles centered at `x=200, y=8` (one per button in the leading sequence). Filled circles = buttons already pressed correctly. Uses `leadingSequence()` to pick the most advanced sequence.

**2. Fail bar** — a horizontal bar at `y=18`, full width minus 40 px margins. Fills from left as `failCount` rises toward `Config.Cockpit.failLimit`. Border only when empty; black fill proportional to `failCount / failLimit`.

---

## Button Layout

All positions are sprite centers. Buttons are invisible in normal play (`setVisible(debug == true)`) — they are hit zones only.

| Label | x | y | w | h | Group |
|---|---|---|---|---|---|
| `1` | 26 | 140 | 32 | 48 | Left panel |
| `2` | 74 | 140 | 32 | 48 | Left panel |
| `3` | 166 | 200 | 24 | 16 | Center grid left col |
| `4` | 166 | 220 | 24 | 16 | Center grid left col |
| `6` | 166 | 180 | 24 | 16 | Center grid left col |
| `7` | 246 | 200 | 24 | 16 | Center grid right col |
| `8` | 246 | 220 | 24 | 16 | Center grid right col |
| `9` | 246 | 180 | 24 | 16 | Center grid right col |
| `A` | 372 | 63  | 28 | 22 | Far-right keypad |
| `B` | 372 | 89  | 28 | 22 | Far-right keypad |
| `C` | 372 | 115 | 28 | 22 | Far-right keypad |
| `D` | 372 | 141 | 28 | 22 | Far-right keypad |
| `ESC` | 206 | 228 | 50 | 20 | Exit button |

---

## Entities

### `CockpitButton` (`entities/UI/cockpit/CockpitButton.lua`)
`Graphics.sprite`. Draws a 3D-raised rectangle with a centered label using the `shinonome` font. Only visible when `debug == true`. Hit detection via `isHovered(px, py)` — AABB check against the button's center and stored `w`/`h`.

### `CockpitPointer` (`entities/UI/cockpit/CockpitPointer.lua`)
`NobleSprite`. Spritesheet at `assets/images/ui/cockpit/ui-pointer`. Two animation states:
- `idle` — frames 1–2, 8 fps
- `hover` — frames 3–4, 8 fps

Z-index: `ZIndex.ui + 10` (above buttons).

### `CockpitBars` (`entities/UI/cockpit/CockpitBars.lua`)
`Graphics.sprite`. Decorative widget at `(206, 190)`, size `50×31`. Renders 5 horizontal bars that independently lerp toward random targets each frame (`LERP_SPEED = 0.06`, `CHANGE_RATE = 0.03` probability per frame per bar). Pure decoration — no gameplay effect.

### `CockpitRadar` (`entities/UI/cockpit/CockpitRadar.lua`)
`Graphics.sprite`. Decorative widget at `(50, 200)`, size `80×60`. Renders an 8×5 grid of dots (`4×8 px` each) that randomly appear and fade (`APPEAR_RATE = 0.04`, `FADE_RATE = 0.03`). Pure decoration — no gameplay effect.
