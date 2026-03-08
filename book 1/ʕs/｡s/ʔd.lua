--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Donor section]
   
---------------------------------------------------------------------------------------------------------------------------]]--

local version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local tps = FindFirstChildOfClass(game, "TeleportService")
local ws = FindFirstChildOfClass(game, "Workspace")
local srgui = FindFirstChildOfClass(game, "StarterGui")
local uis = FindFirstChildOfClass(game, "UserInputService")
local plrs = FindFirstChildOfClass(game, "Players")
local l = FindFirstChildOfClass(game, "Lighting")
local rs = FindFirstChildOfClass(game, "RunService")
local d = FindFirstChildOfClass(game, "Debris")
local ts = FindFirstChildOfClass(game, "TweenService")

local setfpscap = (syn and syn.setfpscap) or setfpscap
local getgenv = getgenv() or _G
local clipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
local writefile = (syn and syn.writefile) or writefile
local readfile = (syn and syn.readfile) or readfile
local isfile = (syn and syn.isfile) or isfile
local hiddenui = gethui() or FindFirstChildOfClass(game, "CoreGui")
local blacklistrayfilter = Enum.RaycastFilterType.Blacklist

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local mobile = uis.TouchEnabled

-------------------------------------------------------------------------------------------------------------------------------

-- key
local keysyshandler = {}
local junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
junkie.service = "BSGUI"
junkie.identifier = "1691"
junkie.provider = "BSGUI provider"

function keysyshandler:supportsfileapi()
	return pcall(function() return writefile and readfile and isfile end)
end

function keysyshandler:savekey(key)
	if keysyshandler:supportsfileapi() then pcall(writefile, folder .. "/Saved Donor Key.txt", key) end
end

function keysyshandler:loadkey()
	if keysyshandler:supportsfileapi() and isfile(folder .. "/Saved Donor Key.txt") then
		local ok, content = pcall(readfile, folder .. "/Saved Donor Key.txt")
		return ok and content or nil
	end
end

local keypopup
function keysystempopup(onVerifiedCallback)
	if keypopup then return end

	keypopup = env.essentials.library.makecoolframe(UDim2.new(0, 310, 0, 250), env.essentials.sgui, false, true, UDim2.new(0.5, 0, -0.4, 0), nil, nil, nil, 9000)
	spwn(function() env.essentials.library.centerui(keypopup, false, Enum.EasingStyle.Back) end)

	env.essentials.library.addcooltab(UDim2.new(0, 200, 0, 40), keypopup, UDim2.new(0, 120, 0, -12), "Noxious: Boxten Sex GUI")
	local close = env.essentials.library.addclosebutton(UDim2.new(0, 48, 0, 27), keypopup, UDim2.new(0.5, 110, 0, 0), "X", 22)
	close.Activated:Connect(function() keypopup:Destroy() keypopup = nil end)

	env.essentials.library.makecooltext(keypopup, UDim2.new(1, -30, 0, 90), "Donor Key System", 20, nil, 2, UDim2.new(0.5, 0, 0.5, -102), nil, nil, nil, 9001)

	local keyInput = env.essentials.library.makecooltextbox(UDim2.new(0, 277, 0, 32), keypopup, "", 20, "Key", nil, UDim2.new(0.5, 0, 0.5, -60), nil, 9001)

	env.essentials.library.makecooltext(keypopup, UDim2.new(1, -30, 0, 90), "Once you've validated your key, you will able to access the Donor section. Keys expire in 5 hours.", 14, Color3.fromRGB(200, 200, 200), 2, UDim2.new(0.5, 0, 0.5, -19), nil, nil, nil, 9001)

	local status = env.essentials.library.makecooltext(keypopup, UDim2.new(1, -30, 0, 90), "Status: ...", 16, nil, 2, UDim2.new(0.5, 0, 0.5, 10), nil, nil, nil, 9001)

	local getKeyBtn = env.essentials.library.makecoolbutton("Get key", UDim2.new(0, 277, 0, 32), keypopup, UDim2.new(0.5, 0, 0.5, 45), "info", 21, nil, 9001)
	local verifyBtn = env.essentials.library.makecoolbutton("Verify key", UDim2.new(0, 277, 0, 32), keypopup, UDim2.new(0.5, 0, 0.5, 90), "yes", 21, nil, 9001)

	getKeyBtn.Activated:Connect(function()
		local secureGetKeyLink = junkie.get_key_link()
		if not secureGetKeyLink then
			return
		end
		local link = secureGetKeyLink

		if link then
			env.funcs.copytoclipboard(link)
		end
	end)

	verifyBtn.Activated:Connect(function()
		local input = keyInput.Text
		if input == "" then return end

		local result = junkie.check_key(input)
		if result and result.valid then
			keysyshandler:savekey(input)
			getgenv.BSGUI_donor_key = input
			keypopup:Destroy()
			keypopup = nil
			if onVerifiedCallback then onVerifiedCallback(input) end
		else
			keyInput.Text = ""
		end
	end)
end

function keysyshandler:popup()
	local saved = keysyshandler:loadkey() or getgenv.BSGUI_donor_key

	if saved then
		local result = junkie.check_key(saved)
		if result and result.valid then
			getgenv.BSGUI_donor_key = saved
			table.insert(env.essentials.data.autodonors, env.stuf.user)
			return
		end
	end

	keysystempopup(function(verifiedKey)
		table.insert(env.essentials.data.autodonors, env.stuf.user)
	end)
end

local saved = keysyshandler:loadkey() or getgenv.BSGUI_donor_key

if saved then
	local result = junkie.check_key(saved)
	if result and result.valid then
		getgenv.BSGUI_donor_key = saved
		table.insert(env.essentials.data.autodonors, env.stuf.user)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

