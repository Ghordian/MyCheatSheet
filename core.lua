--- MyCheatSheet.lua
local ADDON_NAME, private = ... 

local MyCheatSheet = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0");

local AceLocale = LibStub("AceLocale-3.0")
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

-- Tabla de colores para cada estadística
MyCheatSheet.statColors = {
  -- https://warcraft.wiki.gg/wiki/API_GetAttackPowerForStat
    ["INTELLECT"]   = {r = .95, g = 0.55, b = 0.73, a = 1},     -- Fucsia
    ["HASTE"]       = {r = 0.25, g = 0.9, b = 0.45, a = 1},     -- Verde
    ["MASTERY"]     = {r = 0.65, g = 0.45, b = 0.95, a = 1},    -- Púrpura
    ["CRIT"]        = {r = 1.0, g = 0.25, b = 0.25, a = 1},     -- Rojo
    ["VERSATILITY"] = {r = 0.7, g = 0.7, b = 0.7, a = 1},       -- Gris
    ["AGILITY"]     = {r = 1.0, g = 0.8, b = 0.25, a = 1},      -- Dorado
    ["STRENGTH"]    = {r = 1.0, g = 0.5, b = 0.5, a = 1},       -- Rojo claro
};

-- Tabla de iconos MÁS IDENTIFICATIVOS y ARMÓNICOS con los colores
MyCheatSheet.statIcons = {
    ["INTELLECT"]   = "Interface\\Icons\\Spell_Arcane_Mind",               -- Cerebro arcano (fucsia/púrpura)
    ["HASTE"]       = "Interface\\Icons\\Spell_Nature_Windfury",           -- Viento verde (velocidad)
    ["MASTERY"]     = "Interface\\Icons\\Spell_Holy_InnerFire",            -- Fuego interior (maestría)
    ["CRIT"]        = "Interface\\Icons\\Ability_CriticalStrike",          -- Golpe crítico directo
    ["VERSATILITY"] = "Interface\\Icons\\Spell_Holy_Devotion",             -- Devoción (versátil/equilibrio)
    ["AGILITY"]     = "Interface\\Icons\\Spell_Nature_SpiritWolf",         -- Lobo espíritu (dorado/natural) 
    ["STRENGTH"]    = "Interface\\Icons\\Ability_Warrior_InnerRage",       -- Furia interior (rojo/fuerza)
};

MyCheatSheet.contentKeysToNames = {
    ["RAID"]        = L["RAID"],
    ["RAID-DAMAGE"] = L["RAID-DAMAGE"],
    ["RAID-TANK"]   = L["RAID-TANK"],
    ["RAID-HEAL"]   = L["RAID-HEAL"],
    ["RAID-CLEAVE"] = L["RAID-CLEAVE"],
    ["MYTHIC_PLUS"] = L["MYTHIC_PLUS"],
    ["DELVES"]      = L["DELVES"],
    ["OPEN_WORLD"]  = L["OPEN_WORLD"],
    ["DELVES_AND_OPEN_WORLD"] = L["DELVES_AND_OPEN_WORLD"],
    ["MYTHIC_PUSH_KEYS"] = L["MYTHIC_PUSH_KEYS"],
};

local debugMode = true
function MyCheatSheet:GetDebugMode()
    if self.db and self.db.profile and self.db.profile.advanced then
        debugMode = self.db.profile.advanced.debugMode
    end
    -- devolver estado actualizado
    return debugMode
end

--- 
function MyCheatSheet:DebugPrint(...)
  -- 
  if MyCheatSheet:GetDebugMode() then
    print("|cff00ff00[MyCheatSheet]|r |cff00ffff[DBG]|r", ...)
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

    print("|cff00ff00MyCheatSheet|r loaded. Use |cff00ff00/mcs|r to open.")
end


function MyCheatSheet:OnEnable()
    self:DebugPrint("MyCheatSheet:OnEnable")

    self.config = MyCheatSheet:GetModule("Config")
    self.validData = MyCheatSheet:GetModule("ValidData")
    self.export = MyCheatSheet:GetModule("Export")

    debugMode = self.config.GetDebugMode();

    self:CreateCheatSheetUI();
    self:CreateUIContent();
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
  local _, classID = UnitClassBase("player");
  local classInfo = C_CreatureInfo.GetClassInfo(classID);
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

  self:UpdateDropdowns();
  self:UpdateUI();
end

--- Crea la interfaz principal del cheat sheet
function MyCheatSheet:CreateCheatSheetUI()
    local frame = CreateFrame("Frame", "MyCheatSheetFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate");
    frame:SetPoint("CENTER");
    frame:SetSize(680, 580);
    frame:Hide();

    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 },
    });

    frame:SetBackdropColor(0.1, 0.1, 0.1, 1);
    frame:SetMovable(true);
    frame:SetClampedToScreen(true);
    frame:SetScript("OnMouseDown", function(self)
        if IsMouseButtonDown("LeftButton") then
            self:StartMoving();
        end
    end);
    frame:SetScript("OnMouseUp", function(self) self:StopMovingOrSizing(); end);

    if bResizableFrame then
        frame:SetResizable(true);
        -- Crear un tirador para redimensionar en la esquina inferior derecha
        local resizeHandle = CreateFrame("Button", nil, frame);
        resizeHandle:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -6, 6);
        resizeHandle:SetSize(16, 16);
    
        -- Establecer textura del tirador
        local texture = resizeHandle:CreateTexture(nil, "OVERLAY");
        texture:SetTexture("Interface\\Tooltips\\UI-Tooltip-Resize");
        texture:SetAllPoints(true);
    
        resizeHandle:SetScript("OnMouseDown", function(self)
            if IsMouseButtonDown("LeftButton") then
                self:GetParent():StartSizing();
            end
        end);
        resizeHandle:SetScript("OnMouseUp", function(self) self:GetParent():StopMovingOrSizing(); end);
    end

    -- Icono del addon en la esquina superior izquierda
    local iconFrame = CreateFrame("Frame", nil, frame);
    iconFrame:SetSize(24, 24);
    iconFrame:SetPoint("TOPLEFT", 16, -16);
    
    local iconTexture = iconFrame:CreateTexture(nil, "ARTWORK");
    iconTexture:SetAllPoints(iconFrame);
    iconTexture:SetTexture("Interface\\Icons\\INV_Scroll_03");
    iconTexture:SetTexCoord(0.08, 0.92, 0.08, 0.92); -- Recortar bordes para mejor apariencia
    
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
    title:SetText(L["MY_CHEAT_SHEET"]);
    title:SetPoint("TOP", 0, -10);

    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton");
    closeButton:SetPoint("TOPRIGHT", -12, -12);
    closeButton:SetScript("OnClick", function()
        frame:Hide();
    end);

    self.MyCheatSheetFrame = frame;
    tinsert(UISpecialFrames, "MyCheatSheetFrame");
