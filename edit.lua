-- edit.lua

local ADDON_NAME, private = ...

-- Contains the addon's configuration and item data.
---@type MyCheatSheet 
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

--[[ mecanismo de edición personalizada ]]--

--- Editor simple para una sola subsección
---@param sectionTitle string
---@param subsectionType string "bestInSlot" o "alternatives"
function MyCheatSheet:OpenSimpleEditor(sectionTitle, subsectionType)
    -- Cerrar editor existente
    if self.editFrame then
        self.editFrame:Hide()
        self.editFrame = nil
    end

    local sectionKey = self:GetSectionKey(sectionTitle)
    local subsectionName = ""

    -- Determinar el nombre de la subsección
    if subsectionType == "direct" then
        -- Para consumables (sin subsecciones)
        subsectionName = sectionTitle
    elseif subsectionType == "bestInSlot" then
        subsectionName = L["BEST_IN_SLOT"]
    elseif subsectionType == "alternatives" then
        subsectionName = L["ALTERNATIVES"]
    end

    -- Frame simple
    local editFrame = CreateFrame("Frame", "MyCheatSheetEditFrame", UIParent, "BackdropTemplate")
    editFrame:SetSize(400, 300)
    editFrame:SetPoint("CENTER")
    editFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    editFrame:SetBackdropColor(0.2, 0.2, 0.2, 1)
    editFrame:SetFrameStrata("DIALOG")
    editFrame:SetMovable(true)
    editFrame:EnableMouse(true)
    editFrame:RegisterForDrag("LeftButton")
    editFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    editFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)

    self.editFrame = editFrame

    -- Título
    local title = editFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    if subsectionType == "direct" then
        title:SetText(string.format("Editar %s", sectionTitle))
    else
        title:SetText(string.format("Editar %s: %s", sectionTitle, subsectionName))
    end
    title:SetPoint("TOP", 0, -15)

    -- Instrucciones
    local instructions = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    instructions:SetText(L["ITEM_IDS_SEPARATED_BY_COMMAS"])
    instructions:SetPoint("TOPLEFT", 20, -50)

    -- Obtener datos actuales
    local currentData = nil
    if subsectionType == "direct" then
        -- Para consumables, obtener datos directos
        currentData = self:GetSectionData(sectionKey)
    else
        -- Para subsecciones
        currentData = self:GetSectionData(sectionKey, subsectionType)
    end
    local currentItemIDs = self:ItemIDsToString(currentData)

    -- EditBox
    local editBox = CreateFrame("EditBox", nil, editFrame, "InputBoxTemplate")
    editBox:SetSize(350, 30)
    editBox:SetPoint("TOPLEFT", 20, -80)
    editBox:SetText(currentItemIDs)
    editBox:SetAutoFocus(true)
    editBox:SetMaxLetters(200)

    -- Ejemplo
    local example = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    example:SetText(L["EXAMPLE"] .. currentItemIDs)
    example:SetPoint("TOPLEFT", 20, -120)
    example:SetTextColor(0.7, 0.7, 0.7, 1)

    -- [Save]    [Reset]    [Cancel] mostrados de izquierda a derecha

    local cancelButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    cancelButton:SetText(L["CANCEL"])
    cancelButton:SetSize(80, 25)
    cancelButton:SetPoint("BOTTOMRIGHT", -20, 20)
    cancelButton:SetScript("OnClick", function()
        editFrame:Hide()
        self.editFrame = nil
    end)

    local resetButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    resetButton:SetText(L["RESET"])
    resetButton:SetSize(80, 25)
    resetButton:SetPoint("RIGHT", cancelButton, "LEFT", -5, 0)
    resetButton:SetScript("OnClick", function()
        -- Show confirmation dialog before resetting
        StaticPopupDialogs["MYCHEATSHEET_CONFIRM_RESET_SIMPLE_EDITOR"] = {
            text = L["CONFIRM_RESET_SIMPLE_EDITOR"],
            button1 = CONTINUE,
            button2 = CANCEL,
            OnAccept = function()
                MyCheatSheet:ResetSingleSubsection(sectionTitle, subsectionType)
                editFrame:Hide()
                MyCheatSheet.editFrame = nil
                MyCheatSheet.Result = true
                MyCheatSheet:UpdateUI()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("MYCHEATSHEET_CONFIRM_RESET_SIMPLE_EDITOR")
    end)

    local saveButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    saveButton:SetText(L["SAVE"])
    saveButton:SetSize(80, 25)
    saveButton:SetPoint("RIGHT", resetButton, "LEFT", -5, 0)
    saveButton:SetScript("OnClick", function()
        self:SaveSingleSubsection(sectionTitle, subsectionType, editBox:GetText())
        editFrame:Hide()
        self.editFrame = nil
        self.Result = true
        self:UpdateUI()
    end)

    -- Preview de iconos en tiempo real
    local previewFrame = CreateFrame("ScrollFrame", nil, editFrame, "UIPanelScrollFrameTemplate")
    previewFrame:SetPoint("TOPLEFT", 20, -150)
    previewFrame:SetPoint("BOTTOMRIGHT", -50, 80)

    local previewContent = CreateFrame("Frame", nil, previewFrame)
    previewContent:SetSize(350, 200)
    previewFrame:SetScrollChild(previewContent)

    -- Función para actualizar el preview
    local function UpdatePreview()
        -- Limpiar preview anterior
        for _, child in ipairs({previewContent:GetChildren()}) do
            child:Hide()
        end

        local itemText = editBox:GetText()
        local itemIDs = {}

        -- Parsear IDs del texto
        for itemID in string.gmatch(itemText, "(%d+)") do
            local id = tonumber(itemID)
            if id then table.insert(itemIDs, id) end
        end

        local itemSize = 32
        local itemPadding = 5
        local itemsPerRow = 8

        -- Crear botones de items
        for i, itemID in ipairs(itemIDs) do
            local col = (i-1) % itemsPerRow
            local row = math.floor((i-1) / itemsPerRow)

            local button = CreateFrame("Button", nil, previewContent)
            button:SetSize(itemSize, itemSize)
            button:SetPoint("TOPLEFT", col * (itemSize + itemPadding), -row * (itemSize + itemPadding))

            local icon = button:CreateTexture(nil, "ARTWORK")
            icon:SetAllPoints(button)

            -- Obtener icono del item
            if itemID and itemID > 0 then
                local _, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
                if itemIcon then
                    icon:SetTexture(itemIcon)
                else
                    icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                end
            end

            -- Tooltip del item
            button.itemID = itemID
            button:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetItemByID(self.itemID)
            end)
            button:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
        end

        -- Ajustar altura del contenido
        local totalRows = math.ceil(#itemIDs / itemsPerRow)
        previewContent:SetHeight(math.max(100, totalRows * (itemSize + itemPadding)))
    end

    -- Actualizar preview cuando cambie el texto
    editBox:SetScript("OnTextChanged", UpdatePreview)

    -- Preview inicial
    UpdatePreview()

    editFrame:Show()
end

--- Convierte itemIDs de datos a string para el EditBox
---@param data table|nil
---@return string itemIDsString
function MyCheatSheet:ItemIDsToString(data)
    if data and data.itemIDs then
        local idStrings = {}
        for _, itemID in ipairs(data.itemIDs) do
            table.insert(idStrings, tostring(itemID))
        end
        return table.concat(idStrings, ", ")
    end
    return ""
end

--- Resetea una sola subsección
---@param sectionTitle string
---@param subsectionType string
function MyCheatSheet:ResetSingleSubsection(sectionTitle, subsectionType)
    if not MyCheatSheetDB or not MyCheatSheetDB.customOverrides then return end

    local sectionKey = self:GetSectionKey(sectionTitle)

    if MyCheatSheetDB.customOverrides[self.selectedClass] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec][sectionKey] then

        if sectionKey == "consumables" or subsectionType == "direct" then
            -- Para consumables, borrar directamente itemIDs
            MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec][sectionKey].itemIDs = nil
            print(string.format("%s reset for %s", L["CONSUMABLES"], sectionTitle))
        else
          -- Para subsecciones normales
          MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec][sectionKey][subsectionType] = nil
          local subsectionName = subsectionType == "bestInSlot" and L["BEST_IN_SLOT"] or L["ALTERNATIVES"]
          print(string.format("%s reset for %s", subsectionName, sectionTitle))
        end
    end
