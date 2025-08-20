--- MyCheatSheet.lua
local ADDON_NAME, private = ... 

--- @type MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0");

--- @type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
--- @type AceGUI-3.0
local AceGUI = LibStub("AceGUI-3.0")

local L = AceLocale:GetLocale(ADDON_NAME)

-- BINDING
function MyCheatSheet_ToggleBinding()
  if MyCheatSheet and MyCheatSheet.ToggleUI then
    MyCheatSheet:ToggleUI()
  end
end

-- STATS
L["HASTE"] = STAT_HASTE
L["MASTERY"] = STAT_MASTERY
L["VERSATILITY"] = STAT_VERSATILITY

--- tabla de claves de contenido a nombres
MyCheatSheet.contentKeysToNames = {
    ["RAID"]        = L["RAID"],
    ["RAID-DAMAGE"] = L["RAID-DAMAGE"],
    ["RAID-TANK"]   = L["RAID-TANK"],
    ["RAID-HEAL"]   = L["RAID-HEAL"],
    ["RAID-CLEAVE"] = L["RAID-CLEAVE"],
    ["RAID-DPS"]    = L["RAID-DPS"],
    ["MYTHIC_PLUS"] = L["MYTHIC_PLUS"],
    ["DELVES"]      = L["DELVES"],
    ["OPEN_WORLD"]  = L["OPEN_WORLD"],
    ["DELVES_AND_OPEN_WORLD"] = L["DELVES_AND_OPEN_WORLD"],
    ["MYTHIC_PUSH_KEYS"] = L["MYTHIC_PUSH_KEYS"],
};

---@type Frame
-- local debugf = tekDebug and tekDebug:GetFrame(ADDON_NAME)
local debugf = nil
if debugf then
--**debugf:Hide()
end

local debugMode = true
function MyCheatSheet:GetDebugMode()
    if self.db and self.db.profile and self.db.profile.advanced then
        debugMode = self.db.profile.advanced.debugMode
    end
    if debugMode then
        if debugf then
            -- mostrar marco de depuración
            debugf:Show()
        end
    end
    -- devolver estado actualizado
    return debugMode
end

function MyCheatSheet:DebugPrint(...)
  -- 
  if MyCheatSheet:GetDebugMode() then
    if debugf then
      debugf:AddMessage("|cff00ff00[MyCheatSheet]|r |cff00ffff[DBG]|r", ...)
    else
      print("|cff00ff00[MyCheatSheet]|r |cff00ffff[DBG]|r", ...)
    end
  end
end

local function OnShowCharacterFrame(self, frame)
    if MyCheatSheet and MyCheatSheet.AddCharacterFrameTab then
        MyCheatSheet:AddCharacterFrameTab(frame)
    end
end


function MyCheatSheet:OnInitialize()
    self:DebugPrint("MyCheatSheet:OnInitialize")

    -- Habilitar módulo Config PRIMERO
    self:EnableModule("Config")
    self:EnableModule("ValidData")
    self:EnableModule("Export")

    -- Inicializar SavedVariable si no existe
    if not MyCheatSheetDB then
        MyCheatSheetDB = { customOverrides = {} }
    end

    if self.RegisterChatCommand then
        self:RegisterChatCommand("mcs", "SlashCommand");
    end

    self:RegisterMessage("MCS_CUSTOMSHEETS_REFRESH", "RefreshUI")

    --[[ Hook para inicializar la pestaña al abrir el CharacterFrame
    self:SecureHookScript(CharacterFrame, "OnShow", OnShowCharacterFrame);
    ]]--

    print("|cff00ff00MyCheatSheet|r loaded. Use |cff00ff00/mcs|r to open.")
end

function MyCheatSheet:OnEnable()
    self:DebugPrint("MyCheatSheet:OnEnable")

    self.config = MyCheatSheet:GetModule("Config")
    self.validData = MyCheatSheet:GetModule("ValidData")
    self.export = MyCheatSheet:GetModule("Export")

    debugMode = self.config.GetDebugMode();

    self:LoadPlayerDefaults();

    -- Registrar los eventos para la carga de personaje y el cambio de talentos
    self:RegisterEvent("PLAYER_TALENT_UPDATE");
end

--- Manejador del evento PLAYER_TALENT_UPDATE
function MyCheatSheet:PLAYER_TALENT_UPDATE()
    self:LoadPlayerDefaults()
