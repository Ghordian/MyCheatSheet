# Informe: Secciones Dinámicas en MyCheatSheet

## Resumen

Durante el desarrollo y evolución de MyCheatSheet, hemos debatido la transición de una estructura de datos rígida (secciones fijas por clase/especialización) a un modelo dinámico y flexible de secciones. Este informe resume los puntos clave, ventajas, retos y posibles caminos para implementar secciones dinámicas en el AddOn.

---

## ¿Qué son las secciones dinámicas?

- Permiten definir, añadir, quitar y reordenar bloques de información (secciones) en la hoja de personaje de forma flexible.
- Cada sección puede ser de un tipo distinto: lista de ítems, texto, tabla de estadísticas, notas, etc.
- El layout (estructura y orden de las secciones) puede ser global (para todos los personajes) y los datos pueden ser específicos por clase/especialización o globales.

---

## Ventajas del modelo dinámico

- **Personalización:** Los usuarios pueden crear y compartir sus propias secciones (por ejemplo, “Enchants”, “Macros”, “Notas”).
- **Escalabilidad:** Es fácil añadir nuevos tipos de sección sin modificar la base de datos rígida.
- **Exportación/Importación:** El layout y los datos pueden exportarse e importarse fácilmente (por ejemplo, vía Wago.io).
- **Unificación:** El mismo sistema sirve para secciones “core” (predefinidas) y custom (definidas por el usuario o la comunidad).
- **Evolución:** Permite integrar contribuciones de la comunidad en futuras versiones oficiales del AddOn.

---

## Estructura propuesta

### Layout global (definición de secciones)

```lua
MyCheatSheetDB = {
  layout = {
    { id = "weapons",    title = "Weapons",    type = "itemList",   core = true,  order = 1, subsections = { "BiS", "Alters" } },
    { id = "consumables",title = "Consumables",type = "itemList",   core = true,  order = 2, subsections = { "Direct" } },
    { id = "enchants",   title = "Enchants",   type = "itemList",   core = false, order = 3, subsections = { "Best" } },
    { id = "notes",      title = "Notas",      type = "text",       core = false, order = 4 },
    -- ...más secciones
  },
  -- ...
}
```

### Datos por personaje/especialización

```lua
customData = {
  [classID] = {
    [specID] = {
      weapons = {
        BiS = { itemIDs = { ... } },
        Alters = { itemIDs = { ... } }
      },
      enchants = {
        Best = { itemIDs = { ... } }
      },
      notes = {
        text = "Recuerda usar Flask antes del boss."
      },
      -- ...
    }
  }
}
```

---

## Sub-secciones

- Cada sección de tipo `itemList` puede tener sub-secciones (por ejemplo, “BiS”, “Alters”, “Direct”).
- El layout define qué sub-secciones existen y cómo se llaman.
- Los datos se almacenan por sub-sección.

---

## Migración y compatibilidad

- **No es necesario migrar físicamente los datos rígidos** si solo se van a mapear a secciones dinámicas de solo lectura.
- Un “adaptador” en la UI puede presentar los datos rígidos como bloques dinámicos.
- Los datos custom pueden migrarse a la estructura dinámica si se desea integrarlos como “core” en futuras versiones.

---

## Escenario de integración de datos comunitarios

- Si la comunidad comparte paquetes de secciones y datos custom, estos pueden validarse y convertirse en parte de la base de datos oficial (data-v2).
- El proceso implica recolección, validación, normalización y conversión a la estructura estándar.

---

## Retos y consideraciones

- Adaptar la UI para renderizar secciones y sub-secciones de forma dinámica.
- Definir un sistema de edición y validación de secciones custom.
- Mantener la compatibilidad con datos antiguos durante la transición.

---

## Conclusión

La transición a secciones dinámicas permitirá a MyCheatSheet evolucionar