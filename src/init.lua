
if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded();
end;

if getgenv().metamorphosis then
    pcall(function() 
        getgenv().metamorphosis(); 
    end)
end;


env = getgenv();
if not LPH_OBFUSCATED then
    require(LPH_ENCSTR("@src/utility/librarys/luraph_sdk"));
end; 

xpcall(function()
    if not isfolder("Project Rain") then
        makefolder("Project Rain");
    end;
    
    if not isfolder("Project Rain/Assets") then
        makefolder("Project Rain/Assets");
    end;

    if not isfolder("Project Rain/Assets/Hit Sounds") then
        makefolder("Project Rain/Assets/Hit Sounds");
    end;

    if not isfolder("Project Rain/Assets/Parry Sounds") then
        makefolder("Project Rain/Assets/Parry Sounds");
    end;

    if not isfolder("Project Rain/Fonts") then
        makefolder("Project Rain/Fonts");
    end;

    if not isfolder("Project Rain/Deepwoken-Config") then
        makefolder("Project Rain/Deepwoken-Config");
    end;

    if not isfolder("Project Rain/Deepwoken-Config/CustomGlobalOrnaments") then
        makefolder("Project Rain/Deepwoken-Config/CustomGlobalOrnaments");
    end;

    if not isfolder("Project Rain/Deepwoken-Config/CustomRaces") then
        makefolder("Project Rain/Deepwoken-Config/CustomRaces");
    end;

    if not isfolder("Project Rain/Deepwoken-Config/Preferences") then
        makefolder("Project Rain/Deepwoken-Config/Preferences");
    end;

    if not isfolder("Project Rain/Deepwoken-Config/CustomEnchantments") then
        makefolder("Project Rain/Deepwoken-Config/CustomEnchantments");
    end;

    if not isfile("Project Rain/script_state") then
        writefile("Project Rain/script_state", game:GetService("HttpService"):JSONEncode({
            ["last_executed"] = tick(),
            ["last_executed_version"] = LPH_ENCSTR("__BUILD__"),
            ["build_id"] = game:GetService("HttpService"):GenerateGUID(false)
        }));
    end;
end, warn);

if env.aztup then
    if env.Markers then   
        for _, marker in env.Markers:get() do
            marker:Destroy(); 
        end;
        table.clear(env.Markers._marked_instances);
        table.clear(env.Markers);
        getgenv().Markers = nil;
    end;

    xpcall(function()
        env.aztup:detach();
    end, warn);
    env.aztup = nil;
end;

env.aztup = {
    detach = function(self)
        if self.maid then
            self.maid:do_cleaning()
        end;
        
        if self.features then
            for _, feature in pairs(self.features) do
                xpcall(function()
                    feature:disable();
                end, function(...) 
                    warn(string.format("[detach %s]", feature.id or "none"), ...);
                end);
            end; 
        end;
 
        if self.ui then
            self.ui:Unload();
        end;
    end,
    features = {},
    flags = {}, 
    farms = {},
    tabs = {},
};

local profiler = require("@src/utility/profiler");
getgenv().Feature = {} 

do

    Feature.__index = Feature;
    function Feature.new(_, id: string, conn: RBXScriptConnection?, func: any?)
        local self = setmetatable({}, Feature);

        self.id = id;
        self.conn = conn or Instance.new("BindableEvent").Event;
        self.func = func or function() end;
        self.update = profiler.wrap_no_xpcall(id, self.func);
        self.current_connection = nil; 

        aztup.features[id] = self

        return self    
    end;

end; 

local hasnt_accepted_tos = not isfile("Project Rain/tos_accepted_82126_0822UTC0.txt");

env.persistent_data = require("@src/utility/persistent_data");
env.Logger = require(LPH_ENCSTR("@src/utility/logger"));   
aztup.automation = require(LPH_ENCSTR("@src/automation/loader"));
env.fflags = require("@src/utility/fflags");

--if fflags:get("auto_load") and script_key then
 --   require("@src/utility/setup_auto_load");
--end


if aztup.automation:should_auto_start() then
    local requests = services.ReplicatedStorage:WaitForChild("Requests");
    local start = requests:WaitForChild("StartMenu"):WaitForChild("Start")
    repeat
        start:FireServer(true)
        task.wait(0.5)
    until game:GetService("Players").LocalPlayer.Character;
    task.wait(1);