end

--- Manejador del comando de chat
---@param input string
function MyCheatSheet:SlashCommand(input)
    input = input:trim()
    local args = {strsplit(" ", input)}
    local command = args[1] and args[1]:lower() or ""

    if command == "validate" or command == "check" then
        self.validData:ValidateDataWithCache(true)
        return
    end
    
    if command == "validatefast" then
        self.validData:ValidateData(true)
        return
    end

    if command == "exporterrors" or command == "errors" then
        self.validData:ExportValidationErrors()
        return
    end

    if command == "clearerrors" then
        if MyCheatSheetDB and MyCheatSheetDB.lastValidation then
            MyCheatSheetDB.lastValidation = nil
            print("|cff00ff00[OK] Errores de validación limpiados|r")
        else
            print("|cffff0000No hay errores guardados|r")
        end
        return
    end

    if command == "export" then
        if self.export then
            self.export:HandleExportCommand(args)
        else
            print("|cffff0000Export module not enabled|r")
        end
        return
    end
    
    if command == "import" then
        if self.export then
            self.export:HandleImportCommand(args)
        else
            print("|cffff0000Export module not enabled|r")
        end
        return
    end
    
    if command == "custom" then
        if self.export then
            self.export:HandleCustomCommand(args)
        else
            print("|cffff0000Export module not enabled|r")
        end
        return
    end

    if command == "config" or command == "options" then
        -- Delegar al módulo Config
        if self:IsModuleEnabled("Config") then
            InterfaceOptionsFrame_OpenToCategory(self.config.configFrame)
            InterfaceOptionsFrame_OpenToCategory(self.config.configFrame)
        else
            print("|cffff0000Config module not enabled|r")
        end
        return
    end

    if not input or input:trim() == "" or input:lower() == "toggle" then 
        self:ToggleUI();
        self:UpdateUI();
    end
end

--[[
    -- https://warcraft.wiki.gg/wiki/API_UnitClassBase
    -- https://warcraft.wiki.gg/wiki/API_C_CreatureInfo.GetClassInfo
  ]]--

--- Carga la configuración por defecto del jugador actual
function MyCheatSheet:LoadPlayerDefaults()
    self:DebugPrint("LoadPlayerDefaults")
    local _, classID = UnitClassBase("player")
    local classInfo = C_CreatureInfo.GetClassInfo(classID)
    local playerSpec = self:GetTalentInfo()
    local specID = C_SpecializationInfo.GetSpecializationInfo(playerSpec);

    if classID and specID then
        if MyCheatSheet.data.sheets[classID] and MyCheatSheet.data.sheets[classID][specID] then
        self.selectedClass = classID;
        self.selectedSpec = specID;

        for contentKey in pairs(MyCheatSheet.data.sheets[classID][specID].statsByContent) do
            self.selectedContent = contentKey;
            break;
        end
        end
    else
        self.selectedClass = nil;
        self.selectedSpec = nil;
        self.selectedContent = nil;
    end

if false then
    self:UpdateDropdowns()
    self:UpdateUI()
end
end

--- Muestra u oculta la interfaz de usuario.
---@param show boolean|nil
function MyCheatSheet:ToggleUI(show)
    local frame = self.MyCheatSheetFrame
    if frame == nil then
        self:CreateCheatSheetUI()
        self:CreateUIContent()
        frame = self.MyCheatSheetFrame
        if frame then
            self:UpdateDropdowns()
            self:UpdateUI()
        end
    end
    if show == nil then
        if frame:IsShown() then
            frame:Hide()
        else
            frame:Show()
        end
    elseif show then
        frame:Show()
    else
        frame:Hide()
    end
end

