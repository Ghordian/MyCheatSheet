-- UI logic functions moved from core.lua

local ADDON_NAME, private = ... 

---@type MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

-- =============================
-- Creación de la UI principal
-- =============================

--- Crea la interfaz principal del cheat sheet
function MyCheatSheet:CreateCheatSheetUI()

    -- BasicFrameTemplateWithInset
    -- BackdropTemplateMixin and "BackdropTemplate"
    local frame = CreateFrame("Frame", "MyCheatSheetFrame", UIParent, "BackdropTemplate");
    -- Intentar restaurar la posición guardada
    ---@type FramePosition
    local pos = self.db and self.db.profile and self.db.profile.ui and self.db.profile.ui.position
    if pos and pos.point and pos.x and pos.y then
        frame:SetPoint(pos.point, UIParent, pos.point, pos.x, pos.y)
    else
        frame:SetPoint("CENTER")
        self:DebugPrint("No FramePosition", self.db, self.db.profile, self.db.profile.ui, self.db.profile.ui.position)
    end
    frame:SetSize(680, 580);
    frame:Hide();

    -- Aplica el fondo según la opción de fondo opaco
    self.MyCheatSheetFrame = frame;
    self:UpdateMainPanelBackdrop()
    frame:SetMovable(true);
    frame:EnableMouse(true);
    frame:SetClampedToScreen(true);
    frame:RegisterForDrag("LeftButton");
    frame:SetScript("OnDragStart", frame.StartMoving);
    frame:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing();
        MyCheatSheet:SaveFramePosition();
    end);

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
    local titleFont = CreateFont("MyCheatSheetTitleFont");
    titleFont:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE"); -- Tamaño aumentado
    title:SetFontObject(titleFont);

    local closeButton = CreateFrame("Button", "MyCheatSheetTitleCloseButton", frame, "UIPanelCloseButton");
    closeButton:SetPoint("TOPRIGHT", -12, -12);
    closeButton:SetScript("OnClick", function()
        frame:Hide();
    end);
    frame.closeButton = closeButton

    -- Botón de edición de layout
    local editLayoutButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    editLayoutButton:SetSize(90, 24)
    editLayoutButton:SetText(L["EDIT_LAYOUT"])
    editLayoutButton:SetWidth(editLayoutButton:GetFontString():GetStringWidth() + 24)
    editLayoutButton:SetPoint("RIGHT", closeButton, "LEFT", -8, 0)
    editLayoutButton:SetScript("OnClick", function()
        if MyCheatSheet.isLayoutEditMode then
            StaticPopup_Show("MYCHEATSHEET_CONFIRM_SAVE_LAYOUT")
        else
            MyCheatSheet.editLayoutButton = editLayoutButton
            MyCheatSheet:ToggleLayoutEditMode()
        end
    end)
    frame.editLayoutButton = editLayoutButton
    -- Mostrar/ocultar según config
    if not (MyCheatSheet.config:GetShowLayoutEditButton()) then
        editLayoutButton:Hide()
    else
        editLayoutButton:Show()
    end
    -- Asegura que el texto del botón refleje el estado al mostrar la ventana
    frame:HookScript("OnShow", function(self)
        if self.editLayoutButton then
            self.editLayoutButton:SetText(MyCheatSheet.isLayoutEditMode and L["SAVE_LAYOUT"] or L["EDIT_LAYOUT"])
            if MyCheatSheet.config:GetShowLayoutEditButton() then
                self.editLayoutButton:Show()
            else
                self.editLayoutButton:Hide()
            end
        end
    end)

    frame:SetSize(700, 680);

    tinsert(UISpecialFrames, "MyCheatSheetFrame");

    -- Refuerzo: asegurar que el botón esté siempre visible y habilitado al mostrar la ventana
    frame:HookScript("OnShow", function(self)
        if self.closeButton then
            self.closeButton:Show()
            self.closeButton:Enable()
        end
    end)
end

-- Permite actualizar el fondo del panel principal dinámicamente
function MyCheatSheet:UpdateMainPanelBackdrop()
    local frame = self.MyCheatSheetFrame
    if not frame then return end 
    if self.config:GetOpaqueBackground() then
        frame:SetBackdrop({
            -- Interface\\DialogFrame\UI-DialogBox-Background
            -- Interface\\FrameGeneral\\UI-Background-Marble
            bgFile = "Interface\\FrameGeneral\\UI-Background-Marble",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 },
        })
    else
        frame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 },
        })
    end
end

-- =============================
-- Contenido y dropdowns de la UI
-- =============================

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
    importExportButton:SetSize(140, 25);
    importExportButton:SetWidth(importExportButton:GetFontString():GetStringWidth() + 24);
    importExportButton:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", leftPadding, 20);
    importExportButton:SetScript("OnClick", function() MyCheatSheet:OpenImportExportPanel(); end);
    importExportButton:Show();

    -- Nota sobre Import/Export
    local importExportNote = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    importExportNote:SetText(L["IMPORT_EXPORT_NOTE"])
    importExportNote:SetTextColor(1, 0.95, 0.5, 1)
    importExportNote:SetJustifyH("LEFT")
    importExportNote:SetWidth(500)
    importExportNote:SetHeight(50)
    importExportNote:SetPoint("TOPLEFT", importExportButton, "RIGHT", 10, 25);
--    importExportNote:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -35, 45)

    --[[ Edit Button (deshabilitado para futuras versiones)
    local editButton = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate");
    editButton:SetText(L["EDIT"]);
    editButton:SetSize(80, 25);
    editButton:SetPoint("LEFT", importExportButton, "RIGHT", 10, 0);
    editButton:SetScript("OnClick", function() MyCheatSheet:OpenEditPanel(); end);
    editButton:Hide();
    ]]--
end

-- =============================
-- Dropdowns: actualización y lógica de selección
-- =============================

--- Actualiza todos los dropdowns
function MyCheatSheet:UpdateDropdowns()
    self:UpdateClassDropdown();
