# MyCheatSheet - Express Test Plan

## Objetivo
Verificar rápidamente que las funcionalidades principales listadas en el changelog están presentes y operativas en la última versión del addon.

---

## 1. Confirmaciones de acciones destructivas
- [ ] Al pulsar "Reset Custom Data" aparece un popup de confirmación.
- [ ] Al pulsar "Clear All Custom Data" aparece un popup de confirmación.
- [ ] Al pulsar "Save Layout" aparece un popup de confirmación con opciones (guardar/resetear).

## 2. Opciones de configuración UI
- [ ] Las opciones "Show Data Edit Buttons" y "Show Layout Edit Button" aparecen en la configuración del addon (Interface > MyCheatSheet).
- [ ] Cambiar estas opciones afecta inmediatamente a la UI (los botones aparecen/desaparecen).

## 3. Edición de layout
- [ ] En modo edición de layout, todas las secciones (incluso las ocultas) son visibles y pueden moverse u ocultarse/mostrarse.
- [ ] No es posible guardar el layout si todas las secciones están ocultas (aparece un mensaje de error).

## 4. Paneles y selectores
- [ ] El panel "List Custom Sheets" funciona y muestra los datos correctamente.
- [ ] Los selectores de clase y especialización funcionan y actualizan la UI.

## 5. Otros
- [ ] El minimapa muestra el icono y responde a los clics según lo esperado.
- [ ] No aparecen mensajes de debug innecesarios en el chat.

---

## Notas
- Realizar las pruebas en un entorno limpio y con datos de ejemplo.
- Si alguna funcionalidad falla, anotar el paso y el error observado.

---

**Fin del plan express.**
