--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Visuals section)

---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn, inf = task.wait, task.spawn, math.huge
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local ws = FindFirstChildOfClass(game, "Workspace")
local l = FindFirstChildOfClass(game, "Lighting")
local uis = FindFirstChildOfClass(game, "UserInputService")
local rs = FindFirstChildOfClass(game, "RunService")
local plrs = FindFirstChildOfClass(game, "Players")

local GetChildren = getins(game, "GetChildren") 
local GetPlayers = getins(plrs, "GetPlayers") 
local Destroy = getins(game, "Destroy") 

local getgenv = getgenv() or _G
local req = (syn and syn.request) or (http and http.request) or request
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

fbconn, altfbconn, fogconn = nil
ogl = {}

function killfb()
	if fbconn then fbconn:Disconnect() fbconn = nil end 
	if altfbconn then altfbconn:Disconnect() altfbconn = nil end
end

function savelighting()
	ogl.Brightness = l.Brightness
	ogl.ClockTime = l.ClockTime
	ogl.FogEnd = l.FogEnd
	ogl.GlobalShadows = l.GlobalShadows
	ogl.OutdoorAmbient = l.OutdoorAmbient
end

spwn(function() repeat t() until env.funcs.exists() savelighting() end)

-------------------------------------------------------------------------------------------------------------------------------

function relighting()
	l.Brightness = ogl.Brightness
	l.ClockTime = ogl.ClockTime
	l.FogEnd = ogl.FogEnd
	l.GlobalShadows = ogl.GlobalShadows
	l.OutdoorAmbient = ogl.OutdoorAmbient
end

-------------------------------------------------------------------------------------------------------------------------------

function fb(alt)
	l.Brightness = 2
	l.ClockTime = alt and 0 or 14
	l.FogEnd = 100000
	l.GlobalShadows = false
	l.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end

-------------------------------------------------------------------------------------------------------------------------------

function togglefb(state)
	if state then
		if altfbconn then env.essentials.library.update("Alt fullbright", false) end
		killfb() savelighting()
		fbconn = rs.Heartbeat:Connect(fb)
	else
		killfb()
		relighting()
	end
end

-------------------------------------------------------------------------------------------------------------------------------

function toggleafb(state)
	if state then
		if fbconn then env.essentials.library.update("Fullbright", false) end
		killfb() savelighting()
		altfbconn = rs.Heartbeat:Connect(function()
			fb(true)
		end)
	else
		killfb()
		relighting()
	end
end

-------------------------------------------------------------------------------------------------------------------------------

function nofog(state)
	if state then
		if fogconn then fogconn:Disconnect() fogconn = nil end
		relighting()
	else
		fogconn = rs.Heartbeat:Connect(function()
			ogl.FogEnd = 9e9
		end)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

brightblock = {}
function norender(state)
	if state then
		brightblock.sgui = Instance.new("ScreenGui")
		brightblock.sgui.Name = "3D rendering is disabled"
		brightblock.sgui.ResetOnSpawn = false
		brightblock.sgui.DisplayOrder = -999999
		brightblock.sgui.IgnoreGuiInset = true
		brightblock.sgui.Parent = env.stuf.plrgui

		brightblock.f = Instance.new("Frame")		
		brightblock.f.Parent = brightblock.sgui
		brightblock.f.BackgroundColor3 = Color3.new(0, 0, 0)
		brightblock.f.Size = UDim2.new(1, 0, 1, 60)
		brightblock.f.Position = UDim2.new(0, 0, 0, -60)
		brightblock.f.ZIndex = 1

		rs:Set3dRenderingEnabled(false)
	else
		if brightblock.sgui then brightblock.sgui:Destroy() brightblock.sgui = nil end
		rs:Set3dRenderingEnabled(true)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