end

--- Apply ClassDropdown selection and update related dropdowns
--- @param info UIDropDownMenuInfo
local function SelectClassDropdown(info)
    if MyCheatSheet.selectedClass then
        local classInfo = C_CreatureInfo.GetClassInfo(MyCheatSheet.selectedClass);
        if classInfo then
            UIDropDownMenu_SetText(MyCheatSheet.classDropdown, classInfo.className);
        end
        -- Preseleccionar primer spec
        local classSpecs = MyCheatSheet.data.sheets[MyCheatSheet.selectedClass]
        if classSpecs then
            local firstSpec = nil
            for specID in pairs(classSpecs) do
                firstSpec = specID; break
            end
            MyCheatSheet.selectedSpec = firstSpec
            -- Preseleccionar primer content
            if firstSpec and classSpecs[firstSpec] then
                local firstContent = nil
                for contentKey in pairs(classSpecs[firstSpec]) do
                    firstContent = contentKey; break
                end
                MyCheatSheet.selectedContent = firstContent
            else
                MyCheatSheet.selectedContent = nil
            end
        else
            MyCheatSheet.selectedSpec = nil
            MyCheatSheet.selectedContent = nil
        end
    end
    -- Actualizar dropdowns
    MyCheatSheet:UpdateSpecDropdown();
    MyCheatSheet:UpdateContentDropdown();
end

