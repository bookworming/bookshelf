--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Local Player section]
   
---------------------------------------------------------------------------------------------------------------------------]]--

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ws = FindFirstChildOfClass(game, "Workspace")
local uis = FindFirstChildOfClass(game, "UserInputService")
local rs = FindFirstChildOfClass(game, "RunService")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local getconnections = (syn and syn.getconnections) or getconnections
local blacklistrayfilter = Enum.RaycastFilterType.Blacklist

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

noclipconn = nil
noclipmodparts = {}
noclipfactiveconn = nil
noclipping = false
noclippaused = false

function gbp()
	local rp = RaycastParams.new()
	rp.FilterDescendantsInstances = {env.stuf.char}
	rp.FilterType = blacklistrayfilter
	rp.IgnoreWater = true

	local result = ws:Raycast(env.stuf.root.Position, env.stuf.root.CFrame.LookVector * 40, rp)
	if result and result.Instance and result.Instance:IsA("BasePart") and result.Instance.Name ~= "hello" then
		return result.Instance
	end
	return nil
end

function gtp()
	local touching = {}
	for _, part in ipairs(env.stuf.char:GetDescendants()) do
		if part:IsA("BasePart") and part.CanTouch then
			for _, p in ipairs(part:GetTouchingParts()) do
				if not p:IsDescendantOf(env.stuf.char) and p.Name ~= "hello" then
					table.insert(touching, p)
				end
			end
		end
	end
	return touching
end

function gsp()
	local origin = env.stuf.root.Position
	local direction = Vector3.new(0, -5, 0)

	local rp = RaycastParams.new()
	rp.FilterDescendantsInstances = {env.stuf.char}
	rp.FilterType = blacklistrayfilter
	rp.IgnoreWater = true

	local result = ws:Raycast(origin, direction, rp)
	if result and result.Instance then
		return result.Instance
	end
	return nil
end

function rcp()
	local pr = {}

	for part, data in pairs(noclipmodparts) do
		if part and part.Parent then
			local front = gbp()
			local touching = gtp()
			local stillTouching = (front == part) or table.find(touching, part)

			if not stillTouching then
				table.insert(pr, part)
			end
		else
			noclipmodparts[part] = nil
		end
	end

	for _, part in ipairs(pr) do
		if noclipmodparts[part] then
			part.CanCollide = noclipmodparts[part].CanCollide
			noclipmodparts[part] = nil
		end
	end
end

function noclip()
	if noclipconn then return end

	noclipconn = rs.Heartbeat:Connect(function()
		if env.stuf.hum and env.stuf.hum.PlatformStand then
			if not noclippaused then
				noclippaused = true
				for part, data in pairs(noclipmodparts) do
					if part and part.Parent then
						part.CanCollide = data.CanCollide
					end
				end
				table.clear(noclipmodparts)
			end
			return
		else
			if noclippaused then
				noclippaused = false
			end
		end

		rcp()

		local standing = gsp()
		local front = gbp()
		if front and front.CanCollide and front.Name ~= "hello" and front ~= standing then
			if not noclipmodparts[front] then
				noclipmodparts[front] = {
					CanCollide = front.CanCollide,
					LastSeen = tick()
				}
				front.CanCollide = false
			else
				noclipmodparts[front].LastSeen = tick()
			end
		end

		local touching = gtp()
		for _, part in ipairs(touching) do
			if part:IsA("BasePart") and part.CanCollide and part.Name ~= "é§u}ÙwVµÏË{Z<Ç_ÊFvÅëôÅåG/º?^¹" then
				if part ~= standing and part.Position.Y > env.stuf.root.Position.Y - 3 then
					if not noclipmodparts[part] then
						noclipmodparts[part] = {
							CanCollide = part.CanCollide,
							LastSeen = tick()
						}
						part.CanCollide = false
					else
						noclipmodparts[part].LastSeen = tick()
					end
				end
			end
		end
	end)
