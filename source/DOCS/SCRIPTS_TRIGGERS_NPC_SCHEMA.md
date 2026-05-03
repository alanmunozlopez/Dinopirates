# Scripts, Triggers y NPCs — Relación y Schema

Este documento describe la relación entre los tres sistemas y define los schemas necesarios para construir una herramienta de generación de contenido.

---

## 1. Visión general de la relación

```
┌─────────────────────────────────────────────────────────────────┐
│                        LDtk (nivel)                             │
│                                                                 │
│   ┌──────────────────┐         ┌──────────────────┐            │
│   │  Trigger entity  │         │   NPC entity     │            │
│   │  ─────────────── │         │  ─────────────── │            │
│   │  type            │         │  type (sprite)   │            │
│   │  script (fallbk) │         │  sourceFeed      │            │
│   │  conditionalScrp │         │  conditionalScrp │            │
│   │  position + size │         │  hasGranted      │            │
│   └────────┬─────────┘         └────────┬─────────┘            │
│            │                            │                       │
└────────────┼────────────────────────────┼───────────────────────┘
             │  referencia por nombre     │  referencia por nombre
             ▼                            ▼
┌──────────────────────────────────────────────────────────────────┐
│                    script.lua (global `script`)                  │
│                                                                  │
│   { name = "scriptName",                                         │
│     dialog = {                                                   │
│       { video = "player", text = "key-01" },                     │
│       { video = "radioHand", text = "key-02" }                   │
│     }                                                            │
│   }                                                              │
└──────────────────────────────────────────────────────────────────┘
             │  texto localizado
             ▼
┌─────────────────────────────────┐
│   en.strings / jp.strings       │
│   "key-01" = "Texto visible"    │
└─────────────────────────────────┘
```

**Regla central**: ni Trigger ni NPC contienen texto. Solo contienen el _nombre_ de un script. Los scripts contienen el texto (como claves de localización), y el texto está en los `.strings`.

---

## 2. Schema: Script

Definido en `assets/data/script.lua` como tabla global `script`.

```
Script {
  name:   String          -- identificador único, referenciado por Triggers y NPCs
  dialog: DialogLine[]    -- array de líneas en orden
}

DialogLine {
  video:  String          -- estado del portrait (ver lista abajo)
  text:   String          -- clave en en.strings
  screen: Image?          -- (opcional) imagen estática sobre el dialog box
}
```

### Estados válidos de `video`

| Estado | Descripción |
|--------|-------------|
| `player` | Retrato neutral del jugador |
| `playerWorry` | Jugador preocupado |
| `playerSurprise` | Jugador sorprendido |
| `playerHappy` | Jugador feliz |
| `playerAngry` | Jugador enojado |
| `playerSleepy` | Jugador dormido |
| `playerScared` | Jugador asustado |
| `playerCry` | Jugador llorando |
| `radioHand` | Radio en mano |
| `radioPocket` | Radio en bolsillo |
| `radioRing` | Radio sonando |
| `notesHand` | Notas en mano |

> Si `PlayerData.isTiny == true`, el sistema agrega `-tiny` automáticamente al nombre del estado (e.g., `player-tiny`). No existe un estado `tiny` standalone.

---

## 3. Schema: Trigger

Definido como entidad `Triggers` en LDtk. En Lua: `entities/props/trigger.lua`.

```
Trigger {
  -- Posición (LDtk, el x/y es el centro del rect)
  x:                 Number
  y:                 Number
  width:             Number
  height:            Number

  -- Identidad
  iid:               String     -- UUID generado por LDtk, no modificar

  -- Comportamiento
  type:              TriggerType
  script:            String?    -- script fallback si conditionalScripts falla o está vacío
  conditionalScripts: String[]  -- lista de condiciones, evaluadas top-to-bottom
}

TriggerType = "Story" | "Cutscene" | "Search" | "Call" | "Counter" | nil
```

### Tipos de Trigger y su comportamiento de activación

