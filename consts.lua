-- consts.lua
-- =============================
-- Enumerados y tablas de constantes
-- =============================

consts = {}

-- Enumerado de IDs de sección principales
consts.SECTION_IDS = {
    -- Ojo! estos valores se almacenan en la base de datos de CONFIGURACIÓN,
    -- NO SE DEBEN CAMBIAR A LA LIGERA SIN UN PROCESO DE MIGRACIÓN
    STATS = "STAT_PRIORITY",
    WEAPONS = "WEAPONS",
    TRINKETS = "TRINKETS",
    CONSUMABLES = "CONSUMABLES",
    TIER = "TIER",
}

-- Colores por estadística
consts.statColors = {
  -- https://warcraft.wiki.gg/wiki/API_GetAttackPowerForStat
    ["INTELLECT"]   = {r = .95, g = 0.55, b = 0.73, a = 1},     -- Fucsia
    ["HASTE"]       = {r = 0.25, g = 0.9, b = 0.45, a = 1},     -- Verde
    ["MASTERY"]     = {r = 0.65, g = 0.45, b = 0.95, a = 1},    -- Púrpura
    ["CRIT"]        = {r = 1.0, g = 0.25, b = 0.25, a = 1},     -- Rojo
    ["VERSATILITY"] = {r = 0.7, g = 0.7, b = 0.7, a = 1},       -- Gris
    ["AGILITY"]     = {r = 1.0, g = 0.8, b = 0.25, a = 1},      -- Dorado
    ["STRENGTH"]    = {r = 1.0, g = 0.5, b = 0.5, a = 1},       -- Rojo claro
}; 

-- Iconos por estadística
consts.statIcons = {
    ["INTELLECT"]   = "Interface\\Icons\\Spell_Arcane_Mind",               -- Cerebro arcano (fucsia/púrpura)
    ["HASTE"]       = "Interface\\Icons\\Spell_Nature_Windfury",           -- Viento verde (velocidad)
    ["MASTERY"]     = "Interface\\Icons\\Spell_Holy_InnerFire",            -- Fuego interior (maestría)
    ["CRIT"]        = "Interface\\Icons\\Ability_CriticalStrike",          -- Golpe crítico directo
    ["VERSATILITY"] = "Interface\\Icons\\Spell_Holy_Devotion",             -- Devoción (versátil/equilibrio)
    ["AGILITY"]     = "Interface\\Icons\\Spell_Nature_SpiritWolf",         -- Lobo espíritu (dorado/natural) 
    ["STRENGTH"]    = "Interface\\Icons\\Ability_Warrior_InnerRage",       -- Furia interior (rojo/fuerza)
};

-- Tabla de lookup para parches y títulos
consts.PATCH_TITLES = {
    ["11.2.0"] = "Ghosts of K'aresh",
    ["11.1.7"] = "Undermine",
    ["11.1.5"] = "Undermine",
    ["11.1.0"] = "Undermine",
    ["11.0.7"] = "Siren Isle",
    ["11.0.5"] = "20th Anniversary Celebration",
    ["11.0.2"] = "The War Within",
    ["11.0.0"] = "The War Within",
    ["10.2.7"] = "Dark Heart",
    ["10.2.6"] = "Plunderstorm",
    ["10.2.5"] = "Seeds of Renewal",
    ["10.2.0"] = "Guardians of the Dream",
    ["10.1.7"] = "Fury Incarnate",
    ["10.1.5"] = "fractures in Time",
    ["10.1.0"] = "Embers of Neltharion",
    ["10.0.5"] = "Trading Post",
    ["10.0.2"] = "Dragonflight",
    ["10.0.0"] = "Dragonflight Launch",
}

-- consts.lua - fin del archivo