end

function stopnoclipping()
	env.funcs.rid(noclipconn)
	noclipconn = nil

	for part, data in pairs(noclipmodparts) do
		if part and part.Parent then
			part.CanCollide = data.CanCollide
		end
	end

	table.clear(noclipmodparts)
end

function ncdc()
	if not getconnections then return end

	for _, connection in pairs(getconnections(env.stuf.root:GetPropertyChangedSignal("CanCollide"))) do
		connection:Disconnect() t()
	end

	for _, connection in pairs(getconnections(env.stuf.root:GetPropertyChangedSignal("CanTouch"))) do
		connection:Disconnect() t()
	end

	for _, connection in pairs(getconnections(env.stuf.root:GetPropertyChangedSignal("CanQuery"))) do
		connection:Disconnect() t()
	end
end

savedCollisions = {}

function disableCharacterCollisions(character)
	savedCollisions = {}

	for _, inst in ipairs(character:GetDescendants()) do
		if inst:IsA("BasePart") then
			savedCollisions[inst] = inst.CanCollide
			inst.CanCollide = false
		end
	end
end

function restoreCharacterCollisions()
	for part, state in pairs(savedCollisions) do
		if part and part.Parent then
			part.CanCollide = state
		end
	end
	savedCollisions = {}
end

nccalled = false

function noclipbypass(state)
	noclipping = state
	if not env.stuf.char then return end

	if state then
		if env.stuf.inrun then
			ncdc()
			if not nccalled then
				nccalled = true
				disableCharacterCollisions(env.stuf.char)
			end
		else
			noclipping = true
			disableCharacterCollisions(env.stuf.char)
			noclip()
		end
	else
		if env.stuf.inrun then
			ncdc()
			restoreCharacterCollisions()
		else
			noclipping = false
			restoreCharacterCollisions()
			stopnoclipping()
		end
		nccalled = false
	end
end

