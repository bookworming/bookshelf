--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI
   
---------------------------------------------------------------------------------------------------------------------------]]--

if not game:IsLoaded() then game.Loaded:Wait() end local t = task.wait

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local plrs = FindFirstChildOfClass(game, "Players")
local rs = game:GetService("RunService")
local uis = FindFirstChildOfClass(game, "UserInputService")
local ts = FindFirstChildOfClass(game, "TweenService")

local hiddenui = gethui() or game:GetService("CoreGui")
local getgenv = (syn and syn.getgenv) or getgenv() or _G
local writefile = (syn and syn.writefile) or writefile
local isfolder = (syn and syn.isfolder) or isfolder
local makefolder = (syn and syn.makefolder) or makefolder

local folder = "Bоxten Sеx GUI"
local mobile = uis.TouchEnabled
local debugmode = true

-------------------------------------------------------------------------------------------------------------------------------

-- main & env setup
getgenv.BSGUI = {} 
local env = getgenv.BSGUI
local setupsucc, setuperr = pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/bookworming/bookshelf/refs/heads/main/book%201/%CA%95s/%CA%94i.lua"))() end)

repeat t() until env.setupcomplete and env.essentialsloaded
env.expectedcompiledscriptversion = 1 
env.funcs.box("setup complete, expected CSV: " .. env.expectedcompiledscriptversion)

-------------------------------------------------------------------------------------------------------------------------------

local function tween(obj, info, goal)
	local tween = ts:Create(obj, TweenInfo.new(unpack(info)), goal)
	tween:Play()
	return tween
end

