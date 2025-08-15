local ADDON_NAME, private = ... 
-- Contains the addon's configuration and item data.
---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

private.data = {
    -- Un número de versión para los datos.
--**version = 1, -- inital definition
--**version = 2, -- added MyCheatSheetStatGroup
--**version = 3, -- added tier section
--**version = 4, -- added classID and specID
--**version = 5, -- removed cyrce's circles section
--**version = 6, -- added subsection statsByContent
    version = 7, -- added fields author, updated for each cheat-sheet
    version = 8, -- added fields author, updated for each cheat-sheet
  {
    [72] = {
      ["author"] = "Archimtiros",
      ["updated"] = "2025/08/03",
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237608,  237613,  237611,  237609,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  222720,  224107,        },
      },
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234490,  222443,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234490,  222443,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234490,  222443,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
      },
    },
    [73] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237609,  237611,  237610,  237608,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212265,  212271,  212283,  224107,  222733,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Nomeratur",
    },
    [71] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237608,  237613,  237611,  237609,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  222720,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242394,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242394,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242394,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Archimtiros",
    },
  },
  {
    [65] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237620,  237622,  237618,  237617,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  212241,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221150,  242493,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221150,  242493,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221150,  242493,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "HolyClarius",
    },
    [66] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237620,  237622,  237618,  237617,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212274,  212265,  244839,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DAMAGE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-TANK"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185824,  237741,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237734,  237723,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  242401,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Andybrew",
    },
    [70] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237622,  237620,  237619,  237618,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  222728,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237737,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Bolas",
    },
  },
  {
    [253] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237646,  237644,  237649,  237645,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          224107,  222728,  212283,  212265,  222720,  244839,  212256,  224572,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234492,  221143,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237733,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234492,  221143,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237733,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234492,  221143,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237733,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  219312,  185818,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
      },
      ["author"] = "Tarlo",
    },
    [254] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237646,  237644,  237649,  237645,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237732,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185783,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237732,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185783,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237732,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185783,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "TheAzortharion",
    },
    [255] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237646,  237644,  237645,  237649,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  224107,  224572,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222448,  221159,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242481,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242395,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222448,  221159,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242481,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242395,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222448,  221159,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242481,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242395,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "DoolB",
    },
  },
  {
    [260] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237664,  237663,  237667,  237662,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212277,  212265,  222504,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "JustGuy",
    },
    [261] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237664,  237663,  237667,  237662,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212277,  212265,  222504,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221128,  221138,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237731,  234493,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242397,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "fuu1",
    },
    [259] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237665,  237664,  237663,  237662,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  220156,  222504,  222733,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221138,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237740,  237729,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  219314,  242396,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242494,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221138,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237740,  237729,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  219314,  242396,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242494,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221138,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237740,  237729,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  219314,  242396,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242494,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                221138,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237740,  237729,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  219314,  242396,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242494,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Whispyr",
    },
  },
  {
    [256] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237709,  237707,  237712,  237710,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  224107,  212241,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  238386,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  238386,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  238386,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  238386,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "AutomaticJak",
    },
    [257] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237709,  237707,  237712,  237708,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  224107,  212241,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-HEAL"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["MYTHIC_PUSH_KEYS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242393,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "AutomaticJak",
    },
    [258] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237710,  237709,  237708,  237712,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,  221132,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242495,  242497,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,  221132,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242495,  242497,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,  221132,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242495,  242497,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "EllipsisPriest",
    },
  },
  {
    [252] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237628,  237631,  237627,  237626,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212265,  224107,  212283,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234490,  237725,  243365,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242487,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  238386,  246344,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234490,  237725,  243365,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242487,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  238386,  246344,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234490,  237725,  243365,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242487,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  238386,  246344,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                234490,  237725,  243365,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242487,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  238386,  246344,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Taeznak",
    },
    [250] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237628,  237626,  237631,  237629,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224105,  243191,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DPS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237725,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242394,  242401,  246344,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  190652,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237725,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242394,  242401,  246344,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  190652,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237725,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242394,  242401,  246344,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  190652,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237725,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242394,  242401,  246344,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  190652,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237725,  242487,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242394,  242401,  246344,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  190652,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
      },
      ["author"] = "Mandl",
    },
    [251] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237631,  237628,  237627,  237626,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  244839,  224107,  212265,  224572,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  237813,  237813,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                222447,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                238390,  246945,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  237813,  237813,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                222447,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                238390,  246945,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237737,  237813,  237813,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                222447,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242402,  242396,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                238390,  246945,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "STRENGTH"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "khazakdk",
    },
  },
  {
    [264] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237637,  237640,  237638,  237636,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  224571,  191368,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237723,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  190958,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237723,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  190958,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237723,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219308,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  190958,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Theun",
    },
    [262] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237635,  237640,  237638,  237636,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224572,  222732,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "HawkCorrigan",
    },
    [263] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237637,  237635,  237638,  237636,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  244839,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237738,  178834,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185823,  222446,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  185818,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237738,  178834,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185823,  222446,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  185818,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237738,  178834,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                185823,  222446,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  185818,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
      },
      ["author"] = "wordup",
    },
  },
  {
    [64] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237718,  237716,  237719,  237717,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  244839,  224107,        },
      },
      ["updated"] = "2025/08/07",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  242494,  219314,  219312,  190958,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  242494,  219314,  219312,  190958,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  242494,  219314,  219312,  190958,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Dorovon",
    },
    [62] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237718,  237716,  237721,  237717,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212274,  212265,  224107,  222720,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237742,  237730,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  219312,  242392,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237742,  237730,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  219312,  242392,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237742,  237730,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  219312,  242392,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["RAID-CLEAVE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237742,  237730,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                190958,  219312,  242392,  219308,  242395,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
      },
      ["author"] = "Porom",
    },
    [63] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237716,  237721,  237717,  237719,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  212283,  212265,  224105,  222728,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  190958,  242494,  242402,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  190958,  242494,  242402,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  242392,  190958,  242494,  242402,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Preheat",
    },
  },
  {
    [265] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237701,  237700,  237699,  237703,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  222735,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Kalamazi",
    },
    [266] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237700,  237698,  237703,  237699,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  212265,  222735,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185821,  237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,  219308,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185821,  237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,  219308,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185821,  237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242392,  219308,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "NotWarlock",
    },
    [267] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237700,  237698,  237703,  237699,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  222735,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  219314,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Loozy",
    },
  },
  {
    [268] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237673,  237671,  237676,  237674,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  244839,  222510,  222504,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242481,  221144,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232543,  219309,  242395,  242404,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242401,  242391,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["MYTHIC_PUSH_KEYS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242481,  221144,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232543,  219309,  242395,  242404,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242401,  242391,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["RAID-DAMAGE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242481,  221144,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232543,  219309,  242395,  242404,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242401,  242391,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242481,  221144,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232543,  219309,  242395,  242404,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242401,  242391,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
        ["RAID-TANK"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242481,  221144,  221128,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232543,  219309,  242395,  242404,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242401,  242391,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
            },
          },
        },
      },
      ["author"] = "Sinzhu",
    },
    [269] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237676,  237674,  237672,  237671,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224572,        },
      },
      ["updated"] = "2025/08/04",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242494,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"  "HASTE"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242494,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"  "HASTE"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242494,  232541,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"  "HASTE"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
      },
      ["author"] = "Babylonius",
    },
    [270] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237673,  237671,  237674,  237672,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  224107,  212241,  212265,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID-DAMAGE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  185812,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242402,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  185812,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242402,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["RAID-HEAL"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  185812,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242402,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  185812,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219308,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242392,  242402,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "JuneMW",
    },
  },
  {
    [104] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237685,  237682,  237681,  237680,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242401,  242402,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242401,  242402,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                243365,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237726,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242401,  242402,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219309,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Pumps",
    },
    [105] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237682,  237680,  237685,  237683,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212274,  212241,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["RAID-HEAL"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Voulk",
    },
    [102] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237682,  237680,  237683,  237681,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212265,  212283,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242392,  242497,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242392,  242497,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242392,  242497,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242395,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
      },
      ["author"] = "tettles",
    },
    [103] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237682,  237681,  237685,  237683,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224572,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  234494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  242397,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  234494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  242397,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237726,  234494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                221159,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219314,  242397,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  232541,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Guiltyas",
    },
  },
  {
    [577] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237691,  237689,  237694,  237692,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  244839,  224107,  222728,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185780,  185778,  237738,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237727,  222441,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185818,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  242397,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185780,  185778,  237738,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237727,  222441,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185818,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  242397,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185780,  185778,  237738,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237727,  222441,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185818,  232541,  190652,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242395,  242397,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "AGILITY"              },
            },
          },
        },
      },
      ["author"] = "Shadarek",
    },
    [581] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237689,  237690,  237692,  237694,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224107,  222720,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185778,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234491,  222440,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  242402,  219314,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  219309,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185778,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234491,  222440,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  242402,  219314,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  219309,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                185778,  0,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                234491,  222440,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                232541,  242402,  219314,  232543,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                190958,  219309,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "AGILITY"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Itamae",
    },
  },
  {
    [1468] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237655,  237653,  237656,  237654,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212280,  212265,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">>",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                222568,  237728,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237730,  0,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                219312,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                219314,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
            },
          },
        },
      },
      ["author"] = "Voulk",
    },
    [1473] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237653,  237658,  237656,  237654,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224572,  222732,  224107,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237730,  221122,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237728,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242497,  242494,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242392,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = "=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Jereico",
    },
    [1467] = {
      ["tier"] = {
        ["bestInSlot"] = {
          ["itemIDs"] = {
            237655,  237653,  237658,  237654,          },
        },
      },
      ["consumables"] = {
        ["itemIDs"] = {
          212283,  212265,  224105,  222728,        },
      },
      ["updated"] = "2025/08/03",
      ["contents"] = {
        ["RAID"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,  222450,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219314,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["MYTHIC_PLUS"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,  222450,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219314,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["RAID-DAMAGE"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,  222450,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219314,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
        ["DELVES_AND_OPEN_WORLD"] = {
          ["weapons"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                237728,  237730,  221165,  222568,  222450,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                237735,  222566,              },
            },
          },
          ["trinkets"] = {
            ["alternatives"] = {
              ["itemIDs"] = {
                242395,  219314,  242392,              },
            },
            ["bestInSlot"] = {
              ["itemIDs"] = {
                242402,  242497,              },
            },
          },
          ["statsPriority"] = {
            {
              ["stats"] = {
                "INTELLECT"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "CRIT"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "HASTE"              },
              ["operator"] = ">",
            },
            {
              ["stats"] = {
                "MASTERY"              },
              ["operator"] = ">=",
            },
            {
              ["stats"] = {
                "VERSATILITY"              },
            },
          },
        },
      },
      ["author"] = "Preheat",
    },
  },
}