end


--- Muestra u oculta la interfaz de usuario.
---@param show boolean|nil
function MyCheatSheet:ToggleUI(show)
    local frame = self.MyCheatSheetFrame;
    if show == nil then
        if frame:IsShown() then
            frame:Hide();
        else
            frame:Show();
        end
    elseif show then
        frame:Show();
    else
        frame:Hide();
    end
end


--- Crea el contenido inicial de la interfaz de usuario (dropdowns, scroll frame).
function MyCheatSheet:CreateUIContent()
    local parent = self.MyCheatSheetFrame;

    if parent == nil then
        self:DebugPrint("CreateUIContent", "parent == nil")
        return
    end

    local topOffset = -50;
    local leftPadding = 20;
    local padding = 10;
    local dropdownWidth = 180;
    local xOffset = padding + dropdownWidth + padding * 3;

    -- Etiqueta y Dropdown de Clase
    local classLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    classLabel:SetText(L["SELECT_CLASS"]);
    classLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", leftPadding, topOffset);
    classLabel:SetJustifyH("LEFT");

    self.classDropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate");
    self.classDropdown:SetPoint("TOPLEFT", classLabel, "BOTTOMLEFT", -20, -10); -- Espaciado reducido
    UIDropDownMenu_SetWidth(self.classDropdown, dropdownWidth);
    UIDropDownMenu_SetText(self.classDropdown, "");

    -- Etiqueta y Dropdown de Especialización
    local specLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    specLabel:SetText(L["SELECT_SPECIALIZATION"]);
    specLabel:SetPoint("LEFT", classLabel, "LEFT", xOffset, 0);
    specLabel:SetJustifyH("LEFT");

    self.specDropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate");
    self.specDropdown:SetPoint("TOPLEFT", specLabel, "BOTTOMLEFT", -20, -10); -- Espaciado reducido
    UIDropDownMenu_SetWidth(self.specDropdown, dropdownWidth);
    UIDropDownMenu_SetText(self.specDropdown, "");

    -- Etiqueta y Dropdown de Contenido
    local contentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    contentLabel:SetText(L["SELECT_CONTENT"]);
    contentLabel:SetPoint("LEFT", specLabel, "LEFT", xOffset, 0);
    contentLabel:SetJustifyH("LEFT");

    self.contentDropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate");
    self.contentDropdown:SetPoint("TOPLEFT", contentLabel, "BOTTOMLEFT", -20, -10); -- Espaciado reducido
    UIDropDownMenu_SetWidth(self.contentDropdown, dropdownWidth);
    UIDropDownMenu_SetText(self.contentDropdown, "");

    local scrollFrame = CreateFrame("ScrollFrame", "MyCheatSheetScrollFrame", parent, "UIPanelScrollFrameTemplate");
    scrollFrame:SetPoint("TOPLEFT", self.classDropdown, "BOTTOMLEFT", leftPadding, -15);
    scrollFrame:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -35, 50);

    local contentFrame = CreateFrame("Frame", "MyCheatSheetContentFrame", scrollFrame);
    contentFrame:SetSize(scrollFrame:GetWidth(), scrollFrame:GetHeight());
    contentFrame:SetPoint("TOPLEFT");
    scrollFrame:SetScrollChild(contentFrame);

    self.scrollFrame = scrollFrame;
    self.contentFrame = contentFrame;

    -- Import/Export Button
    local importExportButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate");
    importExportButton:SetText(L["IMPORT_EXPORT"]);
    importExportButton:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", leftPadding, 20);
    importExportButton:SetSize(140, 25); -- Aumentado de 120 a 140
    importExportButton:SetScript("OnClick", function() MyCheatSheet:OpenImportExportPanel(); end);
    importExportButton:Show();

    -- Edit Button (deshabilitado para futuras versiones)
    local editButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate");
    editButton:SetText(L["EDIT"]);
    editButton:SetPoint("LEFT", importExportButton, "RIGHT", 10, 0);
    editButton:SetSize(80, 25);
    editButton:SetScript("OnClick", function() MyCheatSheet:OpenEditPanel(); end);
    editButton:Hide();
end

--- Actualiza todos los dropdowns
function MyCheatSheet:UpdateDropdowns()
    self:UpdateClassDropdown();
end


local function SelectClassDropdown(info)
    if MyCheatSheet.selectedClass then
        self:DebugPrint("selectedClass", MyCheatSheet.selectedClass)
        local classInfo = C_CreatureInfo.GetClassInfo(MyCheatSheet.selectedClass);
        if classInfo then
            UIDropDownMenu_SetText(MyCheatSheet.classDropdown, classInfo.className);
        end
    end
    if MyCheatSheet.selectedSpec == nil then
        UIDropDownMenu_SetText(MyCheatSheet.specDropdown, L["SELECT_SPECIALIZATION"]);
    end
    if MyCheatSheet.selectedContent == nil then
        UIDropDownMenu_SetText(MyCheatSheet.contentDropdown, L["SELECT_CONTENT"]);
    end

    MyCheatSheet:UpdateSpecDropdown();
end

--- Actualiza el dropdown de clases
function MyCheatSheet:UpdateClassDropdown()
    UIDropDownMenu_Initialize(self.classDropdown, function(frame, level, menuList)
        for classID in pairs(MyCheatSheet.data.sheets) do
            local classInfo = C_CreatureInfo.GetClassInfo(classID);
            if classInfo then
                local info = UIDropDownMenu_CreateInfo()
                info.text = classInfo.className;
                info.value = classID;
                info.func = function(frame, arg1, arg2)
                    MyCheatSheet.selectedClass = frame.value;
                    MyCheatSheet.selectedSpec = nil;
                    MyCheatSheet.selectedContent = nil;
                    SelectClassDropdown(frame);
                end;
                info.checked = (classID == self.selectedClass);
                UIDropDownMenu_AddButton(info, level);
            end
        end
    end);

    if self.selectedClass then
        self:DebugPrint("SelectClassDefault", self.selectedClass)
        local classInfo = C_CreatureInfo.GetClassInfo(self.selectedClass);
        if classInfo then
            UIDropDownMenu_SetText(self.classDropdown, classInfo.className);
        end
    end
    self:UpdateSpecDropdown();
