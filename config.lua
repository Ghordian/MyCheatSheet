-- config.lua

local ADDON_NAME, private = ... 

---@type MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

-- Crear módulo Config
---@class ConfigModule : AceModule
---@field addon MyCheatSheet
local module = MyCheatSheet:NewModule("Config", "AceEvent-3.0")

---@type AceConfig-3.0
local AceConfig = LibStub("AceConfig-3.0")
---@type AceConfigDialog-3.0
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale(ADDON_NAME)

--[[
Sistema de control de versiones de configuración
-----------------------------------------------
Cada vez que se cambia la estructura de la configuración por perfil, se debe:
    1. Aumentar el valor de self.CONFIG_VERSION.
    2. Añadir lógica de migración en InitializeConfig para adaptar perfiles antiguos.
    3. Usar el campo profile.configVersion para saber la versión de los datos del usuario.

Ejemplo de migración:
if self.addon.db.profile.configVersion < 2 then
        -- Realizar cambios necesarios para la versión 2
end

Esto asegura compatibilidad y actualización automática de perfiles antiguos.
]]

    -- Función de copia profunda
    local function deepcopy(tbl)
        if type(tbl) ~= "table" then return tbl end
        local t = {}
        for k, v in pairs(tbl) do
            t[k] = type(v) == "table" and deepcopy(v) or v
        end
        return t
    end

    local function vardump(t, level)
        level = level or 0
        if not module:GetDebugMode() then return end
        if type(t) ~= "table" then
            module:DebugPrint(string.rep("  ", level) .. tostring(t))
            return
        end
        if level > 2 then return end -- máximo 3 niveles (0,1,2)
        for k, v in pairs(t) do
            if type(v) == "table" then
                module:DebugPrint(string.rep("  ", level) .. tostring(k) .. " = {")
                vardump(v, level + 1)
                module:DebugPrint(string.rep("  ", level) .. "}")
            else
                module:DebugPrint(string.rep("  ", level) .. tostring(k) .. " = " .. tostring(v))
            end
        end
    end

-- ========================================
-- MÓDULO CONFIG
-- ========================================

function module:OnInitialize()
    self.addon = MyCheatSheet
    self:InitializeConfig()
end

function module:OnEnable()
    self:ApplySettings()
end

--- Inicializa el sistema de configuración
function module:InitializeConfig()
    self:DebugPrint("InitializeConfig")

    -- Configuración por defecto
--[[-- Configuración por defecto
    self.CONFIG_VERSION = 1 -- added layout / sections 
    self.CONFIG_VERSION = 2 -- added showDataEditButtons, showLayoutEditButton
  ]]--
    self.CONFIG_VERSION = 3 -- added opaqueBackground, hideSectionTitles

    self.addon.defaults = {
        profile = {
            configVersion = self.CONFIG_VERSION,
            -- UI Settings
            ui = {
                position = {
                    point = "CENTER",
                    x = 0,
                    y = 0
                },
                -- added VER.2
                showDataEditButtons = true,
                showLayoutEditButton = true,
                -- added VER.3
                opaqueBackground = false,
                hideSectionTitles = false,
            },
            -- Layout editable por usuario (por perfil)
            layout = {
                sections = {
                    { id = "STAT_PRIORITY", visible = true },
                    { id = "WEAPONS", visible = true },
                    { id = "TRINKETS", visible = true },
                    { id = "CONSUMABLES", visible = true },
                    { id = "TIER", visible = true },
                }
            },
            -- Advanced Settings  
            advanced = {
                debugMode = false
            }
        }
    }

    -- Inicializar base de datos
    self.addon.db = LibStub("AceDB-3.0"):New("MyCheatSheetDB", self.addon.defaults, true)

    -- Migración/configuración por versión
    if not self.addon.db.profile.configVersion then
        self.addon.db.profile.configVersion = 0
    end

    -- Migración de versión 0 a 1: añadir layout si no existe
    if self.addon.db.profile.configVersion < 1 then
        if not self.addon.db.profile.layout then
            self.addon.db.profile.layout = deepcopy(self.addon.defaults.profile.layout)
        end
        self.addon.db.profile.configVersion = 1
    end

    -- Migración de versión 1 a 2: añadir showDataEditButtons y showLayoutEditButton si no existen
    if self.addon.db.profile.configVersion < 2 then
        if not self.addon.db.profile.ui.showDataEditButtons then
            self.addon.db.profile.ui.showDataEditButtons = self.addon.defaults.profile.ui.showDataEditButtons
        end
        if not self.addon.db.profile.ui.showLayoutEditButton then
            self.addon.db.profile.ui.showLayoutEditButton = self.addon.defaults.profile.ui.showLayoutEditButton
        end
        self.addon.db.profile.configVersion = 2
    end
    if self.addon.db.profile.configVersion < 3 then
        self.addon.db.profile.configVersion = 3
    end

    -- Migraciones futuras: ejemplo
    if self.addon.db.profile.configVersion < self.CONFIG_VERSION then
        -- Aquí puedes añadir migraciones según la versión
        self.addon.db.profile.configVersion = self.CONFIG_VERSION
    end
    -- Versión Activa!
    self:DebugPrint("configVersion", self.CONFIG_VERSION)

    -- Crear opciones de configuración
    self:CreateConfigOptions()

    -- Registrar en Blizzard Interface Options
    self:RegisterConfig()
