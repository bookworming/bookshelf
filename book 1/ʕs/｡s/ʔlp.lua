--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Local Player section)

---------------------------------------------------------------------------------------------------------------------------]]--

local version = 3

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ws = FindFirstChildOfClass(game, "Workspace")
local uis = FindFirstChildOfClass(game, "UserInputService")
local rst = FindFirstChildOfClass(game, "ReplicatedStorage")
local rs = FindFirstChildOfClass(game, "RunService")
local vim = game:GetService("VirtualInputManager") -- cant use findfirstchildofclass for this one
local plrs = FindFirstChildOfClass(game, "Players")

local getgenv = getgenv() or _G
local firesignal = (syn and syn.firesignal) or firesignal
local cloneref = (syn and syn.cloneref) or cloneref
local queueotp = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local hiddenui = (syn and syn.gethui) or gethui() or FindFirstChildOfClass(game, "CoreGui")
local fireproximityprompt = (syn and syn.fireproximityprompt) or fireproximityprompt
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
	if result and result.Instance and result.Instance:IsA("BasePart") and result.Instance.Name ~= "plz dont clip through this plz plz" then
		return result.Instance
	end
	return nil
end

function gtp()
	local touching = {}
	for _, part in ipairs(env.stuf.char:GetDescendants()) do
		if part:IsA("BasePart") and part.CanTouch then
			for _, p in ipairs(part:GetTouchingParts()) do
				if not p:IsDescendantOf(env.stuf.char) and p.Name ~= "plz dont clip through this plz plz" then
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
	if noclipconn then noclipconn:Disconnect() noclipconn = nil end

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

-- the code for this looks abnormally large
infinitestaminasprinttoggled = false
infinitestaminaconnections = {}
env.stuf.infinitestaminaenabled = false
infinitestaminachangedconnection = nil
infstamspeedloop = nil
infstamsprintstatloop = nil
infstambuttonimageloop = nil
showactualstamina = false

function infstamfetchspeed(mode)
	if not env.stuf.plrstats then return env.stuf.hum.WalkSpeed end

	if mode == "Run" then
		local base = env.stuf.plrstats:FindFirstChild("RunSpeed")
		local mod = env.stuf.plrstats:FindFirstChild("RunSpeedModifier")
		if base and mod then return base.Value * mod.Value end
	elseif mode == "Walk" then
		local base = env.stuf.plrstats:FindFirstChild("WalkSpeed")
		local mod = env.stuf.plrstats:FindFirstChild("SpeedModifier")
		if base and mod then return base.Value * mod.Value end
	end

	return env.stuf.hum.WalkSpeed
end

function setsprinting(value)
	if not env.stuf.plrstats then return false end

	local sprintStat = env.stuf.plrstats:FindFirstChild("Sprinting")
	if not sprintStat then
		return false
	end

	sprintStat.Value = value
	return true
end

function updsprintbtnimg(o)
	local screenGui = env.stuf.plrgui:WaitForChild("ScreenGui")
	local button = screenGui:FindFirstChild("MobileRun")

	if button then
		local image1 = "rbxassetid://11866517702" -- walk
		local image2 = "rbxassetid://11866539249" -- run

		if o then button.Image = image1 return end
		if infinitestaminasprinttoggled then
			button.Image = image2
		else
			button.Image = image1
		end
	end
end

function startsprintbtnimgloop()
	if infstambuttonimageloop then return end

	infstambuttonimageloop = rs.Heartbeat:Connect(function()
		if env.stuf.infinitestaminaenabled then
			updsprintbtnimg()
		end
	end)
end

function stopsprintbtnimgloop() 
	if infstambuttonimageloop then 
		infstambuttonimageloop:Disconnect() 
		infstambuttonimageloop = nil 
	end 
	updsprintbtnimg(true) 
end

function startsprintingloop()
	if infstamsprintstatloop then return end

	infstamsprintstatloop = rs.Heartbeat:Connect(function()
		if infinitestaminasprinttoggled then
			local success = setsprinting(true)
			if not success then
				stopsprintingloop()
			end
		end
	end)
end

function stopsprintingloop() if infstamsprintstatloop then infstamsprintstatloop:Disconnect() infstamsprintstatloop = nil end end

function startinfstamrunspeedloop()
	if infstamspeedloop then return end

	infstamspeedloop = rs.Heartbeat:Connect(function()
		if infinitestaminasprinttoggled then
			env.stuf.hum.WalkSpeed = infstamfetchspeed("Run")
		end
	end)
end

function stopinfstamrunspeedloop() if infstamspeedloop then infstamspeedloop:Disconnect() infstamspeedloop = nil end end

function startupdstaminaloop()
	if infinitestaminachangedconnection then return end

	local cs = env.stuf.plrstats:FindFirstChild("CurrentStamina")
	local ms = env.stuf.plrstats:FindFirstChild("Stamina")
	if cs and ms then
		infinitestaminachangedconnection = cs.Changed:Connect(function()
			cs.Value = ms.Value
		end)
		cs.Value = ms.Value
	end
end

function stopupdstaminaloop() if infinitestaminachangedconnection then infinitestaminachangedconnection:Disconnect() infinitestaminachangedconnection = nil end end
function infstamfiresprintevent(state) local spr = hiddenui:FindFirstChild("SprintEvent")  or rst.Events:FindFirstChild("SprintEvent") if spr then spr:FireServer(state) end end
function infstamapplywalkspeed() env.stuf.hum.WalkSpeed = infstamfetchspeed("Walk") end
function infstamapplyrunspeed() env.stuf.hum.WalkSpeed = infstamfetchspeed("Run") end

function env.funcs.infstamsprinting()
	infinitestaminasprinttoggled = true

	if env.stuf.infinitestaminaenabled then
		if showactualstamina then
			-- inf and showac
			setsprinting(true)
			infstamfiresprintevent(true)
			startsprintingloop()
			startinfstamrunspeedloop()
		else
			-- inf
			startinfstamrunspeedloop()
			setsprinting(true)
			startsprintingloop()
		end
	else
		infstamfiresprintevent(true)
		setsprinting(true)
		infstamapplyrunspeed()
	end
end

function env.funcs.infstamwalking()
	infinitestaminasprinttoggled = false

	if env.stuf.infinitestaminaenabled then
		if showactualstamina then
			infstamfiresprintevent(false)
			stopsprintingloop()
			stopinfstamrunspeedloop()
			setsprinting(false)
			infstamapplywalkspeed()
		else
			stopinfstamrunspeedloop()
			setsprinting(false)
			infstamapplywalkspeed()
		end
	else
		infstamfiresprintevent(false)
		setsprinting(false)
		infstamapplywalkspeed()
	end
end

function setuppcinfstam()
	for _, conn in ipairs(infinitestaminaconnections) do
		if conn.Disconnect then conn:Disconnect() end
	end
	table.clear(infinitestaminaconnections)

	table.insert(infinitestaminaconnections, uis.InputBegan:Connect(function(input, gameProcessed)
		if input.KeyCode == Enum.KeyCode.LeftShift and not gameProcessed then
			env.funcs.infstamsprinting()
		end
	end))

	table.insert(infinitestaminaconnections, uis.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift then
			env.funcs.infstamwalking()
		end
	end))
