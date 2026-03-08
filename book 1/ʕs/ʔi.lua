--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Script setup)

---------------------------------------------------------------------------------------------------------------------------]]--

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

-- findfirstchildofclass is faster than getservice according to MyWorld
local ws = FindFirstChildOfClass(game, "Workspace")
local rst = FindFirstChildOfClass(game, "ReplicatedStorage")
local plrs = FindFirstChildOfClass(game, "Players")
local rs = FindFirstChildOfClass(game, "RunService")
local txts = FindFirstChildOfClass(game, "TextService")
local ts = FindFirstChildOfClass(game, "TweenService")
local pfs = FindFirstChildOfClass(game, "PathfindingService")
local d = FindFirstChildOfClass(game, "Debris")
local https = FindFirstChildOfClass(game, "HttpService")
local contp = FindFirstChildOfClass(game, "ContentProvider")
local srgui = FindFirstChildOfClass(game, "StarterGui")
local mps = FindFirstChildOfClass(game, "MarketplaceService")
local ls = FindFirstChildOfClass(game, "LogService")

local core = FindFirstChildOfClass(game, "CoreGui")
local getgenv = (syn and syn.getgenv) or getgenv() or _G
local hiddenui = (syn and syn.gethui) or gethui() or FindFirstChildOfClass(game, "CoreGui")
local writefile = (syn and syn.writefile) or writefile
local readfile = (syn and syn.readfile) or readfile
local isfile = (syn and syn.isfile) or isfile
local delfile = (syn and syn.delfile) or delfile
local listfiles = (syn and syn.listfiles) or listfiles
local isfolder = (syn and syn.isfolder) or isfolder
local makefolder = (syn and syn.makefolder) or makefolder
local identifyexecutor = (syn and syn.identifyexecutor) or identifyexecutor
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI

-------------------------------------------------------------------------------------------------------------------------------

-- env setup
env.essentialsloaded, env.setupcomplete = nil
env.funcs, env.stuf, env.gear, env.essentials = {}, {}, {}, {}

env.essentials.library, env.essentials.data, env.essentials.sgui = nil
env.essentials.toggles, env.essentials.buttons, env.essentials.elements = {}, {}, {}

env.scriptinfo, env.filemanager = {}, {}

local function yield(this)
	repeat t() until this()
end

spwn(function()
	yield(function() return env.setupcomplete end) env.funcs.pop("Hi!")
	env.essentials.library = env.funcs.recursivels("book%201/%CA%95u/%CA%94l.lua", true) 
	env.funcs.box("UI library loaded successfully")

	env.essentials.data = env.funcs.recursivels("book%201/%CA%95s/%CA%94d.lua", true)
	env.funcs.box("script data loaded successfully")

	env.essentialsloaded = true
end)

-------------------------------------------------------------------------------------------------------------------------------

-- script info & file manager
spwn(function()
	yield(function() return env.essentialsloaded end)
	env.scriptinfo.script = {
		version = env.essentials.data.cl.current.version,
		subversion = env.essentials.data.cl.current.subversion,
		lastupdated = env.essentials.data.cl.current.subversion,
		changelog = env.essentials.data.cl.current.changelog
	}

	-- idk what ill use this for
	env.scriptinfo.library = {
		version = env.essentials.library.version
	}
end)