end;

if not game:GetService("Players").LocalPlayer.Character then
	repeat
		task.wait(1)
	until game:GetService("Players").LocalPlayer.Character;
	task.wait(2)
end

local success, result = pcall(function()
  return require(LPH_ENCSTR("@src/features/hooking"))
end);

if not success or not result then 
  return game:GetService("Players").LocalPlayer:Kick("[pr] failed to hook, kicking to prevent bans\n" .. result)
end; 

do 
    LPH_NO_VIRTUALIZE(function()
           local function decode_asset(asset)
		    local success, result = pcall(function()
		        local decoded = services.EncodingService:Base64Decode(buffer.fromstring(asset))
		        local decompress = services.EncodingService:DecompressBuffer(
		            decoded,
		            Enum.CompressionAlgorithm.Zstd
		        )
		
		        return buffer.tostring(decompress)
		    end)
		
		    if success then
		        return result
		    end
		
		    return asset
		end
		
		        task.spawn(pcall, function()  
            if not isfile("Project Rain/Assets/proximity.mp3") then
                writefile("Project Rain/Assets/proximity.mp3", decode_asset(inline_asset_b96("@assets/proximity.mp3")));
            end;

            if not isfile("Project Rain/Assets/Parry Sounds/Ultrakill Parry.mp3") then
                writefile("Project Rain/Assets/Parry Sounds/Ultrakill Parry.mp3", decode_asset(inline_asset_b96("@assets/Ultrakill Parry.mp3")));
            end;

            if not isfile("Project Rain/Assets/notification.mp3") then 
                writefile("Project Rain/Assets/notification.mp3", decode_asset(inline_asset_b96("@assets/notification.mp3")));
            end;

            if not isfile("Project Rain/Deepwoken-Config/GuiItself.rbxm") then
                writefile("Project Rain/Deepwoken-Config/GuiItself.rbxm", decode_asset(inline_asset_b96("@assets/DeepwokenMorphs/GuiItself.rbxm")));
            end;
        end)
        
        if not isfile("Project Rain/Fonts/Lexend.ttf") then 
            writefile("Project Rain/Fonts/Lexend.ttf", decode_asset(inline_asset_b96("@assets/lexend.ttf")));
        end; 

        if not isfile("Project Rain/Fonts/Lexend-Bold.ttf") then 
            writefile("Project Rain/Fonts/Lexend-Bold.ttf", decode_asset(inline_asset_b96("@assets/lexend-bold.ttf")));
        end; 

        if not isfile("Project Rain/Fonts/Lexend-Medium.ttf") then 
            writefile("Project Rain/Fonts/Lexend-Medium.ttf", decode_asset(inline_asset_b96("@assets/lexend-medium.ttf")));
        end; 
    end)(); 
end; 

lexend = require("@src/utility/custom_font");


if hasnt_accepted_tos then
    require(LPH_ENCSTR("@src/ui/tos"));
    
    if not isfile("Project Rain\\Deepwoken-Config\\settings\\default_conf.json") and not isfile("Project Rain/inquired_about_default_config.txt") and not isfile("Project Rain\\Deepwoken-Config\\settings\\autoload.txt") then
        writefile("Project Rain/inquired_about_default_config.txt", "true");
        require(LPH_ENCSTR("@src/ui/choice_frame")).set(nil,
            function()
	    	    local config_fetch_success, config_content = pcall(game.HttpGet, game, "https://files.project-rain.net/configs/premade.json");
                if config_fetch_success then
                    writefile("Project Rain\\Deepwoken-Config\\settings\\default_conf.json", config_content);
                    writefile("Project Rain\\Deepwoken-Config\\settings\\autoload.txt", "default_conf");
                end;
            end,
            function()
            end
        );
    end;

    task.wait(1.5);
end; 

--if game.PlaceId == 4111023553 then 
    
    
    
    
    
    
    

    
    
    
    
    

    
    
    
    
    
    
    
 --   task.spawn(xpcall, function() 
--require("@src/main_menu/loader");
--    end, warn)

--return true
--end;

env.signal = require("@src/utility/signal");
loaded_signal = env.signal.new();
env.LOAD_START_TIME = tick();
aztup.silent_mode = isfile(LPH_ENCSTR("Project Rain/silent_mode_toggle"));
aztup.maid = require(("@src/utility/maid")).new(); 

