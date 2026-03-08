--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Automation section)

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
local rst = FindFirstChildOfClass(game, "ReplicatedStorage")
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local fireproximityprompt = (syn and syn.fireproximityprompt) or fireproximityprompt
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

local autoteleporttoelevatorconditions = {"Instant"}
local autoteleporttoelevatorconn
local autoteleportingtoelevator = false

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
	autoteleportingtoelevator = state

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

		if table.find(autoteleporttoelevatorconditions, "Instant") or #autoteleporttoelevatorconditions == 0 then
			toelevator(nil, "tp")

		elseif table.find(autoteleporttoelevatorconditions, "Everyone at elevator") then
			spwn(function()
				while autoteleportingtoelevator and panic.Value do
					if checkeveryoneatelevaor() then
						toelevator(nil, "tp")
						break
					end
					t()
				end
			end)

		elseif table.find(autoteleporttoelevatorconditions, "At the last second") then
			spwn(function()
				while autoteleportingtoelevator and panic.Value do
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
					firesignal(menu.Calibrate.Activated)
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
				local menu = env.stuf.plrgui.ScreenGui:FindFirstChild("Menu")
				
				firesignal(menu.Calibrate.MouseButton1Down)
				firesignal(menu.Calibrate.MouseButton1Up)
				firesignal(menu.Calibrate.MouseButton1Click)
				firesignal(menu.Calibrate.Activated)
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
			oldskillcheckinvoc = getcallbackvalue(rst.Events.SkillcheckUpdate, "OnClientInvoke") 
		else 
			oldskillcheckinvoc = nil 
		end 
	end
end)

function autocalibration2(state)
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

					local tween = ts:Create(a.Menu.SkillCheckMessage, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {TextTransparency = 1,TextStrokeTransparency = 1})
					tween:Play()
					tween.Completed:Wait()
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

local function yield(this)
	repeat t() until this()
end

local autoteleporttomachineconditions = {"Extraction start"}
local autoteleportingtomachineconn
local autoteleportingtomachine = false
local autoteleporttomachineconns = {}

local function autoteleporttomachine(state)
	autoteleportingtomachine = state

	if not state then
		for _, conn in ipairs(autoteleporttomachineconns) do
			conn:Disconnect()
		end
		autoteleporttomachineconns = {}
		if autoteleportingtomachineconn then
			autoteleportingtomachineconn:Disconnect()
			autoteleportingtomachineconn = nil
		end
		return
	end

	if autoteleportingtomachineconn then return end

	local conditions = autoteleporttomachineconditions

	local function doteleport()
		env.funcs.tomachine("tp")
	end

	if table.find(conditions, "Extraction start") then
		local conn = env.stuf.char:FindFirstChild("Decoding").Changed:Connect(function(val)
			if val then doteleport() end
		end)
		table.insert(autoteleporttomachineconns, conn)
	end

	if table.find(conditions, "Extraction end") then
		local conn = env.stuf.char:FindFirstChild("Decoding").Changed:Connect(function(val)
			if not val then doteleport() end
		end)
		table.insert(autoteleporttomachineconns, conn)
	end

	if table.find(conditions, "On floor start") then
		local conn = env.stuf.gameinfo:FindFirstChild("FloorActive").Changed:Connect(function(val)
			if val then
				yield(function() return not env.stuf.actionqueuerunning end)
				doteleport()
			end
		end)
		table.insert(autoteleporttomachineconns, conn)
	end

	if table.find(conditions, "Map fully loaded") then
		local conn = env.stuf.roomfolder.ChildAdded:Connect(function()
			yield(function() return env.funcs.getgamestat("message"):find("Doors open") end)
			yield(function() return not env.stuf.actionqueuerunning end)
			doteleport()
		end)
		table.insert(autoteleporttomachineconns, conn)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local autoclosepopupsconn = nil

