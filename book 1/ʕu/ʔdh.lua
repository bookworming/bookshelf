--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Dialogue handler]
   
---------------------------------------------------------------------------------------------------------------------------]]--

if not game:IsLoaded() then game.Loaded:Wait() end

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local txts = FindFirstChildOfClass(game, "TextService")
local plrs = FindFirstChildOfClass(game, "Players")
local rs = FindFirstChildOfClass(game, "RunService")
local uis = FindFirstChildOfClass(game, "UserInputService")
local ts = FindFirstChildOfClass(game, "TweenService")

local getgenv = (syn and syn.getgenv) or getgenv() or _G

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI

-------------------------------------------------------------------------------------------------------------------------------

local dialogue = env.funcs.recursivels("book%201/%CA%95u/%CA%94d.lua", true)
local sgui = env.essentials.sgui

local expressions = {
	boxten = {
	},
	altboxten = {
	},
	poppy = {
	},
	shrimpo = {
	}
}

-------------------------------------------------------------------------------------------------------------------------------

local function dialoguenoise()
  env.funcs.playsound("rbxassetid://4841731967")
end

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 1)
container.Position = UDim2.new(0.5, 0, 1, -60)
container.Size = UDim2.new(0, 400, 0, 300)
container.BackgroundTransparency = 1
container.Parent = screengui

local PADDING = 2
local DISPLAY_TIME = 5
local TWEEN_TIME = 0.5
local TEXT_SIZE = 16

local notifications = {}

local function tweeny(obj, newY)
	ts:Create(obj, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1, newY)
	}):Play()
end

local function RecalculatePositions()
	local currentOffset = 0
	for _, label in ipairs(notifications) do
		local height = label.AbsoluteSize.Y
		tweeny(label, -currentOffset)
		currentOffset += height + PADDING
	end
end

local ICONS = {
	box = "rbxassetid://87876871905320",
  altbox = "rbxassetid://109975147142863",
	pop = "rbxassetid://104725304950571",
	shr = "rbxassetid://71382889666653",
}

local NAME_COLORS = {
	box = Color3.fromRGB(197, 61, 224),
	altbox = Color3.fromRGB(197, 61, 224),
	pop = Color3.fromRGB(112, 234, 255),
	shr = Color3.fromRGB(247, 109, 40),
}

