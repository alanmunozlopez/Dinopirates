# Sistema de Triggers Condicionales

Este sistema permite que los Triggers ejecuten diferentes scripts dependiendo del estado del jugador.

## 1. Configuración en LDTK

Agrega un **Custom Field** a tu entidad `Triggers`:

*   **Identificador**: `conditionalScripts`
*   **Tipo**: `Array<String>`

## 2. Tipos de Condiciones

### A. Condiciones Booleanas
*   `isTiny:script` (Si es tiny)
*   `!isTiny:script` (Si NO es tiny)
*   `items.hasLamp:script` (Si tiene lámpara)

### B. Comparaciones Numéricas
Operadores soportados: `>`, `<`, `>=`, `<=`, `==`, `!=`
*   `mapPercent>50:midGameDialogue`
*   `battery<20:lowBatteryWarning`

## 3. Persistencia (IMPORTANTE) [NUEVO]

Por defecto, los scripts condicionales **NO eliminan el trigger**. Esto es útil para mensajes de rechazo o pistas que el jugador puede volver a ver.

Para hacer que un script **SI elimine el trigger** (es decir, que sea de un solo uso), agrega `!` al final del nombre del script.

*   `!hasKey:msgLocked` -> **Mantiene** el trigger. (Puedes verlo muchas veces).
*   `hasKey:openDoor!` -> **Elimina** el trigger. (Solo ocurre una vez).

Si usas el campo `script` normal (fallback), este **siempre elimina el trigger** (comportamiento clásico), **EXCEPTO** si el Trigger es de tipo `Search`. Los triggers de tipo Search persisten por defecto.

## 4. Prioridad

El juego evalúa la lista de **arriba a abajo**. La primera condición que se cumpla ganará.

**Ejemplo completo:**
1.  `!items.hasKey:msgDoorLocked` (Sin llave -> Mensaje recurrente)
2.  `items.hasKey:enterSecretRoom!` (Con llave -> Entrar y borrar trigger)
