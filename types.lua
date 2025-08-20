-- types.lua
-- Contains EmmyLua type definitions for the addon's data structures.

-- DATA V1 - REV07

-- Definiciones de tipos para emmyLua.
---@class MyCheatSheetStatGroup
---@field stats table<number, string>
---@field operator string?
---@field percent number?

---@class MyCheatSheetItemRow
---@field itemIDs table<number, number>

---@class MyCheatSheetInventoryItems
---@field bestInSlot MyCheatSheetItemRow
---@field alternatives MyCheatSheetItemRow

---@class MyCheatSheetWeapons : MyCheatSheetInventoryItems

---@class MyCheatSheetTrinkets : MyCheatSheetInventoryItems

---@class MyCheatSheetTier
---@field bestInSlot MyCheatSheetItemRow

---@class MyCheatSheetContent
---@field statsPriority table<number, MyCheatSheetStatGroup>

---@class MyCheatSheetSpecializationData
---@field author string         # Autor de la hoja
---@field updated string        # Fecha de actualización (yyyy-mm-dd)
---@field patchVersion string   # Versión del parche WoW (11.2.0)
---@field weapons MyCheatSheetWeapons
---@field trinkets MyCheatSheetTrinkets
---@field consumables MyCheatSheetItemRow
---@field tier MyCheatSheetTier
---@field statsByContent table<string, MyCheatSheetContent>

---@class AuthorData
---@field author string         # Autor de la hoja
---@field updated string        # Fecha de actualización (yyyy-mm-dd)
---@field patchVersion string   # Versión del parche WoW (11.2.0)

-- CORE

---@class profiles Profiles
---@field Default ProfileV1

---@class MyCheatSheet : AceAddon
---@field selectedClass number
---@field selectedSpec number
---@field selectedContent string
---@field defaults table
---@field db AceDB
---@field customOverrides table<number, MyCheatSheetSpecializationData>
---@field profilekeys table
---@field lastValidation table
---@field profiles Profiles

-- DATA V2

---@class MyCheatSheetContentV2
---@field statsPriority table<number, MyCheatSheetStatGroup>
---@field weapons MyCheatSheetWeapons
---@field trinkets MyCheatSheetTrinkets

---@class MyCheatSheetSpecializationDataV2
---@field content MyCheatSheetContentV2
---@field consumables MyCheatSheetItemRow
---@field tier MyCheatSheetTier

-- CONFIG

---@class FramePosition
---@field point string  -- Anclaje principal ("CENTER", "TOPLEFT", etc)
---@field x number      -- Offset X relativo al punto
---@field y number      -- Offset Y relativo al punto

---@class ProfileV1
---@field ui table  # Configuración de la UI
---@field ui.position FramePosition  # Posición del frame principal
---@field layout table  # Layout de la UI
---@field layout.sections table<number, table>  # Secciones del layout
---@field advanced.debugMode boolean  # Modo de depuración avanzado

---@class ProfileV2 : ProfileV1
---@field ui.showDataEditButton boolean  # Mostrar botón de edición de datos
---@field ui.showLayoutEditButton boolean  # Mostrar botón de edición de layout

-- types.lua -- fin del archivo