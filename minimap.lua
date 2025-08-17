-- minimap.lua
local ADDON_NAME, private = ... 

---@type MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);
---@type AceModule
local module = MyCheatSheet:NewModule("Minimap", "AceEvent-3.0")

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

-- Dependencias para minimapa
local LibDataBroker = LibStub("LibDataBroker-1.1", true)
local LibDBIcon = LibStub("LibDBIcon-1.0", true)

function module:DebugPrint(...)
    MyCheatSheet:DebugPrint(...)
end

function module:OnInitialize()
    self.addon = MyCheatSheet
    
    -- Verificar que las librerías estén disponibles
    if not LibDataBroker or not LibDBIcon then
        self:DebugPrint("Warning: LibDataBroker or LibDBIcon not available")
        return
    end
    
    -- Crear el objeto LibDataBroker
    self.dataObject = LibDataBroker:NewDataObject(ADDON_NAME, {
        type = "launcher",
        icon = "Interface\\Icons\\INV_Scroll_03", -- Icono de pergamino
        text = ADDON_NAME,
        label = ADDON_NAME,
        tocname = ADDON_NAME,
        
        OnClick = function(self, button)
            module:OnMinimapClick(button)
        end,
        
        OnTooltipShow = function(tooltip)
            module:OnTooltipShow(tooltip)
        end,
    })
    
    -- Inicializar configuración del minimapa si no existe
    if not MyCheatSheetDB then
        MyCheatSheetDB = {}
    end
    
    if not MyCheatSheetDB.minimapIcon then
        MyCheatSheetDB.minimapIcon = {
            hide = false,
        }
    end
    
    -- Registrar el icono en el minimapa
    LibDBIcon:Register(ADDON_NAME, self.dataObject, MyCheatSheetDB.minimapIcon)
end

function module:OnEnable()
    -- El módulo está habilitado
    self:DebugPrint("Minimap module enabled")
end

--- Maneja clics en el icono del minimapa
---@param button string Botón presionado ("LeftButton", "RightButton", etc.)
function module:OnMinimapClick(button)
    if button == "LeftButton" then
        -- Click izquierdo: abrir panel principal
        self:DebugPrint("Minimap left click - opening main panel")
        self.addon:ToggleUI()

    elseif button == "RightButton" then
        -- Click derecho: mostrar menú contextual (futuro)
        self:DebugPrint("Minimap right click - context menu (future)")
        -- Aquí se podría implementar un menú contextual

    elseif button == "MiddleButton" then
        -- Click medio: toggle icono del minimapa
        self:ToggleMinimapIcon()
    end
end

--- Muestra el tooltip cuando se hace hover sobre el icono
---@param tooltip Frame El tooltip frame
function module:OnTooltipShow(tooltip)
    if not tooltip then return end

    tooltip:AddLine("|cffffd700MyCheatSheet|r")
    tooltip:AddLine(" ")
    tooltip:AddLine("|cffadd8e6" .. (L["MINIMAP_TOOLTIP_LEFT_CLICK"] or "Left click: Open cheat sheet panel") .. "|r")
    tooltip:AddLine("|cffadd8e6" .. (L["MINIMAP_TOOLTIP_MIDDLE_CLICK"] or "Middle click: Toggle minimap icon") .. "|r")
    tooltip:AddLine(" ")
    tooltip:AddLine("|cff808080" .. (L["MINIMAP_TOOLTIP_ADDON_INFO"] or "Character cheat sheet addon") .. "|r")
end

--- Toggle la visibilidad del icono del minimapa
function module:ToggleMinimapIcon()
    if not LibDBIcon then return end

    MyCheatSheetDB.minimapIcon.hide = not MyCheatSheetDB.minimapIcon.hide

    if MyCheatSheetDB.minimapIcon.hide then
        LibDBIcon:Hide(ADDON_NAME)
        print("|cffffd700[MyCheatSheet]|r " .. (L["MINIMAP_ICON_HIDDEN"] or "Minimap icon hidden. Use /mcs minimap to show it again."))
    else
        LibDBIcon:Show(ADDON_NAME)
        print("|cffffd700[MyCheatSheet]|r " .. (L["MINIMAP_ICON_SHOWN"] or "Minimap icon shown."))
    end
end

--- Muestra el icono del minimapa
function module:ShowMinimapIcon()
    if not LibDBIcon then return end

    MyCheatSheetDB.minimapIcon.hide = false
    LibDBIcon:Show(ADDON_NAME)
end

--- Oculta el icono del minimapa
function module:HideMinimapIcon()
    if not LibDBIcon then return end

    MyCheatSheetDB.minimapIcon.hide = true
    LibDBIcon:Hide(ADDON_NAME)
end

--- Verifica si el icono del minimapa está visible
---@return boolean isVisible
function module:IsMinimapIconVisible()
    return not (MyCheatSheetDB.minimapIcon and MyCheatSheetDB.minimapIcon.hide)
end

-- Funciones públicas para otros módulos (compatibilidad con implementación anterior)
function MyCheatSheet:ShowMinimapIcon()
    local minimapModule = self:GetModule("Minimap", true)
    if minimapModule then
        minimapModule:ShowMinimapIcon()
    end
end

function MyCheatSheet:HideMinimapIcon()
    local minimapModule = self:GetModule("Minimap", true)
    if minimapModule then
        minimapModule:HideMinimapIcon()
    end
end

function MyCheatSheet:ToggleMinimapIcon()
    local minimapModule = self:GetModule("Minimap", true)
    if minimapModule then
        minimapModule:ToggleMinimapIcon()
    end
end

-- Alias para compatibilidad con implementación anterior
function module:ShowButton()
    self:ShowMinimapIcon()
end

function module:HideButton()
    self:HideMinimapIcon()
end

function module:IsButtonVisible()
    return self:IsMinimapIconVisible()
end