end

--- Resetea los items personalizados de una sección
---@param sectionTitle string
function MyCheatSheet:ResetCustomItems(sectionTitle)
    if not MyCheatSheetDB or not MyCheatSheetDB.customOverrides then
        return
    end

    local sectionKey = self:GetSectionKey(sectionTitle)

    if MyCheatSheetDB.customOverrides[self.selectedClass] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] then

        -- Eliminar directamente del spec (sin content)
        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec][sectionKey] = nil

        local className = C_CreatureInfo.GetClassInfo(self.selectedClass).className
        local _, specName = GetSpecializationInfoByID(self.selectedSpec)

        print(string.format("Reset Custom Items for %s %s: %s",
              className, specName, sectionTitle))
    end
end

--- Mapea títulos de sección a claves de datos
---@param sectionTitle string
---@return string
function MyCheatSheet:GetSectionKey(sectionTitle)
    local titleMap = {
        [L["WEAPONS"]] = "weapons",
        [L["TRINKETS"]] = "trinkets", 
        [L["CONSUMABLES"]] = "consumables",
        [L["TIER"]] = "tier"
    }

    return titleMap[sectionTitle] or string.lower(sectionTitle:gsub(" ", ""))
end

--- Determina si una sección tiene subsección de alternatives
---@param subsections table
---@return boolean hasAlternatives
function MyCheatSheet:SectionHasAlternatives(subsections)
    for _, subsection in ipairs(subsections) do
        if subsection.title == L["ALTERNATIVES"] then
            return true
        end
    end
    return false