end

function setupmobileinfstam()
	for _, conn in ipairs(infinitestaminaconnections) do
		if conn.Disconnect then conn:Disconnect() end
	end
	table.clear(infinitestaminaconnections)

	local screenGui = env.stuf.plrgui:WaitForChild("ScreenGui")
	local originalButton = screenGui:FindFirstChild("MobileRun") or screenGui:WaitForChild("MobileRun")
	local clonedButton = originalButton:Clone()
	clonedButton.Name = "MobileRun"
	clonedButton.Parent = screenGui
	originalButton:Destroy()

	updsprintbtnimg()

	table.insert(infinitestaminaconnections, clonedButton.MouseButton1Click:Connect(function()
		if infinitestaminasprinttoggled then
			env.funcs.infstamwalking()
		else
			env.funcs.infstamsprinting()
		end
	end))
end

function infstamcleanup()
	infinitestaminasprinttoggled = false

	stopsprintingloop()
	stopinfstamrunspeedloop()
	stopsprintbtnimgloop()

	setsprinting(false)
	infstamapplywalkspeed()

	for _, conn in ipairs(infinitestaminaconnections) do
		if conn.Disconnect then conn:Disconnect() end
	end
	table.clear(infinitestaminaconnections)

	updsprintbtnimg(true)
end

function enableinfinitestamina(state)
	if not env.stuf.inrun then return end

	if state then
		if env.stuf.infinitestaminaenabled then return end
		env.stuf.infinitestaminaenabled = true

		if mobile then
			setupmobileinfstam()
			startsprintbtnimgloop()
		else
			setuppcinfstam()
		end

		if not showactualstamina then
			startupdstaminaloop()
		else
			stopupdstaminaloop()
		end
	else
		if not env.stuf.infinitestaminaenabled then return end
		env.stuf.infinitestaminaenabled = false

		infstamcleanup()

		if mobile then
			setupmobileinfstam()
		else
			setuppcinfstam()
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

antislownessdebuffenabled = false
antislownessdebuffenabledconnections = {}

local function fixModifier(value)
	if not value or typeof(value) ~= "number" then
		return 1
	end

	local iterations = 0
	local maxIterations = 50

	while value < 1 and iterations < maxIterations do
		value = value * 1.1
		iterations += 1
	end

	while value < 1 and iterations < maxIterations do
		value = value + 0.05
		iterations += 1
	end

	if value < 1 then
		value = 1
	end

	return value
end

function fetchspeedwithoutdebuff(mode)
	if not env.funcs.exists() then
		repeat t() until env.funcs.exists()
	end

	if not env.stuf.plrstats then return env.stuf.hum.WalkSpeed end

	if mode == "Run" then
		local base = env.stuf.plrstats:FindFirstChild("RunSpeed").Value
		local mod  = env.stuf.plrstats:FindFirstChild("RunSpeedModifier")

		if base and mod then
			local fixedMod = fixModifier(mod.Value)
			return base * fixedMod
		end

	elseif mode == "Walk" then
		local base = env.stuf.plrstats:FindFirstChild("WalkSpeed").Value
		local mod  = env.stuf.plrstats:FindFirstChild("SpeedModifier")

		if base and mod then
			local fixedMod = fixModifier(mod.Value)
			return base.Value * fixedMod
		end
	end

	return env.stuf.hum.WalkSpeed
end

function antislownessdebuffloop()
	if not env.funcs.exists() then
		repeat t() until env.funcs.exists()
	end

	local sprint = env.stuf.plrstats:FindFirstChild("Sprinting")

	table.insert(antislownessdebuffenabledconnections,
		sprint.Changed:Connect(function()
			if sprint.Value then
				env.stuf.hum.WalkSpeed = fetchspeedwithoutdebuff("Run")
			else
				env.stuf.hum.WalkSpeed = fetchspeedwithoutdebuff("Walk")
			end
		end)
	)
end

function enableantislownessdebuff(state)
	if state then
		if antislownessdebuffenabled then return end
		antislownessdebuffenabled = true
		antislownessdebuffloop()

	else
		if not antislownessdebuffenabled then return end
		antislownessdebuffenabled = false

		for _, conn in ipairs(antislownessdebuffenabledconnections) do
			if conn.Disconnect then conn:Disconnect() end
		end

		table.clear(antislownessdebuffenabledconnections)

		env.stuf.hum = fetchspeedwithoutdebuff("Walk")
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local antibanconn = nil

function enableantiban(state)
	if state then
		if env.stuf.inlobby then 
			antibanconn = rst.Events.WarnUser.OnClientEvent:Connect(function()
				env.stuf.plr:Kick("[Boxten]: you triggered the anticheat. lucky for you, we kicked you in order to avoid you getting banned after the second tick. dont do it again.")
			end)
		end
	else
		if antibanconn then
			antibanconn:Disconnect() 
			antibanconn = nil
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

Services = setmetatable({}, {
	__index = function(self, name)
		local success, cache = pcall(function()
			return cloneref(game:GetService(name))
		end)
		if success then
			rawset(self, name, cache)
			return cache
		end
	end
})

local lmao = nil

function antiafk(state)
	if state then
		if getconnections then
			for _, connection in pairs(getconnections(env.stuf.plr.Idled)) do
				if connection["Disable"] then
					connection["Disable"](connection)
				elseif connection["Disconnect"] then
					connection["Disconnect"](connection)
				end
			end
		else
			if not lmao then
				lmao = env.stuf.plr.Idled:Connect(function()
					Services.VirtualUser:CaptureController()
					Services.VirtualUser:ClickButton2(Vector2.new())
				end)
			end
		end
	else
		if getconnections then
			for _, connection in pairs(getconnections(env.stuf.plr.Idled)) do
				if connection["Enable"] then
					connection["Enable"](connection)
				elseif connection["Reconnect"] then
					connection["Reconnect"](connection)
				end
			end
		else
			if lmao then
				lmao:Disconnect()
				lmao = nil
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

function env.funcs.forcequitmachine()
	local decoding = env.funcs.getstats("player", env.stuf.char).extracting
	if decoding ~= nil then
		decoding.Stats.StopInteracting:FireServer("Stop")
	end
	return not env.stuf.plrgui.ScreenGui.Menu.StopGenerator.Visible
end

-------------------------------------------------------------------------------------------------------------------------------

local function fat(state)
	if state then
		for _, child in pairs(env.stuf.char:GetDescendants()) do
			if child.ClassName == "Part" then
				child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
			end
		end
	else 
		for _, child in pairs(env.stuf.char:GetDescendants()) do
			if child.ClassName == "Part" then
				child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local pushaurasenabled = false
local pushaurasize = 20
local activepushauras = {}
local pushauraconns = {}