local function autoclosepopups(state)
	if state then
		local a = env.stuf.plrgui:FindFirstChild("ScreenGui")
		if not autoclosepopupsconn then
			autoclosepopupsconn = a.ChildAdded:Connect(function()
				t(math.random(1/15, 1))
				local popup = a:FindFirstChild("TemporaryPopUp", true)
				if popup then
					env.essentials.library.clik()
					popup:Destroy()
				end
			end)
		end
	else
		if autoclosepopupsconn then
			autoclosepopupsconn:Disconnect() 
			autoclosepopupsconn = nil
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local autovotebestcardenabled = false
local autovotebestcardpriority = {
	"Machine", "Stamina", "ItemRarity", "MonsterPanicReduction", "GlowLight",
	"AbilityCooldown", "RandomItem", "SurvivalPoint", "Elevator",
	"DandyDiscount", "PipingTape", "DyleFloor"
}

local function votebest()
	local voter = env.stuf.gameinfo.CardVote
	local event = rst.Events.CardVoteEvent

	local function fire(name)
		spwn(function()
			for _, suffix in ipairs({"", "2"}) do
				local c = voter:FindFirstChild(name .. suffix)
				if c then event:FireServer(c) end
			end
		end)
	end

	for _, name in ipairs(autovotebestcardpriority) do
		fire(name)
	end

	spwn(function()
		local lowhealth = false
		for _, p in ipairs(plrs:GetPlayers()) do
			local h = p.Character and p.Character:FindFirstChildOfClass("Humanoid")
			if h and h.Health < 2 then lowhealth = true break end
		end
		if lowhealth then
			for _, suffix in ipairs({"", "2"}) do
				local c = voter:FindFirstChild("Heal" .. suffix)
				if c then event:FireServer(c) end
			end
		end
	end)
end

local function monitorcards()
	local voter = env.stuf.gameinfo.CardVote

	local function tryvote()
		if not autovotebestcardenabled or alreadyVoted then return end
		task.delay(1, function()
			if not autovotebestcardenabled or alreadyVoted then return end
			if #voter:GetChildren() > 0 then
				votebest()
				alreadyVoted = true
			end
		end)
	end

	voter.ChildAdded:Connect(tryvote)
	voter.ChildRemoved:Connect(function()
		if #voter:GetChildren() == 0 then alreadyVoted = false end
	end)
	if #voter:GetChildren() > 0 then tryvote() end
end

local function autovotebestcard(state)
	if not env.stuf.inrun then return end
	autovotebestcardenabled = state
	alreadyVoted = false
	if state then spwn(monitorcards) end
end

-------------------------------------------------------------------------------------------------------------------------------

local autousingitems = false
local autouseitemsthread = nil
local autouseitemsconns = {}
local autouseitemsbehavior = "Instant"
local autouseitemsblacklist = {}

local autouseitmsnamemap = {
	["Air Horn"]               = "AirHorn",
	["Bandage"]                = "Bandage",
	["Bonbon"]                 = "Bonbon",
	["Bottle o' Pop"]          = "PopBottle",
	["Box o' Chocolates"]      = "ChocolateBox",
	["Chocolate"]              = "Chocolate",
	["Eject Button"]           = "EjectButton",
	["Extraction Speed Candy"] = "ExtractionSpeedCandy",
	["Gumballs"]               = "Gumballs",
	["Health Kit"]             = "HealthKit",
	["Instructions"]           = "Instructions",
	["Jawbreaker"]             = "Jawbreaker",
	["Jumper Cable"]           = "JumperCable",
	["Pop"]                    = "Pop",
	["Protein Bar"]            = "ProteinBar",
	["Skill Check Candy"]      = "SkillCheckCandy",
	["Smoke Bomb"]             = "SmokeBomb",
	["Speed Candy"]            = "SpeedCandy",
	["Stealth Candy"]          = "StealthCandy",
	["Stopwatch"]              = "Stopwatch",
	["Valve"]                  = "Valve",
}

local autouseitemcats = {
	onmachine = {
		"ExtractionSpeedCandy", "SkillCheckCandy", "Valve", "JumperCable",
		"StealthCandy", "Jawbreaker", "Gumballs", "Instructions",
	},
	heal = {
		"Bandage", "HealthKit",
	},
	speed = {
		"SpeedCandy", "EjectButton", "Chocolate", "SmokeBomb", "Gumballs",
	},
	stamina = {
		"StaminaCandy", "Pop", "PopBottle", "ProteinBar",
	}
}

