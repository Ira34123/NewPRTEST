local COMMIT = ""

local BASE =
    "https://github.com/Ira34123/NewPRTEST"
    .. COMMIT .. "/"

local Cache = {}
local oldRequire = require
function require(name)
    if typeof(name) == "string" then
        if name:sub(1, 5) == "@src/" then
            name = name:sub(6)
            name = "src/" .. name
        end

        if not name:match("%.lua$") then
            name = name .. ".lua"
        end

        if Cache[name] then
            return Cache[name]
        end

        local source = game:HttpGet(BASE .. name)

        local fn = loadstring(source)

        if not fn then
            error("Failed to load " .. name)
        end

        local result = fn()

        Cache[name] = result

        return result
    else
        return oldRequire(name)
    end
end

local AssetCache = {}

function inline_asset_b96(path)
    local filePath = path:gsub("^@", "")

    if AssetCache[filePath] ~= nil then
        return AssetCache[filePath]
    end

    local data = game:HttpGet(BASE .. filePath)

    AssetCache[filePath] = data

    return data
end



require("@src/globals")
require("@src/init")