if not aztup.ui then
    aztup.ui = require(("@src/utility/librarys/ui"));
end;

env.server_utility = require("@src/utility/deepwoken/servers");
env.local_player = require(("@src/utility/player-data"));
env.general = require(("@src/utility/deepwoken/general_utilitys"));
env.InstanceWatcher = require(("@src/utility/instancewatcher"));
env.BindableFunction = require(("@src/utility/bindablefunction"));
env.Markers = require(("@src/utility/markers")).new();
env.MarkedInstanceCreator = require(("@src/utility/markedinstancecreator"));
env.StateMachine = require(("@src/utility/statemachine"));
env.Tween = require(("@src/utility/deepwoken/safe_tween"));
env.EffectReplicatorHandler = require(("@src/utility/deepwoken/effect_replicator_handler"));
env.LoopUtil = require(("@src/utility/loop"));
env.scheduler = require("@src/utility/scheduler");
env.TargetFilter = require("@src/features/auto-parry/util/target-filter")
env.ab_builder = require("@src/features/auto-builder/auto_builder");
aztup.automation.initialize();

require(("@src/features/auto-parry/block-input-manager"))
--require(("@src/features/loader")).initialize();
task.spawn(pcall, function() 
    require(LPH_ENCSTR("@src/features/auto-parry/handlers/animator-handler"));
end)
chance_store = require("@src/features/auto-parry/data/chance_store")
getgenv().chance_store = chance_store;
require(LPH_ENCSTR("@src/ui/ui")).initialize();

local features = {
    list_modules("features/auto-builder/*"),
    list_modules("features/auto-fight/*"),
    list_modules("features/auto-parry/*"),
    list_modules("features/buttons/*"),
    list_modules("features/combat/*"),
    list_modules("features/exploits/*"),
    list_modules("features/misc/*"),
    list_modules("features/movement/*"),
    list_modules("features/qol/*"),
    list_modules("features/removals/*"),
    list_modules("features/spoofing/*"),
    list_modules("features/visuals/*"),
}

function get_last_filename(path)
    return path:match("([^/]+)%.lua$")
end

for _, v in ipairs(features) do
    for _, path in ipairs(v) do
		if aztup.features[get_last_filename(path)] then
			continue
		end
		
        task.spawn(function()
            local success, result = xpcall(function()
                return require(path)
            end, debug.traceback)

            if not success then
                warn("[FEATURE FAILED]", path, "ERROR:" .. result)
            else
                print("[FEATURE LOADED]", path, result)
            end
        end)
    end
end

require("@src/features/auto-loot/auto_loot")

function sync_feature_states()
    for id, enabled in pairs(aztup.flags) do

        if enabled then
            if aztup.flags[id] and aztup_toggles[id] then
				task.spawn(function()
                aztup_toggles[id]:SetValue(false)
                 task.wait(0.05)
                  aztup_toggles[id]:SetValue(true)
					end)
            end
        end
    end
end

sync_feature_states()

require("@src/features/visuals/player_esp")();
require("@src/features/visuals/base_esp")();

if not fflags:get("dont_notify_on_first_exec") and aztup.silent_mode then
    if not persistent_data:get("has_executed_before") then
        messagebox("You have 'Silent Mode' enabled, Which means you wont see the UI until you open it with the keybind & have extra anti PC check features, If you would like to disable this, Go to UI settings and disable it, This notification is disablable in the fast flags area of UI", "Project Rain", 0)
    end;
    
    persistent_data:set("has_executed_before", true); 
end

shared.unloaded = false;
Library:OnUnload(function()
    if shared.unloaded then return end
    shared.unloaded = true;

    if env.aztup then
        if env.Markers then   
            for _, marker in env.Markers:get() do
                marker:Destroy();
            end;
            table.clear(env.Markers._marked_instances);
            table.clear(env.Markers);
            getgenv().Markers = nil;
        end;
    
        env.aztup:detach();
        env.aztup = nil;
    end;
    
    Library.Unloaded = true
end)
 
if not aztup.silent_mode then
    Logger.log("Not in silent mode.");
end;

loaded_signal:fire(); 

aztup.automation:start(); 