spwn(function()
	yield(function() return env.essentialsloaded end)
	env.filemanager.autoloadfile = folder .. "/Auto-loads.json"
	env.filemanager.configfolder = folder .. "/Configs"
	env.filemanager.persistfile = folder .. "/Persistent.json"

	-- will not get saved
	env.filemanager.saveblacklisted = {
		"Config name",
		"Auto-load lobby config",
		"Auto-load run config",
		"Auto-load roleplay config",

		"Toggle interface keybind",
		"Debug mode",
		"Keep on server switch",
		"Ignore full Research Twisteds",

		"Mainframe UI scale",
		"Button UI scale",

		"Closed captions",
		"Alternate Boxten personality",
		"Live Poppy reaction",
		"Live Shrimpo reaction",

		"Exclude yourself",
	}

	-- remains persistent
	env.filemanager.persist = {	
		"Auto-load lobby config",
		"Auto-load run config",
		"Auto-load roleplay config",

		"Toggle interface keybind",
		"Debug mode",
		"Keep on server switch",
		"Ignore full Research Twisteds",

		"Mainframe UI scale",
		"Button UI scale",

		"Closed captions",
		"Alternate Boxten personality",
		"Live Poppy reaction",
		"Live Shrimpo reaction",

		"Exclude yourself",
	}

	if not isfolder(folder) then makefolder(folder) end
	if not isfolder(env.filemanager.configfolder) then makefolder(env.filemanager.configfolder) end

	function env.filemanager.deleteconfig(name)
		local path = env.filemanager.configfolder .. "/" .. name .. ".json"
		if isfile(path) then
			delfile(path)
		end
	end

	function env.filemanager.listconfigs()
		local configs = env.filemanager.getconfigs()
		return table.concat(configs, ", ")
	end

	function env.filemanager.getconfigcount()
		local folderPath = env.filemanager.configfolder
		if isfolder(folderPath) then
			local files = listfiles(folderPath)
			local count = 0

			for _, path in ipairs(files) do
				if path:sub(-5):lower() == ".json" then
					count = count + 1
				end
			end

			return count
		end
		return 0
	end

	function env.filemanager.autoloadset(placeId, configName)
		local autoloads = {}
		if isfile(env.filemanager.autoloadfile) then
			autoloads = https:JSONDecode(readfile(env.filemanager.autoloadfile))
		end

		autoloads[tostring(placeId)] = configName
		writefile(env.filemanager.autoloadfile, https:JSONEncode(autoloads))
	end

	function env.filemanager.autoload()
		if isfile(env.filemanager.autoloadfile) then
			local autoloads = https:JSONDecode(readfile(env.filemanager.autoloadfile))
			local currentId = tostring(game.PlaceId)

			if autoloads[currentId] then
				local configToLoad = autoloads[currentId]

				task.delay(1, function()
					env.filemanager.loadconfig(configToLoad)
				end)
			end
		end
	end

	function env.filemanager.save(name, dataTable)
		local path = name
		if not name:find(env.filemanager.configfolder) then
			path = env.filemanager.configfolder .. "/" .. name .. ".json"
		end
		local success, encoded = pcall(function() return https:JSONEncode(dataTable) end)
		if success then
			writefile(path, encoded)
		end
	end

	function env.filemanager.load(name)
		local path = name
		if not name:find(env.filemanager.configfolder) then
			path = env.filemanager.configfolder .. "/" .. name .. ".json"
		end

		if isfile(path) then
			local content = readfile(path)

			local success, decoded = pcall(function() 
				return https:JSONDecode(content)
			end)

			if success then
				return decoded
			end
		end
		return nil
	end

	function env.filemanager.getconfigs()
		local files = listfiles(env.filemanager.configfolder)
		for i, path in ipairs(files) do
			local name = path:gsub(env.filemanager.configfolder .. "/", ""):gsub(".json", "")

			name = name:gsub(".*\\", "")

			files[i] = name
		end
		return files
	end

	function env.filemanager.persistsave()
		local data = {}
		for _, title in ipairs(env.filemanager.persist) do
			local element = env.essentials.toggles[title] or env.essentials.elements[title] or env.essentials.buttons[title]
			if element then
				if element.type == "toggle" then
					data[title] = element.enabled
				elseif element.type == "input" or element.type == "binder" then
					local target = element.instance or element.elementtitle
					data[title] = target and target.Text or ""
				elseif element.type == "slider" then
					data[title] = tonumber(element.instance and element.instance.Text) or 0
				end
			end
		end
		writefile(env.filemanager.persistfile, https:JSONEncode(data))
	end

	function env.filemanager.persistload()
		if not isfile(env.filemanager.persistfile) then return end
		local success, data = pcall(function() return https:JSONDecode(readfile(env.filemanager.persistfile)) end)
		if not success then return end

		for title, value in pairs(data) do
			local element = env.essentials.elements[title] or env.essentials.toggles[title] or env.essentials.buttons[title]
			if element and element.setValue then
				element.setValue(element.type == "slider" and tonumber(value) or value)
			elseif element and element.updtoggles then
				element.enabled = value
				element.updtoggles()
				if element.callback then task.spawn(element.callback, value) end
			end
		end
	end

	function env.filemanager.saveconfig(configName)
		local dataToSave = {}

		local function getPos(pos)
			if not pos then return nil end
			return {pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset}
		end

		for id, toggleData in pairs(env.essentials.toggles or {}) do
			if not toggleData.dirty then continue end
			if env.filemanager.saveblacklisted and table.find(env.filemanager.saveblacklisted, id) then continue end

			local buttonPos = nil
			if toggleData.currentButtonData and toggleData.currentButtonData.frame then
				buttonPos = getPos(toggleData.currentButtonData.frame.Position)
			elseif toggleData.buttonFrame then
				buttonPos = getPos(toggleData.buttonFrame.Position)
			end

			dataToSave[id] = {
				type = "toggle",
				enabled = toggleData.enabled,
				textValue = toggleData.inputbox and toggleData.inputbox.Text or nil,
				bind = toggleData.currentBind and toggleData.currentBind.Name or nil,
				buttonPos = buttonPos,
				hasSeparateButton = toggleData.currentButtonData ~= nil
			}
		end

		for id, buttonData in pairs(env.essentials.buttons or {}) do
			if not buttonData.dirty then continue end
			if env.filemanager.saveblacklisted and table.find(env.filemanager.saveblacklisted, id) then continue end

			local buttonPos = nil
			if buttonData.currentButtonData and buttonData.currentButtonData.frame then
				buttonPos = getPos(buttonData.currentButtonData.frame.Position)
			end

			dataToSave[id] = {
				type = "button",
				bind = buttonData.currentBind and buttonData.currentBind.Name or nil,
				buttonPos = buttonPos,
				hasSeparateButton = buttonData.currentButtonData ~= nil
			}
		end

		for id, data in pairs(env.essentials.elements or {}) do
			if not data.dirty then continue end
			if env.filemanager.saveblacklisted and table.find(env.filemanager.saveblacklisted, id) then continue end
			if dataToSave[id] then continue end

			local val = ""
			if data.type == "slider" then
				val = data.value or 0 
			elseif data.type == "input" or data.type == "binder" then
				val = data.instance and data.instance.Text or ""
			elseif data.type == "dropdown" then
				local current = data.getValue and data.getValue() or ""
				val = current
			end       

			dataToSave[id] = {
				type = "element",
				value = val,
				elementType = data.type
			}
		end

		env.filemanager.save(configName, dataToSave)
		--[[
		for _, t in pairs({env.essentials.toggles, env.essentials.buttons, env.essentials.elements}) do
			for _, el in pairs(t or {}) do
				el.dirty = false
			end
		end
		]]
	end

	function env.filemanager.loadconfig(configName)
		local path = env.filemanager.configfolder .. "/" .. configName .. ".json"
		if not configName or not isfile(path) then return end

		local data = env.filemanager.load(path)
		if not data or typeof(data) ~= "table" then return end

		for id, savedState in pairs(data) do
			local element = env.essentials.toggles[id] or env.essentials.buttons[id] or env.essentials.elements[id]

			if element then
				if savedState.type == "element" and element.setValue then
					local eType = savedState.elementType

					if eType == "slider" or eType == "input" then
						spwn(function() element.setValue(savedState.value) end)
					end
				end

				if savedState.elementType == "dropdown" or element.type == "dropdown" then
					if savedState.value ~= nil then
						spwn(function() element.setValue(savedState.value) end)
					end
				end

				if savedState.enabled ~= nil and element.type == "toggle" then
					element.enabled = savedState.enabled

					if savedState.textValue and element.inputbox then
						element.inputbox.Text = savedState.textValue
					end

					if element.updtoggles then spwn(function() element.updtoggles() end) end
					if element.callback then task.spawn(element.callback, element.enabled) end
				end

				if savedState.bind and element.elementtitle then
					local success, keycode = pcall(function() return Enum.KeyCode[savedState.bind] end)
					if success then
						element.currentBind = keycode
						local mappedName = env.essentials.library.mapkey(keycode)
						element.elementtitle.RichText = true
						element.elementtitle.Text = (element.title or id) .. " <font color='rgb(71, 190, 255)'>[" .. mappedName .. "]</font>"
						if element.updateSize then element.updateSize() end
					end
				end

				if savedState.hasSeparateButton and element.makeseperatebutton then
					if not element.currentButtonData then
						local dest = nil
						if savedState.buttonPos then
							local p = savedState.buttonPos
							dest = UDim2.new(p[1], p[2], p[3], p[4])
						end
						element.makeseperatebutton(dest)
					end
				end
			end
		end
	end

	-- main screengui
	env.essentials.sgui = Instance.new("ScreenGui")
	env.essentials.sgui.Name = folder
	env.essentials.sgui.ResetOnSpawn = false
	env.essentials.sgui.Parent = hiddenui
end)

-------------------------------------------------------------------------------------------------------------------------------

-- settings & essentials
do
	env.gear.general = {
		-- script settings
		debugmode = true,
		defaultkeybind = Enum.KeyCode.N,
		queueteleport = false,

		-- script adjustments
		ignoreresearchcompleted = true,
		itemtpposyoffset = -2.5,
		forcequitwhenteleportingtomach = false,

		-- blacklists
		encountertwistedblacklist = {},

		-- ui settings
		mainframescale = 1,
		buttonscale = 1,
	}

	env.gear.toons = {
		-- default order
		order = {
			main = "Boxten",
			commands = "Poppy",
			configs = "Shrimpo"
		},

		-- toon adjustments
		nicerboxten = false,
		livepoppyreaction = false,
		liveshrimporeaction = false,

		-- utility
		closedcaptions = true,
		sendmsgsinchat = false,
	}
end