showhealthconnection = nil
function updhealths(visibility, dist)
	if not env.stuf.plrfolder or not env.stuf.inrun then return end

	for _, plr in ipairs(env.stuf.plrfolder:GetChildren()) do
		local healthgui = plr:FindFirstChild("LoadoutFrame")				
		if healthgui then
			healthgui.MaxDistance = dist

			local frame = healthgui:FindFirstChild("Frame")					
			if frame then
				local healthFrame = frame:FindFirstChild("HealthFrame")						
				if healthFrame then
					healthFrame.Visible = visibility
				end
			end
		end
	end
end

function showhealth(state)
	if state then
		if not showhealthconnection then
			showhealthconnection = rs.Heartbeat:Connect(function()
				updhealths(true, inf)
			end)
		end
	else
		if showhealthconnection then showhealthconnection:Disconnect() showhealthconnection = nil end
		updhealths(false, 30)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

showtrinketsconn = nil
function updtrinketlos(visibility, dist)
	if not env.stuf.plrfolder then return end

	for _, plr in ipairs(env.stuf.plrfolder:GetChildren()) do
		local loadoutgui = plr:FindFirstChild("LoadoutFrame")				
		if loadoutgui then
			loadoutgui.MaxDistance = dist

			local frame = loadoutgui:FindFirstChild("Frame")
			if frame then
				for _, slotname in ipairs({"Slot1", "Slot2"}) do
					local slotframe = frame:FindFirstChild(slotname)
					if slotframe and slotframe:IsA("Frame") then
						slotframe.Visible = visibility
					end
				end
			end
		end
	end
end

function showtrinkets(state)
	if state then
		if not showtrinketsconn then
			showtrinketsconn = rs.Heartbeat:Connect(function()
				updtrinketlos(true, inf)
			end)
		end
	else
		if showtrinketsconn then showtrinketsconn:Disconnect() showtrinketsconn = nil end
		updtrinketlos(false, 0)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

infdistenabled = false
function updmaxdist(player, distance)
	local function onchar(char)
		local root = char:WaitForChild("HumanoidRootPart", 5)
		if root then
			local gui = root:FindFirstChild("NameTag")			
			if gui then
				gui.MaxDistance = distance
			end
		end
	end

	if env.funcs.exists(player) then
		onchar(player.Character)
	end

	player.CharacterAdded:Connect(function()
		if env.funcs.exists(player) then
			onchar(player.Character)
		end
	end)
end

