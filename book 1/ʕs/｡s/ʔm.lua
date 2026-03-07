--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Main section)

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
local tps = FindFirstChildOfClass(game, "TeleportService")
local uis = FindFirstChildOfClass(game, "UserInputService")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local req = (syn and syn.request) or (http and http.request) or request
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

function getmembercount(inv)
	if not req then return "???" end

	local success, res = pcall(function()
		return req({
			Url = ("https://discord.com/api/v10/invites/%s?with_counts=true"):format(inv),
			Method = "GET"
		})
	end)

	if success and res and res.Body then
		local data = https:JSONDecode(res.Body)
		if data and data.approximate_member_count then
			return tostring(data.approximate_member_count)
		end
	end

	return "???"
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "seperator" },
	{ type = "button", title = "button", desc = "debug",
		callback = function() 
			print("button")
		end
	},
	{ type = "toggle", title = "toggle", desc = "debug",
		callback = function(state) 
			print("toggle " .. tostring(state))
		end
	},
	{ type = "slider", title = "slider", desc = "debug",
		callback = function(val) 
			print("slider " .. tostring(val))
		end
	},
	{ type = "dropdown", title = "dropdown", desc = "debug",
		options = {"option1", "option2", "option3"},
		callback = function(val) 
			print("dropdown " .. tostring(val))
		end
	},
	{ type = "input", title = "input", desc = "debug",
		callback = function(val) 
			print("input " .. tostring(val))
		end
	},
	{ type = "input and button", title = "input and button", desc = "debug",
		callback = function(val) 
			print("input and button " .. tostring(val))
		end
	},
	{ type = "input and toggle", title = "input and toggle", desc = "debug",
		callback = function(val) 
			print("input and toggle " .. tostring(val))
		end
	},
	{ type = "separator", title = "Community" },
	{ type = "button", title = "Join Noxious Discord", desc = ("Copies our server's Discord invite link. (Members: %s)"):format(getmembercount("m2K7UXcyZj")),
		commandcat = "Main",

		command = "noxiousdiscord",
		aliases = {"discord"},
		commanddesc = "Copies our server's Discord invite link",

		callback = function() 
			env.funcs.copytoclipboard("https://discord.gg/m2K7UXcyZj")
		end
	},
	{ type = "button", title = "Join Bookclub Discord", desc = ("Copies Bookclub / Riddance's Discord invite link. (Members: %s)"):format(getmembercount("hbHEv8QvE9")),
		commandcat = "Main",

		command = "bookclubdiscord",
		aliases = {"riddancediscord"},
		commanddesc = "Copies Bookclub / Riddance's Discord invite link",

		callback = function() 
			env.funcs.copytoclipboard("https://discord.gg/hbHEv8QvE9")
		end
	},

	{ type = "separator", title = "Interface" },
	{ type = "button", title = "Reposition interface", desc = "Repositions the interface back into the center of the screen.",
		commandcat = "Main",

		command = "repositionui",
		aliases = {"reposui"},
		commanddesc = "Repositions the interface back into the center of the screen",

		callback = function() 
			env.essentials.library.centerui(env.stuf.mainframe)
		end
	},
	{ type = "toggle", title = "Lock interface", desc = "Toggles the ability to drag the interface.",
		commandcat = "Main",

		encommands = {"lockui"},
		enaliases = {"lui"},
		encommanddesc = "Prevents the interface from being dragged",

		discommands = {"unlockui"},
		disaliases = {"unlui"},
		discommanddesc = "Makes the interface draggable again",

		callback = function(state) 
			env.stuf.mainframedrag.draggable = not state
		end
	},
	{ type = "toggle", title = "Lock toggle button", desc = "Toggles the ability to drag the toggle button.",
		commandcat = "Main",

		encommands = {"locktogglebutton"},
		enaliases = {"ltb"},
		encommanddesc = "Prevents the toggle button from being dragged",

		discommands = {"unlocktogglebutton"},
		disaliases = {"unltb"},
		discommanddesc = "Makes the toggle button draggable again",

		callback = function(state) 
			env.stuf.togglebuttondrag.draggable = not state
		end
	},
	{ type = "toggle", title = "Hide toggle button", desc = "Hides the toggle button.",
		commandcat = "Main",

		encommands = {"hidetogglebutton"},
		enaliases = {"htb"},
		encommanddesc = "Hides the toggle button",

		discommands = {"showtogglebutton"},
		disaliases = {"stb"},
		discommanddesc = "Shows the toggle button",

		callback = function(state) 
			env.stuf.togglebutton.Visible = not state
		end
	},
	{ type = "button", title = "Destroy interface", desc = "Destroys the interface.",
		commandcat = "Main",

		command = "destroyui",
		aliases = {"noui"},
		commanddesc = "Destroys the interface",

		callback = function()
			env.funcs.popup("Are you sure you want to destroy the interface? This is irreversable.", "Yes", function() if env.stuf.mainframe then env.stuf.mainframe:Destroy() end if env.stuf.togglebutton then env.stuf.togglebutton:Destroy() end end, "Nevermind", nil)
		end
	},
	{ type = "button", title = "Disconnect all connections", desc = "Disconnects all running connections, essentially resetting everything back to normal.",
		commandcat = "Main",

		command = "disconnectallconnections",
		aliases = {"disconnectall", "noconns"},
		commanddesc = "Disconnects all connections",

		callback = function() 
			env.funcs.popup("Are you sure you want to disconnect all connections? This will reset everything to default.", "Yes", function() end, "Nevermind", nil)
		end
	},

	{ type = "separator", title = "Developer" },
	{ type = "button", title = "Notify version", desc = "Notifies you the current version of the script.",
		commandcat = "Main",

		command = "notifyversion",
		aliases = {"version"},
		commanddesc = "Notifies you the current version of the script",

		callback = function() 
		end
	},
	{ type = "button", title = "Show console", desc = "Shows the Roblox Developer Console.",
		commandcat = "Main",

		command = "console",
		aliases = {"c"},
		commanddesc = "Opens the Roblox Developer Console",

		callback = function()
			env.funcs.setcore("console", true)
		end
	},

	{ type = "separator", title = "Server" },
	{ type = "button", title = "Server hop", desc = "Joins a different server.",
		commandcat = "Main",

		command = "serverhop",
		aliases = {"shop"},
		commanddesc = "Joins a different server",

		callback = function() 
			loadstring(game:HttpGet("https://pastefy.app/rQLTcjeQ/raw"))():serverhop()
		end
	},
	{ type = "button", title = "Rejoin", desc = "Rejoins your current server.",
		commandcat = "Main",

		command = "rejoin",
		aliases = {"rj"},
		commanddesc = "Rejoins your current server",

		callback = function() 
			loadstring(game:HttpGet("https://pastefy.app/rQLTcjeQ/raw"))():rejoin()
		end
	},
	{ type = "button", title = "Rejoin teleport", desc = "Rejoins your current server and then teleports you to the same spot you left in.",
		commandcat = "Main",

		command = "rejointeleport",
		aliases = {"rejointp", "rjtp"},
		commanddesc = "Rejoins your current server and then teleports you to the same spot you left in",

		callback = function() 
			loadstring(game:HttpGet("https://pastefy.app/rQLTcjeQ/raw"))():rejointeleport()
		end
	},

	{ type = "separator", title = "Game" },
	{ type = "button", title = "Join lobby", desc = "Joins the lobby.",
		commandcat = "Main",

		command = "joinlobby",
		aliases = {"tolobby", "jl"},
		commanddesc = "Joins the lobby",

		callback = function() 
			tps:Teleport(env.stuf.lobbyid, env.stuf.plr)
		end
	},
	{ type = "button", title = "Join roleplay server", desc = "Joins a roleplay server.",
		commandcat = "Main",

		command = "joinroleplayserver",
		aliases = {"toroleplayserver", "jrps"},
		commanddesc = "Joins a roleplay server",

		callback = function() 
			tps:Teleport(env.stuf.rpid, env.stuf.plr)
		end
	},

	{ type = "separator", title = "Support" },
	{ type = "button", title = "Donation (500)", desc = "Copies a link to our 500 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1085884381/Donor")
		end
	},
	{ type = "button", title = "Donation (450)", desc = "Copies a link to our 450 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1318032362/Donor")
		end
	},
	{ type = "button", title = "Donation (400)", desc = "Copies a link to our 400 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480841694/Donor")
		end
	},
	{ type = "button", title = "Donation (350)", desc = "Copies a link to our 350 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480783676/Donor")
		end
	},
	{ type = "button", title = "Donation (300)", desc = "Copies a link to our 300 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1481391576/Donor")
		end
	},
	{ type = "button", title = "Donation (250)", desc = "Copies a link to our 250 Robux gamepass.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480775720/Donor")
		end
	},
	{ type = "button", title = "Donation (200)", desc = "Copies a link to our 200 Robux gamepass.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480661763/Donor")
		end
	},
	{ type = "button", title = "Donation (150)", desc = "Copies a link to our 150 Robux gamepass.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480693767/Donor")
		end
	},
	{ type = "button", title = "Donation (100)", desc = "Copies a link to our 100 Robux gamepass.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1481321604/Donor")
		end
	},
	{ type = "button", title = "Donation (50)", desc = "Copies a link to our 50 Robux gamepass.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480785633/Donor")
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
