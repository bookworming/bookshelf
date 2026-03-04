--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Dialogue handler]
   
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

local getgenv = (syn and syn.getgenv) or getgenv() or _G

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI

-------------------------------------------------------------------------------------------------------------------------------

-- local dialogue = env.funcs.recursivels("book%201/%CA%95u/%CA%94d.lua", true)

-------------------------------------------------------------------------------------------------------------------------------

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotificationGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = gethui()

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 1)
container.Position = UDim2.new(0.5, 0, 1, -60)
container.Size = UDim2.new(0, 400, 0, 300)
container.BackgroundTransparency = 1
container.Parent = screenGui

local PADDING = 2
local DISPLAY_TIME = 5
local TWEEN_TIME = 0.5

local notifications = {}

local function TweenPosition(obj, newY)
	ts:Create(obj, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1, newY)
	}):Play()
end

local function RecalculatePositions()
	local currentOffset = 0

	for i, label in ipairs(notifications) do
		local height = label.AbsoluteSize.Y
		TweenPosition(label, -currentOffset)
		currentOffset += height + PADDING
	end
end

local function CreateNotification(text, whosaidit, shoutintensity)
  if whosaidit then
    if whosaidit == "box" then
      text = "[Boxten]: " .. text
    elseif whosaidit == "pop" then
      text = "[Poppy]: " .. text
    elseif whosaidit == "shr" then
      text = "[Shrimpo]: " .. text
    end
  end
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, 0, 0, 24)
	label.TextWrapped = true
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextTransparency = 1
	label.Font = Enum.Font.FredokaOne
	label.TextSize = 16
	label.AnchorPoint = Vector2.new(0.5, 1)
	label.Position = UDim2.new(0.5, 0, 1, 5)
	label.Parent = container
  label.RichText = true

  local border = Instance.new("UIStroke")
  border.Parent = label
  border.Color = Color3.fromRGB(0, 0, 0)
  border.Thickness = 1
  border.Transparency = 1

	task.wait()
	label.Size = UDim2.new(1, 0, 0, label.TextBounds.Y)

	local newHeight = label.AbsoluteSize.Y + PADDING
	for _, existing in ipairs(notifications) do
		local currentY = existing.Position.Y.Offset
		TweenPosition(existing, currentY - newHeight)
	end

	table.insert(notifications, 1, label)

	ts:Create(label, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 0,
		Position = UDim2.new(0.5, 0, 1, 0)
	}):Play()

	ts:Create(border, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Transparency = 0,
	}):Play()

	task.delay(DISPLAY_TIME, function()
		local fade = ts:Create(label, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			TextTransparency = 1
		})

		local fade2 = ts:Create(border, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Transparency = 1
		})

		fade:Play() fade2:Play()
		fade.Completed:Wait()

		for i, v in ipairs(notifications) do
			if v == label then
				table.remove(notifications, i)
				break
			end
		end

		label:Destroy()

		RecalculatePositions()
	end)
end

CreateNotification("First notification")
wait(1)
CreateNotification("Second notification")
wait(1)
CreateNotification("Third notification")

-------------------------------------------------------------------------------------------------------------------------------