--- Actualiza el dropdown de clases
function MyCheatSheet:UpdateClassDropdown()
    UIDropDownMenu_Initialize(self.classDropdown, function(frame, level, menuList)
        for classID in pairs(MyCheatSheet.data.sheets) do
            local classInfo = C_CreatureInfo.GetClassInfo(classID);
            if classInfo then
                local info = UIDropDownMenu_CreateInfo()
                local classFile = classInfo.classFile
                local color = RAID_CLASS_COLORS and classFile and RAID_CLASS_COLORS[classFile] or {r=1,g=1,b=1}
                local colorCode = string.format("|cff%02x%02x%02x", color.r*255, color.g*255, color.b*255)
                info.text = colorCode .. classInfo.className .. "|r"
                info.value = classID;
                info.func = function(frame, arg1, arg2)
                    MyCheatSheet.selectedClass = frame.value;
                    MyCheatSheet.selectedSpec = nil;
                    MyCheatSheet.selectedContent = nil;
                    SelectClassDropdown(frame);
                end;
                info.checked = (classID == MyCheatSheet.selectedClass);
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

--- Apply SpecDropdown selection and update related dropdowns
---@param info UIDropDownMenuInfo
local function SelectSpecDropdown(info)
    MyCheatSheet:DebugPrint("SelectSpecDropdown", info.value)
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
                local _, specLocal, _, icon = GetSpecializationInfoByID(specID);
                if specLocal then
                    local info = UIDropDownMenu_CreateInfo()
                    local iconMarkup = icon and ("|T"..icon..":18:18:0:0:64:64:4:60:4:60|t ") or ""
                    info.text = iconMarkup .. specLocal;
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

--- Actualiza el dropdown de contenido
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

--- Maneja la selección de contenido
--- @param info UIDropDownMenuInfo
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

-- =============================
-- Renderizado dinámico de secciones según layout
-- =============================

--- Actualiza toda la interfaz de usuario con los datos actuales
function MyCheatSheet:UpdateUI()
    local selectedClass = self.selectedClass;
    local selectedSpec = self.selectedSpec;
    --- @type string : contentKeysToNames
    local selectedContent = self.selectedContent;

--**self:DebugPrint("UpdateUI", selectedClass, selectedSpec, selectedContent)

    -- Limpiar el contenido anterior
    for _, child in ipairs({ self.contentFrame:GetChildren() }) do
        child:Hide();
    end

    local yOffset = 0;
    local padding = 3;
    local specData = nil;
    local statData = nil;
    local isCustomStats

    if selectedClass and selectedSpec and MyCheatSheet.data.sheets[selectedClass] and MyCheatSheet.data.sheets[selectedClass][selectedSpec] then
        specData = MyCheatSheet.data.sheets[selectedClass][selectedSpec];
        if selectedContent and specData.statsByContent[selectedContent] then
            statData, isCustomStats  = self:GetStatsData(selectedClass, selectedSpec, selectedContent);
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

    -- Renderizado dinámico según layout
    local layout = self.db.profile.layout
    local sections = layout and layout.sections

    local visibleCount = MyCheatSheet:GetVisibleSectionCount()
    self:SetVisibleSectionCount(visibleCount)

    local pintadas = 0
    for idx, section in ipairs(sections) do
        if section.visible or self.isLayoutEditMode then
            pintadas = pintadas + 1
            local isFirst = idx == 1
            local isLast = idx == #sections
            local sectionYOffset = yOffset
            -- Render sección según id
            local sectionFrame = nil
            if section.id == consts.SECTION_IDS.STATS and statData then
                local sectionFrameHeight, sectionFrame = self:CreateStatPriorityRowWithCustomIcon(self.contentFrame, statData.statsPriority, yOffset, L["STAT_PRIORITY"], isCustomStats);
                yOffset = yOffset + sectionFrameHeight;
                if self.isLayoutEditMode and sectionFrame then
                    -- Si la sección está oculta, atenuar ligeramente
                    if not section.visible then
                        sectionFrame:SetAlpha(0.4)
                    else
                        sectionFrame:SetAlpha(1)
                    end
                    self:CreateSectionEditButtons(sectionFrame, 0, section.id, isFirst, isLast, section.visible)
                end
                yOffset = yOffset + padding;
            elseif section.id == consts.SECTION_IDS.WEAPONS then
                local weaponData = {};
                local bestWeapons, isCustomBis = self:GetSectionData("weapons", "bestInSlot")
                if bestWeapons and bestWeapons.itemIDs and #bestWeapons.itemIDs > 0 then
                    tinsert(weaponData, { title = L["BEST_IN_SLOT"], itemIDs = bestWeapons.itemIDs, isCustom = isCustomBis });
                end
                local altWeapons, isCustomAlt = self:GetSectionData("weapons", "alternatives")
                if altWeapons and altWeapons.itemIDs and #altWeapons.itemIDs > 0 then
                    tinsert(weaponData, { title = L["ALTERNATIVES"], itemIDs = altWeapons.itemIDs, isCustom = isCustomAlt });
                end
                if #weaponData > 0 or self.isLayoutEditMode then
                    local sectionFrameHeight, frame = self:CreateItemSection(self.contentFrame, yOffset, L["WEAPONS"], weaponData);
                    yOffset = yOffset + sectionFrameHeight;
                    sectionFrame = frame
                    yOffset = yOffset + padding;
                end
            elseif section.id == consts.SECTION_IDS.TRINKETS then
                local trinketData = {};
                local bestTrinkets, isCustomBisTrinkets = self:GetSectionData("trinkets", "bestInSlot")
                if bestTrinkets and bestTrinkets.itemIDs and #bestTrinkets.itemIDs > 0 then
                    tinsert(trinketData, { title = L["BEST_IN_SLOT"], itemIDs = bestTrinkets.itemIDs, isCustom = isCustomBisTrinkets });
                end
                local altTrinkets, isCustomAltTrinkets = self:GetSectionData("trinkets", "alternatives")
                if altTrinkets and altTrinkets.itemIDs and #altTrinkets.itemIDs > 0 then
                    tinsert(trinketData, { title = L["ALTERNATIVES"], itemIDs = altTrinkets.itemIDs, isCustom = isCustomAltTrinkets });
                end
                if #trinketData > 0 or self.isLayoutEditMode then
                    local sectionFrameHeight, frame = self:CreateItemSection(self.contentFrame, yOffset, L["TRINKETS"], trinketData);
                    yOffset = yOffset + sectionFrameHeight;
                    sectionFrame = frame
                    yOffset = yOffset + padding;
                end
            elseif section.id == consts.SECTION_IDS.CONSUMABLES then
                local consumablesItems, isCustomConsumables = self:GetSectionData("consumables")
                if (consumablesItems and consumablesItems.itemIDs and #consumablesItems.itemIDs > 0) or self.isLayoutEditMode then
                    local consumablesData = {
                        { title = "", itemIDs = consumablesItems and consumablesItems.itemIDs or {}, isCustom = isCustomConsumables },
                    };
                    local sectionFrameHeight, frame = self:CreateItemSection(self.contentFrame, yOffset, L["CONSUMABLES"], consumablesData);
                    yOffset = yOffset + sectionFrameHeight;
                    sectionFrame = frame
                    yOffset = yOffset + padding;
                end
            elseif section.id == consts.SECTION_IDS.TIER then
                local tierData = {};
                local bestInSlotTier, isCustomTierBis = self:GetSectionData("tier", "bestInSlot");
                if bestInSlotTier and bestInSlotTier.itemIDs and #bestInSlotTier.itemIDs > 0 then
                    tinsert(tierData, { title = L["BEST_IN_SLOT"], itemIDs = bestInSlotTier.itemIDs, isCustom = isCustomTierBis });
                end
                if #tierData > 0 or self.isLayoutEditMode then
                    local sectionFrameHeight, frame = self:CreateItemSection(self.contentFrame, yOffset, L["TIER"], tierData);
                    yOffset = yOffset + sectionFrameHeight;
                    sectionFrame = frame
                    yOffset = yOffset + padding;
                end
            end
            -- Botones de edición de layout
            if self.isLayoutEditMode and sectionFrame then
                -- Si la sección está oculta, atenuar ligeramente
                if not section.visible then
                    sectionFrame:SetAlpha(0.4)
                else
                    sectionFrame:SetAlpha(1)
                end
                -- Crear botones de edición para la sección
                self:CreateSectionEditButtons(sectionFrame, 0, section.id, isFirst, isLast, section.visible)
            end
        end
    end

    -- Agregar información del autor y fecha de actualización al final
    if specData and (specData.author or specData.updated or specData.patchVersion) then
        local authorData = self:GetAuthorData(selectedClass, selectedSpec, selectedContent)

        yOffset = yOffset + self:CreateSheetInfoFooter(self.contentFrame, yOffset, authorData);
    end
    local extraPadding = 0;
    self.contentFrame:SetSize(self.scrollFrame:GetWidth() - extraPadding, yOffset);
end

--- Crea el pie de página con información del autor, fecha de actualización y más
---@param parent Frame
---@param yOffset number
---@param authorData AuthorData
---@return number footerHeight La altura del pie de página creado.
function MyCheatSheet:CreateSheetInfoFooter(parent, yOffset, authorData)
    local footerHeight = 36;
    local footerFrame = CreateFrame("Frame", "SheetFooterFrame", parent, "BackdropTemplate");
    footerFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -yOffset);
    footerFrame:SetSize(parent:GetWidth() - 20, footerHeight);
    footerFrame:Show();

    footerFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 },
    })
    footerFrame:SetBackdropColor(0.2, 0.2, 0.2, 0.5);

    -- Define tus colores
    local clrBlue   = "|cff4da6ff"
    local clrYellow = "|cfff0d000"
    local clrGreen  = "|cff00ff00"
    local clrWhite  = "|cffffffff"
    local clrReset  = "|r"

    local infoText = ""
    local patchText = ""
    -- Usar patchVersion como campo principal
    if authorData.patchVersion then
        local version = tostring(authorData.patchVersion)
        local title = consts.PATCH_TITLES[version]
        patchText = L["PATCH"] .. " " .. clrBlue .. version .. clrReset
        if title and title ~= "" then
            patchText = patchText .. ": " .. clrWhite .. title .. clrReset
        end
    end
    if patchText ~= "" then
        infoText = patchText
    end

    if authorData.author then
        if infoText ~= "" then
            infoText = infoText .. "  |  "
        end
        infoText = infoText .. L["AUTHOR"] .. ": " .. clrGreen .. authorData.author .. clrReset
    end

    if authorData.updated then
        local updatedText = L["UPDATED"] .. ": " .. clrYellow .. authorData.updated .. clrReset
        if infoText ~= "" then
            infoText = infoText .. "  |  " .. updatedText
        else
            infoText = updatedText
        end
    end

    if infoText ~= "" then
        local infoString = footerFrame:CreateFontString("FooterFrameInfoString", "OVERLAY", "GameFontNormal")
        infoString:SetText(infoText)
        infoString:SetJustifyH("CENTER")
        infoString:SetTextColor(0.7, 0.7, 0.7, 1)
        local padding = 8
        infoString:SetPoint("TOPLEFT", footerFrame, "TOPLEFT", padding, -padding)
        infoString:SetPoint("BOTTOMRIGHT", footerFrame, "BOTTOMRIGHT", -padding, padding)
    end

    return footerHeight
