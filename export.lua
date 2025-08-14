-- export.lua
local ADDON_NAME, private = ... 

---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);
---@class AceModule
local module = MyCheatSheet:NewModule("Export", "AceEvent-3.0")

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
local L = AceLocale:GetLocale(ADDON_NAME)

-- Dependencias externas
local LibDeflate = LibStub:GetLibrary("LibDeflate", true)
local AceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

-- Tablas de conversión para IDs legibles
local CLASS_NAMES = {
    [1] = "Warrior", [2] = "Paladin", [3] = "Hunter", [4] = "Rogue", 
    [5] = "Priest", [6] = "Death Knight", [7] = "Shaman", [8] = "Mage",
    [9] = "Warlock", [10] = "Monk", [11] = "Druid", [12] = "Demon Hunter", [13] = "Evoker"
}

local SPEC_NAMES = {
    -- Warrior
    [71] = "Arms", [72] = "Fury", [73] = "Protection",
    -- Paladin  
    [65] = "Holy", [66] = "Protection", [70] = "Retribution",
    -- Hunter
    [253] = "Beast Mastery", [254] = "Marksmanship", [255] = "Survival",
    -- Rogue
    [259] = "Assassination", [260] = "Outlaw", [261] = "Subtlety",
    -- Priest
    [256] = "Discipline", [257] = "Holy", [258] = "Shadow",
    -- Death Knight
    [250] = "Blood", [251] = "Frost", [252] = "Unholy",
    -- Shaman
    [262] = "Elemental", [263] = "Enhancement", [264] = "Restoration",
    -- Mage
    [62] = "Arcane", [63] = "Fire", [64] = "Frost",
    -- Warlock
    [265] = "Affliction", [266] = "Demonology", [267] = "Destruction",
    -- Monk
    [268] = "Brewmaster", [270] = "Mistweaver", [269] = "Windwalker",
    -- Druid
    [102] = "Balance", [103] = "Feral", [104] = "Guardian", [105] = "Restoration",
    -- Demon Hunter
    [577] = "Havoc", [581] = "Vengeance",
    -- Evoker
    [1467] = "Devastation", [1468] = "Preservation", [1473] = "Augmentation"
}

function module:DebugPrint(...)
    MyCheatSheet:DebugPrint(...)
end

function module:OnInitialize()
    self.addon = MyCheatSheet
    self.data = self.addon.data
    
    -- Inicializar estructura para datos custom/importados
    if not MyCheatSheetDB then
        MyCheatSheetDB = {}
    end
    
    if not MyCheatSheetDB.customSheets then
        MyCheatSheetDB.customSheets = {}
    end
    
    -- Los datos custom van aquí, no en self.data
    self.customData = MyCheatSheetDB.customSheets
end

--- Tipos de exportación disponibles
local EXPORT_FORMATS = {
    SINGLE_SPEC = "single",     -- Una spec específica
    SINGLE_CLASS = "class",     -- Toda una clase
    ALL_DATA = "all",          -- Todo el dataset
    CUSTOM_SELECTION = "custom" -- Selección manual múltiple
}

--- Exporta datos en formato comprimido para intercambio
---@param exportType string Tipo de exportación (EXPORT_FORMATS)
---@param selection table|nil Parámetros específicos del tipo
---@return string exportData Datos en formato comprimido
function module:ExportSheets(exportType, selection)
    local exportData = {
        version = self.data.version or 1,
        exportType = exportType,
        timestamp = date("%Y-%m-%d %H:%M:%S"),
        author = UnitName("player") .. "-" .. GetRealmName(),
        sheets = {}
    }
    
    if exportType == EXPORT_FORMATS.SINGLE_SPEC then
        -- Exportar una spec específica: {classID = 8, specID = 64}
        local classID, specID = selection.classID, selection.specID
        if self.data.sheets[classID] and self.data.sheets[classID][specID] then
            exportData.sheets[classID] = {
                [specID] = self.data.sheets[classID][specID]
            }
        end
        
    elseif exportType == EXPORT_FORMATS.SINGLE_CLASS then
        -- Exportar toda una clase: {classID = 8}
        local classID = selection.classID
        if self.data.sheets[classID] then
            exportData.sheets[classID] = self.data.sheets[classID]
        end
        
    elseif exportType == EXPORT_FORMATS.ALL_DATA then
        -- Exportar todo
        exportData.sheets = self.data.sheets
        
    elseif exportType == EXPORT_FORMATS.CUSTOM_SELECTION then
        -- Exportar selección custom: {specs = {{classID=8, specID=64}, {classID=1, specID=71}}}
        for _, spec in ipairs(selection.specs) do
            local classID, specID = spec.classID, spec.specID
            if self.data.sheets[classID] and self.data.sheets[classID][specID] then
                if not exportData.sheets[classID] then
                    exportData.sheets[classID] = {}
                end
                exportData.sheets[classID][specID] = self.data.sheets[classID][specID]
            end
        end
    end
    
    -- Serializar datos con AceSerializer
    local serializedData = AceSerializer:Serialize(exportData)
    
    -- Comprimir para ahorrar espacio (si LibDeflate está disponible)
    if LibDeflate then
        local compressedData = LibDeflate:CompressDeflate(serializedData)
        local encodedData = LibDeflate:EncodeForPrint(compressedData)
        return encodedData
    else
        -- Fallback: encoding básico
        return self:EncodeBase64(serializedData)
    end