end

--- Crea las opciones de configuración
function module:CreateConfigOptions()
    self.configOptions = {
        type = "group",
        name = "My Cheat Sheet",
        handler = self,
        get = "GetOption",
        set = "SetOption",
        args = {
            -- HEADER
            header = {
                type = "header",
                name = "MyCheatSheet Configuration",
                order = 1
            },
            
            -- UI SETTINGS (solo posición)
            ui = {
                type = "group",
                name = "Interface",
                order = 10,
                args = {
                    resetPosition = {
                        type = "execute",
                        name = L["RESET_POSITION_OPTION_NAME"],
                        desc = L["RESET_POSITION_OPTION_DESC"],
                        func = function() self:ResetPosition() end,
                        order = 1
                    },
                    showDataEditButtons = {
                        type = "toggle",
                        name = L["SHOW_DATA_EDIT_BUTTONS_OPTION_NAME"],
                        desc = L["SHOW_DATA_EDIT_BUTTONS_OPTION_DESC"],
                        get = function() return self.addon.db.profile.ui.showDataEditButtons end,
                        set = function(_, val) self.addon.db.profile.ui.showDataEditButtons = val; if self.addon.MyCheatSheetFrame then self.addon:UpdateUI() end end,
                        width = "full",
                        order = 2
                    },
                    showLayoutEditButton = {
                        type = "toggle",
                        name = L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_NAME"],
                        desc = L["SHOW_LAYOUT_EDIT_BUTTON_OPTION_DESC"],
                        get = function() return self.addon.db.profile.ui.showLayoutEditButton end,
                        set = function(_, val) self.addon.db.profile.ui.showLayoutEditButton = val; if self.addon.MyCheatSheetFrame then self.addon:UpdateUI() end end,
                        width = "full",
                        order = 3
                    },
                    opaqueBackground = {
                        type = "toggle",
                        name = L["OPAQUE_BACKGROUND_OPTION_NAME"],
                        desc = L["OPAQUE_BACKGROUND_OPTION_DESC"],
                        get = function() return self.addon.db.profile.ui.opaqueBackground end,
                        set = function(_, val)
                            self.addon.db.profile.ui.opaqueBackground = val
                            if self.addon.MyCheatSheetFrame then
                                self.addon:UpdateMainPanelBackdrop()
                            end
                        end,
                        width = "full",
                        order = 4
                    },
                    hideSectionTitles = {
                        type = "toggle",
                        name = L["HIDE_SECTION_TITLES_OPTION_NAME"],
                        desc = L["HIDE_SECTION_TITLES_OPTION_DESC"],
                        get = function() return self.addon.db.profile.ui.hideSectionTitles end,
                        set = function(_, val)
                            self.addon.db.profile.ui.hideSectionTitles = val
                            if self.addon.MyCheatSheetFrame then
                                self.addon:UpdateUI()
                            end
                        end,
                        width = "full",
                        order = 5,
                    }, 
                }
            },

            -- DEBUG MODE
            debug = {
                type = "group",
                name = "Debug",
                order = 20,
                args = {
                    debugMode = {
                        type = "toggle",
                        name = "Debug Mode",
                        desc = "Enable debug messages in chat",
                        get = function() return self.addon.db.profile.advanced.debugMode end,
                        set = function(_, val) self.addon.db.profile.advanced.debugMode = val end,
                        order = 1
                    }
                }
            }
        }
    }
