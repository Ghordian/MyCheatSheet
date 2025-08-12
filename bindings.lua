-- bindings.lua
local ADDON_NAME, private = ...

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

BINDING_HEADER_MYCHEATSHEET = L["MY_CHEAT_SHEET"]
BINDING_NAME_MYCHEATSHEET_TOGGLE_UI = L["TOGGLE_MYCHEATSHEET_PANEL"]

-- bindings.lua - fin del archivo