function applymaxdist(distance)
	for _, player in ipairs(plrs:GetPlayers()) do
		updmaxdist(player, distance)
	end

	plrs.PlayerAdded:Connect(function(player)
		updmaxdist(player, distance)
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

function infinitenametagdist(state)
	applymaxdist(state and inf or 30)
end

-------------------------------------------------------------------------------------------------------------------------------

local esphandler = {
	player = {
		enabled = false,
		hls = {},
		conn = nil
	},
	twisted = {
		enabled = false,
		hls = {},
		conn = nil
	},
	machine = {
		enabled = false,
		hls = {},
		conn = nil
	},
	item = {
		enabled = false,
		hls = {},
		conn = nil
	},
	elevator = {
		enabled = false,
		hls = {},
	},
	fakeelevator = {
		enabled = false,
		hls = {},
		conn = nil
	},
	twistedobstacle = {
		enabled = false,
		hls = {},
		conn = nil
	}
}

local espsettings = {
	colors = {
		player = Color3.fromRGB(0, 0, 255),
		playerhurt = Color3.fromRGB(0, 0, 190),
		playerbadlyhurt = Color3.fromRGB(0, 0, 130),
		playerdead = Color3.fromRGB(0, 0, 70),

		machine = Color3.fromRGB(150, 150, 150),
		possessedmachine = Color3.fromRGB(87, 234, 249),
		completedmachine = Color3.fromRGB(255, 80, 250),

		item = Color3.fromRGB(0, 255, 0),
		rareitem = Color3.fromRGB(173, 65, 245),
		ultrarareitem = Color3.fromRGB(255, 141, 45),
		dangerousitem = Color3.fromRGB(255, 255, 0),

		elevator = Color3.fromRGB(80, 80, 80),
		fakeelevator = Color3.fromRGB(171, 171, 4),

		twisted = Color3.fromRGB(255, 0, 0),
		twistedobstacle = Color3.fromRGB(122, 7, 0),
	},

	hover = false,

	playerindicators = {
		username = true,
		displayname = true,
		stealth = true,
		inventory = true,
		abilitycooldown = true,
		tapes = true,
		ichor = true,
		twistedschasing = true
	},
	twistedindicators = {
		rarity = true,
		chasing = true,
		insight = true,
		sightcooldown = true
	},

	hidemachineespconditions = {
		completed = false,
		hasprogress = false,
		noprogress = false
	},
	itemespblacklist = {},
}

local function newhl(parent, fill, outline)
	local h = Instance.new("Highlight")
	h.FillColor = fill

	if not outline then
		local brightness = fill.R * 0.299 + fill.G * 0.587 + fill.B * 0.114
		h.OutlineColor = brightness > 0.6 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
	else
		h.OutlineColor = outline
	end

	h.FillTransparency = 0.5
	h.OutlineTransparency = 0
	h.Adornee = parent
	h.Parent = parent
	return h
end

local function clearhls(type)
	for _, h in pairs(esphandler[type].hls) do
		if h and h.Parent then h:Destroy() end
	end
	esphandler[type].hls = {}
end

local function setupplayeresp(state)
	if esphandler.player.conn then esphandler.player.conn:Disconnect() esphandler.player.conn = nil end
	clearhls("player")

	if not state then return end

	local function apply(player)
		if player == env.stuf.plr then return end
		if not env.stuf.plrfolder:FindFirstChild(player.Name) then return end

		local function onchar(char)
			if esphandler.player.hls[player.Name] then
				esphandler.player.hls[player.Name]:Destroy()
			end
			if esphandler.player.enabled then
				esphandler.player.hls[player.Name] = newhl(char, espsettings.colors.player)
				char.AncestryChanged:Connect(function()
					if not char.Parent and esphandler.player.hls[player.Name] then
						esphandler.player.hls[player.Name]:Destroy()
						esphandler.player.hls[player.Name] = nil
					end
				end)
			end
		end

		if player.Character then onchar(player.Character) end
		player.CharacterAdded:Connect(function(char)
			if esphandler.player.enabled then onchar(char) end
		end)
	end

	for _, player in ipairs(plrs:GetPlayers()) do
		apply(player)
	end

	esphandler.player.conn = plrs.PlayerAdded:Connect(function(player)
		if esphandler.player.enabled then apply(player) end
	end)
end

local function yield(this)
	repeat t() until this()
end

local function setuptwistedesp(state)
	if esphandler.twisted.conn then esphandler.twisted.conn:Disconnect() esphandler.twisted.conn = nil end
	clearhls("twisted")

	if not state then return end

	spwn(function()
		yield(function() return env.stuf.twisteds end)
		local folder = env.stuf.twisteds

		for _, model in ipairs(folder:GetChildren()) do
			if esphandler.twisted.enabled then
				esphandler.twisted.hls[model] = newhl(model, espsettings.colors.twisted)
			end
		end

		esphandler.twisted.conn = folder.ChildAdded:Connect(function(model)
			if esphandler.twisted.enabled then
				esphandler.twisted.hls[model] = newhl(model, espsettings.colors.twisted)
			end
		end)
	end)
end

local function setupitemesp(state)
	if esphandler.item.conn then esphandler.item.conn:Disconnect() esphandler.item.conn = nil end
	clearhls("item")

	if not state then return end

	spwn(function()
		yield(function() return env.stuf.items end)
		local folder = env.stuf.items

		for _, model in ipairs(folder:GetChildren()) do
			if esphandler.item.enabled then
				esphandler.item.hls[model] = newhl(model, espsettings.colors.item)
			end
		end

		esphandler.item.conn = folder.ChildAdded:Connect(function(model)
			if esphandler.item.enabled then
				esphandler.item.hls[model] = newhl(model, espsettings.colors.item)
			end
		end)
	end)
end

local function setupmachineesp(state)
	if esphandler.machine.conn then esphandler.machine.conn:Disconnect() esphandler.machine.conn = nil end
	clearhls("machine")

	if not state then return end

	spwn(function()
		yield(function() return env.stuf.machines end)
		local folder = env.stuf.machines

		for _, model in ipairs(folder:GetChildren()) do
			if esphandler.machine.enabled then
				esphandler.machine.hls[model] = newhl(model, espsettings.colors.machine)
			end
		end

		esphandler.machine.conn = folder.ChildAdded:Connect(function(model)
			if esphandler.machine.enabled then
				esphandler.machine.hls[model] = newhl(model, espsettings.colors.machine)
			end
		end)
	end)
end

local function setupelevatoresp(state)
	clearhls("elevator")
	if not state then return end

	if esphandler.elevator.enabled then
		yield(function() return env.stuf.elevator end)
		local elevator = env.stuf.elevator
		local door = elevator:FindFirstChild("ElevatorDoor")

		local h = newhl(door, espsettings.colors.elevator)
		esphandler.elevator.hls[door] = h
	end
end

local function setupfakeelevatoresp(state)
	if esphandler.fakeelevator.conn then esphandler.fakeelevator.conn:Disconnect() esphandler.fakeelevator.conn = nil end
	clearhls("fakeelevator")

	if not state then return end

	spwn(function()
		yield(function() return env.stuf.fakeelevator end)
		local elevator = env.stuf.fakeelevator
		local door = elevator:FindFirstChild("ElevatorDoor")

		if esphandler.fakeelevator.enabled then
			esphandler.fakeelevator.hls[door] = newhl(door, espsettings.colors.fakeelevator)
		end

		esphandler.fakeelevator.conn = env.stuf.freearea.ChildAdded:Connect(function(model)
			if esphandler.fakeelevator.enabled then
				if model.Name == "FakeElevator" then
					local door = model:FindFirstChild("ElevatorDoor")
					if door then
						esphandler.fakeelevator.hls[door] = newhl(door, espsettings.colors.fakeelevator)
					end
				end
			end
		end)
	end)
end

local function setuptwistedobstacleesp(state)
	if esphandler.twistedobstacle.conn then esphandler.twistedobstacle.conn:Disconnect() esphandler.twistedobstacle.conn = nil end
	if esphandler.twistedobstacle.blotconn then esphandler.twistedobstacle.blotconn:Disconnect() esphandler.twistedobstacle.blotconn = nil end
	clearhls("twistedobstacle")
	
	if not state then return end
	
	spwn(function()
		yield(function() return env.stuf.freearea end)

		local function addobstacle(obstacle)
			if not esphandler.twistedobstacle.enabled then return end
			if obstacle.Name:find("SproutTendril") then
				esphandler.twistedobstacle.hls[obstacle] = newhl(obstacle, espsettings.colors.twistedobstacle)
			end
		end

		local function addblothand(model)
			if not esphandler.twistedobstacle.enabled then return end
			if model.Name:find("BlotHand") then
				local innermodel = model:FindFirstChildWhichIsA("Model")
				local hand = innermodel and innermodel:FindFirstChild("Arm")
				if hand then
					esphandler.twistedobstacle.hls[hand] = newhl(hand, espsettings.colors.twistedobstacle)
				end
			end
		end

		if env.stuf.twistedobstacle then
			yield(function() return env.stuf.currentroom end)
			for _, obstacle in pairs(env.stuf.freearea:GetChildren()) do
				addobstacle(obstacle)
			end
			esphandler.twistedobstacle.conn = env.stuf.freearea.ChildAdded:Connect(addobstacle)

			for _, model in pairs(env.stuf.currentroom:GetChildren()) do
				addblothand(model)
			end
			esphandler.twistedobstacle.blotconn = env.stuf.currentroom.ChildAdded:Connect(addblothand)
		end
	end)
end

local function esp(type, state)
	if type == "player" then
		esphandler.player.enabled = state
		setupplayeresp(state)
	elseif type == "twisted" then
		esphandler.twisted.enabled = state
		setuptwistedesp(state)
	elseif type == "machine" then
		esphandler.machine.enabled = state
		setupmachineesp(state)
	elseif type == "item" then
		esphandler.item.enabled = state
		setupitemesp(state)
	elseif type == "elevator" then
		esphandler.elevator.enabled = state
		setupelevatoresp(state)
	elseif type == "fakeelevator" then
		esphandler.fakeelevator.enabled = state
		setupfakeelevatoresp(state)
	elseif type == "twistedobstacle" then
		esphandler.twistedobstacle.enabled = state
		setuptwistedobstacleesp(state)
	end
end

function env.funcs.reverifesp(state)
	if esphandler.twisted.enabled then setuptwistedesp(state) end
	if esphandler.item.enabled then setupitemesp(state) end
	if esphandler.machine.enabled then setupmachineesp(state) end
	if esphandler.fakeelevator.enabled then setupfakeelevatoresp(state) end
	if esphandler.twistedobstacle.enabled then setuptwistedobstacleesp(state) end
end

-------------------------------------------------------------------------------------------------------------------------------

noclipcolliderparts = {}
noclipfactiveconn = nil

function removeborders()
	if env.stuf.currentroom then
		for _, model in ipairs(env.stuf.currentroom:GetChildren()) do
			if model:IsA("Model") then
				for _, part in ipairs(model:GetDescendants()) do
					if part:IsA("BasePart") and part.Name == "NoClip_Collider" and part.Name ~= "plz dont clip through this plz plz" then
						if not noclipcolliderparts[part] then
							noclipcolliderparts[part] = part.CanCollide
							part.CanCollide = false
						end
					end
				end
			end
		end
	end
end

function restoreborders()
	for part, originalCollide in pairs(noclipcolliderparts) do
		if part and part.Parent then
			part.CanCollide = originalCollide
		end
	end
	table.clear(noclipcolliderparts)
end

function toggleborders(state)
	if not env.stuf.inrun then return end

	if state then
		if env.stuf.currentroom then removeborders() end

		noclipfactiveconn = env.funcs.getgamestat("flooractive").Changed:Connect(function(active)
			if active then
				removeborders()
			end
		end)
	else
		if noclipfactiveconn then noclipfactiveconn:Disconnect() noclipfactiveconn = nil end restoreborders()
	end
end

-------------------------------------------------------------------------------------------------------------------------------

antilaghandler = {}

function getdescninbatches(parent, batchSize)
	local batch = {}
	local currbatch = {}
	for i, child in ipairs(parent:GetDescendants()) do
		table.insert(currbatch, child)
		if #currbatch >= batchSize then
			table.insert(batch, currbatch)
			currbatch = {}
		end
	end
	if #currbatch > 0 then
		table.insert(batch, currbatch)
	end
	return batch
end

function antilag(state)
	local root = workspace

	if state then
		antilaghandler[root] = antilaghandler[root] or {}

		local batches = getdescninbatches(root, 1500)

		for _, batch in ipairs(batches) do
			for _, obj in ipairs(batch) do
				if obj:IsA("BasePart") or obj:IsA("MeshPart") then
					antilaghandler[root][obj] = antilaghandler[root][obj] or {}
					antilaghandler[root][obj].Material = obj.Material
					obj.Material = Enum.Material.SmoothPlastic

					local textures = {}
					for _, child in ipairs(obj:GetChildren()) do
						if child:IsA("Texture") or child:IsA("Decal") or child:IsA("SpecialMesh") then
							table.insert(textures, child:Clone())
							child:Destroy()
						end
					end
					antilaghandler[root][obj].Textures = textures

					local particles = {}
					for _, child in ipairs(obj:GetChildren()) do
						if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Fire") or child:IsA("Smoke") or child:IsA("Sparkles") then
							table.insert(particles, child:Clone())
							child:Destroy()
						end
					end
					antilaghandler[root][obj].Particles = particles
				end
			end
			t(0.5)
		end
	else
		if not antilaghandler[root] then return end

		for obj, backup in pairs(antilaghandler[root]) do
			if obj and obj.Parent then
				if backup.Material then
					obj.Material = backup.Material
				end

				if backup.Textures then
					for _, tex in ipairs(backup.Textures) do
						tex.Parent = obj
					end
				end

				if backup.Particles then
					for _, p in ipairs(backup.Particles) do
						p.Parent = obj
					end
				end
			end
		end

		antilaghandler[root] = nil
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "ESPs" },
	{ type = "toggle", title = "Player ESP", desc = "Toggles ESP for players.",
		callback = function(state) 
			esp("player", state)
		end
	},
	{ type = "toggle", title = "Twisted ESP", desc = "Toggles ESP for Twisteds.",
		callback = function(state) 
			esp("twisted", state)
		end
	},
	{ type = "toggle", title = "Machine ESP", desc = "Toggles ESP for machines.",
		callback = function(state) 
			esp("machine", state)
		end
	},
	{ type = "toggle", title = "Item ESP", desc = "Toggles ESP for items.",
		callback = function(state) 
			esp("item", state)
		end
	},
	{ type = "toggle", title = "Elevator ESP", desc = "Toggles ESP for the elevator.",
		callback = function(state) 
			esp("elevator", state)
		end
	},
	{ type = "toggle", title = "Fake elevator ESP", desc = "Toggles ESP for the fake elevator.",
		callback = function(state) 
			esp("fakeelevator", state)
		end
	},
	{ type = "toggle", title = "Twisted obstacle ESP", desc = "Toggles ESP for obstacles from Twisteds.",
		callback = function(state) 
			esp("twistedobstacle", state)
		end
	},
	{ type = "separator", title = "ESP Setitngs" },
	{ type = "toggle", title = "Hover ESP", desc = "Makes it so the ESP shows additional information on the mouse target.",
		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Twisted ESP indicators", desc = "Toggles the indicators shown in Twisted ESP.", 
		options = {"Rarity", "Chasing", "In sight", "Sight cooldown"},
		default = {"Rarity", "Chasing", "In sight", "Sight cooldown"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Player ESP indicators", desc = "Toggles the indicators shown in player ESP.", 
		options = {"Username", "Display name", "Stealth", "Inventory", "Ability cooldown", "Tapes", "Ichor", "Twisteds chasing"},
		default = {"Username", "Display name", "Stealth", "Inventory", "Ability cooldown", "Tapes", "Ichor", "Twisteds chasing"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Hide machine ESP conditions", desc = "Hides the ESP of a machine if it meets one of the selected conditions.", 
		options = {"Completed", "Has progress", "No progress"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Item ESP blacklist", desc = "Blacklists the selected items from being shown in ESP.", 
		options = {"Air Horn", "Bandage", "Bonbon", "Bottle o' Pop", "Box o' Chocolates", 
			"Chocolate", "Eject Button", "Extraction Speed Candy", "Event Currency", "Gumballs", 
			"Health Kit", "Jawbreaker", "Jumper Cable", "Pop", "Protein Bar", "Research Capsule", 
			"Skill Check Candy", "Smoke Bomb", "Speed Candy", "Stealth Candy", "Tape"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "separator", title = "Environment" },
	{ type = "button", title = "Reset lighting", desc = "Restores the lighting back to how it was when the script was executed.",
		callback = function() 
			killfb() 
			env.essentials.library.update("Fullbright", false)
			env.essentials.library.update("No fog", false)
			env.essentials.library.update("Alt fullbright", false)
			env.essentials.library.update("Daytime", false)
			relighting()
		end
	},
	{ type = "toggle", title = "No fog", desc = "Removes the fog.",
		commandcat = "Visuals",

		encommands = {"nofog"},
		encommanddesc = "Removes the fog",

		discommands = {"fog"},
		discommanddesc = "Restores the fog",

		callback = function(state) 
			nofog(state)
		end
	},
	{ type = "toggle", title = "Daytime", desc = "Makes it daytime.",
		commandcat = "Visuals",

		encommands = {"day"},
		encommanddesc = "Makes it daytime",

		discommands = {"night"},
		discommanddesc = "Makes it night time",

		callback = function(state) 
			l.ClockTime = state and 12 or 0
		end
	},
	{ type = "toggle", title = "Fullbright", desc = "Makes everything bright.",
		commandcat = "Visuals",

		encommands = {"fullbright"},
		enaliases = {"fb"},
		encommanddesc = "Makes everything bright",

		discommands = {"unfullbright"},
		disaliases = {"unfb"},
		discommanddesc = "Disables fullbright",

		callback = function(state) 
			togglefb(state)
		end
	},
	{ type = "toggle", title = "Alt fullbright", desc = "Makes everything less darker.",
		commandcat = "Visuals",

		encommands = {"alternativefullbright"},
		enaliases = {"afb"},
		encommanddesc = "Makes everything less darker",

		discommands = {"unalternativefullbright"},
		disaliases = {"unafb"},
		discommanddesc = "Disables alternative fullbright",

		callback = function(state) 
			toggleafb(state)
		end
	},
	{ type = "toggle", title = "Disable 3D rendering", desc = "Disables 3d rendering.",
		commandcat = "Visuals",

		encommands = {"render"},
		enaliases = {"3dr"},
		encommanddesc = "Enables 3D rendering",

		discommands = {"norender"},
		disaliases = {"no3dr"},
		discommanddesc = "Disables 3D rendering",

		callback = function(state) 
			norender(state)
		end
	},

	{ type = "separator", title = "Utility" },
	{ type = "toggle", title = "Anti lag", desc = "Removes textures and particles to improve performance. Processes in batches of 1500.",
		commandcat = "Visuals",

		encommands = {"antilag"},
		enaliases = {"al"},
		encommanddesc = "Enables anti lag",

		discommands = {"unantilag"},
		disaliases = {"unal"},
		discommanddesc = "Disables anti lag",

		callback = function(state) 
			antilag(state)
		end
	},
	{ type = "toggle", title = "Toggle barriers", desc = "Toggles the invisible barriers around the map.",
		commandcat = "Local Player",

		encommands = {"nobarriers"},
		enaliases = {"nob"},
		encommanddesc = "Destroys the invisible barriers",

		discommands = {"barriers"},
		disaliases = {"b"},
		discommanddesc = "Restores the invisible barriers",

		callback = function(state) 
			toggleborders(state)
		end
	},
	{ type = "toggle", title = "Infinite player billboard GUI distance", desc = "Makes every single player's BillboardGui have an infinite visibility distance.",
		commandcat = "Visuals",

		encommands = {"enableinfinitebillboarddistance"},
		enaliases = {"eibd"},
		encommanddesc = "Enables infinite player bullboard GUI distance",

		discommands = {"disableinfinitebillboarddistance"},
		disaliases = {"dibd"},
		discommanddesc = "Disables infinite player bullboard GUI distance",

		callback = function(state)
			infinitenametagdist(state)
		end
	},
	{ type = "toggle", title = "Show players' health bar", desc = "Shows the health stats GUI under every player in a run.",
		commandcat = "Visuals",

		encommands = {"showhealthbars"},
		enaliases = {"showhb", "shb"},
		encommanddesc = "Shows players' health bars",

		discommands = {"hidehealthbars"},
		disaliases = {"hidehb", "hhb"},
		discommanddesc = "Hides players' health bars",

		callback = function(state) 
			showhealth(state)
		end
	},
	{ type = "toggle", title = "Show players' Trinket loadout", desc = "Shows the Trinket loadout under every single player in a run.",
		commandcat = "Visuals",

		encommands = {"showtrinketloadouts"},
		enaliases = {"showtl", "stl"},
		encommanddesc = "Shows players' Trinket loadouts",

		discommands = {"hidetrinketloadouts"},
		disaliases = {"hidetl", "htl"},
		discommanddesc = "Hides players' Trinket loadouts",

		callback = function(state) 
			showtrinkets(state)
		end
	},

	{ type = "separator", title = "Audit logging" },
	{ type = "toggle", title = "Player audit logging", desc = "Monitors every single player's actions and logs it into the chat.",
		commandcat = "Visuals",

		encommands = {"enableplayerauditlogging"},
		enaliases = {"epal"},
		encommanddesc = "Enables player audit logging",

		discommands = {"disableplayerauditlogging"},
		disaliases = {"dpal"},
		discommanddesc = "Disables player audit logging",

		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Player audit log location", desc = "Indicates the location in which the player audit logs will be sent on.", 
		multiselect = true, 
		options = {"Chat (System)", "Chat (Player)", "Notification"},
		default = "Chat (System)",
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Player audit log actions", desc = "Sets the actions you want to be logged for player audit logs.", 
		options = {"Machine completed", "Item picked up", "Item used", "Ability used", "Talked / Used sticker"},
		default = {"Machine completed", "Item picked up", "Item used", "Ability used", "Talked / Used sticker"},
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Player audit log item blacklist", desc = "Blacklists the selected items from being logged from player audit logs.", 
		options = {"Air Horn", "Bandage", "Bonbon", "Bottle o' Pop", "Box o' Chocolates", 
			"Chocolate", "Eject Button", "Extraction Speed Candy", "Gumballs", 
			"Health Kit", "Instructions", "Jawbreaker", "Jumper Cable", "Pop", "Protein Bar", 
			"Skill Check Candy", "Smoke Bomb", "Speed Candy", "Stealth Candy", 
			"Stopwatch", "Valve"},
		multiselect = true,

		callback = function(selected) 
		end 
	},
	{ type = "toggle", title = "Twisted audit logging", desc = "Monitors every single Twisted's actions and logs it into the chat.",
		commandcat = "Visuals",

		encommands = {"enabletwistedauditlogging"},
		enaliases = {"etal"},
		encommanddesc = "Enables Twisted audit logging",

		discommands = {"disabletwistedauditlogging"},
		disaliases = {"dtal"},
		discommanddesc = "Disables Twisted audit logging",

		callback = function(state) 
		end
	},
	{ type = "dropdown", title = "Twisted audit log location", desc = "Indicates the location in which the Twisted audit logs will be sent on.", 
		multiselect = true, 
		options = {"Chat (System)", "Chat (Player)", "Notification"},
		default = "Chat (System)",
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Twisted audit log actions", desc = "Sets the actions you want to be logged for Twisted audit logs.", 
		options = {"Hit player", "Killed player", "Used ability"},
		default = {"Hit player", "Killed player", "Used ability"},
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Twisted audit log blacklist", desc = "Blacklists the selected Twisteds from being logged from Twisted audit logs.", 
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
		end 
	},
	{ type = "toggle", title = "Floor audit logging", desc = "Monitors the current floor for any changes and logs it into the chat.",
		commandcat = "Visuals",

		encommands = {"enablefloorauditlogging"},
		enaliases = {"efal"},
		encommanddesc = "Enables floor audit logging",

		discommands = {"disablefloorauditlogging"},
		disaliases = {"dfal"},
		discommanddesc = "Disables floor audit logging",

		callback = function(state)
		end
	},
	{ type = "dropdown", title = "Floor audit log location", desc = "Indicates the location in which the floor audit logs will be sent on.", 
		multiselect = true, 
		options = {"Chat (System)", "Chat (Player)", "Notification"},
		default = "Chat (System)",
		canbeempty = false,

		callback = function(selected) 
		end 
	},
	{ type = "dropdown", title = "Floor audit log actions", desc = "Sets the actions you want to be logged for floor audit logs.", 
		options = {"Map name", "Items on floor", "Twisteds on floor", "Floor event", "Twisteds on floor", "Indicate MVP", "Indicate Twisted MVP", "Dandy's stock"},
		default = {"Map name", "Items on floor", "Twisteds on floor", "Floor event", "Twisteds on floor", "Dandy's stock"},
		canbeempty = false,

		callback = function(selected) 
		end 
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