end

--- Crea una fila de prioridad de estadísticas en la UI, mostrando un icono de estrella si la info es personalizada
---@param parent Frame
---@param statGroups table<number, MyCheatSheetStatGroup>
---@param yOffset number
---@param title string
---@param isCustomStats boolean Si es true, muestra el icono de estrella a la izquierda del título
---@return number rowHeight La altura de la fila creada.
---@return Frame rowFrame El frame creado para la fila.
function MyCheatSheet:CreateStatPriorityRowWithCustomIcon(parent, statGroups, yOffset, title, isCustomStats)
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

    local titleYOffset = -8
    local titleXOffset = 4
    local starIcon;
    if isCustomStats then
        starIcon = rowFrame:CreateTexture(nil, "OVERLAY");
        starIcon:SetTexture("Interface\\COMMON\\ReputationStar-Glow");
        starIcon:SetSize(20, 20);
        starIcon:SetPoint("TOPLEFT", 5, -4);
        starIcon:SetAlpha(1);
        titleXOffset = titleXOffset + 20; 
        -- Tooltip
        starIcon:EnableMouse(true)
        starIcon:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
            GameTooltip:AddLine(L["CUSTOM_INFO"], 1, 0.82, 0, 1);
            GameTooltip:Show();
        end)
        starIcon:SetScript("OnLeave", function(self)
            GameTooltip:Hide();
        end)
    end
    local titleString = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    titleString:SetText(title);
    titleString:SetTextColor(1.0, 1.0, 1.0);
    titleString:SetPoint("TOPLEFT", titleXOffset, titleYOffset);

    -- Mostrar botones de edición si la configuración lo permite
    if self.config:GetShowDataEditButtons() then
        local editStatsButton = CreateFrame("Button", nil, rowFrame, "UIPanelButtonTemplate")
        editStatsButton:SetText(L["EDIT_STATS"])
        editStatsButton:SetSize(50, 20)
        editStatsButton:SetPoint("TOPRIGHT", rowFrame, "TOPRIGHT", -4, -4)
        editStatsButton:SetScript("OnClick", function()
            self:OpenStatsEditor()
        end)
    end

    local function GetStatName(stat, bUseAbrev)
      local sText =L[stat]
      if bUseAbrev then
        sText = L[stat.."_ABBE"]
      end
      return sText
    end

    local xOffset = 24;
    local statYOffset = -25;
    local bUseAbrev = nil
    for i, group in ipairs(statGroups) do
        if bUseAbrev == nil then
          bUseAbrev = group.percent
        end
        for j, stat in ipairs(group.stats) do
            local statText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            local sValue = GetStatName(stat, bUseAbrev)
            statText:SetText(sValue);
            statText:SetPoint("TOPLEFT", xOffset, statYOffset);
            if consts.statColors[stat] then
                statText:SetTextColor(consts.statColors[stat].r, consts.statColors[stat].g, consts.statColors[stat].b, consts.statColors[stat].a);
            end
            xOffset = xOffset + statText:GetWidth() + 5;

            if j < #group.stats then
                local separator = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
                separator:SetText("=");
                separator:SetPoint("TOPLEFT", xOffset, statYOffset);
                xOffset = xOffset + separator:GetWidth() + 5;
            end
        end
        if group.percent then
            local percent = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            local sValue = string.format("(%d %%)", tonumber(group.percent))
            percent:SetText(sValue);
            percent:SetPoint("TOPLEFT", xOffset, statYOffset);
            xOffset = xOffset + percent:GetWidth() + 5;
        end
        if group.operator and i < #statGroups then
            local separator = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
            separator:SetText(group.operator);
            separator:SetPoint("TOPLEFT", xOffset, statYOffset);
            xOffset = xOffset + separator:GetWidth() + 5;
        end
    end

    return rowHeight, rowFrame;
end

--- Crea una fila de prioridad de estadísticas en la UI, mostrando un icono de estrella si la info es personalizada
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