local function makepushaura(monster)
	if activepushauras[monster] then return end

	local anchorPart = env.funcs.getstats("twisted", monster).troot
	if not anchorPart then return end

	local aura = Instance.new("Part")
	aura.Anchored = true
	aura.CanCollide = true
	aura.Transparency = 0.5
	aura.Color = Color3.fromRGB(255, 255, 255)
	aura.CastShadow = false
	aura.Material = Enum.Material.ForceField
	aura.Massless = true
	aura.Size = Vector3.new(pushaurasize, pushaurasize, pushaurasize)
	aura.Shape = Enum.PartType.Ball
	aura.CanQuery = false
	aura.Name = "big fat transparent sphere parented to a twisted"

	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Sphere
	mesh.Scale = Vector3.new(1, 1, 1)
	mesh.Parent = aura

	aura.Parent = workspace
	activepushauras[monster] = {aura = aura, anchor = anchorPart}

	activepushauras[monster].connection = rs.Heartbeat:Connect(function()
		if not pushaurasenabled or not anchorPart or not anchorPart.Parent then
			removepushaura(monster)
			return
		end

		aura.Position = anchorPart.Position
		aura.Size = Vector3.new(pushaurasize, pushaurasize, pushaurasize)
	end)
end

function removepushaura(monster)
	local data = activepushauras[monster]
	if data then
		if data.connection then 
			data.connection:Disconnect() 
		end
		if data.aura and data.aura.Parent then 
			data.aura:Destroy() 
		end
		activepushauras[monster] = nil
	end
end

local function clearpushauralisteners()
	for _, conn in pairs(pushauraconns) do
		if conn then conn:Disconnect() end
	end
	table.clear(pushauraconns)
end