end

--- Importa datos desde string exportado
---@param importData string Datos exportados
---@param importMode string "merge" | "replace" | "validate_only"
---@return boolean success, string|table result
function module:ImportSheets(importData, importMode)
    -- Decodificar datos
    local decodedData
    
    if LibDeflate then
        decodedData = LibDeflate:DecodeForPrint(importData)
        if decodedData then
            decodedData = LibDeflate:DecompressDeflate(decodedData)
        end
    else
        decodedData = self:DecodeBase64(importData)
    end
    
    if not decodedData then
        return false, "Invalid import format or corrupted data"
    end
    
    -- Deserializar con AceSerializer
    local success, importedData = AceSerializer:Deserialize(decodedData)
    if not success or not importedData or not importedData.sheets then
        return false, "Invalid data structure"
    end
    
    -- Validar datos importados
    local isValid, validationErrors = self:ValidateImportedData(importedData.sheets)
    if not isValid then
        if importMode == "validate_only" then
            return false, validationErrors
        else
            return false, "Imported data failed validation: " .. tostring(validationErrors[1])
        end
    end
    
    if importMode == "validate_only" then
        return true, {
            specs = self:CountImportedSpecs(importedData.sheets),
            author = importedData.author,
            timestamp = importedData.timestamp,
            version = importedData.version
        }
    end
    
    -- Aplicar importación
    local importedSpecs = 0
    
    if importMode == "replace" then
        -- Reemplazar completamente
        for classID, classData in pairs(importedData.sheets) do
            if not self.customData[classID] then
                self.customData[classID] = {}
            end
            for specID, specData in pairs(classData) do
                self.customData[classID][specID] = specData
                importedSpecs = importedSpecs + 1
            end
        end
        
    elseif importMode == "merge" then
        -- Fusionar manteniendo existentes
        for classID, classData in pairs(importedData.sheets) do
            if not self.customData[classID] then
                self.customData[classID] = {}
            end
            for specID, specData in pairs(classData) do
                if not self.customData[classID][specID] then
                    self.customData[classID][specID] = specData
                    importedSpecs = importedSpecs + 1
                end
            end
        end
    end
    
    return true, string.format("Successfully imported %d specs", importedSpecs)
end

--- Comandos de chat para exportar
---@param args table
function module:HandleExportCommand(args)
    local command = args[2] and args[2]:lower()
    
    if command == "spec" then
        -- /mcs export spec 8 64 (classID specID)
        local classID, specID = tonumber(args[3]), tonumber(args[4])
        if not classID or not specID then
            print("|cffff0000Usage: /mcs export spec <classID> <specID>|r")
            return
        end
        
        local exportString = self:ExportSheets(EXPORT_FORMATS.SINGLE_SPEC, {classID = classID, specID = specID})
        self:DisplayExportResult(exportString, "Single Spec")
        
    elseif command == "class" then
        -- /mcs export class 8 (classID)
        local classID = tonumber(args[3])
        if not classID then
            print("|cffff0000Usage: /mcs export class <classID>|r")
            return
        end
        
        local exportString = self:ExportSheets(EXPORT_FORMATS.SINGLE_CLASS, {classID = classID})
        self:DisplayExportResult(exportString, "Single Class")
        
    elseif command == "all" then
        -- /mcs export all
        local exportString = self:ExportSheets(EXPORT_FORMATS.ALL_DATA, {})
        self:DisplayExportResult(exportString, "All Data")
        
    else
        print("|cffffd700Export options:|r")
        print("  |cffffd700/mcs export spec <classID> <specID>|r - Export single spec")
        print("  |cffffd700/mcs export class <classID>|r - Export entire class")
        print("  |cffffd700/mcs export all|r - Export everything")
    end
end

--- Comandos de chat para importar
---@param args table
function module:HandleImportCommand(args)
    local importData = args[2]
    local mode = args[3] or "preview" -- preview, merge, replace, validate
    
    if not importData then
        print("|cffff0000Usage: /mcs import <data_string> [preview|merge|replace|validate]|r")
        return
    end
    
    -- Si el modo es preview, mostrar la ventana de vista previa
    if mode == "preview" then
        self:ShowImportPreview(importData)
        return
    end
    
    local success, result = self:ImportSheets(importData, mode)
    
    if success then
        if mode == "validate_only" then
            print(string.format("|cff00ff00[VALID] Import data: %d specs from %s|r", 
                result.specs, result.author or "Unknown"))
            print(string.format("  Version: %s, Date: %s", 
                tostring(result.version), result.timestamp or "Unknown"))
        else
            print("|cff00ff00[SUCCESS] " .. result .. "|r")
        end
    else
        print("|cffff0000[ERROR] " .. result .. "|r")
    end