end

--- Registra la configuración en Blizzard UI
function module:RegisterConfig()
    AceConfig:RegisterOptionsTable(ADDON_NAME, self.configOptions)
    self.addon.configFrame = AceConfigDialog:AddToBlizOptions(ADDON_NAME, "MyCheatSheet")

    -- Agregar perfil de opciones
    self.configOptions.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.addon.db)
end

--- Aplica configuración inicial
function module:ApplySettings()
    -- Aplicar configuración de UI si existe el frame
    if self.addon.MyCheatSheetFrame then
        self:ApplyFramePosition()
    end
end

--- Aplica configuración de posición del frame
function module:ApplyFramePosition()
    if self.addon.MyCheatSheetFrame and self.addon.db then
        local pos = self.addon.db.profile.ui.position
        self.addon.MyCheatSheetFrame:ClearAllPoints()
        self.addon.MyCheatSheetFrame:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y)
    end
end

--- Resetea la posición del frame
function module:ResetPosition()
    if self.addon.MyCheatSheetFrame then
        self.addon.MyCheatSheetFrame:ClearAllPoints()
        self.addon.MyCheatSheetFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
        self.addon.db.profile.ui.position.point = "CENTER"
        self.addon.db.profile.ui.position.x = 0
        self.addon.db.profile.ui.position.y = 0
        self:DebugPrint("Window position reset to center")
    end
end

--- Getters y setters genéricos
function module:GetOption(info)
    return self.addon.db.profile[info[#info-1]][info[#info]]
end

function module:SetOption(info, value)
    self.addon.db.profile[info[#info-1]][info[#info]] = value
end

--- Debug del Módulo
function module:DebugPrint(...)
    if self:GetDebugMode() then
        print("|cff00ff00[MCS]|r|cff00ffff[Config Module]|r", ...)
    end
end

--- Getter for DebugMode flag
function module:GetDebugMode()
    if self then
      if self.addon.db and self.addon.db.profile.advanced then
          return self.addon.db.profile.advanced.debugMode
      end
    end
    return true
end

--- Getter for showDataEditButtons flag
function module:GetShowDataEditButtons()
    if self then
      if self.addon.db and self.addon.db.profile.ui then
          return self.addon.db.profile.ui.showDataEditButtons
      else
          return false
      end
    end
    return true
end

--- Getter for showLayoutEditButton flag
function module:GetShowLayoutEditButton()
    if self then
      if self.addon.db and self.addon.db.profile.ui then
          return self.addon.db.profile.ui.showLayoutEditButton
      else
          return false
      end
    end
    return true
end

function module:ResetLayoutToDefault()
    -- Resetear layout a valores por defecto
    self.addon.db.profile.layout = deepcopy(self.addon.defaults.profile.layout)
    self:DebugPrint("Layout reset to default")

    -- Aplicar cambios de UI
    if self.addon.MyCheatSheetFrame then
        self.addon:UpdateUI()
    end
end

--- Getter for opaqueBackground flag
function module:GetOpaqueBackground()
    if self then
      if self.addon.db and self.addon.db.profile.ui then
          return self.addon.db.profile.ui.opaqueBackground
      else
          return false
      end
    end
    return true
end

function module:GetHideSectionTitles()
    if self then
        if self.addon.db and self.addon.db.profile.ui then
            return self.addon.db.profile.ui.hideSectionTitles
        end
        return false
    end
    return true
end

-- config.lua -- fin del archivo