--[[---------------------------------------------------------------------------------------------------------------------------
⠀⠀⠀⠀⠀⠀⣀⣤⣀
⠀⠀⠀⣀⠀⠀⢹⣿⣿⠀⠀⣀
⠀⢰⣿⣿⠀⠀⠀⢻⣿⠀⠀⣿⣿⡆
⠀⢸⣿⣿⠀⠀⠀⠀⢻⠀⠀⣿⣿⡇⠀⠀Team Noxious
⠀⢸⣿⣿⠀⠀⡀⠀⠈⠀⠀⣿⣿⡇⠀⠀Boxten Sex GUI | Developed by unable
⠀⢸⣿⣿⠀⠀⣧⠀⠀⠀⠀⣿⣿⡇⠀⠀:: "Automation section"
⠀⠸⣿⣿⠀⠀⣿⣧⠀⠀⠀⣿⣿⠇
⠀⠀⠀⠉⠀⠀⣿⣿⣇⠀⠀⠉
⠀⠀⠀⠀⠀⠀⠉⠛⠉
---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ws = FindFirstChildOfClass(game, "Workspace")
local uis = FindFirstChildOfClass(game, "UserInputService")
local ts = FindFirstChildOfClass(game, "TweenService")
local rs = FindFirstChildOfClass(game, "RunService")
local rst = FindFirstChildOfClass(ws, "ReplicatedStorage")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local firesignal = (syn and syn.firesignal) or firesignal
local getcallbackvalue = (syn and syn.getcallbackvalue) or getcallbackvalue

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

local autoescapewormconn
local autoescapewormdelay = 0.1
local function autoescape(state)
	if state then
		local function tap(dir)
			rst.Events.TwistedSquirmGrab:FireServer(unpack({"Struggle", dir}))
		end

		local uivisible
		local ui = env.stuf.plrgui.TwistedSquirmEscapeUI
		autoescapewormconn = ui.Changed:Connect(function()
			if ui.Enabled then
				uivisible = true
				while uivisible do
					tap("left") t(autoescapewormdelay)
					tap("right") t(autoescapewormdelay)
				end
			else
				uivisible = false
			end
		end)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local autoteleporttoelevatorconditions = {}
local autoteleporttoelevatorconn
local autoteleporttoelevatorenabled = false

function getelevatorcframe(ele, nearshop)
	local placednearshop = ele.CFrame * CFrame.new(-6, -10.5, 0) * CFrame.Angles(0, math.rad(-90), 0)
	local center = ele.CFrame * CFrame.new(0, -10.5, 0) * CFrame.Angles(0, math.rad(-90), 0)
	return nearshop and placednearshop or center
end

local function toelevator(fake, method)
	if env.stuf.root then
		if fake and env.stuf.freearea then
			local base = env.stuf.freearea:FindFirstChild("FakeElevator"):FindFirstChild("Base")
			if base:IsA("Part") then
				env.funcs.moveplr(base.CFrame * CFrame.new(0, 2.7, 0) * CFrame.Angles(0, math.rad(-90), 0), method)
			end
		else
			env.funcs.moveplr(getelevatorcframe(env.stuf.elevator:FindFirstChild("MonsterBlocker")), method)
		end
	end
end

local function checkeveryoneatelevaor()
	local blocker = env.stuf.elevator:FindFirstChild("MonsterBlocker")
	if not blocker then return false end
	for _, player in ipairs(plrs:GetPlayers()) do
		if player ~= env.stuf.plr and player.Character then
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if not root or (root.Position - blocker.Position).Magnitude > 40 then
				return false
			end
		end
	end
	return true
end

local function autoteleporttoelevator(state)
	autoteleporttoelevatorenabled = state

	if not state then
		if autoteleporttoelevatorconn then
			autoteleporttoelevatorconn:Disconnect()
			autoteleporttoelevatorconn = nil
		end
		return
	end

	if autoteleporttoelevatorconn then return end

	local panic = env.stuf.gameinfo:FindFirstChild("Panic")
	local timer = env.stuf.gameinfo:FindFirstChild("PanicTimer")

	autoteleporttoelevatorconn = panic.Changed:Connect(function()
		if not panic.Value then return end

		local condition = autoteleporttoelevatorconditions

		if condition == "Instant" then
			toelevator(nil, "tp")

		elseif condition == "Everyone at elevator" then
			spwn(function()
				while autoteleporttoelevatorenabled and panic.Value do
					if checkeveryoneatelevaor() then
						toelevator(nil, "tp")
						break
					end
					t()
				end
			end)

		elseif condition == "At the last second" then
			spwn(function()
				while autoteleporttoelevatorenabled and panic.Value do
					if timer and timer.Value <= 1 then
						toelevator(nil, "tp")
						break
					end
					t()
				end
			end)
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local autocalibrating = false

local function handlesc()
	local tl = 5
	local sgui = env.stuf.plrgui:FindFirstChild("ScreenGui")		
	if not sgui then return end

	local menu = sgui:FindFirstChild("Menu")	
	if not menu then return end

	local scf = menu:FindFirstChild("SkillCheckFrame")		
	if not scf then return end

	local function visibledisrupt()
		if autocalibrating and scf.Visible then
			local marker = scf:FindFirstChild("Marker")				
			local goldarea = scf:FindFirstChild("GoldArea")

			if marker and goldarea then
				local mpos = marker.AbsolutePosition
				local gpos = goldarea.AbsolutePosition
				local garea = goldarea.AbsoluteSize

				if mpos.X >= gpos.X and mpos.X <= (gpos.X + garea.X) + tl then
					firesignal(menu.Calibrate.MouseButton1Down)
					firesignal(menu.Calibrate.MouseButton1Up)
					firesignal(menu.Calibrate.MouseButton1Click)
				end
			end
		end
	end

	scf.Changed:Connect(function()
		if not scf.Visible then visibledisrupt() else visibledisrupt() end
	end)

	local marker = scf:FindFirstChild("Marker")		
	local goldarea = scf:FindFirstChild("GoldArea")

	if marker then
		marker.Changed:Connect(function(property)
			if property == "AbsolutePosition" then visibledisrupt() end
		end)
	end

	if goldarea then
		goldarea.Changed:Connect(function(property)
			if property == "AbsolutePosition" or property == "AbsoluteSize" then visibledisrupt() end
		end)
	end
end

function autocalibration(state)
	if state then
		spwn(handlesc)
		autocalibrating = true
	else
		autocalibrating = false
	end
end

-------------------------------------------------------------------------------------------------------------------------------

-- thank you unable
autocircleminigame = false
acmlastpresstime = 0
acmalreadypressed = false

function handlecm()
	local function getsize(circle)
		local size = circle.AbsoluteSize
		local stroke = circle:FindFirstChildOfClass("UIStroke")
		local thickness = stroke and stroke.Thickness or 0
		return math.min(size.X, size.Y) + (thickness * 2)
	end

	local function checkmatch()
		if not autocircleminigame then return end

		local gui = env.stuf.plrgui:FindFirstChild("CircleSkillCheckGui")
		if not gui then
			acmalreadypressed = false
			return
		end

		local skillcheck = gui:FindFirstChild("SkillCheckFrame")
		if not skillcheck then
			acmalreadypressed = false
			return
		end

		local container = skillcheck:FindFirstChild("Container")
		if not container then
			acmalreadypressed = false
			return
		end

		local red = container:FindFirstChild("ShrinkingCircle")
		local gold = container:FindFirstChild("YellowCircle")
		if not red or not gold then
			acmalreadypressed = false
			return
		end

		local redsize = getsize(red)
		local goldsize = getsize(gold)

		local diff = math.abs(redsize - goldsize)
		local threshold = math.max(5, goldsize * 0.05)

		if diff <= threshold then
			if not acmalreadypressed then
				t(0.03)
				firesignal(container)
				firesignal(container.MouseButton1Down)
				firesignal(container.MouseButton1Up)
				firesignal(container.MouseButton1Click)
				acmlastpresstime = tick()
				acmalreadypressed = true
			end
		else
			acmalreadypressed = false
		end
	end

	env.stuf.plrgui.ChildAdded:Connect(function(child)
		if child.Name == "CircleSkillCheckGui" then
			local skillcheck = child:WaitForChild("SkillCheckFrame", 2)
			local container = skillcheck and skillcheck:WaitForChild("Container", 2)
			if container then
				local conn
				conn = rs.RenderStepped:Connect(function()
					if not autocircleminigame then
						conn:Disconnect()
						return
					end
					checkmatch()
				end)
			end
		end
	end)
end

function autocirclecalibration(state)
	if state then
		if not autocircleminigame then
			spwn(handlecm)
			autocircleminigame = true
		end
	else
		autocircleminigame = false
	end
end

-------------------------------------------------------------------------------------------------------------------------------

handlingtreadmill = false
treadmillhandlerverif = false
ontreadmill = false
treadmillconn = nil

treadmilllowthresh = 20
treadmillhighthresh = 100

function handletreadmill()
	if not env.stuf.plrstats then return end
	local stamina = env.stuf.plrstats:FindFirstChild("CurrentStamina")
	if not stamina then return end

	if treadmillconn then treadmillconn:Disconnect() end

	local function checkSprint()
		if handlingtreadmill and treadmillhandlerverif and ontreadmill then
			local val = stamina.Value
			if val > treadmilllowthresh and val < treadmillhighthresh then
				rst.Events.SprintEvent:FireServer(true)
			else
				rst.Events.SprintEvent:FireServer(false)
			end
		else
			rst.Events.SprintEvent:FireServer(false)
		end
	end

	treadmillconn = stamina.Changed:Connect(checkSprint)
	checkSprint()
end

function treadmillmonitor()
	spwn(function()
		while handlingtreadmill do
			t(0.5)

			if env.funcs.getstats("player", env.stuf.char).extracting and not treadmillhandlerverif then
				treadmillhandlerverif = true
				ontreadmill = env.funcs.getstats("machine", env.funcs.getstats("player", env.stuf.char).extracting).machtype == "treadimll"
				if ontreadmill then
					handletreadmill()
				end

			elseif not env.funcs.getstats("player", env.stuf.char).extracting and treadmillhandlerverif then
				treadmillhandlerverif = false
				ontreadmill = false
				if treadmillconn then
					treadmillconn:Disconnect()
					treadmillconn = nil
				end
				rst.Events.SprintEvent:FireServer(false)
			end
		end
	end)
end

autotreadmillconn = nil
autotreadmillenabled = false
autotreadmillspamming = false
autotreadmilldelay = 0.1

function spamspace()
	if autotreadmillspamming then return end
	autotreadmillspamming = true

	spwn(function()
		while autotreadmillspamming do
			t(autotreadmilldelay)
		end
		autotreadmillspamming = false
	end)
end

function ojnef9023htibweidunfp9q83hfojdsnfv()
	for _, gui in ipairs(env.stuf.plrgui:GetChildren()) do
		if gui:IsA("ScreenGui") and gui.Name:find("Tre") then
			spamspace()
		end
	end

	autotreadmillconn = env.stuf.plrgui.ChildAdded:Connect(function(gui)
		if gui:IsA("ScreenGui") and gui.Name:find("Tre") then
			spamspace()
		end
	end)

	env.stuf.plrgui.ChildRemoved:Connect(function(gui)
		if gui:IsA("ScreenGui") and gui.Name:find("Tre") then
			autotreadmillspamming = false
		end
	end)
end

function autotreadmill(state)
	if state then
		if autotreadmillenabled then return end
		handlingtreadmill = true
		treadmillmonitor()
		ojnef9023htibweidunfp9q83hfojdsnfv()
		autotreadmillenabled = true
	else
		if autotreadmillconn then
			autotreadmillconn:Disconnect()
			autotreadmillconn = nil
		end
		autotreadmillenabled = false
		autotreadmillspamming = false
		handlingtreadmill = false
		if treadmillconn then treadmillconn:Disconnect() treadmillconn = nil end
		rst.Events.SprintEvent:FireServer(false)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local oldskillcheckinvoc
spwn(function() 
	if env.stuf.inrun then
		if getcallbackvalue then 
			oldskillcheckinvoc = getcallbackvalue(game:GetService("ReplicatedStorage").Events.SkillcheckUpdate, "OnClientInvoke") 
		else 
			oldskillcheckinvoc = nil 
		end 
	end
end)

function autocalibration2(state)
	autocalibration = state
	if env.stuf.inrun then
		local hi = rst.Events.SkillcheckUpdate
		if state then
			hi.OnClientInvoke = function()
				spwn(function()
					local a = env.stuf.plrgui:WaitForChild("ScreenGui")
					a.Menu.SkillCheckFrame.Visible = false
					a.Menu.Calibrate.Visible = false

					a.Correct:Stop()
					a.Correct:Play()
					a.GoldAreaHit:Stop()
					a.GoldAreaHit:Play()

					a.Menu.SkillCheckMessage.Text = "Great Job!"
					a.Menu.SkillCheckMessage.UIGradient.Enabled = false
					a.Menu.SkillCheckMessage.UIGradientWin.Enabled = true
					a.Menu.SkillCheckMessage.Visible = true
					a.Menu.SpaceBarPromptText.Visible = true
					a.Menu.SkillCheckMessage.TextTransparency = 0
					a.Menu.SkillCheckMessage.TextStrokeTransparency = 0

					t(1)

					local c = ts:Create(a.Menu.SkillCheckMessage, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {TextTransparency = 1,TextStrokeTransparency = 1}):Play()
					c.Completed:Wait()
					a.Menu.SkillCheckMessage.Visible = false
				end)

				return "supercomplete"
			end
		else
			hi.OnClientInvoke = oldskillcheckinvoc
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

env.stuf.afe = {
	running = false,
	priority = {},
	maxitemcap = 2,
	itemmaxdist = 0,
	machmaxdist = 0,
	preset = "Default",
	actiontrigger = "Map fully loaded",
	actions = {
		"Auto pick up all items", 
		"Auto pick up all event items", 
		"Auto pick up all Research Capsules",
		"Auto pick up all Tapes", 
		"Auto pick up all heals", 
		"Auto pick up all extraction items", 
		"Auto encounter Twisteds",
		"Auto buy items"
	}
}

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Autofarming" },
	{ type = "toggle", title = "Toggle autofarm", desc = "Toggles the autofarm. Turning on any functions that modify or adjust the player's behavior may result in conflicts.",
		callback = function(state) 
			env.stuf.afe.running = state
		end
	},

	{ type = "separator", title = "Autofarm settings" },
	{ type = "dropdown", title = "Autofarm priority", desc = "Makes the autofarm prioritize the selected element.", 
		options = {"Research", "Heals", "Extraction speed"},

		callback = function(selected) 
			env.stuf.afe.priority = selected
		end 
	},
	{ type = "slider", title = "Item capacity limit for autofarm", desc = "Limits the amount of items you can hold in your inventory.", min = 0, max = 4, default = 0, step = 1,
		callback = function(value)
			env.stuf.afe.maxitemcap = value
		end
	},
	{ type = "slider", title = "Item max distance for autofarm", desc = "Avoids items when a Twisted is within the set distance of the item.", min = 0, max = 100, default = 0, step = 1,
		callback = function(value)
			env.stuf.afe.itemmaxdist = value
		end
	},
	{ type = "slider", title = "Machine max distance for autofarm", desc = "Avoids machines when a Twisted is within the set distance of the machine.", min = 0, max = 100, default = 0, step = 1,
		callback = function(value)
			env.stuf.afe.machmaxdist = value
		end
	},
	{ type = "toggle", title = "Anti crash for autofarm", desc = "Toggles a mode that prevents your device from crashing due to memory leaks all while trying to keep your device's temperature stable. Use this when you want to autofarm on a low-end device for a long period of time.",
		callback = function(state) 
		end
	},
	{ type = "slider", title = "Anti crash memory leak threshold", desc = "Lowers the memory usage when it exceeds the set value.", min = 1000, max = 15000, default = 2000, step = 100,
		callback = function(value)
		end
	},
	{ type = "dropdown", title = "Autofarm preset", desc = "Sets a custom preset for the Autofarm.", 
		options = {"Default", "Toon Mastery", "Twisted Research"},
		default = env.stuf.afe.preset,
		canbeempty = false,

		callback = function(selected) 
			env.stuf.afe.preset = selected
		end 
	},

	{ type = "separator", title = "Autofarm actions" },
	{ type = "dropdown", title = "Perform autofarm actions trigger", desc = "Performs the autofarm actions when the selected event is triggered.", 
		options = {"Map fully loaded", "On floor start", "On panic mode"},
		default = env.stuf.afe.actiontrigger,
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
			env.stuf.afe.actiontrigger = selected
		end 
	},
	{ type = "dropdown", title = "Automate actions", desc = "Automatically performs the selected actions while autofarming.", 
		options = {"Auto pick up all items", "Auto pick up all event items", "Auto pick up all Research Capsules",
			"Auto pick up all Tapes", "Auto pick up all heals", "Auto pick up all extraction items", "Auto encounter Twisteds"},
		default = env.stuf.afe.actions,
		multiselect = true,

		callback = function(selected) 
			env.stuf.afe.actions = selected
		end 
	},

	{ type = "separator", title = "Teleports" },
	{ type = "toggle", title = "Auto teleport to elevator", desc = "Automatically teleports you to the elevator when panic mode is on.",
		commandcat = "Automation",

		encommands = {"enableautoteleporttoelevator"},
		enaliases = {"eatpte"},
		encommanddesc = "Enables auto teleport to elevator",

		discommands = {"disableautoteleporttoelevator"},
		disaliases = {"datpte"},
		discommanddesc = "Disables auto teleport to elevator",

		callback = function(state)
			autoteleporttoelevator(state)
		end
	},
	{ type = "dropdown", title = "Auto teleport to elevator condition", desc = "Sets the condition that has to be followed before automatically teleporting to the elevator.", 
		options = {"Instant", "Everyone at elevator", "At the last second"},
		default = "Instant",
		canbeempty = false,

		callback = function(selected)
			autoteleporttoelevatorconditions = selected
		end
	},
	{ type = "toggle", title = "Auto teleport to machine", desc = "Automatically teleports you to a random machine.",
		commandcat = "Automation",

		encommands = {"enableautoteleporttomachine"},
		enaliases = {"eatptm"},
		encommanddesc = "Enables auto teleport to machine",

		discommands = {"disableautoteleporttomachine"},
		disaliases = {"datptm"},
		discommanddesc = "Disables auto teleport to machine",

		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Auto teleport to machine condition", desc = "Sets the condition that has to be followed before automatically teleporting to a random machine.", 
		options = {"Extraction start", "Extraction end", "Player is near", "On floor start", "Map fully loaded"},
		default = "Extraction start",
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Force stop extraction when teleporting to machine", desc = "Forcefully quits machine extraction when teleporting to a random generator.",
		commandcat = "Automation",

		encommands = {"enableautoforcequitmachine"},
		enaliases = {"eafqm"},
		encommanddesc = "Enables auto force quit machine",

		discommands = {"disableautoforcequitmachine"},
		disaliases = {"dafqm"},
		discommanddesc = "Disables auto force quit machine",

		callback = function(state) 
		end
	},

	{ type = "separator", title = "Player" },
	{ type = "toggle", title = "Auto machine calibration", desc = "Automatically completes skillchecks for regular machines.",
		commandcat = "Automation",

		encommands = {"enableautocalibration"},
		enaliases = {"eac"},
		encommanddesc = "Enables auto machine calibration",

		discommands = {"disableautocalibration"},
		disaliases = {"dac"},
		discommanddesc = "Disables auto machine calibration",

		callback = function(state) 
			autocalibration(state)
		end
	},
	{ type = "toggle", title = "Auto circle machine calibration", desc = "Automatically completes skillchecks for circle machines.",
		commandcat = "Automation",

		encommands = {"enableautocirclecalibration"},
		enaliases = {"eacc"},
		encommanddesc = "Enables auto circle machine calibration",

		discommands = {"disableautocirclecalibration"},
		disaliases = {"dacc"},
		discommanddesc = "Disables auto circle machine calibration",

		callback = function(state) 
			autocirclecalibration(state)
		end
	},
	{ type = "input and toggle", title = "Auto treadmill machine calibration", desc = "Automatically completes skillchecks for treadmill machines with the set spam delay.", placeholder = "Delay",
		commandcat = "Automation",

		encommands = {"enableautotreadmillcalibration"},
		enaliases = {"eatc"},
		encommanddesc = "Enables auto treadmill machine calibration",

		discommands = {"disableautotreadmillcalibration"},
		disaliases = {"datc"},
		discommanddesc = "Disables auto treadmill machine calibration",

		defaulttext = "0.1",
		callback = function(text, state) 
			autotreadmilldelay = text or 0.1
			autotreadmill(state)
		end
	},
	{ type = "toggle", title = "Instant calibration success", desc = "Automatically completes skillchecks instantly.",
		commandcat = "Automation",

		encommands = {"enableinstantcalibrationsuccess"},
		enaliases = {"eics"},
		encommanddesc = "Enables instant machine calibration success",

		discommands = {"disableinstantcalibrationsuccess"},
		disaliases = {"dics"},
		discommanddesc = "Disables instant machine calibration success",

		callback = function(state) 
			autocalibration2(state)
		end
	},
	{ type = "input and toggle", title = "Auto escape Squirm", desc = "Automatically frees yourself when you get caught by Twisted Squirm with the set struggle delay.", placeholder = "Delay",
		commandcat = "Automation",

		encommands = {"enableautoescapesquirm"},
		enaliases = {"eaes"},
		encommanddesc = "Enables auto escape Twisted Squirm",

		discommands = {"disableautoescapesquirm"},
		disaliases = {"daes"},
		discommanddesc = "Disables auto escape Twisted Squirm",

		defaulttext = "0.1",
		callback = function(text, state) 
			autoescapewormdelay = text or 0.1
			autoescape(state)
		end
	},
	{ type = "toggle", title = "Auto close pop-ups", desc = "Automatically closes pop-ups that pop up on your screen.",
		commandcat = "Automation",

		encommands = {"enableautoclosepopups"},
		enaliases = {"eacpu"},
		encommanddesc = "Enables auto close pop-ups",

		discommands = {"disableautoclosepopups"},
		disaliases = {"dacpu"},
		discommanddesc = "Disables auto close pop-ups",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Auto vote best card", desc = "Automatically votes for the best card available when card voting.",
		commandcat = "Automation",

		encommands = {"enableautovotebestcard"},
		enaliases = {"eavbc"},
		encommanddesc = "Enables auto vote best card",

		discommands = {"disableautovotebestcard"},
		disaliases = {"davbc"},
		discommanddesc = "Disables auto vote best card",

		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Auto use items", desc = "Automatically uses your item when available.",
		commandcat = "Automation",

		encommands = {"enableautouseitems"},
		enaliases = {"eaui"},
		encommanddesc = "Enables auto use items",

		discommands = {"disableautouseitems"},
		disaliases = {"daui"},
		discommanddesc = "Disables auto use items",

		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Auto use items behavior", desc = "Determines the way your items will be used automatically.", 
		options = {"Instant", "When necessary", "1 second delay"},
		default = "Instant",
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Auto use items blacklist", desc = "Blacklists the selected items from being used automatically.", 
		options = {"Air Horn", "Bandage", "Bonbon", "Bottle o' Pop", "Box o' Chocolates", 
			"Chocolate", "Eject Button", "Extraction Speed Candy", "Gumballs", "Health Kit", 
			"Instructions", "Jawbreaker", "Jumper Cable", "Pop", "Protein Bar", 
			"Skill Check Candy", "Smoke Bomb", "Speed Candy", "Stealth Candy", "Stopwatch", 
			"Valve"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Auto sprint", desc = "Automatically sprints when a Twisted comes close.",
		commandcat = "Automation",

		encommands = {"enableautosprint"},
		enaliases = {"eas"},
		encommanddesc = "Enables auto sprint",

		discommands = {"disableautosprint"},
		disaliases = {"das"},
		discommanddesc = "Disables auto sprint",

		callback = function(state)
		end
	},
	{ type = "slider", title = "Auto sprint Twisted distance", desc = "Sets the distance required for the Twisted to reach toward you to sprint.", min = 5, max = 30, default = 10, step = 1,
		callback = function(value)
		end
	},

	{ type = "separator", title = "Ability" },
	{ type = "toggle", title = "Auto Bassie Bone", desc = "Automatically executes the Bassie + Bone trick.",
		commandcat = "Automation",

		encommands = {"enableautobassiebone"},
		enaliases = {"eabb"},
		encommanddesc = "Enables auto Bassie Bone",

		discommands = {"disableautobassiebone"},
		disaliases = {"dabb"},
		discommanddesc = "Disables auto Bassie Bone",

		callback = function(state)
		end
	},
	{ type = "slider", title = "Auto Bassie Bone delay", desc = "Sets the delay for the auto Bassie Bone (In milliseconds).", min = 5, max = 500, default = 30, step = 5,
		callback = function(value)
		end
	},
	{ type = "button", title = "Manual Bassie Bone", desc = "Uses Bassie's ability to drop an item, and then picks it back up.",
		callback = function()
		end
	},
	{ type = "toggle", title = "Auto use ability", desc = "Automatically uses your ability.",
		commandcat = "Automation",

		encommands = {"enableautouseability"},
		enaliases = {"eaua"},
		encommanddesc = "Enables auto use ability",

		discommands = {"disableautouseability"},
		disaliases = {"daua"},
		discommanddesc = "Disables auto use ability",

		callback = function(state)
		end
	},
	{ type = "dropdown", title = "Auto use ability condition", desc = "Sets the conditions that need to be met in order to automatically use your ability.", 
		options = {"When cooldown ends", "Everyone near elevator", "Near a Twisted", "Near a player", "Near an extracting player", "All Twisteds gathered", "Player near Twisted"},
		default = "When cooldown ends",
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Auto heal nearby players", desc = "Automatically heals nearby players when they are low. Use healer Toons.",
		commandcat = "Automation",

		encommands = {"enableautohealnearby"},
		enaliases = {"eahn"},
		encommanddesc = "Enables auto heal nearby players on low health",

		discommands = {"disableautohealnearby"},
		disaliases = {"dahn"},
		discommanddesc = "Disables auto heal nearby players on low health",

		callback = function(state)
		end
	},
	{ type = "dropdown", title = "Auto heal blacklist", desc = "Blacklsists the target players from auto heal.", 
		playerlist = true,
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "slider", title = "Auto heal health threshold", desc = "Sets the minimum health required to heal a player.", min = 1, max = 3, default = 1, step = 1,
		callback = function(value)
		end
	},
	{ type = "toggle", title = "Auto boost player extraction speed", desc = "Automatically boosts nearby players who are extracting a machine. Use Shelly.",
		commandcat = "Automation",

		encommands = {"enableautohealnearby"},
		enaliases = {"eahn"},
		encommanddesc = "Enables auto boost nearby players who are extracting a machine",

		discommands = {"disableautohealnearby"},
		disaliases = {"dahn"},
		discommanddesc = "Disables auto boost nearby players who are extracting a machine",

		callback = function(state)
		end
	},
	{ type = "dropdown", title = "Auto boost player extraction speed blacklist", desc = "Blacklsists the target players from auto boost player extraction speed.", 
		playerlist = true,
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Auto grapple onto machines", desc = "Automatically grapples onto a machine. Use Scraps.",
		commandcat = "Automation",

		encommands = {"enableautograppleontomachine"},
		enaliases = {"eagom"},
		encommanddesc = "Enables auto grapple onto a nearby machine",

		discommands = {"disableautograppleontomachine"},
		disaliases = {"dagom"},
		discommanddesc = "Disables auto grapple onto a nearby machine",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto grapple onto player", desc = "Automatically grapples onto another player when necessary. Use Scraps.",
		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto grab player", desc = "Automatically grabs another player to you when necessary. Use Goob.",
		callback = function(state)
		end
	},

	{ type = "separator", title = "Utility" },
	{ type = "dropdown", title = "Perform actions trigger", desc = "Performs the automated actions when the selected event is triggered.", 
		options = {"Map fully loaded", "On floor start", "On panic mode"},
		default = "Map fully loaded",
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Auto pick up all items", desc = "Automatically picks up every item on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupallitems"},
		enaliases = {"eapuai"},
		encommanddesc = "Enables auto pick up all items",

		discommands = {"disableautopickupallitems"},
		disaliases = {"dapuai"},
		discommanddesc = "Disables auto pick up all items",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto pick up all event items", desc = "Automatically picks up every event item / currency on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupalleventitems"},
		enaliases = {"eapuaei"},
		encommanddesc = "Enables auto pick up all event items",

		discommands = {"disableautopickupalleventitems"},
		disaliases = {"dapuaei"},
		discommanddesc = "Disables auto pick up all event items",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto pick up all Research Capsules", desc = "Automatically picks up every Research Capsule on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupallcapsules"},
		enaliases = {"eapuac"},
		encommanddesc = "Enables auto pick up all Research Capsules",

		discommands = {"disableautopickupallcapsules"},
		disaliases = {"dapuac"},
		discommanddesc = "Disables auto pick up all Research Capsules",
		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto pick up all Tapes", desc = "Automatically picks up every Tape on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupalltapes"},
		enaliases = {"eapuat"},
		encommanddesc = "Enables auto pick up all Tapes",

		discommands = {"disableautopickupalltapes"},
		disaliases = {"dapuat"},
		discommanddesc = "Disables auto pick up all Tapes",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto pick up all heals", desc = "Automatically picks up all the heals on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupallheals"},
		enaliases = {"eapuah"},
		encommanddesc = "Enables auto pick up all heals",

		discommands = {"disableautopickupallheals"},
		disaliases = {"dapuah"},
		discommanddesc = "Disables auto pick up all heals",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto pick up all extraction items", desc = "Automatically picks up every extraction item on the floor.",
		commandcat = "Automation",

		encommands = {"enableautopickupallextractionitems"},
		enaliases = {"eapuaexi"},
		encommanddesc = "Enables auto pick up all extraction items",

		discommands = {"disableautopickupallextractionitems"},
		disaliases = {"dapuaexi"},
		discommanddesc = "Disables auto pick up all extraction items",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto encounter Twisteds", desc = "Automatically encounters every Twisted in the floor.",
		commandcat = "Automation",

		encommands = {"enableautoencountertwisteds"},
		enaliases = {"eaet"},
		encommanddesc = "Enables auto encounter Twisteds",

		discommands = {"disableautoencountertwisteds"},
		disaliases = {"daet"},
		discommanddesc = "Disables auto encounter Twisteds",

		callback = function(state)
		end
	},

	{ type = "separator", title = "Lobby" },
	{ type = "toggle", title = "Auto join run", desc = "Automatically joins an available run.",
		commandcat = "Automation",

		encommands = {"enableautojoinrun"},
		enaliases = {"eajr"},
		encommanddesc = "Enables auto join run",

		discommands = {"disableautojoinrun"},
		disaliases = {"dajr"},
		discommanddesc = "Disables auto join run",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto join solo run", desc = "Automatically joins an empty elevator.",
		commandcat = "Automation",

		encommands = {"enableautojoinsolorun"},
		enaliases = {"eajsr"},
		encommanddesc = "Enables auto join solo run",

		discommands = {"disableautojoinsolorun"},
		disaliases = {"dajsr"},
		discommanddesc = "Disables auto join solo run",

		callback = function(state)
		end
	},
	{ type = "toggle", title = "Auto join matchmaker run", desc = "Automatically joins a matchmaker run.",
		commandcat = "Automation",

		encommands = {"enableautojoinmatchmakerrun"},
		enaliases = {"eajmmr"},
		encommanddesc = "Enables auto join matchmaker run",

		discommands = {"disableautojoinmatchmakerrun"},
		disaliases = {"dajmmr"},
		discommanddesc = "Disables auto join matchmaker run",

		callback = function(state)
		end
	},
	{ type = "input and toggle", title = "Auto join run with queue amount", desc = "Automatically joins an elevator with the target amount of players in the queue.", placeholder = "Count",
		commandcat = "Automation",

		encommands = {"enableautojoinrunwithqueuecount [num]"},
		enaliases = {"eajrwqc [num]"},
		encommanddesc = "Enables auto join elevator with the target amount of players in the queue",

		discommands = {"disableautojoinrunwithqueuecount"},
		disaliases = {"dajrwqc"},
		discommanddesc = "Disables auto join elevator with the target amount of players in the queue",

		callback = function(text, state) 
		end
	},

	{ type = "separator", title = "Distracting" },
	{ type = "toggle", title = "Orbit distract", desc = "Makes you walk around a circular path.",
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Orbit distract path toggle", desc = "Toggles the visibility of the path you will walk on.",
		callback = function(state) 
		end
	},
	{ type = "slider", title = "Orbit distract path X radius", desc = "Sets the X radius of the orbit path.", min = 0, max = 50, default = 7, step = 1,
		callback = function(value)
		end
	},
	{ type = "slider", title = "Orbit distract path Z radius", desc = "Sets the Z radius of the orbit path.", min = 0, max = 50, default = 7, step = 1,
		callback = function(value)
		end
	},
	{ type = "toggle", title = "Kite distract", desc = "Makes you walk around a small island or a group of objects.",
		callback = function(state) 
		end
	},
	{ type = "toggle", title = "Kite distract island target toggle", desc = "Toggles the visibility of the indicator showing which island you will walk around.",
		callback = function(state) 
		end
	},

	{ type = "separator", title = "Webhook" },
	{ type = "input", title = "Webhook URL", desc = "Input your Webhook URL to send logs from.", placeholder = "URL",
		callback = function(text) 
		end
	},
	{ type = "dropdown", title = "Webhook action triggers", desc = "Sets the actions you want to be logged via Webhook.", 
		options = {"Machines left", "Floor cleared", "MVP", "Twisted MVP", "Player damaged", "Player died", "Dandy's stock", "Twisteds on floor", "Items on floor"},
		default = {"Machines left", "Floor cleared", "Player damaged", "Player died", "Dandy's stock", "Twisteds on floor", "Items on floor"},
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
		end 
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
