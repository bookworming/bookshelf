--[[---------------------------------------------------------------------------------------------------------------------------
⠀⠀⠀⠀⠀⠀⣀⣤⣀
⠀⠀⠀⣀⠀⠀⢹⣿⣿⠀⠀⣀
⠀⢰⣿⣿⠀⠀⠀⢻⣿⠀⠀⣿⣿⡆
⠀⢸⣿⣿⠀⠀⠀⠀⢻⠀⠀⣿⣿⡇⠀⠀Team Noxious
⠀⢸⣿⣿⠀⠀⡀⠀⠈⠀⠀⣿⣿⡇⠀⠀Boxten Sex GUI | Developed by unable
⠀⢸⣿⣿⠀⠀⣧⠀⠀⠀⠀⣿⣿⡇⠀:: "Navigation section"
⠀⠸⣿⣿⠀⠀⣿⣧⠀⠀⠀⣿⣿⠇
⠀⠀⠀⠉⠀⠀⣿⣿⣇⠀⠀⠉
⠀⠀⠀⠀⠀⠀⠉⠛⠉
---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

--[[---------------------------------------------------------------------------------------------------------------------------

   TODO:
   complete it idiot

---------------------------------------------------------------------------------------------------------------------------]]--

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ws = FindFirstChildOfClass(game, "Workspace")
local https = FindFirstChildOfClass(game, "HttpService")
local tps = FindFirstChildOfClass(game, "TeleportService")
local uis = FindFirstChildOfClass(game, "UserInputService")
local rs = FindFirstChildOfClass(game, "RunService")
local plrs = FindFirstChildOfClass(game, "Players")

local firetouchinterest = (syn and syn.firetouchinterest) or firetouchinterest
local getgenv = getgenv() or _G
local req = (syn and syn.request) or (http and http.request) or request
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

function getelevatorcframe(ele, nearshop)
	local placednearshop = ele.CFrame * CFrame.new(-6, -10.5, 0) * CFrame.Angles(0, math.rad(-90), 0)
	local center = ele.CFrame * CFrame.new(0, -10.5, 0) * CFrame.Angles(0, math.rad(-90), 0)

	return nearshop and placednearshop or center
end

function toelevator(spec, method)
	local elevator = ws:FindFirstChild("Elevators"):FindFirstChild("Elevator")

	if env.stuf.root then
		if env.stuf.inrun then		
			if spec == 2 and env.stuf.freearea then
				local base = env.stuf.freearea:FindFirstChild("FakeElevator"):FindFirstChild("Base")
				if base:IsA("Part") then
					env.funcs.moveplr(base.CFrame * CFrame.new(0, 2.7, 0) * CFrame.Angles(0, math.rad(-90), 0), method) 
				end
			elseif spec == 1 then
				env.funcs.moveplr(getelevatorcframe(elevator:FindFirstChild("MonsterBlocker")), method)
			end
		end

	elseif env.stuf.inlobby then
		for _, model in ipairs(elevator:GetChildren()) do
			if model:IsA("Model") and model.Name == "Gate" then
				local gate, n = model:FindFirstChild("Gate"), model:FindFirstChild(tostring(spec))
				if gate and n and gate:IsA("BasePart") and n:IsA("BasePart") then
					local s = env.stuf.root.CFrame
					firetouchinterest(env.stuf.root, gate, 0) t()
					firetouchinterest(env.stuf.root, gate, 1) t()
					env.stuf.root.CFrame = s
					return
				end
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

movementtools = {
	teleport = {ins = nil, conn = nil},
	tween = {ins = nil, conn = nil},
	pathfind = {ins = nil, conn = nil}
}

function givemovenenttool(method, state)
	if not movementtools[method] then return end
	local dat = movementtools[method]

	if state then
		local function hi()
			if dat.ins then return end

			local tool = Instance.new("Tool")
			tool.Name = method .. " tool"
			tool.RequiresHandle = false
			tool.Parent = env.stuf.plr.Backpack
			dat.ins = tool

			tool.Activated:Connect(function()
				local cf = CFrame.new(env.stuf.mouse.Hit.X, env.stuf.mouse.Hit.Y + 3, env.stuf.mouse.Hit.Z, select(4, env.stuf.root.CFrame:components()))

				if method == "teleport" then
					env.funcs.moveplr(cf, "tp") 
				elseif method == "tween" then
					env.funcs.moveplr(cf, "tween") 
				elseif method == "pathfind" then
					env.funcs.moveplr(CFrame.new(env.stuf.mouse.Hit.X, env.stuf.mouse.Hit.Y + 3, env.stuf.mouse.Hit.Z), "pf", true) 
				end
			end)

			env.funcs.setcore("bag", true)
		end

		hi() dat.conn = env.stuf.plr.CharacterAdded:Connect(hi)
	else
		if dat.conn then dat.conn:Disconnect() dat.conn = nil end
		if dat.ins then dat.ins:Destroy() dat.ins = nil end
		dat.ins = nil
		dat.conn = nil
	end
end

-------------------------------------------------------------------------------------------------------------------------------

looptptoplrconn = nil

function toplr(plr, method)
	local targets = env.funcs.resolvetargets(plr)
	if not targets or #targets == 0 then return end
	local target = targets[1]

	if target.Character then
		local cf = target.Character:FindFirstChild("HumanoidRootPart").CFrame

		if method == "looptp" then
			if looptptoplrconn then looptptoplrconn:Disconnect() looptptoplrconn = nil end

			looptptoplrconn = rs.Heartbeat:Connect(function()
				env.funcs.moveplr(cf, "tp")
			end)

		elseif method == "unlooptp" then
			if looptptoplrconn then looptptoplrconn:Disconnect() looptptoplrconn = nil end

		else
			env.funcs.moveplr(cf, method) 			
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

function togenerator(method)
	if not env.stuf.machines then return end
	local good = {}

	for _, generator in ipairs(env.stuf.machines:GetChildren()) do
		if generator.PrimaryPart then
			local info = env.funcs.getstats("machine", generator)
			local pos = generator.PrimaryPart.Position

			if not info.completed and not info.possessed then
				local cantgothere = false

				for _, obj in ipairs(env.stuf.currentroom:GetChildren()) do
					if obj:IsA("BasePart") and string.find(obj.Name, "BlotHand") then
						if (obj.Position - pos).Magnitude <= 25 then
							cantgothere = true
							break
						end
					end
				end
				if cantgothere then continue end

				for _, obj in ipairs(env.stuf.freearea:GetChildren()) do
					if obj:IsA("BasePart") and string.find(obj.Name, "SproutTendril") then
						if (obj.Position - pos).Magnitude <= 20 then
							cantgothere = true
							break
						end
					end
				end
				if cantgothere then continue end

				for _, monster in ipairs(env.stuf.twisteds:GetChildren()) do
					if monster:IsA("Model") then
						local info = env.funcs.getstats("twisted", monster)
						local twis = info.name
						local twisroot = info.troot

						if not twisroot then continue end

						local dist = (twisroot.Position - pos).Magnitude

						if not (twis:find("Rodger") or twis:find("Blot") or twis:find("Connie")) then
							if twis:find("Razzle") then
								local awake = monster:FindFirstChild("Awake")
								if awake and awake.Value and dist <= 90 then
									cantgothere = true
									break
								end
							elseif dist <= 50 then
								cantgothere = true
								break
							end
						end
					end
				end

				if not cantgothere then
					table.insert(good, {
						model = generator,
						progress = info.amount
					})
				end
			end
		end
	end

	if #good > 0 then
		table.sort(good, function(a, b)
			return a.progress > b.progress
		end)

		env.funcs.moveplr(env.funcs.getstats("machine", good[1].model).pos, method)
	else
		env.funcs.pop("No available generators found!")
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Teleports" },
	{ type = "button", title = "Teleport to elevator", desc = "Teleports you to the elevator.",
		commandcat = "Local Player",

		command = "teleporttoelevator",
		aliases = {"toele", "tpte"},
		commanddesc = "Teleports you to the elevator",

		callback = function() 
			toelevator(1)
		end
	},
	{ type = "button", title = "Teleport to fake elevator", desc = "Teleports you to the fake elevator.",
		commandcat = "Local Player",

		command = "teleporttofakeelevator",
		aliases = {"tofakeele", "tptfe"},
		commanddesc = "Teleports you to the fake elevator",

		callback = function() 
			toelevator(2)
		end
	},
	{ type = "button", title = "Teleport to machine", desc = "Teleports you to a random machine.",
		commandcat = "Local Player",

		command = "teleporttomachine",
		aliases = {"tomach", "tptm"},
		commanddesc = "Teleports you to a random machine",

		callback = function() 
			togenerator("tp")
		end
	},
	{ type = "toggle", title = "Teleport tool", desc = "Gives you a teleport tool. Click anywhere while having it equipped to teleport to the clicked position.",
		commandcat = "Local Player",

		encommands = {"teleporttool"},
		enaliases = {"tptool"},
		encommanddesc = "Gives you a teleport tool",

		discommands = {"unteleporttool"},
		disaliases = {"untptool"},
		discommanddesc = "Gets rid of the teleport tool",

		callback = function(state) 
			givemovenenttool("teleport", state)
		end
	},
	{ type = "input and button", title = "Teleport to player", desc = "Teleports you to the target player.", placeholder = "Target",
		commandcat = "Local Player",

		command = "teleportto [plr]",
		aliases = {"tp [plr]", "to [plr]"},
		commanddesc = "Teleports you to the target player",

		callback = function(text) 
			toplr(text, "tp")
		end,

		autofill = true
	},
	{ type = "input and toggle", title = "Loop teleport to player", desc = "Repetitively teleports you to the target player.", placeholder = "Target",
		commandcat = "Local Player",

		encommands = {"loopteleportto [plr]"},
		enaliases = {"looptpto [plr]", "loopto [plr]", "ltp [plr]"},
		encommanddesc = "Repetitively teleports you to the target player",

		discommands = {"unloopteleportto"},
		disaliases = {"unlooptp", "unloopto", "unltp"},
		discommanddesc = "Stops repetitively teleporting to target player",

		callback = function(text, state) 
			toplr(text, state and "looptp" or "unlooptp")
		end,

		autofill = true
	},

	{ type = "separator", title = "Tweens" },
	{ type = "button", title = "Tween to elevator", desc = "Tweens you to the elevator.",
		commandcat = "Local Player",

		command = "tweentoelevator",
		aliases = {"tweentoele", "twte"},
		commanddesc = "Tweens you to the elevator",

		callback = function() 
			toelevator(1, "tween")
		end
	},
	{ type = "button", title = "Tween to fake elevator", desc = "Tweens you to the fake elevator.",
		commandcat = "Local Player",

		command = "tweentofakeelevator",
		aliases = {"tweentofakeele", "twtfe"},
		commanddesc = "Tweens you to the fake elevator",

		callback = function() 
			toelevator(2, "tween")
		end
	},
	{ type = "button", title = "Tween to machine", desc = "Tweens you to a random machine.",
		commandcat = "Local Player",

		command = "tweentomachine",
		aliases = {"tweentomach", "twtm"},
		commanddesc = "Tweens you to a random machine",

		callback = function() 
			togenerator("tween")
		end
	},
	{ type = "toggle", title = "Tween tool", desc = "Gives you a tween tool. Click anywhere while having it equipped to tween to the clicked position.",
		commandcat = "Local Player",

		encommands = {"tweentool"},
		enaliases = {"twtool"},
		encommanddesc = "Gives you a tween tool",

		discommands = {"untweentool"},
		disaliases = {"untwtool"},
		discommanddesc = "Gets rid of the tween tool",

		callback = function(state)
			givemovenenttool("tween", state)
		end
	},
	{ type = "input and button", title = "Tween to player", desc = "Tweens you to the target player.", placeholder = "Target",
		commandcat = "Local Player",

		command = "tweento [plr]",
		aliases = {"twto [plr]"},
		commanddesc = "Tweens you to the target player",

		callback = function(text) 
			toplr(text, "tween")
		end,

		autofill = true
	},

	{ type = "separator", title = "Pathfinding" },
	{ type = "button", title = "Pathfind to elevator", desc = "Walks you to the elevator using a pathfinding agent.",
		commandcat = "Local Player",

		command = "pathfindtoelevator",
		aliases = {"walktoele", "pfte"},
		commanddesc = "Walks you to the elevator",

		callback = function() 
			toelevator(1, "pf")
		end
	},
	{ type = "button", title = "Pathfind to fake elevator", desc = "Walks you to the fake elevator using a pathfinding agent.",
		commandcat = "Local Player",

		command = "pathfindtofakeelevator",
		aliases = {"walktofakeele", "pftfe"},
		commanddesc = "Walks you to the fake elevator",

		callback = function() 
			toelevator(2, "pf")
		end
	},
	{ type = "button", title = "Pathfind to machine", desc = "Walks you to a random machine using a pathfinding agent.",
		commandcat = "Local Player",

		command = "pathfindtomachine",
		aliases = {"walktomach", "tpte"},
		commanddesc = "Walks you to a random machine",

		callback = function() 
			togenerator("pf")
		end
	},
	{ type = "toggle", title = "Pathfind tool", desc = "Gives you a Pathfind tool. Click anywhere while having it equipped to walk a path towards the clicked position.",
		commandcat = "Local Player",

		encommands = {"pathfindtool"},
		enaliases = {"pftool"},
		encommanddesc = "Gives you a pathfind tool",

		discommands = {"unpathfindtool"},
		disaliases = {"unpftool"},
		discommanddesc = "Gets rid of the pathfind tool",

		callback = function(state) 
			givemovenenttool("pathfind", state)
		end
	},
	{ type = "input and button", title = "Pathfind to player", desc = "Walks you to the target player using a pathfinding agent.", placeholder = "Target",
		commandcat = "Local Player",

		command = "pathfindto [plr]",
		aliases = {"walkto [plr]", "pfto [plr]"},
		commanddesc = "Walks you to the target player using a pathfinding agent",

		callback = function(text) 
			toplr(text, "pf")
		end,

		autofill = true
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