local function applypushauras()
	for monster, _ in pairs(activepushauras) do
		removepushaura(monster)
	end

	if not pushaurasenabled then 
		clearpushauralisteners()
		return 
	end

	if not env.stuf.currentroom then return end

	for _, monster in pairs(env.stuf.twisteds:GetChildren()) do
		if monster:IsA("Model") then
			local monsterName = monster.Name
			if not string.find(monsterName, "Connie") and not string.find(monsterName, "Rodger") and not string.find(monsterName, "RazzleDazzle") and not string.find(monsterName, "Blot") then
				makepushaura(monster)
			end
		end
	end

	clearpushauralisteners()

	pushauraconns["added"] = env.stuf.twisteds.ChildAdded:Connect(function(monster)
		if pushaurasenabled and monster:IsA("Model") then
			local monsterName = monster.Name
			if not string.find(monsterName, "Connie") and not string.find(monsterName, "Rodger") then
				t(0.2)
				makepushaura(monster)
			end
		end
	end)

	pushauraconns["removed"] = env.stuf.twisteds.ChildRemoved:Connect(function(monster)
		removepushaura(monster)
	end)

	pushauraconns["descendantAdded"] = env.stuf.currentroom.DescendantAdded:Connect(function(obj)
		if obj.Name == "Monsters" and obj:IsA("Folder") then
			applypushauras()
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local dodgetwistedssafedist = 12
local dodgetwistedsenabled = false
local dodgetwistedsthread = nil

local function isvalidpart(part)
	return part and part:IsA("BasePart") and part:IsDescendantOf(ws)
end

local function getcleardist(origin, direction, maxDist)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {env.stuf.char}
	params.FilterType = blacklistrayfilter

	local result = ws:Raycast(origin, direction.Unit * maxDist, params)
	if result then
		return (result.Position - origin).Magnitude
	else
		return maxDist
	end
end

local function getsafestdirection(fromPos, monsters)
	local bestDirection = nil
	local bestScore = -math.huge
	local wallAvoidDist = 10

	for angle = 0, 360 - 15, 15 do
		local dir = CFrame.Angles(0, math.rad(angle), 0).LookVector
		local clearDist = getcleardist(fromPos, dir, dodgetwistedssafedist)

		local wallPenalty = 0
		if clearDist < wallAvoidDist then
			wallPenalty = (wallAvoidDist - clearDist) * 5
		end

		local danger = 0
		for _, m in ipairs(monsters) do
			if isvalidpart(m) then
				local toMonster = (m.Position - fromPos)
				local dot = dir:Dot(toMonster.Unit)
				if dot > 0 then
					danger += (dot / toMonster.Magnitude)
				end
			end
		end

		local score = clearDist - (danger * 10) - wallPenalty
		if score > bestScore then
			bestScore = score
			bestDirection = dir
		end
	end

	return bestDirection and bestDirection.Unit or nil
end

local function gettwisroots()
	local roots = {}
	if not env.stuf.twisteds then return roots end

	if env.stuf.twisteds then
		for _, monster in ipairs(env.stuf.twisteds:GetChildren()) do
			local root = table.insert(roots, env.funcs.getstats("twisted", monster).troot)
			if isvalidpart(root) then
				table.insert(roots, root)
			end
		end
	end
	return roots
end

local function avoidloop()
	while dodgetwistedsenabled do
		t()

		local monsters = gettwisroots()
		if #monsters == 0 then continue end

		local danger = false
		for _, m in ipairs(monsters) do
			local dist = (m.Position - env.stuf.root.Position).Magnitude
			if dist < dodgetwistedssafedist then
				danger = true
				break
			end
		end

		if danger then
			local safeDir = getsafestdirection(env.stuf.root.Position, monsters)
			if safeDir then
				local newPos = env.stuf.root.Position + Vector3.new(safeDir.X, 0, safeDir.Z) * 12
				env.stuf.root.CFrame = CFrame.new(newPos, env.stuf.root.CFrame.LookVector + newPos)
			end
		end
	end
end

local function avoidtwisteds(state)
	if state then
		if dodgetwistedsenabled then return end
		dodgetwistedsenabled = true
		dodgetwistedsthread = spwn(avoidloop)
	else
		if not dodgetwistedsenabled then return end
		dodgetwistedsenabled = false
		dodgetwistedsthread = nil
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local function offsettwisteds(x, y, z)
	rst.Events.GetCharacterPosition.OnClientInvoke = function() 
		return env.stuf.char:GetPivot().Position + Vector3.new(x, y, z)
	end
end

local function unoffsettwisteds()
	rst.Events.GetCharacterPosition.OnClientInvoke = function() 
		return env.stuf.char:GetPivot().Position
	end
end

local antigrabconn
local antigrabdb = 0

local function antigrab(state)
	if state then
		if antigrabconn then return end
		antigrabconn = rst.StoryEvents.Spotted.OnClientEvent:Connect(function()
			for _, twisted in ipairs(env.stuf.twisteds:GetChildren()) do
				if twisted.Name:find("Goob") or twisted.Name:find("Gigi") or twisted.Name:find("Scraps") then
					if env.funcs.getstats("twisted", twisted).chasing == env.stuf.user then
						local now = os.clock()
						antigrabdb = now

						offsettwisteds(0, -3.5, 0)

						task.delay(1, function()
							if os.clock() - antigrabdb >= 1 then
								unoffsettwisteds()
							end
						end)

						break
					end
				end
			end
		end)
	else
		if antigrabconn then
			antigrabconn:Disconnect()
			antigrabconn = nil
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

function env.funcs.pickupallitems()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0
	local doit

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			if env.stuf.items:FindFirstChild("FakeCapsule") then
				if not env.stuf.afe.running then
					env.funcs.popup("Twisted Rodger's capsule is on this floor. Are you sure you still want to run this?", "Yes", function() doit = true end, "Nevermind", function() doit = false end)
				end
			end

			repeat t() until doit ~= nil
			if doit then
				for _, item in ipairs(env.stuf.items:GetChildren()) do
					if item:IsA("Model") then
						if env.stuf.afe.running and item.Name:find("Fake") then return end
						local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
						for _ = 1, 15 do 
							env.funcs.moveplr(itemCFrame, "tp") 
							local prompt = env.funcs.getstats("item", item).act
							if prompt then
								fireproximityprompt(env.funcs.getstats("item", item).act)
							end
							t() 
						end
					end
				end
			end
		end
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

function env.funcs.pickupallcapsules()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			for _, item in ipairs(env.stuf.items:GetChildren()) do
				if item:IsA("Model") and item.Name:find("ResearchCapsule") then
					local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
					for _ = 1, 15 do 
						env.funcs.moveplr(itemCFrame, "tp") 
						local prompt = env.funcs.getstats("item", item).act
						if prompt then
							fireproximityprompt(env.funcs.getstats("item", item).act)
						end
						t() 
					end
				end
			end
		end
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

function env.funcs.pickupalltapes()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			for _, item in ipairs(env.stuf.items:GetChildren()) do
				if item:IsA("Model") and item.Name:find("Tape") then
					local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
					for _ = 1, 15 do 
						env.funcs.moveplr(itemCFrame, "tp") 
						local prompt = env.funcs.getstats("item", item).act
						if prompt then
							fireproximityprompt(env.funcs.getstats("item", item).act)
						end
						t() 
					end
				end
			end
		end
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

function env.funcs.pickupallheals()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			for _, item in ipairs(env.stuf.items:GetChildren()) do
				if item:IsA("Model") and item.Name:find("HealthKit") or item.Name:find("Bandage") then
					local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
					for _ = 1, 15 do 
						env.funcs.moveplr(itemCFrame, "tp") 
						local prompt = env.funcs.getstats("item", item).act
						if prompt then
							fireproximityprompt(env.funcs.getstats("item", item).act)
						end
						t() 
					end
				end
			end
		end
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

function env.funcs.pickupallextitems()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			for _, item in ipairs(env.stuf.items:GetChildren()) do
				if item:IsA("Model") and item.Name:find("JumperCable") or item.Name:find("ExtractionSpeedCandy") or item.Name:find("SkillCheckCandy") or item.Name:find("Jawbreaker") then
					local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
					for _ = 1, 15 do 
						env.funcs.moveplr(itemCFrame, "tp") 
						local prompt = env.funcs.getstats("item", item).act
						if prompt then
							fireproximityprompt(env.funcs.getstats("item", item).act)
						end
						t() 
					end
				end
			end
		end	
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

function env.funcs.pickupalleventitems()
	local oldcf = env.stuf.root.CFrame
	ws.Gravity = 0

	if env.stuf.currentroom then
		if env.stuf.items and #env.stuf.items:GetChildren() > 0 then
			for _, item in ipairs(env.stuf.items:GetChildren()) do
				if item:IsA("Model") and item.Name:find("HolidayCollectibleItem") then
					local itemCFrame = item:GetPivot() * CFrame.new(0, env.gear.general.itemtpposyoffset, 0)
					for _ = 1, 15 do 
						env.funcs.moveplr(itemCFrame, "tp") 
						local prompt = env.funcs.getstats("item", item).act
						if prompt then
							fireproximityprompt(env.funcs.getstats("item", item).act)
						end
						t() 
					end
				end
			end
		end
	end

	env.funcs.moveplr(oldcf, "tp")
	oldcf = nil
	ws.Gravity = 196.2
end

-------------------------------------------------------------------------------------------------------------------------------

local function shakesquirmoff()
	local function tap(dir)
		rst.Events.TwistedSquirmGrab:FireServer(unpack({"Struggle", dir}))
	end

	local ui = env.stuf.plrgui.TwistedSquirmEscapeUI
	if ui.Enabled then
		while ui.Enabled do
			tap("left") t()
			tap("right") t()
			if not ui.Enabled then break end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

encounteringtwisteds = false

function env.funcs.encountertwisteds()
	if encounteringtwisteds then return end
	encounteringtwisteds = true

	local ogpos = env.stuf.root.CFrame
	t()

	if env.stuf.currentroom and env.stuf.twisteds then
		ws.Gravity = 0
		local visitedrnd = false

		for _, monster in ipairs(env.stuf.twisteds:GetChildren()) do
			if monster:IsA("Model") and monster:FindFirstChild("HumanoidRootPart") then
				local mname = monster.Name:lower()

				if mname:find("rodger") then
					env.funcs.moveplr(monster:GetModelCFrame() + Vector3.new(0, 6, 0), "tp")
					fireproximityprompt(env.stuf.items:FindFirstChild("FakeCapsule").Prompt:FindFirstChildOfClass("ProximityPrompt"))

				elseif mname:find("razzle") and not visitedrnd then
					visitedrnd = true

					local infstamwasenabled = env.stuf.infinitestaminaenabled
					local spr = hiddenui:FindFirstChild("SprintEvent") or rst.Events:WaitForChild("SprintEvent")

					spwn(function()
						if spr then spr.Parent = rst.Events spr:FireServer(false) end
					end)

					env.funcs.moveplr(monster:GetModelCFrame() + Vector3.new(0, -4, 0), "tp")
					ws.Gravity = 196.2

					spr = rst.Events.SprintEvent
					if spr then spr:FireServer(true) end
					spwn(function() vim:SendKeyEvent(true, Enum.KeyCode.W, false, uis) end)
					t(0.5)
					spwn(function() vim:SendKeyEvent(false, Enum.KeyCode.W, false, uis) end)
					if spr then spr:FireServer(false) end

					if infstamwasenabled then
						spwn(function()
							local spr = rst.Events:FindFirstChild("SprintEvent") or rst.Events:WaitForChild("SprintEvent")
							if spr then spr:FireServer(false) spr.Parent = hiddenui end
						end)
					end

					ws.Gravity = 0

				elseif mname:find("squirm") then
					local spotted = false
					local spottedConn = rst.StoryEvents.Spotted.OnClientEvent:Connect(function()
						spotted = true
					end)

					env.funcs.moveplr(monster:GetModelCFrame() + Vector3.new(0, -3, 0), "tp")

					local starttime = tick()
					while tick() - starttime < 3 do
						if spotted then break end
						t()
					end

					spottedConn:Disconnect()

					if not spotted then
						shakesquirmoff()
					end

				elseif not mname:find("razzle") and not mname:find("rodger") then
					local starttime = tick()
					while tick() - starttime < 0.3 do
						if env.funcs.getstats("twisted", monster).troot then
							local foff = (mname:find("dandy") or mname:find("dyle") or mname:find("pebble")) and -28 or -18
							local targetcf = CFrame.new(
								monster.HumanoidRootPart.Position - monster.HumanoidRootPart.CFrame.LookVector * foff,
								monster.HumanoidRootPart.Position
							)
							env.funcs.moveplr(targetcf, "tp")
						end
						t()
					end
				end
			end
		end

		env.funcs.moveplr(ogpos, "tp")
		ws.Gravity = 196.2
	end

	encounteringtwisteds = false
end

-------------------------------------------------------------------------------------------------------------------------------

local directabilitytarget = ""
local usingabildirectly = false

local function fireability() rst.Events.AbilityEvent:InvokeServer(env.stuf.char, env.stuf.root.CFrame, false) end

local function fireabilityon(plr, ginger)
	if ginger then
		local args = {
			"HealChannelStarted",
			plr
		}
		for _ = 1, 100 do
			rst:WaitForChild("Events"):WaitForChild("GingerHealChannel"):FireServer(unpack(args))
			t()
		end
		return
	end

	local args = {
		env.stuf.char,
		plr:FindFirstChild("HumanoidRootPart").CFrame,
		plr
	}
	for _ = 1, 100 do
		rst:WaitForChild("Events"):WaitForChild("AbilityEvent"):InvokeServer(unpack(args))
		t()
	end
end

local function useabildirect(args)
	if usingabildirectly then return end 
	usingabildirectly = true
	local targets = env.funcs.resolvetargets(args)
	if not targets or #targets == 0 then return end

	local ogpos = env.stuf.root.CFrame

	local target = targets[1]
	if not target.Character then return end

	for _ = 1, 20 do env.stuf.root.CFrame = target.Character:FindFirstChild("HumanoidRootPart").CFrame t() end
	fireability()

	env.stuf.root.CFrame = ogpos
	usingabildirectly = false
end

-------------------------------------------------------------------------------------------------------------------------------

local boosting, boostspeed, fadedur, lastboosttime = false, 72, 0.5, -math.huge

local function RUDIEBOOST()
	if boosting then return end
	local currenttime = tick()
	if currenttime < lastboosttime then return end

	local rudie = Instance.new("Animation")
	rudie.AnimationId = "rbxassetid://82114603220952"
	local rudietrack = env.stuf.hum:LoadAnimation(rudie)

	boosting, lastboosttime = true, math.huge

	local og = {}
	for _, child in pairs(env.stuf.char:GetDescendants()) do
		if child:IsA("Part") then
			og[child] = child.CustomPhysicalProperties
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end

	spwn(function()
		rudietrack:Play() 
		if not env.stuf.inlobby then
			firesignal(rst.Events.RenderObject.OnClientEvent, rst.Parts.RenderModules.RudieBoost, {env.stuf.char})
		end
	end)

	spwn(function()
		local step = 0.02
		local maindur = 0
		local tm = 0

		while tm < maindur do
			local md = env.stuf.hum.MoveDirection
			local bd = md.Magnitude > 0 and md.Unit or env.stuf.root.CFrame.LookVector
			env.stuf.root.AssemblyLinearVelocity = bd * boostspeed + Vector3.new(0, env.stuf.root.AssemblyLinearVelocity.Y, 0)
			t(step)
			tm += step
		end

		tm = 0
		while tm < fadedur do
			local alpha = tm / fadedur
			local md = env.stuf.hum.MoveDirection
			local bd = md.Magnitude > 0 and md.Unit or env.stuf.root.CFrame.LookVector
			local normalvel = (md.Magnitude > 0) and md.Unit * env.stuf.hum.WalkSpeed or Vector3.new()
			local boostvel = bd * boostspeed
			local lerpvel = normalvel:Lerp(boostvel, 1 - alpha)
			env.stuf.root.AssemblyLinearVelocity = lerpvel + Vector3.new(0, env.stuf.root.AssemblyLinearVelocity.Y, 0)
			t(step)
			tm += step
		end

		for part, properties in pairs(og) do
			if part.Parent then
				part.CustomPhysicalProperties = properties
			end
		end

		boosting = false
		lastboosttime = tick()
	end)
end

env.stuf.plr.CharacterAdded:Connect(function()
	boosting = false
	lastboosttime = -math.huge
end)

env.stuf.plr.CharacterRemoving:Connect(function()
	boosting = false
end)

-------------------------------------------------------------------------------------------------------------------------------

local loopspeedinput = 16
local loopspeeding = false
local humanmodifcons = {}

local function setloopspeed(speed)
	if speed then
		local function WalkSpeedChange()
			if env.stuf.hum then
				env.stuf.hum.WalkSpeed = speed
			end
		end
		WalkSpeedChange()
		humanmodifcons.wsLoop = (humanmodifcons.wsLoop and humanmodifcons.wsLoop:Disconnect() and false) or env.stuf.hum:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		humanmodifcons.wsCA = (humanmodifcons.wsCA and humanmodifcons.wsCA:Disconnect() and false) or env.stuf.plr.CharacterAdded:Connect(function()
			WalkSpeedChange()
			humanmodifcons.wsLoop = (humanmodifcons.wsLoop and humanmodifcons.wsLoop:Disconnect() and false) or env.stuf.hum:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		end)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local tpwalking = false
local tpwalkcurrentspeed = 2
local tpwalkonextract = false
local tpwalksession = 0

local function settpwalk(speed)
	tpwalkcurrentspeed = tonumber(speed)
	tpwalking = true
	tpwalksession += 1
	local currentsession = tpwalksession

	if not env.stuf.hum then return end

	spwn(function()
		while tpwalking and env.stuf.hum and tpwalksession == currentsession do
			local delta = rs.Heartbeat:Wait()

			local canMove = true
			if tpwalkonextract then
				local decodingValue = env.stuf.char:FindFirstChild("Decoding")
				if not (decodingValue and decodingValue.Value) then
					canMove = false
				end
			end

			if canMove and env.stuf.hum.MoveDirection.Magnitude > 0 then
				env.stuf.char:TranslateBy(env.stuf.hum.MoveDirection * tpwalkcurrentspeed * delta * 10)
			end
		end
	end)
end

local function untpwalk()
	tpwalking = false
	tpwalksession += 1
end

-------------------------------------------------------------------------------------------------------------------------------

noxflying = false
noxflying2 = false
noxflyspeed = 1
noxflycontrol = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
noxflyinputbeganconnection, noxflyinputendedconnection, noxflystepconnection = nil, nil, nil

function stopflying()
	if not noxflying then return end

	noxflying = false
	ws.Gravity = 196.2

	env.stuf.root.Velocity = Vector3.zero

	if noxflyinputbeganconnection then noxflyinputbeganconnection:Disconnect() end
	if noxflyinputendedconnection then noxflyinputendedconnection:Disconnect() end
	if noxflystepconnection then noxflystepconnection:Disconnect() end

	noxflycontrol = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
end

function startflying(flySpeed)
	stopflying()
	if not noxflying2 then return end
	if noxflying then return end

	ws.Gravity = 0
	noxflying = true
	noxflyspeed = flySpeed or 1

	local ctrl
	if mobile then
		ctrl = require(env.stuf.plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
	end

	noxflyinputbeganconnection = uis.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		local key = input.KeyCode
		if key == Enum.KeyCode.W then noxflycontrol.F = 1 end
		if key == Enum.KeyCode.S then noxflycontrol.B = -1 end
		if key == Enum.KeyCode.A then noxflycontrol.L = -1 end
		if key == Enum.KeyCode.D then noxflycontrol.R = 1 end
		if key == Enum.KeyCode.E then noxflycontrol.Q = 1 end
		if key == Enum.KeyCode.Q then noxflycontrol.E = -1 end
	end)

	noxflyinputendedconnection = uis.InputEnded:Connect(function(input)
		local key = input.KeyCode
		if key == Enum.KeyCode.W then noxflycontrol.F = 0 end
		if key == Enum.KeyCode.S then noxflycontrol.B = 0 end
		if key == Enum.KeyCode.A then noxflycontrol.L = 0 end
		if key == Enum.KeyCode.D then noxflycontrol.R = 0 end
		if key == Enum.KeyCode.E then noxflycontrol.Q = 0 end
		if key == Enum.KeyCode.Q then noxflycontrol.E = 0 end
	end)

	noxflystepconnection = rs.RenderStepped:Connect(function()
		local camCF = env.stuf.cam.CFrame
		local direction

		if mobile and ctrl then
			direction = ctrl:GetMoveVector()
			local moveVec = (
				-camCF.LookVector * direction.Z +
					camCF.RightVector * direction.X +
					Vector3.new(0, noxflycontrol.Q + noxflycontrol.E, 0)
			) * noxflyspeed * 50

			env.stuf.root.CFrame = CFrame.new(env.stuf.root.Position, env.stuf.root.Position + Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z))
			env.stuf.root.Velocity = moveVec.Magnitude > 0 and moveVec or Vector3.zero

		else
			local flatLookVector = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
			local moveVec = (
				camCF.LookVector * (noxflycontrol.F + noxflycontrol.B) +
					camCF.RightVector * (noxflycontrol.R + noxflycontrol.L) +
					Vector3.new(0, noxflycontrol.Q + noxflycontrol.E, 0)
			) * noxflyspeed * 50

			if flatLookVector.Magnitude > 0 then
				env.stuf.root.CFrame = CFrame.new(env.stuf.root.Position, env.stuf.root.Position + flatLookVector)
			end

			env.stuf.root.Velocity = moveVec.Magnitude > 0 and moveVec or Vector3.zero
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local rejoindeathconn, exitdeathconn, rerundeathconn

-------------------------------------------------------------------------------------------------------------------------------

local itemaurablacklist = {}
local itemauraenabled = false
local itemaurathread = nil

local itemnamemap = {
	["Air Horn"]                 = "AirHorn",
	["Bandage"]                  = "Bandage",
	["Bonbon"]                   = "Bonbon",
	["Bottle o' Pop"]            = "PopBottle",
	["Box o' Chocolates"]        = "ChocolateBox",
	["Chocolate"]                = "Chocolate",
	["Eject Button"]             = "EjectButton",
	["Extraction Speed Candy"]   = "ExtractionSpeedCandy",
	["Event Currency"]           = "EventCurrency",
	["Gumballs"]                 = "Gumballs",
	["Health Kit"]               = "HealthKit",
	["Jawbreaker"]               = "Jawbreaker",
	["Jumper Cable"]             = "JumperCable",
	["Pop"]                      = "Pop",
	["Protein Bar"]              = "ProteinBar",
	["Research Capsule"]         = "ResearchCapsule",
	["Skill Check Candy"]        = "SkillCheckCandy",
	["Smoke Bomb"]               = "SmokeBomb",
	["Speed Candy"]              = "SpeedCandy",
	["Stealth Candy"]            = "StealthCandy",
	["Tape"]                     = "Tape",
}

local function itemaura(state)
	itemauraenabled = state

	if not state then
		if itemaurathread then
			task.cancel(itemaurathread)
			itemaurathread = nil
		end
		return
	end

	if itemaurathread then return end

	itemaurathread = spwn(function()
		while itemauraenabled do
			if env.stuf.currentroom and env.stuf.items then
				for _, item in pairs(env.stuf.items:GetChildren()) do
					if not itemaurablacklist[item.Name] then
						local promptPart = item:FindFirstChild("Prompt")
						if promptPart then
							local proximityPrompt = promptPart:FindFirstChildOfClass("ProximityPrompt")
							if proximityPrompt and proximityPrompt.Enabled then
								fireproximityprompt(proximityPrompt)
							end
						end
					end
				end
			end
			t()
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local buyaurablacklist = {}
local buyauraenabled = false
local buyaurathread = nil

local buynamemap = {
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

local function buyaura(state)
	buyauraenabled = state

	if not state then
		if buyaurathread then
			task.cancel(buyaurathread)
			buyaurathread = nil
		end
		return
	end

	if buyaurathread then return end

	buyaurathread = spwn(function()
		while buyauraenabled do
			local store = env.stuf.elevator:FindFirstChild("DandyStore")
			if store then
				for _, slot in ipairs(store:GetChildren()) do
					if slot.Name:lower():match("^slot") then
						local itemModel = slot:FindFirstChildWhichIsA("Model")
						if itemModel and not buyaurablacklist[itemModel.Name] then
							local promptPart = itemModel:FindFirstChild("Prompt")
							if promptPart then
								local prompt = promptPart:FindFirstChildOfClass("ProximityPrompt")
								if prompt and prompt.Enabled then
									fireproximityprompt(prompt)
								end
							end
						end
					end
				end
			end
			t()
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local machineauraconditions = {}
local machineauraenabled = false
local machineaurathread = nil

local function machineaura(state)
	machineauraenabled = state

	if not state then
		if machineaurathread then
			task.cancel(machineaurathread)
			machineaurathread = nil
		end
		return
	end

	if machineaurathread then return end

	machineaurathread = spwn(function()
		while machineauraenabled do
			if env.stuf.machines then
				for _, machine in ipairs(env.stuf.machines:GetChildren()) do
					local machstats = env.funcs.getstats("machine", machine)
					local possessed = machstats.possessed
					local hasprogress = machstats.amount ~= 0.1
					local machinetype = machstats.machtype

					local conditions = machineauraconditions
					if #conditions > 0 then
						local noprogress    = not table.find(conditions, "No progress")    or not hasprogress
						local notpossessed  = not table.find(conditions, "Not possessed")  or not possessed
						local typenormal    = not table.find(conditions, "Normal machine type")    or machinetype == "Normal"
						local typecircle    = not table.find(conditions, "Circle machine type")    or machinetype == "Circle"
						local typetreadmill = not table.find(conditions, "Treadmill machine type") or machinetype == "Treadmill"

						if not (noprogress and notpossessed and (typenormal or typecircle or typetreadmill)) then
							continue
						end
					end

					fireproximityprompt(machstats.prox)
				end
			end
			t()
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local extrawalkspeedunits = 0
local extrarunspeedunits = 0
local extraunitconn

local function addextraunits()
	if not env.stuf.inrun then return end

	if extraunitconn then return end
	extraunitconn = rs.Heartbeat:Connect(function()
		if extrawalkspeedunits < 0 and extrarunspeedunits < 0 then 
			extraunitconn:Disconnect() 
			extraunitconn = nil 
		end

		if env.stuf.plrstats:FindFirstChild("Sprinting") then
			env.stuf.hum.Walkspeed = env.stuf.plrstats:FindFirstChild("RunSpeed").Value + extrawalkspeedunits
		else
			env.stuf.hum.Walkspeed = env.stuf.plrstats:FindFirstChild("Walkspeed").Value + extrawalkspeedunits
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

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
			spwn(function() 
				if showactualstamina and state then 
					startupdstaminaloop() 
				else 
					stopupdstaminaloop() 
				end 
			end)
			enableinfinitestamina(state)
		end
	},
	{ type = "toggle", title = "Show actual stamina while having infinite stamina", desc = "Shows your actual stamina value while having infinite stamina enabled.",
		callback = function(state) 
			showactualstamina = state

			if env.stuf.infinitestaminaenabled then
				enableinfinitestamina(false)
				enableinfinitestamina(true)
			end

			spwn(function() 
				if state then 
					stopupdstaminaloop() 
				else 
					startupdstaminaloop() 
				end 
			end)
		end
	},
	{ type = "toggle", title = "Item aura", desc = "Toggles item aura.",
		commandcat = "Local Player",

		encommands = {"enableitemaura"},
		enaliases = {"eia"},
		encommanddesc = "Enables item aura",

		discommands = {"disableitemaura"},
		disaliases = {"dia"},
		discommanddesc = "Disables item aura",

		callback = function(state) 
			itemaura(state)
		end
	},
	{ type = "dropdown", title = "Item aura blacklist", desc = "Blacklists the selected items from being picked up by the item aura.", 
		options = {"Air Horn", "Bandage", "Bonbon", "Bottle o' Pop", "Box o' Chocolates", 
			"Chocolate", "Eject Button", "Extraction Speed Candy", "Event Currency", "Gumballs", 
			"Health Kit", "Jawbreaker", "Jumper Cable", "Pop", "Protein Bar", "Research Capsule", 
			"Skill Check Candy", "Smoke Bomb", "Speed Candy", "Stealth Candy", "Tape"},
		multiselect = true,

		callback = function(selected)
			itemaurablacklist = {}
			for _, label in ipairs(selected) do
				local mapped = itemnamemap[label] or label
				itemaurablacklist[mapped] = true
			end
		end 
	},
	{ type = "toggle", title = "Buy aura", desc = "Toggles buy aura.",
		commandcat = "Local Player",

		encommands = {"enablebuyaura"},
		enaliases = {"eba"},
		encommanddesc = "Enables buy aura",

		discommands = {"disablebuyaura"},
		disaliases = {"dba"},
		discommanddesc = "Disables buy aura",

		callback = function(state) 
			buyaura(state)
		end
	},
	{ type = "dropdown", title = "Buy aura blacklist", desc = "Blacklists the selected items from being bought from Dandy's Shop for the buy aura.", 
		options = {"Air Horn", "Bandage", "Bonbon", "Bottle o' Pop", "Box o' Chocolates", 
			"Chocolate", "Eject Button", "Extraction Speed Candy", "Gumballs", "Health Kit", 
			"Instructions", "Jawbreaker", "Jumper Cable", "Pop", "Protein Bar", 
			"Skill Check Candy", "Smoke Bomb", "Speed Candy", "Stealth Candy", "Stopwatch", 
			"Valve"},
		multiselect = true,

		callback = function(selected)
			buyaurablacklist = {}
			for _, label in ipairs(selected) do
				local mapped = buynamemap[label] or label
				buyaurablacklist[mapped] = true
			end
		end
	},
	{ type = "toggle", title = "Machine aura", desc = "Toggles machine aura.",
		commandcat = "Local Player",

		encommands = {"enablemachineaura"},
		enaliases = {"ema"},
		encommanddesc = "Enables machine aura",

		discommands = {"disablemachineaura"},
		disaliases = {"dma"},
		discommanddesc = "Disables machine aura",

		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Machine aura condition", desc = "Sets the conditions for the machine aura that the closest machine has to follow.", 
		options = {"No progress", "Not possessed", "Normal machine type", "Circle machine type", "Treadmill machine type"},
		default = {"No progress", "Not possessed", "Normal machine type", "Circle machine type", "Treadmill machine type"},
		multiselect = true,

		callback = function(selected) 
			machineauraconditions = selected
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
			enableantislownessdebuff(state)
		end
	},
	{ type = "toggle", title = "Anti ban", desc = "Applies measures that will prevent you from getting banned. Note that you are still susceptible to getting banned even when having this on.",
		default = true,
		commandcat = "Local Player",

		encommands = {"enableantiban"},
		enaliases = {"eab"},
		encommanddesc = "Enables anti ban",

		discommands = {"disableantiban"},
		disaliases = {"dab"},
		discommanddesc = "Disables anti ban",

		callback = function(state)
			enableantiban(state)
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
			antiafk(state)
		end
	},
	{ type = "button", title = "Force quit machine", desc = "Forcefully quits machine extraction.",
		commandcat = "Local Player",

		command = "forcequitmachine",
		aliases = {"fqm"},
		commanddesc = "Forcefully quits machine extraction",

		callback = function()
			env.funcs.forcequitmachine()
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
			fat(state)
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
			pushaurasenabled = state
			if state then
				applypushauras()
			else
				for monster, _ in pairs(activepushauras) do
					removepushaura(monster)
				end
			end
		end
	},
	{ type = "slider", title = "Twisteds push aura size", desc = "Adjusts the size of the Twisteds' push aura.", min = 5, max = 80, default = 20, step = 1,
		callback = function(value)
			local num = tonumber(value)
			if num and num > 0 then
				pushaurasize = num
				for _, data in pairs(activepushauras) do
					if data.aura then
						data.aura.Size = Vector3.new(pushaurasize, pushaurasize, pushaurasize)
					end
				end
			end
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
			avoidtwisteds(state)
		end
	},
	{ type = "slider", title = "Avoid Twisteds distance", desc = "Sets the distance required for the Twisted to reach toward you to teleport away.", min = 3, max = 80, default = 10, step = 1,
		callback = function(value)
			dodgetwistedssafedist = value
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
			antigrab(state)
		end
	},
	{ type = "button", title = "Pick up all items", desc = "Picks up all the items on the floor.",
		commandcat = "Local Player",

		command = "pickupallitems",
		aliases = {"puai"},
		commanddesc = "Picks up all the items on the floor",

		callback = function() 
			env.funcs.pickupallitems()
		end
	},
	{ type = "button", title = "Pick up all Research Capsules", desc = "Picks up all the Research Capsules on the floor.",
		commandcat = "Local Player",

		command = "pickupallresearchcapsules",
		aliases = {"puarc"},
		commanddesc = "Picks up all the Research Capsules on the floor",

		callback = function() 
			env.funcs.pickupallcapsules()
		end
	},
	{ type = "button", title = "Pick up all Tapes", desc = "Picks up all the tapes on the floor.",
		commandcat = "Local Player",

		command = "pickupalltapes",
		aliases = {"puat"},
		commanddesc = "Picks up all the Tapes on the floor",

		callback = function() 
			env.funcs.pickupalltapes()
		end
	},
	{ type = "button", title = "Pick up all heals", desc = "Picks up all the heals on the floor.",
		commandcat = "Local Player",

		command = "pickupallheals",
		aliases = {"puah"},
		commanddesc = "Picks up all the heals on the floor",

		callback = function() 
			env.funcs.pickupallheals()
		end
	},
	{ type = "button", title = "Pick up all etxraction items", desc = "Picks up all the extraction items on the floor.",
		commandcat = "Local Player",

		command = "pickupallextractionitems",
		aliases = {"puaei"},
		commanddesc = "Picks up all the extraction items on the floor",

		callback = function() 
			env.funcs.pickupallextitems()
		end
	},
	{ type = "button", title = "Pick up all event items", desc = "Picks up all the event items / currency on the floor (Including Research Capsules that are linked to Event Twisteds).",
		commandcat = "Local Player",

		command = "pickupalleventitems",
		aliases = {"puaeti"},
		commanddesc = "Picks up all the event items on the floor",

		callback = function() 
			env.funcs.pickupalleventitems()
		end
	},
	{ type = "button", title = "Encounter all Twisteds", desc = "Encounters every Twisted on the floor that you haven't encountered yet.",
		commandcat = "Local Player",

		command = "encounteralltwisteds",
		aliases = {"eat"},
		commanddesc = "Encounters all the Twisteds on the floor that haven't spotted you yet",

		callback = function() 
			env.funcs.encountertwisteds()
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
			if not env.stuf.inrun then return end
			if state then
				local popup = env.stuf.plrgui.ScreenGui:FindFirstChild("PopUp")
				if popup then popup.Parent = hiddenui end
			else 
				local popup = hiddenui:FindFirstChild("PopUp")
				if popup then popup.Parent = env.stuf.plrgui.ScreenGui end
			end
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
			if not env.stuf.inrun then return end
			if state then
				local scf = env.stuf.plrgui.ScreenGui.Menu:FindFirstChild("SkillCheckFrame")
				if scf then scf.Parent = hiddenui end
			else 
				local scf = hiddenui:FindFirstChild("SkillCheckFrame")
				if scf then scf.Parent = env.stuf.plrgui.ScreenGui.Menu end
			end
		end
	},
	{ type = "button", title = "Instant death", desc = "Kills you.",
		commandcat = "Local Player",

		command = "die",
		commanddesc = "Kills you",

		callback = function() 
			env.funcs.popup("Running this will kill you instantly. Are you sure you want to run this?", "Yes", function() env.stuf.hum.Health = 0 end, "Nevermind", nil)
		end
	},

	{ type = "separator", title = "Ability" },
	{ type = "input and button", title = "Use ability on player", desc = "Uses your ability on the target player, bypassing some distance checks.", placeholder = "Target",
		commandcat = "Local Player",

		command = "useabilityon [plr]",
		aliases = {"useabil [plr]"},
		commanddesc = "Uses your ability on the target player",

		callback = function(text) 
			fireabilityon(text)
		end,

		autofill = true
	},
	{ type = "input and button", title = "Teleport to and use ability on player", desc = "Teleports you to the target player and then uses your ability.", placeholder = "Target",
		commandcat = "Local Player",

		command = "teleportanduseabilityon [plr]",
		aliases = {"tpanduseabil [plr]"},
		commanddesc = "Teleports you to the target player and then uses your ability",

		callback = function(text) 
			useabildirect(text)
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
			RUDIEBOOST()
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
			loopspeeding = state
			if loopspeeding then
				setloopspeed(text)
			else
				humanmodifcons.wsLoop = (humanmodifcons.wsLoop and humanmodifcons.wsLoop:Disconnect() and false) or nil
				humanmodifcons.wsCA = (humanmodifcons.wsCA and humanmodifcons.wsCA:Disconnect() and false) or nil

				if env.stuf.hum then
					env.stuf.hum.WalkSpeed = 16
				end
			end
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
			if state then
				settpwalk(text)
			else
				untpwalk()
			end
		end
	},
	{ type = "toggle", title = "Teleport walk on extract", desc = "Toggles teleport walking only when extracting.",
		callback = function(state) 
			tpwalkonextract = state
		end
	},
	{ type = "input and toggle", title = "Fly", desc = "Makes you fly with the inputted speed.", placeholder = "Speed",
		commandcat = "Local Player",

		encommands = {"fly [num]"},
		encommanddesc = "Makes you fly",

		discommands = {"unfly"},
		discommanddesc = "Stop flying",

		callback = function(text, state) 
			local num = tonumber(text)
			if num == 0 then num = 1 end
			if num and num > 0 then
				noxflyspeed = num
				stopflying()
				startflying(noxflyspeed)
			end

			noxflying2 = state
			if noxflying2 then
				startflying(noxflyspeed)
			else
				stopflying()
			end
		end
	},
	{ type = "input", title = "Extra walk speed units", desc = "Adds extra speed to your walk movement speed.", placeholder = "Speed",
		commandcat = "Local Player",

		command = "addwalkspeed [num]",
		aliases = {"addws [num]"},
		commanddesc = "Adds extra speed to your walk movement speed",

		callback = function(text)
			extrawalkspeedunits = tonumber(text) or 0
			addextraunits()
		end
	},
	{ type = "input", title = "Extra run speed units", desc = "Adds extra speed to your run movement speed.", placeholder = "Speed",
		commandcat = "Local Player",

		command = "addrunspeed [num]",
		aliases = {"addrs [num]"},
		commanddesc = "Adds extra speed to your run movement speed",

		callback = function(text)
			extrarunspeedunits = tonumber(text) or 0
			addextraunits()
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
			if state then
				rejoindeathconn = env.stuf.hum.Died:Connect(function()
					rst.Events:WaitForChild("Teleport"):FireServer()
				end)
			else
				if rejoindeathconn then
					rejoindeathconn:Disconnect()
					rejoindeathconn = nil
				end
			end
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
			if state then
				exitdeathconn = env.stuf.hum.Died:Connect(function()
					game:Shutdown()
				end)
			else
				if exitdeathconn then
					exitdeathconn:Disconnect()
					exitdeathconn = nil
				end
			end
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
			if state then
				rerundeathconn = env.stuf.hum.Died:Connect(function()
					spwn(function()
						queueotp([[game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function() local function findgate() for _, model in ipairs(workspace["Elevators"]:GetChildren()) do if model:IsA("Model") and model.Name == "Gate" then local gate = model:FindFirstChild("Gate") local partOne = model:FindFirstChild("1") if gate and gate:IsA("BasePart") and partOne and partOne:IsA("BasePart") then return gate end end end return nil end local function gog(lal) local character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait() local root = character:WaitForChild("HumanoidRootPart") local savedCFrame = root.CFrame firetouchinterest(root, lal, 0) task.wait() firetouchinterest(root, lal, 1) task.wait() root.CFrame = savedCFrame end local gate = findgate() if gate then gog(gate) end end)]])
					end)
					t(0.5)
					rst.Events:WaitForChild("Teleport"):FireServer()
				end)
			else
				if rerundeathconn then
					rerundeathconn:Disconnect()
					rerundeathconn = nil
				end
			end
		end
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
