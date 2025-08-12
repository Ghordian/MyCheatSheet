-- validdata.lua
local ADDON_NAME, private = ... 

---@class MyCheatSheet
local MyCheatSheet = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME);
---@class AceModule
local module = MyCheatSheet:NewModule("ValidData", "AceEvent-3.0")

---@type AceLocale-3.0
local AceLocale = LibStub("AceLocale-3.0")
---@type table<string, string>
local L = AceLocale:GetLocale(ADDON_NAME)

--- Tabla de compatibilidad clase-item
local CLASS_ITEM_COMPATIBILITY = {
    [1] = { -- Warrior
        armorSubClasses = {0, 1, 2, 3, 4, 6},
        weaponSubClasses = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 15, 16, 18, 19, 20}
    },
    [2] = { -- Paladin
        armorSubClasses = {0, 1, 2, 3, 4, 6},
        weaponSubClasses = {0, 1, 4, 5, 6, 7, 8, 10}
    },
    [3] = { -- Hunter
        armorSubClasses = {0, 1, 2, 3},
        weaponSubClasses = {0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 15, 18}
    },
    [4] = { -- Rogue
        armorSubClasses = {0, 1, 2},
        weaponSubClasses = {2, 3, 4, 7, 13, 15, 16, 18}
    },
    [5] = { -- Priest
        armorSubClasses = {0, 1},
        weaponSubClasses = {4, 10, 15, 19}
    },
    [6] = { -- Death Knight
        armorSubClasses = {0, 1, 2, 3, 4},
        weaponSubClasses = {0, 1, 4, 5, 6, 7, 8}
    },
    [7] = { -- Shaman
        armorSubClasses = {0, 1, 2, 3, 6},
        weaponSubClasses = {0, 1, 4, 5, 6, 10, 13, 15}
    },
    [8] = { -- Mage
        armorSubClasses = {0, 1},
        weaponSubClasses = {4, 7, 10, 15, 19}
    },
    [9] = { -- Warlock
        armorSubClasses = {0, 1},
        weaponSubClasses = {4, 7, 10, 15, 19}
    },
    [10] = { -- Monk
        armorSubClasses = {0, 1, 2},
        weaponSubClasses = {4, 5, 6, 7, 10, 13, 15}
    },
    [11] = { -- Druid
        armorSubClasses = {0, 1, 2},
        weaponSubClasses = {4, 5, 6, 7, 10, 13, 15}
    },
    [12] = { -- Demon Hunter
        armorSubClasses = {0, 1, 2},
        weaponSubClasses = {7, 9, 13, 15}
    },
    [13] = { -- Evoker
        armorSubClasses = {0, 1, 2, 3},
        weaponSubClasses = {0, 1, 4, 5, 7, 8, 10, 13, 15}
    }
}

function module:DebugPrint(...)
    -- 
    MyCheatSheet:DebugPrint(...)
end

function module:OnInitialize()
    self.addon = MyCheatSheet
    self.data = self.addon.data
end

function module:IsAutoValidate()
    local profile = self.addon.db.profile;
    if profile.validation and profile.validation.autoValidate then
        return true
    end
    return false
end

function module:OnEnable()
  --[[
    local config = core:GetModule("Config", true)
    if not config then return end
    ]]--

    -- Auto-validar si está configurado
    if self:IsAutoValidate() then
        C_Timer.After(2, function()
            self:ValidateDataWithCache(false)
        end)
    end
end

--- Valida toda la tabla de datos del addon
---@param showDetails boolean Mostrar detalles de errores en chat
---@return boolean isValid, table errors
function module:ValidateData(showDetails)
    local errors = {
        structure = {},
        classes = {},
        specs = {},
        items = {},
        consumables = {},
        tierSets = {},
        stats = {},
        contentKeys = {}
    }
    
    local isValid = true
    local startTime = GetTime()
    
    print("=== Starting data validation ===")
    
    -- Validar estructura básica
    isValid = self:ValidateBasicStructure(errors.structure) and isValid
    
    -- Validar clases
    isValid = self:ValidateClasses(errors.classes) and isValid
    
    -- Validar especializaciones
    isValid = self:ValidateSpecs(errors.specs) and isValid
    
    -- Validar keys de contenido
    isValid = self:ValidateContentKeys(errors.contentKeys) and isValid
    
    -- Validar items de equipación
    isValid = self:ValidateEquipmentItems(errors.items) and isValid
    
    -- Validar consumibles
    isValid = self:ValidateConsumables(errors.consumables) and isValid
    
    -- Validar tier sets por clase
    isValid = self:ValidateTierSets(errors.tierSets) and isValid
    
    -- Validar estadísticas
    isValid = self:ValidateStats(errors.stats) and isValid
    
    local endTime = GetTime()
    local totalTime = endTime - startTime
    
    if showDetails then
        self:PrintValidationResults(isValid, errors, totalTime)
    end
    
    return isValid, errors
