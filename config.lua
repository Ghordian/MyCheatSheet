-- config.lua

local ADDON_NAME, private = ... 

---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

-- Crear módulo Config
local module = MyCheatSheet:NewModule("Config", "AceEvent-3.0")

---@type AceConfig-3.0
local AceConfig = LibStub("AceConfig-3.0")
---@type AceConfigDialog-3.0
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale(ADDON_NAME)

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
    -- Configuración por defecto
    self.addon.defaults = {
        profile = {
            -- UI Settings
            ui = {
                position = {
                    point = "CENTER",
                    x = 0,
                    y = 0
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
    
    -- Crear opciones de configuración
    self:CreateConfigOptions()
    
    -- Registrar en Blizzard Interface Options
    self:RegisterConfig()
end

--- Crea las opciones de configuración
function module:CreateConfigOptions()
    self.configOptions = {
        type = "group",
        name = "MyCheatSheet",
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
                        name = "Reset Position",
                        desc = "Reset window position to center",
                        func = function() self:ResetPosition() end,
                        order = 1
                    }
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
function module:DebugPrint(message)
    if self:GetDebugMode() then
        print("|cff00ffff[Config Module]|r " .. message)
    end
end

--- Getter del flag DebugMode
function module:GetDebugMode()
    if self then
      if self.addon.db and self.addon.db.profile.advanced then
          return self.addon.db.profile.advanced.debugMode
      end
    end
    return true
end

--[[ Exportar el módulo
MyCheatSheet.Config = module
]]--

-- config.lua -- fin del archivo