end


local function SelectSpecDropdown(info)
    self:DebugPrint("SelectSpecDropdown", info.value)
    UIDropDownMenu_SetText(MyCheatSheet.specDropdown, info.text);
    if MyCheatSheet.selectedContent == nil then
        UIDropDownMenu_SetText(MyCheatSheet.contentDropdown, L["SELECT_CONTENT"]);
    end
    if MyCheatSheet.selectedClass and MyCheatSheet.selectedSpec then
        local _, specLocal = GetSpecializationInfoByID(MyCheatSheet.selectedSpec);
        if specLocal then
            UIDropDownMenu_SetText(MyCheatSheet.specDropdown, specLocal);
        end
    end

    MyCheatSheet:UpdateContentSelection();
end

--- Actualiza el dropdown de especialización
function MyCheatSheet:UpdateSpecDropdown()
    UIDropDownMenu_Initialize(self.specDropdown, function(self, level, menuList)
        if MyCheatSheet.selectedClass and MyCheatSheet.data.sheets[MyCheatSheet.selectedClass] then
            for specID in pairs(MyCheatSheet.data.sheets[MyCheatSheet.selectedClass]) do
                local _, specLocal = GetSpecializationInfoByID(specID);
                if specLocal then
                    local info = UIDropDownMenu_CreateInfo()
                    info.text = specLocal;
                    info.value = specID;
                    info.func = function(frame, arg1, arg2)
                        MyCheatSheet.selectedSpec = frame.value;
                        SelectSpecDropdown(frame);
                    end;
                    info.checked = (specID == MyCheatSheet.selectedSpec);
                    UIDropDownMenu_AddButton(info, level);
                end
            end
        end
    end);

    if self.selectedClass and self.selectedSpec then
        self:DebugPrint("SelectSpecDefault", self.selectedSpec)
        local _, specLocal = GetSpecializationInfoByID(self.selectedSpec);
        if specLocal then
            UIDropDownMenu_SetText(self.specDropdown, specLocal);
        end
    end

    self:UpdateContentSelection();
end

--- Maneja la selección de contenido de forma inteligente
function MyCheatSheet:UpdateContentSelection()
    local selectedClass = self.selectedClass;
    local selectedSpec = self.selectedSpec;

    if selectedClass and selectedSpec then
        local currentSpecData = self.data.sheets[selectedClass][selectedSpec];

        -- Verificar si la clave de contenido actual sigue siendo válida para la nueva especialización
        if not self.selectedContent or not currentSpecData.statsByContent[self.selectedContent] then
            -- Si no es válida, selecciona la primera clave disponible
            local firstContentKey = nil;
            for contentKey in pairs(currentSpecData.statsByContent) do
                firstContentKey = contentKey;
                break;
            end
            self.selectedContent = firstContentKey;
            if firstContentKey then
            --**self:DebugPrint("New selected content:", firstContentKey)
            end
        end
    end

    self:UpdateContentDropdown();
end


local function SelectContentDropdown(info)
  UIDropDownMenu_SetText(MyCheatSheet.contentDropdown, info.text);
  MyCheatSheet:UpdateUI();
end

--- Actualiza el dropdown de contenido
function MyCheatSheet:UpdateContentDropdown()
    UIDropDownMenu_Initialize(self.contentDropdown, function(self, level, menuList)
        if MyCheatSheet.selectedClass and MyCheatSheet.selectedSpec and MyCheatSheet.data.sheets[MyCheatSheet.selectedClass][MyCheatSheet.selectedSpec].statsByContent then
            for contentKey in pairs(MyCheatSheet.data.sheets[MyCheatSheet.selectedClass][MyCheatSheet.selectedSpec].statsByContent) do
                local info = UIDropDownMenu_CreateInfo()
                info.text = MyCheatSheet.contentKeysToNames[contentKey] or contentKey;
                info.value = contentKey;
                info.func = function(frame, arg1, arg2)
                    MyCheatSheet.selectedContent = frame.value;
                    SelectContentDropdown(info);
                end;
                info.checked = (contentKey == MyCheatSheet.selectedContent);
                UIDropDownMenu_AddButton(info, level);
            end
        end
    end);

    if self.selectedClass and self.selectedSpec and self.selectedContent then
        self:DebugPrint("SelectContentDefault", self.selectedContent)
        local contentText = self.contentKeysToNames[self.selectedContent] or self.selectedContent;
        UIDropDownMenu_SetText(self.contentDropdown, contentText);
    end

    MyCheatSheet:UpdateUI();
end