local function getitemslot(stats, itemname)
	for i = 1, 4 do
		if stats["slot" .. i] == itemname then
			return i
		end
	end
end

local function tryuseitem(stats)
	local extracting = stats.extracting
	local twistedschasing = stats.twistedschasing or 0
	local health = env.stuf.char:FindFirstChildOfClass("Humanoid").Health
	local lowhealth = health <= 1

	local priority = {}

	if extracting and not env.funcs.veemoteactive() then
		for _, item in ipairs(autouseitemcats.onmachine) do table.insert(priority, item) end
	end
	if lowhealth then
		for _, item in ipairs(autouseitemcats.heal) do table.insert(priority, item) end
	end
	if twistedschasing > 0 then
		for _, item in ipairs(autouseitemcats.stamina) do table.insert(priority, item) end
	end

	for _, itemname in ipairs(priority) do
		if autouseitemsblacklist[itemname] then continue end
		if (itemname == "HealthKit" or itemname == "Bandage") and not lowhealth then continue end
		local slot = getitemslot(stats, itemname)
		if slot then
			env.funcs.useitem(slot)
			return
		end
	end
end

local function onInventoryChanged()
	t(0.1)
	if not autousingitems then return end
	local stats = env.funcs.getstats("player", env.stuf.char)
	if not stats then return end

	local behavior = autouseitemsbehavior

	if behavior == "Instant" then
		tryuseitem(stats)

	elseif behavior == "When necessary" then
		local extracting = stats.extracting
		local twistedschasing = (stats.twistedschasing or 0) > 0
		local lowhealth = env.stuf.char:FindFirstChildOfClass("Humanoid").Health <= 1
		if extracting or twistedschasing or lowhealth then
			tryuseitem(stats)
		end

	elseif behavior == "1 second delay" then
		task.delay(1, function()
			if not autousingitems then return end
			local freshstats = env.funcs.getstats("player", env.stuf.char)
			if freshstats then tryuseitem(freshstats) end
		end)
	end
end

local function autouseitems(state)
	autousingitems = state

	for _, conn in ipairs(autouseitemsconns) do conn:Disconnect() end
	autouseitemsconns = {}

	if not state then return end

	local inventory = env.stuf.char:FindFirstChild("Inventory")
	if inventory then
		for i = 1, 4 do
			local slot = inventory:FindFirstChild("Slot" .. i)
			if slot then
				table.insert(autouseitemsconns, slot.Changed:Connect(onInventoryChanged))
			end
		end
	end

	table.insert(autouseitemsconns, rst.StoryEvents.Spotted.OnClientEvent:Connect(function()
		if not autousingitems then return end
		local stats = env.funcs.getstats("player", env.stuf.char)
		if not stats then return end
		for _, itemname in ipairs(autouseitemcats.speed) do
			if autouseitemsblacklist[itemname] then continue end
			local slot = getitemslot(stats, itemname)
			if slot then
				env.funcs.useitem(slot)
				return
			end
		end
	end))
end

-------------------------------------------------------------------------------------------------------------------------------

local sprinttapdistance = 20
local sprinttappingenabled = false
local sprinttappingthread = nil
local sprinttappingconn = nil

local function sprinttap()
	if sprinttappingthread then return end
	sprinttappingthread = spwn(function()
		local sprintEvent = rst.Events.SprintEvent
		local sprinting = false

		while sprinttappingenabled and env.funcs.getgamestat("flooractive") and env.stuf.twisteds do
			local nearestMonster = nil
			local nearestDist = math.huge

			for _, monster in pairs(env.stuf.twisteds:GetChildren()) do
				if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
					local dist = (env.funcs.getstats("twisted", monster).troot.Position - env.stuf.root.Position).Magnitude
					if dist < nearestDist then
						nearestDist = dist
						nearestMonster = monster
					end
				end
			end

			if nearestMonster and nearestDist <= sprinttapdistance then
				if not sprinting then
					sprinting = true
					if env.stuf.infinitestaminaenabled then
						env.funcs.infstamsprinting()
					else
						sprintEvent:FireServer(true)
					end
				end
			else
				if sprinting then
					sprinting = false
					if env.stuf.infinitestaminaenabled then
						env.funcs.infstamwalking()
					else
						sprintEvent:FireServer(false)
					end
				end
			end

			t()
		end

		if sprinting then
			if env.stuf.infinitestaminaenabled then
				env.funcs.infstamwalking()
			else
				sprintEvent:FireServer(false)
			end
		end

		sprinttappingthread = nil
	end)
