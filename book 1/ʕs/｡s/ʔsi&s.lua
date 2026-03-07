--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Script Information & File sections]
   
---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ts = FindFirstChildOfClass(game, "TweenService")

local getgenv = getgenv() or _G
local queueotp = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local currentversioninfo = env.scriptinfo.script
local olderversioninfo = env.essentials.data.cl.older

-------------------------------------------------------------------------------------------------------------------------------

queueconn = nil
function queuescript(state)
	if not queueotp then return end
	if state then
		queueconn = env.stuf.plr.OnTeleport:Connect(function()
			queueotp("")
		end)
	else
		if queueconn then queueconn:Disconnect() queueconn = nil end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local sections = {
	version = version,

	["1"] = {
		{ type = "separator", title = "Script settings" },
		{ type = "binder", title = "Toggle interface keybind", desc = "Sets the keybind that will toggle the visibility of the interface.", 
			default = "N",
			callback = function(key)
				env.gear.general.defaultkeybind = key
			end
		},
		{ type = "toggle", title = "Debug mode", desc = "Toggles debug mode. Output visible in the Roblox Developer Console.", 
			default = true,
			callback = function(state) 
				env.gear.general.debugmode = state
			end
		},
		{ type = "toggle", title = "Keep on server switch", desc = "Re-executes the script upon switching experiences.", 
			callback = function(state) 
				env.gear.general.queueteleport = state
				queuescript(state)
			end
		},
		{ type = "toggle", title = "Ignore full Research Twisteds", desc = "Ignores every single Twisted in which you already have full Research on when encountering all Twisteds.", 
			callback = function(state) 
				env.gear.general.ignoreresearchcompleted = state
			end
		},
		{ type = "slider", title = "Item teleport Y offset", desc = "Sets the Y offset of the target item teleport position (In studs).", min = -5, max = 5, default = -2.5, step = 0.5,
			callback = function(value)
				env.gear.general.itemtpposyoffset = value
			end
		},
		{ type = "toggle", title = "Force stop extraction when teleporting to machine", desc = "Forcefully quits machine extraction when teleporting to a random generator.",

			callback = function(state) 
				env.gear.general.forcequitwhenteleportingtomach = state
			end
		},

		{ type = "separator", title = "Blacklists" },
		{ type = "dropdown", title = "Twisted encounter blacklist", desc = "Blacklists the selected Twisteds from being encountered.", 
			options = {"Twisted Astro", "Twisted Bassie", "Twisted Blot", "Twisted Bobette", "Twisted Boxten", "Twisted Brightney", "Twisted Brusha",
				"Twisted Coal", "Twisted Cocoa", "Twisted Connie", "Twisted Cosmo",
				"Twisted Dandy", "Twisted Dazzle", "Twisted Dyle",
				"Twisted Eggson", "Twisted Eclipse",
				"Twisted Finn", "Twisted Flutter", "Twisted Flyte",
				"Twisted Gigi", "Twisted Ginger", "Twisted Glisten", "Twisted Goob", "Twisted Gourdy",
				"Twisted Looey",
				"Twisted Pebble", "Twisted Poppy",
				"Twisted Razzle", "Twisted Ribecca", "Twisted Rodger", "Twisted Rudie",
				"Twisted Scraps", "Twisted Shelly", "Twisted Shrimpo", "Twisted Soulvester", "Twisted Sprout",
				"Twisted Teagan", "Twisted Tisha", "Twisted Toodles",
				"Twisted Vee",
				"Twisted Yatta"},
			multiselect = true,

			callback = function(selected) 
				env.gear.general.encountertwistedblacklist = selected
			end 
		}
	},
	["2"] = {
		{ type = "separator", title = "Scaling" },
		{ type = "slider", title = "Mainframe UI scale", desc = "Adjusts the UI sscale of the mainframe.", min = 0.5, max = 2, default = 1, step = 0.1,
			callback = function(value)
				env.gear.general.mainframescale = value
				ts:Create(env.stuf.mainframescale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = env.gear.general.mainframescale }):Play()
			end
		},
		{ type = "slider", title = "Button UI scale", desc = "Adjusts the UI scale of the buttons.", min = 0.5, max = 2, default = 1, step = 0.1,
			callback = function(value)
				env.gear.general.buttonscale = value
				if env.stuf.setbuttonscale then
					env.stuf.setbuttonscale(value)
				end
			end
		},

		{ type = "separator", title = "Toons" },
		{ type = "toggle", title = "Closed captions", desc = "Enables subtitles for the Toons.", 
			callback = function(state) 
				env.gear.toons.closedcaptions = state
			end
		},
		{ type = "toggle", title = "Alternate Boxten personality", desc = "Changes Boxten's way of speaking and makes him talk like how he actually talks.", 
			callback = function(state) 
				env.gear.toons.nicerboxten = state
			end
		},
		{ type = "button", title = "Switch Boxten with Poppy", desc = "Switches Boxten with Poppy and changes their dialogue.", 
			callback = function() 
			end, 
		},
		{ type = "button", title = "Switch Poppy with Shrimpo", desc = "Switches Poppy with Shrimpo and changes their dialogue.", 
			callback = function() 
			end, 
		},
		{ type = "button", title = "Switch Shrimpo with Boxten", desc = "Switches Shrimpo with Boxten and changes their dialogue.", 
			callback = function() 
			end, 
		},
		{ type = "toggle", title = "Live Poppy reaction", desc = "Allows Poppy to react to your gameplay.", 
			callback = function(state) 
				env.gear.toons.livepoppyreaction = state
			end
		},
		{ type = "toggle", title = "Live Shrimpo reaction", desc = "Allows Shrimpo to react to your gameplay.", 
			callback = function(state) 
				env.gear.toons.liveshrimporeaction = state
			end
		},
	},
	["3"] = {
		{ type = "separator", title = "Current version" },
		{ type = "label", title = "Version " .. currentversioninfo.version, desc = "Sub-version: " .. currentversioninfo.subversion .. ". Last updated: " .. currentversioninfo.lastupdated, content = currentversioninfo.changelog },

		{ type = "separator", title = "Older versions" },
		{ type = "label", title = "Version " .. olderversioninfo["1.2.9"].version, desc = "Sub-versions: " .. olderversioninfo["1.2.9"].subversions .. ". Final release: " .. olderversioninfo["1.2.9"].finaldate, content = olderversioninfo["1.2.9"].changelog },
	}
}

-------------------------------------------------------------------------------------------------------------------------------

return sections

-------------------------------------------------------------------------------------------------------------------------------