--- Actualiza toda la interfaz de usuario con los datos actuales
function MyCheatSheet:Org_UpdateUI()
    local selectedClass = self.selectedClass;
    local selectedSpec = self.selectedSpec;
    local selectedContent = self.selectedContent;

    self:DebugPrint("UpdateUI", selectedClass, selectedSpec, selectedContent)

    -- Limpiar el contenido anterior
    for _, child in ipairs({ self.contentFrame:GetChildren() }) do
        child:Hide();
    end

    local yOffset = 0;
    local padding = 5;
    local specData = nil;
    local statData = nil;

    if selectedClass and selectedSpec and MyCheatSheet.data.sheets[selectedClass] and MyCheatSheet.data.sheets[selectedClass][selectedSpec] then
        specData = MyCheatSheet.data.sheets[selectedClass][selectedSpec];
        if selectedContent and specData.statsByContent[selectedContent] then
            statData = self:GetStatsData(selectedClass, selectedSpec, selectedContent);
        end
    end

    if not specData then
        if self.textNoDataSelected == nil then
            self.textNoDataSelected = self.contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        end
        self.textNoDataSelected:SetPoint("TOPLEFT", 20, -10);
        self.textNoDataSelected:SetText(L["NO_DATA_SELECTED"]);
        self.textNoDataSelected:Show();
        return;
    else
        if self.textNoDataSelected then
            self.textNoDataSelected:Hide();
        end
    end

    if statData then
        yOffset = yOffset + self:CreateStatPriorityRow(self.contentFrame, statData.statsPriority, yOffset, L["STAT_PRIORITY"]);
        yOffset = yOffset + padding;
    end

    -- WEAPONS
    local weaponData = {};
    local bestWeapons = self:GetSectionData("weapons", "bestInSlot")
    if bestWeapons and bestWeapons.itemIDs and #bestWeapons.itemIDs > 0 then
        tinsert(weaponData, { title = L["BEST_IN_SLOT"], itemIDs = bestWeapons.itemIDs });
    end
    local altWeapons = self:GetSectionData("weapons", "alternatives")
    if altWeapons and altWeapons.itemIDs and #altWeapons.itemIDs > 0 then
        tinsert(weaponData, { title = L["ALTERNATIVES"], itemIDs = altWeapons.itemIDs });
    end
    if #weaponData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["WEAPONS"], weaponData);
        yOffset = yOffset + padding;
    end

    -- TRINKETS
    local trinketData = {};
    local bestTrinkets = self:GetSectionData("trinkets", "bestInSlot")
    if bestTrinkets and bestTrinkets.itemIDs and #bestTrinkets.itemIDs > 0 then
        tinsert(trinketData, { title = L["BEST_IN_SLOT"], itemIDs = bestTrinkets.itemIDs });
    end
    local altTrinkets = self:GetSectionData("trinkets", "alternatives")
    if altTrinkets and altTrinkets.itemIDs and #altTrinkets.itemIDs > 0 then
        tinsert(trinketData, { title = L["ALTERNATIVES"], itemIDs = altTrinkets.itemIDs });
    end
    if #trinketData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["TRINKETS"], trinketData);
        yOffset = yOffset + padding;
    end

    -- CONSUMABLES
    local consumablesItems = self:GetSectionData("consumables")
    if consumablesItems and consumablesItems.itemIDs and #consumablesItems.itemIDs > 0 then
        local consumablesData = {
            { title = "", itemIDs = consumablesItems.itemIDs },
        };
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["CONSUMABLES"], consumablesData);
        yOffset = yOffset + padding;
    end

    -- TIER
    local tierData = {};
    local bestInSlotTier = self:GetSectionData("tier", "bestInSlot");
    if bestInSlotTier and bestInSlotTier.itemIDs and #bestInSlotTier.itemIDs > 0 then
        tinsert(tierData, { title = L["BEST_IN_SLOT"], itemIDs = bestInSlotTier.itemIDs });
    end
    local altTier = self:GetSectionData("tier", "alternatives");
    if altTier and altTier.itemIDs and #altTier.itemIDs > 0 then
        tinsert(tierData, { title = L["ALTERNATIVES"], itemIDs = altTier.itemIDs });
    end
    if #tierData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["TIER"], tierData);
        yOffset = yOffset + padding;
    end

    local extraPadding = 0;
    self.contentFrame:SetSize(self.scrollFrame:GetWidth() - extraPadding, yOffset);
end

--- Actualiza toda la interfaz de usuario con los datos actuales
function MyCheatSheet:UpdateUI()
    local selectedClass = self.selectedClass;
    local selectedSpec = self.selectedSpec;
    local selectedContent = self.selectedContent;

    self:DebugPrint("UpdateUI", selectedClass, selectedSpec, selectedContent)

    -- Limpiar el contenido anterior
    for _, child in ipairs({ self.contentFrame:GetChildren() }) do
        child:Hide();
    end

    local yOffset = 0;
    local padding = 5;
    local specData = nil;
    local statData = nil;

    if selectedClass and selectedSpec and MyCheatSheet.data.sheets[selectedClass] and MyCheatSheet.data.sheets[selectedClass][selectedSpec] then
        specData = MyCheatSheet.data.sheets[selectedClass][selectedSpec];
        if selectedContent and specData.statsByContent[selectedContent] then
            statData = self:GetStatsData(selectedClass, selectedSpec, selectedContent);
        end
    end

    if not specData then
        if self.textNoDataSelected == nil then
            self.textNoDataSelected = self.contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        end
        self.textNoDataSelected:SetPoint("TOPLEFT", 20, -10);
        self.textNoDataSelected:SetText(L["NO_DATA_SELECTED"]);
        self.textNoDataSelected:Show();
        return;
    else
        if self.textNoDataSelected then
            self.textNoDataSelected:Hide();
        end
    end

    if statData then
        yOffset = yOffset + self:CreateStatPriorityRow(self.contentFrame, statData.statsPriority, yOffset, L["STAT_PRIORITY"]);
        yOffset = yOffset + padding;
    end

    -- WEAPONS
    local weaponData = {};
    local bestWeapons = self:GetSectionData("weapons", "bestInSlot")
    if bestWeapons and bestWeapons.itemIDs and #bestWeapons.itemIDs > 0 then
        tinsert(weaponData, { title = L["BEST_IN_SLOT"], itemIDs = bestWeapons.itemIDs });
    end
    local altWeapons = self:GetSectionData("weapons", "alternatives")
    if altWeapons and altWeapons.itemIDs and #altWeapons.itemIDs > 0 then
        tinsert(weaponData, { title = L["ALTERNATIVES"], itemIDs = altWeapons.itemIDs });
    end
    if #weaponData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["WEAPONS"], weaponData);
        yOffset = yOffset + padding;
    end

    -- TRINKETS
    local trinketData = {};
    local bestTrinkets = self:GetSectionData("trinkets", "bestInSlot")
    if bestTrinkets and bestTrinkets.itemIDs and #bestTrinkets.itemIDs > 0 then
        tinsert(trinketData, { title = L["BEST_IN_SLOT"], itemIDs = bestTrinkets.itemIDs });
    end
    local altTrinkets = self:GetSectionData("trinkets", "alternatives")
    if altTrinkets and altTrinkets.itemIDs and #altTrinkets.itemIDs > 0 then
        tinsert(trinketData, { title = L["ALTERNATIVES"], itemIDs = altTrinkets.itemIDs });
    end
    if #trinketData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["TRINKETS"], trinketData);
        yOffset = yOffset + padding;
    end

    -- CONSUMABLES
    local consumablesItems = self:GetSectionData("consumables")
    if consumablesItems and consumablesItems.itemIDs and #consumablesItems.itemIDs > 0 then
        local consumablesData = {
            { title = "", itemIDs = consumablesItems.itemIDs },
        };
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["CONSUMABLES"], consumablesData);
        yOffset = yOffset + padding;
    end

    -- TIER
    local tierData = {};
    local bestInSlotTier = self:GetSectionData("tier", "bestInSlot");
    if bestInSlotTier and bestInSlotTier.itemIDs and #bestInSlotTier.itemIDs > 0 then
        tinsert(tierData, { title = L["BEST_IN_SLOT"], itemIDs = bestInSlotTier.itemIDs });
    end
    local altTier = self:GetSectionData("tier", "alternatives");
    if altTier and altTier.itemIDs and #altTier.itemIDs > 0 then
        tinsert(tierData, { title = L["ALTERNATIVES"], itemIDs = altTier.itemIDs });
    end
    if #tierData > 0 then
        yOffset = yOffset + self:CreateItemSection(self.contentFrame, yOffset, L["TIER"], tierData);
        yOffset = yOffset + padding;
    end

    -- Agregar información del autor y fecha de actualización al final
    if specData.author or specData.updated then
        yOffset = yOffset + self:CreateSheetInfoFooter(self.contentFrame, yOffset, specData);
    end

    local extraPadding = 0;
    self.contentFrame:SetSize(self.scrollFrame:GetWidth() - extraPadding, yOffset);
