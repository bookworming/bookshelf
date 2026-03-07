--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Animations section)

---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local uis = FindFirstChildOfClass(game, "UserInputService")
local rs = FindFirstChildOfClass(game, "RunService")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Animation target" },
	{ type = "dropdown", title = "Animaton target", desc = "Sets the Toon you want to play animations from.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Use Twisted", desc = "Uses the animatons of the Twisted version of the Toon.", 
		callback = function(state) 
		end
	},

	{ type = "separator", title = "Animations (Toon)" },
	{ type = "toggle", title = "Apply animation pack", desc = "Applies the target Toon's animations onto you.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play idle animation", desc = "Plays the idle animation of the target Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play walk animation", desc = "Plays the walk animation of the target Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play run animation", desc = "Plays the run animation of the target Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play extract animation", desc = "Plays the extract animation of the target Toon.", 
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play quirk animation", desc = "Plays the quirk animation of the target Toon.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop quirk animation", desc = "Plays the quirk animation of the target Toon in a loop.",
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play ability animation", desc = "Plays the ability animation of the target Toon.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop ability animation", desc = "Plays the ability animation of the target Toon in a loop.",
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary idle animation", desc = "Plays the secondary idle animation of the target Toon if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary walk animation", desc = "Plays the secondary walk animation of the target Toon if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary run animation", desc = "Plays the secondary run animation of the target Toon if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary extract animation", desc = "Plays the secondary extract animation of the target Toon if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play secondary quirk animation", desc = "Plays the secondary quirk animation of the target Toon if they have one.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop secondary quirk animation", desc = "Plays the secondary quirk animation of the target Toon in a loop if they have one.",
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play secondary ability animation", desc = "Plays the secondary ability animation of the target Toon if they have one.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop secondary ability animation", desc = "Plays the secondary ability animation of the target Toon in a loop if they have one.",
		callback = function(state) 
		end
	},

	{ type = "separator", title = "Animations (Twisted)" },
	{ type = "toggle", title = "Apply animation pack", desc = "Applies the target Twisted's animations onto you.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play idle animation", desc = "Plays the idle animation of the target Twisted.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play walk animation", desc = "Plays the walk animation of the target Twisted.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play run animation", desc = "Plays the run animation of the target Twisted.", 
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play attack animation", desc = "Plays the attack animation of the target Twisted.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop attack animation", desc = "Plays the attack animation of the target Twisted in a loop.",
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play ability animation", desc = "Plays the ability animation of the target Twisted if they have one.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop ability animation", desc = "Plays the ability animation of the target Twisted in a loop if they have one.",
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play lost interest animation", desc = "Plays the lost interest animation of the target Twisted.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop lost interest animation", desc = "Plays the lost interest animation of the target Twisted in a loop.",
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary idle animation", desc = "Plays the secondary idle animation of the target Twisted if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary walk animation", desc = "Plays the secondary walk animation of the target Twisted if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Play secondary run animation", desc = "Plays the secondary run animation of the target Twisted if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "button", title = "Play secondary ability animation", desc = "Plays the secondary ability animation of the target Twisted if they have one.",
		callback = function() 
		end
	},
	{ type = "toggle", title = "Loop secondary ability animation", desc = "Plays the secondary ability animation of the target Twisted in a loop if they have one.",
		callback = function(state) 
		end
	},

	{ type = "separator", title = "Animation replacing" },
	{ type = "input", title = "Idle animation target", desc = "Input the name of the Toon you want to replace your idle animation with.", placeholder = "Toon",
		callback = function(text) 
		end
	},
	{ type = "dropdown", title = "Idle animaton target", desc = "Sets the Toon you want to replace your idle animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Use Twisted idle", desc = "Uses the idle animatons of the Twisted version of the Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Replace current idle animation", desc = "Replaces your current idle animation to the target idle animation.", 
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Walk animaton target", desc = "Sets the Toon you want to replace your walk animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Use Twisted walk", desc = "Uses the walk animatons of the Twisted version of the Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Replace current walk animation", desc = "Replaces your current walk animation to the target walk animation.", 
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Run animaton target", desc = "Sets the Toon you want to replace your run animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Use Twisted run", desc = "Uses the run animatons of the Twisted version of the Toon.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Replace current run animation", desc = "Replaces your current run animation to the target run animation.", 
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Extract animaton target", desc = "Sets the Toon you want to replace your extract animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Replace current extract animation", desc = "Replaces your current extract animation to the target extract animation.", 
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Quirk animaton target", desc = "Sets the Toon you want to replace your quirk animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Replace current quirk animation", desc = "Replaces your current quirk animation to the target quirk animation.", 
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Ability animaton target", desc = "Sets the Toon you want to replace your ability animation with.", 
		options = {"Astro", "Bassie", "Blot", "Bobette", "Boxten", "Brightney", "Brusha",
			"Coal", "Cocoa", "Connie", "Cosmo",
			"Dandy", "Dazzle", "Dyle",
			"Eggson", "Eclipse",
			"Finn", "Flutter", "Flyte",
			"Gigi", "Ginger", "Glisten", "Goob", "Gourdy",
			"Looey",
			"Pebble", "Poppy",
			"Razzle", "Ribecca", "Rodger", "Rudie",
			"Scraps", "Shelly", "Shrimpo", "Soulvester", "Sprout",
			"Teagan", "Tisha", "Toodles",
			"Vee",
			"Yatta"},

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Use Twisted ability", desc = "Uses the ability animatons of the Twisted version of the Toon if they have one.", 
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Replace current ability animation", desc = "Replaces your current ability animation to the target ability animation.", 
		callback = function(state) 
		end
	},

	{ type = "separator", title = "Animation settings" },
	{ type = "button", title = "Reset animations", desc = "Resets your animations back to normal.",
		callback = function() 
		end
	},
	{ type = "slider", title = "Animation speed", desc = "Adjusts your animation speed to the set value.", min = 0, max = 200, default = 1, step = 1,
		callback = function(value)
		end
	},
	{ type = "toggle", title = "Stop motion animations", desc = "Makes your animations more jittery.", 
		callback = function(state) 
		end
	},
	{ type = "slider", title = "Stop motion animation step rate", desc = "Determines the step rate of the jittery animations.", min = 0.02, max = 1, default = 0.06, step = 0.02,
		callback = function(value)
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
