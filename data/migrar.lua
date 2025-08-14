-- migrar.lua

ADDON_NAME = "MyCheatSheet"
private = {}

dofile("data_v1.lua") -- o require si está en el path de Lua
-- dofile("externa.lua") -- si tienes la tabla externa
local sheets = private.data and private.data.sheets

-- Aquí va tu lógica de migración, por ejemplo:
local v2 = {}


for classID, specs in pairs(sheets) do
    v2[classID] = {}
    for specID, hoja in pairs(specs) do
        -- Migrar statsByContent a statsPriority por tipo de contenido
        local statsByContent = hoja.statsByContent or {}
        local contentV2 = {}
        for contentType, contentData in pairs(statsByContent) do
            contentV2[contentType] = {
                statsPriority = contentData.statsPriority or {},
                weapons = hoja.weapons or {},
                trinkets = hoja.trinkets or {},
            }
        end
        -- Migrar consumibles y tier
        v2[classID][specID] = {
            author = hoja.author,
            updated = hoja.updated,
            consumables = hoja.consumables or {},
            tier = hoja.tier or {},
            contents = contentV2,
        }
    end
end

-- Función para guardar la tabla como archivo Lua
local function is_array(tbl)
    if type(tbl) ~= "table" then return false end
    local i = 0
    for _ in pairs(tbl) do
        i = i + 1
        if tbl[i] == nil then return false end
    end
    return true
end

local bSingleLine = false
local function is_identifier(str)
    return type(str) == "string" and str:match("^[_%a][_%w]*$")
end

local function is_array_of_tables(tbl)
    if not is_array(tbl) then return false end
    for i = 1, #tbl do
        if type(tbl[i]) ~= "table" then return false end
    end
    return true
end

local function table_to_string(tbl, indent, parentIsArray, forceMultiline)
    indent = indent or ""
    local nextIndent = indent .. "  "
    forceMultiline = forceMultiline or false
    if is_array(tbl) then
        local multiline = forceMultiline or is_array_of_tables(tbl)
        local items = {}
        for i = 1, #tbl do
            local v = tbl[i]
            if type(v) == "table" then
                table.insert(items, table_to_string(v, nextIndent, true, multiline))
            elseif type(v) == "string" then
                table.insert(items, string.format("%q", v))
            else
                table.insert(items, tostring(v))
            end
        end
        if multiline then
            return "{\n" .. nextIndent .. table.concat(items, ",\n" .. nextIndent) .. "\n" .. indent .. "}"
        else
            return "{" .. table.concat(items, ", ") .. "}"
        end
    else
        local items = {}
        for k, v in pairs(tbl) do
            local key
            if is_identifier(k) then
                key = k
            elseif type(k) == "string" then
                key = "[" .. string.format("%q", k) .. "]"
            else
                key = "[" .. tostring(k) .. "]"
            end
            local value
            if type(v) == "table" then
                if is_array(v) then
                    -- Force multiline for statsPriority
                    local multiline = (k == "statsPriority") or is_array_of_tables(v)
                    value = table_to_string(v, nextIndent, true, multiline)
                else
                    value = table_to_string(v, nextIndent)
                end
                if is_array(v) then
                    -- arrays already formatted
                else
                    value = "{" .. "\n" .. nextIndent .. value:sub(2, -2):gsub("^%s+",""):gsub("%s+$","") .. "\n" .. indent .. "}"
                end
            elseif type(v) == "string" then
                value = string.format("%q", v)
            else
                value = tostring(v)
            end
            table.insert(items, key .. " = " .. value)
        end
        if parentIsArray then
            return "{" .. table.concat(items, ", ") .. "}"
        else
            return "{" .. "\n" .. nextIndent .. table.concat(items, ",\n" .. nextIndent) .. "\n" .. indent .. "}"
        end
    end
end

local file = io.open("datav2.lua", "w")
file:write("return ", table_to_string(v2), "\n")
file:close()