end

--- Crea el pie de página con información del autor y fecha de actualización
---@param parent Frame
---@param yOffset number
---@param specData table
---@return number footerHeight La altura del pie de página creado.
function MyCheatSheet:CreateSheetInfoFooter(parent, yOffset, specData)
    local footerHeight = 30;
    local footerFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate");
    footerFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -yOffset);
    footerFrame:SetSize(parent:GetWidth() - 20, footerHeight);
    footerFrame:Show();

    footerFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 8,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    });
    footerFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.3);

    local infoText = "";
    
    if specData.author then
        infoText = L["AUTHOR"] and (L["AUTHOR"] .. ": " .. specData.author) or ("Author: " .. specData.author);
    end
    
    if specData.updated then
        local updatedText = L["UPDATED"] and (L["UPDATED"] .. ": " .. specData.updated) or ("Updated: " .. specData.updated);
        if infoText ~= "" then
            infoText = infoText .. "  |  " .. updatedText;
        else
            infoText = updatedText;
        end
    end

    if infoText ~= "" then
        local infoString = footerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
        infoString:SetText(infoText);
        infoString:SetTextColor(0.7, 0.7, 0.7, 1);
        infoString:SetPoint("CENTER", footerFrame, "CENTER", 0, 0);
        infoString:SetJustifyH("CENTER");
    end

    return footerHeight;
end

--- Crea una fila de prioridad de estadísticas en la UI
---@param parent Frame
---@param statGroups table<number, MyCheatSheetStatGroup>
---@param yOffset number
---@param title string
---@return number rowHeight La altura de la fila creada.
function MyCheatSheet:CreateStatPriorityRow(parent, statGroups, yOffset, title)
    local rowHeight = 50;
    local rowFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate");
    rowFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -yOffset);
    rowFrame:SetSize(parent:GetWidth() - 20, rowHeight);
    rowFrame:Show();

    rowFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    });
    rowFrame:SetBackdropColor(0.2, 0.2, 0.2, 0.5);

    local titleString = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    titleString:SetText(title);
    titleString:SetTextColor(1.0, 1.0, 1.0);
    titleString:SetPoint("TOPLEFT", 5, -5);

    -- Botón de edición de estadísticas
    local editStatsButton = CreateFrame("Button", nil, rowFrame, "UIPanelButtonTemplate")
    editStatsButton:SetText("Edit")
    editStatsButton:SetSize(50, 20)
    editStatsButton:SetPoint("TOPRIGHT", rowFrame, "TOPRIGHT", -10, -4)
    editStatsButton:SetScript("OnClick", function()
        self:OpenStatsEditor()
    end)

    local xOffset = 20;
    local statYOffset = -25;
    for i, group in ipairs(statGroups) do
        for j, stat in ipairs(group.stats) do
            local statText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            statText:SetText(L[stat]);
            statText:SetPoint("TOPLEFT", xOffset, statYOffset);
            if self.statColors[stat] then
                statText:SetTextColor(self.statColors[stat].r, self.statColors[stat].g, self.statColors[stat].b, self.statColors[stat].a);
            end
            xOffset = xOffset + statText:GetWidth() + 5;

            if j < #group.stats then
                local separator = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
                separator:SetText("=");
                separator:SetPoint("TOPLEFT", xOffset, statYOffset);
                xOffset = xOffset + separator:GetWidth() + 5;
            end
        end
        if group.operator and i < #statGroups then
            local separator = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            separator:SetText(group.operator);
            separator:SetPoint("TOPLEFT", xOffset, statYOffset);
            xOffset = xOffset + separator:GetWidth() + 5;
        end
    end

    return rowHeight;
end

function MyCheatSheet:Icons_CreateStatPriorityRow(parent, statGroups, yOffset, title)
    local rowHeight = 60;
    local rowFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate");
    rowFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -yOffset);
    rowFrame:SetSize(parent:GetWidth() - 20, rowHeight);
    rowFrame:Show();

    rowFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    });
    rowFrame:SetBackdropColor(0.2, 0.2, 0.2, 0.5);

    local titleString = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    titleString:SetText(title);
    titleString:SetTextColor(1.0, 1.0, 1.0);
    titleString:SetPoint("TOPLEFT", 5, -5);

    local editStatsButton = CreateFrame("Button", nil, rowFrame, "UIPanelButtonTemplate")
    editStatsButton:SetText("Edit")
    editStatsButton:SetSize(50, 20)
    editStatsButton:SetPoint("TOPRIGHT", rowFrame, "TOPRIGHT", -10, -4)
    editStatsButton:SetScript("OnClick", function()
        self:OpenStatsEditor()
    end)

    local startX = 15;
    local currentY = -27;
    local currentX = startX;
    local iconSize = 26;

    for i, group in ipairs(statGroups) do
        for j, stat in ipairs(group.stats) do
            local iconFrame = CreateFrame("Frame", nil, rowFrame);
            iconFrame:SetSize(iconSize, iconSize);
            iconFrame:SetPoint("TOPLEFT", currentX, currentY);

            local icon = iconFrame:CreateTexture(nil, "ARTWORK");
            icon:SetAllPoints(iconFrame);
            icon:SetTexture(self.statIcons[stat] or "Interface\\Icons\\INV_Misc_QuestionMark");

            local border = iconFrame:CreateTexture(nil, "OVERLAY");
            border:SetAllPoints(iconFrame);
            border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
            border:SetVertexColor(1, 1, 1, 0.8);

            currentX = currentX + iconSize + 4;

            local statText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            statText:SetText(L[stat]);
            statText:SetPoint("TOPLEFT", currentX, currentY + iconSize/2);
            statText:SetJustifyH("LEFT");

            if self.statColors[stat] then
                statText:SetTextColor(self.statColors[stat].r, self.statColors[stat].g, self.statColors[stat].b, self.statColors[stat].a);
                icon:SetVertexColor(
                    0.6 + (self.statColors[stat].r * 0.4),
                    0.6 + (self.statColors[stat].g * 0.4),
                    0.6 + (self.statColors[stat].b * 0.4),
                    1
                );
            end

            currentX = currentX + statText:GetStringWidth() + 8;

            if j < #group.stats then
                local separator = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
                separator:SetText("=");
                separator:SetPoint("TOPLEFT", currentX, currentY + iconSize/2);
                separator:SetTextColor(0.8, 0.8, 0.8, 1);
                currentX = currentX + separator:GetStringWidth() + 8;
            end

            iconFrame:SetScript("OnEnter", function()
                GameTooltip:SetOwner(iconFrame, "ANCHOR_TOP");
                GameTooltip:SetText(L[stat], 1, 1, 1);
                GameTooltip:Show();
            end);
            iconFrame:SetScript("OnLeave", function() GameTooltip:Hide(); end);
        end

        if group.operator and i < #statGroups then
            local operatorText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            operatorText:SetText(group.operator);
            operatorText:SetPoint("TOPLEFT", currentX, currentY + iconSize/2);
            operatorText:SetTextColor(1, 1, 0, 1);

            local operatorFont = CreateFont("OperatorFont" .. i);
            operatorFont:SetFont("Fonts\\FRIZQT__.TTF", 15, "OUTLINE");
            operatorText:SetFontObject(operatorFont);

            currentX = currentX + operatorText:GetStringWidth() + 15;
        end
    end

    return rowHeight;