diohandler = {}
diohandler.frozenobjectstable = {}
diohandler.clones = {}
diohandler.playinganimation = false

diohandler.maxseconds = 20
diohandler.timestopped = false

diohandler.cce = Instance.new("ColorCorrectionEffect")
diohandler.cce.Parent = l
diohandler.cce.Saturation = 0
diohandler.cce.Contrast = 0
diohandler.cce.Enabled = true

diohandler.sphere = Instance.new("Part")
diohandler.sphere.Material = Enum.Material.ForceField
diohandler.sphere.Size = Vector3.new(0, 0, 0)
diohandler.sphere.Shape = Enum.PartType.Ball
diohandler.sphere.CanCollide = false
diohandler.sphere.Massless = true
diohandler.sphere.Transparency = 1
diohandler.sphere.Color = Color3.new(1, 1, 1)
diohandler.sphere.CastShadow = false
diohandler.sphere.Parent = nil

diohandler.sphereweld = Instance.new("Weld")
diohandler.sphereweld.Parent = nil

function shakescreen(dur, i)
	local shakeStrength = i or 1
	local shakeDecayStart = 0.001
	local shakeDecayDuration = dur or 2.7

	spwn(function()
		local startTime = tick()

		while shakeStrength > 0 do
			rs.RenderStepped:Wait()

			local elapsed = tick() - startTime
			if elapsed >= shakeDecayStart then
				local alpha = math.clamp(
					(elapsed - shakeDecayStart) / shakeDecayDuration,
					0, 1
				)
				shakeStrength = 1 - alpha
			end

			env.stuf.cam.CFrame *= CFrame.fromEulerAngles(
				math.random(-4, 4) / 100 * shakeStrength,
				math.random(-4, 4) / 100 * shakeStrength,
				0
			)
		end
	end)
end

diohandler.resuming = false
diohandler.currentid = 0

