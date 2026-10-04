local COMMIT = ""

local BASE =
    "nil"
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



local profiler = require("@src/utility/profiler");
local feature = {} 

do

    feature.__index = feature;
    function feature.new(_, id: string, conn: RBXScriptConnection?, func: any?)
        local self = setmetatable({}, feature);

        self.id = id;
        self.conn = conn or Instance.new("BindableEvent").Event;
        self.func = func or function() end;
        self.update = profiler.wrap_no_xpcall(id, self.func);
        self.current_connection = nil; 

        aztup.features[id] = self

        return self    
    end;

end; 

require("@src/globals")
require("@src/init")