end


--- Crea una sección completa (un marco) con un título principal y subsecciones de ítems
---@param parent Frame
---@param yOffset number
---@param title string
---@param subsections table<number, table>
---@return number sectionHeight La altura de la sección creada.
function MyCheatSheet:CreateItemSection(parent, yOffset, title, subsections)
    local itemSize = 40;
    local itemPadding = 5;
    local titleHeight = 15;
    local subtitleHeight = 12;
    local verticalPadding = 5;
    local horizontalPadding = 15;

    local sectionFrame = CreateFrame("Frame", nil, parent, "BackdropTemplate");
    sectionFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -yOffset);
    sectionFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    });
    sectionFrame:SetBackdropColor(0.2, 0.2, 0.2, 0.5);

    local titleString = sectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    titleString:SetText(title);
    titleString:SetTextColor(1.0, 1.0, 1.0);
    titleString:SetPoint("TOPLEFT", 5, -5);

    -- Verificar si la sección tiene subsecciones
    local hasSubsections = false
    local hasAlternatives = false

    -- Detectar si tiene estructura de subsecciones
    if subsections and #subsections > 0 then
        for _, subsection in ipairs(subsections) do
            if subsection.title == L["BEST_IN_SLOT"] then
                hasSubsections = true
            elseif subsection.title == L["ALTERNATIVES"] then
                hasAlternatives = true
            end
        end
    end

    if hasSubsections then
        -- SECCIONES CON SUBSECCIONES (Weapons, Trinkets, Tier)
        local buttonWidth = 50
        local buttonSpacing = 5

        -- Botón BiS (PRIMERO)
        local editBisButton = CreateFrame("Button", nil, sectionFrame, "UIPanelButtonTemplate")
        editBisButton:SetText("BiS")
        editBisButton:SetSize(buttonWidth, 20)
        editBisButton:SetPoint("TOPRIGHT", sectionFrame, "TOPRIGHT", -10, -4)
        editBisButton:SetScript("OnClick", function()
            self:OpenSimpleEditor(title, "bestInSlot")
        end)

        -- Botón Alt (SEGUNDO, solo si existe)
        if hasAlternatives then
            local editAltButton = CreateFrame("Button", nil, sectionFrame, "UIPanelButtonTemplate")
            editAltButton:SetText("Alt")
            editAltButton:SetSize(buttonWidth, 20)
            editAltButton:SetPoint("RIGHT", editBisButton, "LEFT", -buttonSpacing, 0)
            editAltButton:SetScript("OnClick", function()
                self:OpenSimpleEditor(title, "alternatives")
            end)
        end
    else
        -- SECCIONES SIN SUBSECCIONES (Consumables)
        local editButton = CreateFrame("Button", nil, sectionFrame, "UIPanelButtonTemplate")
        editButton:SetText(L["EDIT"])
        editButton:SetSize(50, 20)
        editButton:SetPoint("TOPRIGHT", sectionFrame, "TOPRIGHT", -10, -4)
        editButton:SetScript("OnClick", function()
            self:OpenSimpleEditor(title, "direct")  -- Modo especial para consumables
        end)
    end

    local currentHeight = titleHeight + verticalPadding;
    local maxSubSectionHeight = 0;
    local horizontalOffset = 20;

    if subsections and #subsections > 0 then
        for i, subSection in ipairs(subsections) do
            local subSectionHeight = 0;
            local currentSubYOffset = -currentHeight;

            if subSection.title and subSection.title ~= "" then
                local subtitleString = sectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
                subtitleString:SetText(subSection.title);
                subtitleString:SetTextColor(0.8, 0.8, 0.8);
                subtitleString:SetPoint("TOPLEFT", horizontalOffset, currentSubYOffset);
                subSectionHeight = subSectionHeight + subtitleHeight + verticalPadding;
            end

            local itemYOffset = currentSubYOffset - subSectionHeight;

            if not subSection.itemIDs or #subSection.itemIDs == 0 then
                local noDataText = sectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
                noDataText:SetText(L["NO_DATA_AVAILABLE"]);
                noDataText:SetPoint("TOPLEFT", horizontalOffset, itemYOffset + 10);
                subSectionHeight = subSectionHeight + subtitleHeight + verticalPadding;
            else
                for j, itemID in ipairs(subSection.itemIDs) do
                    local button = CreateFrame("Button", nil, sectionFrame);
                    button:SetSize(itemSize, itemSize);
                    button:SetPoint("TOPLEFT", horizontalOffset + (j-1) * (itemSize + itemPadding), itemYOffset);

                    local icon = button:CreateTexture(nil, "ARTWORK");
                    icon:SetAllPoints(button);

                    local _, itemType, itemSubType, itemEquipLoc, itemIcon, classID, subClassID = C_Item.GetItemInfoInstant(itemID)
                    icon:SetTexture(itemIcon);

                    button.itemID = itemID;

                    button:SetScript("OnEnter", function(self)
                        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
                        GameTooltip:SetItemByID(self.itemID);
                    end);
                    button:SetScript("OnLeave", function(self)
                        GameTooltip:Hide();
                    end);
                    button:SetScript("OnClick", function(self, mouseButton)
                        if mouseButton == "LeftButton" then
                            local itemName, itemLink = C_Item.GetItemInfo(button.itemID)
                            if itemLink then
                                ChatEdit_InsertLink(itemLink);
                            end
                        end
                    end);
                end
                subSectionHeight = subSectionHeight + itemSize + verticalPadding;
            end

            subSectionHeight = subSectionHeight + verticalPadding;
