# Plan de Pruebas MyCheatSheet v0.2.0

## 📋 Test Plan Checklist

### 🎯 Objetivo
Validar todas las funcionalidades del addon MyCheatSheet antes del release v0.2.0, con especial énfasis en el nuevo icono del minimapa y la estabilidad general.

---

## 🚀 Preparación del Entorno de Pruebas

### ✅ Setup Inicial
- [ ] **Personaje de prueba creado/seleccionado**
- [ ] **Addon instalado** via deploy script
- [ ] **WoW reiniciado** o `/reload` ejecutado
- [ ] **Verificar que no hay errores** en la consola Lua (`/console scriptErrors 1`)
- [ ] **SavedVariables limpia** (opcional: borrar `MyCheatSheetDB` para pruebas desde cero)

---

## 🎮 Pruebas de Funcionalidad Principal

### 1. ⭐ **Icono del Minimapa** (NUEVA FUNCIONALIDAD)

#### 1.1 Aparición del Icono
- [ ] **Icono visible** en el minimapa tras login/reload
- [ ] **Icono correcto** (libro/pergamino - INV_Misc_Book_09)
- [ ] **Posición inicial** correcta en el minimapa

#### 1.2 Interacciones con Click
- [ ] **Click izquierdo**: Abre panel principal (si estaba cerrado)
- [ ] **Click izquierdo**: Cierra panel principal (si estaba abierto)
- [ ] **Click derecho**: No hace nada (funcionalidad futura)
- [ ] **Click medio**: Oculta el icono del minimapa
- [ ] **Tras ocultar con click medio**: Aparece mensaje en chat

#### 1.3 Tooltip del Minimapa
- [ ] **Hover sobre icono**: Aparece tooltip
- [ ] **Título**: "MyCheatSheet" en dorado
- [ ] **Línea 1**: Instrucción de click izquierdo
- [ ] **Línea 2**: Instrucción de click medio
- [ ] **Línea 3**: Descripción del addon
- [ ] **Colores correctos** en las líneas del tooltip

#### 1.4 Persistencia y Configuración
- [ ] **Posición guardada**: Arrastrar icono, hacer /reload, verificar posición
- [ ] **Visibilidad guardada**: Ocultar icono, hacer /reload, verificar que sigue oculto
- [ ] **Comando restore**: `/mcs minimap` para mostrar icono oculto

### 2. 🖥️ **Panel Principal**

#### 2.1 Apertura del Panel
- [ ] **Keybinding**: `Ctrl+Alt+C` abre el panel
- [ ] **Desde minimapa**: Click izquierdo abre el panel
- [ ] **Comando chat**: `/mcs` abre el panel
- [ ] **Panel se centra** correctamente en pantalla

#### 2.2 Interfaz del Panel
- [ ] **Título**: "MyCheatSheet" visible
- [ ] **Dropdown Clase**: Muestra todas las clases disponibles
- [ ] **Dropdown Especialización**: Se actualiza según clase seleccionada
- [ ] **Dropdown Contenido**: Se actualiza según especialización
- [ ] **Botones**: "Import/Export" y "Edit" visibles y funcionales
- [ ] **Icono del .toc**: Mismo icono que minimapa en lista de addons

#### 2.3 Selección de Datos
- [ ] **Seleccionar clase**: Actualiza especializaciones disponibles
- [ ] **Seleccionar spec**: Actualiza contenido disponible
- [ ] **Seleccionar contenido**: Muestra datos en el panel
- [ ] **Datos mostrados**: Stat Priority, Weapons, Armor, etc. correctos
- [ ] **Formato visual**: Texto legible y bien estructurado

### 3. 📤 **Sistema Import/Export**

#### 3.1 Panel Import/Export
- [ ] **Botón "Import/Export"**: Abre el panel secundario
- [ ] **TextBox grande**: Para pegar datos de importación
- [ ] **Botones**: "Import", "Export Custom", "Close" funcionales
- [ ] **ESC key**: Cierra el panel Import/Export

#### 3.2 Exportación
- [ ] **Export Custom**: Genera string serializado
- [ ] **Datos exportados**: Incluyen clase, spec y contenido actual
- [ ] **String válido**: Formato AceSerializer correcto
- [ ] **Copiable**: String se puede copiar completamente

#### 3.3 Importación - Datos Válidos
- [ ] **Paste datos válidos**: Import Preview se abre automáticamente
- [ ] **Preview Info**: Muestra especialización(es) a importar
- [ ] **Compatibility check**: "Compatible con versión actual"
- [ ] **Validation pass**: "Todos los datos validados"
- [ ] **Botón "Import (Merge)"**: Funcional
- [ ] **Botón "Replace"**: Funcional (sobrescribe datos)

#### 3.4 Import Preview Panel
- [ ] **Auto-apertura**: Se abre al pegar datos válidos
- [ ] **Información detallada**: Versión, clases, specs
- [ ] **Conteo de specs**: "X specialization(s) will be imported"
- [ ] **ESC key**: Cierra Import Preview ANTES que Import/Export
- [ ] **Botón "Cancel"**: Cierra preview sin importar

#### 3.5 Importación - Datos Inválidos
- [ ] **Datos corruptos**: Muestra error apropiado
- [ ] **Formato incorrecto**: Manejo graceful del error
- [ ] **Versión incompatible**: Warning apropiado

### 4. ✏️ **Sistema de Edición**