--- Crea una sección completa (un marco) con un título principal y subsecciones de ítems
---@param parent Frame
---@param yOffset number
---@param title string
---@param subsections table<number, table>
---@return number sectionHeight La altura de la sección creada.
---@return Frame sectionFrame Frame de la sección creada
function MyCheatSheet:CreateItemSection(parent, yOffset, title, subsections)
    local itemSize = 40;
    local itemPadding = 5;
    local titleHeight = 0;
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

    local xOffset = 5
    local titleString

    local isCustom
    if subsections and #subsections > 0 then
      isCustom = subsections[1].isCustom
    end
    -- Añadir estrella si es custom
    if isCustom then
        local starIcon = sectionFrame:CreateTexture(nil, "OVERLAY")
        starIcon:SetTexture("Interface\\COMMON\\ReputationStar-Glow")
        starIcon:SetSize(20, 20)
        starIcon:SetPoint("TOPLEFT", sectionFrame, "TOPLEFT", xOffset, -4)
        starIcon:SetAlpha(1)
        -- Tooltip
        starIcon:EnableMouse(true)
        starIcon:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(L["CUSTOM_INFO"], 1, 0.82, 0, 1)
            GameTooltip:Show()
        end)
        starIcon:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
        -- Dejar espacio para el icono
        xOffset = xOffset + 20
    end

    local titleString = nil
    if not MyCheatSheet.config:GetHideSectionTitles() then
        titleString = sectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        titleString:SetText(title);
        titleString:SetTextColor(1.0, 1.0, 1.0);
        titleString:SetPoint("TOPLEFT", sectionFrame, "TOPLEFT", xOffset, -8)
        titleHeight = 20;
    end

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

    -- Mostrar botones de edición si la configuración lo permite
    if self.config:GetShowDataEditButtons() then
        if hasSubsections then
            -- SECCIONES CON SUBSECCIONES (Weapons, Trinkets, Tier)
            local buttonWidth = 50
            local buttonSpacing = 5

            -- Botón BiS (PRIMERO)
            local editBisButton = CreateFrame("Button", nil, sectionFrame, "UIPanelButtonTemplate")
            editBisButton:SetText(L["BIS"])
            editBisButton:SetSize(buttonWidth, 20)
            editBisButton:SetPoint("TOPRIGHT", sectionFrame, "TOPRIGHT", -4, -4)
            editBisButton:SetScript("OnClick", function()
                self:OpenSimpleEditor(title, "bestInSlot")
            end)

            -- Botón Alt (SEGUNDO, solo si existe)
            if hasAlternatives then
                local editAltButton = CreateFrame("Button", nil, sectionFrame, "UIPanelButtonTemplate")
                editAltButton:SetText(L["ALT"])
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
            editButton:SetPoint("TOPRIGHT", sectionFrame, "TOPRIGHT", -4, -4)
            editButton:SetScript("OnClick", function()
                self:OpenSimpleEditor(title, "direct")  -- Modo especial para consumables
            end)
        end
    end

    local currentHeight = titleHeight + verticalPadding;
    local maxSubSectionHeight = 0;
    local horizontalOffset = 20;

    if subsections and #subsections > 0 then
        for i, subSection in ipairs(subsections) do
            local subSectionHeight = 0;
            local currentSubYOffset = -currentHeight;

            if subSection.title and subSection.title ~= "" then
                local subtitleString = sectionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
                local subSection_title = subSection.title
                if subSection.isCustom then
                  subSection_title = "|cffffff00*|r" .. subSection_title
                end
                subtitleString:SetText(subSection_title);
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
            horizontalOffset = horizontalOffset + (#subSection.itemIDs * (itemSize + itemPadding)) + horizontalPadding * 2;

            if subSectionHeight > maxSubSectionHeight then
                maxSubSectionHeight = subSectionHeight;
            end
        end
    end

    currentHeight = currentHeight + maxSubSectionHeight;
    sectionFrame:SetSize(parent:GetWidth() - 20, currentHeight);
    sectionFrame:Show();

    return sectionFrame:GetHeight(), sectionFrame;
end

-- =============================
-- Importación y exportación de datos
-- =============================

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
    frame.title:SetText(L["IMPORT_EXPORT_TITLE"])
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5)

    -- Sección Export
    local exportLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    exportLabel:SetText(L["EXPORT"])
    exportLabel:SetPoint("TOPLEFT", frame, "TOPLEFT", 25, -40)
    exportLabel:SetTextColor(0.8, 1, 0.8)

    -- Botones Export
    local exportSpecButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    exportSpecButton:SetText(L["EXPORT_CURRENT_SPEC"])
    exportSpecButton:SetSize(180, 25)
    exportSpecButton:SetWidth(exportSpecButton:GetFontString():GetStringWidth() + 24)
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
    exportClassButton:SetText(L["EXPORT_CURRENT_CLASS"])
    exportClassButton:SetSize(180, 25)
    exportClassButton:SetWidth(exportClassButton:GetFontString():GetStringWidth() + 24)
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
    exportAllButton:SetText(L["EXPORT_ALL_DATA"])
    exportAllButton:SetSize(180, 25)
    exportSpecButton:SetWidth(exportSpecButton:GetFontString():GetStringWidth() + 24)
    exportAllButton:SetPoint("TOPLEFT", exportClassButton, "BOTTOMLEFT", 0, -5)
    exportAllButton:SetScript("OnClick", function()
        if self.export then
            self.export:HandleExportCommand({"export", "all"})
        end
    end)

    -- Sección Import
    local importLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    importLabel:SetText(L["IMPORT"])
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
    importEditBox:SetText(L["PASTE_EXPORT_STRING"])
    importEditBox:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    importEditBox:SetScript("OnEditFocusGained", function(self)
        if self:GetText() == L["PASTE_EXPORT_STRING"] then
            self:SetText("")
        end
    end)
    importEditBox:SetScript("OnEditFocusLost", function(self)
        if self:GetText() == "" then
            self:SetText(L["PASTE_EXPORT_STRING"])
        end
    end)

    importScrollFrame:SetScrollChild(importEditBox)

    local importButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    importButton:SetText(L["PREVIEW_IMPORT"])
    importButton:SetSize(120, 25)
    importButton:SetWidth(importButton:GetFontString():GetStringWidth() + 24)
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
    mergeButton:SetText(L["QUICK_MERGE"])
    mergeButton:SetSize(100, 25)
    mergeButton:SetWidth(mergeButton:GetFontString():GetStringWidth() + 24)
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
    customLabel:SetText(L["CUSTOM_DATA"])    
    customLabel:SetPoint("TOPLEFT", importButton, "BOTTOMLEFT", 0, -25)
    customLabel:SetTextColor(1, 0.8, 0.8)

    local customListButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    customListButton:SetText(L["LIST_CUSTOM_SHEETS"])
    customListButton:SetSize(180, 25)
    customListButton:SetWidth(customListButton:GetFontString():GetStringWidth() + 24)
    customListButton:SetPoint("TOPLEFT", customLabel, "BOTTOMLEFT", 0, -10)
    customListButton:SetScript("OnClick", function()
        MyCheatSheet:ShowCustomSheetsPanel()
    end)

    local customClearButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    customClearButton:SetText(L["CLEAR_ALL_CUSTOM_DATA"])
    customClearButton:SetSize(180, 25)
    customClearButton:SetWidth(customClearButton:GetFontString():GetStringWidth() + 24)
    customClearButton:SetPoint("TOPLEFT", customListButton, "BOTTOMLEFT", 0, -5)
    customClearButton:SetScript("OnClick", function()
        StaticPopup_Show("MYCHEATSHEET_CONFIRM_RESET_ALL")
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

-- =============================
-- Posicionamiento y guardado de la ventana principal
-- =============================

--- Delega la aplicación de posición al módulo Config
function MyCheatSheet:ApplyFramePosition()
    if self:IsModuleEnabled("Config") then
        self.config:ApplyFramePosition()
    end
end

--- Delega el reseteo de posición al módulo Config
function MyCheatSheet:ResetPosition()
    if self:IsModuleEnabled("Config") then
        self.config:ResetPosition()
    end
end

--- Guarda la posición actual del frame en la base de datos
---@return FramePosition|nil
function MyCheatSheet:SaveFramePosition()
    if self.MyCheatSheetFrame and self.db then
        local point, _, _, x, y = self.MyCheatSheetFrame:GetPoint()
        ---@type FramePosition
        local pos = {
            point = point or "CENTER",
            x = x or 0,
            y = y or 0
        }
        self.db.profile.ui.position = pos
        self:DebugPrint(string.format("Position saved: %s %.0f,%.0f", pos.point, pos.x, pos.y))
        return pos
    end
    return nil
end

-- =============================
-- Helpers para el modo edición de layout
-- =============================

MyCheatSheet.isLayoutEditMode = false
MyCheatSheet.editLayoutButton = nil

function MyCheatSheet:UpdateLayoutEditButton()
    if self.editLayoutButton then
        self.editLayoutButton:SetText(self.isLayoutEditMode and L["SAVE_LAYOUT"] or L["EDIT_LAYOUT"])
    end
end

function MyCheatSheet:ToggleLayoutEditMode()
    self.isLayoutEditMode = not self.isLayoutEditMode
    self:UpdateUI()
    self:UpdateLayoutEditButton()
end

function MyCheatSheet:MoveSection(sectionId, direction)
    local layout = self.db and self.db.profile and self.db.profile.layout
    if not layout or not layout.sections then return end
    local idx
    for i, s in ipairs(layout.sections) do
        if s.id == sectionId then idx = i break end
    end
    if not idx then return end
    local newIdx = direction == "up" and idx - 1 or idx + 1
    if newIdx < 1 or newIdx > #layout.sections then return end
    layout.sections[idx], layout.sections[newIdx] = layout.sections[newIdx], layout.sections[idx]
    self:UpdateUI()
end

--- Alterna la visibilidad de una sección y devuelve el número de secciones visibles
--- Impide que se oculten todas las secciones
--- @param sectionId number
--- @param visibleCount number
--- @return number
function MyCheatSheet:ToggleSectionVisibility(sectionId, visibleCount)
    local layout = self.db and self.db.profile and self.db.profile.layout
    if not layout or not layout.sections then return end
    for _, s in ipairs(layout.sections) do
        if s.id == sectionId then
            if not s.visible then
                visibleCount = visibleCount + 1
            else
                visibleCount = visibleCount - 1
            end
            if visibleCount > 0 then
                s.visible = not s.visible
            end
            break
        end
    end
    self:UpdateUI()
    return visibleCount
end

function MyCheatSheet:ResetLayoutToDefault()
    self:DebugPrint("Layout reset to default")
    self.config:ResetLayoutToDefault()
    MyCheatSheet:ToggleLayoutEditMode()
end

function MyCheatSheet:SaveLayoutChanges()
    self:DebugPrint("Layout changes saved")
    MyCheatSheet:ToggleLayoutEditMode()
end

--- Obtiene el número de secciones visibles en el layout actual
---@return number
function MyCheatSheet:GetVisibleSectionCount()
    local visibleCount = 0
    local layout = self.db.profile.layout
    local sections = layout and layout.sections

    for _, section in ipairs(sections) do
        if section.visible then
            visibleCount = visibleCount + 1
        end
    end
    return visibleCount
end

--- Establece el número de secciones visibles en el layout actual
---@param count number
function MyCheatSheet:SetVisibleSectionCount(count)
    self.visibleSectionCount = count
end

-- Helper para crear botones de edición en cada sección
---@param parent Frame
---@param yOffset number
---@param sectionId number
---@param isFirst boolean
---@param isLast boolean
---@param isVisible boolean
function MyCheatSheet:CreateSectionEditButtons(parent, yOffset, sectionId, isFirst, isLast, isVisible)
    local btnSize, spacing = 18, 2
    local btns = {}
    -- Barra de herramientas: alineados en la esquina inferior derecha
    -- Checkbox de visibilidad
    local visChk = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    visChk:SetSize(btnSize, btnSize)
    visChk:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -2, 4)
    visChk:SetChecked(isVisible)
    visChk.tooltip = "Mostrar/Ocultar sección"
    visChk:SetScript("OnClick", function(self)
        local visibleCount = MyCheatSheet:GetVisibleSectionCount()
        visibleCount = MyCheatSheet:ToggleSectionVisibility(sectionId, visibleCount)
        if visibleCount > 0 then
            MyCheatSheet:SetVisibleSectionCount(visibleCount)
        end
    end)
    table.insert(btns, visChk)

    -- Botón Down a la izquierda del checkbox
    local downBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    downBtn:SetSize(btnSize, btnSize)
    downBtn:SetPoint("RIGHT", visChk, "LEFT", -spacing, 0)
    -- Crear Texture para la flecha Down
    local downIcon = downBtn:CreateTexture(nil, "ARTWORK")
    downIcon:SetTexture("Interface\\AddOns\\MyCheatSheet\\Images\\DownArrow")
    downIcon:SetSize(12, 12)
    downIcon:SetPoint("CENTER", downBtn, "CENTER", 0, 0)
    downBtn.icon = downIcon
    downBtn:SetText("")
    downBtn:SetEnabled(not isLast)
    if isLast then
        downIcon:SetDesaturated(true)
        downIcon:SetAlpha(0.5)
    else
        downIcon:SetDesaturated(false)
        downIcon:SetAlpha(1)
    end
    downBtn:SetScript("OnClick", function() MyCheatSheet:MoveSection(sectionId, "down") end)
    table.insert(btns, downBtn)

    -- Botón Up a la izquierda del Down
    local upBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    upBtn:SetSize(btnSize, btnSize)
    upBtn:SetPoint("RIGHT", downBtn, "LEFT", -spacing, 0)
    -- Crear Texture para la flecha Up
    local upIcon = upBtn:CreateTexture(nil, "ARTWORK")
    upIcon:SetTexture("Interface\\AddOns\\MyCheatSheet\\Images\\UPArrow")
    upIcon:SetSize(12, 12)
    upIcon:SetPoint("CENTER", upBtn, "CENTER", 0, 0)
    upBtn.icon = upIcon
    upBtn:SetText("")
    upBtn:SetEnabled(not isFirst)
    if isFirst then
        upIcon:SetDesaturated(true)
        upIcon:SetAlpha(0.5)
    else
        upIcon:SetDesaturated(false)
        upIcon:SetAlpha(1)
    end
    upBtn:SetScript("OnClick", function() MyCheatSheet:MoveSection(sectionId, "up") end)
    table.insert(btns, upBtn)
    return btns