-------------------------------------------------------------------------------------------------------------------------------

-- variables, tables & stuff
do
	-- intro handling
	env.stuf.introframes = {
		"rbxassetid://100574547642033",
		"rbxassetid://112676149480176",
		"rbxassetid://128483511908825",
		"rbxassetid://98526328079081",
		"rbxassetid://125620778551016",
		"rbxassetid://121840616986842",
		"rbxassetid://77486925388731",
		"rbxassetid://137768803650234",
		"rbxassetid://138559596051498",
		"rbxassetid://125881683664938",
		"rbxassetid://126560495448003",
		"rbxassetid://128833866484859",
		"rbxassetid://98939554909162",
		"rbxassetid://128264696403245",
		"rbxassetid://79832587316668",
		"rbxassetid://134447565090058",
		"rbxassetid://85041188928731",
		"rbxassetid://104581054761468",
		"rbxassetid://138081255923085",
		"rbxassetid://134107814899748",
		"rbxassetid://113122715441561",
		"rbxassetid://134270677515326",
		"rbxassetid://122970007395765",
		"rbxassetid://73100602199352",
		"rbxassetid://131853977343701",
		"rbxassetid://130994581118987",
		"rbxassetid://100257805271730",
		"rbxassetid://84219062653907",
		"rbxassetid://85039535413330",
		"rbxassetid://104454051555103",
		"rbxassetid://95591945463588",
		"rbxassetid://112381580508362",
		"rbxassetid://94229125660486",
		"rbxassetid://113611999423711",
		"rbxassetid://133881320303703",
		"rbxassetid://77421113211167",
		"rbxassetid://89036777888865",
		"rbxassetid://73750550023686",
		"rbxassetid://138551330795256",
		"rbxassetid://140596827838823",
		"rbxassetid://134328852872532",
		"rbxassetid://126321590854988",
		"rbxassetid://118215650732396",
		"rbxassetid://116912873522252",
		"rbxassetid://138749211750927",
		"rbxassetid://112410615754720",
		"rbxassetid://87534921561304",
		"rbxassetid://94429722030689",
		"rbxassetid://115973573575650",
		"rbxassetid://123535768889762",
		"rbxassetid://113859591165475",
		"rbxassetid://84719539704691",
		"rbxassetid://106599766300525",
		"rbxassetid://138236178832061",
		"rbxassetid://70662598652772",
		"rbxassetid://113918880141336",
		"rbxassetid://136755179377074",
		"rbxassetid://125174027961199",
		"rbxassetid://96461321002664",
		"rbxassetid://83151239852091",
		"rbxassetid://133688751922108",
		"rbxassetid://127315833656418",
		"rbxassetid://80681440397822",
		"rbxassetid://137361336195838",
		"rbxassetid://131241222856870",
		"rbxassetid://105604666874330",
		"rbxassetid://79318338619271",
		"rbxassetid://81572171746314",
		"rbxassetid://75482496976216",
		"rbxassetid://124623527027974",
		"rbxassetid://72048038318514",
		"rbxassetid://99000028633954",
		"rbxassetid://92926652673018",
		"rbxassetid://90116252251867",
		"rbxassetid://90868304789082",
		"rbxassetid://105758518193158",
		"rbxassetid://98518150995265",
		"rbxassetid://94489897468652",
		"rbxassetid://116637303866377",
		"rbxassetid://81142282647660",
		"rbxassetid://112327541806219",
	}

	local temp = Instance.new("ScreenGui", hiddenui)
	env.stuf.introholder = Instance.new("Frame")
	env.stuf.introholder.Size, env.stuf.introholder.BackgroundTransparency = UDim2.fromOffset(1, 1), 1
	env.stuf.introholder.Parent = temp
	d:AddItem(temp, 10)

	local assets = {}
	for _, id in ipairs(env.stuf.introframes) do
		local img = Instance.new("ImageLabel")
		img.Size, img.Image, img.Parent = UDim2.fromScale(1, 1), id, env.stuf.introholder
		img.BackgroundTransparency = 1
		table.insert(assets, img)
	end

	local introready = false

	spwn(function() contp:PreloadAsync(assets) introready = true end)

	local started = os.clock()

	repeat t() until introready or (os.clock() - started) >= 5

	-- key mapping
	env.stuf.keynamemapping = {
		Backslash = "\\", Slash = "/", Return = "<-",

		LeftBracket = "[", RightBracket = "]",
		LeftControl = "LC", RightControl = "RC",
		LeftShift = "LS", RightShift = "RS",
		LeftAlt = "LA", RightAlt = "RA",
		LeftMeta = "L@", RightMeta = "R@",

		Space = "Sp", Enter = "En", Tab = "Tb", Backspace = "Bs", CapsLock = "CL",
		Backquote = "`", Equals = "=", Semicolon = ";", Comma = ",", Period = ".", Minus = "-",

		One = "1", Two = "2", Three = "3", Four = "4", Five = "5",
		Six = "6", Seven = "7", Eight = "8", Nine = "9", Zero = "0",

		Up = "Up", Down = "Dn", Left = "Lt", Right = "Rt"
	}

	-- konami code
	env.stuf.konamicode = {
		["1"] = "Up", ["2"] = "Up",
		["3"] = "Down", ["4"] = "Down",
		["5"] = "Left", ["6"] = "Right",
		["7"] = "Left", ["8"] = "Right",
		["9"] = "B", ["10"] = "A",
		["11"] = "Return",
	}

	-- player character stuff
	env.stuf.plr = getins(plrs, "LocalPlayer")
	env.stuf.backpack = env.stuf.plr:WaitForChild("Backpack")
	env.stuf.user = getins(env.stuf.plr, "Name")
	env.stuf.displayname = getins(env.stuf.plr, "DisplayName")
	env.stuf.plrid = getins(env.stuf.plr, "UserId")

	env.stuf.char = env.stuf.plr.Character or env.stuf.plr.CharacterAdded:Wait()
	env.stuf.hum = env.stuf.char:WaitForChild("Humanoid")
	env.stuf.root = env.stuf.char:WaitForChild("HumanoidRootPart")

	env.stuf.cam = ws.CurrentCamera
	env.stuf.mouse = getins(env.stuf.plr, "GetMouse")(env.stuf.plr)
	env.stuf.plrgui = env.stuf.plr:WaitForChild("PlayerGui")

	env.stuf.plrstats = nil

	local function updcharrefs(char)
		if not char then return end
		env.stuf.char = char

		local statsfolder = env.stuf.char:WaitForChild("Stats", 5)
		if statsfolder then
			env.stuf.plrstats = statsfolder
		end

		local hum = char:WaitForChild("Humanoid", 5)
		if not hum then return end
		env.stuf.hum = hum

		local root = char:WaitForChild("HumanoidRootPart", 5)
		if not root then return end
		env.stuf.root = root
	end

	if env.stuf.char then updcharrefs(env.stuf.char) end env.stuf.plr.CharacterAdded:Connect(function(char) t() updcharrefs(char) end)
	ws:GetPropertyChangedSignal("CurrentCamera"):Connect(function() env.stuf.cam = ws.CurrentCamera end)

	-- game
	env.stuf.placeid = getins(game, "PlaceId")
	env.stuf.lobby, env.stuf.run, env.stuf.roleplay = 16116270224, 16552821455, 18984416148
	env.stuf.inlobby, env.stuf.inrun, env.stuf.inrp = env.stuf.placeid == env.stuf.lobby, env.stuf.placeid == env.stuf.run, env.stuf.placeid == env.stuf.roleplay

	env.stuf.gamemap = nil
	env.stuf.roomfolder, env.stuf.elevator = nil
	env.stuf.plrfolder = env.stuf.inrun and ws:WaitForChild("InGamePlayers") or ws:WaitForChild("Players")

	env.stuf.refconn, env.stuf.refconn2 = nil
	env.stuf.gameinfo, env.stuf.currentroom, env.stuf.freearea, env.stuf.twisteds, env.stuf.items, env.stuf.machines, env.stuf.fakeelevator = nil
	if env.stuf.inrun then
		spwn(function()
			yield(function() return env.setupcomplete end)
			env.stuf.elevator = ws:WaitForChild("Elevators"):WaitForChild("Elevator") env.funcs.box("found elevator model")
			env.stuf.roomfolder = ws:WaitForChild("CurrentRoom") env.funcs.box("found room model")

			local updrefsrunning = false

			local function updrefs()
				if updrefsrunning then return end
				updrefsrunning = true
				env.funcs.box("updating references")

				task.delay(0.2, function()
					updrefsrunning = false

					env.stuf.gameinfo = ws:FindFirstChild("Info")
					env.stuf.currentroom = env.funcs.getroom()

					if not env.stuf.currentroom then
						if env.stuf.refconn then env.stuf.refconn:Disconnect() env.stuf.refconn = nil end
						if env.stuf.refconn2 then env.stuf.refconn2:Disconnect() env.stuf.refconn2 = nil end
						env.funcs.pop("The room doesn't exist yet!")
						return
					end

					if env.stuf.refconn then env.stuf.refconn:Disconnect() env.stuf.refconn = nil end
					if env.stuf.refconn2 then env.stuf.refconn2:Disconnect() env.stuf.refconn2 = nil end

					env.stuf.freearea = env.stuf.currentroom:WaitForChild("FreeArea")
					env.stuf.fakeelevator = env.stuf.freearea:WaitForChild("FakeElevator")
					env.stuf.twisteds = env.stuf.currentroom:WaitForChild("Monsters")
					env.stuf.items = env.stuf.currentroom:WaitForChild("Items")
					env.stuf.machines = env.stuf.currentroom:WaitForChild("Generators")
					env.funcs.box("monitoring current room")

					env.stuf.refconn = env.stuf.currentroom.ChildAdded:Connect(updrefs)
					env.stuf.refconn2 = env.stuf.currentroom.ChildRemoved:Connect(updrefs)

					task.delay(0.1, function()
						if not env.stuf.visualssectionloaded then repeat t() until env.stuf.visualssectionloaded end
						env.funcs.reverifesp(true)
					end)
				end)
			end

			env.stuf.roomfolder.ChildAdded:Connect(updrefs)
			env.stuf.roomfolder.ChildRemoved:Connect(updrefs)
			env.funcs.box("monitoring room folder")
			updrefs()
		end)
	end

	-- ui
	env.stuf.mainframe, env.stuf.mainframesections = nil
	env.stuf.togglebutton, env.stuf.togglebuttondrag = nil
	env.stuf.popup = nil

	env.stuf.soundholder = hiddenui:FindFirstChild("aud")
	if not hiddenui:FindFirstChild("aud") then env.stuf.soundholder = Instance.new("Folder") env.stuf.soundholder.Name = "aud" env.stuf.soundholder.Parent = hiddenui end

	env.stuf.buttonscalelistenercount = 0
	env.stuf.buttonscalelisteners = {}
	env.stuf.mainframescale = Instance.new("UIScale")
	env.stuf.buttonscale = Instance.new("UIScale")

	spwn(function() 
		if not env.funcs.recursivels then repeat t() until function() return env.funcs.recursivels end end
		env.stuf.dialogue = env.funcs.recursivels("book%201/%CA%95u/%CA%94d.lua", true) 
	end)

	-- donor handling
	env.stuf.handshaker = {}
	env.stuf.handshaker.handshakenclients = {}
	env.stuf.handshaker.id = "rbxassetid://282574440BSGUI_"
	env.stuf.handshaker.donorid = "rbxassetid://188242481BSGUI_"
	env.stuf.handshaker.riddancekey = "rbxassetid://67riddance_chat_"
	env.stuf.handshaker.detectedRiddance = {}
	env.stuf.handshaker.cansend = true
	env.stuf.handshaker.commands = {}
	env.stuf.handshaker.excludeself = true
	env.stuf.handshaker.scanningplayers = false

	env.stuf.handshaker.animations = {
		check = Instance.new("Animation"),
		donor = Instance.new("Animation")
	}

	env.stuf.handshaker.tracks = {
		check = nil,
		donor = nil
	}

	spwn(function()
		if env.stuf.handshaker.scanningplayers then return end
		if not env.stuf.handshaker.monitor then repeat t() until function() return env.stuf.handshaker.monitor end end
		for _, plr in ipairs(plrs:GetPlayers()) do env.stuf.handshaker.monitor(plr) end plrs.PlayerAdded:Connect(function(plr) env.stuf.handshaker.monitor(plr) end)
		env.stuf.handshaker.scanningplayers = true
	end)

	for _, pass in ipairs({ 1085884381, 1318032362, 1480841694, 1480783676, 1481391576 }) do 
		spwn(function() 
			while t() do 
				local success, result = pcall(function() return mps:UserOwnsGamePassAsync(env.stuf.plrid, pass) end) 
				if success then 
					if result then 
						table.insert(env.essentials.data.autodonors, env.stuf.user) 
					end 
					break 
				end 
			end 
		end) 
	end