--**        horizontalOffset = horizontalOffset + (#subSection.itemIDs * (itemSize + itemPadding)) + horizontalPadding;
            horizontalOffset = horizontalOffset + (#subSection.itemIDs * (itemSize + itemPadding)) + horizontalPadding * 2;

            if subSectionHeight > maxSubSectionHeight then
                maxSubSectionHeight = subSectionHeight;
            end
        end
    end
    
    currentHeight = currentHeight + maxSubSectionHeight;
    sectionFrame:SetSize(parent:GetWidth() - 20, currentHeight);
    sectionFrame:Show();
    
    return sectionFrame:GetHeight();
end

--- Obtiene datos de una sección con soporte para overrides personalizados
---@param sectionType string
---@param subsectionType string|nil
---@return table|nil
function MyCheatSheet:GetSectionData(sectionType, subsectionType)
    local customData = nil
    
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
        return customData
    end
    
    -- Para trinkets, usar GetTrinckets()
    if sectionType == "trinkets" then
        local trinkets = self:GetTrinckets(self.selectedClass, self.selectedSpec)
        if subsectionType then
            return trinkets[subsectionType]
        else
            return trinkets
        end
    end
    
    -- Fallback a datos por defecto para otras secciones
    local specData = self.data.sheets[self.selectedClass] and 
                     self.data.sheets[self.selectedClass][self.selectedSpec]
    if specData and specData[sectionType] then
        if subsectionType then
            return specData[sectionType][subsectionType]
        else
            return specData[sectionType]
        end
    end
    
    return nil
end

--- Obtiene datos de estadísticas con soporte para stats personalizadas
---@param classID number
---@param specID number
---@param contentKey string
---@return table|nil
function MyCheatSheet:GetStatsData(classID, specID, contentKey)
    -- 1. Buscar stats personalizadas primero
    if MyCheatSheetDB and MyCheatSheetDB.customOverrides and 
       MyCheatSheetDB.customOverrides[classID] and
       MyCheatSheetDB.customOverrides[classID][specID] and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey] and
       MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey].statsPriority then
        
        -- Devolver stats personalizadas
        return {
            statsPriority = MyCheatSheetDB.customOverrides[classID][specID].statsByContent[contentKey].statsPriority
        }
    end

    -- 2. Si no hay personalizadas, devolver las originales
    local specData = self.data.sheets[classID] and self.data.sheets[classID][specID]
    if specData and specData.statsByContent and specData.statsByContent[contentKey] then
        return specData.statsByContent[contentKey]
    end

    return nil
end

--- Abre el panel de importación y exportación
function MyCheatSheet:OpenImportExportPanel()
    -- Crear o mostrar el panel de Import/Export
    if not self.importExportFrame then
        self.importExportFrame = self:CreateImportExportFrame()
    end
    
    -- Posicionar el panel ligeramente desplazado del centro para no cubrir completamente el panel principal
    self.importExportFrame:ClearAllPoints()
    self.importExportFrame:SetPoint("CENTER", UIParent, "CENTER", 50, 50)
    self.importExportFrame:Show()
    self.importExportFrame:Raise() -- Asegurar que esté por encima
end