end

--- Muestra el resultado de exportación
---@param exportString string
---@param exportType string
function module:DisplayExportResult(exportString, exportType)
    print(string.format("|cff00ff00[EXPORTED] %s data ready|r", exportType))
    print(string.format("|cffffd700[SIZE] %d characters|r", #exportString))
    
    -- Guardar en SavedVariables para fácil acceso
    if not MyCheatSheetDB then MyCheatSheetDB = {} end
    MyCheatSheetDB.lastExport = {
        data = exportString,
        type = exportType,
        timestamp = date("%Y-%m-%d %H:%M:%S")
    }
    
    print("|cffffd700[SAVED] Export saved to MyCheatSheetDB.lastExport.data|r")
    
    -- Mostrar la ventana de export con el texto para copiar
    self:ShowExportUI(exportString, exportType)
end

--- Validación básica de datos importados
---@param sheets table
---@return boolean isValid, table|nil errors
function module:ValidateImportedData(sheets)
    local errors = {}
    
    -- Validación básica de estructura
    if type(sheets) ~= "table" then
        table.insert(errors, "Sheets data is not a table")
        return false, errors
    end
    
    for classID, classData in pairs(sheets) do
        if type(classID) ~= "number" then
            table.insert(errors, "Invalid classID: " .. tostring(classID))
        end
        
        if type(classData) ~= "table" then
            table.insert(errors, "Class data is not a table for classID: " .. tostring(classID))
        else
            for specID, specData in pairs(classData) do
                if type(specID) ~= "number" then
                    table.insert(errors, "Invalid specID: " .. tostring(specID) .. " for classID: " .. tostring(classID))
                end
                
                if type(specData) ~= "table" then
                    table.insert(errors, "Spec data is not a table for classID: " .. tostring(classID) .. ", specID: " .. tostring(specID))
                end
            end
        end
    end
    
    return #errors == 0, (#errors > 0 and errors or nil)
end

--- Cuenta specs en datos importados
---@param sheets table
---@return number specCount
function module:CountImportedSpecs(sheets)
    local count = 0
    for classID, classData in pairs(sheets) do
        for specID, specData in pairs(classData) do
            count = count + 1
        end
    end
    return count
end

--- Serialización simple de tabla (fallback si no hay AceSerializer)
---@param t table
---@return string serialized
function module:SerializeTable(t)
    -- Implementación básica - en producción usar AceSerializer
    local function serialize(obj, level)
        level = level or 0
        local indent = string.rep("  ", level)
        
        if type(obj) == "table" then
            local result = "{\n"
            for k, v in pairs(obj) do
                result = result .. indent .. "  [" .. serialize(k) .. "] = " .. serialize(v, level + 1) .. ",\n"
            end
            result = result .. indent .. "}"
            return result
        elseif type(obj) == "string" then
            return string.format("%q", obj)
        else
            return tostring(obj)
        end
    end
    
    return serialize(t)
end

--- Deserialización simple (fallback)
---@param str string
---@return table|nil deserialized
function module:DeserializeTable(str)
    -- Implementación básica - en producción usar AceSerializer
    local func, err = loadstring("return " .. str)
    if func then
        local success, result = pcall(func)
        if success then
            return result
        end
    end
    return nil
end

--- Encoding Base64 básico (fallback)
---@param data string
---@return string encoded
function module:EncodeBase64(data)
    -- Implementación muy básica - en producción usar una librería real
    return data -- Por ahora, sin encoding
end

--- Decoding Base64 básico (fallback)
---@param data string
---@return string decoded
function module:DecodeBase64(data)
    -- Implementación muy básica - en producción usar una librería real
    return data -- Por ahora, sin decoding
end

--- Obtiene datos combinados (data.lua + custom) para una spec específica
---@param classID number
---@param specID number
---@return table|nil specData
function module:GetCombinedSpecData(classID, specID)
    -- Prioridad: 1. Custom, 2. Default data.lua
    if self.customData[classID] and self.customData[classID][specID] then
        return self.customData[classID][specID]
    end
    
    if self.data.sheets[classID] and self.data.sheets[classID][specID] then
        return self.data.sheets[classID][specID]
    end
    
    return nil
end

--- Comandos para gestionar customs
---@param args table
function module:HandleCustomCommand(args)
    local command = args[2] and args[2]:lower()
    
    if command == "list" then
        -- /mcs custom list
        local count = 0
        print("|cffffd700=== CUSTOM SHEETS ===|r")
        
        for classID, classData in pairs(self.customData) do
            local classInfo = C_CreatureInfo.GetClassInfo(classID)
            local className = classInfo and classInfo.className or ("Class " .. classID)
            
            for specID, specData in pairs(classData) do
                local specInfo = GetSpecializationInfoByID(specID)
                local specName = specInfo or ("Spec " .. specID)
                
                print(string.format("  |cff00ff00%s - %s|r (Source: Custom)", className, specName))
                count = count + 1
            end
        end
        
        if count == 0 then
            print("  |cffff8800No custom sheets found|r")
        else
            print(string.format("|cffffd700Total: %d custom sheets|r", count))
        end
        
    elseif command == "clear" then
        -- /mcs custom clear
        self.customData = {}
        MyCheatSheetDB.customSheets = {}
        print("|cff00ff00[SUCCESS] All custom sheets cleared|r")
        
    elseif command == "remove" then
        -- /mcs custom remove 8 64 (classID specID)
        local classID, specID = tonumber(args[3]), tonumber(args[4])
        if not classID or not specID then
            print("|cffff0000Usage: /mcs custom remove <classID> <specID>|r")
            return
        end
        
        if self.customData[classID] and self.customData[classID][specID] then
            self.customData[classID][specID] = nil
            
            -- Limpiar clase vacía
            local hasSpecs = false
            for _ in pairs(self.customData[classID]) do
                hasSpecs = true
                break
            end
            
            if not hasSpecs then
                self.customData[classID] = nil
            end
            
            print(string.format("|cff00ff00[SUCCESS] Removed custom sheet for class %d, spec %d|r", classID, specID))
        else
            print(string.format("|cffff8800[INFO] No custom sheet found for class %d, spec %d|r", classID, specID))
        end
        
    else
        print("|cffffd700Custom sheet commands:|r")
        print("  |cffffd700/mcs custom list|r - List all custom sheets")
        print("  |cffffd700/mcs custom clear|r - Remove all custom sheets")
        print("  |cffffd700/mcs custom remove <classID> <specID>|r - Remove specific custom sheet")
    end
end

--- Muestra UI para copiar texto de exportación
---@param exportString string
---@param exportType string
function module:ShowExportUI(exportString, exportType)
    -- Crear frame de copia si no existe
    if not self.exportFrame then
        self.exportFrame = self:CreateExportFrame()
    end
    
    -- Configurar contenido
    self.exportFrame.title:SetText("Export: " .. exportType)
    self.exportFrame.editBox:SetText(exportString)
    self.exportFrame.sizeLabel:SetText(string.format("Size: %d characters", #exportString))
    
    -- Posicionar ligeramente desplazado del centro
    self.exportFrame:ClearAllPoints()
    self.exportFrame:SetPoint("CENTER", UIParent, "CENTER")
    
    -- Mostrar frame y asegurar que esté por encima
    self.exportFrame:Show()
    self.exportFrame:Raise()
    
    -- Dar foco al EditBox y seleccionar todo el texto
    C_Timer.After(0.1, function()
        self.exportFrame.editBox:SetFocus()
        self.exportFrame.editBox:HighlightText()
    end)
end

--- Crea el frame de exportación
---@return Frame exportFrame
function module:CreateExportFrame()
    local frame = CreateFrame("Frame", "MyCheatSheetExportFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(600, 400)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Asegurar que aparezca por encima del panel de Import/Export
    frame:SetFrameStrata("FULLSCREEN")
    frame:SetFrameLevel(2000)
    
    -- Título
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5)
    
    -- EditBox scrollable
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -30)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -35, 40)
    
    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(scrollFrame:GetWidth())
    editBox:SetAutoFocus(true) -- Cambiar a true para que tome foco automáticamente
    editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
    
    -- Añadir scripts útiles para facilitar la copia
    editBox:SetScript("OnEnterPressed", function(self)
        -- Ctrl+Enter para seleccionar todo
        if IsControlKeyDown() then
            self:HighlightText()
        end
    end)
    
    editBox:SetScript("OnMouseUp", function(self)
        -- Click para seleccionar todo el texto
        self:HighlightText()
    end)
    
    editBox:SetScript("OnReceiveDrag", function(self)
        -- Evitar arrastrar contenido accidentalmente
        return false
    end)
    
    scrollFrame:SetScrollChild(editBox)
    frame.editBox = editBox
    
    -- Label de tamaño
    frame.sizeLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.sizeLabel:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 15, 15)
    
    -- Botón para seleccionar todo
    local selectAllBtn = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    selectAllBtn:SetPoint("BOTTOM", frame, "BOTTOM", -50, 10)
    selectAllBtn:SetSize(100, 22)
    selectAllBtn:SetText("Select All")
    selectAllBtn:SetScript("OnClick", function() 
        editBox:SetFocus()
        editBox:HighlightText()
    end)
    
    -- Botón cerrar
    local closeBtn = CreateFrame("Button", nil, frame, "GameMenuButtonTemplate")
    closeBtn:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -15, 10)
    closeBtn:SetSize(80, 22)
    closeBtn:SetText("Close")
    closeBtn:SetScript("OnClick", function() frame:Hide() end)
    
    frame:Hide()
    return frame
