-- enUS.lua

local L = LibStub("AceLocale-3.0"):NewLocale("MyCheatSheet", "enUS", true);
if not L then return; end

-- CORE
L["MY_CHEAT_SHEET"] = "My CheatSheet"
L["TOGGLE_MYCHEATSHEET_PANEL"] = "Toggle My CheatSheet UI"

-- UI
L["SELECT_CLASS"] = "Select class"
L["SELECT_SPECIALIZATION"] = "Select Specialization"
L["SELECT_CONTENT"] = "Select Content"
L["NO_DATA_SELECTED"] = "Select specialization and content."
-- NOTES AND HELP
L["IMPORT_EXPORT_NOTE"] = "Want to share or back up your setups? Use the Import/Export button to copy, paste, or transfer your character sheets easily between accounts or with friends. Don't lose your progress!"

-- IMPORT/EXPORT
L["IMPORT_EXPORT"] = "Import/Export"
L["IMPORT_EXPORT_TITLE"] = "Import / Export"
L["IMPORT_PREVIEW_TITLE"] = "Import Preview"
L["EXPORT"] = "Export"
L["EXPORT_CURRENT_SPEC"] = "Export Current Spec"
L["EXPORT_CURRENT_CLASS"] = "Export Current Class"
L["EXPORT_ALL_DATA"] = "Export All Data"
L["IMPORT"] = "Import"
L["PASTE_EXPORT_STRING"] = "Paste export string here..."
L["PREVIEW_IMPORT"] = "Preview Import"
L["QUICK_MERGE"] = "Quick Merge"
L["CUSTOM_DATA"] = "Custom Data"
L["LIST_CUSTOM_SHEETS"] = "List Custom Sheets"
L["CLEAR_ALL_CUSTOM_DATA"] = "Clear All Custom Data"
L["CONFIRM_RESET_CUSTOM_DATA"] = "Are you sure you want to reset all custom data? This cannot be undone."
L["CONFIRM_RESET_ALL_CUSTOM_DATA"] = "Are you sure you want to delete ALL custom data? This cannot be undone."
L["CONFIRM_RESET_SELECTED_CUSTOM_DATA"] = "Are you sure you want to delete the selected custom sheets? This cannot be undone."

-- EXPORT
L["SELECT_ALL"] = "Select All"
L["CLOSE"] = "Close"
L["SETUP"] = "Setup"
L["CREATED"] = "Created"
L["N_SPECS"] = "spec(s)"

-- IMPORT PREVIEW
L["SETUP_CONTENTS"] = "Setup Contents:"
L["SPECIALIZATIONS_WILL_BE_IMPORTED"] = "%d specialization(s) will be imported"
L["EQUIPMENT_AND_STAT_CONFIGS"] = "Equipment and stat configurations"
L["COMPATIBLE_WITH_CURRENT_VERSION"] = "Compatible with current addon version"
L["ALL_DATA_PASSED_VALIDATION"] = "All data has passed validation checks"
L["EXPORT_VERSION"] = "Export version: %s"
L["CONTAINS_DATA_FOR"] = "Contains data for:"
L["IMPORT_ACTIONS"] = "Import Actions:"
L["LARGE_IMPORT_WARNING"] = "Large import (%d specs) - may take a moment"
L["WILL_ADD_NEW_DATA"] = "This will add new data to your custom sheets"
L["EXISTING_DATA_OVERWRITTEN"] = "Existing data with same class/spec may be overwritten (Replace mode)"
L["MERGE_MODE_PRESERVES"] = "Merge mode will preserve existing data when possible"
L["VIEW_DETAILS"] = "View Details"
L["IMPORT_MERGE"] = "Import (Merge)"
L["REPLACE"] = "Replace"
L["CANCEL"] = "Cancel"

-- IMPORT VIEW DETAILS
L["SPEC_DETAILS"] = "Spec Details:"
L["PREV"]  = "Prev"
L["NEXT"]  = "Next"

-- CUSTOM DATA VIEW
L["SHEETS_SELECTED"] = "selected"

-- EDIT
L["EDIT"] = "Edit"
L["SAVE"] = "Save"
L["CANCEL"] = "Cancel"
L["RESET"] = "Reset"
L["EXAMPLE"] = "Example: "
L["EDIT_STATS_PRIORITY"] = "Edit Stats Priority"
L["STATS_EDITOR_HELP_L1"] = "Format: STAT1 = STAT2 > STAT3 >> STAT4"
L["STATS_EDITOR_HELP_L2"] = "Example: INTELLECT > HASTE = CRIT > MASTERY"
L["STATS_EDITOR_HELP_L3"] = "STRENGTH >> CRIT = HASTE > VERSATILITY"
L["STATS_EDITOR_HELP_L5"] = "Stats: STRENGTH, AGILITY, INTELLECT, CRIT, HASTE, MASTERY, VERSATILITY"
L["STATS_EDITOR_HELP_L6"] = "Operators: = (equal), > (greater), >> (much greater)"
L["CONFIRM_RESET_SIMPLE_EDITOR"] = "Are you sure you want to reset this data? This cannot be undone."
L["CONFIRM_RESET_STATS_EDITOR"] = "Are you sure you want to reset the stats? This cannot be undone."
L["ALL_CUSTOM_SHEETS_REMOVED"] = "All custom sheets have been removed."
L["N_CUSTOM_SHEETS_REMOVED"] = "%d custom sheet(s) removed."

