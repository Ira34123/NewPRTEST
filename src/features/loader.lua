
local HttpService = game:GetService("HttpService")

local REPO =
    "https://api.github.com/repos/Ira34123/NewPRTEST/git/trees/master?recursive=1"

local response = game:HttpGet(REPO)
local data = HttpService:JSONDecode(response)

function list_modules(pattern)
    local result = {}

    -- Turn:
    -- features/auto-parry/data/effects/*
    --
    -- into:
    -- features/auto-parry/data/effects/

    local prefix = pattern:gsub("%*$", "")

    for _, file in ipairs(data.tree or {}) do
        if file.type == "blob" then
            local path = file.path

            -- Only look inside src/
            if path:sub(1, 4) == "src/" then
                path = path:sub(5)
            end

            -- Only Lua files
            if path:sub(-4) == ".lua" then
                -- Check requested directory
                if path:sub(1, #prefix) == prefix then
                    -- Remove .lua
                    path = path:sub(1, -5)

                    table.insert(result, path)
                end
            end
        end
    end

    local newresult = {}
    for i, v in result do
        table.insert(newresult, "@src/" .. v)
    end

    return newresult
end


local BASE =
    "https://raw.githubusercontent.com/Ira34123/NewPRTEST/refs/heads/master"
    .. "/"

local Cache = {}
local oldRequire = require
local base_require = require
function require(name)
    if typeof(name) == "string" then
        if name:sub(1, 5) == "@src/" then
            name = name:sub(6)
            name = "src/" .. name
        end

        if not name:match("%.lua$") then
            name = name .. ".lua"
        end

        local finalName = (name:match("([^/]+)$")):gsub("%.lua$", "")

        if Cache[name] then
            return Cache[name]
        end

        local source = game:HttpGet(BASE .. name)

        local fn, err = loadstring(source)

        if not fn then
            error("Failed to load " .. BASE .. name .. tostring(err))
        end

        local result = fn()

        Cache[name] = result

        local data = {
            name = finalName
        }

        return result, data
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