end

--- Muestra ventana de vista previa antes de importar
---@param importData string Datos para importar
function module:ShowImportPreview(importData)
    -- Validar y obtener información del import primero
    local success, previewData = self:ImportSheets(importData, "validate_only")
    
    if not success then
        print("|cffff0000[ERROR] Invalid import data: " .. tostring(previewData) .. "|r")
        return
    end
    
    -- Crear frame de vista previa si no existe
    if not self.previewFrame then
        self.previewFrame = self:CreateImportPreviewFrame()
    end
    
    -- Configurar contenido de la vista previa
    self:PopulatePreviewData(previewData, importData)
    
    -- Mostrar frame
    self.previewFrame:Show()
    self.previewFrame:Raise()
end

--- Crea el frame de vista previa de importación
---@return Frame previewFrame
function module:CreateImportPreviewFrame()
    local frame = CreateFrame("Frame", "MyCheatSheetImportPreviewFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(500, 450)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    
    -- Asegurar que aparezca por encima
    frame:SetFrameStrata("FULLSCREEN")
    frame:SetFrameLevel(2100)
    
    -- Estrategia simple: interceptar ESC directamente para este frame
    local originalOnKeyDown = frame:GetScript("OnKeyDown")
    frame:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            self:Hide()
            return -- Consumir el evento
        end
        if originalOnKeyDown then
            originalOnKeyDown(self, key)
        end
    end)
    
    frame:SetScript("OnShow", function(self)
        -- Habilitar captura de teclado solo para este frame
        self:EnableKeyboard(true)
        self:SetPropagateKeyboardInput(false) -- No propagar teclas a otros frames
    end)
    
    frame:SetScript("OnHide", function(self)
        self:EnableKeyboard(false)
    end)
    
    -- Título
    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.title:SetText(L["IMPORT_PREVIEW_TITLE"] or "Import Preview")
    frame.title:SetPoint("TOP", frame, "TOP", 0, -5) -- Volver a la posición original que funcionaba
    
    -- Área de información principal
    local infoArea = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    infoArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 15, -40)
    infoArea:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -35, -40)
    infoArea:SetHeight(320) -- Aumentamos altura para usar mejor el espacio
    
    local infoContent = CreateFrame("Frame", nil, infoArea)
    infoContent:SetWidth(450)
    infoArea:SetScrollChild(infoContent)
    frame.infoContent = infoContent
    
    -- Labels para mostrar información
    frame.setupName = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.setupName:SetPoint("TOPLEFT", infoContent, "TOPLEFT", 5, -5)
    frame.setupName:SetTextColor(1, 1, 0.8)
    
    frame.authorInfo = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.authorInfo:SetPoint("TOPLEFT", frame.setupName, "BOTTOMLEFT", 0, -5)
    frame.authorInfo:SetTextColor(0.8, 0.8, 0.8)
    
    frame.timestampInfo = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.timestampInfo:SetPoint("TOPLEFT", frame.authorInfo, "BOTTOMLEFT", 0, -2)
    frame.timestampInfo:SetTextColor(0.8, 0.8, 0.8)
    
    -- Separador
    local separator1 = infoContent:CreateTexture(nil, "ARTWORK")
    separator1:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
    separator1:SetPoint("TOPLEFT", frame.timestampInfo, "BOTTOMLEFT", -5, -10)
    separator1:SetPoint("TOPRIGHT", infoContent, "TOPRIGHT", -5, -10)
    separator1:SetHeight(8)
    
    -- Contenido del setup
    frame.contentTitle = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.contentTitle:SetText(L["SETUP_CONTENTS"] or "Setup Contents:")
    frame.contentTitle:SetPoint("TOPLEFT", separator1, "BOTTOMLEFT", 5, -10)
    frame.contentTitle:SetTextColor(0.8, 1, 0.8)
    
    frame.specsInfo = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.specsInfo:SetPoint("TOPLEFT", frame.contentTitle, "BOTTOMLEFT", 10, -5)
    frame.specsInfo:SetTextColor(1, 1, 1)
    
    frame.detailsInfo = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.detailsInfo:SetPoint("TOPLEFT", frame.specsInfo, "BOTTOMLEFT", 0, -10)
    frame.detailsInfo:SetTextColor(0.9, 0.9, 0.9)
    frame.detailsInfo:SetJustifyH("LEFT")
    frame.detailsInfo:SetWidth(420)
    
    -- Separador 2
    local separator2 = infoContent:CreateTexture(nil, "ARTWORK")
    separator2:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
    separator2:SetPoint("TOPLEFT", frame.detailsInfo, "BOTTOMLEFT", -15, -15)
    separator2:SetPoint("TOPRIGHT", infoContent, "TOPRIGHT", -5, -15)
    separator2:SetHeight(8)
    
    -- Advertencias
    frame.warningTitle = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    frame.warningTitle:SetText(L["IMPORT_ACTIONS"] or "Import Actions:")
    frame.warningTitle:SetPoint("TOPLEFT", separator2, "BOTTOMLEFT", 5, -10)
    frame.warningTitle:SetTextColor(1, 0.8, 0.2)
    
    frame.warningText = infoContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.warningText:SetPoint("TOPLEFT", frame.warningTitle, "BOTTOMLEFT", 10, -5)
    frame.warningText:SetTextColor(1, 0.9, 0.7)
    frame.warningText:SetJustifyH("LEFT")
    frame.warningText:SetWidth(420)
    
    -- Área de botones
    local buttonArea = CreateFrame("Frame", nil, frame)
    buttonArea:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 15, 15)
    buttonArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -15, 15)
    buttonArea:SetHeight(70) -- Reducimos altura para optimizar espacio
    
    -- Botón Ver Detalles
    frame.detailsButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    frame.detailsButton:SetText(L["VIEW_DETAILS"] or "View Details")
    frame.detailsButton:SetSize(100, 25)
    frame.detailsButton:SetPoint("BOTTOMLEFT", buttonArea, "BOTTOMLEFT", 0, 35)
    frame.detailsButton:Disable()
    frame.detailsButton:SetScript("OnClick", function() 
        print("|cffff8800[INFO] TODO.|r")
    end)
    
    -- Botones de importación
    frame.mergeButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    frame.mergeButton:SetText(L["IMPORT_MERGE"] or "Import (Merge)")
    frame.mergeButton:SetSize(150, 25) -- Más ancho para texto largo en español
    frame.mergeButton:SetPoint("BOTTOMLEFT", buttonArea, "BOTTOMLEFT", 0, 0)
    frame.mergeButton:SetScript("OnClick", function() 
        self:ImportSheets(frame.importData, "merge")
        frame:Hide()
        print("|cff00ff00[SUCCESS] Setup imported successfully (merged with existing data)|r")
    end)
    
    frame.replaceButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    frame.replaceButton:SetText(L["REPLACE"] or "Replace")
    frame.replaceButton:SetSize(100, 25)
    frame.replaceButton:SetPoint("LEFT", frame.mergeButton, "RIGHT", 10, 0)
    frame.replaceButton:SetScript("OnClick", function() 
        self:ImportSheets(frame.importData, "replace")
        frame:Hide()
        print("|cff00ff00[SUCCESS] Setup imported successfully (replaced existing data)|r")
    end)
    
    -- Botón Cancelar
    frame.cancelButton = CreateFrame("Button", nil, buttonArea, "UIPanelButtonTemplate")
    frame.cancelButton:SetText(L["CANCEL"] or "Cancel")
    frame.cancelButton:SetSize(80, 25)
    frame.cancelButton:SetPoint("BOTTOMRIGHT", buttonArea, "BOTTOMRIGHT", 0, 0)
    frame.cancelButton:SetScript("OnClick", function() frame:Hide() end)
    
    frame:Hide()
    return frame
