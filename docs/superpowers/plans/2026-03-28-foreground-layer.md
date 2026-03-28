# Foreground Layer Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Cargar una imagen `Fg_Room_X.png` como sprite estético por encima de personajes pero por debajo de la UI, leyendo el flag `hasForeground` del LDtk export.

**Architecture:** Se agrega un nuevo zIndex `foreground` en Config.lua (valor 100, sobre player=4, bajo fx=1999). En MazeScene se carga/descarga el sprite condicionalmente igual que el `floor`, usando la ruta `assets/images/rooms/floor{level}/Fg_{identifier}.png`. No se necesita colisión ni lógica: es puramente visual.

**Tech Stack:** Lua, Playdate SDK (`Graphics.sprite`, `Graphics.image`), Noble Engine

---

## Archivos involucrados

| Archivo | Cambio |
|---------|--------|
| `source/assets/data/Config.lua` | Agregar `foreground = 100` en `Config.ZIndex` |
| `source/scenes/MazeScene.lua` | Cargar/remover sprite foreground condicionalmente |

> **Prerequisito externo:** Correr la herramienta React para regenerar `levels_floor4.lua` con `hasForeground = true/false` en cada room. Si ese campo no existe aún, el código hace nil-check seguro y no carga nada.

---

## Task 1: Agregar zIndex `foreground` en Config

**Files:**
- Modify: `source/assets/data/Config.lua:4-14`

- [ ] **Step 1: Agregar la entrada en Config.ZIndex**

```lua
Config.ZIndex = {
    player     = 4,
    enemy      = 3,
    props      = 2,
    items      = 4,
    foreground = 100,   -- sobre personajes, bajo FX/UI
    fx         = 1999,
    ui         = 2000,
    hud        = 2000,
    menu       = 2100,
    alert      = 2200,
}
```

- [ ] **Step 2: Verificar en simulador que no rompe nada**

Compilar y abrir en simulador:
```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
open "DinoPirates from inner space Brocolation.pdx"
```
Esperado: juego carga normal, sin errores en consola.

- [ ] **Step 3: Commit**

```bash
git add source/assets/data/Config.lua
git commit -m "feat: add foreground zIndex (100) to Config"
```

---

## Task 2: Cargar/descargar el sprite foreground en MazeScene

**Files:**
- Modify: `source/scenes/MazeScene.lua`

El comportamiento es idéntico al sprite `floor` ya existente, pero:
- Ruta: `assets/images/rooms/floor{level}/Fg_{identifier}` (prefijo `Fg_`)
- ZIndex: `ZIndex.foreground` (100)
- Solo se crea si `levelsLDTK[room].customFields.hasForeground == true`
- Si la imagen no existe, `Graphics.image.new()` devuelve nil → skip silencioso

- [ ] **Step 1: Declarar variable local `foregroundSprite` junto a `floor`**

En la sección de variables locales (~línea 50), junto a `local shadow = nil`:

```lua
local foregroundSprite = nil
```

- [ ] **Step 2: Cargar el sprite en `scene:enter()` después del floor**

Después del bloque `-- MARK: Floor` (~línea 115), agregar:

```lua
-- MARK: Foreground
local cf = levelsLDTK[room].customFields
if cf.hasForeground == true then
    local fgPath = 'assets/images/rooms/floor' .. PlayerData.actualLevel
                   .. '/Fg_' .. levelsLDTK[room].identifier
    local fgImage = Graphics.image.new(fgPath)
    if fgImage then
        foregroundSprite = Graphics.sprite.new()
        foregroundSprite:setImage(fgImage)
        foregroundSprite:setZIndex(ZIndex.foreground)
        foregroundSprite:moveTo(200, 120)
        foregroundSprite:add()
    end
end
```

> **Nota:** La variable local `cf` ya se usa más abajo en `scene:enter()` para el shadow. La declaración de foreground debe ir ANTES de esa segunda declaración de `cf` (línea ~248). Si hay conflicto de nombre, renombra la local del foreground a `roomCf`.

- [ ] **Step 3: Remover el sprite en `scene:exit()`**

En `scene:exit()` (~línea 390), junto a `floor:remove()`:

```lua
if foregroundSprite then
    foregroundSprite:remove()
    foregroundSprite = nil
end
```

- [ ] **Step 4: Compilar y probar en simulador**

```bash
pdc source "DinoPirates from inner space Brocolation.pdx"
open "DinoPirates from inner space Brocolation.pdx"
```

Navegar a Room_7 (floor 4). Esperado:
- La imagen `Fg_Room_7.png` aparece sobre el jugador y enemigos
- Está por debajo del HUD/UI
- No hay errores en consola
- Al salir de la room y volver, el sprite se recarga correctamente sin leaks

- [ ] **Step 5: Probar room SIN foreground**

Navegar a cualquier room donde `hasForeground` sea false (o el campo no exista aún). Esperado: carga normal, sin crash, sin sprite fantasma.

- [ ] **Step 6: Commit**

```bash
git add source/scenes/MazeScene.lua
git commit -m "feat: load foreground layer sprite above characters in MazeScene"
```

---

## Resultado final

- Rooms con `hasForeground = true` en LDtk muestran `Fg_Room_X.png` en zIndex 100
- Rooms sin ese flag funcionan igual que antes
- Convención de nombre de archivo: `Fg_{identifier}.png` en la carpeta del floor correspondiente
- Zero impacto en performance para rooms sin foreground