end

local function sprinttapping(state)
	if state then
		if not sprinttappingenabled then
			sprinttappingenabled = true
			spwn(sprinttap)

			sprinttappingconn = env.stuf.gameinfo.FloorActive.Changed:Connect(function(active)
				if not sprinttappingenabled then return end

				if active then
					sprinttap()
				else
					if sprinttappingthread then
						sprinttappingthread = nil
					end
				end
			end)
		end
	else
		if sprinttappingenabled then
			sprinttappingenabled = false
			if sprinttappingconn then sprinttappingconn:Disconnect() sprinttappingconn = nil end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local bassieboneenabled = false
local bassiebonedelay = 0.5
local bassieboneconn = nil

local function fireprompts()
	t()
	for _, item in ipairs(env.stuf.items:GetChildren()) do
		fireproximityprompt(item.Prompt:FindFirstChildOfClass("ProximityPrompt"))
	end
end

local function bassiebone(looped)
	local function bas()
		local one = {
			env.stuf.char,
			CFrame.new(-98.01789, 145.92488, 137.47554, -0.91248, 0, 0.40912, 0, 1, 0, -0.40912, 0, -0.91248),
			false
		}
		rst.Events.AbilityEvent:InvokeServer(unpack(one))

		local two = {
			env.stuf.char,
			env.stuf.char.Inventory:WaitForChild("Slot1")
		}
		rst.Events.ItemEvent:InvokeServer(unpack(two))

		if looped then t(bassiebonedelay) end
	end

	if looped then
		while bassieboneenabled do bas() end
	else
		bas()
	end
end

local function autobassiebone(state)
	if state then
		if bassieboneconn then bassieboneconn:Disconnect() end
		yield(function() return env.stuf.items end)

		bassieboneconn = env.stuf.items.ChildAdded:Connect(fireprompts)

		bassieboneenabled = true
		spwn(function() bassiebone(true) end)
	else
		bassieboneenabled = false

		if bassieboneconn then
			bassieboneconn:Disconnect()
			bassieboneconn = nil
		end
	end
end

local function dobassieboneonce()
	if bassieboneconn then return end
	bassieboneconn = env.stuf.items.ChildAdded:Connect(fireprompts)
end

-------------------------------------------------------------------------------------------------------------------------------

local autouseabilityconn = nil
local autouseabilityconditions = {"When cooldown ends"}

local function fireability() 
	rst.Events.AbilityEvent:InvokeServer(env.stuf.char, CFrame.new(-740, 99, 100, 1, 0, 0, 0, 1, 0, 0, 0, 1), false) 
end

local function enableautouseability()
	if autouseabilityconn then return end

	local abilfolder = env.stuf.char:FindFirstChild("Abilities")
	local abilcd

	if abilfolder then
		for _, ability in pairs(abilfolder:GetChildren()) do
			if ability:FindFirstChild("Cooldown") then
				abilcd = ability.Cooldown
			end
		end
	end

	if abilcd then
		autouseabilityconn = abilcd.Changed:Connect(function(v)
			if v == 0 then
				fireability()
			end
		end)
	end
end

local function disableautouseability()
	if autouseabilityconn then
		autouseabilityconn:Disconnect()
		autouseabilityconn = nil
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local performactionstriggers = {"Map fully loaded"}
local actionqueue = {}
env.stuf.actionqueuerunning = false

local autoactions = {
	autopickupallitems = { enabled = false, conns = {}, func = function() env.funcs.pickupallitems() end },
	autopickupallcapsules = { enabled = false, conns = {}, func = function() env.funcs.pickupallcapsules() end },
	autopickupalltapes = { enabled = false, conns = {}, func = function() env.funcs.pickupalltapes() end },
	autopickupallheals = { enabled = false, conns = {}, func = function() env.funcs.pickupallheals() end },
	autopickupallextitems = { enabled = false, conns = {}, func = function() env.funcs.pickupallextitems() end },
	autopickupalleventitems = { enabled = false, conns = {}, func = function() env.funcs.pickupalleventitems() end },
	autoencountertwisteds = { enabled = false, conns = {}, func = function() env.funcs.encountertwisteds() end },
}