end

--- Llena los datos de vista previa
---@param previewData table
---@param importData string
function module:PopulatePreviewData(previewData, importData)
    local frame = self.previewFrame
    ---@cast frame +{importData: string}
    frame.importData = importData -- Guardar para usar en los botones
    
    -- Decodificar los datos para obtener más información
    local success, fullData = self:GetImportedDataDetails(importData)
    local setupInfo = success and fullData or {}
    
    -- Información básica
    local setupName = "Custom Setup"
    if setupInfo.exportType then
        if setupInfo.exportType == "single" then
            setupName = "Single Spec Setup"
        elseif setupInfo.exportType == "class" then
            setupName = "Class Setup"  
        elseif setupInfo.exportType == "all" then
            setupName = "Complete Dataset"
        end
    end
    
    -- Intentar obtener más contexto del contenido
    if success and setupInfo.sheets then
        local firstClassID, firstClassData = next(setupInfo.sheets)
        if firstClassID and firstClassData then
            local className = self:GetClassName(tonumber(firstClassID))
            local specCount = 0
            local firstSpecID = nil
            
            for specID, _ in pairs(firstClassData) do
                specCount = specCount + 1
                if not firstSpecID then
                    firstSpecID = specID
                end
            end
            
            if setupInfo.exportType == "single" and firstSpecID then
                local specName = self:GetSpecName(tonumber(firstSpecID))
                setupName = string.format("%s %s Setup", className, specName)
            elseif setupInfo.exportType == "class" then
                setupName = string.format("%s Class Setup", className)
            end
        end
    end
    
    frame.setupName:SetText("Setup: " .. setupName)
    frame.authorInfo:SetText("Author: " .. (previewData.author or "Unknown"))
    frame.timestampInfo:SetText("Created: " .. (previewData.timestamp or "Unknown"))
    
    -- Información de contenido  
    local specsText = string.format(L["SPECIALIZATIONS_WILL_BE_IMPORTED"] or "%d specialization(s) will be imported", previewData.specs or 0)
    frame.specsInfo:SetText(specsText)
    
    -- Detalles adicionales
    local details = {}
    table.insert(details, L["EQUIPMENT_AND_STAT_CONFIGS"] or "Equipment and stat configurations")
    table.insert(details, L["COMPATIBLE_WITH_CURRENT_VERSION"] or "Compatible with current addon version")
    table.insert(details, L["ALL_DATA_PASSED_VALIDATION"] or "All data has passed validation checks")
    
    if setupInfo.version then
        table.insert(details, string.format(L["EXPORT_VERSION"] or "Export version: %s", tostring(setupInfo.version)))
    end
    
    -- Información específica de clases/specs si está disponible
    if success and setupInfo.sheets then
        local classCount = 0
        local specDetails = {}
        for classID, classData in pairs(setupInfo.sheets) do
            classCount = classCount + 1
            local specCount = 0
            local classSpecDetails = {}
            
            for specID, _ in pairs(classData) do
                specCount = specCount + 1
                local specName = self:GetSpecName(tonumber(specID))
                table.insert(classSpecDetails, specName)
            end
            
            local className = self:GetClassName(tonumber(classID))
            if #classSpecDetails > 0 then
                table.insert(specDetails, string.format("  %s: %s", className, table.concat(classSpecDetails, ", ")))
            else
                table.insert(specDetails, string.format("  %s: %d spec(s)", className, specCount))
            end
        end
        
        if #specDetails > 0 then
            table.insert(details, "")
            table.insert(details, L["CONTAINS_DATA_FOR"] or "Contains data for:")
            for _, detail in ipairs(specDetails) do
                table.insert(details, detail)
            end
        end
    end
    
    frame.detailsInfo:SetText(table.concat(details, "\n"))
    
    -- Advertencias dinámicas
    local warnings = {}
    if previewData.specs > 5 then
        table.insert(warnings, string.format(L["LARGE_IMPORT_WARNING"] or "Large import (%d specs) - may take a moment", previewData.specs))
    else
        table.insert(warnings, L["WILL_ADD_NEW_DATA"] or "This will add new data to your custom sheets")
    end
    
    table.insert(warnings, L["EXISTING_DATA_OVERWRITTEN"] or "Existing data with same class/spec may be overwritten (Replace mode)")
    table.insert(warnings, L["MERGE_MODE_PRESERVES"] or "Merge mode will preserve existing data when possible")
    
    frame.warningText:SetText(table.concat(warnings, "\n"))
    
    -- Ajustar altura del contenido dinámicamente
    local baseHeight = 200
    local extraHeight = math.max(0, (#details - 3) * 12) + math.max(0, (#warnings - 3) * 12)
    frame.infoContent:SetHeight(baseHeight + extraHeight)
end

--- Obtiene detalles completos de los datos importados
---@param importData string
---@return boolean success, table|nil data
function module:GetImportedDataDetails(importData)
    -- Decodificar datos
    local decodedData
    
    if LibDeflate then
        decodedData = LibDeflate:DecodeForPrint(importData)
        if decodedData then
            decodedData = LibDeflate:DecompressDeflate(decodedData)
        end
    else
        decodedData = self:DecodeBase64(importData)
    end
    
    if not decodedData then
        return false, nil
    end
    
    -- Deserializar con AceSerializer
    local success, importedData = AceSerializer:Deserialize(decodedData)
    if not success or not importedData then
        return false, nil
    end
    
    return true, importedData
end

--- Obtiene el nombre legible de una clase (localizado)
---@param classID number
---@return string className
function module:GetClassName(classID)
    local classInfo = C_CreatureInfo.GetClassInfo(classID)
    if classInfo and classInfo.className then
        return classInfo.className
    end
    -- Fallback a tabla hardcodeada si la API falla
    return CLASS_NAMES[classID] or ("Class " .. tostring(classID))
end

--- Obtiene el nombre legible de una especialización (localizado)
---@param specID number
---@return string specName  
function module:GetSpecName(specID)
--[[ 
    https://warcraft.wiki.gg/wiki/API_C_SpecializationInfo.GetSpecializationInfo (index) 
    https://warcraft.wiki.gg/wiki/API_GetSpecializationInfoByID
    id, name, description, icon, role, classFile, className = GetSpecializationInfoByID(specID)
]]--
    local _, specName = GetSpecializationInfoByID(specID)
    if specName and type(specName) == "string" and specName ~= "" then
        return specName
    end
    -- Fallback a tabla hardcodeada si la API falla
    if SPEC_NAMES[specID] then
        return SPEC_NAMES[specID]
    end
    -- Último recurso: texto legible con el número
    return "Especialización desconocida (ID: " .. tostring(specID) .. ")"
end

--- Muestra detalles completos del import (placeholder)
---@param importData string
function module:ShowImportDetails(importData)
    -- Decodificar y deserializar los datos importados
    local success, fullData = self:GetImportedDataDetails(importData)
    if not success or not fullData or not fullData.sheets then
        print("|cffff0000[ERROR] No valid data to show|r")
        return
    end

    -- Crear el frame de detalles si no existe
    if not self.detailsFrame then
        self.detailsFrame = self:CreateImportDetailsFrame()
    end

    local frame = self.detailsFrame
    frame:Show()
    frame:Raise()

    -- Recopilar todos los (classID, specID) pares
    local specList = {}
    for classID, classData in pairs(fullData.sheets) do
        for specID, specData in pairs(classData) do
            table.insert(specList, {classID=tonumber(classID), specID=tonumber(specID), data=specData})
        end
    end
    table.sort(specList, function(a, b)
        if a.classID == b.classID then return a.specID < b.specID end
        return a.classID < b.classID
    end)

    frame.specList = specList
    frame.currentIndex = 1
    frame.importData = importData

    -- Función para mostrar el spec actual
    function frame:ShowCurrentSpec()
        local entry = self.specList[self.currentIndex]
        if not entry then return end

        -- Mostrar info de clase/spec
        local className = module:GetClassName(entry.classID)
        local specName = module:GetSpecName(entry.specID)
        self.titleLabel:SetText(string.format("%s - %s", className, specName))

        -- Limpiar el área de preview
        if self.previewContainer and self.previewContainer:IsShown() then
            self.previewContainer:Hide()
            self.previewContainer:SetParent(nil)
        end

        -- Fallback: mostrar datos en texto (hasta que se implemente un marco de contenido independiente)
        if not self.previewContainer or not self.previewContainer:IsShown() then
            if self.previewContainer then
                self.previewContainer:Hide()
                self.previewContainer:SetParent(nil)
            end
            self.previewContainer = CreateFrame("Frame", nil, self, "BackdropTemplate")
            self.previewContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 20, -50)
            self.previewContainer:SetSize(440, 320)
            self.previewContainer:SetBackdrop({
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                edgeSize = 8,
                insets = { left = 2, right = 2, top = 2, bottom = 2 },
            })
            self.previewContainer:SetBackdropColor(0.1, 0.1, 0.1, 0.3)
        end
        self.previewContainer:Show()
        self.previewContainer:SetParent(self)

        -- Solo mostrar datos en texto plano
        if not self.textFallback then
            self.textFallback = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            self.textFallback:SetPoint("TOPLEFT", self.previewContainer, "TOPLEFT", 10, -10)
            self.textFallback:SetWidth(420)
            self.textFallback:SetJustifyH("LEFT")
        end
        self.textFallback:SetText("Vista previa visual deshabilitada temporalmente.\n\n" .. module:SerializeTable(entry.data))
        self.textFallback:Show()
        -- Actualizar estado de los botones
        self.prevButton:SetEnabled(self.currentIndex > 1)
        self.nextButton:SetEnabled(self.currentIndex < #self.specList)
        self.counterLabel:SetText(string.format("%d / %d", self.currentIndex, #self.specList))
    end

    -- Mostrar el primer spec
    frame:ShowCurrentSpec()
end

function module:CreateImportDetailsFrame()
    local frame = CreateFrame("Frame", "MyCheatSheetImportDetailsFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(500, 450)
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:SetFrameStrata("FULLSCREEN")
    frame:SetFrameLevel(2200)

    -- Título
    frame.titleLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.titleLabel:SetPoint("TOP", frame, "TOP", 0, -5)
    frame.titleLabel:SetText("Spec Details")

    -- Botones de navegación
    frame.prevButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.prevButton:SetText("< Prev")
    frame.prevButton:SetSize(80, 22)
    frame.prevButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 15)
    frame.prevButton:SetScript("OnClick", function(self)
        if frame.currentIndex > 1 then
            frame.currentIndex = frame.currentIndex - 1
            frame:ShowCurrentSpec()
        end
    end)

    frame.nextButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.nextButton:SetText("Next >")
    frame.nextButton:SetSize(80, 22)
    frame.nextButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 15)
    frame.nextButton:SetScript("OnClick", function(self)
        if frame.currentIndex < #frame.specList then
            frame.currentIndex = frame.currentIndex + 1
            frame:ShowCurrentSpec()
        end
    end)

    -- Contador
    frame.counterLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    frame.counterLabel:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
    frame.counterLabel:SetText("1 / 1")

    -- Botón cerrar
    frame.closeButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.closeButton:SetText("Close")
    frame.closeButton:SetSize(80, 22)
    frame.closeButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, -5)
    frame.closeButton:SetScript("OnClick", function() frame:Hide() end)

    frame:Hide()
    return frame
end

-- export.lua -- fin del archivo