local function CreateNotification(text, whosaidit)
	local nameText = ""
	local nameColor = Color3.new(1, 1, 1)

	if whosaidit and NAME_COLORS[whosaidit] then
		local displayName =
			(whosaidit == "box" or whosaidit == "altbox") and "Boxten" or
			whosaidit == "pop" and "Poppy" or
			whosaidit == "shr" and "Shrimpo"

		nameText = "[" .. displayName .. "]: "
		nameColor = NAME_COLORS[whosaidit]
    
    dialoguenoise()
	end

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.new(0, 0, 0, 16)
	holder.AnchorPoint = Vector2.new(0.5, 1)
	holder.Position = UDim2.new(0.5, 0, 1, 5)
	holder.ClipsDescendants = false
	holder.Parent = container

	local allFadeable = {}
	local letters = {}
	local cursorX = 0

	if whosaidit and ICONS[whosaidit] then
		local ICON_SIZE = 25
		local icon = Instance.new("ImageLabel")
		icon.BackgroundTransparency = 1
		icon.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
		icon.Position = UDim2.new(0, cursorX, 0.5, -ICON_SIZE / 2)
		icon.Image = ICONS[whosaidit]
		icon.ImageTransparency = 1
		icon.Parent = holder
		cursorX += ICON_SIZE + 4

    spwn(function() ts:Create(icon, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 10}):Play() t(1) ts:Create(icon, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 5}):Play() end)

		table.insert(allFadeable, { label = icon, stroke = nil, baseX = icon.Position.X.Offset, isIcon = true })
	end

	if nameText ~= "" then
		local nameWidth = env.essentials.library.gettextbounds(nameText, Enum.Font.FredokaOne, TEXT_SIZE)

		local nameLabel = Instance.new("TextLabel")
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = nameText
		nameLabel.TextColor3 = nameColor
		nameLabel.Font = Enum.Font.FredokaOne
		nameLabel.TextSize = TEXT_SIZE
		nameLabel.Size = UDim2.new(0, nameWidth, 1, 0)
		nameLabel.Position = UDim2.new(0, cursorX, 0, 0)
		nameLabel.TextTransparency = 1
		nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.Parent = holder

		local border = Instance.new("UIStroke")
		border.Parent = nameLabel
		border.Thickness = 1
		border.Color = Color3.fromRGB(0, 0, 0)
		border.Transparency = 1

		table.insert(allFadeable, { label = nameLabel, stroke = border, baseX = cursorX })
		cursorX += nameWidth
	end

  local textStartX = cursorX

  for i = 1, #text do
    local char = text:sub(i, i)

    local widthUpToHere = env.essentials.library.gettextbounds(text:sub(1, i), Enum.Font.FredokaOne, TEXT_SIZE)
    local widthUpToPrev = i > 1 and env.essentials.library.gettextbounds(text:sub(1, i - 1), Enum.Font.FredokaOne, TEXT_SIZE) or 0
    local charWidth = widthUpToHere - widthUpToPrev
    local xPos = textStartX + widthUpToPrev

    local letter = Instance.new("TextLabel")
		letter.BackgroundTransparency = 1
		letter.Text = char
		letter.TextColor3 = Color3.new(1, 1, 1)
		letter.Font = Enum.Font.FredokaOne
		letter.TextSize = TEXT_SIZE
		letter.Size = UDim2.new(0, charWidth, 1, 0)
    letter.Position = UDim2.new(0, xPos, 0, -2)
		letter.TextTransparency = 1
		letter.TextXAlignment = Enum.TextXAlignment.Left
		letter.Parent = holder

		local border = Instance.new("UIStroke")
		border.Parent = letter
		border.Thickness = 1
		border.Color = Color3.fromRGB(0, 0, 0)
		border.Transparency = 1

		local entry = { label = letter, stroke = border, baseX = xPos }
    table.insert(letters, entry)
	end

	cursorX = textStartX + env.essentials.library.gettextbounds(text, Enum.Font.FredokaOne, TEXT_SIZE)
  holder.Size = UDim2.new(0, cursorX, 0, 16)

	local newHeight = holder.AbsoluteSize.Y + PADDING
	for _, existing in ipairs(notifications) do
		local currentY = existing.Position.Y.Offset
		tweeny(existing, currentY - newHeight)
	end

	table.insert(notifications, 1, holder)

	local fadeInInfo = TweenInfo.new(TWEEN_TIME)
	ts:Create(holder, fadeInInfo, {
		Position = UDim2.new(0.5, 0, 1, 0)
	}):Play()

	for _, entry in ipairs(allFadeable) do
		if entry.isIcon then
			ts:Create(entry.label, fadeInInfo, { ImageTransparency = 0 }):Play()
		else
			ts:Create(entry.label, fadeInInfo, { TextTransparency = 0 }):Play()
			if entry.stroke then
				ts:Create(entry.stroke, fadeInInfo, { Transparency = 0 }):Play()
			end
		end
	end

	spwn(function()
		local popInfo = TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		for _, entry in ipairs(letters) do
			ts:Create(entry.label, popInfo, {
				TextTransparency = 0,
				Position = UDim2.new(0, entry.baseX, 0, 0),
			}):Play()
			if entry.stroke then
				ts:Create(entry.stroke, popInfo, { Transparency = 0 }):Play()
			end
			rs.RenderStepped:Wait()
		end
	end)

	task.delay(5, function()
		local fadeOutInfo = TweenInfo.new(1)

		for _, entry in ipairs(allFadeable) do
			if entry.isIcon then
				ts:Create(entry.label, fadeOutInfo, { ImageTransparency = 1 }):Play()
			else
				ts:Create(entry.label, fadeOutInfo, { TextTransparency = 1 }):Play()
				if entry.stroke then
					ts:Create(entry.stroke, fadeOutInfo, { Transparency = 1 }):Play()
				end
			end
		end

		for _, entry in ipairs(letters) do
			ts:Create(entry.label, fadeOutInfo, { TextTransparency = 1 }):Play()
			if entry.stroke then
				ts:Create(entry.stroke, fadeOutInfo, { Transparency = 1 }):Play()
			end
		end

		t(1)

		for i, v in ipairs(notifications) do
			if v == holder then
				table.remove(notifications, i)
				break
			end
		end

		holder:Destroy()
		RecalculatePositions()
	end)
end

wait(1)
CreateNotification("hello, im boxten. i was the first here.", "box")
wait(2)
CreateNotification("I'm (the other) Boxten. My current behavior can be toggled...", "altbox")
wait(2)
CreateNotification("Hi! I'm Poppy! I hold the Commands Section for Boxten Sex GUI!", "pop")
wait(2)
CreateNotification("I'M SHRIMPO AND I HATE BEING IN AN EXPLOIT SCRIPT!!!", "shr")

-------------------------------------------------------------------------------------------------------------------------------