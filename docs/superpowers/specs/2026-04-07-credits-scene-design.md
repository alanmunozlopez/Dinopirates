# Credits Scene — Design Spec
**Date:** 2026-04-07
**Branch:** new-feat
**Status:** Approved

---

## Summary

A scrolling credits scene with a black background and white text/images moving bottom-to-top. Content is defined as a Lua array inline in the scene file. Holding A speeds up scrolling. B exits immediately to TitleScene. When the content finishes scrolling, the scene auto-transitions to TitleScene.

---

## Scope

- New file: `source/scenes/CreditsScene.lua`
- Modified: `source/main.lua` — add `import 'scenes/CreditsScene'`
- Modified: `source/scenes/TitleScene.lua` — add "Credits" menu item that calls `Noble.transition(CreditsScene)`

Not in scope: animated text effects, sound, per-item transitions, pause/resume.

---

## Content Array Format

Defined as a `local credits = { ... }` table inside `CreditsScene.lua`. Three item types:

```lua
local credits = {
    { type = "text",  value = "A game by" },
    { type = "image", path = "assets/images/credits/logo" },
    { type = "text",  value = "Sebastian Zuniga" },
    { type = "space", height = 30 },
    { type = "text",  value = "Music" },
    { type = "text",  value = "..." },
}
```

| Type | Fields | Rendered as |
|---|---|---|
| `"text"` | `value: string` | White text, horizontally centered at x=200 |
| `"image"` | `path: string` | Image loaded in `enter()`, centered horizontally |
| `"space"` | `height: number` | Empty vertical gap |

Items are drawn top-to-bottom in array order.

---

## Scroll Behavior

- `scrollY` starts at `0`, incremented every frame in `update()`
- Normal speed: `1` px/frame
- Fast speed (A held): `3` px/frame
- A is tracked via `isHoldingA` flag: set `true` on `AButtonDown`, `false` on `AButtonUp`
- When `scrollY >= totalContentHeight + 240` → `Noble.transition(TitleScene)`
- B button → `Noble.transition(TitleScene)` immediately

`totalContentHeight` is computed once in `enter()` by summing item heights (text line height + spacing, image height, or explicit space height) plus `ITEM_SPACING` between items.

---

## Layout Constants (defined at top of CreditsScene.lua)

```lua
local SCROLL_SPEED      = 1    -- px/frame normal
local SCROLL_SPEED_FAST = 3    -- px/frame when A held
local LINE_HEIGHT       = 20   -- px per text line
local ITEM_SPACING      = 16   -- px gap between items
local START_OFFSET      = 260  -- initial Y so content starts below screen
```

---

## Drawing

- `scene.backgroundColor = Graphics.kColorBlack`
- All drawing in `scene:drawBackground()`
- Before drawing text: `Graphics.setImageDrawMode(Graphics.kDrawModeFillWhite)`
- Text: `Graphics.drawTextAligned(item.value, 200, y, kTextAlignment.center)`
- Images: `image:draw(x, y)` where `local w, _ = image:getSize(); x = 200 - w / 2` (horizontally centered)
- Items where `y > 240` or `y + itemHeight < 0` are skipped (offscreen optimization)

Images are loaded once in `scene:enter()` into a parallel `loadedImages` table (indexed same as `credits`) to avoid per-frame disk reads.

---

## Input Handler

```lua
CreditsScene.inputHandler = {
    AButtonDown = function() isHoldingA = true end,
    AButtonUp   = function() isHoldingA = false end,
    BButtonDown = function() Noble.transition(TitleScene) end,
}
```

---

## Scene Lifecycle

| Hook | Action |
|---|---|
| `init()` | Standard Noble init |
| `enter()` | Load images into `loadedImages`, compute `totalContentHeight`, reset `scrollY = 0`, `isHoldingA = false` |
| `update()` | Increment `scrollY` by speed, check end condition |
| `drawBackground()` | Draw all visible items |
| `exit()` | Clear `loadedImages` table |

---

## Files Involved

| File | Role |
|---|---|
| `source/scenes/CreditsScene.lua` | Full credits scene + content array |
| `source/main.lua` | Import |
| `source/scenes/TitleScene.lua` | Menu entry point |
| `assets/images/credits/` | Image assets for credits (created by art team) |