| type | Activación | Acción | Se consume |
|------|-----------|--------|-----------|
| `Story` | Automática (colisión) | `dialogUI:addScreen(script, sourceFeed)` | Sí |
| `Cutscene` | Automática (colisión) | Activa `isCutscene`, corre `Panels` | Sí |
| `Counter` | Automática (colisión) | Incrementa `PlayerData.storyCounter` | Sí |
| `Search` | Manual (presionar A) | `dialogUI:addScreen(script, sourceFeed)` | No (por defecto) |
| `Call` | Manual (presionar A) | `dialogUI:addScreen(script, sourceFeed)` | No (por defecto) |
| `nil` | Manual (presionar A) | `dialogUI:addScreen(script, sourceFeed)` | Sí |

> Los tipos manuales muestran un ícono HUD: `Search` = lupa, `Call` = radio, `nil` = press A.

### Format de `conditionalScripts` (Trigger)

Cada entrada es un string con dos partes separadas por `:`:

```
"condición:scriptName"
"condición:scriptName!"   ← el ! al final hace que se consuma el trigger
```

El `!` terminal es opcional. Sin él, el trigger **permanece activo** (repeatable). Con él, el trigger se marca como `usedTrigger = true` y desaparece.

**Fallback**: si `conditionalScripts` está vacío o ninguna condición aplica, se usa el campo `script` directamente. En ese caso, el trigger se consume excepto si es de tipo `Search`.

---

## 4. Schema: NPC

Definido como entidad `NPC` en LDtk. En Lua: `entities/props/npc.lua`.

```
NPC {
  -- Posición
  x:                 Number
  y:                 Number

  -- Identidad
  iid:               String     -- UUID generado por LDtk

  -- Visual
  type:              String     -- nombre del sprite frame en el spritesheet ("cat", etc.)
  sourceFeed:        Number     -- índice del portrait en el videoFeed del dialog (default: 0)

  -- Comportamiento
  conditionalScripts: String[]  -- lista de condiciones, evaluadas top-to-bottom

  -- Estado persistente (no modificar manualmente)
  hasGranted:        Bool       -- true si ya se aplicaron los grants (SaveSystem lo persiste)
}
```

### Format de `conditionalScripts` (NPC)

Cada entrada es un string con dos o cuatro partes separadas por `:`:

```
"condición:scriptName"
"condición:scriptName:grantKey:grantValue"
```

Los grants se aplican **solo una vez** (controlado por `hasGranted`). Después, el dialog sigue siendo reproducible pero sin grant.

### Formato de grants

| Formato | Ejemplo | Efecto |
|---------|---------|--------|
| Key card | `key:2` | `PlayerData.keys[2] = true` |
| Item booleano | `hasBoots:true` | `PlayerData.items.hasBoots = true` |

Un NPC solo puede dar **un grant por entry**. Para múltiples grants, usar entries separadas con condiciones apropiadas.

---

## 5. Evaluador de condiciones (compartido por Trigger y NPC)

Ambas entidades usan el mismo sistema de evaluación. La condición se resuelve contra `PlayerData`.

### Sintaxis

| Forma | Ejemplo | Evaluación |
|-------|---------|-----------|
| Catch-all | `true` | Siempre verdadero — usar como último fallback |
| Booleano directo | `items.hasLamp` | `PlayerData.items.hasLamp == true` |
| Booleano negado | `!isTiny` | `PlayerData.isTiny ~= true` |
| Comparación numérica | `mapPercent>50` | `PlayerData.mapPercent > 50` |

### Operadores numéricos soportados

`>` `<` `>=` `<=` `==` `!=`

### Rutas de PlayerData comunes para condiciones

```
isTiny                     -- bool: jugador está en modo tiny
items.hasLamp              -- bool: tiene la lámpara
items.hasBoots             -- bool: tiene las botas
items.hasRadio             -- bool: tiene la radio
items.hasBag               -- bool: tiene la bolsa
keys[1]                    -- bool: tiene la llave 1
keys[2]                    -- bool: tiene la llave 2
mapPercent                 -- number: % del mapa explorado (0-100)
battery                    -- number: nivel de batería
healthPoints               -- number: HP actual
storyCounter               -- number: contador de eventos de historia
```

### Orden de evaluación

Las condiciones se evalúan **top-to-bottom**. La primera que aplica gana; el resto se ignoran. Siempre poner `"true:scriptFallback"` como última entrada para garantizar un resultado.