end

--- Actualiza la barra de estado del panel de custom sheets
function MyCheatSheet:UpdateCustomSheetsStatusBar()
    local panel = self.customSheetsPanel
    if not panel or not panel.statusBar or not panel._checkboxes then return end
    local total, checked = 0, 0
    for _, cb in ipairs(panel._checkboxes) do
        total = total + 1
        if cb:GetChecked() then checked = checked + 1 end
    end
    panel.statusBar:SetText(string.format("%d/%d %s", checked, total, L["SHEETS_SELECTED"]))
end

-- Modal panel para gestionar custom sheets
function MyCheatSheet:ShowCustomSheetsPanel()
    if self.customSheetsPanel and self.customSheetsPanel:IsShown() then return end

    local panel = self.customSheetsPanel or CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
    panel:SetSize(500, 420)
    panel:SetPoint("CENTER")
    panel:SetFrameStrata("DIALOG")
    panel:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 24,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    panel:SetMovable(true)
    panel:EnableMouse(true)
    panel:RegisterForDrag("LeftButton")
    panel:SetScript("OnDragStart", panel.StartMoving)
    panel:SetScript("OnDragStop", panel.StopMovingOrSizing)
    panel:Show()
    self.customSheetsPanel = panel

    -- Título
    if not panel.title then
        panel.title = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        panel.title:SetPoint("TOP", panel, "TOP", 0, -16)
        panel.title:SetText(L["LIST_CUSTOM_SHEETS"])
    end

    -- ScrollFrame para la lista
    if not panel.scrollFrame then
        panel.scrollFrame = CreateFrame("ScrollFrame", nil, panel, "UIPanelScrollFrameTemplate")
        panel.scrollFrame:SetPoint("TOPLEFT", panel, "TOPLEFT", 18, -48)
        panel.scrollFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -32, 60)
        panel.scrollChild = CreateFrame("Frame", nil, panel.scrollFrame)
        panel.scrollChild:SetSize(340, 320)
        panel.scrollFrame:SetScrollChild(panel.scrollChild)
    end

    -- Limpiar lista previa
    for _, child in ipairs({panel.scrollChild:GetChildren()}) do child:Hide() end

    -- Obtener la tabla persistente de custom sheets
    local customData = (MyCheatSheetDB and MyCheatSheetDB.customOverrides) or {}
    local rows = {}
    local idx = 0
    panel._checkboxes = {}
    for classID, classData in pairs(customData) do
    --**local classInfo = C_CreatureInfo.GetClassInfo(classID)
        local className, classColor = self.export:GetClassNameAndColor(classID)

        for specID, specData in pairs(classData) do
            idx = idx + 1
            local specName, specColor = self.export:GetSpecNameAndColor(specID)
            if not specName then
                specName = "SpecID: "..tostring(specID)
            end
            local row = panel.scrollChild["row"..idx] or CreateFrame("Frame", nil, panel.scrollChild)
            row:SetSize(480, 24)
            row:SetPoint("TOPLEFT", panel.scrollChild, "TOPLEFT", 0, -((idx-1)*26))
            -- Checkbox
            local cb = row.checkbox or CreateFrame("CheckButton", nil, row, "UICheckButtonTemplate")
            cb:SetPoint("LEFT", 0, 0)
            cb:SetSize(20, 20)
            cb:SetChecked(false)
            row.checkbox = cb
            -- Etiqueta
            local label = row.label or row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("LEFT", cb, "RIGHT", 8, 0)
            local classColorCode = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255)
        --**local specColorCode = string.format("|cff%02x%02x%02x", specColor.r*255, specColor.g*255, specColor.b*255)
            local authorColor = "|cFF33FF33" -- verde
            local specColorCode = "|cFFFFFFFF"   -- blanco

            local author = specData.author or "?"
            local updated = specData.updated or "-"
            local _, _, _, icon = GetSpecializationInfoByID(specID)
            local iconMarkup = icon and ("|T"..icon..":18:18:0:0:64:64:4:60:4:60|t ") or ""
            label:SetText(
                iconMarkup .. classColorCode..className.."|r - "..specColorCode..specName.."|r"
                .."  |cffa0a0a0"..L["BY"]..":|r "..authorColor..author.."|r"
                .."  |cffa0a0a0"..L["ON"]..":|r "..updated
            )
            row.label = label
            row:Show()
            cb:Show()
            label:Show()
            -- Guardar referencia
            cb._classID = classID
            cb._specID = specID
            -- Actualizar barra de estado al marcar/desmarcar
            cb:SetScript("OnClick", function() MyCheatSheet:UpdateCustomSheetsStatusBar() end)
            table.insert(panel._checkboxes, cb)
        end
    end

    -- Botón Reset
    if not panel.resetBtn then
        panel.resetBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        panel.resetBtn:SetText(L["RESET"])
        panel.resetBtn:SetSize(100, 24)
    end
    panel.resetBtn:SetScript("OnClick", function()
        -- Confirmación antes de eliminar seleccionados
        StaticPopup_Show("MYCHEATSHEET_CONFIRM_RESET_SELECTED")
    end)

    -- Botón Cancel
    if not panel.cancelBtn then
        panel.cancelBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
        panel.cancelBtn:SetText(L["CANCEL"])
        panel.cancelBtn:SetSize(100, 24)
    end
    panel.cancelBtn:SetScript("OnClick", function()
        panel:Hide()
    end)

    -- Posicionar botones juntos en la esquina inferior derecha
    panel.cancelBtn:ClearAllPoints()
    panel.resetBtn:ClearAllPoints()
    panel.cancelBtn:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -24, 18)
    panel.resetBtn:SetPoint("RIGHT", panel.cancelBtn, "LEFT", -8, 0)

    -- Barra de estado: seleccionados/total (justo encima de los botones, centrada)
    if not panel.statusBar then
        panel.statusBar = panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        panel.statusBar:SetPoint("BOTTOM", panel, "BOTTOM", 0, 48)
    end
    MyCheatSheet:UpdateCustomSheetsStatusBar()

    -- Modalidad: bloquear fondo
    panel:EnableKeyboard(true)
    panel:SetPropagateKeyboardInput(false)
    panel:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then self:Hide() end
    end)
    panel:SetFrameLevel(3000)
    panel:Show()
