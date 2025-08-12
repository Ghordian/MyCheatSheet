-- types.lua
-- Contains EmmyLua type definitions for the addon's data structures.

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

-- types.lua -- fin del archivo
