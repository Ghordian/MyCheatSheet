-- data.lua
local ADDON_NAME, private = ... 
-- Contains the addon's configuration and item data.
---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

-- La tabla principal contiene los datos del addon.
private.data = {
    -- Un número de versión para el formato de los datos.
--**version = 1, -- inital definition
--**version = 2, -- added MyCheatSheetStatGroup
--**version = 3, -- added tier section
--**version = 4, -- added classID and specID
--**version = 5, -- removed cyrce's circles section
--**version = 6, -- added subsection statsByContent
    version = 7, -- added fields author, updated for each cheat-sheet

    -- Los datos se indexan por classID y specializationID.
    sheets = {
      -- Warrior (1) - Patch 11.2.
      [1] = {
        -- https://www.wowhead.com/guide/classes/warrior/arms/cheat-sheet
        [71] = { -- Arms; By Archimtiros; Updated: 2025/08/03
          author = "Archimtiros",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 243365, 0 } },
            alternatives = { itemIDs = { 237737, 0 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 219314, 242395 } },
            alternatives = { itemIDs = { 242394, 185818 } }, },
          consumables = { itemIDs = { 212283, 212265, 222720, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237608, 237613, 237611, 237609 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "MASTERY" }, operator = "=" },
              { stats = { "VERSATILITY" } }, }, },
            ["MYTHIC_PLUS"] = {statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "MASTERY" }, operator = "=" },
              { stats = { "VERSATILITY" } }, }, },
            ["DELVES"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "MASTERY" }, operator = "=" },
              { stats = { "VERSATILITY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/warrior/fury/cheat-sheet
        [72] = { -- Fury; By Archimtiros; Updated: 2025/08/03
          author = "Archimtiros",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 234490, 222443 } },
            alternatives = { itemIDs = { 237737, 0 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 219314, 242395 } },
            alternatives = { itemIDs = { 232541, 185818 } }, },
          consumables = { itemIDs = { 212283, 212265, 222720, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237608, 237613, 237611, 237609 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "MASTERY" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "CRIT" } }, }, },
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "MASTERY" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "CRIT" } }, }, },
            ["DELVES"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "MASTERY" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "CRIT" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/warrior/protection/cheat-sheet
        [73] = { -- Protection; By Nomeratur; Updated: 2025/08/03
          author = "Nomeratur",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 237734, 237723 } },
            alternatives = { itemIDs = { 185824, 237741 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 219309, 242401 } },
            alternatives = { itemIDs = { 232541, 190652 } }, },
          consumables = { itemIDs = { 212265, 212271, 212283, 224107, 222733 } },
          tier = { bestInSlot = { itemIDs = { 237609, 237611, 237610, 237608 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">=" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">=" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">=" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, }, },
        },
      },

      -- Paladin (2) - Patch 11.2.
      [2] = {
        -- https://www.wowhead.com/guide/classes/paladin/holy/cheat-sheet
        [65] = { -- Holy Paladin; By HolyClarius; Updated: 2025/08/03
          author = "HolyClarius",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 237735, 237723 } },
            alternatives = { itemIDs = { 221150, 242493 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 242392, 242395 } },
            alternatives = { itemIDs = { 219312, 185818 } }, },
          consumables = { itemIDs = { 212274, 212241, 212265, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237620, 237622, 237618, 237617 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" }, operator = ">" },
              { stats = { "HASTE" }, operator = "=" },
              { stats = { "MASTERY" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" }, operator = ">" },
              { stats = { "HASTE" }, operator = ">" },
              { stats = { "CRIT" }, operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/paladin/protection/cheat-sheet
        [66] = { -- Protection Paladin; By Andybrew; Updated: 2025/08/03
          author = "Andybrew",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 237734, 237723 } },
            alternatives = { itemIDs = { 185824, 237741 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 219309, 242401 } },
            alternatives = { itemIDs = { 242402, 232541, 190652 } }, },
          consumables = { itemIDs = { 212283, 212274, 212265, 244839 } },
          tier = { bestInSlot = { itemIDs = { 237620, 237622, 237618, 237617 } } },
          statsByContent = {
            ["RAID-DAMAGE"] = { statsPriority = {
              { stats = { "STRENGTH" },    operator = ">" },
              { stats = { "HASTE" },       operator = ">" },
              { stats = { "CRIT" },        operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
            ["RAID-TANK"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = "=" },
              { stats = { "VERSATILITY" } }, }, },
            ["MYTHIC_PLUS"] = {statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = "=" },
              { stats = { "VERSATILITY" } }, }, },
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "STRENGTH" },    operator = ">" },
              { stats = { "HASTE" },       operator = ">" },
              { stats = { "CRIT" },        operator = ">" },
              { stats = { "VERSATILITY" }, operator = ">" },
              { stats = { "MASTERY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/paladin/retribution/cheat-sheet
        [70] = { -- Retribution Paladin; By Bolas; Updated: 2025/08/03
          author = "Bolas",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 237737, 0 } },
            alternatives = { itemIDs = { 243365, 242487 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 232541, 219314 } }, },
          consumables = { itemIDs = { 212283, 222728, 212265, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237622, 237620, 237619, 237618 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = "=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "MASTERY" },  operator = "=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "MASTERY" },  operator = "=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, }, },
        },
      },

      -- Hunter (3) - Patch 11.2.
      [3] = {
        -- https://www.wowhead.com/guide/classes/hunter/beast-mastery/cheat-sheet
        [253] = { -- Beast Mastery; By Tarlo; Updated: 2025/08/03
          author = "Tarlo",
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 237733, 0 } },
            alternatives = { itemIDs = { 234492, 221143 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242395, 219314 } },
            alternatives = { itemIDs = { 232541, 219312, 185818 } }, },
          consumables = { itemIDs = { 224107, 222728, 212283, 212265, 222720, 244839, 212256, 224572 } },
          tier = { bestInSlot = { itemIDs = { 237646, 237644, 237649, 237645 } }, },
          statsByContent = {
            -- Pack Leader Single-Target Build
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } }, }, },
            -- Pack Leader Multi-Shot AoE
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } }, }, },
            -- Open World / Delve / Horrific Visions Build
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/hunter/marksmanship/cheat-sheet
        [254] = { -- marksmanship; By TheAzortharion; Updated: 2025/08/03
          author = "TheAzortharion",
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 185783, 0 } },
            alternatives = { itemIDs = { 237732, 0 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 219308, 0 } }, },
          consumables = { itemIDs = { 212283, 212265, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237646, 237644, 237649, 237645 } }, },
          statsByContent = {
            -- Dark Ranger Single-Target Build
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Dark Ranger Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" } },}, },
            -- Dark Ranger Open World / Delve
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/hunter/survival/cheat-sheet
        [255] = { -- Survival; By DoolB; Updated: 2025/08/05
          author = "DoolB",
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 242481, 0 } },
            alternatives = { itemIDs = { 222448, 221159 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242402, 232541 } },
            alternatives = { itemIDs = { 219308, 242395, 219312 } }, },
          consumables = { itemIDs = { 212283, 224107, 224572 } },
          tier = { bestInSlot = { itemIDs = { 237646, 237644, 237645, 237649 } }, },
          statsByContent = {
            -- Pack Leader Raid
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Pack Leader Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Sentinel Delve
            ["DELVES"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
          },
        },
      },

      -- Rogue (4) - Patch 11.2.
      [4] = {
        -- https://www.wowhead.com/guide/classes/rogue/assassination/cheat-sheet
        [259] = { -- Assassination
          author = "Whispyr",
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 237740, 237729 } },
            alternatives = { itemIDs = { 221138, 0 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242494, 242395 } },
            alternatives = { itemIDs = { 242402, 219314, 242396 } }, },
          consumables = { itemIDs = { 212283, 212265, 220156, 222504, 222733 } },
          tier = { bestInSlot = { itemIDs = { 237665, 237664, 237663, 237662 } }, },
          statsByContent = {
            -- Raid Single Target
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Raid AoE
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/rogue/outlaw/cheat-sheet
        [260] = { -- Outlaw; By JustGuy; Updated: 2025/08/03
          author = "JustGuy",
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 237731, 234493 } },
            alternatives = { itemIDs = { 221128, 221138 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242397, 242395 } },
            alternatives = { itemIDs = { 219314, 232541 } }, },
          consumables = { itemIDs = { 212277, 212265, 222504 } },
          tier = { bestInSlot = { itemIDs = { 237664, 237663, 237667, 237662 } }, },
          statsByContent = {
            -- Raid Single Target
            ["RAID-DPS"] = { statsPriority = { 
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Raid AoE
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/rogue/subtlety/overview-pve-dps
        [261] = { -- Subtlety; By fuu1; Updated: 2025/08/03
          author = "fuu1", -- https://www.wowhead.com/author/fuu1
          updated = "2025/08/03",
          weapons = {
            bestInSlot = { itemIDs = { 237731, 234493 } },
            alternatives = { itemIDs = { 221128, 221138 } }, },
          trinkets = {
            bestInSlot = { itemIDs = { 242397, 242395 } },
            alternatives = { itemIDs = { 219314, 232541 } }, },
          consumables = { itemIDs = { 212277, 212265, 222504 } },
          tier = { bestInSlot = { itemIDs = { 237664, 237663, 237667, 237662 } }, },
          statsByContent = {
            -- Raid Single Target
            ["RAID-DPS"] = { statsPriority = { 
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Raid AoE
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } }, }, },
          },
        },
      },

      -- Priest (5) - Patch 11.2.
      [5] = {
        -- https://www.wowhead.com/guide/classes/priest/discipline/cheat-sheet
        [256] = { -- Discipline
          author = "AutomaticJak",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237730 } },
          },
          trinkets = {
            bestInSlot   = { itemIDs = { 242393, 242392 } },
            alternatives = { itemIDs = { 242497, 238386 } },
          },
          consumables = { itemIDs = { 212274, 224107, 212241 } },
          tier = { bestInSlot = { itemIDs = { 237709, 237707, 237712, 237710 } }, },
          statsByContent = {
            -- Oracle Raid; 
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "CRIT" },       operator = "=" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- Oracle Mythic+; 
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "CRIT" },       operator = "=" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- VW Mythic+; 
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" } }, }, },
            -- Delves/Open-World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/priest/holy/cheat-sheet
        [257] = { -- Holy; By AutomaticJak; Updated: 2025/08/03
          author = "AutomaticJak",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237730 } },
          },
          trinkets = {
            bestInSlot   = { itemIDs = { 242393, 242392 } },
            alternatives = { itemIDs = { 190958, 242395 } },
          },
          consumables    = { itemIDs = { 212274, 224107, 212241 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237709, 237707, 237712, 237708 } }, },
          statsByContent = {
            -- Oracle Raid
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "HASTE" } }, }, },
            -- Archon Raid
            ["RAID-HEAL"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "HASTE" } }, }, },
            -- Oracle Mythic+
            ["MYTHIC_PUSH_KEYS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Archon Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } }, }, },
            -- Delves/Open-World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } }, }, },
          },
        },
        -- https://www.wowhead.com/guide/classes/priest/shadow/cheat-sheet
        [258] = { -- Shadow; By EllipsisPriest; Updated: 2025/08/03
          author = "EllipsisPriest",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237730, 221122, 221132, 222568 } },
          },
          trinkets = {
            bestInSlot   = { itemIDs = { 242402, 242392 } },
            alternatives = { itemIDs = { 242495, 242497, 219308, 242395 } },
          },
          consumables = { itemIDs = { 212283, 212265, 224107 } },
          tier = { bestInSlot = { itemIDs = { 237710, 237709, 237708, 237712 } }, },
          statsByContent = {
            -- 
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- 
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
            -- 
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } }, }, },
          },
        },
      },

      -- Death Knight (6) - Patch 11.2.
      [6] = {
        -- https://www.wowhead.com/guide/classes/death-knight/blood/cheat-sheet
        [250] = { -- Blood; By Mandl; Updated: 2025/08/03
          author = "Mandl",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot = { itemIDs = { 243365, 0 } },
            alternatives = { itemIDs = { 237725, 242487 } }, },
          trinkets = { 
            bestInSlot = { itemIDs = { 219309, 190652 } },
            alternatives = { itemIDs = { 242402, 242396, 242394, 242401, 246344 } }, },
          consumables = { itemIDs = { 212283, 212265, 224105, 243191 } },
          tier = { bestInSlot = { itemIDs = { 237628, 237626, 237631, 237629 } } },
          statsByContent = {
            -- Raid (SL)
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" },     operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">=" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "MASTERY" } },},},
            -- Raid (DB)
            ["RAID-DPS"] = { statsPriority = {
              { stats = { "STRENGTH" },     operator = ">>" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" } },},},
            -- Raid (DB,no tier)
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "STRENGTH" },     operator = ">>" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" } },},},
            -- Mythic+ (SL); Mythic+ (DB); Mythic+ (DB,no tier)
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" },     operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">=" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "MASTERY" } },},},
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "STRENGTH" },     operator = ">>" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "HASTE" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/death-knight/frost/cheat-sheet
        [251] = { -- Frost; By khazakdk; Updated: 2025/08/03
          author = "khazakdk",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 222447, 0 } },
            alternatives = { itemIDs = { 237737, 237813, 237813 } }, },
          trinkets = { 
            bestInSlot   = { itemIDs = { 238390, 246945 } },
            alternatives = { itemIDs = { 242402, 242396, 242395 } }, },
          consumables = { itemIDs = { 212283, 244839, 224107, 212265, 224572 } },
          tier = { bestInSlot = { itemIDs = { 237631, 237628, 237627, 237626 } } },
          statsByContent = {
            -- Raid Rider; Raid Deathbringer
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Mythic+ Rider; Mythic+ Deathbringer; 
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Delves/Open World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/death-knight/unholy/cheat-sheet
        [252] = { -- Unholy; By Taeznak; Updated: 2025/08/03
          author = "Taeznak",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 242487, 0 } },
            alternatives = { itemIDs = { 234490, 237725, 243365 } }, },
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 219314, 238386, 246344, 232541 } }, },
          consumables    = { itemIDs = { 212265, 224107, 212283 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237628, 237631, 237627, 237626 } } },
          statsByContent = {
            -- Rider ST; San'layn ST
            ["RAID"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "HASTE" },    operator = ">=" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">>" },
              { stats = { "VERSATILITY" } },},},
            -- Rider Raid Cleave; San'layn Raid Cleave
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "HASTE" },    operator = ">=" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">>" },
              { stats = { "VERSATILITY" } },},},
            -- San'layn M+ ; Rider M+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "HASTE" },    operator = ">=" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">>" },
              { stats = { "VERSATILITY" } },},},
            -- Delves/Open World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "STRENGTH" }, operator = ">>" },
              { stats = { "HASTE" },    operator = ">=" },
              { stats = { "MASTERY" },  operator = ">=" },
              { stats = { "CRIT" },     operator = ">>" },
              { stats = { "VERSATILITY" } },},},
          },
        },
      },

      -- Shaman (7) - Patch 11.2.
      [7] = {
      -- https://www.wowhead.com/guide/classes/shaman/elemental/cheat-sheet
        [262] = { -- Elemental; By HawkCorrigan; Updated: 2025/08/03
          author = "HawkCorrigan",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237730, 221122 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242392 } },
            alternatives = { itemIDs = { 242497, 242494 } },},
          consumables    = { itemIDs = { 212283, 212265, 224572, 222732, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237635, 237640, 237638, 237636 } } },
          statsByContent = {
            -- Raid pre-4p ; Raid post-4p
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" } },},},
            -- Mythic+ pre-4p ; Mythic+ post-4p
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/shaman/enhancement/cheat-sheet
        [263] = { -- Enhancement; By wordup; Updated: 2025/08/03
          author = "wordup",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 185823, 222446 } },
            alternatives = { itemIDs = { 237738, 178834, 221128 } },
          },
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 232541 } },
            alternatives = { itemIDs = { 242395, 185818, 219308 } },
          },
          consumables    = { itemIDs = { 212283, 212265, 244839 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237637, 237635, 237638, 237636 } } },
          statsByContent = {
            -- Stormbringer Raid ; Totemic Raid 
            ["RAID"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } },},},
            -- Stormbringer M+ ; Totemic M+ 
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } },},},
            -- Delves
            ["DELVES"] = { statsPriority = {
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "AGILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/shaman/restoration/cheat-sheet
        [264] = { -- Restoration; By Theun; Updated: 2025/08/03
          author = "Theun",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237723 } },},
          trinkets = {
            bestInSlot   = { itemIDs = { 242395, 190958 } },
            alternatives = { itemIDs = { 219308, 242392 } },},
          consumables    = { itemIDs = { 212283, 224571, 191368 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237637, 237640, 237638, 237636 } } },
          statsByContent = {
            -- Raid
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Delves / Open World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
          },
        },
      },

      -- Mage (8) - Patch 11.2.
      [8] = {
        -- https://www.wowhead.com/guide/classes/mage/arcane/cheat-sheet
        [62] = { -- Arcane; By Porom; Updated: 2025/08/03
          author = "Porom",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237728, 237742, 237730, 222568 } },
          },
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242497, 219314 } },
            alternatives = { itemIDs = { 190958, 219312, 242392, 219308, 242395 } },
          },
          consumables    = { itemIDs = { 212283, 212274, 212265, 224107, 222720 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237718, 237716, 237721, 237717 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "MASTERY" },      operator = "=" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" } },},},
            ["RAID-CLEAVE"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "MASTERY" },      operator = "=" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" } },},},
            ["MYTHIC_PLUS"] = {
                statsPriority = {
                  { stats = { "INTELLECT" },    operator = ">" },
                  { stats = { "HASTE" },        operator = ">" },
                  { stats = { "VERSATILITY" },  operator = "=" },
                  { stats = { "MASTERY" },      operator = ">" },
                  { stats = { "CRIT" } },
              },
            },
            ["DELVES_AND_OPEN_WORLD"] = {
                statsPriority = {
                  { stats = { "INTELLECT" },    operator = ">" },
                  { stats = { "HASTE" },        operator = ">" },
                  { stats = { "VERSATILITY" },  operator = "=" },
                  { stats = { "MASTERY" },      operator = ">" },
                  { stats = { "CRIT" } },
              },
            },
          },
        },
        -- https://www.wowhead.com/guide/classes/mage/fire/cheat-sheet
        [63] = { -- Fire; By Preheat; Updated: 2025/08/03
          author = "Preheat",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237728, 237730, 221165, 222568 } },
          },
          trinkets = { 
            bestInSlot   = { itemIDs = { 242497, 219314 } },
            alternatives = { itemIDs = { 242395, 242392, 190958, 242494, 242402 } },
          },
          consumables    = { itemIDs = { 212274, 212283, 212265, 224105, 222728 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237716, 237721, 237717, 237719 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
                  { stats = { "HASTE" },        operator = ">" },
                  { stats = { "INTELLECT" },    operator = ">" },
                  { stats = { "VERSATILITY" },  operator = ">=" },
                  { stats = { "MASTERY" },      operator = ">" },
                  { stats = { "CRIT" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
                  { stats = { "HASTE" },        operator = ">" },
                  { stats = { "INTELLECT" },    operator = ">" },
                  { stats = { "MASTERY" },      operator = ">" },
                  { stats = { "VERSATILITY" },  operator = ">" },
                  { stats = { "CRIT" } },},},
            -- Frostfire Delves/Open World
            ["DELVES_AND_OPEN_WORLD"] = {
                statsPriority = {
                  { stats = { "HASTE" },        operator = ">" },
                  { stats = { "INTELLECT" },    operator = ">" },
                  { stats = { "CRIT" },         operator = ">" },
                  { stats = { "VERSATILITY" },  operator = ">" },
                  { stats = { "MASTERY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/mage/frost/cheat-sheet
        [64] = { -- Frost; By Dorovon; Updated: 2025/08/07
          author = "Dorovon",
          updated = "2025/08/07",
          weapons = { 
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 222568 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242497 } },
            alternatives = { itemIDs = { 242395, 242392, 242494, 219314, 219312, 190958 } },},
          consumables    = { itemIDs = { 212283, 212265, 244839, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237718, 237716, 237719, 237717 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
          },
        },
      },

      -- Warlock (9) - Patch 11.2.
      [9] = {
        -- https://www.wowhead.com/guide/classes/warlock/affliction/cheat-sheet
        [265] = { -- Affliction; By Kalamazi; Updated: 2025/08/03
          author = "Kalamazi",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237730 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 242497, 242392 } },},
          consumables    = { itemIDs = { 212283, 212265, 222735, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237701, 237700, 237699, 237703 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/warlock/demonology/cheat-sheet
        [266] = { -- Demonology; By NotWarlock; Updated: 2025/08/03
          author = "NotWarlock",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 185821, 237730 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 242497, 242392, 219308, 219312 } },},
          consumables    = { itemIDs = { 212274, 212265, 222735, 224107 } },
          tier = {
            bestInSlot   = { itemIDs = { 237700, 237698, 237703, 237699 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/warlock/destruction/cheat-sheet
        [267] = { -- Destruction; By Loozy; Updated: 2025/08/03
          author = "Loozy",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237730 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242392 } },
            alternatives = { itemIDs = { 242497, 219314 } },},
          consumables    = { itemIDs = { 212283, 212265, 222735, 224107 } },
          tier = {
            bestInSlot   = { itemIDs = { 237700, 237698, 237703, 237699 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
      },

      -- Monk (10)
      -- Monk; 64; Conduit of the Celestials; 65; Shado-pan; 66; Master of Harmony
      [10] = {
      -- https://www.wowhead.com/guide/classes/monk/brewmaster/cheat-sheet
        [268] = { -- Brewmaster - By Sinzhu; Updated: 2025/08/03
          author = "Sinzhu",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 221159, 0 } },
            alternatives = { itemIDs = { 242481, 221144, 221128 } },},
          trinkets = {
            bestInSlot   = { itemIDs = { 242401, 242391 } },
            alternatives = { itemIDs = { 232543, 219309, 242395, 242404 } },},
          tier = {
            bestInSlot   = { itemIDs = { 237673, 237671, 237676, 237674 } } },
          consumables    = { itemIDs = { 212283, 212265, 244839, 222510, 222504 } },
          trinketsByContent = {
            -- Shado-Pan[65]
            ["RAID-TANK"] = { 
              bestInSlot   = { itemIDs = { 242401, 190652 } },
              alternatives = { itemIDs = { 242395, 219309, 242397, 232541 } },
            },
            -- Master of Harmony[66]
            ["RAID-DAMAGE"] = {
              bestInSlot   = { itemIDs = { 242401, 242391 } },
              alternatives = { itemIDs = { 232543, 219309, 242395, 242404 } },
            },
            -- Mythic+ (Standard) - Master of Harmony[66]
            ["MYTHIC_PLUS"] = {
              bestInSlot   = { itemIDs = { 242401, 242397 } },
              alternatives = { itemIDs = { 232541, 242391, 242395, 219308 } },
            },
            -- Mythic+ (Advanced) - Shado-Pan[65]
            ["MYTHIC_PUSH_KEYS"] = {
              bestInSlot   = { itemIDs = { 242401, 242397 } },
              alternatives = { itemIDs = { 232541, 242391, 242395, 242494 } },
            },
            -- Delves & Open World - Shado-Pan[65]
            ["DELVES_AND_OPEN_WORLD"] = {
              bestInSlot   = { itemIDs = { 242401, 190652 } },
              alternatives = { itemIDs = { 242397, 219309, 242395, 242396 } },
            },
          },
          statsByContent = {
            -- Raid (Defensive) - Master of Harmony[66]
            ["RAID-TANK"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" } },},},
            -- Raid (Offensive) - Shado-Pan[65]
            ["RAID-DAMAGE"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" } },},},
            -- Mythic+ (Standard) - Master of Harmony[66]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">>" },
              { stats = { "HASTE" } },},},
            -- Mythic+ (Advanced) - Shado-Pan[65]
            ["MYTHIC_PUSH_KEYS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = "=" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" } },},},
            -- Delves & Open World - Shado-Pan[65]
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">>" },
              { stats = { "HASTE" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/monk/mistweaver/cheat-sheet
        [270] = { -- Mistweaver; By JuneMW; Updated: 2025/08/03
          -- DELVES / OPEN WORLD
          author = "JuneMW",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237730, 185812 } },},
          trinkets = {
            bestInSlot   = { itemIDs = { 242392, 242402} },
            alternatives = { itemIDs = { 242395, 219308 } },},
          tier = {
            bestInSlot   = { itemIDs = { 237673, 237671, 237674, 237672 } } },
          consumables    = { itemIDs = { 212274, 224107, 212241, 212265 } },
          statsByContent = {
            -- Yu'lon Raid Healing - Conduit of the Celestials [64]
            ["RAID-HEAL"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Chi-Ji Raid Healing - Conduit of the Celestials [64]
            ["RAID-DAMAGE"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Mythic+ - Master of Harmony [66]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "VERSATILITY" } },},},
            -- Delves - Master of Harmony [66]
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">>" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" },      operator = ">=" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/monk/windwalker/cheat-sheet
        [269] = { -- Windwalker; By Babylonius; Updated: 2025/08/04
          -- DELVES / OPEN WORLD
          author = "Babylonius",
          updated = "2025/08/04",
          weapons = { 
            bestInSlot   = { itemIDs = { 221159, 0 } },
            alternatives = { itemIDs = { 237726, 0 } },
          },
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 242494, 232541 } },
          },
          tier = { 
            bestInSlot   = { itemIDs = { 237676, 237674, 237672, 237671 } } },
          consumables    = { itemIDs = { 212283, 212265, 224572 } },
          statsByContent = {
            -- Shado-Pan [65]
            ["RAID"] = {
                statsPriority = {
              { stats = { "AGILITY" },          operator = ">" },
              { stats = { "MASTERY", "HASTE" }, operator = ">>" },
              { stats = { "VERSATILITY" },      operator = "=" },
              { stats = { "CRIT" } },},},
            -- Shado-Pan [65]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },          operator = ">" },
              { stats = { "MASTERY", "HASTE" }, operator = ">>" },
              { stats = { "VERSATILITY" },      operator = "=" },
              { stats = { "CRIT" } },},},
            -- Shado-Pan [65]
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "AGILITY" },          operator = ">" },
              { stats = { "MASTERY", "HASTE" }, operator = ">>" },
              { stats = { "VERSATILITY" },      operator = "=" },
              { stats = { "CRIT" } },},},
          },
        },
      },

      -- Druid (11) - Patch 11.2.
      [11] = {
        -- https://www.wowhead.com/guide/classes/druid/balance/cheat-sheet
        [102] = { -- Balance; By tettles; Updated: 2025/08/03
          author = "tettles",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237730, 0 } },
            alternatives = { itemIDs = { 237735, 222566 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242395 } },
            alternatives = { itemIDs = { 242392, 242497 } },},
          consumables    = { itemIDs = { 212265, 212283, 224107 } },
          tier = {
            bestInSlot   = { itemIDs = { 237682, 237680, 237683, 237681 } } },
          statsByContent = {
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/druid/feral/cheat-sheet
        [103] = { -- Feral; By Guiltyas; Updated: 2025/08/03
          author = "Guiltyas",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 221159, 0 } },
            alternatives = { itemIDs = { 237726, 234494 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 232541 } },
            alternatives = { itemIDs = { 219314, 242397 } },},
          consumables    = { itemIDs = { 212283, 212265, 224572 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237682, 237681, 237685, 237683 } } },
          statsByContent = {
            -- Raid; Druid of the Claw
            ["RAID"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Mythic+; Druid of the Claw
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Delves; Druid of the Claw
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "AGILITY" },  operator = ">" },
              { stats = { "MASTERY" },  operator = ">" },
              { stats = { "CRIT" },     operator = ">=" },
              { stats = { "HASTE" },    operator = ">" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/druid/guardian/cheat-sheet
        [104] = { -- Guardian; By Pumps; Updated: 2025/08/03
          author = "Pumps",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237726, 0 } },
            alternatives = { itemIDs = { 243365, 0 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 219309, 232541 } },
            alternatives = { itemIDs = { 242401, 242402, 232543 } },},
          consumables    = { itemIDs = { 212283, 212265, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237685, 237682, 237681, 237680 } } },
          statsByContent = {
            -- Raid; Druid of the Claw
            ["RAID"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Mythic+; Elune's Chosen
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } },},},
            -- Delves; Elune's Chosen
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/druid/restoration/cheat-sheet
        [105] = { -- Restoration; By Voulk; Updated: 2025/08/03
          author = "Voulk",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237730, 0 } },
            alternatives = { itemIDs = { 222568, 237728 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 190958, 242392 } },
            alternatives = { itemIDs = { 219314, 219312 } },},
          consumables    = { itemIDs = { 212274, 212241, 224107 } },
          tier = {
            bestInSlot   = { itemIDs = { 237682, 237680, 237685, 237683 } } },
          statsByContent = {
            -- Raid WS; Wildstalker
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">>" },
              { stats = { "CRIT" } },},},
            -- Raid KotG; Keeper of the Grove
            ["RAID-HEAL"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">>" },
              { stats = { "CRIT" } },},},
            -- Mythic+; Wildstalker
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" } },},},
            -- Delves; Wildstalker
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "MASTERY" } },},},
          },
        },
      },

      -- Demon Hunter (12) - Patch 11.2.
      [12] = {
      -- https://www.wowhead.com/guide/classes/demon-hunter/havoc/cheat-sheet
        [577] = { -- Havoc; By Shadarek; Updated: 2025/08/03
          author = "Shadarek",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237727, 222441 } },
            alternatives = { itemIDs = { 185780, 185778, 237738 } },},
          trinkets = {
            bestInSlot   = { itemIDs = { 242395, 242397 } },
            alternatives = { itemIDs = { 185818, 232541, 190652 } },},
          consumables    = { itemIDs = { 212283, 212265, 244839, 224107, 222728 } },
          tier = {
            bestInSlot   = { itemIDs = { 237691, 237689, 237694, 237692 } } },
          statsByContent = {
          -- Aldrachi [35] Raid
          -- Fel Scarred [34] Raid 
            ["RAID"] = { statsPriority = {
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "AGILITY" } },},},
          -- Aldrachi [35] Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "AGILITY" } },},},
          -- Fel Scarred [34] Mythic+
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "AGILITY" } },},},
          -- Fel Scarred [34] Delves/Open World
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "AGILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/demon-hunter/vengeance/cheat-sheet
        [581] = { -- Vengeance-tank; By Itamae; Updated: 2025/08/03
          author = "Itamae",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 234491, 222440 } },
            alternatives = { itemIDs = { 185778, 0 } },
          },
          trinkets = { 
            bestInSlot   = { itemIDs = { 190958, 219309 } },
            alternatives = { itemIDs = { 232541, 242402, 219314, 232543 } },
          },
          consumables    = { itemIDs = { 212283, 212265, 224107, 222720 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237689, 237690, 237692, 237694 } } },
          statsByContent = {
            -- Raid; Fel-Scarred [34]
            ["RAID"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "MASTERY" } },},},
            -- Mythic+; Aldrachi Reaver [35]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "MASTERY" } },},},
            -- Delves; Fel-Scarred [34]
            ["DELVES"] = { statsPriority = {
              { stats = { "AGILITY" },      operator = ">>" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "CRIT" },         operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">=" },
              { stats = { "MASTERY" } },},},},
        },
      },

      -- Evoker (13) - Patch 11.2.
      [13] = {
        -- https://www.wowhead.com/guide/classes/evoker/devastation/cheat-sheet
        [1467] = { -- Devastation; By Preheat; Updated: 2025/08/03 [DPS]
          author = "Preheat",
          updated = "2025/08/03",
          weapons = {
            bestInSlot   = { itemIDs = { 237735, 222566 } },
            alternatives = { itemIDs = { 237728, 237730, 221165, 222568, 222450 } },},
          trinkets = {
            bestInSlot   = { itemIDs = { 242402, 242497 } },
            alternatives = { itemIDs = { 242395, 219314, 242392 } },},
          consumables    = { itemIDs = { 212283, 212265, 224105, 222728 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237655, 237653, 237658, 237654 } } },
          statsByContent = {
            -- Flameshaper [37] Raid
            -- Scalecommander [36] Raid
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = ">=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">=" },
              { stats = { "VERSATILITY" } },},},
            -- Scalecommander [36] Mythic+
            ["RAID-DAMAGE"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "CRIT" },       operator = ">=" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "MASTERY" },    operator = ">=" },
              { stats = { "VERSATILITY" } },},},
            -- Flameshaper [37] Mythic+ Scintillation
            -- Flameshaper [37] Mythic+ Firestorm
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "MASTERY" },    operator = ">=" },
              { stats = { "VERSATILITY" } },},},
            -- Delves/Open World - Scalecommander [36]
            ["DELVES_AND_OPEN_WORLD"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "CRIT" },       operator = ">=" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "MASTERY" },    operator = ">=" },
              { stats = { "VERSATILITY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/evoker/preservation/cheat-sheet
        [1468] = { -- Preservation; By Voulk; Updated: 2025/08/03 - [healer]
          author = "Voulk",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237730, 0 } },
            alternatives = { itemIDs = { 222568, 237728 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 219314, 242392 } },
            alternatives = { itemIDs = { 219312 } },},
          consumables    = { itemIDs = { 212280, 212265, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237655, 237653, 237656, 237654 } } },
          statsByContent = {
            -- Raid; Flameshaper [37]
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">>" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = ">" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Mythic+; Chronowarden [38]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Delves; Chronowarden [38]
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "HASTE" },        operator = ">" },
              { stats = { "CRIT" },         operator = ">" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "MASTERY" } },},},
          },
        },
        -- https://www.wowhead.com/guide/classes/evoker/augmentation/cheat-sheet
        [1473] = { -- Augmentation; By Jereico; Updated: 2025/08/03; [DPS]
          author = "Jereico",
          updated = "2025/08/03",
          weapons = { 
            bestInSlot   = { itemIDs = { 237728, 222566 } },
            alternatives = { itemIDs = { 237730, 221122 } },},
          trinkets = { 
            bestInSlot   = { itemIDs = { 242402, 242392 } },
            alternatives = { itemIDs = { 242497, 242494 } },},
          consumables    = { itemIDs = { 212283, 212265, 224572, 222732, 224107 } },
          tier = { 
            bestInSlot   = { itemIDs = { 237653, 237658, 237656, 237654 } } },
          statsByContent = {
            -- Raid; Chronowarden [38]
            ["RAID"] = { statsPriority = {
              { stats = { "INTELLECT" },    operator = ">" },
              { stats = { "MASTERY" },      operator = ">" },
              { stats = { "HASTE" },        operator = "=" },
              { stats = { "VERSATILITY" },  operator = ">" },
              { stats = { "CRIT" } },},},
            -- Mythic+; Scalecommander [36]
            ["MYTHIC_PLUS"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            -- Delves & Open world; Scalecommander [36]
            ["DELVES"] = { statsPriority = {
              { stats = { "INTELLECT" },  operator = ">" },
              { stats = { "MASTERY" },    operator = ">" },
              { stats = { "HASTE" },      operator = "=" },
              { stats = { "CRIT" },       operator = ">" },
              { stats = { "VERSATILITY" } },},},
            },
         },
      },
   },

};

MyCheatSheet.data = data

-- data.lua -- fin del archivo