end

-------------------------------------------------------------------------------------------------------------------------------

-- functions
do
	-- debugging
	function env.funcs.getservertime() -- returns the server time
		return os.date("%H:%M:%S")
	end

	function env.funcs.box(s, force) -- output
		if env.gear.general.debugmode or force then
			print("[Boxten]: " .. tostring(s))
		end
	end

	function env.funcs.pop(s, force) -- warn
		if env.gear.general.debugmode or force then
			warn("[Poppy]: " .. tostring(s))
		end
	end

	function env.funcs.shr(s, force) -- error
		if env.gear.general.debugmode or force then
			error("[Shrimpo]: " .. tostring(s))
		end
	end

	-- utility
	function env.funcs.recursivels(link, frompath) -- replaces loadstring, tries to load the link 3 times if unsuccessful
		local atts = 1
		local start = os.clock()

		local success, result = pcall(function()
			local truelink = link
			if frompath then truelink = "https://raw.githubusercontent.com/bookworming/bookshelf/refs/heads/main/" .. link end
			local source = game:HttpGet(truelink)
			return loadstring(source)()
		end)

		if success then
			env.funcs.box(string.format("url loaded in %.3fs", os.clock() - start))
			return result
		else
			env.funcs.pop("URL failed!: " .. result)

			if atts < 3 then
				t(1)
				return env.funcs.recursivels(link, atts + 1)
			else
				env.funcs.shr("SOMETHING WENT WRONG. TRY AGAIN LATER. (" .. result .. ")")
				return nil
			end
		end
	end

	function env.funcs.datacheck(class, aim) -- checks whether the target user is in the specified userclass, returns true or false
		aim = aim or env.stuf.user
		for _, user in ipairs(class) do if user == aim then return true end end return false
	end

	function env.funcs.identifyexec() -- returns the user's executor
		local a, b = pcall(identifyexecutor) 

		if a and b then 
			return b 
		else 
			return "Unknown" 
		end 
	end

	function env.funcs.copytoclipboard(txt) -- copies a string to the player's clipboard
		if clipboard then 
			clipboard(tostring(txt))
		end 
	end

	function env.funcs.setcore(core, state) -- alternative to setcoreguienabled
		if core == "bag" then
			srgui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, state)

		elseif core == "console" then
			srgui:SetCore("DevConsoleVisible", state)
		end
	end

	function env.funcs.resolvetargets(i) -- resolves targets
		local t = {}
		if not i or (type(i) == "string" and i:match("^%s*$")) then return {env.stuf.plr} end

		local targets = {}

		if type(i) == "string" then
			for part in i:gmatch("[^,]+") do
				local trimmed = part:match("^%s*(.-)%s*$")
				if trimmed ~= "" then
					table.insert(targets, trimmed:lower())
				end
			end

		elseif type(i) == "table" then
			for _, part in ipairs(i) do
				if typeof(part) == "string" then
					local trimmed = part:match("^%s*(.-)%s*$")
					if trimmed ~= "" then
						table.insert(targets, trimmed:lower())
					end
				end
			end

		else
			return {env.stuf.plr}
		end

		local added = {}
		local function add(player)
			if player and not added[player] then
				table.insert(t, player)
				added[player] = true
			end
		end

		for _, part in ipairs(targets) do
			if part == "me" then
				add(env.stuf.plr)

			elseif part == "random" then
				local all = plrs:GetPlayers()
				if #all > 0 then
					add(all[math.random(1, #all)])
				end

			elseif part == "others" then
				for _, otherplr in ipairs(plrs:GetPlayers()) do
					if otherplr ~= env.stuf.plr then
						add(otherplr)
					end
				end

			elseif part == "all" then
				for _, otherplr in ipairs(plrs:GetPlayers()) do
					add(otherplr)
				end

			elseif part == "nonfriends" then
				for _, otherplr in ipairs(plrs:GetPlayers()) do
					if otherplr ~= env.stuf.plr and not env.stuf.plr:IsFriendsWith(otherplr.UserId) then
						add(otherplr)
					end
				end

			elseif part == "friends" then
				for _, otherplr in ipairs(plrs:GetPlayers()) do
					if otherplr ~= env.stuf.plr and env.stuf.plr:IsFriendsWith(otherplr.UserId) then
						add(otherplr)
					end
				end

			else
				for _, otherplr in ipairs(plrs:GetPlayers()) do
					local usernamematch = otherplr.Name:lower():find(part, 1, true)
					local displaymatch = otherplr.DisplayName:lower():find(part, 1, true)

					local toon = nil
					if otherplr.Character then
						toon = env.funcs.getstats("player", otherplr.Character).currenttoon
					end

					local toonmatch = toon and toon:lower():find(part, 1, true)

					if usernamematch or displaymatch or toonmatch then
						add(otherplr)
						break
					end
				end
			end
		end

		return t
	end

	function env.funcs.playsound(id, vol, pitch, timepos, parent) -- plays the target sound
		local s
		task.spawn(function()
			s = Instance.new("Sound")
			s.SoundId = id
			s.Volume = vol or 0.5
			s.TimePosition = timepos or 0
			s.PlaybackSpeed = pitch or 1
			s.Parent = parent or env.stuf.soundholder
			s.Ended:Connect(function() s:Destroy() end)
			s:Play()
		end)
		return s
	end

	-- game
	function env.funcs.getroom() -- checks if currentroom folder has a parent, returns the folders child or nil
		if env.stuf.gamemap and env.stuf.gamemap.Parent then return env.stuf.gamemap end
		env.stuf.gamemap = ws.CurrentRoom:FindFirstChildWhichIsA("Model")
		if env.stuf.gamemap then return env.stuf.gamemap else env.funcs.pop("Room not found.") return nil end
	end

	function env.funcs.exists(plr) -- checks if the player exists in the player folder (ingame and not ingame), returns true or false
		local exists, aim = nil, (plr and plr.Name) or env.stuf.user
		if not env.stuf.inrun then exists = env.stuf.plrfolder:FindFirstChild(aim) 
		else exists = env.stuf.plrfolder:FindFirstChild(aim) end
		return exists
	end

	function env.funcs.getstats(type, obj) -- returns a table full of the target objects stats, can fetch the floor, item, machine, twisted, and another players stats
		if not obj:IsA("Model") then env.funcs.shr("INVALID OBJECT, IDIOT!!!") end
		local name = obj.Name

		if type == "floor" then
			local floorname = env.stuf.currentroom.Name
			local hasdialoguetriggers = obj:GetAttribute("HasDialogueTriggers")

			local twistedsonfloor = {}
			for model in ipairs(env.stuf.twisteds:GetChildren()) do
				if model:IsA("Model") then
					table.insert(twistedsonfloor, model)
				end
			end

			local itemsonfloor = {}
			for model in ipairs(env.stuf.items:GetChildren()) do
				if model:IsA("Model") then
					table.insert(itemsonfloor, model)
				end
			end

			return {
				floorname = floorname, 
				twistedsonfloor = twistedsonfloor, 
				itemsonfloor = itemsonfloor, 
				hasdialoguetriggers = hasdialoguetriggers
			}

		elseif type == "item" then
			local prompt = obj:FindFirstChild("Prompt") or nil
			local act = prompt and prompt:FindFirstChildOfClass("ProximityPrompt") or nil

			local research
			if name == "ResearchCapsule" then 
				research = prompt and prompt:FindFirstChild("Monster").Value or 0
			end

			return {
				act = act, 
				research = research}

		elseif type == "machine" then
			local stats = obj:FindFirstChild("Stats")
			local pos = obj:FindFirstChild("TeleportPositions"):FindFirstChild("TeleportPosition").CFrame * CFrame.new(0, 2.3, 0)
			
			local prox
			if obj:FindFirstChild("Prompt") then
				prox = obj.Prompt:FindFirstChildOfClass("ProximityPrompt") or obj.Prompt.Attachment:FindFirstChildOfClass("ProximityPrompt")
			end

			local active = stats:FindFirstChild("ActivePlayer").Value
			local completed = stats:FindFirstChild("Completed").Value
			local possessed = stats:FindFirstChild("Connie").Value
			local amount = stats:FindFirstChild("CurrentAmount").Value
			local required = stats:FindFirstChild("RequiredAmount").Value

			local machtype = obj:GetAttribute("MinigameType")
			if machtype == "MovementTreadmill" then 
				machtype = "treadmill"
				pos = obj:FindFirstChild("TeleportPositions"):FindFirstChild("TreadmillTeleportPosition").CFrame * CFrame.new(0, 2.3, 0)
			elseif machtype == "Circle" then 
				machtype = "circle"
			else
				machtype = "normal"
			end

			return {
				pos = pos, 
				prox = prox,
				active = active, 
				completed = completed, 
				possessed = possessed, 
				amount = amount, 
				required = required, 
				machtype = machtype
			}

		elseif type == "twisted" then
			local name = obj.Name
			local troot = obj:FindFirstChild("HumanoidRootPart") or obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
			local chaser = obj:FindFirstChild("Chaser")

			local hearingrad, intrestrad, hitboxrad, visionrad, intresttime, LoS, hitcooldown
			if chaser then
				hearingrad = chaser:FindFirstChild("HearingRadius").Value or 0
				intrestrad = chaser:FindFirstChild("InstantRadius").Value or 0
				hitboxrad = chaser:FindFirstChild("HearingRadius").Value or 0
				visionrad = chaser:FindFirstChild("VisionRadius").Value or 0

				intresttime = chaser:FindFirstChild("InterestTime").Value or 0
				LoS = chaser:FindFirstChild("LineOfSight").Value or 0
				hitcooldown = chaser:FindFirstChild("HitCooldown").Value or 0
			end

			local chasing = obj:FindFirstChild("ChasingValue")
			local ischasing = chasing and chasing.Value ~= nil

			local hasability = obj:FindFirstChild("Grabbing") or nil
			local usingability = hasability and hasability.Value
			local alerted = obj:GetAttribute("Alerted") or nil

			local research
			local research = rst:FindFirstChild("PlayerData"):FindFirstChild(env.stuf.plrid):FindFirstChild("Research")
			local tr = research:FindFirstChild(name)
			if not tr then research = 0 else research = tr.Value end

			return {
				name = name, 
				troot = troot, 
				alerted = alerted, 
				research = research, 
				hearingrad = hearingrad, 
				intrestrad = intrestrad, 
				hitboxrad = hitboxrad, 
				visionrad = visionrad, 
				intresttime = intresttime, 
				LoS = LoS, 
				hitcooldown = hitcooldown,
				chasing = chasing, 
				ischasing = ischasing, 
				hasability = hasability, 
				usingability = usingability
			}

		elseif type == "player" then
			local inserver = plrs:FindFirstChild(obj.Name)

			if not inserver then return end

			local ins = inserver and plrs:FindFirstChild(obj.Name)
			local currenttoon = obj:FindFirstChild("Config"):FindFirstChild("ModuleName").Value

			if not env.stuf.inrun then return {ins, currenttoon} end

			local icon = obj:FindFirstChild("Config"):FindFirstChild("Icon").Texture
			local runstats = env.stuf.gameinfo:FindFirstChild("PlayerStats"):FindFirstChild(ins.Name)

			local capsulespickedup = runstats:FindFirstChild("Capsules").Value
			local itemspickedup = runstats:FindFirstChild("Items").Value
			local machinescompleted = runstats:FindFirstChild("Generators").Value
			local ichorearned = runstats:FindFirstChild("Ichor").Value
			local twistedsencountered = runstats:FindFirstChild("Monsters").Value
			local tapescollected = runstats:FindFirstChild("SurvivalPoints").Value
			local toonpicked = ins:GetAttribute("SelectedCharacter")

			local dead = inserver and not ws:FindFirstChild("InGamePlayers"):FindFirstChild(ins.Name)
			local left = inserver == false

			local function fetchitem(slot)
				local ins = obj:FindFirstChild("Inventory"):FindFirstChild("Slot" .. slot)
				if slot == 4 then if not ins then return "None" end end
				return ins.Value
			end

			local function fetchtrinket(slot)
				return ins:GetAttribute("EquippedTrinket" .. slot)
			end

			local slot1, slot2, slot3, slot4 = fetchitem(1), fetchitem(2), fetchitem(3), fetchitem(4)
			local inventoryfull = slot1 ~= "None" and slot2 ~= "None" and slot3 ~= "None" and (slot4 and slot4 ~= "None")
			local trinket1, trinket2 = fetchtrinket(1), fetchtrinket(2)

			local extracting = obj:FindFirstChild("Decoding").Value
			local currentstealth = ins:GetAttribute("Stealth")
			local twistedschasing = ins:GetAttribute("ChaseCount")

			local abilitycooldown, currentabilitycooldown

			for _, ability in pairs(obj:FindFirstChild("Abilities"):GetChildren()) do
				if ability:FindFirstChild("Cooldown") then
					abilitycooldown = ability:FindFirstChild("Cooldown").Value
					currentabilitycooldown = ability:FindFirstChild("CurrentCooldown").Value
				end
			end

			return {
				currentstealth = currentstealth, 
				twistedschasing = twistedschasing, 
				currenttoon = currenttoon, 
				inserver = inserver, 
				ins = ins, 
				dead = dead, 
				left = left, 
				capsulespickedup = capsulespickedup, 
				itemspickedup = itemspickedup, 
				machinescompleted = machinescompleted, 
				ichorearned = ichorearned, 
				twistedsencountered = twistedsencountered, 
				tapescollected = tapescollected, 
				toonpicked = toonpicked, 
				slot1 = slot1, 
				slot2 = slot2, 
				slot3 = slot3, 
				slot4 = slot4, 
				trinket1 = trinket1, 
				trinket2 = trinket2, 
				extracting = extracting, 
				icon = icon, 
				abilitycooldown = abilitycooldown, 
				currentabilitycooldown = currentabilitycooldown
			}
		end
	end

	function env.funcs.getgamestat(stat) -- returns the value of the target game stat
		local gamestats = {
			gamestarted = env.stuf.gameinfo:FindFirstChild("GameStarted").Value,
			cardvoting = env.stuf.gameinfo:FindFirstChild("CardVoting").Value,
			dandyselling = env.stuf.gameinfo:FindFirstChild("DandyStoreOpen").Value,
			currentfloor = env.stuf.gameinfo:FindFirstChild("Floor").Value,
			flooractive = env.stuf.gameinfo:FindFirstChild("FloorActive").Value,
			panicmode = env.stuf.gameinfo:FindFirstChild("Panic").Value,
			machscompleted = env.stuf.gameinfo:FindFirstChild("GeneratorsCompleted").Value,
			machsrequired = env.stuf.gameinfo:FindFirstChild("RequiredGenerators").Value,
			blackout = env.stuf.gameinfo:FindFirstChild("BlackOut").Value,
			playersalive = env.stuf.gameinfo:FindFirstChild("ActivePlayers").Value,
			boughtnothingfor = env.stuf.gameinfo:FindFirstChild("DandyTracker"):FindFirstChild("NoBuy").Value,
			message = env.stuf.gameinfo:FindFirstChild("Message").Value
		}

		return stat and gamestats[stat] or gamestats
	end

	function env.funcs.useitem(slot, breakifoneused)
		if slot == "all" then
			for i = 1, 4 do
				local slotn = "Slot" .. i
				local slotvalue = env.funcs.getstats("player", env.stuf.char)[slotn:lower()]
				
				if slotvalue ~= "None" then
					local args = {
						env.stuf.char,
						game:GetService("Players").LocalPlayer.Character:WaitForChild("Inventory"):WaitForChild(slotn)
					}
					rst.Events.ItemEvent:InvokeServer(unpack(args))
					
					if breakifoneused then
						local newslotvalue = env.funcs.getstats("player", env.stuf.char)[slotn:lower()]
						if newslotvalue == "None" then
							break
						end
					end
				end
			end
		else
			local args = {
				env.stuf.char,
				game:GetService("Players").LocalPlayer.Character:WaitForChild("Inventory"):WaitForChild("Slot" .. slot)
			}
			rst.Events.ItemEvent:InvokeServer(unpack(args))
		end
	end

	function env.funcs.veemoteactive() -- returns the vmotes value if the user has it, true if active, false if inactive
		local folder = env.stuf.char:FindFirstChild("Trinkets")
		if folder then
			for _, trinket in ipairs(folder:GetChildren()) do
				if trinket.Value == "VeeRemote" then
					local active = trinket:FindFirstChild("Active")
					if active then
						return active.Value
					end
				end
			end
		else
			env.funcs.pop("Trinkets folder not found!")
		end
	end

	function env.funcs.teleportplr(cf) -- teleports the player to the target cframe
		ws.Gravity = 0
		env.stuf.root.AssemblyLinearVelocity = Vector3.zero
		env.stuf.char:PivotTo(cf)
		ws.Gravity = 196.2
	end

	function env.funcs.tpbypass(cf, usebypass) -- teleports the player to the target cframe using a teleport bypass
		local x = env.stuf.root.Position.X
		local z = env.stuf.root.Position.Z

		if usebypass then
			while not env.stuf.plr:GetAttribute("isBeingTeleported") do 
				local bp = ws.Baseplate
				local y = bp.Position.Y + (bp.Size.Y / 2) + 2

				env.funcs.teleportplr(CFrame.new(x + math.random(), y + math.random(), z + math.random())) t()
			end
		end

		env.funcs.teleportplr(cf)
		-- t(0.1) for i = 1, 15 do env.funcs.teleportplr(cf) t() end
	end

	local currenttweenid = 0
	function env.funcs.tweenplr(cf) -- tweens the player to the target cframe
		currenttweenid = currenttweenid + 1
		local id = currenttweenid

		local duration = env.stuf.inrun and (env.stuf.root.Position - cf.Position).Magnitude / (env.stuf.plr:GetAttribute("KM_MAX_PLAYER_SPEED") * 1.25) or 0.7
		ws.Gravity = 0 
		env.stuf.root.AssemblyLinearVelocity = Vector3.zero

		local tween = ts:Create(env.stuf.root, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {CFrame = cf})
		tween:Play()

		local completed = false
		tween.Completed:Connect(function()
			completed = true
		end)

		while not completed do
			t()
			if currenttweenid ~= id then
				tween:Cancel()
				return
			end
		end

		ws.Gravity = 196.2
	end

	local currentpfid = 0
	function env.funcs.pathfindto(cf, showwps) -- creates a path to the target cframe for the player to walk to, showwps shows the paths waypoints
		currentpfid = currentpfid + 1
		local id = currentpfid

		local path = pfs:CreatePath({
			AgentRadius = 2, 
			AgentHeight = 6, 
			AgentCanJump = false,
			WaypointSpacing = 4
		})

		local succ, err = pcall(function()
			path:ComputeAsync(env.stuf.root.Position, cf.Position)
		end)

		if succ and path.Status == Enum.PathStatus.Success then
			local waypoints = path:GetWaypoints()

			if showwps then
				for _, waypoint in ipairs(waypoints) do
					if currentpfid ~= id then return end 

					local p = Instance.new("Part")
					p.Size = Vector3.new(0.6, 0.6, 0.6)
					p.Position = waypoint.Position
					p.Anchored = true
					p.CanCollide = false
					p.Material = Enum.Material.Neon
					p.Shape = Enum.PartType.Ball
					p.Color = Color3.new(1, 0, 0)
					p.Parent = workspace
					d:AddItem(p, 5)
				end
			end

			for i, waypoint in ipairs(waypoints) do
				if currentpfid ~= id then 
					return 
				end

				env.stuf.hum:MoveTo(waypoint.Position)

				local reached = false
				local timeout = task.delay(2, function()
					if not reached and currentpfid == id then
						env.funcs.pop("Player stuck! Re-calculating...")
						env.stuf.hum:MoveTo(env.stuf.root.Position)
						env.funcs.pathfindto(cf, showwps)
					end
				end)

				reached = env.stuf.hum.MoveToFinished:Wait()
				task.cancel(timeout)

				if not reached then break end
			end
		else
			if currentpfid == id then
				env.funcs.pop("Path failed:", err)
			end
		end
	end

	function env.funcs.moveplr(cf, method, spec) -- moves the player to the target cframe using the specified method (spec being the options)
		if not method then method = "tp" end

		if method == "tp" then
			env.funcs.tpbypass(cf, spec or false)

		elseif method == "tween" then
			env.funcs.tweenplr(cf)

		elseif method == "pf" then
			env.funcs.pathfindto(cf, spec or false)
		end
	end

	-- ui
	function env.funcs.popup(desc, notext, nocallback, yestext, yescallback) -- popup
		if env.stuf.popup then env.stuf.popup:Destroy() env.stuf.popup = nil end

		env.stuf.popup = env.essentials.library.makecoolframe(UDim2.new(0, 310, 0, 250), env.essentials.sgui, false, true, UDim2.new(0.5, 0, -0.4, 0), nil, nil, nil, 9000)
		spwn(function() env.essentials.library.centerui(env.stuf.popup, false, Enum.EasingStyle.Back) end)

		env.essentials.library.addcooltab(UDim2.new(0, 200, 0, 40), env.stuf.popup, UDim2.new(0, 120, 0, -12), "Noxious: Boxten Sex GUI")
		local close = env.essentials.library.addclosebutton(UDim2.new(0, 48, 0, 27), env.stuf.popup, UDim2.new(0.5, 110, 0, 0), "X", 22)
		close.Activated:Connect(function() env.stuf.popup:Destroy() env.stuf.popup = nil end)

		env.essentials.library.makecooltext(env.stuf.popup, UDim2.new(1, -30, 0, 90), "Hold it!", 20, nil, 2, UDim2.new(0.5, 0, 0.5, -102), nil, nil, nil, 9001)

		local textcontainer = Instance.new("Frame")
		textcontainer.Size = UDim2.new(0, 274, 0, 92)
		textcontainer.BorderSizePixel = 0
		textcontainer.AnchorPoint = Vector2.new(0.5, 0)
		textcontainer.Position = UDim2.new(0.5, 0, 0, 48)
		textcontainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		textcontainer.BackgroundTransparency = 0.7
		textcontainer.ZIndex = 9001
		textcontainer.Parent = env.stuf.popup

		Instance.new("UICorner", textcontainer).CornerRadius = UDim.new(0, 14)

		local pb = Instance.new("UIStroke")
		pb.Thickness = 2
		pb.Color = Color3.fromRGB(0, 0, 0)
		pb.Transparency = 0.6
		pb.Parent = textcontainer

		env.essentials.library.makecooltext(textcontainer, UDim2.new(1, 0, 1, 0), desc or "This is a warning.", 14, nil, 2, UDim2.new(0.5, 0, 0.5, 0), Enum.TextXAlignment.Center, Enum.TextYAlignment.Center, nil, 9001)

		local no = env.essentials.library.makecoolbutton(notext or "No", UDim2.new(0, 277, 0, 32), env.stuf.popup, UDim2.new(0.5, 0, 0.5, 45), "yes", 21, nil, 9001)
		local yes = env.essentials.library.makecoolbutton(yestext or "Yes", UDim2.new(0, 277, 0, 32), env.stuf.popup, UDim2.new(0.5, 0, 0.5, 90), "no", 21, nil, 9001)

		no.Activated:Connect(function()
			if nocallback then nocallback() end
			env.stuf.popup:Destroy() env.stuf.popup = nil
		end)

		yes.Activated:Connect(function()
			if yescallback then yescallback() end
			env.stuf.popup:Destroy() env.stuf.popup = nil
		end)
	end

	-- donor
	function env.stuf.handshaker.addcmd(name, func)
		if env.stuf.handshaker.commands[name] then end
		env.stuf.handshaker.commands[name] = func
	end

	function env.stuf.handshaker.isscriptuser(player)
		if not player then return false end

		if table.find(env.stuf.handshaker.handshakenclients, player.Name) then
			return true
		end

		if player == env.stuf.plr then
			return true
		end

		return false
	end

	function env.stuf.handshaker.donorsend(id)
		if not env.stuf.handshaker.cansend then return end env.stuf.handshaker.cansend = false

		env.stuf.handshaker.animations.donor.AnimationId = env.stuf.handshaker.donorid .. " " .. id

		local animator = env.stuf.hum:FindFirstChildOfClass("Animator")

		if not env.stuf.handshaker.tracks.donor then
			env.stuf.handshaker.tracks.donor = animator:LoadAnimation(env.stuf.handshaker.animations.donor)
		end

		if animator and env.stuf.handshaker.tracks.donor then
			local track = env.stuf.handshaker.tracks.donor
			track:Play()
			track:AdjustWeight(0.0001)

			task.delay(0.1, function()
				track:Stop()
				env.stuf.handshaker.cansend = true
			end)
		end
	end

	function env.stuf.handshaker.processincoming(player, animId)
		if animId:sub(1, #env.stuf.handshaker.donorid) == env.stuf.handshaker.donorid then
			local fullCmdString = animId:sub(#env.stuf.handshaker.donorid + 2)

			local chatMessage = fullCmdString:match("^send%s(.+)")
			if chatMessage then
				if table.find(env.stuf.handshaker.handshakenclients, player.Name) then
					env.funcs.logchat(chatMessage, player.Name)
				end
				return
			end

			local cmd, data = fullCmdString:match("^(%w+)%s?(.*)")
			if cmd and table.find(env.stuf.handshaker.handshakenclients, player.Name) then
				local commandFunc = env.stuf.handshaker.commands[cmd:lower()]
				if commandFunc then
					spwn(function()
						commandFunc(player, data)
					end)
				end
			end
		end
	end

	local function fixid(id)
		id = tostring(id)
		id = id:gsub("http://www%.roblox%.com/asset/%?id=", "rbxassetid://")
		id = id:gsub("https://www%.roblox%.com/asset/%?id=", "rbxassetid://")
		if not id:find("rbxassetid://") then
			id = "rbxassetid://" .. id
		end
		return id
	end

	function env.stuf.handshaker.shakehands(player, animator)
		animator.AnimationPlayed:Connect(function(track)
			if not track or not track.Animation then return end

			local animId = fixid(track.Animation.AnimationId)

			if animId == fixid(env.stuf.handshaker.id) and math.abs(track.WeightTarget - 0.001) < 0.001 then
				if not table.find(env.stuf.handshaker.handshakenclients, player.Name) then
					table.insert(env.stuf.handshaker.handshakenclients, player.Name)
					if env.funcs.refreshuserlist() then env.funcs.refreshuserlist() end
					if player.Name == env.stuf.user then
						env.funcs.consolelog("Assigned yourself as a script user.")
					else
						env.funcs.consolelog("Shook hands with another client!")
					end
				end
				return
			end

			if animId:find(env.stuf.handshaker.riddancekey) then
				if not table.find(env.stuf.handshaker.detectedRiddance, player.Name) then
					table.insert(env.stuf.handshaker.detectedRiddance, player.Name)
					local extractedText = animId:match("chat_(.+)")

					if extractedText then
						env.funcs.logchat(extractedText, player.Name, true)
						env.funcs.consolelog("Riddance Hub user detected!")
						if env.funcs.refreshuserlist() then env.funcs.refreshuserlist() end
					end
				end
				return
			end

			env.stuf.handshaker.processincoming(player, animId)
		end)
	end

	function env.stuf.handshaker.monitor(player)
		local function added(char)
			local hum = char:WaitForChild("Humanoid", 10)
			local animator = hum and hum:WaitForChild("Animator", 10)
			if animator then
				env.stuf.handshaker.shakehands(player, animator)
			end
		end

		if player.Character then added(player.Character) end
		player.CharacterAdded:Connect(added)
	end

	function env.stuf.handshaker.requesthandshake()
		if env.funcs.exists() then
			env.stuf.handshaker.animations.check.AnimationId = fixid(env.stuf.handshaker.id)
			local animator = env.stuf.hum:FindFirstChildOfClass("Animator")

			if not env.stuf.handshaker.tracks.check then
				if animator then
					env.stuf.handshaker.tracks.check = animator:LoadAnimation(env.stuf.handshaker.animations.check)
				end
			end

			if animator and env.stuf.handshaker.tracks.check then
				local track = env.stuf.handshaker.tracks.check
				track.Priority = Enum.AnimationPriority.Action
				track:Play()
				track:AdjustWeight(0.0001)
				task.delay(0.2, function()
					track:Stop()
					env.funcs.box("sent handshake request")
				end)
			end
		else
			env.funcs.pop("Character not found, cannot send handshake request.")
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------

env.setupcomplete = true
env.funcs.box("hello") -- hi!

-------------------------------------------------------------------------------------------------------------------------------