end

--- Valida la estructura básica de los datos
---@param errors table
---@return boolean isValid
function module:ValidateBasicStructure(errors)
    local isValid = true
    
    if not self.data then
        table.insert(errors, "self.data does not exist")
        return false
    end
    
    if not self.data.sheets then
        table.insert(errors, "self.data.sheets does not exist")
        return false
    end
    
    if not self.data.version then
        table.insert(errors, "self.data.version is not defined")
        isValid = false
    elseif type(self.data.version) ~= "number" then
        table.insert(errors, "self.data.version must be a number")
        isValid = false
    end
    
    return isValid
end

--- Valida que todas las clases existen en el juego
---@param errors table
---@return boolean isValid
function module:ValidateClasses(errors)
    local isValid = true
    local validClassCount = 0
    
    for classID in pairs(self.data.sheets) do
        if type(classID) ~= "number" then
            table.insert(errors, string.format("Invalid ClassID (not numeric): %s", tostring(classID)))
            isValid = false
        else
            local classInfo = C_CreatureInfo.GetClassInfo(classID)
            if not classInfo then
                table.insert(errors, string.format("Non-existent class: ID %d", classID))
                isValid = false
            else
                validClassCount = validClassCount + 1
            end
        end
    end
    
    print(string.format("Classes validated: %d found", validClassCount))
    return isValid
end

--- Valida que todas las especializaciones existen
---@param errors table
---@return boolean isValid
function module:ValidateSpecs(errors)
    local isValid = true
    local validSpecCount = 0
    
    for classID, classData in pairs(self.data.sheets) do
        if type(classData) == "table" then
            for specID in pairs(classData) do
                if type(specID) ~= "number" then
                    table.insert(errors, string.format("Invalid SpecID (not numeric): Class %s, Spec %s", 
                        tostring(classID), tostring(specID)))
                    isValid = false
                else
                    local _, specName = GetSpecializationInfoByID(specID)
                    if not specName then
                        table.insert(errors, string.format("Non-existent spec: Class %d, Spec ID %d", classID, specID))
                        isValid = false
                    else
                        validSpecCount = validSpecCount + 1
                    end
                end
            end
        end
    end
    
    print(string.format("Specializations validated: %d found", validSpecCount))
    return isValid
end

--- Valida las claves de contenido
---@param errors table
---@return boolean isValid
function module:ValidateContentKeys(errors)
    local isValid = true
    local validContentKeys = {
        ["RAID"] = true,
        ["RAID-DAMAGE"] = true,
        ["RAID-TANK"] = true,
        ["RAID-HEAL"] = true,
        ["RAID-CLEAVE"] = true,
        ["RAID-DPS"] = true,
        ["MYTHIC_PLUS"] = true,
        ["DELVES"] = true,
        ["OPEN_WORLD"] = true,
        ["DELVES_AND_OPEN_WORLD"] = true,
        ["MYTHIC_PUSH_KEYS"] = true,
    }
    
    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            if specData.statsByContent then
                for contentKey in pairs(specData.statsByContent) do
                    if not validContentKeys[contentKey] then
                        table.insert(errors, string.format("Invalid ContentKey: Class %d, Spec %d, Key '%s'", 
                            classID, specID, contentKey))
                        isValid = false
                    end
                end
            end
        end
    end
    
    return isValid
end

