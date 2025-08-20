-- esES.lua

local L = LibStub("AceLocale-3.0"):NewLocale("MyCheatSheet", "esES");
if not L then return; end

-- CORE
L["MY_CHEAT_SHEET"] = "My Cheat-Sheet"
L["TOGGLE_MYCHEATSHEET_PANEL"] = "Abrir UI de MyCheatSheet"

-- UI
L["SELECT_CLASS"] = "Seleccionar Clase"
L["SELECT_SPECIALIZATION"] = "Seleccionar Especialización" 
L["SELECT_CONTENT"] = "Seleccionar Contenido"
L["CLASS_DOTS"] = "Clase:"
L["SPEC_DOTS"] = "Espec.:"
L["CONTENT_DOTS"] = "Contenido:"
L["NO_DATA_SELECTED"] = "Selecciona una especialización y un contenido."
-- NOTAS Y AYUDA
L["IMPORT_EXPORT_NOTE"] = "¿Quieres compartir o guardar tus configuraciones? Usa el botón Importar/Exportar para copiar, pegar o transferir tus hojas de personaje fácilmente entre cuentas o con amigos. ¡No pierdas tu progreso!"

-- IMPORT
L["IMPORT_EXPORT"] = "Importar/Exportar"
L["IMPORT_EXPORT_TITLE"] = "Importar / Exportar"
L["IMPORT_PREVIEW_TITLE"] = "Vista Previa de Importación"
L["EXPORT"] = "Exportar"
L["EXPORT_CURRENT_SPEC"] = "Exportar Especialización Actual"
L["EXPORT_CURRENT_CLASS"] = "Exportar Clase Actual"
L["EXPORT_ALL_DATA"] = "Exportar Todos los Datos"
L["IMPORT"] = "Importar"
L["PASTE_EXPORT_STRING"] = "Pega aquí la cadena de exportación..."
L["PREVIEW_IMPORT"] = "Vista Previa de Importación"
L["QUICK_MERGE"] = "Fusión Rápida"
L["CUSTOM_DATA"] = "Datos Personalizados"
L["LIST_CUSTOM_SHEETS"] = "Listar Hojas Personalizadas"
L["CLEAR_ALL_CUSTOM_DATA"] = "Borrar Todos los Datos Personalizados"
L["CONFIRM_RESET_CUSTOM_DATA"] = "¿Seguro que quieres borrar todos los datos personalizados? Esta acción no se puede deshacer."
L["CONFIRM_RESET_ALL_CUSTOM_DATA"] = "¿Seguro que quieres borrar TODOS los datos personalizados? Esta acción no se puede deshacer."
L["CONFIRM_RESET_SELECTED_CUSTOM_DATA"] = "¿Seguro que quieres borrar las hojas personalizadas seleccionadas? Esta acción no se puede deshacer."

-- EXPORT
L["SELECT_ALL"] = "Seleccionar Todo"
L["CLOSE"] = "Cerrar"
L["SETUP"] = "Configuración"
L["CREATED"] = "Creado"
L["N_SPECS"] = "especialización(es)"

-- IMPORT PREVIEW
L["SETUP_CONTENTS"] = "Contenido del Setup:"
L["SPECIALIZATIONS_WILL_BE_IMPORTED"] = "%d especialización(es) serán importadas"
L["EQUIPMENT_AND_STAT_CONFIGS"] = "Configuraciones de equipamiento y estadísticas"
L["COMPATIBLE_WITH_CURRENT_VERSION"] = "Compatible con la versión actual del addon"
L["ALL_DATA_PASSED_VALIDATION"] = "Todos los datos han pasado las validaciones"
L["EXPORT_VERSION"] = "Versión de exportación: %s"
L["CONTAINS_DATA_FOR"] = "Contiene datos para:"
L["IMPORT_ACTIONS"] = "Acciones de Importación:"
L["LARGE_IMPORT_WARNING"] = "Importación grande (%d specs) - puede tomar un momento"
L["WILL_ADD_NEW_DATA"] = "Esto añadirá nuevos datos a tus hojas personalizadas"
L["EXISTING_DATA_OVERWRITTEN"] = "Los datos existentes con la misma clase/spec pueden ser sobrescritos (modo Reemplazar)"
L["MERGE_MODE_PRESERVES"] = "El modo Fusionar preservará los datos existentes cuando sea posible"
L["VIEW_DETAILS"] = "Ver Detalles"
L["IMPORT_MERGE"] = "Importar (Fusionar)"
L["REPLACE"] = "Reemplazar"
L["CANCEL"] = "Cancelar"

-- IMPORT VIEW DETAILS
L["SPEC_DETAILS"] = "Detalles de la Especialización:"
L["PREV"]  = "Anterior"
L["NEXT"]  = "Siguiente"

-- CUSTOM DATA VIEW
L["SHEETS_SELECTED"] = "seleccionado(s)"