end

--- Guarda una sola subsección con validación
---@param sectionTitle string
---@param subsectionType string
---@param itemIDsText string
function MyCheatSheet:SaveSingleSubsection(sectionTitle, subsectionType, itemIDsText)
    if not MyCheatSheetDB then
        MyCheatSheetDB = { customOverrides = {} }
    end

    -- Parsear los IDs primero
    local itemIDs = {}
    for itemID in string.gmatch(itemIDsText, "(%d+)") do
        table.insert(itemIDs, tonumber(itemID))
    end

    local subsectionTypeText = subsectionType == "bestInSlot" and L["BEST_IN_SLOT"] or subsectionType == "alternatives" and L["ALTERNATIVES"] or L["COSUMABLES"]

    -- Si no hay items, permitir guardar (para limpiar)
    if #itemIDs == 0 then
        self:SaveSubsectionData(sectionTitle, subsectionType, itemIDs)
        print(string.format("|cffff9900[INFO] %s cleared for %s|r",
            subsectionTypeText, 
            sectionTitle))
        return
    end

    -- Validar todos los items antes de guardar
    local errors = {}
    local validItems = {}
    local sectionKey = self:GetSectionKey(sectionTitle)

    print(string.format("Validating %d items...", #itemIDs))

    for _, itemID in ipairs(itemIDs) do
        local isValid, errorMsg = self.validData:ValidateItem(itemID, sectionKey, self.selectedClass)
        if isValid then
            table.insert(validItems, itemID)
        else
            table.insert(errors, string.format("Item %d: %s", itemID, errorMsg))
        end
    end

    -- Mostrar resultados de la validación
    if #errors > 0 then
        print("|cffff0000[ERROR] Validation errors found:|r")
        for i, error in ipairs(errors) do
            print(string.format("  %d. %s", i, error))
            if i >= 3 then -- Limitar a 3 errores para no hacer spam
                print(string.format("  ... and %d more errors", #errors - 3))
                break
            end
        end

        if #validItems > 0 then
            print(string.format("|cffffd700Save only the %d valid items? (Invalid ones will be ignored)|r", #validItems))
            -- Guardar solo los items válidos
            self:SaveSubsectionData(sectionTitle, subsectionType, validItems)
            print(string.format("|cff00ff00[OK] %s saved for %s (%d valid items, %d ignored)|r", 
                subsectionTypeText, sectionTitle, #validItems, #errors))
        else
            print("|cffff0000[ERROR] Nothing saved - all items are invalid|r")
        end
    else
        -- Todos los items son válidos
        self:SaveSubsectionData(sectionTitle, subsectionType, itemIDs)
        print(string.format("|cff00ff00[OK] %s saved for %s - %d valid items|r", 
            subsectionTypeText, sectionTitle, #itemIDs))
    end
end

--- Función helper para guardar los datos (sin validación)
---@param sectionTitle string
---@param subsectionType string
---@param itemIDs table
function MyCheatSheet:SaveSubsectionData(sectionTitle, subsectionType, itemIDs)
    -- Crear estructura si no existe
    if not MyCheatSheetDB.customOverrides[self.selectedClass] then
        MyCheatSheetDB.customOverrides[self.selectedClass] = {}
    end
    if not MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] then
        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] = {}
    end

    local sectionKey = self:GetSectionKey(sectionTitle)
    local specData = MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec]

    if not specData[sectionKey] then
        specData[sectionKey] = {}
    end

    -- Si es consumables (sin subsección), guardar directamente en itemIDs
    if sectionKey == "consumables" or subsectionType == "direct" then
        specData[sectionKey].itemIDs = itemIDs
    else
        -- Guardar los datos
        specData[sectionKey][subsectionType] = { itemIDs = itemIDs }
    end
end

--- Resetea las estadísticas para el contenido actual
function MyCheatSheet:ResetStatsForContent()
    if not MyCheatSheetDB or not MyCheatSheetDB.customOverrides then 
        print("[INFO] No custom stats to reset")
        return 
    end

    if MyCheatSheetDB.customOverrides[self.selectedClass] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent and
       MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent[self.selectedContent] then

        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent[self.selectedContent].statsPriority = nil

        local classInfo = C_CreatureInfo.GetClassInfo(self.selectedClass)
        if classInfo then
            local _, specName = GetSpecializationInfoByID(self.selectedSpec)
            local contentName = self.contentKeysToNames[self.selectedContent] or self.selectedContent
            print(string.format("[OK] Stats priority reset for %s %s - %s", 
                classInfo.className, specName, contentName))
        end
    else
        print("[INFO] No custom stats found to reset")
    end
end

--- Editor de prioridad de estadísticas (versión compacta)
function MyCheatSheet:OpenStatsEditor()
    -- Cerrar editor existente
    if self.editFrame then
        self.editFrame:Hide()
        self.editFrame = nil
    end

    if not self.selectedClass or not self.selectedSpec or not self.selectedContent then
        print("[ERROR] Select class, spec and content type first")
        return
    end

    -- Frame del editor (más pequeño)
    local editFrame = CreateFrame("Frame", "MyCheatSheetStatsEditFrame", UIParent, "BackdropTemplate")
    editFrame:SetSize(450, 260) -- Aumentado de 220 a 260 para acomodar más contenido
    editFrame:SetPoint("CENTER", UIParent, "CENTER")
    editFrame:SetFrameStrata("DIALOG")
    editFrame:SetMovable(true)
    editFrame:EnableMouse(true)
    editFrame:RegisterForDrag("LeftButton")
    editFrame:SetScript("OnDragStart", editFrame.StartMoving)
    editFrame:SetScript("OnDragStop", editFrame.StopMovingOrSizing)

    editFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    editFrame:SetBackdropColor(0.0, 0.0, 0.0, 1)
    editFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

    self.editFrame = editFrame

    -- Título
    local title = editFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    local classInfo = C_CreatureInfo.GetClassInfo(self.selectedClass)
    local _, specName = GetSpecializationInfoByID(self.selectedSpec)
    local contentName = self.contentKeysToNames[self.selectedContent] or self.selectedContent
    title:SetText(string.format(L["EDIT_STATS_PRIORITY"] .. ": %s %s - %s", 
        classInfo.className or "Unknown", 
        specName or "Unknown", 
        contentName))
    title:SetPoint("TOP", 0, -15)

    -- Botón cerrar
    local closeButton = CreateFrame("Button", nil, editFrame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", -12, -12)
    closeButton:SetScript("OnClick", function()
        editFrame:Hide()
        self.editFrame = nil
    end)

    -- Etiqueta para el campo de entrada
    local label = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetText(L["EDIT_STATS_PRIORITY"])
    label:SetPoint("TOPLEFT", 20, -45)

    -- EditBox simple de una línea (como InputBoxTemplate)
    local editBox = CreateFrame("EditBox", nil, editFrame, "InputBoxTemplate")
    editBox:SetSize(400, 25) -- Una sola línea
    editBox:SetPoint("TOPLEFT", 20, -70)
    editBox:SetAutoFocus(true)
    editBox:SetMaxLetters(150) -- Límite razonable

    -- Obtener y mostrar datos actuales
    local currentStats = self:GetCurrentStatsData()
    local statsText = self:ConvertStatsToText(currentStats)
    editBox:SetText(statsText)

    -- Ejemplo compacto
    local example = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    example:SetText(L["STATS_EDITOR_HELP_L2"])
    example:SetPoint("TOPLEFT", 20, -100)
    example:SetTextColor(0.7, 0.7, 0.7, 1)

    -- Formato y ejemplos expandidos (3 líneas)
    local formatText = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    formatText:SetPoint("TOPLEFT", 20, -120)
    formatText:SetPoint("TOPRIGHT", -20, -120)
    formatText:SetJustifyH("LEFT")
    formatText:SetText(L["STATS_EDITOR_HELP_L1"] .. "\n" .. L["STATS_EDITOR_HELP_L2"] .. "\n" .. L["STATS_EDITOR_HELP_L3"])
    formatText:SetTextColor(0.6, 0.8, 0.6, 1) -- Verde claro para los ejemplos

    -- Ayuda muy compacta
    local helpText = editFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    helpText:SetPoint("TOPLEFT", 20, -160)
    helpText:SetPoint("TOPRIGHT", -20, -160)
    helpText:SetJustifyH("LEFT")
    helpText:SetText(L["STATS_EDITOR_HELP_L5"].."\n"..L["STATS_EDITOR_HELP_L6"])
    helpText:SetTextColor(0.8, 0.8, 0.8, 1)

    local buttonWidth = 80
    local buttonHeight = 25

    -- [Save][Reset][Cancel] de izquierda a derecha

    local cancelButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    cancelButton:SetText(L["CANCEL"])
    cancelButton:SetSize(buttonWidth, buttonHeight)
    cancelButton:SetPoint("BOTTOMRIGHT", -20, 20)
    cancelButton:SetScript("OnClick", function()
        editFrame:Hide()
        self.editFrame = nil
    end)

    local resetButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    resetButton:SetText(L["RESET"])
    resetButton:SetSize(buttonWidth, buttonHeight)
    resetButton:SetPoint("RIGHT", cancelButton, "LEFT", -5, 0)
    resetButton:SetScript("OnClick", function()
        -- Mostrar confirmación antes de resetear
        StaticPopupDialogs["MYCHEATSHEET_CONFIRM_RESET_STATS_EDITOR"] = {
            text = L["CONFIRM_RESET_STATS_EDITOR"] or "¿Seguro que quieres resetear las estadísticas?",
            button1 = CONTINUE,
            button2 = CANCEL,
            OnAccept = function()
                self:ResetStatsForContent()
                editFrame:Hide()
                self.editFrame = nil
                self:UpdateUI()
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
            preferredIndex = 3,
        }
        StaticPopup_Show("MYCHEATSHEET_CONFIRM_RESET_STATS_EDITOR")
    end)

    local saveButton = CreateFrame("Button", nil, editFrame, "UIPanelButtonTemplate")
    saveButton:SetText(L["SAVE"])
    saveButton:SetSize(buttonWidth, buttonHeight)
    saveButton:SetPoint("RIGHT", resetButton, "LEFT", -5, 0)
    saveButton:SetScript("OnClick", function()
        local newStatsText = editBox:GetText()
        local success, error = self:SaveStatsFromText(newStatsText)
        if success then
            print("[OK] Stats priority updated successfully")
            self:UpdateUI()
            editFrame:Hide()
            self.editFrame = nil
        else
            print("[ERROR] " .. (error or "Invalid stats format"))
        end
    end)

    editFrame:Show()
end

--- Obtiene los datos actuales de estadísticas
--- @return table
function MyCheatSheet:GetCurrentStatsData()
    local specData = self.data.sheets[self.selectedClass] and 
                     self.data.sheets[self.selectedClass][self.selectedSpec]

    if specData and specData.statsByContent and specData.statsByContent[self.selectedContent] then
        return specData.statsByContent[self.selectedContent].statsPriority
    end

    return {}
end

--- Convierte estructura de stats a texto editable
--- @param statsPriority table
--- @return string
function MyCheatSheet:ConvertStatsToText(statsPriority)
    if not statsPriority or #statsPriority == 0 then
        return "-- No stats defined --"
    end

    local parts = {}

    for i, group in ipairs(statsPriority) do
        if group.stats and #group.stats > 0 then
            local groupText = table.concat(group.stats, "=")
            table.insert(parts, groupText)

            -- Agregar operador si no es el último grupo
            if i < #statsPriority and group.operator then
                table.insert(parts, group.operator)
            end
        end
    end

    return table.concat(parts, " ")
end

--- Guarda estadísticas desde texto editado
--- @param statsText string
--- @return boolean, string?
function MyCheatSheet:SaveStatsFromText(statsText)
    -- Limpiar texto
    statsText = statsText:trim()
    if statsText == "" or statsText:find("^%-%-") then
        return false, "Empty or commented stats"
    end

    -- Stats válidas
    local validStats = {
        STRENGTH = true, AGILITY = true, INTELLECT = true, STAMINA = true,
        CRIT = true, HASTE = true, MASTERY = true, VERSATILITY = true
    }

    -- Operadores válidos
    local validOperators = {
        [">"] = true, [">>"] = true, [">="] = true, ["~"] = true, ["="] = true
    }

    -- Parsear texto
    local statsPriority = {}
    local tokens = {}

    -- Separar por operadores
    for token in statsText:gmatch("[^%s]+") do
        table.insert(tokens, token)
    end

    local currentGroup = { stats = {} }

    for _, token in ipairs(tokens) do
        if validOperators[token] then
            -- Es un operador
            if #currentGroup.stats > 0 then
                currentGroup.operator = token
                table.insert(statsPriority, currentGroup)
                currentGroup = { stats = {} }
            end
        else
            -- Es un grupo de stats (pueden estar separadas por =)
            local stats = {}
            for stat in token:gmatch("[^=]+") do
                stat = stat:upper():trim()
                if validStats[stat] then
                    table.insert(stats, stat)
                else
                    return false, string.format("Invalid stat: %s", stat)
                end
            end

            -- Agregar stats al grupo actual
            for _, stat in ipairs(stats) do
                table.insert(currentGroup.stats, stat)
            end
        end
    end

    -- Agregar último grupo
    if #currentGroup.stats > 0 then
        table.insert(statsPriority, currentGroup)
    end

    -- Validar que hay al menos un grupo
    if #statsPriority == 0 then
        return false, "No valid stats found"
    end

    -- Guardar en SavedVariables
    if not MyCheatSheetDB.customOverrides then
        MyCheatSheetDB.customOverrides = {}
    end
    if not MyCheatSheetDB.customOverrides[self.selectedClass] then
        MyCheatSheetDB.customOverrides[self.selectedClass] = {}
    end
    if not MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] then
        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec] = {}
    end
    if not MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent then
        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent = {}
    end
    if not MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent[self.selectedContent] then
        MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent[self.selectedContent] = {}
    end

    MyCheatSheetDB.customOverrides[self.selectedClass][self.selectedSpec].statsByContent[self.selectedContent].statsPriority = statsPriority

    return true, nil
end

-- edit.lua -- fin del archivo