local function processqueue()
	if env.stuf.actionqueuerunning then return end
	env.stuf.actionqueuerunning = true
	spwn(function()
		while #actionqueue > 0 do
			local nextact = table.remove(actionqueue, 1)
			nextact()
			t(0.1)
		end
		env.stuf.actionqueuerunning = false
	end)
end

local function enqueue(fn)
	table.insert(actionqueue, fn)
	processqueue()
end

local function hookaction(action)
	for _, conn in ipairs(action.conns) do conn:Disconnect() end
	action.conns = {}

	if not action.enabled then return end

	local function try()
		if not action.enabled then return end
		enqueue(action.func)
	end

	if table.find(performactionstriggers, "Map fully loaded") then
		table.insert(action.conns, env.stuf.roomfolder.ChildAdded:Connect(function()
			yield(function() return env.funcs.getgamestat("message"):find("Doors open") end)
			try()
		end))
	end

	if table.find(performactionstriggers, "On floor start") then
		table.insert(action.conns, env.stuf.gameinfo.FloorActive.Changed:Connect(function(val)
			if val then try() end
		end))
	end

	if table.find(performactionstriggers, "On panic mode") then
		table.insert(action.conns, env.stuf.gameinfo.Panic.Changed:Connect(function(val)
			if val then try() end
		end))
	end
end

local function maketoggles()
	for name, action in pairs(autoactions) do
		env.funcs[name] = function(state)
			action.enabled = state
			hookaction(action)
		end
	end
end
maketoggles()

local function autopickupallitems(state) autoactions.autopickupallitems.enabled = state hookaction(autoactions.autopickupallitems) end
local function autopickupallcapsules(state)autoactions.autopickupallcapsules.enabled = state hookaction(autoactions.autopickupallcapsules) end
local function autopickupalltapes(state)autoactions.autopickupalltapes.enabled = state hookaction(autoactions.autopickupalltapes) end
local function autopickupallheals(state) autoactions.autopickupallheals.enabled = state hookaction(autoactions.autopickupallheals) end
local function autopickupallextitems(state) autoactions.autopickupallextitems.enabled = state hookaction(autoactions.autopickupallextitems) end
local function autopickupalleventitems(state) autoactions.autopickupalleventitems.enabled = state hookaction(autoactions.autopickupalleventitems) end
local function autoencountertwisteds(state) autoactions.autoencountertwisteds.enabled = state hookaction(autoactions.autoencountertwisteds) end

-------------------------------------------------------------------------------------------------------------------------------

env.stuf.afe = {
	running = false,
	priority = {},
	maxitemcap = 2,
	itemmaxdist = 0,
	machmaxdist = 0,
	preset = {"Default"},
	actiontrigger = {"Map fully loaded"},
	actions = {
		"Auto pick up all items", 
		"Auto pick up all event items", 
		"Auto pick up all Research Capsules",
		"Auto pick up all Tapes", 
		"Auto pick up all heals", 
		"Auto pick up all extraction items", 
		"Auto encounter Twisteds",
		"Auto buy items"
	},

	conns = {}
}