--- Obtiene datos de una sección con soporte para overrides personalizados
---@param sectionType string
---@param subsectionType string|nil
---@return table|nil, isCustom|nil
function MyCheatSheet:GetSectionData(sectionType, subsectionType)
    local customData = nil
    local isCustom = nil

    if MyCheatSheetDB and MyCheatSheetDB.customOverrides and 
       MyCheatSheetDB.customOverrides[self.selectedClass] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] then
        
        local customSection = MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec][sectionType]
        if customSection then
            if subsectionType then
                customData = customSection[subsectionType]
            else
                customData = customSection
            end
        end
    end

    -- Si hay datos personalizados, usarlos
    if customData and customData.itemIDs and #customData.itemIDs > 0 then
        isCustom = true
        return customData, isCustom
    end

    -- Para trinkets, usar GetTrinckets()
    if sectionType == "trinkets" then
        local trinkets = self:GetTrinckets(self.selectedClass, self.selectedSpec)
        if subsectionType then
            return trinkets[subsectionType]
        else
            return trinkets, isCustom
        end
    end

    -- Fallback a datos por defecto para otras secciones
    local specData = self.data.sheets[self.selectedClass] and 
                     self.data.sheets[self.selectedClass][self.selectedSpec]
    if specData and specData[sectionType] then
        if subsectionType then
            return specData[sectionType][subsectionType], isCustom
        else
            return specData[sectionType], isCustom
        end
    end

    return nil, nil
end

--- Obtiene datos de estadísticas con soporte para stats personalizadas
---@param classID number
---@param specID number
---@param contentKey string
---@return table|nil, isCustom|nil
function MyCheatSheet:GetStatsData(classID, specID, contentKey)
    local isCustom = nil

    -- 1. Buscar stats personalizadas primero
    if MyCheatSheetDB and MyCheatSheetDB.customOverrides and 
       MyCheatSheetDB.customOverrides[classID] and
       MyCheatSheetDB.customOverrides[classID][specID] and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey] and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey].statsPriority then

        isCustom = true
        -- Devolver stats personalizadas
        return {
           statsPriority = MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey].statsPriority
        }, isCustom
    end

    -- 2. Si no hay personalizadas, devolver las originales
    local specData = self.data.sheets[classID] and self.data.sheets[classID][specID]
    if specData and specData.statsByContent and specData.statsByContent[contentKey] then
        return specData.statsByContent[contentKey], isCustom
    end

    return nil, nil
end

--- Obtiene datos de autor con soporte para datos personalizados
---@param classID number ClassID
---@param specID number SpecID
---@param contentKey string|nil ContentKey
---@return table|nil, isCustom|nil
function MyCheatSheet:GetAuthorData(classID, specID, contentKey)
    local isCustom = nil
    local authorData = {}

    -- 1. Buscar datos de autor personalizados primero
    if MyCheatSheetDB and MyCheatSheetDB.customOverrides and
       MyCheatSheetDB.customOverrides[classID] and
       MyCheatSheetDB.customOverrides[classID][specID] then

        authorData = {
            author = MyCheatSheetDB.customOverrides[classID][specID].author,
            updated = MyCheatSheetDB.customOverrides[classID][specID].updated,
            patchVersion = MyCheatSheetDB.customOverrides[classID][specID].patchVersion,
        };
        isCustom = true
        -- Devolver datos de autor personalizados
        return authorData, isCustom
    end

    -- 2. Si no hay personalizadas, devolver las originales
    local specData = self.data.sheets[classID] and self.data.sheets[classID][specID]
    if specData  then
        authorData = {
            author = specData.author,
            updated = specData.updated,
            patchVersion = specData.patchVersion,
        };

        return authorData, isCustom
    end

    return nil, nil
end

--[[
      https://warcraft.wiki.gg/wiki/API_C_ClassTalents.GetActiveHeroTalentSpec
      https://warcraft.wiki.gg/wiki/HeroSpecID
  ]]--

