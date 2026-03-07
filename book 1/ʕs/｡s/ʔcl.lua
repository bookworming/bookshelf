--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Config Loading section)

---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local https = FindFirstChildOfClass(game, "HttpService")

local getgenv = getgenv() or _G
local readfile = (syn and syn.readfile) or readfile
local isfile = (syn and syn.isfile) or isfile
local delfile = (syn and syn.delfile) or delfile
local listfiles = (syn and syn.listfiles) or listfiles

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI

-------------------------------------------------------------------------------------------------------------------------------

local configname = ""

local function updateindi()		
	if env.stuf.fileinfolabel then
		env.stuf.fileinfolabel.Text = [[
Total configs: ]] .. env.filemanager.getconfigcount() .. [[

<font color='rgb(130,130,130)' size='11'>All files fetched successfully.</font>

Current executor: ]] .. env.funcs.identifyexec() .. [[

<font color='rgb(130,130,130)' size='11'>Your executor is supported.</font>
        ]]
	end

	env.essentials.library.update("List of saved configs", env.filemanager.getconfigcount() == 0 and "No configs found." or env.filemanager.listconfigs())
end

local autoloadData = {}
if isfile(env.filemanager.autoloadfile) then
	local success, decoded = pcall(https.JSONDecode, https, readfile(env.filemanager.autoloadfile))
	if success then autoloadData = decoded end
end

local configname = ""
local lobbyautoload = autoloadData[tostring(env.stuf.lobbyid)] or ""
local runautoload = autoloadData[tostring(env.stuf.runid)] or ""
local roleplayautoload = autoloadData[tostring(env.stuf.rpid)] or ""

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "File" },
	{ type = "label", title = "List of saved configs", desc = "The list below contains all of your saved configs.", content = env.filemanager.getconfigcount() == 0 and "No configs found." or env.filemanager.listconfigs() },
	{ type = "input", title = "Config name", desc = "Input the name of the config to save or load.", placeholder = "Config name",
		callback = function(text)
			configname = text
		end
	},
	{ type = "button", title = "Save config", desc = "Saves the current state of the script to file.", 
		callback = function()
			if not configname or configname == "" then env.funcs.pop("Invalid config name!") return end

			if isfile(env.filemanager.configfolder .. "/" .. configname .. ".json") then
				env.funcs.popup("A config with the name \"" .. configname .. "\" already exists. Do you want to override it?", "Yes", 
					function() 
						local succ, err = pcall(function() env.filemanager.saveconfig(configname) end)
						if not succ then env.funcs.shr("CONFIG ERROR!!!: " .. err) else env.funcs.box("config \"" .. configname .. "\" saved successfully") updateindi() end
						updateindi()
					end, "No", nil)
			end
		end
	},
	{ type = "button", title = "Load config", desc = "Loads the target config.", 
		callback = function()
			if not configname or configname == "" then env.funcs.pop("Invalid config name!") return end
			if not isfile(env.filemanager.configfolder .. "/" .. configname .. ".json") then env.funcs.pop("Config \"" .. configname .. "\" doesn't exist!") return end

			local succ, err = pcall(function() env.filemanager.loadconfig(configname) end)
			if not succ then env.funcs.shr("CONFIG ERROR!!!: " .. err) else env.funcs.box("config \"" .. configname .. "\" loaded successfully") end
		end
	},
	{ type = "button", title = "Delete config", desc = "Deletes the current config.", 
		callback = function()
			if not configname or configname == "" then env.funcs.pop("Invalid config name!") return end

			if isfile(env.filemanager.configfolder .. "/" .. configname .. ".json") then
				env.funcs.popup("Are you sure you want to delete the config \"" .. configname .. "\"? This is irreversable.", "Yes", 
					function() 
						if not isfile(env.filemanager.configfolder .. "/" .. configname .. ".json") then env.funcs.pop("Config \"" .. configname .. "\" doesn't exist!") return end

						local succ, err = pcall(function() env.filemanager.deleteconfig(configname) end)
						if not succ then env.funcs.shr("CONFIG ERROR!!!: " .. err) else env.funcs.box("config \"" .. configname .. "\" deleted successfully") updateindi() end
						updateindi()
					end, "No", nil)
			end
		end
	},
	{ type = "button", title = "Delete all configs", desc = "Permanently deletes every saved config file.", 
		callback = function()
			local configs = listfiles(folder .. "/Configs/")
			for _, file in ipairs(configs) do
				if file:sub(-5) == ".json" then
					delfile(file)
				end
			end
			env.funcs.box("all configs wiped successfully")
			updateindi()
		end
	},

	{ type = "separator", title = "Auto-loading" },
	{ type = "input", title = "Auto-load lobby config", desc = "Automatically loads config in lobby.", placeholder = "Config name",
		default = lobbyautoload,
		callback = function(text)
			env.filemanager.autoloadset(env.stuf.lobbyid, text)
		end
	},
	{ type = "input", title = "Auto-load run config", desc = "Automatically loads config in a run.", placeholder = "Config name",
		default = runautoload,
		callback = function(text)
			env.filemanager.autoloadset(env.stuf.runid, text)
		end
	},
	{ type = "input", title = "Auto-load roleplay config", desc = "Automatically loads config in RP.", placeholder = "Config name",
		default = roleplayautoload,
		callback = function(text)
			env.filemanager.autoloadset(env.stuf.rpid, text)
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