--- Valida items de equipación (weapons, trinkets, tier)
---@param errors table
---@return boolean isValid
function module:ValidateEquipmentItems(errors)
    local isValid = true
    local itemSections = {"weapons", "trinkets", "tier"}
    local totalItemsChecked = 0
    
    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            for _, section in ipairs(itemSections) do
                if specData[section] then
                    local sectionValid, itemCount = self:ValidateItemSection(classID, specID, section, specData[section], errors)
                    isValid = sectionValid and isValid
                    totalItemsChecked = totalItemsChecked + itemCount
                end
            end
        end
    end
    
    print(string.format("Equipment items validated: %d items verified", totalItemsChecked))
    return isValid
end

--- Valida una sección específica de items
---@param classID number
---@param specID number
---@param sectionName string
---@param sectionData table
---@param errors table
---@return boolean isValid, number itemCount
function module:ValidateItemSection(classID, specID, sectionName, sectionData, errors)
    local isValid = true
    local itemCount = 0
    local subsections = {"bestInSlot", "alternatives"}
    
    for _, subsection in ipairs(subsections) do
        if sectionData[subsection] and sectionData[subsection].itemIDs then
            for _, itemID in ipairs(sectionData[subsection].itemIDs) do
                if itemID ~= 0 then -- Ignorar items placeholder (0)
                    local itemValid, itemError = self:ValidateItem(itemID, sectionName, classID)
                    if not itemValid then
                        table.insert(errors, string.format("Class %d, Spec %d, %s.%s: %s", 
                            classID, specID, sectionName, subsection, itemError))
                        isValid = false
                    end
                    itemCount = itemCount + 1
                end
            end
        end
    end
    
    return isValid, itemCount
end



--- Valida que una clase puede equipar un item específico usando IDs
---@param itemID number
---@param classID number
---@param itemType string
---@param itemSubType string
---@param classIDFromItem number
---@param subclassID number
---@return boolean canEquip, string|nil error
function module:ValidateClassCompatibility(itemID, classID, itemType, itemSubType, classIDFromItem, subclassID)
    local compatibility = CLASS_ITEM_COMPATIBILITY[classID]
    if not compatibility then
        return true, nil -- Si no hay restricciones definidas, permitir
    end
    
    local className = (C_CreatureInfo.GetClassInfo(classID) and C_CreatureInfo.GetClassInfo(classID).className) or ("Class" .. classID)
    
    -- Verificar armadura (ItemClass 4)
    if classIDFromItem == 4 then -- Armor
        local canWearArmor = false
        for _, allowedSubClass in ipairs(compatibility.armorSubClasses) do
            if subclassID == allowedSubClass then
                canWearArmor = true
                break
            end
        end
        
        if not canWearArmor then
            return false, string.format("Item %d (Armor SubClass %d: %s) cannot be worn by %s", 
                itemID, subclassID, itemSubType, className)
        end
    end
    
    -- Verificar armas (ItemClass 2)
    if classIDFromItem == 2 then -- Weapon
        local canUseWeapon = false
        for _, allowedSubClass in ipairs(compatibility.weaponSubClasses) do
            if subclassID == allowedSubClass then
                canUseWeapon = true
                break
            end
        end
        
        if not canUseWeapon then
            return false, string.format("Item %d (Weapon SubClass %d: %s) cannot be used by %s", 
                itemID, subclassID, itemSubType, className)
        end
    end
    
    return true, nil
end

--- Valida un item específico (versión actualizada con compatibilidad de clase)
---@param itemID number
---@param expectedType string
---@param classID number
---@return boolean isValid, string|nil error
function module:ValidateItem(itemID, expectedType, classID)
    -- Verificar que el item existe
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, 
          itemStackCount, itemEquipLoc, itemTexture, sellPrice, classIDFromItem, subclassID = GetItemInfo(itemID)

    -- Si no está cacheado, se debe manejar de forma asíncrona
    if not itemName then
        -- Forzar solicitud del item
        local tooltip = CreateFrame("GameTooltip", "ValidationTooltip" .. itemID, nil, "GameTooltipTemplate")
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetItemByID(itemID)
        tooltip:Hide()
        
        -- Marcar como no disponible (para carga asíncrona)
        return false, string.format("Item %d not cached (requires loading)", itemID)
    end
    
    -- Debug info
    self:DebugPrint(string.format("Validating item %d: %s (Class:%d, SubClass:%d, EquipLoc:%s)", 
        itemID, itemName, classIDFromItem or -1, subclassID or -1, itemEquipLoc or "nil"))
    
    -- Verificar compatibilidad de clase PRIMERO (solo para equipables)
    if expectedType == "weapons" or expectedType == "tier" then
        local canEquip, equipError = self:ValidateClassCompatibility(itemID, classID, itemType, itemSubType, classIDFromItem, subclassID)
        if not canEquip then
            return false, equipError
        end
    end
    
    -- Validaciones específicas por tipo
    if expectedType == "weapons" then
        return self:ValidateWeapon(itemID, itemType, itemSubType, itemEquipLoc)
    elseif expectedType == "trinkets" then
        return self:ValidateTrinket(itemID, itemType, itemEquipLoc)
    elseif expectedType == "tier" then
        return self:ValidateTierItem(itemID, itemType, itemEquipLoc, classID)
    end
    
    return true, nil