-- DATA
L["STAT_PRIORITY"] = "Stat Priority"
L["WEAPONS"] = "Weapons"
L["BEST_IN_SLOT"] = "Best in Slot"
L["BEST_IN_SLOT_DESC"] = "Best Item in Slot"
L["ALTERNATIVES"] = "Alternatives"
L["ALTER_BEST_IN_SLOT_DESC"] = "Alternatives Items"
L["TRINKETS"] = "Trinkets"
L["CONSUMABLES"] = "Consumables"
L["TIER"] = "Tier"
L["BIS"] = "BiS"
L["ALT"] = "Alt"

-- UI 
L["AUTHOR"] = "Author"
L["UPDATED"] = "Updated"
L["CUSTOM_INFO"] = "Custom info"
L["PATCH"] = "Patch"
L["BY"] = "By"
L["ON"] = "On"

-- CONTENT
L["RAID"] = "Raid"
L["RAID-DAMAGE"] = "Raid - Damage"
L["RAID-TANK"] = "Raid - Defensive"
L["RAID-HEAL"] = "Raid - Healing"
L["RAID-CLEAVE"] = "Raid - Cleave"
L["RAID-DPS"] = "Raid - DPS"
L["MYTHIC_PLUS"] = "Mythic+"
L["DELVES"] = "Delves"
L["OPEN_WORLD"] = "Open World"
L["DELVES_AND_OPEN_WORLD"] = "Delves & Open World"
L["MYTHIC_PUSH_KEYS"] = "Mythic+ Push Keys"

-- EDITOR
L["ITEM_IDS_SEPARATED_BY_COMMAS"] = "Item IDs separated by commas:"

-- STATS
L["CRIT"] = "Crit"
L["STRENGTH"] = "Strength"
L["AGILITY"] = "Agility"
L["INTELLECT"] = "Intellect"
-- STATS ABBREVIATION (MAX. 4 CHARS)
L["CRIT_ABBE"] = "Crit"
L["STRENGTH_ABBE"] = "Stre"
L["AGILITY_ABBE"] = "Agil"
L["INTELLECT_ABBE"] = "Inte"
L["HASTE_ABBE"] = "Hast"
L["MASTERY_ABBE"] = "Mast"
L["VERSATILITY_ABBE"] = "Vers"

-- MINIMAP
L["MINIMAP_TOOLTIP_LEFT_CLICK"] = "Left click: Open cheat sheet panel"
L["MINIMAP_TOOLTIP_MIDDLE_CLICK"] = "Middle click: Toggle minimap icon"
L["MINIMAP_TOOLTIP_ADDON_INFO"] = "Character cheat sheet addon"
L["MINIMAP_ICON_HIDDEN"] = "Minimap icon hidden. Use /mcs minimap to show it again."
L["MINIMAP_ICON_SHOWN"] = "Minimap icon shown."

-- LAYOUT
L["EDIT_LAYOUT"] = "Edit Layout"
L["SAVE_LAYOUT"] = "Save Layout"
L["EDIT_STATS"] = "Edit"
L["CONFIRM_SAVE_LAYOUT"] = "Do you want to save the changes to the layout, reset to default, or cancel?"

-- CONFIG
L["RESET_POSITION_OPTION_NAME"] = "Reset Position"
L["RESET_POSITION_OPTION_DESC"] = "Reset window position to center"
L["SHOW_DATA_EDIT_BUTTONS_OPTION_NAME"] = "Show Data Edit Buttons"
L["SHOW_DATA_EDIT_BUTTONS_OPTION_DESC"] = "Show or hide the data edit buttons (Edit, BiS, Alt) in each section."
L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_NAME"] = "Show Layout Edit Button"
L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_DESC"] = "Show or hide the layout edit button in the main UI."

L["OPAQUE_BACKGROUND_OPTION_NAME"] = "Opaque Background"
L["OPAQUE_BACKGROUND_OPTION_DESC"] = "Use a solid background template for the main panel (not transparent)."

L["HIDE_SECTION_TITLES_OPTION_NAME"] = "Hide Section Titles"
L["HIDE_SECTION_TITLES_OPTION_DESC"] = "If enabled, the titles of each section will not be displayed."

-- enUS.lua -- end of file