local function autofarm(state)
	env.stuf.afe.running = state

	if state then
		env.essentials.library.update("Auto teleport to elevator", true)
		env.essentials.library.update("Auto teleport to elevator condition", {"Instant"})

		env.essentials.library.update("Auto teleport to machine", true)
		env.essentials.library.update("Auto teleport to machine condition", {"Extraction start", "Map fully loaded"})

		env.essentials.library.update("Instant calibration success", true)
		env.essentials.library.update("Auto escape Squirm", true)
		env.essentials.library.update("Auto vote best card", true)

		env.essentials.library.update("Auto use items", true)
		env.essentials.library.update("Auto use items behavior", {"When necessary"})

		env.essentials.library.update("Auto pick up all Research Capsules", true)
		env.essentials.library.update("Auto pick up all Tapes", true)
		env.essentials.library.update("Auto pick up all heals", true)
		env.essentials.library.update("Auto pick up all extraction items", true)
		env.essentials.library.update("Auto encounter Twisteds", true)
		env.essentials.library.update("Perform actions trigger", env.stuf.afe.actiontrigger)
		t(0.1)
		env.funcs.tomachine("tp")

		local spottedconn = rst.StoryEvents.Spotted.OnClientEvent:Connect(function()
			if env.stuf.actionqueuerunning then return end
			toelevator(true, "tp") t(2)
			env.funcs.tomachine("tp")

			task.delay(2, function()
				if not env.funcs.getstats("player", env.stuf.char).extracting then
					t(5)
					env.funcs.tomachine("tp")
				end
			end)
		end)
		table.insert(env.stuf.afe.conns, spottedconn)
	else
		for _, conn in ipairs(env.stuf.afe.conns) do
			conn:Disconnect()
			conn = nil
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Autofarming" },
	{ type = "toggle", title = "Toggle autofarm", desc = "Toggles the autofarm. Turning on any functions that modify or adjust the player's behavior may result in conflicts.",
		callback = function(state) 
			env.stuf.afe.running = state
			autofarm(state)
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
			performactionstriggers = selected
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
		default = autoteleporttoelevatorconditions,
		canbeempty = false,

		callback = function(selected)
			autoteleporttoelevatorconditions = selected
			if autoteleportingtoelevator then
				autoteleporttoelevator(false)
				autoteleporttoelevator(true)
			end
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
			autoteleporttomachine(state)
		end
	},
	{ type = "dropdown", title = "Auto teleport to machine condition", desc = "Sets the condition that has to be followed before automatically teleporting to a random machine.", 
		options = {"Extraction start", "Extraction end", "On floor start", "Map fully loaded"},
		default = autoteleporttomachineconditions,
		canbeempty = false,
		multiselect = true,

		callback = function(selected) 
			autoteleporttomachineconditions = selected
			if autoteleportingtomachine then
				autoteleporttomachine(false)
				autoteleporttomachine(true)
			end
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
			autoclosepopups(state)
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
			autovotebestcard(state)
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
			autouseitems(state)
		end
	},
	{ type = "dropdown", title = "Auto use items behavior", desc = "Determines the way your items will be used automatically.", 
		options = {"Instant", "When necessary", "1 second delay"},
		default = "Instant",
		canbeempty = false,
		
		callback = function(selected)
			autouseitemsbehavior = selected
			if autousingitems then
				autouseitems(false)
				autouseitems(true)
			end
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
			autouseitemsblacklist = {}
			for _, label in ipairs(selected) do
				local mapped = autouseitmsnamemap[label] or label
				autouseitemsblacklist[mapped] = true
			end
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
			sprinttapping(state)
		end
	},
	{ type = "slider", title = "Auto sprint Twisted distance", desc = "Sets the distance required for the Twisted to reach toward you to sprint.", min = 5, max = 30, default = 10, step = 1,
		callback = function(value)
			if value and value > 0 then
				sprinttapdistance = value
				if sprinttappingenabled then sprinttapping(false) sprinttapping(true) end
			end
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
			autobassiebone(state)
		end
	},
	{ type = "slider", title = "Auto Bassie Bone delay", desc = "Sets the delay for the auto Bassie Bone (In milliseconds).", min = 5, max = 500, default = 30, step = 5,
		callback = function(value)
			bassiebonedelay = value
			if bassieboneenabled then
				autobassiebone(false)
				autobassiebone(true)
			end
		end
	},
	{ type = "button", title = "Manual Bassie Bone", desc = "Uses Bassie's ability to drop an item, and then picks it back up.",
		callback = function()
			dobassieboneonce()
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
		default = autouseabilityconditions,
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
			performactionstriggers = selected
			for _, action in pairs(autoactions) do
				if action.enabled then hookaction(action) end
			end
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
			autopickupallitems(state)
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
			autopickupallcapsules(state)
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
			autopickupalltapes(state)
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
			autopickupallheals(state)
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
			autopickupallextitems(state)
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
			autopickupalleventitems(state)
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
			autoencountertwisteds(state)
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
