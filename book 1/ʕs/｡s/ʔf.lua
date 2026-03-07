--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Fun section)

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
local rs = FindFirstChildOfClass(game, "RunService")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local req = (syn and syn.request) or (http and http.request) or request
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

function playanim(id, weight, speed, time)
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. id
	local track = env.stuf.hum:LoadAnimation(anim)
	track:Play(0.5, weight, speed)
	if time then
		t(time)
		track:Stop(0.5)
		track:Destroy()
		anim:Destroy()
		return
	end
	track.Stopped:Connect(function()
		track:Destroy()
		anim:Destroy()
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

jumppowerloopconn = nil
jumpanimconn = nil

function togglejumping(state)
	local tcf, jump, menu, invite, information, settings

	if mobile then
		tcf = env.stuf.plr:WaitForChild("PlayerGui"):WaitForChild("TouchGui"):FindFirstChild("TouchControlFrame")
		jump = tcf and tcf:FindFirstChild("JumpButton")
		menu = env.stuf.plr:WaitForChild("PlayerGui"):WaitForChild("MainGui"):WaitForChild("Menu")	
		invite = menu:WaitForChild("InviteButton")	
		information = menu:WaitForChild("InfoButton")	
		settings = menu:WaitForChild("SettingsButton")
	end

	if state then
		if not jumpanimconn and env.stuf.hum then
			jumpanimconn = env.stuf.hum.StateChanged:Connect(function(_, newstate)
				if newstate == Enum.HumanoidStateType.Jumping then
					playanim("86612812701056", 2, 1, 0.9) 
				end
			end)
		end

		if mobile and jump then
			jump.Visible = true
			invite.Visible = false
			information.Visible = false
			settings.Visible = false
		end

		jumppowerloopconn = rs.RenderStepped:Connect(function()
			if env.stuf.hum then
				env.stuf.hum.JumpPower = 50
				env.stuf.hum.UseJumpPower = true
				env.stuf.hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				env.stuf.hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
			end
		end)
	else
		if jumpanimconn then jumpanimconn:Disconnect() jumpanimconn = nil end

		if mobile and jump then
			jump.Visible = false
			invite.Visible = true
			information.Visible = true
			settings.Visible = true
		end

		if jumppowerloopconn then jumppowerloopconn:Disconnect() jumppowerloopconn = nil end

		if env.stuf.hum then
			env.stuf.hum.JumpPower = 0
			env.stuf.hum.UseJumpPower = true
			env.stuf.hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
			env.stuf.hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

infjumpconn = nil
infjumpdebounce = false
function infjump(state)
	if not state then
		if infjumpconn then infjumpconn:Disconnect() infjumpconn = nil end
		infjumpdebounce = false
		return
	else
		infjumpconn = uis.JumpRequest:Connect(function()
			if not infjumpdebounce then
				infjumpdebounce = true
				env.stuf.hum:ChangeState(Enum.HumanoidStateType.Jumping)
				t()
				infjumpdebounce = false
			end
		end)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Character" },
	{ type = "toggle", title = "Enable jumping", desc = "Allows you to jump.", 
		commandcat = "Fun",

		encommands = {"enablejumping"},
		enaliases = {"ej"},
		encommanddesc = "Enables jumping",

		discommands = {"disablejumping"},
		disaliases = {"dj"},
		discommanddesc = "Disables jumping",

		callback = function(state) 
			togglejumping(state) 
		end
	},
	{ type = "toggle", title = "Infinite jump", desc = "Allows you to jump without reaching the floor.", 
		commandcat = "Fun",

		encommands = {"enableinfinitejump"},
		enaliases = {"eij"},
		encommanddesc = "Enables infinite jumping",

		discommands = {"disableinfinitejump"},
		disaliases = {"dij"},
		discommanddesc = "Disables infinite jumping",

		callback = function(state) 
			infjump(state)
		end
	},
	{ type = "toggle", title = "Backflip", desc = "Performs a backflip.", 
		commandcat = "Fun",

		encommands = {"enablefliptools"},
		enaliases = {"eft"},
		encommanddesc = "Enables flip tools",

		discommands = {"disablefliptools"},
		disaliases = {"dft"},
		discommanddesc = "Disables flip tools",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Frontflip", desc = "Performs a frontflip.", 
		commandcat = "Fun",

		encommands = {"enablefliptools"},
		enaliases = {"eft"},
		encommanddesc = "Enables flip tools",

		discommands = {"disablefliptools"},
		disaliases = {"dft"},
		discommanddesc = "Disables flip tools",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "T-pose", desc = "Makes you T-pose.", 
		commandcat = "Fun",

		encommands = {"enabletpose"},
		enaliases = {"etp"},
		encommanddesc = "Enables T-posing",

		discommands = {"disabletpose"},
		disaliases = {"dtp"},
		discommanddesc = "Disables T-posing",

		callback = function(state) 
		end
	},
	{ type = "input and toggle", title = "Spin", desc = "Makes you spin with the specified speed.", placeholder = "Speed",
		commandcat = "Fun",

		encommands = {"spin [num]"},
		encommanddesc = "Makes you spin with the target speed",

		discommands = {"unspin"},
		discommanddesc = "Stops spinning",

		callback = function(text, state) 
		end
	},
	{ type = "input and toggle", title = "Z Spin", desc = "Makes you spin on the Z axis with the specified speed.", placeholder = "Speed",
		commandcat = "Fun",

		encommands = {"zspin [num]"},
		encommanddesc = "Makes you spin on the Z axis with the target speed",

		discommands = {"unzspin"},
		discommanddesc = "Stops spinning on the Z axis",

		callback = function(text, state) 
		end
	},
	{ type = "input and toggle", title = "X Spin", desc = "Makes you spin on the X axis with the specified speed.", placeholder = "Speed",
		commandcat = "Fun",

		encommands = {"xspin [num]"},
		encommanddesc = "Makes you spin on the X axis with the target speed",

		discommands = {"unxspin"},
		discommanddesc = "Stops spinning on the X axis",

		callback = function(text, state) 
		end
	},
	{ type = "toggle", title = "Gyrate", desc = "Makes you tumble around.", 
		commandcat = "Fun",

		encommands = {"gyrate"},
		encommanddesc = "Makes you gyrate around",

		discommands = {"ungyrate"},
		discommanddesc = "Stops gyrating",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Spasm", desc = "Makes you go crazy.", 
		commandcat = "Fun",

		encommands = {"spasm"},
		encommanddesc = "Makes you go crazy",

		discommands = {"unspasm"},
		discommanddesc = "Stops spasming",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Upside down", desc = "Flips you upside down.", 
		commandcat = "Fun",

		encommands = {"upsidedown"},
		enaliases = {"dinnerbone"},
		encommanddesc = "Flips your character upside down",

		discommands = {"rightsideup"},
		disaliases = {"undinnerbone"},
		discommanddesc = "Flips your character right side up",

		callback = function(state) 
		end
	},
	{ type = "input and button", title = "Rotate character", desc = "Applies a rotation onto your character.", placeholder = "X, Y, Z",
		commandcat = "Fun",

		command = "rotate [X, Y, Z]",
		commanddesc = "Rotates your character",

		callback = function(text, state) 
		end
	},

	{ type = "separator", title = "Actions" },
	{ type = "input and toggle", title = "Headsit player", desc = "Makes you sit on the target player's head.", placeholder = "Target",
		commandcat = "Fun",

		encommands = {"headsit [plr]"},
		encommanddesc = "Makes you sit on the target player's head",

		discommands = {"unheadsit"},
		discommanddesc = "Disables headsit",

		callback = function(text, state) 
		end,

		autofill = true
	},
	{ type = "slider", title = "Adjust headsit Y offset", desc = "Adjusts the headsit's Y offset.", min = 0, max = 10, default = 0, step = 1,
		callback = function(value)
		end
	},
	{ type = "slider", title = "Adjust headsit Z offset", desc = "Adjusts the headsit's Z offset.", min = 0, max = 10, default = 0, step = 1,
		callback = function(value)
		end
	},
	{ type = "input and toggle", title = "Orbit player", desc = "Makes you orbit around the player.", placeholder = "Target",
		commandcat = "Fun",

		encommands = {"orbit [plr]"},
		encommanddesc = "Makes you orbit around the player",

		discommands = {"unorbit"},
		discommanddesc = "Disables player orbit",

		callback = function(text, state) 
		end,

		autofill = true
	},
	{ type = "slider", title = "Adjust orbit radius", desc = "Adjusts the orbit's radius.", min = 0, max = 10, default = 0, step = 1,
		callback = function(value)
		end
	},
	{ type = "slider", title = "Adjust orbit speed", desc = "Adjusts the orbit's speed.", min = 0, max = 10, default = 0, step = 1,
		callback = function(value)
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