end

--- Valida un item específico
---@param itemID number
---@param expectedType string
---@param classID number
---@return boolean isValid, string|nil error
function module:Basic_ValidateItem(itemID, expectedType, classID)
    -- Verificar que el item existe
    local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, 
          itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemID)

    -- Si no está cacheado, se debe manejar de forma asíncrona
    if not itemName then
        -- Forzar solicitud del item
        local tooltip = CreateFrame("GameTooltip", "ValidationTooltip" .. itemID, nil, "GameTooltipTemplate")
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetItemByID(itemID)
        tooltip:Hide()
        
        -- Marcar como no disponible (para carga asíncrona)
        return false, string.format("Item %d not cached (requires loading)", itemID)
    end
    
    -- Validaciones específicas por tipo
    if expectedType == "weapons" then
        return self:ValidateWeapon(itemID, itemType, itemSubType, itemEquipLoc)
    elseif expectedType == "trinkets" then
        return self:ValidateTrinket(itemID, itemType, itemEquipLoc)
    elseif expectedType == "tier" then
        return self:ValidateTierItem(itemID, itemType, itemEquipLoc, classID)
    end
    
    return true, nil
end

--- Sistema de validación asíncrona con eventos
function module:ValidateDataWithCache(showDetails)
    -- Registrar evento para items pendientes
    self:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    
    -- Estado de validación
    if not self.validationState then
        self.validationState = {
            pendingItems = {},
            totalItems = 0,
            loadedItems = 0,
            startTime = GetTime(),
            callback = showDetails
        }
    end
    
    print("=== Starting validation with item preload ===")
    
    -- Recopilar todos los items primero
    local allItems = self:CollectAllItems()
    self.validationState.totalItems = #allItems
    
    print(string.format("Found %d unique items to validate", #allItems))
    
    -- Verificar cuáles están en caché
    local cachedItems = 0
    for _, itemID in ipairs(allItems) do
        local itemName = GetItemInfo(itemID)
        if itemName then
            cachedItems = cachedItems + 1
        else
            -- Forzar carga del item
            self.validationState.pendingItems[itemID] = true
            local tooltip = CreateFrame("GameTooltip", "LoadTooltip" .. itemID, nil, "GameTooltipTemplate")
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
            tooltip:SetItemByID(itemID)
            tooltip:Hide()
        end
    end
    
    local pendingCount = self.validationState.totalItems - cachedItems
    print(string.format("[OK] %d items cached, %d pending load", cachedItems, pendingCount))
    
    if pendingCount == 0 then
        -- Todos los items están en caché, validar inmediatamente
        self:FinishValidation()
    else
        print(string.format("[WAIT] Loading %d items...", pendingCount))
        
        -- Timer de seguridad (10 segundos máximo)
        C_Timer.After(10, function()
            if self.validationState then
                print("|cffffd700[WARNING] Timeout reached, validating with available items|r")
                self:FinishValidation()
            end
        end)
    end
end

--- Recopila todos los items del addon
---@return table allItems
function module:CollectAllItems()
    local itemsSet = {}
    local allItems = {}
    
    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            -- Items de equipación
            local sections = {"weapons", "trinkets", "tier"}
            for _, section in ipairs(sections) do
                if specData[section] then
                    local subsections = {"bestInSlot", "alternatives"}
                    for _, subsection in ipairs(subsections) do
                        if specData[section][subsection] and specData[section][subsection].itemIDs then
                            for _, itemID in ipairs(specData[section][subsection].itemIDs) do
                                if itemID ~= 0 and not itemsSet[itemID] then
                                    itemsSet[itemID] = true
                                    table.insert(allItems, itemID)
                                end
                            end
                        end
                    end
                end
            end
            
            -- Consumibles
            if specData.consumables and specData.consumables.itemIDs then
                for _, itemID in ipairs(specData.consumables.itemIDs) do
                    if not itemsSet[itemID] then
                        itemsSet[itemID] = true
                        table.insert(allItems, itemID)
                    end
                end
            end
        end
    end
    
    return allItems
end

--- Maneja el evento GET_ITEM_INFO_RECEIVED
function module:GET_ITEM_INFO_RECEIVED(event, itemID, success)
    if not self.validationState then
        return
    end
    
    -- Verificar si es un item que estamos esperando
    if self.validationState.pendingItems[itemID] then
        self.validationState.pendingItems[itemID] = nil
        self.validationState.loadedItems = self.validationState.loadedItems + 1
        
        local remaining = 0
        for _ in pairs(self.validationState.pendingItems) do
            remaining = remaining + 1
        end
        
        if remaining == 0 then
            -- Todos los items han sido cargados
            print("|cff00ff00[OK] All items loaded|r")
            self:FinishValidation()
        elseif self.validationState.loadedItems % 50 == 0 then
            -- Progreso cada 50 items
            print(string.format("[PROGRESS] Loaded %d/%d items...", 
                self.validationState.loadedItems, 
                self.validationState.totalItems - remaining))
        end
    end
end

--- Finaliza la validación después de cargar items
function module:FinishValidation()
    if not self.validationState then
        return
    end

    -- Desregistrar evento
    self:UnregisterEvent("GET_ITEM_INFO_RECEIVED")

    local callback = self.validationState.callback
    self.validationState = nil

    print("|cff00ff00[START] Running validation with loaded items|r")

    -- Ejecutar validación normal
    self:ValidateData(callback)
end

--- Valida que un item sea realmente un arma
---@param itemID number
---@param itemType string
---@param itemSubType string
---@param itemEquipLoc string
---@return boolean isValid, string|nil error
function module:ValidateWeapon(itemID, itemType, itemSubType, itemEquipLoc)
    local validWeaponSlots = {
        "INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND", 
        "INVTYPE_WEAPONOFFHAND", "INVTYPE_RANGED", "INVTYPE_THROWN",
        "INVTYPE_RANGEDRIGHT", "INVTYPE_HOLDABLE", "INVTYPE_SHIELD"
    }

    -- Verificar slot de equipación
    local isValidSlot = false
    for _, slot in ipairs(validWeaponSlots) do
        if itemEquipLoc == slot then
            isValidSlot = true
            break
        end
    end

    if not isValidSlot then
        return false, string.format("Item %d is not a valid weapon (Slot: %s)", 
            itemID, itemEquipLoc or "nil")
    end
    
    return true, nil
end

--- Valida que un item sea realmente un abalorio
---@param itemID number
---@param itemType string
---@param itemEquipLoc string
---@return boolean isValid, string|nil error
function module:ValidateTrinket(itemID, itemType, itemEquipLoc)
    if itemEquipLoc ~= "INVTYPE_TRINKET" then
        return false, string.format("Item %d is not a trinket (Slot: %s)", itemID, itemEquipLoc or "nil")
    end

    return true, nil
end

--- Valida que un item tier sea de armadura válida
---@param itemID number
---@param itemType string
---@param itemEquipLoc string
---@param classID number
---@return boolean isValid, string|nil error
function module:ValidateTierItem(itemID, itemType, itemEquipLoc, classID)
    local validTierSlots = {
        "INVTYPE_HEAD", "INVTYPE_SHOULDER", "INVTYPE_CHEST", "INVTYPE_ROBE", 
        "INVTYPE_LEGS", "INVTYPE_HAND", "INVTYPE_FEET", "INVTYPE_WRIST", 
        "INVTYPE_WAIST", "INVTYPE_CLOAK"
    }

    local isValidSlot = false
    for _, slot in ipairs(validTierSlots) do
        if itemEquipLoc == slot then
            isValidSlot = true
            break
        end
    end

    if not isValidSlot then
        return false, string.format("Tier item %d is not valid armor (Slot: %s)", 
            itemID, itemEquipLoc or "nil")
    end

    return true, nil
end

--- Valida consumibles
---@param errors table
---@return boolean isValid
function module:ValidateConsumables(errors)
    local isValid = true
    local totalConsumablesChecked = 0

    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            if specData.consumables and specData.consumables.itemIDs then
                for _, itemID in ipairs(specData.consumables.itemIDs) do
                    local itemValid, itemError = self:ValidateConsumable(itemID)
                    if not itemValid then
                        table.insert(errors, string.format("Class %d, Spec %d, consumables: %s", 
                            classID, specID, itemError))
                        isValid = false
                    end
                    totalConsumablesChecked = totalConsumablesChecked + 1
                end
            end
        end
    end

    print(string.format("Consumables validated: %d items verified", totalConsumablesChecked))
    return isValid
end

--- Valida que un item sea consumible
---@param itemID number
---@return boolean isValid, string|nil error
function module:ValidateConsumable(itemID)
    --**         1, 2, 3, 4, 5,        6,           7, 8, 9, 10, 11,      12,         13
    local itemName, _, _, _, _, itemType, itemSubType, _, _,  _,  _, classID, subclassID = GetItemInfo(itemID)

    if not itemName then
        return false, string.format("Consumable %d does not exist", itemID)
    end

    -- Usar classID en lugar de texto para mejor compatibilidad
    -- ClassID 0 = Consumables, ClassID 4 = Armor (para algunos buffs), etc.
    -- https://warcraft.wiki.gg/wiki/ItemType
    local validConsumableClasses = {
        [0] = true,  -- Consumable
        [4] = true,  -- Armor (algunos consumibles como bandages)
        [15] = true, -- Miscellaneous (algunos consumibles como scrolls)
    }

    -- SubclassID para consumibles (ClassID = 0)
    local validConsumableSubclasses = {
        [0] = true,  -- Generic consumables
        [1] = true,  -- Potions
        [2] = true,  -- Elixirs
        [3] = true,  -- Flasks
        [5] = true,  -- Food & Drink
        [7] = true,  -- Bandages
        [8] = true,  -- Other consumables
    }

    -- Verificar si es un consumible válido
    if classID == 0 and validConsumableSubclasses[subclassID] then
        return true, nil
    end

    -- Casos especiales: algunos items que no son classID 0 pero son consumibles
    -- Por ejemplo, algunos scrolls, bandages, etc.
    if classID == 15 and subclassID == 0 then -- Miscellaneous items that might be consumable
        -- Verificar si tiene efecto de uso (Use effect)
        local tooltip = CreateFrame("GameTooltip", "ConsumableValidationTooltip", nil, "GameTooltipTemplate")
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetItemByID(itemID)
        
        -- Si tiene texto de "Use:" es probablemente consumible
        for i = 1, tooltip:NumLines() do
            local line = _G["ConsumableValidationTooltipTextLeft" .. i]
            if line and line:GetText() then
                local text = line:GetText():lower()
                if text:find("use:") or text:find("usar:") then
                    tooltip:Hide()
                    return true, nil
                end
            end
        end
        tooltip:Hide()
    end

    self:DebugPrint("Consumable item validated:", itemID, itemName, 
        "ClassID:", classID, "SubclassID:", subclassID, "Type:", itemType)

    return false, string.format("Item %d is not a valid consumable (ClassID: %s, SubclassID: %s, Type: %s)", 
        itemID, tostring(classID), tostring(subclassID), itemType or "nil")
end

--- Valida tier sets por clase
---@param errors table
---@return boolean isValid
function module:ValidateTierSets(errors)
    local isValid = true
    local tierItemsByClass = {}

    -- Recopilar todos los items tier por clase
    for classID, classData in pairs(self.data.sheets) do
        tierItemsByClass[classID] = {}
        
        for specID, specData in pairs(classData) do
            if specData.tier then
                if specData.tier.bestInSlot and specData.tier.bestInSlot.itemIDs then
                    for _, itemID in ipairs(specData.tier.bestInSlot.itemIDs) do
                        if itemID ~= 0 then
                            tierItemsByClass[classID][itemID] = true
                        end
                    end
                end
            end
        end
    end

    -- Verificar que no hay items tier duplicados entre clases
    local allTierItems = {}
    for classID, items in pairs(tierItemsByClass) do
        for itemID in pairs(items) do
            if allTierItems[itemID] then
                table.insert(errors, string.format("Tier item %d is duplicated between classes %d and %d", 
                    itemID, allTierItems[itemID], classID))
                isValid = false
            else
                allTierItems[itemID] = classID
            end
        end
    end

    return isValid
end

--- Valida estadísticas
---@param errors table
---@return boolean isValid
function module:ValidateStats(errors)
    local isValid = true
    local validStats = {
        "STRENGTH", "AGILITY", "INTELLECT", "STAMINA",
        "CRIT", "HASTE", "MASTERY", "VERSATILITY"
    }

    local validOperators = {
        ">", ">=", "=", "<=", "<", ">>", "~"
    }

    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            if specData.statsByContent then
                for contentKey, contentData in pairs(specData.statsByContent) do
                    if contentData.statsPriority then
                        for groupIndex, group in ipairs(contentData.statsPriority) do
                            -- Validar que tiene stats
                            if not group.stats or #group.stats == 0 then
                                table.insert(errors, string.format("Class %d, Spec %d, %s, group %d: no statistics", 
                                    classID, specID, contentKey, groupIndex))
                                isValid = false
                            else
                                -- Validar cada stat
                                for _, stat in ipairs(group.stats) do
                                    local isValidStat = false
                                    for _, validStat in ipairs(validStats) do
                                        if stat == validStat then
                                            isValidStat = true
                                            break
                                        end
                                    end
                                    
                                    if not isValidStat then
                                        table.insert(errors, string.format("Class %d, Spec %d, %s: invalid stat '%s'", 
                                            classID, specID, contentKey, stat))
                                        isValid = false
                                    end
                                end
                            end

                            -- Validar operador (si existe)
                            if group.operator then
                                local isValidOperator = false
                                for _, validOp in ipairs(validOperators) do
                                    if group.operator == validOp then
                                        isValidOperator = true
                                        break
                                    end
                                end
                                
                                if not isValidOperator then
                                    table.insert(errors, string.format("Class %d, Spec %d, %s: invalid operator '%s'", 
                                        classID, specID, contentKey, group.operator))
                                    isValid = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    return isValid
end

--- Imprime los resultados de la validación y los guarda para revisión
---@param isValid boolean
---@param errors table
---@param totalTime number
function module:PrintValidationResults(isValid, errors, totalTime)
    print(string.format("=== Validation completed in %.2f seconds ===", totalTime))

    -- Guardar resultados detallados en SavedVariables
    if not MyCheatSheetDB then
        MyCheatSheetDB = {}
    end

    MyCheatSheetDB.lastValidation = {
        timestamp = date("%Y-%m-%d %H:%M:%S"),
        isValid = isValid,
        totalTime = totalTime,
        summary = {},
        detailedErrors = errors
    }

    local totalErrors = 0
    for category, categoryErrors in pairs(errors) do
        if #categoryErrors > 0 then
            MyCheatSheetDB.lastValidation.summary[category] = #categoryErrors
            totalErrors = totalErrors + #categoryErrors
        end
    end

    if isValid then
        print("|cff00ff00[OK] All data is valid|r")
    else
        print(string.format("|cffff0000[ERROR] Found %d total errors:|r", totalErrors))
        
        -- Mostrar solo resumen en chat
        for category, categoryErrors in pairs(errors) do
            if #categoryErrors > 0 then
                print(string.format("  |cffffd700%s:|r %d errors", category, #categoryErrors))
            end
        end

        print("|cffadd8e6[INFO] Detailed results saved to SavedVariables|r")
        print("|cffadd8e6[INFO] Use '/mcs exporterrors' to generate text file|r")
    end
end

--- Exporta los errores de validación en formato legible
function module:ExportValidationErrors()
    if not MyCheatSheetDB or not MyCheatSheetDB.lastValidation then
        print("|cffff0000[ERROR] No validation results saved|r")
        print("|cffffd700[INFO] Run '/mcs validate' first|r")
        return
    end

    local validation = MyCheatSheetDB.lastValidation

    print("=== EXPORTING VALIDATION ERRORS ===")
    print(string.format("Date: %s", validation.timestamp))
    print(string.format("Time: %.2f seconds", validation.totalTime))
    print(string.format("Status: %s", validation.isValid and "VALID" or "WITH ERRORS"))
    print("")

    -- Crear texto exportable
    local exportText = {
        "=== MyCheatSheet - Validation Errors ===",
        string.format("Date: %s", validation.timestamp),
        string.format("Validation time: %.2f seconds", validation.totalTime),
        ""
    }

    local totalErrors = 0
    for category, count in pairs(validation.summary) do
        totalErrors = totalErrors + count
    end

    table.insert(exportText, string.format("SUMMARY: %d total errors", totalErrors))
    table.insert(exportText, "")

    -- Detalles por categoría
    for category, categoryErrors in pairs(validation.detailedErrors) do
        if #categoryErrors > 0 then
            table.insert(exportText, string.format("=== %s (%d errors) ===", category:upper(), #categoryErrors))
            
            for i, error in ipairs(categoryErrors) do
                table.insert(exportText, string.format("%d. %s", i, error))
            end

            table.insert(exportText, "")
        end
    end

    -- Guardar en variable temporal para copiar
    MyCheatSheetDB.exportedErrors = table.concat(exportText, "\n")

    print("|cff00ff00[OK] Errors exported to MyCheatSheetDB.exportedErrors|r")
    print("|cffffd700[INFO] You can copy content from SavedVariables.lua|r")
    print("|cffffd700[PATH] Location: WTF/Account/YourAccount/SavedVariables/MyCheatSheet.lua|r")
end

--- Migra trinkets actuales a estructura trinketsByHeroSpec con [0] como fallback
function module:MigrateTrinketsToHeroSpecStructure()
    print("=== MIGRATING TRINKETS TO HEROSPEC STRUCTURE ===")
    
    local migratedCount = 0
    local totalSpecs = 0
    
    for classID, classData in pairs(self.data.sheets) do
        for specID, specData in pairs(classData) do
            totalSpecs = totalSpecs + 1
            
            -- Solo migrar si tiene trinkets y NO tiene trinketsByHeroSpec
            if specData.trinkets and not specData.trinketsByHeroSpec then
                -- Crear nueva estructura
                specData.trinketsByHeroSpec = {
                    [0] = {
                        bestInSlot = specData.trinkets.bestInSlot or { itemIDs = {} },
                        alternatives = specData.trinkets.alternatives or { itemIDs = {} }
                    }
                }
                
                -- Mantener trinkets original como backup (opcional)
                -- specData.trinkets = nil -- Descomentar para eliminar original
                
                migratedCount = migratedCount + 1
                
                local className = (C_CreatureInfo and C_CreatureInfo.GetClassInfo(classID) and C_CreatureInfo.GetClassInfo(classID).className) or ("Class" .. classID)
                local specName = (GetSpecializationInfoByID and select(2, GetSpecializationInfoByID(specID))) or ("Spec" .. specID)
                
                self:DebugPrint(string.format("Migrated %s %s trinkets to [0] fallback", className, specName))
            end
        end
    end
    
    print(string.format("Migration completed: %d/%d specs migrated", migratedCount, totalSpecs))
    print("All trinkets now available under trinketsByHeroSpec[0]")
    
    return migratedCount > 0
end

--- Comando para ejecutar la migración
function module:ExecuteTrinketMigration()
    if self:MigrateTrinketsToHeroSpecStructure() then
        print("|cff00ff00[SUCCESS] Trinkets migrated to hero spec structure|r")
        print("|cffffd700[INFO] Use trinketsByHeroSpec[0] for fallback trinkets|r")
        
        -- Incrementar versión de datos
        if self.data.version then
            self.data.version = self.data.version + 1
            print("|cffffd700[INFO] Data version incremented to " .. self.data.version .. "|r")
        end
    else
        print("|cffff9900[INFO] No trinkets found to migrate|r")
    end
end

-- validdata.lua -- fin del archivo