function safenoclip(state)
	noclipping = state
	if state then
		noclip()
	else
		stopnoclipping()
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	{ type = "separator", title = "Utility" },
	{ type = "toggle", title = "Noclip", desc = "Gives you the ability to phase through objects.",
		commandcat = "Local Player",

		encommands = {"noclip"},
		encommanddesc = "Enables noclipping",

		discommands = {"unnoclip"},
		disaliases = {"clip"},
		discommanddesc = "Disables noclipping",

		callback = function(state) 
			noclipbypass(state)
		end
	},
	{ type = "toggle", title = "Infinite stamina", desc = "Makes it so your stamina doesnt drain.",
		commandcat = "Local Player",

		encommands = {"enableinfinitestamina"},
		enaliases = {"infinitestamina", "eis"},
		encommanddesc = "Enables infinite stamina",

		discommands = {"disableinfinitestamina"},
		disaliases = {"finitestamina", "dis"},
		discommanddesc = "Disables infinite stamina",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Show actual stamina while having infinite stamina", desc = "Shows your actual stamina value while having infinite stamina enabled.",
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Anti slowness debuff", desc = "Makes you immune to the slowness debuff.",
		commandcat = "Local Player",

		encommands = {"enableantislownessdebuff"},
		enaliases = {"easd"},
		encommanddesc = "Enables anti slowness debuff",

		discommands = {"disableantislownessdebuff"},
		disaliases = {"dasd"},
		discommanddesc = "Disables anti slowness debuff",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Anti ban", desc = "Applies measures that will prevent you from getting banned. Note that you are still susceptible to getting banned even when having this on.",
		commandcat = "Local Player",

		encommands = {"enableantiban"},
		enaliases = {"eab"},
		encommanddesc = "Enables anti ban",

		discommands = {"disableantiban"},
		disaliases = {"dab"},
		discommanddesc = "Disables anti ban",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Anti AFK", desc = "Prevents you from getting kicked from the game for being idle for too long.",
		commandcat = "Local Player",

		encommands = {"enableantiafk"},
		enaliases = {"eaafk"},
		encommanddesc = "Enables anti AFK",

		discommands = {"disableantiafk"},
		disaliases = {"daafk"},
		discommanddesc = "Disables anti AFK",

		callback = function(state)
		end
	},
	{ type = "button", title = "Force quit machine", desc = "Forcefully quits machine extraction.",
		commandcat = "Local Player",

		command = "forcequitmachine",
		aliases = {"fqm"},
		commanddesc = "Forcefully quits machine extraction",

		callback = function()
		end
	},
	{ type = "toggle", title = "Heavier character", desc = "Makes your character less slippery.",
		commandcat = "Local Player",

		encommands = {"enableheavycharacter"},
		enaliases = {"ehc"},
		encommanddesc = "Enables heavier character",

		discommands = {"disableheavycharacter"},
		disaliases = {"dhc"},
		discommanddesc = "Disables heavier character",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Twisteds push aura", desc = "Applies a push aura to the Twisteds that push you away when they get close.",
		commandcat = "Local Player",

		encommands = {"enabletwistedspushaura"},
		enaliases = {"etpa"},
		encommanddesc = "Enables Twisteds push aura",

		discommands = {"disabletwistedspushaura"},
		disaliases = {"dhc"},
		discommanddesc = "Disables Twisteds push aura",

		callback = function(state)
		end
	},
	{ type = "slider", title = "Twisteds push aura size", desc = "Adjusts the size of the Twisteds' push aura.", min = 3, max = 80, default = 20, step = 1,
		callback = function(value)
		end
	},
	{ type = "toggle", title = "Hide from Twisteds", desc = "Hides you from a Twisted by moving you inside the closest object.",
		commandcat = "Local Player",

		encommands = {"enablehidefromtwisteds"},
		enaliases = {"ehft"},
		encommanddesc = "Enables hide from Twisteds",

		discommands = {"disablehidefromtwisteds"},
		disaliases = {"dhft"},
		discommanddesc = "Disables hide from Twisteds",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Avoid Twisteds", desc = "Teleports you away from the Twisted if they get too close.",
		commandcat = "Local Player",

		encommands = {"enableavoidtwisteds"},
		enaliases = {"eat"},
		encommanddesc = "Enables avoid Twisteds",

		discommands = {"disableavoidtwisteds"},
		disaliases = {"dat"},
		discommanddesc = "Disables avoid Twisteds",

		callback = function(state)
		end
	},
	{ type = "slider", title = "Avoid Twisteds distance", desc = "Sets the distance required for the Twisted to reach toward you to teleport away.", min = 3, max = 80, default = 10, step = 1,
		callback = function(value)
		end
	},
	{ type = "toggle", title = "Anti grab", desc = "Applies measures that stops Twisteds with grabbing abilities (Such as Goob, Scraps, and Gigi) from grabbing you.",
		commandcat = "Local Player",

		encommands = {"enableantigrab"},
		enaliases = {"eag"},
		encommanddesc = "Enables anti grab",

		discommands = {"disableantigrab"},
		disaliases = {"dag"},
		discommanddesc = "Disables anti grab",

		callback = function(state)
		end
	},
	{ type = "button", title = "Pick up all items", desc = "Picks up all the items on the floor.",
		commandcat = "Local Player",

		command = "pickupallitems",
		aliases = {"puai"},
		commanddesc = "Picks up all the items on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Pick up all Research Capsules", desc = "Picks up all the Research Capsules on the floor.",
		commandcat = "Local Player",

		command = "pickupallresearchcapsules",
		aliases = {"puarc"},
		commanddesc = "Picks up all the Research Capsules on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Pick up all Tapes", desc = "Picks up all the tapes on the floor.",
		commandcat = "Local Player",

		command = "pickupalltapes",
		aliases = {"puat"},
		commanddesc = "Picks up all the Tapes on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Pick up all heals", desc = "Picks up all the heals on the floor.",
		commandcat = "Local Player",

		command = "pickupallheals",
		aliases = {"puah"},
		commanddesc = "Picks up all the heals on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Pick up all etxraction items", desc = "Picks up all the extraction items on the floor.",
		commandcat = "Local Player",

		command = "pickupallextractionitems",
		aliases = {"puaei"},
		commanddesc = "Picks up all the extraction items on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Pick up all event items", desc = "Picks up all the event items / currency on the floor (Including Research Capsules that are linked to Event Twisteds).",
		commandcat = "Local Player",

		command = "pickupalleventitems",
		aliases = {"puaeti"},
		commanddesc = "Picks up all the event items on the floor",

		callback = function() 
		end
	},
	{ type = "button", title = "Encounter all Twisteds", desc = "Encounters every Twisted on the floor that you haven't encountered yet.",
		commandcat = "Local Player",

		command = "encounteralltwisteds",
		aliases = {"eat"},
		commanddesc = "Encounters all the Twisteds on the floor that haven't spotted you yet",

		callback = function() 
		end
	},
	{ type = "toggle", title = "Anti pop-ups", desc = "Blocks Twisted Vee's pop-ups from appearing.",
		commandcat = "Local Player",

		encommands = {"enableantipopups"},
		enaliases = {"eapu"},
		encommanddesc = "Enables anti pop-ups",

		discommands = {"disableantipopups"},
		disaliases = {"dapu"},
		discommanddesc = "Disables anti pop-ups",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Anti skillcheck", desc = "Blocks the skillcheck UI from appearing.",
		commandcat = "Local Player",

		encommands = {"enableantiskillchecks"},
		enaliases = {"easc"},
		encommanddesc = "Enables anti skill checks",

		discommands = {"disableantiskillchecks"},
		disaliases = {"dasc"},
		discommanddesc = "Disables anti skill checks",

		callback = function(state)
		end
	},
	{ type = "button", title = "Instant death", desc = "Kills you.",
		commandcat = "Local Player",

		command = "die",
		commanddesc = "Kills you",

		callback = function() 
		end
	},

	{ type = "separator", title = "Ability" },
	{ type = "input and button", title = "Use ability on player", desc = "Uses your ability on the target player, bypassing distance checks.", placeholder = "Target",
		commandcat = "Local Player",

		command = "useabilityon [plr]",
		aliases = {"useabil [plr]"},
		commanddesc = "Uses your ability on the target player",

		callback = function(text) 
		end,

		autofill = true
	},
	{ type = "input and button", title = "Teleport to and use ability on player", desc = "Teleports you to the target player and then uses your ability.", placeholder = "Target",
		commandcat = "Local Player",

		command = "teleportanduseabilityon [plr]",
		aliases = {"tpanduseabil [plr]"},
		commanddesc = "Teleports you to the target player and then uses your ability",

		callback = function(text) 
		end,

		autofill = true
	},

	{ type = "separator", title = "Toon ability replication" },
	{ type = "button", title = "Rudie boost", desc = "Imitates Rudie's active ability. Boosts your character a few studs.",
		commandcat = "Local Player",

		command = "rudieboost",
		aliases = {"boost"},
		commanddesc = "Boosts your character",

		callback = function()
		end
	},
	{ type = "toggle", title = "Finn passive ability", desc = "Imitates Finn's passive ability. You gain a 33% movement speed boost for 10 seconds when a machine is completed.",
		commandcat = "Local Player",

		encommands = {"enablefakefinnpassiveability"},
		enaliases = {"effpa"},
		encommanddesc = "Enables fake Finn passive ability",

		discommands = {"disablefakefinnpassiveability"},
		disaliases = {"dffpa"},
		discommanddesc = "Disables fake Finn passive ability",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Sprout passive ability", desc = "Imitates Sprout's passive ability. Heart icons pulse on every Toon alive in a run.",
		commandcat = "Local Player",

		encommands = {"enablefakesproutpassiveability"},
		enaliases = {"efspa"},
		encommanddesc = "Enables fake Sprout passive ability",

		discommands = {"disablefakesproutpassiveability"},
		disaliases = {"dfspa"},
		discommanddesc = "Disables fake Sprout passive ability",

		callback = function(state)
		end
	},

	{ type = "separator", title = "Character" },
	{ type = "input and toggle", title = "Loop speed", desc = "Repetitively sets your speed to the inputted value.", placeholder = "Speed",
		commandcat = "Local Player",

		encommands = {"loopspeed [num]"},
		enaliases = {"ls [num]"},
		encommanddesc = "Enables loop speed",

		discommands = {"unloopspeed"},
		disaliases = {"unls"},
		discommanddesc = "Disables loop speed",

		callback = function(text, state) 
		end
	},
	{ type = "input and toggle", title = "Teleport walk", desc = "Toggles teleport walking with the inputted speed.", placeholder = "Speed",
		commandcat = "Local Player",

		encommands = {"teleportwalk [num]"},
		enaliases = {"tpwalk [num]"},
		encommanddesc = "Enables teleport walk",

		discommands = {"unteleportwalk"},
		disaliases = {"untpwalk"},
		discommanddesc = "Disables teleport walk",

		callback = function(text, state) 
		end
	},
	{ type = "toggle", title = "Teleport walk on extract", desc = "Toggles teleport walking only when extracting.",
		callback = function(state) 
		end
	},
	{ type = "input and toggle", title = "Fly", desc = "Makes you fly with the inputted speed.", placeholder = "Speed",
		commandcat = "Local Player",

		encommands = {"fly [num]"},
		encommanddesc = "Makes you fly",

		discommands = {"unfly"},
		discommanddesc = "Stop flying",

		callback = function(text, state) 
		end
	},
	{ type = "input", title = "Extra walk speed units", desc = "Adds extra speed to your walk movement speed.", placeholder = "Speed",
		commandcat = "Local Player",

		command = "addwalkspeed [num]",
		aliases = {"addws [num]"},
		commanddesc = "Adds extra speed to your walk movement speed",

		callback = function(text)
		end
	},
	{ type = "input", title = "Extra run speed units", desc = "Adds extra speed to your run movement speed.", placeholder = "Speed",
		commandcat = "Local Player",

		command = "addrunspeed [num]",
		aliases = {"addrs [num]"},
		commanddesc = "Adds extra speed to your run movement speed",

		callback = function(text)
		end
	},

	{ type = "separator", title = "On death" },
	{ type = "toggle", title = "Rejoin lobby on death", desc = "Rejoins the lobby upon death.",
		commandcat = "Local Player",

		encommands = {"enablerejoinlobbyondeath"},
		enaliases = {"erjlod"},
		encommanddesc = "Enables rejoin lobby on death",

		discommands = {"disablerejoinlobbyondeath"},
		disaliases = {"drjlod"},
		discommanddesc = "Disables rejoin lobby on death",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Close game on death", desc = "Closes Roblox upon death.",
		commandcat = "Local Player",

		encommands = {"enableclosegameondeat"},
		enaliases = {"ecod"},
		encommanddesc = "Enables close game on death",

		discommands = {"disableclosegameondeat"},
		disaliases = {"dcod"},
		discommanddesc = "Disables close game on death",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Restart run on death", desc = "Rejoins the lobby and then joins an empty elevator upon death.",
		commandcat = "Local Player",
		
		encommands = {"enablerestartrunondeath"},
		enaliases = {"ecod"},
		encommanddesc = "Enables restart run on death",

		discommands = {"disablerestartrunondeath"},
		disaliases = {"dcod"},
		discommanddesc = "Disables restart run on death",

		callback = function(state) 
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