function timestop(sender)
	if diohandler.timestopped or diohandler.playinganimation then return end
	diohandler.playinganimation = true

	local function hi()
		local s = Instance.new("Sound", env.stuf.char)
		s.SoundId = "rbxassetid://128707491647978"
		s.Volume = 2
		s.PlaybackSpeed = 0.6
		s:Play()
		s.Ended:Connect(function() s:Destroy() end)
	end

	diohandler.currentid = diohandler.currentid + 1
	local myID = diohandler.currentid 

	local isSource = (sender == env.stuf.plr) 
	if isSource then
		env.stuf.handshaker.donorsend("timestop")
	end

	local donorChar = sender.Character
	local donorRoot = donorChar and (donorChar:FindFirstChild("HumanoidRootPart") or donorChar:FindFirstChild("Torso"))

	if donorRoot then
		diohandler.sphere.Parent = donorChar
		diohandler.sphere.Transparency = 0
		diohandler.sphereweld.Part0 = diohandler.sphere
		diohandler.sphereweld.Part1 = donorRoot
		diohandler.sphereweld.C0 = CFrame.new(0, 0, 0)
		diohandler.sphereweld.C1 = CFrame.new(0, 0, 0)
		diohandler.sphereweld.Parent = diohandler.sphere
	end

	local timestopvoiceline = Instance.new("Sound", env.stuf.char)
	timestopvoiceline.SoundId = "rbxassetid://18756313837"

	diohandler.resuming = false
	timestopvoiceline.Volume = 12 
	timestopvoiceline:Play()

	local tsGui = Instance.new("ScreenGui", hiddenui)
	tsGui.IgnoreGuiInset = true

	local textContainer = Instance.new("Frame", tsGui)
	textContainer.Size = UDim2.new(0, 0, 0, 0)
	textContainer.Position = UDim2.new(0.5, 0, 0.7, 0)
	textContainer.AnchorPoint = Vector2.new(0.5, 0)
	textContainer.BackgroundTransparency = 1

	spwn(function()
		local characters = {"ザ", "・", "ワ", "ー", "ル", "ド", "！", "！", "！"}
		local charList = {}

		textContainer:ClearAllChildren()

		textContainer.AnchorPoint = Vector2.new(0.5, 1)
		textContainer.Position = UDim2.new(0.5, 0, 1, (mobile and -50) or -80)

		local charWidth = (mobile and 24) or 34
		local totalWidth = #characters * charWidth
		textContainer.Size = UDim2.new(0, totalWidth, 0, 60)

		local name = sender.DisplayName .. ":"
		if env.funcs.datacheck(env.essentials.data.classes.unable) then name = "Boxten <font color='rgb(169, 22, 199)'> [unable]</font>:" end

		local title = Instance.new("TextLabel")
		title.Text = name
		title.Font = Enum.Font.FredokaOne
		title.TextSize = (mobile and 16) or 22
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.BackgroundTransparency = 1
		title.RichText = true
		title.AnchorPoint = Vector2.new(0.5, 1)
		title.Size = UDim2.new(1, 0, 0, 30)
		title.Position = UDim2.new(0.5, 0, 0, (mobile and 6) or 10)
		title.TextTransparency = 1
		title.Parent = textContainer

		local titleStroke = Instance.new("UIStroke", title)
		titleStroke.Thickness = 2
		titleStroke.Transparency = 1

		ts:Create(title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
		ts:Create(titleStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()

		for i, char in ipairs(characters) do
			local label = Instance.new("TextLabel")
			label.Text = "<b>" .. char .. "</b>"
			label.Font = Enum.Font.FredokaOne
			label.TextSize = (mobile and 35) or 55
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.BackgroundTransparency = 1
			label.RichText = true
			label.Size = UDim2.new(0, charWidth, 1, 0)
			label.Position = UDim2.new(0, (i - 1) * charWidth, 0, 0)
			label.TextTransparency = 1
			label.Parent = textContainer

			local stroke = Instance.new("UIStroke", label)
			stroke.Thickness = 2
			stroke.Transparency = 1

			table.insert(charList, label)

			spwn(function()
				ts:Create(label, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
				ts:Create(label, TweenInfo.new(0.5), {TextSize = 45}):Play()
				ts:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()

				local originalPos = label.Position
				local shakeIntensity = 12
				local startTime = tick()
				while tick() - startTime < 1 do
					rs.RenderStepped:Wait()
					local progress = (tick() - startTime) / 1
					local curIntensity = shakeIntensity * (1 - progress)
					label.Position = originalPos + UDim2.fromOffset(math.random(-curIntensity, curIntensity), math.random(-curIntensity, curIntensity))
				end
				ts:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = originalPos}):Play()
			end)
			t(0.08)
		end

		t(0.8)
		for _, label in ipairs(charList) do
			ts:Create(title, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
			ts:Create(titleStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
			ts:Create(label, TweenInfo.new(0.6), {
				TextTransparency = 1, 
			}):Play()
			for _, stroke in ipairs(label:GetChildren()) do
				if stroke:IsA("UIStroke") then
					ts:Create(stroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
				end
			end
		end
		t(0.6)
		tsGui:Destroy()
	end)

	task.delay(4, function()
		local fadeTween = ts:Create(timestopvoiceline, TweenInfo.new(2), {Volume = 0})
		fadeTween:Play()
		fadeTween.Completed:Connect(function() timestopvoiceline:Destroy() end)
	end)

	task.delay(2, function()
		while not diohandler.resuming and diohandler.timestopped do
			t(1)
			hi()
		end
	end)

	t(1.7)

	for _, otherPlr in ipairs(plrs:GetPlayers()) do
		local character = otherPlr.Character
		if character and character ~= donorChar then
			local visibilityMap = {}
			for _, part in ipairs(character:GetDescendants()) do
				if part:IsA("BasePart") or part:IsA("Decal") then
					visibilityMap[part] = part.Transparency
				end
			end

			local hum = character:FindFirstChildOfClass("Humanoid")
			local animator = hum and hum:FindFirstChildOfClass("Animator")
			if animator then
				for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
					track:AdjustSpeed(0)
				end
			end

			if not env.stuf.handshaker.isscriptuser(otherPlr) then
				character.Archivable = true
				local clone = character:Clone()
				clone.Parent = ws

				for _, obj in ipairs(clone:GetDescendants()) do
					if obj:IsA("LuaSourceContainer") then obj:Destroy() end
					if obj:IsA("BasePart") then 
						obj.Anchored = true 
						local originalPart = character:FindFirstChild(obj.Name, true)
						if originalPart and (originalPart:IsA("BasePart") or originalPart:IsA("Decal")) then
							obj.Transparency = originalPart.Transparency
						end
					end
				end

				table.insert(diohandler.clones, {Original = character, Clone = clone, Map = visibilityMap})

				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") or part:IsA("Decal") then
						part.Transparency = 1
						if part:IsA("BasePart") then
							part.CanCollide = false
							part.Anchored = true
						end
					end
				end
			else
				for _, part in ipairs(character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = true
						table.insert(diohandler.frozenobjectstable, part)
					end
				end
			end
		end
	end

	for _, v in pairs(ws:GetDescendants()) do
		if v:IsA("BasePart") and not v.Anchored then
			if not v:IsDescendantOf(donorChar) and not v:IsDescendantOf(ws:FindFirstChild("diohandler.clones") or ws) then
				v.Anchored = true
				table.insert(diohandler.frozenobjectstable, v)
			end
		end
	end

	shakescreen()

	coroutine.wrap(function()
		diohandler.cce.Enabled = true
		ts:Create(ws.CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FieldOfView = 250}):Play()

		coroutine.wrap(function()
			while not diohandler.timestopped do
				ts:Create(diohandler.cce, TweenInfo.new(0.8), {Contrast = -2}):Play()
				t(0.3)
				ts:Create(diohandler.cce, TweenInfo.new(0.5), {Saturation = -2}):Play()
				t(0.5)
			end
		end)()

		t(0.7)
		ts:Create(ws.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {FieldOfView = 70}):Play()
		t(1)
		ts:Create(diohandler.cce, TweenInfo.new(1), {Contrast = 0, Saturation = -0.8}):Play()
	end)()

	coroutine.wrap(function()
		ts:Create(diohandler.sphere, TweenInfo.new(1), {Size = Vector3.new(180, 180, 180)}):Play()
		t(1.6)
		ts:Create(diohandler.sphere, TweenInfo.new(0.5), {Size = Vector3.new(0, 0, 0)}):Play()
		t(0.5)
		diohandler.sphere.Transparency = 1
	end)()

	for _, v in pairs(ws:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Fire") then
			ts:Create(v, TweenInfo.new(3), {TimeScale = 0}):Play()
		elseif v:IsA("Sound") and not v:IsDescendantOf(env.stuf.char) then
			ts:Create(v, TweenInfo.new(4), {PlaybackSpeed = 0}):Play()
		end
	end

	diohandler.timestopped = true
	diohandler.playinganimation = false
	t(diohandler.maxseconds)
	if diohandler.timestopped and diohandler.currentid == myID then
		timeresume(sender)
	end
end

function timeresume(sender)
	if not diohandler.timestopped or diohandler.resuming then return end
	diohandler.resuming = true
	diohandler.playinganimation = true

	diohandler.currentid = diohandler.currentid + 1

	if sender == env.stuf.plr then
		env.stuf.handshaker.donorsend("timeresume")
	end

	local timeresumevoiceline = Instance.new("Sound", env.stuf.char)
	timeresumevoiceline.SoundId = "rbxassetid://4329802996"
	timeresumevoiceline.Volume = 12 
	timeresumevoiceline:Play()
	timeresumevoiceline.Ended:Connect(function()
		timeresumevoiceline:Destroy()
	end)

	local tsGui = Instance.new("ScreenGui", hiddenui)
	tsGui.IgnoreGuiInset = true

	local textContainer = Instance.new("Frame", tsGui)
	textContainer.Size = UDim2.new(0, 0, 0, 0)
	textContainer.Position = UDim2.new(0.5, 0, 0.7, 0)
	textContainer.AnchorPoint = Vector2.new(0.5, 0)
	textContainer.BackgroundTransparency = 1

	spwn(function()
		local characters = {"时", "は", "動", "き", "出", "す", "。"}
		local charList = {}

		textContainer:ClearAllChildren()

		textContainer.AnchorPoint = Vector2.new(0.5, 1)
		textContainer.Position = UDim2.new(0.5, 0, 1, (mobile and -60) or -80)

		local charWidth = (mobile and 24) or 34
		local totalWidth = #characters * charWidth
		textContainer.Size = UDim2.new(0, totalWidth, 0, 60)

		local name = sender.DisplayName .. ":"
		if env.funcs.datacheck(env.essentials.data.classes.unable) then name = "Boxten <font color='rgb(169, 22, 199)'> [unable]</font>:" end

		local title = Instance.new("TextLabel")
		title.Text = name
		title.Font = Enum.Font.FredokaOne
		title.TextSize = (mobile and 16) or 22
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.BackgroundTransparency = 1
		title.RichText = true
		title.AnchorPoint = Vector2.new(0.5, 1)
		title.Size = UDim2.new(1, 0, 0, 30)
		title.Position = UDim2.new(0.5, 0, 0, (mobile and 6) or 10)
		title.TextTransparency = 1
		title.Parent = textContainer

		local titleStroke = Instance.new("UIStroke", title)
		titleStroke.Thickness = 2
		titleStroke.Transparency = 1

		ts:Create(title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
		ts:Create(titleStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()

		for i, char in ipairs(characters) do
			local label = Instance.new("TextLabel")
			label.Text = "<b>" .. char .. "</b>"
			label.Font = Enum.Font.FredokaOne
			label.TextSize = (mobile and 35) or 55
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.BackgroundTransparency = 1
			label.RichText = true
			label.Size = UDim2.new(0, charWidth, 1, 0)
			label.Position = UDim2.new(0, (i - 1) * charWidth, 0, 0)
			label.TextTransparency = 1
			label.Parent = textContainer

			local stroke = Instance.new("UIStroke", label)
			stroke.Thickness = 2
			stroke.Transparency = 1

			table.insert(charList, label)

			spwn(function()
				ts:Create(label, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
				ts:Create(label, TweenInfo.new(0.5), {TextSize = 45}):Play()
				ts:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()

				local originalPos = label.Position
				local shakeIntensity = 12
				local startTime = tick()
				while tick() - startTime < 1 do
					rs.RenderStepped:Wait()
					local progress = (tick() - startTime) / 1
					local curIntensity = shakeIntensity * (1 - progress)
					label.Position = originalPos + UDim2.fromOffset(math.random(-curIntensity, curIntensity), math.random(-curIntensity, curIntensity))
				end
				ts:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = originalPos}):Play()
			end)
			t(0.1)
		end

		t(0.8)
		for _, label in ipairs(charList) do
			ts:Create(title, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
			ts:Create(titleStroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
			ts:Create(label, TweenInfo.new(0.6), {
				TextTransparency = 1, 
			}):Play()
			for _, stroke in ipairs(label:GetChildren()) do
				if stroke:IsA("UIStroke") then
					ts:Create(stroke, TweenInfo.new(0.6), {Transparency = 1}):Play()
				end
			end
		end
		t(0.6)
		tsGui:Destroy()
	end)

	task.delay(2.2, function()
		diohandler.sphere.Size = Vector3.new(180, 180, 180)
		diohandler.sphere.Transparency = 0
		local shrink = ts:Create(diohandler.sphere, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = Vector3.new(0, 0, 0)})
		shrink:Play()
		shrink.Completed:Wait()
		diohandler.sphere.Transparency = 1
		diohandler.sphere.Parent = nil
	end)

	t(2)

	for _, data in ipairs(diohandler.clones) do
		if data.Original then
			for _, part in ipairs(data.Original:GetDescendants()) do
				if part:IsA("BasePart") or part:IsA("Decal") then
					part.Transparency = data.Map[part] or 0
					if part:IsA("BasePart") then
						part.CanCollide = true
						part.Anchored = false
					end
				end
			end
		end
		if data.Clone then data.Clone:Destroy() end
	end
	diohandler.clones = {}

	for _, v in pairs(diohandler.frozenobjectstable) do
		if v and v:IsA("BasePart") then v.Anchored = false end
	end
	diohandler.frozenobjectstable = {}

	for _, otherPlr in ipairs(plrs:GetPlayers()) do
		local hum = otherPlr.Character and otherPlr.Character:FindFirstChildOfClass("Humanoid")
		local animator = hum and hum:FindFirstChildOfClass("Animator")
		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				track:AdjustSpeed(1)
			end
		end
	end

	for _, v in pairs(ws:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Fire") then
			v.TimeScale = 1
		elseif v:IsA("Sound") and not v:IsDescendantOf(env.stuf.char) then
			v.PlaybackSpeed = 1
		end
	end

	ts:Create(diohandler.cce, TweenInfo.new(2), {Saturation = 0}):Play()
	diohandler.timestopped = false
	diohandler.resuming = false
	diohandler.playinganimation = false
end

env.stuf.handshaker.addcmd("timestop", function(sender) 
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end

	env.funcs.box(sender.Name .. " called timestop")
	timestop(sender)
end)

env.stuf.handshaker.addcmd("timeresume", function(sender) 
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end

	env.funcs.box(sender.Name .. " called timeresume")
	timeresume(sender)
end)

-------------------------------------------------------------------------------------------------------------------------------

function fakehurt(char, death)
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local function attach(name)
		local a = Instance.new("Attachment", hrp)
		a.Name = name
		return a
	end

	local function emitter(parent, props)
		local p = Instance.new("ParticleEmitter", parent)
		for k,v in pairs(props) do p[k] = v end
		return p
	end

	local a1 = attach("EmitterAttachment1")
	local p1 = emitter(a1,{
		Name="Emitter1",
		Texture="rbxassetid://16514111060",
		Rate=0,
		Lifetime=NumberRange.new(1,2),
		Speed=NumberRange.new(1),
		SpreadAngle=Vector2.new(100,100),
		RotSpeed=NumberRange.new(-360,360),
		Acceleration=Vector3.new(0,-8,0),
		Size=NumberSequence.new{
			NumberSequenceKeypoint.new(0,2.61324),
			NumberSequenceKeypoint.new(.116949,.215254),
			NumberSequenceKeypoint.new(.289831,1.01045),
			NumberSequenceKeypoint.new(.333898,2.43902),
			NumberSequenceKeypoint.new(.501695,1.49826),
			NumberSequenceKeypoint.new(1,4.25087)
		},
		Squash=NumberSequence.new{
			NumberSequenceKeypoint.new(0,.4875),
			NumberSequenceKeypoint.new(1,0)
		},
		Transparency=NumberSequence.new{
			NumberSequenceKeypoint.new(0,.99375),
			NumberSequenceKeypoint.new(.179328,.5),
			NumberSequenceKeypoint.new(.676214,.5125),
			NumberSequenceKeypoint.new(1,1)
		}
	})
	p1:Emit(6)

	local a2 = attach("EmitterAttachment2")
	local p2 = emitter(a2,{
		Name="Emitter2",
		Texture="rbxassetid://16514111060",
		Rate=20,
		Lifetime=NumberRange.new(1),
		Speed=NumberRange.new(8),
		SpreadAngle=Vector2.new(100,100),
		RotSpeed=NumberRange.new(-360,360),
		Acceleration=Vector3.new(0,-3,0),
		Size=NumberSequence.new(.1),
		Squash=p1.Squash,
		Transparency=NumberSequence.new{
			NumberSequenceKeypoint.new(0,.99375),
			NumberSequenceKeypoint.new(.174346,.36875),
			NumberSequenceKeypoint.new(.667497,.275),
			NumberSequenceKeypoint.new(1,1)
		}
	})

	local function fade(p,dur)
		p.Enabled, p.Rate = false,0
		local start, keys = tick(), p.Transparency.Keypoints
		local c 
		c = rs.RenderStepped:Connect(function()
			local a = math.clamp((tick() - start) / dur, 0, 1)
			local n = {}
			for _, k in ipairs(keys) do
				n[#n + 1] = NumberSequenceKeypoint.new(k.Time, k.Value + (1 - k.Value) * a)
			end
			p.Transparency = NumberSequence.new(n)
			if a >= 1 then p.Transparency = NumberSequence.new(1) c:Disconnect() c = nil end
		end)
	end

	task.delay(.3, function() fade(p1, .4) fade(p2, .4) end)
	d:AddItem(p1, 1) d:AddItem(p2, 1)
end

function fakedeath(char)
	if not char then return end
	local conn = rs.Heartbeat:Connect(function()
		char:FindFirstChild("HumanoidRootPart").Anchored = true
	end)

	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			part.Transparency = 1
		elseif part:IsA("Decal") then
			part.Transparency = 1
		end
	end

	spwn(function()
		for _ = 1, 2 do
			fakehurt(char)
			t(0.1)
		end
	end)

	env.funcs.playsound("rbxassetid://5920004288", 0.4, 1, 0, env.stuf.root)
	task.delay(2, function() 
		env.stuf.hum.Health = 0 
		if conn then
			conn:Disconnect()
			conn = nil 
		end
		char:FindFirstChild("HumanoidRootPart").Anchored = false 
	end)
end

revolvertoolconn = nil
revolvertool = nil

function gunspead(direction, spreadDegrees)
	local spread = math.rad(spreadDegrees)

	local forward = direction.Unit
	local right = forward:Cross(Vector3.new(0, 1, 0))
	if right.Magnitude < 0.01 then
		right = forward:Cross(Vector3.new(1, 0, 0))
	end
	right = right.Unit
	local up = right:Cross(forward).Unit

	local r = math.sqrt(math.random())
	local theta = math.random() * math.pi * 2

	local offset =
		(right * math.cos(theta) + up * math.sin(theta)) * r * math.tan(spread)

	return (forward + offset).Unit
end

shooting = false

function giverevolver(state)
	if state then
		local function hi()
			if revolvertool then return end

			local tool = Instance.new("Tool")
			tool.Name = "revolver"
			tool.RequiresHandle = false
			tool.CanBeDropped = false

			revolvertool = tool

			tool.Activated:Connect(function()
				if shooting then return end shooting = true
				local origin = env.stuf.cam.CFrame.Position
				local basedir = (env.stuf.mouse.Hit.Position - origin).Unit
				local direction = gunspead(basedir, 0.8) * 1000

				local rayparams = RaycastParams.new()
				rayparams.FilterType = blacklistrayfilter
				rayparams.FilterDescendantsInstances = { env.stuf.char }
				rayparams.IgnoreWater = true
				rayparams.RespectCanCollide = true

				local result = ws:Raycast(origin, direction, rayparams)
				if not result then return end

				local hit = result.Instance
				local model = hit:FindFirstAncestorOfClass("Model")

				if model then
					local humanoid = model:FindFirstChildOfClass("Humanoid")
					local hrp = model:FindFirstChild("HumanoidRootPart")

					if humanoid and hrp then
						local plr = plrs:GetPlayerFromCharacter(model)
						if plr and env.stuf.handshaker.isscriptuser(plr) then
							env.funcs.playsound("rbxassetid://330595293", 0.4, 1, 0, hrp)
							fakehurt(model)
						end
					end
				end

				local hit = result.Position

				env.stuf.handshaker.donorsend(string.format(
					"revolver %s %.3f %.3f %.3f",
					env.stuf.user,
					hit.X,
					hit.Y,
					hit.Z
					))

				t(0.2) shooting = false
			end)

			tool.Parent = env.stuf.backpack
			env.funcs.setcore("bag", true)
		end

		hi() revolvertoolconn = env.stuf.plr.CharacterAdded:Connect(hi)
	else
		if revolvertoolconn then revolvertoolconn:Disconnect() revolvertoolconn = nil end
		if revolvertool then revolvertool:Destroy() revolvertool = nil end
	end
end

env.stuf.handshaker.addcmd("revolver", function(sender, data)
	local sendername, x, y, z = data:match("(%S+)%s+([%-%d%.]+)%s+([%-%d%.]+)%s+([%-%d%.]+)")
	if not sendername or not x then return end

	local pos = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
	local senderchar = sender.Character
	if not senderchar or not senderchar:FindFirstChild("HumanoidRootPart") then return end

	env.funcs.playsound("rbxassetid://128248533356050", 0.4, 1, 0, senderchar.HumanoidRootPart)

	local light = Instance.new("PointLight")
	light.Parent = senderchar.HumanoidRootPart
	light.Color = Color3.fromRGB(255, 255, 0)
	light.Brightness = 1
	light.Range = 8
	d:AddItem(light, 0.1)

	local origin = senderchar.HumanoidRootPart.Position
	local dist = (pos - origin).Magnitude
	local beam = Instance.new("Part", ws)
	beam.Anchored, beam.CanCollide = true, false
	beam.Transparency, beam.Material = 0.2, Enum.Material.Neon
	beam.Color = Color3.fromRGB(255, 255, 0)
	beam.Size = Vector3.new(0.08, 0.08, dist)
	beam.CFrame = CFrame.lookAt(origin, pos) * CFrame.new(0, 0, -dist/2)

	ts:Create(beam, TweenInfo.new(0.15), {Transparency = 1}):Play()
	d:AddItem(beam, 0.2)

	if env.stuf.root and (pos - env.stuf.root.Position).Magnitude < 3 then
		if env.stuf.hum and env.stuf.hum.Health > 0 then 
			local dmg = env.stuf.inlobby and 20 or 1

			local function regdmg()
				env.stuf.hum:TakeDamage(dmg)
				fakehurt(env.stuf.char)
				env.funcs.playsound("rbxassetid://330595293", 0.4, 1, 0, env.stuf.root)
			end

			if env.stuf.inrun then 
				regdmg() 
			else
				if (env.stuf.hum.Health - dmg) <= 0 then
					env.stuf.hum.Health = 1
					fakedeath(env.stuf.char)
				else
					regdmg() 
				end
			end
		end
	end
end)

shotguntoolconn = nil
shotguntool = nil

function givesawedoff(state)
	if state then
		local function hi()
			if shotguntool then return end

			local tool = Instance.new("Tool")
			tool.Name = "double-barrel shotgun"
			tool.RequiresHandle = false
			tool.CanBeDropped = false
			shotguntool = tool

			tool.Activated:Connect(function()
				if shooting then return end shooting = true
				if not env.stuf.root then return end

				local origin = env.stuf.root.Position

				local rayparams = RaycastParams.new()
				rayparams.FilterType = blacklistrayfilter
				rayparams.FilterDescendantsInstances = { env.stuf.char }
				rayparams.IgnoreWater = true
				rayparams.RespectCanCollide = true

				local pellets = {}

				for i = 1, 5 do
					local spreaddir = gunspead((env.stuf.mouse.Hit.Position - origin).Unit, 1.2)
					local result = ws:Raycast(origin, spreaddir * 600, rayparams)

					if result then
						local p = result.Position
						table.insert(pellets, string.format("%.3f %.3f %.3f", p.X, p.Y, p.Z))

						local hit = result.Instance
						local model = hit:FindFirstAncestorOfClass("Model")

						if model then
							local humanoid = model:FindFirstChildOfClass("Humanoid")
							local hrp = model:FindFirstChild("HumanoidRootPart")

							if humanoid and hrp then
								local plr = plrs:GetPlayerFromCharacter(model)
								if plr and env.stuf.handshaker.isscriptuser(plr) then
									env.funcs.playsound("rbxassetid://330595293", 0.6, 1, 0, hrp)
									fakehurt(model)
								end
							end
						end
					end
				end

				if #pellets == 0 then return end

				env.stuf.handshaker.donorsend(string.format(
					"shotgun %s %s",
					env.stuf.user,
					table.concat(pellets, " | ")
					))

				t(0.2) shooting = false
			end)

			tool.Parent = env.stuf.backpack
			env.funcs.setcore("bag", true)
		end

		hi() shotguntoolconn = env.stuf.plr.CharacterAdded:Connect(hi)
	else
		if shotguntool then shotguntool:Destroy() shotguntool = nil end
		if shotguntoolconn then shotguntoolconn:Disconnect() shotguntoolconn = nil end
	end
end

env.stuf.handshaker.addcmd("shotgun", function(sender, data)
	local sendername, dat = data:match("(%S+)%s+(.+)")
	if not sendername or not dat then return end

	local senderchar = sender.Character
	if not senderchar or not senderchar:FindFirstChild("HumanoidRootPart") then return end

	local light = Instance.new("PointLight")
	light.Parent = senderchar.HumanoidRootPart
	light.Color = Color3.fromRGB(255, 255, 0)
	light.Brightness = 1
	light.Range = 8
	d:AddItem(light, 0.1)

	env.funcs.playsound("rbxassetid://3855292863", 0.6, 1, 0, senderchar.HumanoidRootPart)

	for chunk in dat:gmatch("[^|]+") do
		local x, y, z = chunk:match("([%-%d%.]+)%s+([%-%d%.]+)%s+([%-%d%.]+)")
		if x then
			local hits = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
			local origin = senderchar.HumanoidRootPart.Position
			local dist = (hits - origin).Magnitude

			local beam = Instance.new("Part", ws)
			beam.Anchored, beam.CanCollide, beam.Transparency = true, false, 0.2
			beam.Material, beam.Color = Enum.Material.Neon, Color3.fromRGB(255, 220, 0)
			beam.Size = Vector3.new(0.1, 0.1, dist)
			beam.CFrame = CFrame.lookAt(origin, hits) * CFrame.new(0, 0, -dist/2)

			ts:Create(beam, TweenInfo.new(0.15), {Transparency = 1}):Play()
			d:AddItem(beam, 0.15)

			if env.stuf.root and (env.stuf.root.Position - hits).Magnitude <= 2.5 then
				if env.stuf.hum and env.stuf.hum.Health > 0 then 
					local dmg = env.stuf.inlobby and 5 or 1

					local function regdmg()
						env.stuf.hum:TakeDamage(dmg)
						fakehurt(env.stuf.char)
						env.funcs.playsound("rbxassetid://330595293", 0.6, 1, 0, env.stuf.root)
					end

					if env.stuf.inrun then 
						regdmg() 
					else
						if (env.stuf.hum.Health - dmg) <= 0 then
							env.stuf.hum.Health = 1
							fakedeath(env.stuf.char)
						else
							regdmg() 
						end
					end
				end
			end
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

function fakekickuser(target)
	target = target or "all"
	env.stuf.handshaker.donorsend("fakekick " .. target)
end

env.stuf.handshaker.addcmd("fakekick", function(sender) 
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end

	env.funcs.box(sender.Name .. " called fakekick")
	env.funcs.recursivels("book%201/%CA%95f/%CA%94fk.lua", true)
end)

-------------------------------------------------------------------------------------------------------------------------------

function isolateuser(target)
	target = target or "all"
	env.stuf.handshaker.donorsend("isolate " .. target)
end

env.stuf.handshaker.addcmd("isolate", function(sender) 
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end

	env.funcs.box(sender.Name .. " called isolate")
	getgenv.nointro = nil
	env.funcs.recursivels("book%201/%CA%95f/%CA%94br.lua", true)
end)

-------------------------------------------------------------------------------------------------------------------------------

function killuser(target)
	target = target or "all"
	env.stuf.handshaker.donorsend("kill " .. target)
end

env.stuf.handshaker.addcmd("kill", function(sender, target)
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end
	env.funcs.box(sender.Name .. " called kill")
	if env.stuf.hum then
		if not env.stuf.inrun then
			fakedeath(env.stuf.char)
		else
			env.stuf.hum.Health = 0
		end
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

function laguser(state, target)
	target = target or "all"
	env.stuf.handshaker.donorsend((state and "lag ") or "unlag " .. target)
end

env.stuf.handshaker.addcmd("lag", function(sender, target)
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end
	env.funcs.box(sender.Name .. " called lag")
	if setfpscap then
		setfpscap(6)
	end
end)

env.stuf.handshaker.addcmd("unlag", function(sender, target)
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end
	env.funcs.box(sender.Name .. " called unlag")
	if setfpscap then
		setfpscap(999)
	end
end)

-------------------------------------------------------------------------------------------------------------------------------

confused = false

function reversecontrols(state)
	local m = require(env.stuf.plr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"))
	local controls = m:GetControls()

	if state then
		if confused then return end
		confused = true

		controls.moveFunction = function(player, direction, relative) env.stuf.plr.Move(player, -direction, relative) end
	else
		if not confused then return end
		confused = false
		controls.moveFunction = nil
		controls.moveFunction = function(player, direction, relative) env.stuf.plr.Move(player, direction, relative) end
	end
end

function confuseuser(state, target)
	target = target or "all"
	if state then
		env.stuf.handshaker.donorsend("confuse " .. target)
	else
		env.stuf.handshaker.donorsend("unconfuse " .. target)
	end
end

env.stuf.handshaker.addcmd("confuse", function(sender, target)
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end
	env.funcs.box(sender.Name .. " called confuse")
	reversecontrols(true)
end)

env.stuf.handshaker.addcmd("unconfuse", function(sender, target)
	if env.stuf.handshaker.excludeself and sender == env.stuf.plr then return end
	env.funcs.box(sender.Name .. " called unconfuse")
	reversecontrols(false)
end)

-------------------------------------------------------------------------------------------------------------------------------

local section = {
	version = version,

	{ type = "separator", title = "Access" },
	{ type = "button", title = "Open Donor Perks Key System", desc = "Opens a GUI that prompts you to walk through ad checkpoints in order to recieve 5 hours of Donor access and perks.", callback = function() keysyshandler:popup() end },
	{ type = "button", title = "Donation (500)", desc = "Copies a link to our 500 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1085884381/Donor")
		end
	},
	{ type = "button", title = "Donation (450)", desc = "Copies a link to our 450 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1318032362/Donor")
		end
	},
	{ type = "button", title = "Donation (400)", desc = "Copies a link to our 400 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480841694/Donor")
		end
	},
	{ type = "button", title = "Donation (350)", desc = "Copies a link to our 350 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1480783676/Donor")
		end
	},
	{ type = "button", title = "Donation (300)", desc = "Copies a link to our 300 Robux gamepass. This gamepass will grant you Donor perks in Fun/Donor.",
		callback = function() 
			env.funcs.copytoclipboard("https://www.roblox.com/game-pass/1481391576/Donor")
		end
	},

	{ type = "separator", title = "Donor settings" },
	{ type = "toggle", title = "Exclude yourself", desc = "Excludes you from being affected by your own actions.", 
		default = true,

		callback = function(state)
			env.stuf.handshaker.excludeself = state
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},

	{ type = "separator", title = "Actions" },
	{ type = "button", title = "Flashbang script users", desc = "Flashbangs every script user.", 
		commandcat = "Donor",

		command = "flashbangscriptusers",
		aliases = {"fbsu"},
		commanddesc = "Flashbangs every script user",

		callback = function() 
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "button", title = "Kill script users", desc = "Kills every script user.", 
		commandcat = "Donor",

		command = "killscriptusers",
		aliases = {"ksu"},
		commanddesc = "Kills every script user",

		callback = function() 
			killuser()
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "button", title = "Fake ban script users", desc = "Fake bans every script user.", 
		commandcat = "Donor",

		command = "fakebanscriptusers",
		aliases = {"fbansu"},
		commanddesc = "Fake bans every script user",

		callback = function() 
			fakekickuser()
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "toggle", title = "Confuse script users", desc = "Reverses the movement controls of every script user.", 
		commandcat = "Donor",

		encommands = {"confusescriptusers"},
		enaliases = {"csu"},
		encommanddesc = "Reverses the movement controls of every script user",

		discommands = {"unconfusescriptusers"},
		disaliases = {"uncsu"},
		discommanddesc = "Disables confuse script users",

		callback = function(state) 
			confuseuser(state)
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "toggle", title = "Freeze time", desc = "Freezes the time for script users, Dio style.", 
		commandcat = "Donor",

		encommands = {"timestopscriptusers"},
		enaliases = {"tssu"},
		encommanddesc = "Freezes time for script users",

		discommands = {"timeresumescriptusers"},
		disaliases = {"trsu"},
		discommanddesc = "Unfreezes time for script users",

		callback = function(state) 
			env.essentials.library.lock("Freeze time", true, "On cooldown - ", 6)

			if state then
				timestop(env.stuf.plr)
			else
				timeresume(env.stuf.plr)
			end
		end,

		locked = true,
		lockreason = "You are not a Donor."
	},
	{ type = "button", title = "Random trivia question", desc = "Forces every script user to answer a random trivia question, otherwise they would be met with a random punishment.", 
		commandcat = "Donor",

		command = "randomscriptusertriviaquestion",
		aliases = {"rsutq"},
		commanddesc = "Forces every script user to answer a random trivia question",

		callback = function() 
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "toggle", title = "Paranoy script users", desc = "Puts every script user on edge by faking a Twisted spotted event every once in a while.", 
		commandcat = "Donor",

		encommands = {"enablescriptuserparanoia"},
		enaliases = {"esup"},
		encommanddesc = "Enables script user paranoia",

		discommands = {"disablescriptuserparanoia"},
		disaliases = {"dsup"},
		discommanddesc = "Disables script user paranoia",

		callback = function(state) 
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "button", title = "Scare script users", desc = "Makes every single person in the server face towards the script users for a second.", 
		commandcat = "Donor",

		command = "scarescriptusers",
		aliases = {"ssu"},
		commanddesc = "Makes every single person in the server face towards the script users for a second",

		callback = function() 
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "toggle", title = "Lag script users", desc = "Makes every script user laggy by decreasing their frame rate.", 
		commandcat = "Donor",

		encommands = {"enablelagscriptusers"},
		enaliases = {"elsu"},
		encommanddesc = "Enables lag for script users",

		discommands = {"disablelagscriptusers"},
		disaliases = {"dlsu"},
		discommanddesc = "Disables lag for script users",

		callback = function(state) 
			laguser(state)
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "button", title = "Isolate script users", desc = "Teleports every script user in an isolated environment.", 
		commandcat = "Donor",

		command = "isolatescriptusers",
		aliases = {"isu"},
		commanddesc = "Isolates every script user",

		callback = function() 
			env.essentials.library.lock("Isolate script users", true, "On cooldown - ", 15)

			isolateuser()
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},

	{ type = "separator", title = "Tools" },
	{ type = "toggle", title = "Script user revolver", desc = "Gives you a revolver tool that lets you shoot script users.", 
		commandcat = "Donor",

		encommands = {"scriptuserrevolver"},
		enaliases = {"sur"},
		encommanddesc = "Enables script user revolver",

		discommands = {"unscriptuserrevolver"},
		disaliases = {"unsur"},
		discommanddesc = "Disables script user revolver",

		callback = function(state) 
			giverevolver(state) 
		end, 

		locked = true,
		lockreason = "You are not a Donor." 
	},
	{ type = "toggle", title = "Script user double-barrel shotgun", desc = "Gives you a double-barrel shotgun tool that lets you shoot script users.", 
		commandcat = "Donor",

		encommands = {"scriptuserdoublebarrelshotgun"},
		enaliases = {"sudbs"},
		encommanddesc = "Enables script user double-barrel shotgun",

		discommands = {"unscriptuserdoublebarrelshotgun"},
		disaliases = {"unsudbs"},
		discommanddesc = "Disables script user double-barrel shotgun",

		callback = function(state) 
			givesawedoff(state) 
		end,

		locked = true,
		lockreason = "You are not a Donor." 
	}
}

-------------------------------------------------------------------------------------------------------------------------------

return section

-------------------------------------------------------------------------------------------------------------------------------