#### 4.1 Panel de Edición
- [ ] **Botón "Edit"**: Abre panel de edición
- [ ] **TextBox**: Muestra datos actuales editables
- [ ] **Ejemplo**: Texto de ejemplo visible y claro
- [ ] **Instrucciones**: Ayuda sobre formato visible

#### 4.2 Edición de Stat Priority
- [ ] **Formato correcto**: `STAT1 = STAT2 > STAT3 >> STAT4`
- [ ] **Estadísticas válidas**: STRENGTH, AGILITY, INTELLECT, etc.
- [ ] **Operadores válidos**: =, >, >>
- [ ] **Botón "Save"**: Guarda cambios
- [ ] **Botón "Reset"**: Restaura a datos originales
- [ ] **Botón "Cancel"**: Descarta cambios

### 5. 🌍 **Localización y Idiomas**

#### 5.1 Interfaz en Inglés
- [ ] **Cliente en inglés**: Todas las etiquetas en inglés
- [ ] **Tooltips**: Textos en inglés
- [ ] **Mensajes de chat**: En inglés
- [ ] **Botones**: Textos en inglés

#### 5.2 Interfaz en Español
- [ ] **Cliente en español**: Todas las etiquetas en español
- [ ] **Tooltips**: Textos en español
- [ ] **Mensajes de chat**: En inglés (por diseño)
- [ ] **Botones**: Textos en español

---

## 🧪 Pruebas de Estrés y Edge Cases

### 6. 🔄 **Estabilidad y Performance**

#### 6.1 Operaciones Repetitivas
- [ ] **Abrir/cerrar panel**: 10+ veces sin errores
- [ ] **Cambiar clase/spec**: Múltiples veces rápidamente
- [ ] **Import/Export**: Varias operaciones seguidas
- [ ] **Toggle minimapa**: Ocultar/mostrar repetidamente

#### 6.2 Multiples Paneles
- [ ] **Panel principal + Import/Export**: Ambos abiertos simultáneamente
- [ ] **Panel principal + Edit**: Ambos abiertos simultáneamente
- [ ] **Import/Export + Preview**: Comportamiento correcto del ESC

#### 6.3 Datos Extremos
- [ ] **Import muy grande**: Múltiples especializations
- [ ] **Stat priority larga**: Línea muy extensa
- [ ] **Caracteres especiales**: En datos custom

### 7. 🔧 **Integración y Compatibilidad**

#### 7.1 Interacción con WoW
- [ ] **Reloadui**: Addon se recarga correctamente
- [ ] **Login/Logout**: Configuración persistente
- [ ] **Cambio de personaje**: No hay conflictos
- [ ] **Configuración por personaje**: Cada personaje tiene su config

#### 7.2 Comandos de Chat
- [ ] **`/mcs`**: Abre panel principal
- [ ] **`/mcs minimap`**: Muestra icono si está oculto
- [ ] **Comandos inválidos**: Manejo graceful

---

## 🐛 Detección de Errores

### 8. ⚠️ **Casos de Error Comunes**

#### 8.1 Errores de Lua
- [ ] **Sin errores** durante operación normal
- [ ] **Manejo graceful** de datos corruptos
- [ ] **Fallbacks** funcionan si librerías fallan
- [ ] **DebugPrint**: Mensajes apropiados en desarrollo

#### 8.2 Estados Inconsistentes
- [ ] **Panel cerrado**: Keybinding sigue funcionando
- [ ] **Sin datos**: Panel muestra mensaje apropiado
- [ ] **Configuración corrupta**: Addon se recupera

---

## 📊 Validación Final

### 9. ✅ **Checklist Pre-Release**

#### 9.1 Funcionalidad Crítica
- [ ] **Icono minimapa**: 100% funcional
- [ ] **Panel principal**: 100% funcional
- [ ] **Import/Export**: 100% funcional
- [ ] **Edición**: 100% funcional
- [ ] **Localización**: 100% funcional

#### 9.2 Experiencia de Usuario
- [ ] **Interfaz intuitiva**: Fácil de usar para nuevo usuario
- [ ] **Performance fluida**: Sin lag perceptible
- [ ] **Errores mínimos**: No hay errores críticos
- [ ] **Documentación**: Tooltips e instrucciones claras

#### 9.3 Preparación Release
- [ ] **Versión actualizada**: 0.2.0 en .toc
- [ ] **Changelog completo**: Todas las características documentadas
- [ ] **Deploy funcional**: Script de deploy sin errores
- [ ] **Librerías incluidas**: LibDBIcon y LibDataBroker correctos

---

## 📝 Registro de Problemas

### Formato para reportar bugs:
```
❌ **[SEVERIDAD]** Descripción del problema
   📍 Pasos para reproducir:
   1. Paso 1
   2. Paso 2
   💭 Comportamiento esperado: 
   🐛 Comportamiento actual:
   🔧 Posible solución:
```

### Severidades:
- **[CRÍTICO]**: Impide funcionamiento básico
- **[ALTO]**: Afecta funcionalidad importante
- **[MEDIO]**: Problema menor de UX
- **[BAJO]**: Mejora estética o polish

---

**🎯 Meta:** Completar 100% del checklist antes del release v0.2.0

**⏱️ Tiempo estimado:** 45-60 minutos de testing completo

**👤 Tester:** [Tu nombre]
**📅 Fecha:** [Fecha del test]
**🎮 Build:** MyCheatSheet v0.2.0