--- Obtiene la información de talentos del jugador actual
---@return number|nil specid, number|nil icon
function MyCheatSheet:GetTalentInfo()
    local specid, icon = 0, 0
    if GetSpecialization and GetSpecialization() then
        specid = GetSpecialization()
        if GetSpecializationInfo then
            _, _, _, icon = GetSpecializationInfo(specid)
        end

        return specid, icon
    elseif GetPrimaryTalentTree and GetPrimaryTalentTree() then
        specid = GetPrimaryTalentTree()
        if specid and GetTalentTabInfo then
            _, _, _, icon = GetTalentTabInfo(specid)
        end

        return specid, icon
    elseif GetTalentTabInfo then
        local ps = 0
        for i = 1, 4 do
            local _, _, _, iconTexture, pointsSpent = GetTalentTabInfo(i)
            if pointsSpent ~= nil and pointsSpent > ps then
                ps = pointsSpent
                specid = i
                icon = iconTexture
                local _, class = UnitClass("PLAYER")
                if GetActiveTalentGroup and class == "DRUID" and D4:GetWoWBuild() ~= "CATA" then
                    local group = GetActiveTalentGroup()
                    local role = GetTalentGroupRole(group)
                    if role == "DAMAGER" then
                        specid = 2
                        icon = 132115
                    elseif role == "TANK" then
                        specid = 3
                    end
                end
            end

            if icon == nil then
                local _, class = UnitClass("PLAYER")
                icon = D4:GetSpecIcon(class, specid)
                if icon == nil then
                    if class == "DRUID" then
                        icon = 625999
                    elseif class == "HUNTER" then
                        icon = 626000
                    elseif class == "MAGE" then
                        icon = 626001
                    elseif class == "PALADIN" then
                        if specid == 1 then
                            icon = 135920
                        elseif specid == 2 then
                            icon = 135893
                        elseif specid == 3 then
                            icon = 135873
                        end
                    elseif class == "PRIEST" then
                        icon = 626004
                    elseif class == "ROGUE" then
                        icon = 626005
                    elseif class == "SHAMAN" then
                        icon = 626006
                    elseif class == "WARLOCK" then
                        icon = 626007
                    elseif class == "WARRIOR" then
                        icon = 626008
                    end
                end
            end
        end

        return specid, icon
    end

    return nil, nil
end

--- Obtiene los trinkets apropiados
---@param classID number ClassID
---@param specID number SpecID
---@return table trinkets MyCheatSheetInventoryItems
function MyCheatSheet:GetTrinckets(classID, specID)
    --- @type MyCheatSheetSpecializationData
    local specData = self.data.sheets[classID] and self.data.sheets[classID][specID]
    if not specData then
        return { bestInSlot = { itemIDs = {} }, alternatives = { itemIDs = {} } }
    end

    if specData.trinkets then
        return specData.trinkets
    end

    -- Estructura vacía por defecto
    return { bestInSlot = { itemIDs = {} }, alternatives = { itemIDs = {} } }
end

function MyCheatSheet:RefreshUI()
    self:DebugPrint("MyCheatSheet:RefreshUI")
    if self.MyCheatSheetFrame and self.MyCheatSheetFrame:IsShown() then
        -- Aquí puedes llamar a la función que repinta/redibuja el panel principal
        self:UpdateUI()
    end
end

local SecureTabs = LibStub("SecureTabs-2.0")

--- Añade una pestaña al CharacterFrame usando SecureTabs-2.0
function MyCheatSheet:AddCharacterFrameTab()
    if self.characterTabButton then return end -- Evitar duplicados

    -- Crea tu frame si no existe
    if not self.CharacterCheatSheetFrame then
        self.CharacterCheatSheetFrame = self:CreateCharacterCheatSheetUI()
    end

    -- Registra la pestaña
    self.characterTabButton = SecureTabs:Add(CharacterFrame, self.CharacterCheatSheetFrame, "CheatSheet");

    local tab = self.characterTabButton
    local secureTabButton = CreateFrame("Button", nil, CharacterFrame, "SecureActionButtonTemplate")
    secureTabButton:SetAttribute("type", "click")
    secureTabButton:SetAttribute("clickbutton", CharacterFrameTab4)
    secureTabButton:SetPoint("TOPLEFT", tab, "TOPLEFT")
    secureTabButton:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT")
    secureTabButton:RegisterForClicks("AnyDown")

    secureTabButton:HookScript("OnClick", function()
        tab:Click()
        if selectedTab ~= MyCheatSheet.characterTabButton:GetID() then
            MyCheatSheet.CharacterCheatSheetFrame:Hide()
        end
    end)

    tab:SetPassThroughButtons("LeftButton")
    tab.Enable = nop
    tab.Disable = nop

    tab.OnSelect = function()
        CharacterFrameTitleText:SetText(L["MY_CHEAT_SHEET"])
        -- todo - Mostrar el frame cuando se selecciona la pestaña
        if MyCheatSheet.CharacterCheatSheetFrame then
            MyCheatSheet.CharacterCheatSheetFrame:Show()
        end
    end

    tab.OnDeselect = function()
        -- Ocultar el frame cuando se deselecciona la pestaña
        if MyCheatSheet.CharacterCheatSheetFrame then
            MyCheatSheet.CharacterCheatSheetFrame:Hide()
        end
    end
    self.Tab = tab

end

-- core.lua - fin del archivo