local function intro(container)
	local display = Instance.new("ImageLabel")
	display.Size, display.BackgroundTransparency, display.ImageTransparency = UDim2.fromScale(1, 1), 1, 1
	display.Parent = container

	t(1)

	task.delay(0.15, function() tween(display, {0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {ImageTransparency = 0}) end)

	local currentFrame, nextFrameTime = 1, 0
	local connection
	connection = rs.RenderStepped:Connect(function()
		local now = os.clock()
		if now >= nextFrameTime then
			display.Image = env.stuf.introframes[currentFrame]
			currentFrame = currentFrame + 1
			nextFrameTime = now + (1 / 70)
			if currentFrame > #env.stuf.introframes then
				connection:Disconnect()
				env.stuf.introholder:Destroy()
			end
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

env.stuf.mainframe, env.stuf.mainframesections = env.essentials.library.loadmainframe(env.essentials.sgui)
local mainframe, togglebutton = env.stuf.mainframe, nil

local function loadintro(buttononly)
	local function typein(label, text)
		label.Text = ""
		for i = 1, #text do
			label.Text = text:sub(1, i)
			rs.RenderStepped:Wait()
		end
	end

	local function backspace(label)
		local text = label.Text
		for i = #text, 0, -1 do
			label.Text = text:sub(1, i)
			rs.RenderStepped:Wait()
		end
	end

	local function alive()
    local existing = togglebutton:FindFirstChildOfClass("UIScale")
    if existing then existing:Destroy() end

    local scale = Instance.new("UIScale", togglebutton)
    local baseScale = env.gear.general.buttonscale or 1
    scale.Scale = baseScale

    local hover = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local press = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local currenttween
    local function scaleTo(v, info)
      if currenttween then currenttween:Cancel() end
      currenttween = ts:Create(scale, info, { Scale = baseScale * v })
      currenttween:Play()
    end

    env.stuf.setbuttonscale = function(v)
        baseScale = v
        env.stuf.buttonscale.Scale = v  -- keep the table in sync
        ts:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = baseScale }):Play()
        if env.stuf.buttonscalelisteners then
          for _, listener in pairs(env.stuf.buttonscalelisteners) do
            listener(v)
          end
        end
    end

    env.stuf.buttonscale = {
        Scale = baseScale,
    }

    local hover = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local press = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local currenttween

    togglebutton.AnchorPoint = Vector2.new(0.5, 0.5)
    togglebutton.Position = UDim2.new(0.5, 0, 0, 100)

    env.stuf.togglebutton = togglebutton
    env.stuf.togglebuttondrag = env.essentials.library.makedraggable(togglebutton)

    togglebutton.MouseEnter:Connect(function() env.essentials.library.hov() scaleTo(1.02, hover) end)
    togglebutton.MouseLeave:Connect(function() scaleTo(1, hover) end)
    togglebutton.MouseButton1Up:Connect(function() scaleTo(1.02, hover) end)
    togglebutton.MouseButton1Down:Connect(function() scaleTo(0.98, press) end)
    togglebutton.Activated:Connect(function()
      if env.stuf.togglebuttondrag.dragged then return end
      env.essentials.library.clik()
      mainframe.Visible = not mainframe.Visible
    end)

    uis.InputBegan:Connect(function(input, processed)
      if not processed and input.KeyCode == env.gear.general.defaultkeybind then
        mainframe.Visible = not mainframe.Visible
        env.essentials.library.clik()
      end
    end)
	end

	local js
	if not buttononly then
		js = Instance.new("Frame")
		js.Parent, js.AnchorPoint, js.BackgroundTransparency = env.essentials.sgui, Vector2.new(0.5, 0.5), 1
		js.Size, js.Position, js.ZIndex = UDim2.new(1, 1, 2, 0), UDim2.new(0.5, 0, 0.5, -1), 100001

		local aspect = Instance.new("UIAspectRatioConstraint")
		aspect.AspectRatio, aspect.DominantAxis, aspect.Parent = 1.5, Enum.DominantAxis.Height, js

		spwn(function() intro(js) end)

		tween(js, {3.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.new(1, 0, 0, 243)}).Completed:Wait()
		t()
	end

	local hi = env.essentials.library.makecoolframe(UDim2.fromOffset(1, 1), env.essentials.sgui, true, false, nil, nil, nil, true)
	tween(hi, {buttononly and 0 or 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.fromOffset(64, 64)})

	if buttononly then
		hi.Position = UDim2.new(0.5, 0, 0, -100)
		tween(hi, {1, Enum.EasingStyle.Back, Enum.EasingDirection.Out}, {Position = UDim2.new(0.5, 0, 0, 100)})
		hi.Size = UDim2.fromOffset(64, 64)
		togglebutton = hi
		togglebutton.ZIndex = 100000

		local ico = Instance.new("ImageLabel")
		ico.Size, ico.Position, ico.AnchorPoint = UDim2.fromOffset(92, 92), UDim2.fromScale(0.5, 0.5), Vector2.new(0.5, 0.5)
		ico.BackgroundTransparency, ico.Parent, ico.Image = 1, hi, env.stuf.introframes[1]
		ico.ZIndex = 100001
		ico.Position, ico.AnchorPoint = UDim2.fromOffset(-14, -14), Vector2.zero

		env.stuf.buttonscale = Instance.new("UIScale")
		env.stuf.buttonscale.Parent = hi

		alive()
		return
	end

	local ico = Instance.new("ImageLabel")
	ico.Size, ico.Position, ico.AnchorPoint = UDim2.fromOffset(92, 92), UDim2.fromScale(0.5, 0.5), Vector2.new(0.5, 0.5)
	ico.ZIndex = 100001
	ico.BackgroundTransparency, ico.Parent, ico.Image = 1, hi, env.stuf.introframes[1]

	t(0.4) js:Destroy()
	ico.Position, ico.AnchorPoint = UDim2.fromOffset(-14, -14), Vector2.zero
	tween(hi, {0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.fromOffset(230, 64)})

	local lib = env.essentials.library
	local title    = lib.makecooltext(hi, UDim2.fromOffset(200, 20), "", 16, nil, 2, UDim2.fromOffset(163, 22), Enum.TextXAlignment.Left, Enum.TextYAlignment.Center, nil, 100001)
	local subtitle = lib.makecooltext(hi, UDim2.fromOffset(200, 20), "", 12, Color3.fromRGB(187, 187, 187), 2, UDim2.fromOffset(163, 42), Enum.TextXAlignment.Left, Enum.TextYAlignment.Center, nil, 100001)

	task.delay(0.1, function()
		spwn(typein, title, "Noxious: Boxten Sex GUI")
		spwn(typein, subtitle, "Version 1.3.0 | Initializing...")
	end)

	t(0.5)
	tween(hi, {0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.fromOffset(230, 253)})
	t(0.06)

	local function getservertime() return "[" .. os.date("%H:%M:%S") .. "]" end

	local yo = lib.makecoolframe(UDim2.new(1, -28, 0, 1), hi, false, false, UDim2.new(0.5, 0, 0, 65), false, true)
	yo.AnchorPoint = Vector2.new(0.5, 0)
	yo.ClipsDescendants = true

	tween(yo, {0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
		Size = UDim2.new(1, -28, 0, 175),
		Position = UDim2.new(0.5, 0, 0, 65)
	})

	t(0.2)

	local introconsolelogs = {}
	local introconsole = nil

	function env.funcs.introconsolelog(line, outputtype)
		outputtype = outputtype or "reg"

		if outputtype == "reg" then
			line = "  <font size='8' color='rgb(133, 133, 133)'>" .. line .. "</font>"
		elseif outputtype == "state" then
			line = getservertime() .. ": " .. line
		elseif outputtype == "succ" then
			line = "  <font size='8' color='rgb(84, 255, 101)'>" .. line .. "</font>"
		elseif outputtype == "warn" then
			line = "  <font size='8' color='rgb(247, 250, 92)'>" .. line .. "</font>"
		elseif outputtype == "err" then
			line = "  <font size='8' color='rgb(252, 80, 80)'>" .. line .. "</font>"
		end

		table.insert(introconsolelogs, line)
		if #introconsolelogs > 16 then
			table.remove(introconsolelogs, 1)
		end

		introconsole.Text = table.concat(introconsolelogs, "\n")
		if outputtype == "warn" or outputtype == "err" then t(1) end
	end

	introconsole = lib.makecooltext(yo, UDim2.new(0, 188, 0, 20), "", 10, nil, 2, UDim2.new(0.5, 2, 0, 16), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)
	env.funcs.introconsolelog("Initializing...", "state")

	local currentPercent = Instance.new("NumberValue")
	currentPercent.Value = 0

	function env.funcs.introprogress(target, status)
		local tw = ts:Create(currentPercent, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = target})
		local connection = currentPercent.Changed:Connect(function(val)
			subtitle.Text = string.format("Version 1.3.0 | %s (%d%%)", status or "Loading...", math.floor(val))
		end)
		tw:Play()
		return tw, connection
	end

	t(0.8) env.funcs.introprogress(0)

	if env.stuf.inlobby or env.stuf.inrun or env.stuf.inrp then
		env.funcs.introconsolelog("Experience ID recognized (" .. game.PlaceId .. ").")
	else
		env.funcs.introconsolelog("Experience ID unrecognized (" .. game.PlaceId .. ").", "warn")
	end

	env.funcs.introprogress(5) t(0.2)

	if env.funcs.exists() then
		env.funcs.introconsolelog("Character model exists.")
	else
		env.funcs.introconsolelog("Character doesn't exist yet.", "warn")
	end

	env.funcs.introprogress(10) t(0.1)
	env.funcs.introconsolelog("Success: Environment check success", "succ")
	env.funcs.introconsolelog("Downloading assets...", "state")
	t(0.1)

	if not isfolder(folder) then makefolder(folder) end

	local imagesfolder = folder .. "/Images"
	local videosfolder = folder .. "/Videos"
	local soundsfolder = folder .. "/Sounds"

	if isfolder(imagesfolder) and isfolder(videosfolder) and isfolder(soundsfolder) then
		env.funcs.introconsolelog("Fetching assets...")
		t()
		env.funcs.introconsolelog("Success: Assets already downloaded", "succ")
	else
		env.funcs.introconsolelog("Downloading assets...")
		if not isfolder(imagesfolder) then makefolder(imagesfolder) end
		env.funcs.introprogress(15)
		if not isfolder(videosfolder) then makefolder(videosfolder) end
		env.funcs.introprogress(20)
		if not isfolder(soundsfolder) then makefolder(soundsfolder) end
		env.funcs.introprogress(25)
		env.funcs.introconsolelog("Success: Assets downloaded", "succ")
	end

	env.funcs.introprogress(30) t(0.1)
	env.funcs.introconsolelog("Preloading assets...", "state")
	env.funcs.introconsolelog("Fetching images...")
	t(0.1)

	env.funcs.introprogress(35)
	env.funcs.introconsolelog("Success: Preloaded images", "succ")
	t(0.1)

	t(0.1) env.funcs.introprogress(40)
	env.funcs.introconsolelog("Loading UI...", "state")
	t(0.1) env.funcs.introprogress(45)

	if env.essentials.library then
		env.funcs.introconsolelog("UI library successfully loaded.")
	else
		env.funcs.introconsolelog("Something went wrong. (LibFail)", "warn")
	end

	t(0.1) env.funcs.introprogress(50)

	if env.essentials.data then
		env.funcs.introconsolelog("Script data successfully loaded.")
	else
		env.funcs.introconsolelog("Something went wrong. (DataFail)", "warn")
	end

	t(0.1) env.funcs.introprogress(55)
	env.funcs.introconsolelog("Success: Script essentials loaded", "succ")
	env.funcs.introconsolelog("Constructing UI...", "state")
	t(0.1) env.funcs.introprogress(60)

	local buildsucc = env.funcs.recursivels("book%201/%CA%95s/%CA%94b.lua", true)

	if not buildsucc or not env.stuf.sectionsloaded then
		env.funcs.introconsolelog("Something went wrong. (BuildFail)", "warn")
	end

	t(0.1)
	env.funcs.introconsolelog("Success: Script sections loaded", "succ")
	env.funcs.introconsolelog("Finalizing...", "state")
	t(0.1) env.funcs.introprogress(95)

	env.filemanager.persistload()
	env.funcs.introconsolelog("Loaded persistent elements.")
	t(0.1) env.funcs.introprogress(98)

	spwn(function()
		if not env.funcs.exists() then
			env.funcs.pop("Waiting for character to load in before auto-loading configs...")
			repeat t() until env.funcs.exists()
			env.funcs.box("character loaded")
			t(1)
		else
			env.funcs.introconsolelog("Auto-loaded configs.")
		end
		env.filemanager:autoload()
		env.funcs.box("auto-loaded configs (if they exist)")
	end)

	env.funcs.introconsolelog("Success: Script successfully loaded", "succ")
	env.funcs.introconsolelog("Done!", "state") env.funcs.introprogress(100, "Done!")
	t(1)

	local tween2 = tween(yo, {0.43, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {
		Size = UDim2.new(1, -28, 0, 1),
		Position = UDim2.new(0.5, 0, 0, 66)
	})

	tween(hi, {0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.fromOffset(230, 64)})
	tween(env.stuf.buttonscale, {1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Scale = env.gear.general.buttonscale})

	tween2.Completed:Wait()
	yo:Destroy()

spwn(backspace, title)
spwn(backspace, subtitle)

env.stuf.buttonscale = Instance.new("UIScale", hi)
tween(env.stuf.buttonscale, {1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Scale = env.gear.general.buttonscale})

task.delay(0.6, function()
    title:Destroy()
    subtitle:Destroy()
end)

	t(0.2)

	tween(hi, {1.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut}, {Position = UDim2.new(0.5, 0, 0, 100)})
	tween(hi, {1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut}, {Size = UDim2.fromOffset(64, 64)})
	togglebutton = hi
	togglebutton.ZIndex = 100000
	togglebutton.Rotation = 0

	task.delay(1.5, alive)
end

-------------------------------------------------------------------------------------------------------------------------------

loadintro()

-------------------------------------------------------------------------------------------------------------------------------