-- EDIT
L["EDIT"] = "Editar"
L["SAVE"] = "Guardar"
L["CANCEL"] = "Cancelar"
L["RESET"] = "Resetear"
L["EXAMPLE"] = "Ejemplo: "
L["EDIT_STATS_PRIORITY"] = "Editar Prioridad de Estadísticas"
L["STATS_EDITOR_HELP_L1"] = "Formato: STAT1 = STAT2 > STAT3 >> STAT4"
L["STATS_EDITOR_HELP_L2"] = "Ejemplo: INTELLECT > HASTE = CRIT > MASTERY"
L["STATS_EDITOR_HELP_L3"] = "STRENGTH >> CRIT = HASTE > VERSATILITY"
L["STATS_EDITOR_HELP_L5"] = "Estadísticas: STRENGTH, AGILITY, INTELLECT, CRIT, HASTE, MASTERY, VERSATILITY"
L["STATS_EDITOR_HELP_L6"] = "Operadores: = (igual), > (mayor), >> (mucho mayor)"
L["CONFIRM_RESET_SIMPLE_EDITOR"] = "¿Seguro que quieres resetear estos datos? Esta acción no se puede deshacer."
L["CONFIRM_RESET_STATS_EDITOR"] = "¿Seguro que quieres resetear las estadísticas? Esta acción no se puede deshacer."
L["ALL_CUSTOM_SHEETS_REMOVED"] = "Todas las hojas personalizadas han sido eliminadas."
L["N_CUSTOM_SHEETS_REMOVED"] = "%d hoja(s) personalizada(s) eliminada(s)."

-- DATA
L["STAT_PRIORITY"] = "Prioridad de Estadísticas"
L["WEAPONS"] = "Armas"
L["BEST_IN_SLOT"] = "Mejor en Hueco"
L["BEST_IN_SLOT_DESC"] = "Mejor objeto en el hueco"
L["ALTERNATIVES"] = "Alternativas"
L["ALTER_BEST_IN_SLOT_DESC"] = "Items alternativos"
L["TRINKETS"] = "Abalorios"
L["CONSUMABLES"] = "Consumibles"
L["TIER"] = "Tier"
L["BIS"] = "BiS"
L["ALT"] = "Alt"

-- UI 
L["AUTHOR"] = "Autor"
L["UPDATED"] = "Fecha"
L["CUSTOM_INFO"] = "Info personalizada"
L["PATCH"] = "Parche"
L["BY"] = "Por"
L["ON"] = "En"

-- CONTENT
L["RAID"] = "Banda"
L["RAID-DAMAGE"] = "Banda - Daño"
L["RAID-TANK"] = "Banda - Defensivo"
L["RAID-HEAL"] = "Banda - Sanación"
L["RAID-CLEAVE"] = "Banda - Daño en area"
L["RAID-DPS"] = "Banda - DPS"
L["MYTHIC_PLUS"] = "Mythic+"
L["DELVES"] = "Profundidades"
L["OPEN_WORLD"] = "Mundo Abierto"
L["DELVES_AND_OPEN_WORLD"] = "Prof. y Mundo Abierto"
L["MYTHIC_PUSH_KEYS"] = "Mythic+ Push Keys"

-- EDITOR
L["ITEM_IDS_SEPARATED_BY_COMMAS"] = "IDs de items separados por comas:"

-- STATS
L["CRIT"] = "Crítico"
L["STRENGTH"] = "Fuerza"
L["AGILITY"] = "Agilidad"
L["INTELLECT"] = "Intelecto"
-- STATS ABBREVIATION (MAX. 4 CHARS)
L["CRIT_ABBE"] = "Crít"
L["STRENGTH_ABBE"] = "Fuer"
L["AGILITY_ABBE"] = "Agil"
L["INTELLECT_ABBE"] = "Inte"
L["HASTE_ABBE"] = "Cele"
L["MASTERY_ABBE"] = "Mast"
L["VERSATILITY_ABBE"] = "Vers"

-- MINIMAP
L["MINIMAP_TOOLTIP_LEFT_CLICK"] = "Click izquierdo: Abrir panel de hojas de trucos"
L["MINIMAP_TOOLTIP_MIDDLE_CLICK"] = "Click medio: Alternar icono del minimapa"
L["MINIMAP_TOOLTIP_ADDON_INFO"] = "Addon de hojas de trucos de personaje"
L["MINIMAP_ICON_HIDDEN"] = "Icono del minimapa oculto. Usa /mcs minimap para mostrarlo."
L["MINIMAP_ICON_SHOWN"] = "Icono del minimapa mostrado."

-- LAYOUT
L["EDIT_LAYOUT"] = "Editar Layout"
L["SAVE_LAYOUT"] = "Guardar Layout"
L["EDIT_STATS"] = "Editar"
L["CONFIRM_SAVE_LAYOUT"] = "¿Quieres guardar los cambios en el layout, resetear al predeterminado o cancelar?"

-- CONFIG
L["RESET_POSITION_OPTION_NAME"] = "Restablecer posición"
L["RESET_POSITION_OPTION_DESC"] = "Restablece la posición de la ventana al centro"
L["SHOW_DATA_EDIT_BUTTONS_OPTION_NAME"] = "Mostrar botones de edición de datos"
L["SHOW_DATA_EDIT_BUTTONS_OPTION_DESC"] = "Muestra u oculta los botones de edición de datos (Editar, BiS, Alt) en cada sección."
L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_NAME"] = "Mostrar botón de edición de layout"
L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_DESC"] = "Muestra u oculta el botón de edición de layout en la interfaz principal."

L["OPAQUE_BACKGROUND_OPTION_NAME"] = "Fondo opaco"
L["OPAQUE_BACKGROUND_OPTION_DESC"] = "Usa un fondo sólido para el panel principal (no transparente)."

L["HIDE_SECTION_TITLES_OPTION_NAME"] = "Ocultar títulos de sección"
L["HIDE_SECTION_TITLES_OPTION_DESC"] = "Si está activado, los títulos de cada sección no se mostrarán."

-- esES.lua -- fin del archivo