--- Crea el frame de Import/Export
---@return Frame importExportFrame
function MyCheatSheet:CreateImportExportFrame()
    local frame = CreateFrame("Frame", "MyCheatSheetImportExportFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(500, 480) -- Aumentamos más la altura para la caja de texto grande
    frame:SetPoint("CENTER", UIParent, "CENTER", 50, 50) -- Ligeramente desplazado
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Asegurar que aparezca por encima de otros paneles
    frame:SetFrameStrata("DIALOG")
    frame:SetFrameLevel(1000)
    
    -- Registrar para manejo de ESC
    frame:SetScript("OnShow", function(self)
        table.insert(UISpecialFrames, "MyCheatSheetImportExportFrame")
    end)
    
    frame:SetScript("OnHide", function(self)
        for i = #UISpecialFrames, 1, -1 do
            if UISpecialFrames[i] == "MyCheatSheetImportExportFrame" then
                table.remove(UISpecialFrames, i)
                break
            end
        end
    end)
    
    -- Título
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetText("Import / Export")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5)
    
    -- Sección Export
    local exportLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    exportLabel:SetText("Export")
    exportLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -40)
    exportLabel:SetTextColor(0.8, 1, 0.8)
    
    -- Botones Export
    local exportSpecButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    exportSpecButton:SetText("Export Current Spec")
    exportSpecButton:SetSize(180, 25)
    exportSpecButton:SetPoint("TOPLEFT", exportLabel, "BOTTOMLEFT", 0, -10)
    exportSpecButton:SetScript("OnClick", function()
        if self.selectedClass and self.selectedSpec then
            if self.export then
                self.export:HandleExportCommand({"export", "spec", tostring(self.selectedClass), tostring(self.selectedSpec)})
            end
        else
            print("|cffff0000Please select a class and spec first|r")
        end
    end)
    
    local exportClassButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    exportClassButton:SetText("Export Current Class")
    exportClassButton:SetSize(180, 25)
    exportClassButton:SetPoint("TOPLEFT", exportSpecButton, "BOTTOMLEFT", 0, -5)
    exportClassButton:SetScript("OnClick", function()
        if self.selectedClass then
            if self.export then
                self.export:HandleExportCommand({"export", "class", tostring(self.selectedClass)})
            end
        else
            print("|cffff0000Please select a class first|r")
        end
    end)
    
    local exportAllButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    exportAllButton:SetText("Export All Data")
    exportAllButton:SetSize(180, 25)
    exportAllButton:SetPoint("TOPLEFT", exportClassButton, "BOTTOMLEFT", 0, -5)
    exportAllButton:SetScript("OnClick", function()
        if self.export then
            self.export:HandleExportCommand({"export", "all"})
        end
    end)
    
    -- Sección Import
    local importLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    importLabel:SetText("Import")
    importLabel:SetPoint("TOPLEFT", exportAllButton, "BOTTOMLEFT", 0, -25)
    importLabel:SetTextColor(0.8, 0.8, 1)
    
    -- EditBox para pegar datos (más grande y como ScrollFrame)
    local importScrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    importScrollFrame:SetSize(420, 80) -- Reducimos el ancho para dar espacio a la scrollbar
    importScrollFrame:SetPoint("TOPLEFT", importLabel, "BOTTOMLEFT", 0, -10)
    
    -- Añadir marco visual al ScrollFrame
    local importBorder = CreateFrame("Frame", nil, frame, "InsetFrameTemplate")
    importBorder:SetSize(422, 82) -- Ligeramente más grande que el ScrollFrame
    importBorder:SetPoint("CENTER", importScrollFrame, "CENTER")
    importScrollFrame:SetParent(importBorder)
    
    local importEditBox = CreateFrame("EditBox", nil, importScrollFrame)
    importEditBox:SetSize(400, 80) -- Ajustamos el ancho del EditBox
    importEditBox:SetMultiLine(true)
    importEditBox:SetAutoFocus(false)
    importEditBox:SetFontObject(ChatFontNormal)
    importEditBox:SetText("Paste export string here...")
    importEditBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    importEditBox:SetScript("OnEditFocusGained", function(self)
        if self:GetText() == "Paste export string here..." then
            self:SetText("")
        end
    end)
    importEditBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            self:SetText("Paste export string here...")
        end
    end)
    
    importScrollFrame:SetScrollChild(importEditBox)
    
    local importButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    importButton:SetText("Preview Import")
    importButton:SetSize(120, 25) -- Más ancho
    importButton:SetPoint("TOPLEFT", importBorder, "BOTTOMLEFT", 0, -10)
    importButton:SetScript("OnClick", function()
        local importData = importEditBox:GetText()
        if importData and importData ~= "" and importData ~= "Paste export string here..." then
            if self.export then
                self.export:HandleImportCommand({"import", importData, "preview"})
            end
        else
            print("|cffff0000Please paste an export string first|r")
        end
    end)
    
    local mergeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    mergeButton:SetText("Quick Merge")
    mergeButton:SetSize(100, 25) -- Más ancho
    mergeButton:SetPoint("LEFT", importButton, "RIGHT", 10, 0)
    mergeButton:SetScript("OnClick", function()
        local importData = importEditBox:GetText()
        if importData and importData ~= "" and importData ~= "Paste export string here..." then
            if self.export then
                self.export:HandleImportCommand({"import", importData, "merge"})
            end
        else
            print("|cffff0000Please paste an export string first|r")
        end
    end)
    
    -- Sección Custom Data
    local customLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    customLabel:SetText("Custom Data")
    customLabel:SetPoint("TOPLEFT", importButton, "BOTTOMLEFT", 0, -25)
    customLabel:SetTextColor(1, 0.8, 0.8)
    
    local customListButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    customListButton:SetText("List Custom Sheets")
    customListButton:SetSize(180, 25)
    customListButton:SetPoint("TOPLEFT", customLabel, "BOTTOMLEFT", 0, -10)
    customListButton:SetScript("OnClick", function()
        if self.export then
            self.export:HandleCustomCommand({"custom", "list"})
        end
    end)
    
    local customClearButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    customClearButton:SetText("Clear All Custom Data")
    customClearButton:SetSize(180, 25)
    customClearButton:SetPoint("TOPLEFT", customListButton, "BOTTOMLEFT", 0, -5)
    customClearButton:SetScript("OnClick", function()
        if self.export then
            self.export:HandleCustomCommand({"custom", "clear"})
        end
    end)
    
    -- Permitir cerrar con Escape
    frame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:Hide()
        end
    end)
    
    frame:Hide()
    return frame
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

--- Delega la aplicación de posición al módulo Config
function MyCheatSheet:ApplyFramePosition()
    if self:IsModuleEnabled("Config") then
        self.Config:ApplyFramePosition()
    end
end

--- Delega el reseteo de posición al módulo Config
function MyCheatSheet:ResetPosition()
    if self:IsModuleEnabled("Config") then
        self.Config:ResetPosition()
    end
end

--- Delega la inicialización de configuración al módulo Config
function MyCheatSheet:InitializeConfig()
    if self:IsModuleEnabled("Config") then
        self.Config:InitializeConfig()
    else
        self:EnableModule("Config")
    end
end

--- Guarda la posición actual del frame en la base de datos
function MyCheatSheet:SaveFramePosition()
    if self.MyCheatSheetFrame and self.db then
        local point, _, _, x, y = self.MyCheatSheetFrame:GetPoint()
        self.db.profile.ui.position.point = point or "CENTER"
        self.db.profile.ui.position.x = x or 0
        self.db.profile.ui.position.y = y or 0

        self:DebugPrint(string.format("Position saved: %s %.0f,%.0f", point, x, y))
    end
end

--- Configura el guardado automático de posición al arrastrar el frame
function MyCheatSheet:SetupFramePositionSaving()
    if self.MyCheatSheetFrame then
        self.MyCheatSheetFrame:SetScript("OnDragStop", function(frame)
            frame:StopMovingOrSizing()
            self:SaveFramePosition()
        end)
    end
end

--- Obtiene los trinkets apropiados - VERSIÓN SIMPLIFICADA
---@param classID number
---@param specID number
---@return table trinkets { bestInSlot = {...}, alternatives = {...} }
function MyCheatSheet:GetTrinckets(classID, specID)
    local specData = self.data.sheets[classID] and self.data.sheets[classID][specID]
    if not specData then
        return { bestInSlot = { itemIDs = {} }, alternatives = { itemIDs = {} } }
    end
    
    -- SIMPLE: Solo usar trinkets generales
    if specData.trinkets then
        return specData.trinkets
    end
    
    -- Estructura vacía por defecto
    return { bestInSlot = { itemIDs = {} }, alternatives = { itemIDs = {} } }
end

-- core.lua - fin del archivo