---

## 6. Flujo de interacción completo

```
Jugador toca entidad
        │
        ▼
¿Es Trigger automático?        → colisión ejecuta acción directamente
(Story, Cutscene, Counter)       sin intervención del jugador
        │
        │ No
        ▼
¿Es Trigger manual o NPC?     → player.currentTrigger = entidad
(Search, Call, nil, NPC)        MazeScene muestra ícono HUD
        │
        │ Jugador presiona A
        ▼
MazeScene.AButtonDown()
  PlayerData.isGaming = false
  PlayerData.isTalking = true
  scriptName = trigger:returnScript()
  dialogUI:addScreen(scriptName, trigger.sourceFeed)
        │
        ▼
returnScript() en Trigger o NPC:
  1. Busca la entidad en levelsLDTK por iid
  2. Evalúa conditionalScripts top-to-bottom
  3. Retorna el primer scriptName que aplique
  4. (Solo NPC) Si hay grant y !hasGranted → aplica grant → markGranted()
  5. (Trigger) Si scriptName termina en ! → marca usedTrigger = true
        │
        ▼
dialogUI:addScreen(scriptName)
  1. Busca en la tabla global `script` por name
  2. Si no existe → printDebug y return (sin dialog, sin crash)
  3. Si existe → PlayerData.isTalking = true, muestra primer DialogLine
        │
        │ Jugador presiona A (avanza)
        ▼
dialogUI:nextDialog()
  → siguiente DialogLine, o cierra si era la última
  → al cerrar: PlayerData.isTalking = false, PlayerData.isGaming = true
```

---

## 7. Diferencias clave entre Trigger y NPC

| Aspecto | Trigger | NPC |
|---------|---------|-----|
| Clase base | `Graphics.sprite` | `NobleSprite` |
| Tamaño | Configurable (rect invisible) | Fijo 32×32 (sprite visible) |
| Activación automática | Sí (Story, Cutscene, Counter) | Nunca |
| HUD ícono | Depende del `type` | Siempre "Press A" |
| Grants | No | Sí (`key:N` o `field:true`) |
| Persistencia | `usedTrigger` (se destruye) | `hasGranted` (solo oculta el grant) |
| Se puede repetir | Depende del `!` en script | Siempre (solo el grant es one-shot) |
| `sourceFeed` | Campo en LDtk | Campo en LDtk |
| Fallback script | Campo `script` en LDtk | No hay fallback; falla silencioso |
| Format conditionalScripts | `cond:script` o `cond:script!` | `cond:script` o `cond:script:key:val` |

---

## 8. Persistencia

Ambas entidades se persisten automáticamente por `SaveSystem.save()` al salir de un room.

| Campo | Entidad | Cuándo se modifica |
|-------|---------|-------------------|
| `usedTrigger` | Trigger | Cuando `returnScript()` decide consumirlo |
| `hasGranted` | NPC | Cuando se aplica un grant por primera vez |

El SaveSystem guarda solo los campos modificados (por `iid`) sobre una copia limpia de `levelsLDTK`. No es necesario hacer nada extra.

---

## 9. Reference rápida para generador

Para construir un editor/generador, los datos mínimos por entidad son:

### Script
```json
{
  "name": "string único",
  "dialog": [
    { "video": "player|radioHand|...", "text": "clave-en-strings" }
  ]
}
```

### Trigger
```json
{
  "iid": "uuid",
  "x": 0, "y": 0, "width": 32, "height": 32,
  "type": "Story|Cutscene|Search|Call|Counter|null",
  "script": "nombre-script-fallback",
  "conditionalScripts": [
    "condición:scriptName",
    "condición:scriptName!",
    "true:scriptFallback"
  ]
}
```

### NPC
```json
{
  "iid": "uuid",
  "x": 0, "y": 0,
  "type": "cat",
  "sourceFeed": 0,
  "hasGranted": false,
  "conditionalScripts": [
    "condición:scriptName:grantKey:grantValue",
    "true:scriptFallback"
  ]
}
```

### String entry (en.strings)
```
"clave-en-strings" = "Texto visible para el jugador."
```
