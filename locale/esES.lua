-- esES.lua

local L = LibStub("AceLocale-3.0"):NewLocale("MyCheatSheet", "esES");
if not L then return; end

-- CORE
L["MY_CHEAT_SHEET"] = "My Cheat-Sheet"
L["TOGGLE_MYCHEATSHEET_PANEL"] = "Abrir UI de MyCheatSheet"

-- UI
L["SELECT_CLASS"] = "Seleccionar clase"
L["SELECT_SPECIALIZATION"] = "Seleccionar Especialización" 
L["SELECT_CONTENT"] = "Seleccionar Contenido"
L["NO_DATA_SELECTED"] = "Selecciona una especialización y un contenido."

-- IMPORT
L["IMPORT_EXPORT"] = "Importar/Exportar"
L["IMPORT_PREVIEW_TITLE"] = "Vista Previa de Importación"

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

-- UI 
L["AUTHOR"] = "Author"
L["UPDATED"] = "Updated"

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

-- MINIMAP
L["MINIMAP_TOOLTIP_LEFT_CLICK"] = "Click izquierdo: Abrir panel de hojas de trucos"
L["MINIMAP_TOOLTIP_MIDDLE_CLICK"] = "Click medio: Alternar icono del minimapa"
L["MINIMAP_TOOLTIP_ADDON_INFO"] = "Addon de hojas de trucos de personaje"
L["MINIMAP_ICON_HIDDEN"] = "Icono del minimapa oculto. Usa /mcs minimap para mostrarlo."
L["MINIMAP_ICON_SHOWN"] = "Icono del minimapa mostrado."

-- esES.lua -- fin del archivo