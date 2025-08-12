-- export.lua
local ADDON_NAME, private = ... 

---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);
---@class AceModule
local module = MyCheatSheet:NewModule("Export", "AceEvent-3.0")

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

-- Dependencias externas
local LibDeflate = LibStub:GetLibrary("LibDeflate", true)
local AceSerializer = LibStub:GetLibrary("AceSerializer-3.0")

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
    local mode = args[3] or "merge" -- merge, replace, validate
    
    if not importData then
        print("|cffff0000Usage: /mcs import <data_string> [merge|replace|validate]|r")
        return
    end
    
    local success, result = self:ImportSheets(importData, mode)
    
    if success then
        if mode == "validate" then
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
    self.exportFrame:SetPoint("CENTER", UIParent, "CENTER", -50, -50)
    
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

-- export.lua -- fin del archivo