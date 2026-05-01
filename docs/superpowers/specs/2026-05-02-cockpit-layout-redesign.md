# Cockpit Layout Redesign

**Date:** 2026-05-02
**Branch:** new-feat
**Scope:** CockpitScene button layout, CockpitBars orientation, new CockpitRadar entity

---

## Goal

Reorganize the cockpit panel so buttons are grouped into clean aligned columns, two main buttons sit at the same height as the side columns, bars become horizontal progress-bar style, and a new radar dot-grid display fills the upper-left area.

---

## Layout (400×240 screen, coordinates = sprite center)

```
  x=0        x=100      x=200      x=300      x=400
  ┌───────────────────────────────────────────────┐ y=0
  │                                               │
  │  ╔══════════════╗               ╔═══╗         │
  │  ║   RADAR      ║               ║ A ║  y=63   │
  │  ║   center:    ║               ╠═══╣         │
  │  ║  (110, 68)   ║               ║ B ║  y=89   │
  │  ║   80×60      ║               ╠═══╣         │
  │  ╚══════════════╝               ║ C ║  y=115  │
  │                                 ╠═══╣         │
  │  ╔══╗╔══╗  ┌─┐         ┌─┐    ║ D ║  y=141  │
  │  ║1 ║║2 ║  │3│         │7│    ╚═══╝         │ ← y=137
  │  ║  ║║  ║  ├─┤         ├─┤                   │
  │  ║  ║║  ║  │4│         │8│                   │ ← y=154
  │  ║  ║║  ║  ├─┤┌───────┐├─┤                   │
  │  ╚══╝╚══╝  │6││ BARS  ││9│                   │ ← y=170
  │            └─┘└───────┘└─┘                   │
  │                                   ┌───┐       │
  │                                   │ESC│       │ y=228
  └───────────────────────────────────└───┘───────┘ y=240
```

---

## Button Coordinates

| Label | Center X | Center Y | W  | H  | Change |
|-------|----------|----------|----|----|--------|
| 1     | 100      | 137      | 32 | 48 | Resized and repositioned (was 62×46 at y=97) |
| 2     | 136      | 137      | 32 | 48 | Resized and repositioned (was 62×42 at y=152) |
| 3     | 171      | 137      | 18 | 14 | Unchanged |
| 4     | 171      | 154      | 18 | 14 | Unchanged |
| 6     | 171      | 170      | 22 | 12 | X moved from 190 → 171 (aligns with col 3,4) |
| 7     | 246      | 137      | 20 | 14 | Unchanged |
| 8     | 246      | 154      | 20 | 14 | Unchanged |
| 9     | 246      | 170      | 24 | 12 | X moved from 222 → 246 (aligns with col 7,8) |
| A     | 372      | 63       | 28 | 22 | Unchanged |
| B     | 372      | 89       | 28 | 22 | Unchanged |
| C     | 372      | 115      | 28 | 22 | Unchanged |
| D     | 372      | 141      | 28 | 22 | Unchanged |
| ESC   | 385      | 228      | 24 | 18 | Unchanged |

---

## CockpitBars Changes

- **Position:** center moved from (208, 145) → (208, 170), same row as buttons 6 and 9
- **Size:** unchanged 50×31
- **Orientation:** bars now grow **left → right** (horizontal) instead of bottom → top
- 7 bars stacked vertically, each fills proportionally from left edge
- Gap between button 6 right edge (182) and bars left edge (183): 1px
- Gap between bars right edge (233) and button 9 left edge (234): 1px

---

## New Entity: CockpitRadar

**File:** `source/entities/UI/cockpit/CockpitRadar.lua`

### Behavior
- Dot grid: 8 columns × 5 rows = 40 dots
- Each frame, each dot has a small random chance to flip state (lit / dark)
- Dots appear/disappear independently, simulating radar blips
- Two tunable constants: `APPEAR_RATE` (prob per frame a dark dot lights up) and `FADE_RATE` (prob per frame a lit dot goes dark)

### Rendering (1-bit)
- Outer border rect (the "screen" frame)
- Each dot: filled 2×2 rect when lit, nothing when dark
- Dots spaced evenly inside the border with 2px padding

### Position & Size
- Center: (110, 68), size: 80×60
- Registered in CockpitScene the same way as CockpitBars (created in `enter()`, removed in `exit()`)

### Constants (initial values)
```lua
local COLS        = 8
local ROWS        = 5
local APPEAR_RATE = 0.04
local FADE_RATE   = 0.03
```

---

## Files to Change

1. `source/scenes/CockpitScene.lua` — update `btnDefs` coordinates and bars position; add radar import and lifecycle calls
2. `source/entities/UI/cockpit/CockpitBars.lua` — change `draw()` to render horizontal bars
3. `source/entities/UI/cockpit/CockpitRadar.lua` — new file