end

-- StaticPopupDialog para borrar TODOS los datos custom
StaticPopupDialogs["MYCHEATSHEET_CONFIRM_RESET_ALL"] = {
    text = L["CONFIRM_RESET_ALL_CUSTOM_DATA"],
    button1 = CONTINUE,
    button2 = CANCEL,
    OnAccept = function()
        -- Eliminar TODOS los datos custom de la tabla persistente
        if MyCheatSheetDB and MyCheatSheetDB.customOverrides then
            MyCheatSheetDB.customOverrides = {}
            print("|cff00ff00[SUCCESS] "..L["ALL_CUSTOM_SHEETS_REMOVED"].."|r")
        end
        -- Cerrar panel si está abierto
        local panel = MyCheatSheet.customSheetsPanel
        if panel then panel:Hide() end
        MyCheatSheet:SendMessage("MCS_CUSTOMSHEETS_REFRESH")
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- StaticPopupDialog para borrar SOLO los seleccionados
StaticPopupDialogs["MYCHEATSHEET_CONFIRM_RESET_SELECTED"] = {
    text = L["CONFIRM_RESET_SELECTED_CUSTOM_DATA"],
    button1 = CONTINUE,
    button2 = CANCEL,
    OnAccept = function()
        -- Eliminar solo los seleccionados de la tabla persistente
        local removed = 0
        local panel = MyCheatSheet.customSheetsPanel
        if panel and panel._checkboxes then
            local db = MyCheatSheetDB and MyCheatSheetDB.customOverrides
            if db then
                for _, cb in ipairs(panel._checkboxes) do
                    if cb:GetChecked() then
                        if db[cb._classID] and db[cb._classID][cb._specID] then
                            db[cb._classID][cb._specID] = nil
                            if next(db[cb._classID]) == nil then
                                db[cb._classID] = nil
                            end
                            removed = removed + 1
                        end
                    end
                end
                if removed > 0 then
                    print("|cff00ff00[SUCCESS] "..string.format(L["N_CUSTOM_SHEETS_REMOVED"], removed).."|r")
                end
            end
            panel:Hide()
            MyCheatSheet:SendMessage("MCS_CUSTOMSHEETS_REFRESH")
        end
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- StaticPopupDialog para confirmación de guardar el layout
StaticPopupDialogs["MYCHEATSHEET_CONFIRM_SAVE_LAYOUT"] = {
    text = L["CONFIRM_SAVE_LAYOUT"],
    button1 = L["SAVE"],
    button2 = L["RESET"],
    button3 = CANCEL,
    OnAccept = function(self)
        MyCheatSheet:SaveLayoutChanges()
    end,
    OnCancel = function()
        MyCheatSheet:ResetLayoutToDefault()
    end,
    OnButton3 = function (self, data)
        -- MyCheatSheet:ToggleLayoutEditMode()
    end,
    OnShow = function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN);
    end,
    OnHide = function()
        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE);
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    preferredIndex = 3,
}

--- Crea la interfaz de usuario para la hoja de trucos del personaje
--- @param parent Frame
function MyCheatSheet:CreateCharacterCheatSheetUI (parent)
    local frame = CreateFrame("Frame", "CharacterCheatSheetFrame", parent)
    frame:SetSize(200, 200)
    frame:SetPoint("CENTER")
    frame:Hide()

    -- Agregar contenido al marco
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", 0, -10)
    title:SetText("Character Cheat Sheet")

    -- Agregar más elementos de interfaz de usuario según sea necesario

    return frame
end

-- ui.lua - fin del archivo