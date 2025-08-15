-- types.lua
-- Contains EmmyLua type definitions for the addon's data structures.

-- DATA V1 - REV07

-- Definiciones de tipos para emmyLua.
---@class MyCheatSheetStatGroup
---@field stats table<number, string>
---@field operator string?

---@class MyCheatSheetItemRow
---@field itemIDs table<number, number>

---@class MyCheatSheetWeapons
---@field bestInSlot MyCheatSheetItemRow
---@field alternatives MyCheatSheetItemRow

---@class MyCheatSheetTrinkets
---@field bestInSlot MyCheatSheetItemRow
---@field alternatives MyCheatSheetItemRow

---@class MyCheatSheetTier
---@field bestInSlot MyCheatSheetItemRow

---@class MyCheatSheetContent
---@field statsPriority table<number, MyCheatSheetStatGroup>

---@class MyCheatSheetSpecializationData
---@field weapons MyCheatSheetWeapons
---@field trinkets MyCheatSheetTrinkets
---@field consumables MyCheatSheetItemRow
---@field tier MyCheatSheetTier
---@field statsByContent table<string, MyCheatSheetContent>

---@class MyCheatSheet
---@field selectedClass number
---@field selectedSpec number
---@field selectedContent string

-- DATA V2

---@class MyCheatSheetContentV2
---@field statsPriority table<number, MyCheatSheetStatGroup>
---@field weapons MyCheatSheetWeapons
---@field trinkets MyCheatSheetTrinkets

---@class MyCheatSheetSpecializationDataV2
---@field MyCheatSheetContentV2
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

-- types.lua -- fin del archivo
