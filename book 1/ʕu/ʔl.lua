--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (UI library)

---------------------------------------------------------------------------------------------------------------------------]]--

local lib = {}
lib.version = 2

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local plrs = FindFirstChildOfClass(game, "Players")
local uis = FindFirstChildOfClass(game, "UserInputService")
local ts = FindFirstChildOfClass(game, "TweenService")
local txts = FindFirstChildOfClass(game, "TextService")

local getgenv = getgenv() or _G
local hiddenui = gethui() or game:GetService("CoreGui")
local writefile = (syn and syn.writefile) or writefile
local readfile = (syn and syn.readfile) or readfile
local isfile = (syn and syn.isfile) or isfile
local delfile = (syn and syn.delfile) or delfile
local listfiles = (syn and syn.listfiles) or listfiles
local isfolder = (syn and syn.isfolder) or isfolder
local makefolder = (syn and syn.makefolder) or makefolder

local folder = "Bоxten Sеx GUI"
local mobile = uis.TouchEnabled
local env = getgenv.BSGUI

-------------------------------------------------------------------------------------------------------------------------------

-- ui helpers
function lib.clik() env.funcs.playsound("rbxassetid://552900451") end
function lib.hov() env.funcs.playsound("rbxassetid://6895079853") end

function lib.mapkey(key)
	local name = tostring(key):gsub("Enum.KeyCode.", "")
	if env.stuf.keynamemapping[name] then
		return env.stuf.keynamemapping[name]
	end
	return name
end

local canrepos = true
function lib.centerui(ui, ins, style, time)
	if not canrepos then return end
	canrepos = false

	local size = env.stuf.cam.ViewportSize
	local t = ins and 0 or (time or 0.5)
	local e = style and Enum.EasingDirection.Out or Enum.EasingDirection.InOut
	local s = style or Enum.EasingStyle.Quad

	local tween = ts:Create(
		ui,
		TweenInfo.new(t, s, e),
		{ Position = UDim2.fromOffset(size.X / 2, (size.Y / 2) - 56) }
	)

	tween:Play()
	tween.Completed:Wait()
	canrepos = true
end

local draggableuis = {}
local candrag = true
function lib.makedraggable(ui)
	if draggableuis[ui] then
		return draggableuis[ui]
	end
	local state = {
		draggable = true,
		Connections = {},
		dragged = false,
	}
	draggableuis[ui] = state
	spwn(function()
		local dragspeed = 0.15
		local dragstart
		local startpos
		local buttondragtgl
		local dragginginput
		local DRAG_THRESHOLD = 4

		if mobile then
			local function updatebuttoninput(input)
				if not state.draggable then return end
				if input ~= dragginginput then return end
				local delta = input.Position - dragstart
				if not state.dragged and (math.abs(delta.X) > DRAG_THRESHOLD or math.abs(delta.Y) > DRAG_THRESHOLD) then
					state.dragged = true
				end
				local newpos = UDim2.new(
					startpos.X.Scale,
					startpos.X.Offset + delta.X,
					startpos.Y.Scale,
					startpos.Y.Offset + delta.Y
				)
				ts:Create(ui, TweenInfo.new(dragspeed), {Position = newpos}):Play()
			end
			table.insert(state.Connections,
				ui.InputBegan:Connect(function(input)
					if not state.draggable then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch then
						if dragginginput then return end
						buttondragtgl = true
						state.dragged = false
						dragstart = input.Position
						startpos = ui.Position
						dragginginput = input
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								buttondragtgl = false
								dragginginput = nil
							end
						end)
					end
				end)
			)
			table.insert(state.Connections,
				uis.InputChanged:Connect(function(input, processed)
					if processed and not candrag then return end
					if not state.draggable then return end
					if dragginginput and input == dragginginput and buttondragtgl then
						if input.UserInputType == Enum.UserInputType.MouseMovement
							or input.UserInputType == Enum.UserInputType.Touch then
							updatebuttoninput(input)
						end
					end
				end)
			)
		else
			local function updatebuttoninput(input)
				if not state.draggable then return end
				local delta = input.Position - dragstart
				if not state.dragged and (math.abs(delta.X) > DRAG_THRESHOLD or math.abs(delta.Y) > DRAG_THRESHOLD) then
					state.dragged = true
				end
				local newPos = UDim2.new(
					startpos.X.Scale,
					startpos.X.Offset + delta.X,
					startpos.Y.Scale,
					startpos.Y.Offset + delta.Y
				)
				ts:Create(ui, TweenInfo.new(dragspeed), {Position = newPos}):Play()
			end
			table.insert(state.Connections,
				ui.InputBegan:Connect(function(input)
					if not state.draggable then return end
					if input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch then
						buttondragtgl = true
						state.dragged = false
						dragstart = input.Position
						startpos = ui.Position
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								buttondragtgl = false
							end
						end)
					end
				end)
			)
			table.insert(state.Connections,
				uis.InputChanged:Connect(function(input, processed)
					if processed and not candrag then return end
					if not state.draggable then return end
					if (input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch)
						and buttondragtgl then
						updatebuttoninput(input)
					end
				end)
			)
		end
	end)
	return state
end

function lib.gettextbounds(text, font, size, res)
	local bounds = txts:GetTextSize(text, size, font, res or Vector2.new(1920, 1080))
	return bounds.X, bounds.Y
end

-------------------------------------------------------------------------------------------------------------------------------

-- ui functions
function lib.makecooltext(parent, size, text, textsize, color, borderthickness, pos, alignment, alignment2, button, Z)
	local txt = button and Instance.new("TextButton") or Instance.new("TextLabel")
	txt.BorderSizePixel = 0
	txt.AnchorPoint = Vector2.new(0.5, 0.5)
	txt.Position = pos or UDim2.new(0.5, 0, 0.5, 0)
	txt.Size = size or UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.Parent = parent
	txt.Font = Enum.Font.FredokaOne
	txt.TextXAlignment = alignment or Enum.TextXAlignment.Center
	txt.TextYAlignment = alignment2 or Enum.TextYAlignment.Center
	txt.Text = text
	txt.TextWrapped = true
	txt.TextSize = textsize or 16
	txt.RichText = true
	txt.TextStrokeTransparency = 1
	txt.TextColor3 = color or Color3.fromRGB(255, 255, 255)
	txt.Active = button and true or false
	txt.ZIndex = Z or (parent and parent.ZIndex + 1 or 1)

	local txtborder = Instance.new("UIStroke")
	txtborder.Thickness = borderthickness or 2
	txtborder.Color = Color3.fromRGB(0, 0, 0)
	txtborder.Parent = txt
	return txt
end

function lib.makecoolframe(size, parent, center, draggable, pos, round, switch, button, Z)
	Z = Z or 1

	local bg = button and Instance.new("ImageButton") or Instance.new("Frame")
	bg.BorderSizePixel = 0
	bg.AnchorPoint = Vector2.new(0.5, 0.5)
	bg.Position = pos or UDim2.new(0.5, 0, 0.5, 0)
	bg.Size = size
	bg.ZIndex = Z
	bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bg.Parent = parent
	if button then bg.AutoButtonColor = false end

	local bggrad = Instance.new("UIGradient")
	bggrad.Color = switch and ColorSequence.new {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 12, 12)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)),
	} or ColorSequence.new {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 69, 69)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)),
	}
	bggrad.Rotation = 90
	bggrad.Parent = bg

	local bground = Instance.new("UICorner")
	bground.CornerRadius = UDim.new(round and 1 or 0, 17)
	bground.Parent = bg

	local inline = Instance.new("UIStroke")
	inline.Thickness = 1
	inline.Color = switch and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(189, 189, 189)
	inline.Parent = bg
	inline.BorderOffset = UDim.new(0, -1)

	local inlinegrad = Instance.new("UIGradient")
	inlinegrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 189, 189)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)),
	})

	inlinegrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.7, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	inlinegrad.Rotation = 90
	inlinegrad.Parent = inline

	local shadow = Instance.new("UIStroke")
	shadow.Thickness = 2
	shadow.Color = Color3.fromRGB(0, 0, 0)
	shadow.Parent = bg

	local drag
	if center then lib.centerui(bg, true) end
	if draggable then 
		if button then
			drag = lib.makedraggable(bg)
		else
			lib.makedraggable(bg) 
		end
	end

	return bg, drag
end

function lib.makecoolbutton(text, size, parent, pos, type, textsize, padding, Z, noscale)
	Z = Z or 10
	type = type or "yes"

	local themes = {
		yes = {
			bg = {{183,202,96},{95,200,93},{95,200,93}},
			stroke = {240,254,157},
			inline = {{242,255,158},{22,22,22}},
		},
		no = {
			bg = {{238,127,116},{242,84,67},{242,84,67}},
			stroke = {255,196,197},
			inline = {{255,191,186},{231,68,66}},
		},
		info = {
			bg = {{135,164,220},{62,130,204},{62,130,204}},
			stroke = {209,230,255},
			inline = {{209,230,255},{22,22,22}},
		},
		orang = {
			bg = {{255,181,93},{242,157,65},{242,157,65}},
			stroke = {255,217,170},
			inline = {{255,217,170},{22,22,22}},
		},
		yellow = {
			bg = {{255,240,150},{255,204,69},{255,204,69}},
			stroke = {251,255,170},
			inline = {{251,255,170},{22,22,22}},
		},
		purpl = {
			bg = {{162,92,255}, {146,76,239}, {146,76,239}},
			stroke = {206,172,255},
			inline = {{220, 180, 255}, {22, 22, 22}},
		},
		pink = {
			bg = {{255,160,190},{250, 115, 230},{250, 115, 230}},
			stroke = {255,230,250},
			inline = {{255,230,250},{22,22,22}},
		},
		neutral = {
			bg = {{214, 214, 214},{150,150,150},{150,150,150}},
			stroke = {240,240,240},
			inline = {{240,240,240},{22,22,22}},
		},
	}

	local theme = themes[type]

	local bg = Instance.new("ImageButton")
	bg.Size = size
	bg.Position = pos or UDim2.new(0.5,0,0.5,0)
	bg.AnchorPoint = Vector2.new(0.5,0.5)
	bg.AutoButtonColor = false
	bg.ZIndex = Z
	bg.BorderSizePixel = 0
	bg.BackgroundColor3 = Color3.new(1,1,1)
	bg.Parent = parent

	Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)

	local scale = Instance.new("UIScale", bg)

	local function rainbowSequence()
		return ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 195, 90)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 120)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(190, 255, 140)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(130, 190, 255)),
			ColorSequenceKeypoint.new(0.79, Color3.fromRGB(190, 150, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 146, 237)),
		})
	end

	local bgGrad = Instance.new("UIGradient")
	bgGrad.Parent = bg

	if type == "rb" then
		bgGrad.Color = rainbowSequence()
		bgGrad.Rotation = 0
	else
		bgGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(unpack(theme.bg[1]))),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(unpack(theme.bg[2]))),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(unpack(theme.bg[3]))),
		})
		bgGrad.Rotation = 90
	end

	local inline = Instance.new("UIStroke", bg)
	inline.Thickness = 1
	inline.BorderOffset = UDim.new(0,-1)
	inline.Color = Color3.new(200, 200, 200)

	local inlineGrad = Instance.new("UIGradient")
	inlineGrad.Parent = inline

	if type == "rb" then
		inlineGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
		})
		inlineGrad.Rotation = 90
		inlineGrad.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.3),
			NumberSequenceKeypoint.new(0.4, 1),
			NumberSequenceKeypoint.new(1, 1),
		})
	else
		inlineGrad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(unpack(theme.inline[1]))),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(unpack(theme.inline[2]))),
		})
		inlineGrad.Rotation = 90
		inlineGrad.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.4, 1),
			NumberSequenceKeypoint.new(1, 1),
		})
	end

	local shadow = Instance.new("UIStroke", bg)
	shadow.Thickness = 2
	shadow.Color = Color3.new(0,0,0)

	local txt = lib.makecooltext(bg, size, text, textsize, nil, 2)
	txt.ZIndex = Z + 1
	local pad = padding or {}
	local p = Instance.new("UIPadding", txt)
	p.PaddingLeft   = UDim.new(0, pad.left or 6)
	p.PaddingRight  = UDim.new(0, pad.right or 6)
	p.PaddingTop    = UDim.new(0, pad.top or 6)
	p.PaddingBottom = UDim.new(0, pad.bottom or 6)

	local hover = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local press = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween

	local function t(v, info)
		if noscale then return end
		if tween then tween:Cancel() end
		tween = ts:Create(scale, info, {Scale = v})
		tween:Play()
	end

	bg.MouseEnter:Connect(function() lib.hov() t(1.02, hover) end)
	bg.MouseLeave:Connect(function() t(1, hover) end)
	bg.MouseButton1Up:Connect(function() t(1.02, hover) end)
	bg.Activated:Connect(function() lib.clik() end)
	bg.MouseButton1Down:Connect(function() t(0.98, press) end)

	return bg, txt
end

function lib.makecooltextbox(size, parent, defaulttext, textsize, phtext, icon, pos, maxchars, Z)
	Z = Z or 1

	local bg = Instance.new("TextBox")
	bg.BorderSizePixel = 0
	bg.AnchorPoint = Vector2.new(0.5, 0.5)
	bg.Size = size
	bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	bg.Position = pos or UDim2.new(0.5, 0, 0.5, 0)
	bg.Parent = parent
	bg.BorderSizePixel = 0
	bg.ZIndex = Z
	bg.Font = Enum.Font.FredokaOne
	bg.Text = defaulttext or ""
	bg.PlaceholderText = phtext or ""
	bg.TextSize = textsize or 16
	bg.TextStrokeTransparency = 1
	bg.TextColor3 = Color3.fromRGB(255, 255, 255)
	bg.PlaceholderColor3 = Color3.fromRGB(48, 48, 48)
	bg.TextXAlignment = Enum.TextXAlignment.Left
	bg.ClipsDescendants = true

	local bgpad = Instance.new("UIPadding")
	bgpad.PaddingLeft = UDim.new(0, (bg.Size.Y.Offset + (bg.Size.Y.Offset < 32 and -2 or 2)))
	bgpad.PaddingRight = UDim.new(0, 10)
	bgpad.PaddingBottom = UDim.new(0, 2)
	bgpad.Parent = bg

	local bground = Instance.new("UICorner")
	bground.CornerRadius = UDim.new(0, 15)
	bground.Parent = bg

	maxchars = maxchars or 300
	bg:GetPropertyChangedSignal("Text"):Connect(function()
		if #bg.Text > maxchars then
			bg.Text = bg.Text:sub(1, maxchars)
		end
	end)

	local inline = Instance.new("UIStroke")
	inline.Thickness = 1
	inline.Color = Color3.fromRGB(189, 189, 189)
	inline.Parent = bg
	inline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	inline.BorderOffset = UDim.new(0, -1)

	local inlinegrad = Instance.new("UIGradient")
	inlinegrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 189, 189)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25)),
	})

	inlinegrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	inlinegrad.Rotation = -90
	inlinegrad.Parent = inline

	local shadow = Instance.new("UIStroke")
	shadow.Thickness = 2
	shadow.Color = Color3.fromRGB(0, 0, 0)
	shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	shadow.Parent = bg

	if icon then
		local ico = Instance.new("ImageLabel")
		ico.AnchorPoint = Vector2.new(0, 0.5)
		ico.Position = UDim2.new(0, -24, 0.5, 0)
		ico.Size = UDim2.new(0, bg.Size.Y.Offset - 16, 0, bg.Size.Y.Offset - 16)
		ico.ZIndex = Z + 1
		ico.BackgroundTransparency = 1
		ico.Parent = bg
		ico.ImageColor3 = Color3.fromRGB(95, 95, 95)
		ico.Image = icon
	else
		local ico = Instance.new("ImageLabel")
		ico.Image = "rbxassetid://7329220527"
		ico.AnchorPoint = Vector2.new(0, 0.5)
		ico.Position = UDim2.new(0, (bg.Size.Y.Offset < 32 and -18) or -24, 0.5, 1)
		ico.Size = UDim2.new(0, bg.Size.Y.Offset - 16, 0, bg.Size.Y.Offset - 16)
		ico.ZIndex = Z + 1
		ico.BackgroundTransparency = 1
		ico.Parent = bg
		ico.ImageColor3 = Color3.fromRGB(95, 95, 95)
	end

	return bg
end

function lib.makecoolscrollingframe(size, parent, pos, layoutpadding, Z)
	Z = Z or 1
	local bg = Instance.new("Frame")
	bg.BorderSizePixel = 0
	bg.Position = pos or UDim2.new(0.5, 0, 0.5, 0)
	bg.ZIndex = Z
	bg.AnchorPoint = Vector2.new(0.5, 0.5)
	bg.Size = size or UDim2.new(0, 190, 0, 140)
	bg.BackgroundTransparency = 1
	bg.Parent = parent
	local bground = Instance.new("UICorner")
	bground.CornerRadius = UDim.new(0, 8)
	bground.Parent = bg
	local scroll = Instance.new("ScrollingFrame")
	scroll.BorderSizePixel = 0
	scroll.Size = UDim2.new(1, 0, 1, 0)
	scroll.BackgroundTransparency = 1
	scroll.Parent = bg
	scroll.ZIndex = Z + 1
	scroll.ScrollBarThickness = 0
	scroll.ScrollBarImageTransparency = 1
	scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 2)
	pad.PaddingLeft = UDim.new(0, -19)
	pad.Parent = scroll
	local scrollbar = Instance.new("Frame")
	scrollbar.BorderSizePixel = 0
	scrollbar.Position = UDim2.new(1, -5, 0.5, 0)
	scrollbar.AnchorPoint = Vector2.new(0.5, 0.5)
	scrollbar.Size = UDim2.new(0, 10, 0, size.Y.Offset - 4)
	scrollbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	scrollbar.Parent = bg
	scrollbar.ZIndex = Z + 2
	scrollbar.Active = true
	scrollbar.ClipsDescendants = true
	local bggrad = Instance.new("UIGradient")
	bggrad.Color = ColorSequence.new {
		ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 22)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12)),
	}
	bggrad.Rotation = 90
	bggrad.Parent = scrollbar
	Instance.new("UICorner", scrollbar).CornerRadius = UDim.new(1, 0)
	local bar = Instance.new("Frame")
	bar.AnchorPoint = Vector2.new(1, 0)
	bar.Position = UDim2.new(1, -2, 0, 2)
	bar.Size = UDim2.new(0, 6, 1, -4)
	bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bar.BorderSizePixel = 0
	bar.Active = true
	bar.ZIndex = Z + 3
	bar.Parent = scrollbar
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local function getAncestorScale()
		return env.stuf.mainframescale and env.stuf.mainframescale.Scale or 1
	end

	local ogscrollbarheight = size.Y.Offset - 4

	local function updateBar()
		local scale = getAncestorScale()
		local view = scroll.AbsoluteWindowSize.Y / scale
		local canvas = scroll.CanvasSize.Y.Offset
		local barBackgroundHeight = ogscrollbarheight

		if canvas <= view then
			bar.Visible = false
			return
		end
		bar.Visible = true

		local ratio = view / canvas
		local actualHeight = math.clamp(ratio * barBackgroundHeight, 10, barBackgroundHeight - 4)
		bar.Size = UDim2.new(0, 6, 0, actualHeight - 4)

		local maxScrollPos = scroll.CanvasSize.Y.Offset - view
		local maxBarTravel = barBackgroundHeight - actualHeight
		local scrollPercent = maxScrollPos > 0 and math.clamp(scroll.CanvasPosition.Y / maxScrollPos, 0, 1) or 0
		local barY = math.clamp(scrollPercent * maxBarTravel + 2, 2, barBackgroundHeight - actualHeight + 2)
		bar.Position = UDim2.new(1, -2, 0, barY)
	end

	scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(updateBar)
	scroll:GetPropertyChangedSignal("CanvasSize"):Connect(updateBar)
	scroll:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateBar)
	updateBar()

	local dragging = false
	local dragStartY = 0
	local dragStartCanvasY = 0

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			candrag = false
			dragStartY = input.Position.Y
			dragStartCanvasY = scroll.CanvasPosition.Y
		end
	end)

	uis.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local scale = getAncestorScale()
			local view = scroll.AbsoluteWindowSize.Y / scale
			local canvas = scroll.CanvasSize.Y.Offset
			if canvas <= view then return end

			local barBackgroundHeight = ogscrollbarheight
			local actualHeight = math.clamp((view / canvas) * barBackgroundHeight, 10, barBackgroundHeight - 4)
			local maxBarTravel = barBackgroundHeight - actualHeight
			local maxScrollPos = canvas - view

			local delta = (input.Position.Y - dragStartY) / scale
			local scrollDelta = (delta / maxBarTravel) * maxScrollPos
			scroll.CanvasPosition = Vector2.new(scroll.CanvasPosition.X, math.clamp(dragStartCanvasY + scrollDelta, 0, maxScrollPos))
		end
	end)

	uis.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			candrag = true
		end
	end)

	local inline = Instance.new("UIStroke")
	inline.Thickness = 1
	inline.Color = Color3.fromRGB(100, 100, 100)
	inline.Parent = scrollbar
	inline.BorderOffset = UDim.new(0, -1)
	local inlinegrad = Instance.new("UIGradient")
	inlinegrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 189, 189)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)),
	})
	inlinegrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.7, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	inlinegrad.Rotation = 180
	inlinegrad.Parent = inline
	local shadow = Instance.new("UIStroke")
	shadow.Thickness = 2
	shadow.Color = Color3.fromRGB(0, 0, 0)
	shadow.Parent = scrollbar

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, layoutpadding or 12)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = scroll

	local function updateCanvas()
		local scale = getAncestorScale()
		scroll.CanvasSize = UDim2.new(0, 0, 0, (layout.AbsoluteContentSize.Y / scale) + 6)
	end
	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
	updateCanvas()

	spwn(function()
		repeat t() until env.stuf.mainframescale
		env.stuf.mainframescale:GetPropertyChangedSignal("Scale"):Connect(function()
			updateCanvas()
			updateBar()
		end)
	end)

	return scroll, bg
end

function lib.addcooltab(size, parent, pos, text, icon)
	local bg = Instance.new("Frame")
	bg.BorderSizePixel = 0
	bg.Position = pos or UDim2.new(0.5, 0, 0, -12)
	bg.AnchorPoint = Vector2.new(0.5, 0.5)
	bg.Size = size or UDim2.new(0, 90, 0, 40)
	bg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	bg.Parent = parent
	bg.ZIndex = parent.ZIndex - 1

	local bgpad = Instance.new("UIPadding")
	bgpad.PaddingBottom = UDim.new(0, 8)
	bgpad.Parent = bg

	local bggrad = Instance.new("UIGradient")
	bggrad.Color =
		ColorSequence.new {
			ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 22, 22)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12)),
		}
	bggrad.Rotation = 90
	bggrad.Parent = bg

	local bground = Instance.new("UICorner")
	bground.CornerRadius = UDim.new(0, 8)
	bground.Parent = bg

	local inline = Instance.new("UIStroke")
	inline.Thickness = 1
	inline.Color = Color3.fromRGB(100, 100, 100)
	inline.Parent = bg
	inline.BorderOffset = UDim.new(0, -1)

	local inlinegrad = Instance.new("UIGradient")
	inlinegrad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(189, 189, 189)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22)),
	})

	inlinegrad.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.7, 0),
		NumberSequenceKeypoint.new(1, 1),
	})
	inlinegrad.Rotation = 90
	inlinegrad.Parent = inline

	local shadow = Instance.new("UIStroke")
	shadow.Thickness = 2
	shadow.Color = Color3.fromRGB(0, 0, 0)
	shadow.Parent = bg

	local txt = lib.makecooltext(bg, size, text, 16, nil, 2, nil, Enum.TextXAlignment.Right, Enum.TextYAlignment.Center)
	txt.ZIndex = bg.ZIndex + 1

	local txtpad = Instance.new("UIPadding")
	txtpad.PaddingRight = UDim.new(0, 8)
	txtpad.PaddingBottom = UDim.new(0, 1)
	txtpad.Parent = txt

	if icon then
		local ico = Instance.new("ImageLabel")
		ico.Size = UDim2.new(0, bg.Size.Y.Offset, 0, bg.Size.Y.Offset)
		ico.AnchorPoint = Vector2.new(0, 0.5)
		ico.Position = UDim2.new(0, -2, 0.5, 0)
		ico.BorderSizePixel = 0
		ico.BackgroundTransparency = 1
		ico.ZIndex = bg.ZIndex + 1
		ico.BorderColor3 = Color3.new(1, 1, 1)
		ico.ImageColor3 = Color3.new(1, 1, 1)
		ico.ZIndex = 99994
		ico.Parent = bg
		ico.Image = icon
	else
		local ico = Instance.new("ImageLabel")
		ico.Size = UDim2.new(0, bg.Size.Y.Offset, 0, bg.Size.Y.Offset)
		ico.AnchorPoint = Vector2.new(0, 0.5)
		ico.Position = UDim2.new(0, -2, 0.5, 0)
		ico.BorderSizePixel = 0
		ico.BackgroundTransparency = 1
		ico.ZIndex = bg.ZIndex + 1
		ico.BorderColor3 = Color3.new(1, 1, 1)
		ico.ImageColor3 = Color3.new(1, 1, 1)
		ico.ZIndex = 99994
		ico.Parent = bg
		ico.Image = "rbxassetid://100574547642033"
	end

	return bg
end

function lib.addclosebutton(size, parent, pos, text, textsize, callback)
	local bg = lib.makecoolbutton("", size, parent, pos, "no", textsize or 16, nil, parent.ZIndex + 101)
	lib.makecooltext(bg, size, text, textsize or 16, nil, 2, nil).ZIndex = parent.ZIndex + 102

	bg.Activated:Connect(function()
		if callback then callback() end
	end)

	return bg
end

local showingsection = nil
function lib.makesectionbutton(parent, size, pos, image, rotation, on)
	local b = Instance.new("ImageButton", parent)
	b.Size = size
	b.Position = pos
	b.Rotation = rotation or -10
	b.BackgroundTransparency = 1
	b.ZIndex = 70
	b.BorderSizePixel = 0
	b.Image = image
	b.ImageColor3 = Color3.fromRGB(255, 255, 255)

	local st = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local dst = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function select()
		ts:Create(b, st, {
			Rotation = 0,
			ImageColor3 = Color3.fromRGB(170, 170, 170)
		}):Play()
		showingsection = b
	end

	local function deselect(btn)
		ts:Create(btn, dst, {
			Rotation = -10,
			ImageColor3 = Color3.fromRGB(255, 255, 255)
		}):Play()
	end

	b.Activated:Connect(function()
		if showingsection and showingsection ~= b then
			lib.clik()
			deselect(showingsection)
		end
		select()
	end)

	if on then
		b.Rotation = 0
		b.ImageColor3 = Color3.fromRGB(170, 170, 170)
		showingsection = b
	end

	return b
end

local mainframe
function lib.loadmainframe()
	local FRAME_SIZE = UDim2.new(0, 506, 0, 300)
	local VIEWPORT_SIZE = UDim2.new(0, 494, 0, 298)
	local SECTION_HEIGHT = 288
	local SECTION_SPACING = 40
	local SECTION_COUNT = 5
	local TOTAL_HEIGHT = (SECTION_HEIGHT + SECTION_SPACING) * SECTION_COUNT - SECTION_SPACING

	mainframe = lib.makecoolframe(FRAME_SIZE, env.essentials.sgui, true)
	mainframe.Visible = false
	lib.addcooltab(UDim2.new(0, 200, 0, 40), mainframe, UDim2.new(0, 120, 0, -12), "Noxious: Boxten Sex GUI")
	lib.addclosebutton(UDim2.new(0, 48, 0, 27), mainframe, UDim2.new(1, -43, 0, 0), "X", 22, function() mainframe.Visible = false end)

	env.stuf.mainframedrag = lib.makedraggable(mainframe)

	local sectionviewport = Instance.new("Frame")
	sectionviewport.Size = VIEWPORT_SIZE
	sectionviewport.AnchorPoint = Vector2.new(0.5, 0.5)
	sectionviewport.Position = UDim2.new(0.5, 0, 0.5, 0)
	sectionviewport.BackgroundTransparency = 1
	sectionviewport.ClipsDescendants = true
	sectionviewport.Parent = mainframe

	local sectioncontainer = Instance.new("Frame")
	sectioncontainer.Size = UDim2.new(1, 0, 0, TOTAL_HEIGHT)
	sectioncontainer.Position = UDim2.new(0, 0, 0, 4)
	sectioncontainer.BackgroundTransparency = 1
	sectioncontainer.Parent = sectionviewport
	Instance.new("UICorner", sectioncontainer).CornerRadius = UDim.new(0, 14)

	local sections = {}
	for i = 1, SECTION_COUNT do
		local section = Instance.new("Frame")
		section.Size = UDim2.new(1, 0, 0, SECTION_HEIGHT)
		section.Position = UDim2.new(
			0, 0,
			0, (i - 1) * (SECTION_HEIGHT + SECTION_SPACING)
		)
		section.BackgroundTransparency = 1
		section.BorderSizePixel = 0
		section.Parent = sectioncontainer

		Instance.new("UICorner", section).CornerRadius = UDim.new(0, 14)
		sections[i] = section
	end

	local function createSeparator(index, imageId)
		local sep = Instance.new("Frame")
		sep.Size = UDim2.new(1, 0, 0, SECTION_SPACING)
		sep.Position = UDim2.new(
			0, 0,
			0, (index * SECTION_HEIGHT) + ((index - 0.5) * SECTION_SPACING)
		)
		sep.BackgroundTransparency = 1
		sep.Parent = sectioncontainer

		for _, side in ipairs({0, 1}) do
			local line = Instance.new("Frame")
			line.Size = UDim2.new(0.5, -46, 0, 2)
			line.Position = UDim2.new(side, side == 0 and 16 or -16, 0.5, -20)
			line.AnchorPoint = Vector2.new(side, 0.5)
			line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			line.BorderSizePixel = 0
			line.Parent = sep
			Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)
		end

		if imageId then
			local img = Instance.new("ImageLabel")
			img.Size = UDim2.new(0, 28, 0, 28)
			img.Position = UDim2.new(0.5, 0, 0.5, -20)
			img.AnchorPoint = Vector2.new(0.5, 0.5)
			img.BackgroundTransparency = 1
			img.Image = imageId
			img.ImageColor3 = Color3.fromRGB(255, 255, 255)
			img.Parent = sep
		end
	end

	local function scrollto(index)
		ts:Create(sectioncontainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, -(index - 1) * (SECTION_HEIGHT + SECTION_SPACING) + 4)}):Play()
	end

	local buttons = {
		{34, UDim2.new(0, 232, 0, -17), "rbxassetid://9692125126", true},
		{34, UDim2.new(0, 274, 0, -17), "rbxassetid://102459578526748"},
		{34, UDim2.new(0, 315, 0, -17), "rbxassetid://9405931578"},
		{34, UDim2.new(0, 356, 0, -17), "rbxassetid://14895333462"},
		{30, UDim2.new(0, 397, 0, -17), "rbxassetid://6594776225"},
	}

	for i, data in ipairs(buttons) do
		local btn = lib.makesectionbutton(
			mainframe,
			UDim2.new(0, data[1], 0, data[1]),
			data[2],
			data[3],
			-10,
			data[4]
		)
		btn.Activated:Connect(function()
			scrollto(i)
		end)
	end

	local separatorImages = {
		"rbxassetid://103444414602220",
		"rbxassetid://93502951384804",
		"rbxassetid://116292598185848",
		"rbxassetid://133262539402875",
	}

	for i, img in ipairs(separatorImages) do
		createSeparator(i, img)
	end

	env.stuf.mainframescale = Instance.new("UIScale")
	env.stuf.mainframescale.Parent = mainframe
	env.stuf.mainframescale.Scale = env.gear.general.mainframescale

	return mainframe, sections
end

-------------------------------------------------------------------------------------------------------------------------------

-- element helpers
function lib.update(title, value)
	local element = env.essentials.elements[title] or env.essentials.toggles[title] or env.essentials.buttons[title]
	if not element then return end

	if element.type == "inputtoggle" and typeof(value) == "table" then
		if value.text ~= nil then element.inputbox.Text = tostring(value.text) end
		if value.enabled ~= nil then element.enabled = value.enabled end
		if element.updtoggles then element.updtoggles() end
		if element.callback then 
			spwn(element.callback, element.inputbox.Text, element.enabled) 
		end

	elseif element.setValue then
		element.setValue(value)

	elseif element.updtoggles then
		element.enabled = value
		element.updtoggles()
		if element.callback then 
			spwn(element.callback, element.enabled) 
		end
	end
end

function lib.lock(title, state, message, cooldown)
	spwn(function()
		local element = nil
		local data = nil
		local unbindable = false

		data = env.essentials.toggles[title] or env.essentials.buttons[title]

		if not data then
			data = env.essentials.elements[title]
			if data then
				unbindable = true
			end
		end

		element = data and data.frame 

		if not element then return end

		local function setWall(target, isLocked, showExtra, cdTime)
			if not target then return end
			local wall = target:FindFirstChild("wall")
			local wall2 = target:FindFirstChild("wall2")

			target:SetAttribute("locked", isLocked)

			if isLocked then
				if wall then wall:Destroy() end

				local w = Instance.new("Frame")
				w.Name = "wall"
				w.Size = UDim2.new(1, 0, 1, 0)
				w.BackgroundColor3 = Color3.new(0, 0, 0)
				w.BackgroundTransparency = 0.5
				w.BorderSizePixel = 0
				w.ZIndex = target.ZIndex + 10
				w.Parent = target
				Instance.new("UICorner", w).CornerRadius = UDim.new(0, 16) 

				local padlock = Instance.new("ImageLabel")
				padlock.Size = UDim2.new(0, 24, 0, 24)
				padlock.Position = UDim2.new(0.5, 0, 0.5, -5)
				padlock.AnchorPoint = Vector2.new(0.5, 0.5)
				padlock.BackgroundTransparency = 1
				padlock.Image = "rbxassetid://15117261700"
				padlock.ImageColor3 = Color3.new(1, 1, 1)
				padlock.ZIndex = w.ZIndex + 1
				padlock.Parent = w

				local msg = nil
				if message or (cdTime and cdTime > 0) then
					msg = Instance.new("TextLabel")
					msg.Size = UDim2.new(1, 0, 0, 20)
					msg.Position = UDim2.new(0.5, 0, 0.5, 13)
					msg.RichText = true
					msg.AnchorPoint = Vector2.new(0.5, 0.5)
					msg.BackgroundTransparency = 1
					msg.TextColor3 = Color3.new(1, 1, 1)
					msg.TextStrokeTransparency = 1
					msg.Font = Enum.Font.FredokaOne
					msg.TextSize = 10
					msg.ZIndex = w.ZIndex + 2
					msg.Parent = w
				end

				if showExtra then
					local w2 = Instance.new("Frame")
					w2.Name = "wall2"
					w2.Size = UDim2.new(0, 18, 0, 18)
					w2.BackgroundColor3 = Color3.new(0, 0, 0)
					w2.BackgroundTransparency = 0.5
					w2.BorderSizePixel = 0
					w2.AnchorPoint = Vector2.new(1, 0)
					w2.ZIndex = w.ZIndex + 200
					w2.Position = UDim2.new(1, 6, 0, -6)
					w2.Parent = target
					Instance.new("UICorner", w2).CornerRadius = UDim.new(1, 0) 
				end

				spwn(function()
					if message and not cdTime then
						msg.Text = message or "Locked" return
					end

					if cdTime and cdTime > 0 then
						spwn(function()
							local start = tick()
							while tick() - start < cdTime do
								if not target:FindFirstChild("wall") then break end
								local remaining = math.max(0, cdTime - (tick() - start))
								if msg then
									local time = string.format("%.2f", remaining) .. "s"
									msg.Text = (message and cdTime) and message .. time or time
								end
								task.wait(0.05)
							end
							if target:FindFirstChild("wall") then
								lib.lock(title, false)
							end
						end)
					end
				end)
			else
				if wall then wall:Destroy() end
				if wall2 then wall2:Destroy() end
			end
		end

		setWall(element, state, not unbindable, cooldown)

		if data and data.buttonFrame then
			setWall(data.buttonFrame, state, false, cooldown)
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

-- build
function lib.addseperator(parent, title)
	local width, leftpadding, rightpadding = 295, 14, 68
	local textwidth = width - rightpadding - 20

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, width, 0, 12)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.new(0, 20, 0, 0)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 15, Vector2.new(textwidth, math.huge))

	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 15, nil, 2, UDim2.new(0, leftpadding + textwidth / 2 + 18, 0.5), Enum.TextXAlignment.Left)

	return frame
end

lib.seperatebuttonzindexoff = 1

function lib.addtoggle(parent, title, description, callback, bindable, default, locked, lockreason)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 68, -7
	local textwidth = width - rightpadding - 20
	bindable = bindable or true

	local ON = {
		bg = {
			Color3.fromRGB(183, 202, 96),
			Color3.fromRGB(95, 200, 93),
			Color3.fromRGB(95, 200, 93),
		},
		stroke = Color3.fromRGB(244, 255, 199),
	}

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false, nil, nil, nil, true, 60)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	local toggleId = title

	env.essentials.toggles[toggleId] = {
		type = "toggle",
		frame = frame,
		dirty = false,
		enabled = default or false,
		currentBind = nil,
		title = title,
		callback = callback,
		elementtitle = nil,
		createdButtons = {},
		currentButtonData = nil,
		buttonFrame = nil,
		updateSize = nil
	}
	local state = env.essentials.toggles[toggleId]

	local toggle, knob, bgGrad, stroke = nil, nil, nil, nil
	local OFF = nil

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))
	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 1)

	local elementtitle = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	elementtitle.ZIndex = 61

	local elementdesc = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + tetxgap + dh / 2 + 5), Enum.TextXAlignment.Left)
	elementdesc.ZIndex = 61

	local function updateFrameSize()
		local function stripRichText(str)
			return str:gsub("<[^>]-" .. ">", "")
		end

		local cleanTitleText = stripRichText(elementtitle.Text)

		local _, newTh = lib.gettextbounds(cleanTitleText, elementtitle.Font, elementtitle.TextSize, Vector2.new(textwidth, math.huge))
		local _, currDh = lib.gettextbounds(description, elementdesc.Font, elementdesc.TextSize, Vector2.new(textwidth, math.huge))

		local newDescY = leftpadding + newTh + tetxgap
		local newTotalHeight = newTh + currDh + leftpadding * 2 + tetxgap + 1

		elementtitle.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + newTh / 2 - 5)
		elementdesc.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, newDescY + currDh / 2 + 5)

		if toggle then
			toggle.Position = UDim2.new(1, -38, 0.5, 0) 
		end

		frame.Size = UDim2.new(0, width, 0, newTotalHeight)
	end

	state.elementtitle = elementtitle
	state.updateSize = updateFrameSize

	local function getgrad(gradient)
		if not gradient then return nil end
		local keys = gradient.Color.Keypoints
		local c1 = keys[1] and keys[1].Value
		local c2 = keys[2] and keys[2].Value or c1
		local c3 = keys[3] and keys[3].Value or c2
		return { c1, c2, c3 }
	end

	local activeGradTweens = {}

	local function getCurrentGrad(gradient)
		local keys = gradient.Color.Keypoints
		return {
			keys[1].Value,
			keys[2] and keys[2].Value or keys[1].Value,
			keys[3] and keys[3].Value or keys[2].Value,
		}
	end

	local gradCurrentColors = {}

	local function tweengrad(gradient, targetColors, tweenInfo)
		if not gradient or not tweenInfo then return end

		if activeGradTweens[gradient] then
			activeGradTweens[gradient].tween:Cancel()
			activeGradTweens[gradient].conn:Disconnect()
			activeGradTweens[gradient].completedConn:Disconnect()
			activeGradTweens[gradient] = nil
		end

		local from = gradCurrentColors[gradient] or getCurrentGrad(gradient)
		local current = {from[1], from[2], from[3]}

		local t = Instance.new("NumberValue")
		t.Value = 0

		local conn = t.Changed:Connect(function(a)
			local c1 = current[1]:Lerp(targetColors[1], a)
			local c2 = current[2]:Lerp(targetColors[2], a)
			local c3 = current[3]:Lerp(targetColors[3], a)

			gradCurrentColors[gradient] = {c1, c2, c3}

			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, c1),
				ColorSequenceKeypoint.new(0.4, c2),
				ColorSequenceKeypoint.new(1, c3),
			})
		end)

		local tween = ts:Create(t, tweenInfo, { Value = 1 })
		local entry = { tween = tween, conn = conn, completedConn = nil }
		activeGradTweens[gradient] = entry

		entry.completedConn = tween.Completed:Connect(function()
			if activeGradTweens[gradient] == entry then
				activeGradTweens[gradient] = nil
				gradCurrentColors[gradient] = targetColors
			end
			conn:Disconnect()
			t:Destroy()
		end)

		tween:Play()
	end

	local function updtoggles()
		local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local isEnabled = env.essentials.toggles[toggleId].enabled

		if knob then
			ts:Create(knob, ti, {
				Position = isEnabled and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
			}):Play()
		end

		if bgGrad and OFF and OFF.bg then
			tweengrad(bgGrad, isEnabled and ON.bg or OFF.bg, ti)
		end

		if stroke and OFF and OFF.stroke then
			ts:Create(stroke, ti, { Color = isEnabled and ON.stroke or OFF.stroke }):Play()
		end

		for _, buttondata in ipairs(state.createdButtons) do
			if buttondata.knob then
				ts:Create(buttondata.knob, ti, {
					Position = isEnabled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
				}):Play()
			end
			if buttondata.bgGrad and buttondata.OFF and buttondata.OFF.bg then
				tweengrad(buttondata.bgGrad, isEnabled and ON.bg or buttondata.OFF.bg, ti)
			end
			if buttondata.stroke and buttondata.OFF and buttondata.OFF.stroke then
				ts:Create(buttondata.stroke, ti, { Color = isEnabled and ON.stroke or buttondata.OFF.stroke }):Play()
			end
		end
	end

	state.updtoggles = updtoggles

	local function makeseperatebutton(destination)
		env.essentials.toggles[toggleId].dirty = true

		if state.currentButtonData then
			state.currentButtonData.frame:Destroy()
			state.createdButtons = {}
			state.currentButtonData = nil
			state.buttonFrame = nil
			return nil
		end

		lib.seperatebuttonzindexoff += 4
		local zplus = lib.seperatebuttonzindexoff

		local _, textHeight = lib.gettextbounds(title, Enum.Font.FredokaOne, 14, Vector2.new(100, math.huge))
		local baseWidth = 150
		local isTooHigh = textHeight > 30
		local buttonWidth = isTooHigh and (baseWidth + 40) or baseWidth

		local startPos = UDim2.new(0.5, 0, 0, -100)
		local targetPos = destination or UDim2.new(0.5, 0, 0, 60)

		local buttonFrame, drag = lib.makecoolframe(UDim2.new(0, buttonWidth, 0, 64), env.essentials.sgui, false, true, startPos, nil, nil, true, 90000 + zplus)
		ts:Create(buttonFrame, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPos}):Play()

		local toggleWidth, leftPadding = 46, 24
		local miniToggle = lib.makecoolframe(UDim2.new(0, toggleWidth, 0, 24), buttonFrame, false, false, UDim2.new(1, -35, 0.5, 0), true, true, true, 90001 + zplus)

		local textAreaWidth = (buttonWidth - toggleWidth) - (leftPadding * 2)
		local textPosX = leftPadding + (textAreaWidth / 2) - 4
		local titleText = lib.makecooltext(buttonFrame, UDim2.new(0, textAreaWidth, 0, textHeight), title, 14, nil, 2, UDim2.new(0, textPosX, 0.5, 0), Enum.TextXAlignment.Center, nil, nil, 90001 + zplus)
		titleText.TextWrapped = true

		local miniKnob = Instance.new("Frame")
		miniKnob.Size, miniKnob.AnchorPoint, miniKnob.BackgroundColor3, miniKnob.Parent, miniKnob.ZIndex = UDim2.new(0, 20, 0, 20), Vector2.new(0, 0.5), Color3.new(1, 1, 1), miniToggle, miniToggle.ZIndex + 1
		Instance.new("UICorner", miniKnob).CornerRadius = UDim.new(1, 0)

		local miniBgGrad = miniToggle:FindFirstChildOfClass("UIGradient")
		local miniStroke = miniToggle:FindFirstChildOfClass("UIStroke")
		local miniOFF = {
			bg = miniBgGrad and getgrad(miniBgGrad) or {Color3.fromRGB(50, 50, 50), Color3.fromRGB(40, 40, 40), Color3.fromRGB(30, 30, 30)},
			stroke = miniStroke and miniStroke.Color or Color3.fromRGB(200, 200, 200)
		}

		miniKnob.Position = state.enabled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)

		if miniBgGrad then
			local targetColor = state.enabled and ON.bg or miniOFF.bg
			miniBgGrad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, targetColor[1]),
				ColorSequenceKeypoint.new(0.4, targetColor[2]),
				ColorSequenceKeypoint.new(1, targetColor[3]),
			})
		end

		if miniStroke then
			miniStroke.Color = state.enabled and ON.stroke or miniOFF.stroke
		end

		local buttondata = {
			frame = buttonFrame,
			toggle = miniToggle,
			knob = miniKnob,
			bgGrad = miniBgGrad,
			stroke = miniStroke,
			OFF = miniOFF
		}

		table.insert(state.createdButtons, buttondata)
		state.currentButtonData = buttondata
		state.buttonFrame = buttonFrame

		buttonFrame.Destroying:Connect(function()
			if state.currentButtonData == buttondata then 
				state.currentButtonData = nil 
				state.buttonFrame = nil
			end
		end)

		local function onToggle()
			if drag.dragged then return end
			if frame:GetAttribute("locked") then return end
			env.essentials.toggles[toggleId].dirty = true
			state.enabled = not state.enabled
			lib.clik()
			updtoggles()
			if callback then spwn(callback, state.enabled) end
		end

		buttonFrame.Activated:Connect(onToggle)
		miniToggle.Activated:Connect(onToggle)

		local scale = Instance.new("UIScale", buttonFrame)
		local baseScale = env.stuf.buttonscale and env.stuf.buttonscale.Scale or 1
		scale.Scale = baseScale

		local hover, press = TweenInfo.new(0.12, Enum.EasingStyle.Quad), TweenInfo.new(0.08, Enum.EasingStyle.Quad)
		local currenttween
		local function playScale(v, info)
			if currenttween then currenttween:Cancel() end
			currenttween = ts:Create(scale, info, { Scale = baseScale * v })
			currenttween:Play()
		end

		env.stuf.buttonscalelistenercount += 1
		local id = env.stuf.buttonscalelistenercount

		env.stuf.buttonscalelisteners[id] = function(newScale)
			if buttonFrame.Parent == nil then
				env.stuf.buttonscalelisteners[id] = nil
				return
			end
			baseScale = newScale
			ts:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = newScale }):Play()
		end

		buttonFrame.Destroying:Connect(function()
			env.stuf.buttonscalelisteners[id] = nil
		end)

		buttonFrame.MouseEnter:Connect(function() lib.hov() playScale(1.02, hover) end)
		buttonFrame.MouseLeave:Connect(function() playScale(1, hover) end)
		buttonFrame.MouseButton1Down:Connect(function() playScale(0.98, press) end)
		buttonFrame.MouseButton1Up:Connect(function() playScale(1.02, hover) end)

		return buttondata
	end

	state.makeseperatebutton = makeseperatebutton

	if bindable then
		local waitbra, listening, opened = false, false, false

		local kb = Instance.new("ImageButton", frame)
		kb.Size, kb.Position, kb.AnchorPoint = UDim2.fromOffset(14, 14), UDim2.new(1, 4, 0, -4), Vector2.new(1, 0)
		kb.BackgroundTransparency, kb.Image, kb.ZIndex = 1, "rbxassetid://9405931578", 103

		local dropdown = lib.makecoolframe(UDim2.fromOffset(18, 18), frame, false, false, UDim2.new(1, 6, 0, -6), true, true, nil, 69)
		dropdown.AnchorPoint, dropdown.ClipsDescendants = Vector2.new(1, 0), true

		local textMask = Instance.new("Frame")
		textMask.Name = "TextMask"
		textMask.Size = UDim2.new(1, -20, 1, 0)
		textMask.Position = UDim2.new(0, 0, 0, 0)
		textMask.BackgroundTransparency = 1
		textMask.ClipsDescendants = true
		textMask.Parent = dropdown

		local bindbutton = lib.makecooltext(textMask, UDim2.new(0, 30, 1, 0), "Bind", 11, nil, 0, UDim2.new(0, 20, 0.5, 0), nil, nil, true, 101)
		local sep = lib.makecooltext(textMask, UDim2.new(0, 10, 1, 0), "<b>│</b>", 10, nil, 0, UDim2.new(0, 38, 0.5, 0), nil, nil, true, 101)
		local addbuttonbutton = lib.makecooltext(textMask, UDim2.new(0, 50, 1, 0), "New button", 11, nil, 0, UDim2.new(0, 71, 0.5, 0), nil, nil, true, 101)
		addbuttonbutton.TextWrapped = false

		local function closedd()
			if not opened or waitbra then return end
			waitbra, opened, listening = true, false, false

			local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local tween = ts:Create(dropdown, ti, {Size = UDim2.new(0, 18, 0, 18)})

			tween:Play()

			bindbutton.Text = "Bind"
			waitbra = false
		end

		bindbutton.Activated:Connect(function()
			t()
			if waitbra or listening then return end
			lib.clik() listening, bindbutton.Text = true, "..."
		end)

		addbuttonbutton.Activated:Connect(function()
			t()
			if waitbra or listening then return end
			lib.clik() makeseperatebutton() closedd()
		end)

		kb.Activated:Connect(function()
			if frame:GetAttribute("locked") or waitbra then return end
			lib.clik()

			if opened then
				closedd()
			else
				waitbra = true
				opened = true

				local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				local st = ts:Create(dropdown, ti, {Size = UDim2.new(0, 120, 0, 18)})
				st:Play()

				waitbra = false
			end
		end)

		uis.InputBegan:Connect(function(input, processed)
			if listening then
				if input.UserInputType == Enum.UserInputType.MouseButton2 then
					state.currentBind = nil
					listening = false
					bindbutton.Text = "Bind"

					elementtitle.Text = title 

					updateFrameSize()
					closedd()

					if table.find(env.filemanager.persist, title) then 
						env.filemanager.persistsave() 
					end
					return
				end

				if input.UserInputType == Enum.UserInputType.Keyboard then
					local key = input.KeyCode
					if key == state.currentBind then
						listening = false
						bindbutton.Text = "Bind"
						closedd()
						return
					end

					state.currentBind = key
					listening = false
					bindbutton.Text = "Bind"
					elementtitle.RichText = true
					local mappedName = lib.mapkey(key)
					elementtitle.Text = title .. " <font color='rgb(71, 190, 255)'>[" .. mappedName .. "]</font>"

					updateFrameSize()
					closedd()

					if table.find(env.filemanager.persist, title) then 
						env.filemanager.persistsave() 
					end
					return
				end
			end

			if not processed and state.currentBind ~= nil and input.KeyCode == state.currentBind then
				if frame:GetAttribute("locked") then return end
				env.essentials.toggles[toggleId].dirty = true
				lib.clik()
				state.enabled = not state.enabled
				updtoggles()
				if callback then spwn(callback, state.enabled) end
				return
			end

			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and opened then
				local AbsPos, AbsSize = dropdown.AbsolutePosition, dropdown.AbsoluteSize

				if env.stuf.mouse.X < AbsPos.X or env.stuf.mouse.X > AbsPos.X + AbsSize.X
					or env.stuf.mouse.Y < (AbsPos.Y - 20 - 1) or env.stuf.mouse.Y > AbsPos.Y + AbsSize.Y then

					if not listening then closedd() end
				end
			end
		end)
	end

	toggle = lib.makecoolframe(UDim2.new(0, 38, 0, 20), frame, false, false, UDim2.new(1, -38, 0.5, 0), true, true, nil, 61)
	knob = Instance.new("Frame", toggle)
	knob.Size, knob.Position, knob.ZIndex, knob.AnchorPoint, knob.BackgroundColor3 = UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0.5, 0), toggle.ZIndex + 1, Vector2.new(0, 0.5), Color3.new(1,1,1)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
	bgGrad = toggle:FindFirstChildOfClass("UIGradient")
	stroke = toggle:FindFirstChildOfClass("UIStroke")

	OFF = {
		bg = bgGrad and getgrad(bgGrad) or {
			Color3.fromRGB(50, 50, 50),
			Color3.fromRGB(40, 40, 40),
			Color3.fromRGB(30, 30, 30),
		},
		stroke = stroke and stroke.Color or Color3.fromRGB(200, 200, 200),
	}

	state.frame, state.toggle, state.knob, state.bgGrad, state.stroke, state.OFF = frame, toggle, knob, bgGrad, stroke, OFF

	if default then
		state.enabled = true
		updtoggles()
		if callback then 
			spwn(callback, true) 
		end
	end

	frame.MouseEnter:Connect(function() lib.hov() end)
	frame.Activated:Connect(function()
		if frame:GetAttribute("locked") then return end
		env.essentials.toggles[toggleId].dirty = true
		lib.clik()
		state.enabled = not state.enabled
		updtoggles()
		if callback then spwn(callback, state.enabled) end

		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end)

	if locked then
		lib.lock(title, true, lockreason)
	end

	return frame
end

function lib.addbutton(parent, title, description, callback, bindable, locked, lockreason)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 68, -7
	local textwidth = width - rightpadding - 20
	local buttonId = title
	bindable = true

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false, nil, nil, nil, true, 60)
	frame.LayoutOrder = #parent:GetChildren()

	env.essentials.buttons[buttonId] = {
		frame = frame,
		dirty = false,
		currentBind = nil,
		title = title,
		callback = callback,
		createdButtons = {},
		currentButtonData = nil,
		elementtitle = nil,
		updateSize = nil
	}
	local state = env.essentials.buttons[buttonId]

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))
	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 1)

	local elementtitle = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	elementtitle.ZIndex = 61

	local elementdesc = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + tetxgap + dh / 2 + 5), Enum.TextXAlignment.Left)
	elementdesc.ZIndex = 61

	local function updateFrameSize()
		local function stripRichText(str)
			return str:gsub("<[^>]-" .. ">", "")
		end

		local cleanTitleText = stripRichText(elementtitle.Text)

		local _, newTh = lib.gettextbounds(cleanTitleText, elementtitle.Font, elementtitle.TextSize, Vector2.new(textwidth, math.huge))
		local _, currDh = lib.gettextbounds(description, elementdesc.Font, elementdesc.TextSize, Vector2.new(textwidth, math.huge))

		local newDescY = leftpadding + newTh + tetxgap
		local newTotalHeight = newTh + currDh + leftpadding * 2 + tetxgap + 1

		elementtitle.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + newTh / 2 - 5)
		elementdesc.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, newDescY + currDh / 2 + 5)

		frame.Size = UDim2.new(0, width, 0, newTotalHeight)
	end

	state.elementtitle = elementtitle
	state.updateSize = updateFrameSize

	local function makeseperatebutton(destination)
		env.essentials.buttons[buttonId].dirty = true

		if state.currentButtonData then
			state.currentButtonData.frame:Destroy()
			state.createdButtons = {}
			state.buttonFrame = nil
			state.currentButtonData = nil
			return nil
		end

		lib.seperatebuttonzindexoff += 1
		local zplus = lib.seperatebuttonzindexoff

		local _, textHeight = lib.gettextbounds(title, Enum.Font.FredokaOne, 14, Vector2.new(100, math.huge))
		local baseWidth = 108
		local isTooHigh = textHeight > 30
		local buttonWidth = isTooHigh and (baseWidth + 40) or baseWidth

		local startPos = UDim2.new(0.5, 0, 0, -100)
		local targetPos = destination or UDim2.new(0.5, 0, 0, 60)

		local buttonFrame, drag = lib.makecoolframe(UDim2.new(0, buttonWidth, 0, 64), env.essentials.sgui, false, true, startPos, nil, nil, true, 90000 + zplus)
		ts:Create(buttonFrame, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPos}):Play()

		local textAreaWidth = buttonWidth - 48
		local titleText = lib.makecooltext(buttonFrame, UDim2.new(0, textAreaWidth, 0, textHeight), title, 14, nil, 2, UDim2.new(0.5, 0, 0.5, 0), Enum.TextXAlignment.Center, nil, nil, 90001 + zplus)
		titleText.TextWrapped = true

		local buttondata = { frame = buttonFrame }
		table.insert(state.createdButtons, buttondata)
		state.currentButtonData = buttondata
		state.buttonFrame = buttonFrame

		buttonFrame.Destroying:Connect(function()
			if state.currentButtonData == buttondata then state.currentButtonData = nil end
			state.buttonFrame = nil
		end)

		buttonFrame.Activated:Connect(function()
			if buttonFrame:GetAttribute("locked") then return end
			if drag.dragged then return end
			lib.clik()
			if callback then spwn(callback) end
		end)

		local scale = Instance.new("UIScale", buttonFrame)
		local baseScale = env.stuf.buttonscale and env.stuf.buttonscale.Scale or 1
		scale.Scale = baseScale

		local hover, press = TweenInfo.new(0.12, Enum.EasingStyle.Quad), TweenInfo.new(0.08, Enum.EasingStyle.Quad)
		local currenttween
		local function playScale(v, info)
			if currenttween then currenttween:Cancel() end
			currenttween = ts:Create(scale, info, { Scale = baseScale * v })
			currenttween:Play()
		end

		env.stuf.buttonscalelistenercount += 1
		local id = env.stuf.buttonscalelistenercount

		env.stuf.buttonscalelisteners[id] = function(newScale)
			if buttonFrame.Parent == nil then
				env.stuf.buttonscalelisteners[id] = nil
				return
			end
			baseScale = newScale
			ts:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = newScale }):Play()
		end

		buttonFrame.Destroying:Connect(function()
			env.stuf.buttonscalelisteners[id] = nil
		end)

		buttonFrame.MouseEnter:Connect(function() lib.hov() playScale(1.02, hover) end)
		buttonFrame.MouseLeave:Connect(function() playScale(1, hover) end)
		buttonFrame.MouseButton1Down:Connect(function() playScale(0.98, press) end)
		buttonFrame.MouseButton1Up:Connect(function() playScale(1.02, hover) end)

		return buttondata
	end

	state.makeseperatebutton = makeseperatebutton

	if bindable then
		local waitbra, listening, opened = false, false, false

		local kb = Instance.new("ImageButton", frame)
		kb.Size, kb.Position, kb.AnchorPoint = UDim2.fromOffset(14, 14), UDim2.new(1, 4, 0, -4), Vector2.new(1, 0)
		kb.BackgroundTransparency, kb.Image, kb.ZIndex = 1, "rbxassetid://9405931578", 103

		local dropdown = lib.makecoolframe(UDim2.fromOffset(18, 18), frame, false, false, UDim2.new(1, 6, 0, -6), true, true, nil, 69)
		dropdown.AnchorPoint, dropdown.ClipsDescendants = Vector2.new(1, 0), true

		local textMask = Instance.new("Frame")
		textMask.Name = "TextMask"
		textMask.Size = UDim2.new(1, -20, 1, 0)
		textMask.Position = UDim2.new(0, 0, 0, 0)
		textMask.BackgroundTransparency = 1
		textMask.ClipsDescendants = true
		textMask.Parent = dropdown

		local bindbutton = lib.makecooltext(textMask, UDim2.new(0, 30, 1, 0), "Bind", 11, nil, 0, UDim2.new(0, 20, 0.5, 0), nil, nil, true, 101)
		local sep = lib.makecooltext(textMask, UDim2.new(0, 10, 1, 0), "<b>│</b>", 10, nil, 0, UDim2.new(0, 38, 0.5, 0), nil, nil, true, 101)
		local addbuttonbutton = lib.makecooltext(textMask, UDim2.new(0, 50, 1, 0), "New button", 11, nil, 0, UDim2.new(0, 71, 0.5, 0), nil, nil, true, 101)
		addbuttonbutton.TextWrapped = false

		local function closedd()
			if not opened or waitbra then return end
			waitbra, opened, listening = true, false, false

			local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local tween = ts:Create(dropdown, ti, {Size = UDim2.new(0, 18, 0, 18)})

			tween:Play()

			bindbutton.Text = "Bind"
			waitbra = false
		end

		bindbutton.Activated:Connect(function()
			t()
			if waitbra or listening then return end
			lib.clik() listening, bindbutton.Text = true, "..."
		end)

		addbuttonbutton.Activated:Connect(function()
			t()
			if waitbra or listening then return end
			lib.clik() makeseperatebutton() closedd()
		end)

		kb.Activated:Connect(function()
			if frame:GetAttribute("locked") or waitbra then return end
			lib.clik()

			if opened then
				closedd()
			else
				waitbra = true
				opened = true

				local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
				local st = ts:Create(dropdown, ti, {Size = UDim2.new(0, 120, 0, 18)})
				st:Play()

				waitbra = false
			end
		end)

		uis.InputBegan:Connect(function(input, processed)
			if listening then
				if input.UserInputType == Enum.UserInputType.MouseButton2 then
					state.currentBind = nil
					listening = false
					bindbutton.Text = "Bind"

					elementtitle.Text = title 

					updateFrameSize()
					closedd()

					if table.find(env.filemanager.persist, title) then 
						env.filemanager.persistsave() 
					end
					return
				end

				if input.UserInputType == Enum.UserInputType.Keyboard then
					local key = input.KeyCode
					if key == state.currentBind then
						listening = false
						bindbutton.Text = "Bind"
						closedd()
						return
					end

					state.currentBind = key
					listening = false
					bindbutton.Text = "Bind"
					elementtitle.RichText = true
					local mappedName = lib.mapkey(key)
					elementtitle.Text = title .. " <font color='rgb(71, 190, 255)'>[" .. mappedName .. "]</font>"

					updateFrameSize()
					closedd()

					if table.find(env.filemanager.persist, title) then 
						env.filemanager.persistsave() 
					end
					return
				end
			end

			if not processed and state.currentBind ~= nil and input.KeyCode == state.currentBind then
				if frame:GetAttribute("locked") then return end
				lib.clik()
				if callback then spwn(callback) end
				return
			end

			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and opened then
				local AbsPos, AbsSize = dropdown.AbsolutePosition, dropdown.AbsoluteSize

				if env.stuf.mouse.X < AbsPos.X or env.stuf.mouse.X > AbsPos.X + AbsSize.X
					or env.stuf.mouse.Y < (AbsPos.Y - 20 - 1) or env.stuf.mouse.Y > AbsPos.Y + AbsSize.Y then

					if not listening then closedd() end
				end
			end
		end)
	end

	local function ripple(input)
		local abspos, abssiz = frame.AbsolutePosition, frame.AbsoluteSize
		local rippleHolder = Instance.new("Frame")
		rippleHolder.Size, rippleHolder.BackgroundTransparency, rippleHolder.ClipsDescendants, rippleHolder.ZIndex, rippleHolder.Parent = UDim2.fromScale(1, 1), 1, true, 62, frame
		Instance.new("UICorner", rippleHolder).CornerRadius = UDim.new(0, 16)

		local inputtedpos = (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) 
			and Vector2.new(input.Position.X - abspos.X, input.Position.Y - abspos.Y) 
			or Vector2.new(abssiz.X / 2, abssiz.Y / 2)

		local rippleObj = Instance.new("Frame")
		rippleObj.Size, rippleObj.Position, rippleObj.AnchorPoint, rippleObj.BackgroundColor3, rippleObj.BackgroundTransparency, rippleObj.ZIndex, rippleObj.Parent = UDim2.fromOffset(0, 0), UDim2.fromOffset(inputtedpos.X, inputtedpos.Y), Vector2.new(0.5, 0.5), Color3.new(1, 1, 1), 0.7, 63, rippleHolder
		Instance.new("UICorner", rippleObj).CornerRadius = UDim.new(1, 0)

		local maxSize = math.max(abssiz.X, abssiz.Y) * 1.5
		local t = ts:Create(rippleObj, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(maxSize, maxSize), BackgroundTransparency = 1})
		t:Play()
		t.Completed:Connect(function() rippleHolder:Destroy() end)
	end

	local btnIcon = Instance.new("ImageLabel")
	btnIcon.Size, btnIcon.AnchorPoint, btnIcon.Position, btnIcon.BackgroundTransparency, btnIcon.Image, btnIcon.ZIndex, btnIcon.Parent = UDim2.fromOffset(16, 16), Vector2.new(0.5, 0.5), UDim2.new(1, -25, 0.5, 0), 1, "rbxassetid://13306021272", 61, frame

	frame.Activated:Connect(function(input)
		if frame:GetAttribute("locked") then return end
		lib.clik()
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then spwn(function() ripple(input) end) end
		if callback then spwn(callback) end
	end)

	env.essentials.elements[buttonId] = {
		type = "button",
		instance = frame,
		callback = callback,
		setValue = function()
			if frame:GetAttribute("locked") then return end
			if callback then spwn(callback) end
		end
	}

	if locked then
		lib.lock(title, true, lockreason)
	end

	return frame
end

function lib.adddropdown(parent, title, description, options, callback, isPlayerList, multiSelect, default, canBeEmpty)
	if canBeEmpty == nil then canBeEmpty = true end

	local width, leftpadding, rightpadding, textgap = 235, 14, 14, -6
	local textwidth = width - rightpadding - 20
	local opened = false

	local selectedOptions = {}
	if default then
		selectedOptions = typeof(default) == "table" and default or {default}
	end

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	Instance.new("UIPadding", frame).PaddingBottom = UDim.new(0, 13)

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))

	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + textgap + 43)

	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + textgap + dh / 2 + 5), Enum.TextXAlignment.Left)

	local staticYOffset = th + dh + (leftpadding * 2) + textgap + 5
	local selector, selectortext = lib.makecoolbutton("Select...", UDim2.new(0, 208, 0, 28), frame, UDim2.new(0.5, 0, 0, staticYOffset + 10), "info", 14, nil, 63, true)
	local arrow = lib.makecooltext(selector, UDim2.new(0, 20, 1, 0), "▼", 14, nil, 2, UDim2.new(1, -15, 0.5, 0), nil, nil, nil, 64)

	local listFrame = lib.makecoolframe(UDim2.new(0, 210, 0, 28), frame, false, false, UDim2.new(0.5, 0, 0, staticYOffset), false, true, nil, 60)
	listFrame.Visible = false
	listFrame.AnchorPoint = Vector2.new(0.5, 0)
	listFrame.ClipsDescendants = true

	local scrolling = Instance.new("ScrollingFrame")
	scrolling.Size = UDim2.new(1, 0, 1, -33)
	scrolling.Position = UDim2.new(0, 4, 0, 29)
	scrolling.BackgroundTransparency = 1
	scrolling.ScrollBarThickness = 0
	scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
	scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scrolling.ZIndex = 61
	scrolling.Parent = listFrame

	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 2)
	layout.Parent = scrolling

	local function updateSelectionText()
		if #selectedOptions == 0 then
			selectortext.Text = "Select..."
		elseif multiSelect then
			selectortext.Text = #selectedOptions .. " selected"
		else
			selectortext.Text = tostring(selectedOptions[1])
		end
	end

	updateSelectionText()

	local function refreshOptions()
		for _, v in ipairs(scrolling:GetChildren()) do
			if v:IsA("Frame") then v:Destroy() end
		end

		local listToUse = isPlayerList and (function()
			local p = {}
			for _, player in ipairs(plrs:GetPlayers()) do table.insert(p, player.Name) end
			return p
		end)() or options

		for _, optionName in ipairs(listToUse) do
			local isSelected = table.find(selectedOptions, optionName)

			local container = Instance.new("Frame")
			container.Size = UDim2.new(1, -8, 0, 36)
			container.BackgroundTransparency = 1
			container.BorderSizePixel = 0
			container.Parent = scrolling

			local themeType = isSelected and "yes" or "neutral"
			local optBtn = lib.makecoolbutton(optionName, UDim2.new(1, -8, 1, -8), container, UDim2.new(0.5, 0, 0.5, 0), themeType, 14, nil, 62)

			optBtn.Activated:Connect(function()
				env.essentials.elements[title].dirty = true
				local idx = table.find(selectedOptions, optionName)

				if multiSelect then
					if idx then
						if not canBeEmpty and #selectedOptions <= 1 then return end
						table.remove(selectedOptions, idx) 
					else 
						table.insert(selectedOptions, optionName) 
					end
					refreshOptions()
				else
					if idx then
						if not canBeEmpty then return end
						selectedOptions = {}
						refreshOptions()
					else
						selectedOptions = {optionName}
						opened = false
						local tw = ts:Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 208, 0, 28)})
						tw:Play()
						ts:Create(arrow, TweenInfo.new(0.2), {Rotation = 0, Position = UDim2.new(1, -15, 0.5, 0)}):Play()
						tw.Completed:Connect(function() if not opened then listFrame.Visible = false end end)
					end
				end

				updateSelectionText()
				if callback then callback(multiSelect and selectedOptions or selectedOptions[1]) end
			end)
		end
	end

	updateSelectionText()

	selector.Activated:Connect(function()
		opened = not opened

		if opened then
			listFrame.Visible = true
			refreshOptions()

			local listToUse = isPlayerList and #plrs:GetPlayers() or #options
			local targetHeight = math.clamp((listToUse * 38) + 32, 40, 120) 

			ts:Create(arrow, TweenInfo.new(0.2), {Rotation = 180, Position = UDim2.new(1, -15, 0.5, 1)}):Play()
			ts:Create(listFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 208, 0, targetHeight)}):Play()
		else
			ts:Create(arrow, TweenInfo.new(0.2), {Rotation = 0, Position = UDim2.new(1, -15, 0.5, 0)}):Play()
			local tw = ts:Create(listFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, 208, 0, 28)})
			tw:Play()
			tw.Completed:Connect(function() if not opened then listFrame.Visible = false end end)
		end
	end)

	if isPlayerList then
		plrs.PlayerAdded:Connect(function() if opened then refreshOptions() end end)
		plrs.PlayerRemoving:Connect(function() if opened then refreshOptions() end end)
	end

	env.essentials.elements[title] = {
		frame = frame,
		type = "dropdown",
		dirty = false,
		getValue = function()
			return multiSelect and selectedOptions or (selectedOptions[1] or "")
		end,
		setValue = function(val)
			local newState = {}
			if val ~= nil and val ~= "" then
				newState = typeof(val) == "table" and val or {val}
			end

			local shouldTrigger = true
			if #newState == 0 and not canBeEmpty then
				shouldTrigger = false
			end

			selectedOptions = newState
			updateSelectionText()
			refreshOptions()

			if callback and shouldTrigger then 
				local passVal = multiSelect and selectedOptions or (selectedOptions[1] or "")
				spwn(callback, passVal)
			end
		end
	}

	return frame
end

function lib.addinput(parent, title, description, defaulttext, placeholdertext, callback, autofill)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 14, -6
	local textwidth = width - rightpadding - 20

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 9, Vector2.new(textwidth, math.huge))
	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 43)

	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 9, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + tetxgap + dh / 2 + 5), Enum.TextXAlignment.Left)

	local inputbox = lib.makecooltextbox(UDim2.new(0, 208, 0, 28), frame, defaulttext, 16, placeholdertext, nil, UDim2.new(0.5, 0, 1, -29), nil, 61)

	if autofill then
		local lastSuggestion = nil

		inputbox:GetPropertyChangedSignal("Text"):Connect(function()
			if not inputbox:IsFocused() or inputbox.Text == "" then 
				lastSuggestion = nil
				return 
			end

			local currentText = inputbox.Text
			if not currentText:find(",") then
				local resolved = env.funcs.resolvetargets(currentText)

				if #resolved == 1 and resolved[1] ~= env.stuf.plr then
					local targetPlayer = resolved[1]
					if targetPlayer.Name:lower():sub(1, #currentText) == currentText:lower() then
						lastSuggestion = targetPlayer.Name
						return
					end
				end
			end
			lastSuggestion = nil
		end)

		inputbox.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Tab and lastSuggestion then
				inputbox.Text = lastSuggestion
				inputbox.CursorPosition = #lastSuggestion + 1
				lastSuggestion = nil
				input:CaptureFocus() 
			end
		end)
	end

	inputbox.Focused:Connect(function() lib.clik() end)
	inputbox.MouseEnter:Connect(function() lib.hov() end)

	env.essentials.elements[title] = {
		frame = frame,
		type = "input",
		dirty = false,
		instance = inputbox,
		callback = callback,
		setValue = function(val) inputbox.Text = tostring(val) end
	}

	inputbox.FocusLost:Connect(function()
		env.essentials.elements[title].dirty = true
		env.essentials.elements[title].value = inputbox.Text
		if callback then callback(inputbox.Text) end
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end)

	return frame
end

function lib.addinputandtoggle(parent, title, description, defaulttext, placeholdertext, callback, default, locked, lockreason, autofill)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 14, -5
	local textwidth = width - rightpadding - 20

	local ON = {
		bg = {
			Color3.fromRGB(183, 202, 96),
			Color3.fromRGB(95, 200, 93),
			Color3.fromRGB(95, 200, 93),
		},
		stroke = Color3.fromRGB(244, 255, 199),
	}

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false, nil, nil, nil, true, 60)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	if locked then
		lib.lock(title, true, lockreason)
	end

	local toggleId = title
	local inputId = title .. "/input"

	env.essentials.toggles[toggleId] = {
		type = "inputtoggle",
		frame = frame,
		dirty = false,
		enabled = default or false,
		currentBind = nil,
		title = title,
		callback = callback,
		elementtitle = nil,
		createdButtons = {},
		currentButtonData = nil,
		buttonFrame = nil,
		updateSize = nil
	}

	local state = env.essentials.toggles[toggleId]

	local toggle, knob, bgGrad, stroke = nil, nil, nil, nil
	local OFF = nil

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))

	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 45)

	local elementtitle = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	elementtitle.ZIndex = 61

	local elementdesc = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding, 0, leftpadding + th + tetxgap + 5), Enum.TextXAlignment.Left)
	elementdesc.ZIndex = 61

	local inputbox = lib.makecooltextbox(UDim2.new(0, 142, 0, 28), frame, defaulttext, 16, placeholdertext, nil, UDim2.new(0, 0, 1, -30), nil, 61)

	if autofill then
		local lastSuggestion = nil

		inputbox:GetPropertyChangedSignal("Text"):Connect(function()
			if not inputbox:IsFocused() or inputbox.Text == "" then
				lastSuggestion = nil
				return
			end

			local currentText = inputbox.Text
			if not currentText:find(",") then
				local resolved = env.funcs.resolvetargets(currentText)
				if #resolved == 1 and resolved[1] ~= env.stuf.plr then
					local targetPlayer = resolved[1]
					if targetPlayer.Name:lower():sub(1, #currentText) == currentText:lower() then
						lastSuggestion = targetPlayer.Name
						return
					end
				end
			end
			lastSuggestion = nil
		end)

		inputbox.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Tab and lastSuggestion then
				inputbox.Text = lastSuggestion
				inputbox.CursorPosition = #lastSuggestion + 1
				lastSuggestion = nil
				input:CaptureFocus()
			end
		end)
	end

	toggle = lib.makecoolframe(UDim2.new(0, 38, 0, 20), frame, false, false, UDim2.new(1, -38, 1, 0), true, true, nil, 61)
	knob = Instance.new("Frame", toggle)
	knob.Size, knob.Position, knob.ZIndex, knob.AnchorPoint, knob.BackgroundColor3 = UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0.5, 0), toggle.ZIndex + 1, Vector2.new(0, 0.5), Color3.new(1,1,1)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
	bgGrad = toggle:FindFirstChildOfClass("UIGradient")
	stroke = toggle:FindFirstChildOfClass("UIStroke")

	local function getgrad(gradient)
		if not gradient then return nil end
		local keys = gradient.Color.Keypoints
		local c1 = keys[1] and keys[1].Value
		local c2 = keys[2] and keys[2].Value or c1
		local c3 = keys[3] and keys[3].Value or c2
		return { c1, c2, c3 }
	end

	OFF = {
		bg = bgGrad and getgrad(bgGrad) or {
			Color3.fromRGB(50, 50, 50),
			Color3.fromRGB(40, 40, 40),
			Color3.fromRGB(30, 30, 30),
		},
		stroke = stroke and stroke.Color or Color3.fromRGB(200, 200, 200),
	}

	state.frame, state.toggle, state.knob, state.bgGrad, state.stroke, state.OFF = frame, toggle, knob, bgGrad, stroke, OFF
	state.inputbox = inputbox

	env.essentials.elements[inputId] = {
		type = "input",
		frame = frame,
		dirty = false,
		instance = inputbox,
		callback = function(val)
			if callback then callback(val, state.enabled) end
		end,
		setValue = function(val)
			inputbox.Text = tostring(val)
			if callback and state.enabled then
				callback(inputbox.Text, state.enabled)
			end
		end
	}

	function state.setValue(val)
		if typeof(val) == "table" then
			if val.text ~= nil then inputbox.Text = tostring(val.text) end
			if val.enabled ~= nil then state.enabled = val.enabled end
		else
			state.enabled = val
		end
		state.updtoggles()
		if callback then callback(inputbox.Text, state.enabled) end
	end

	local function updateFrameSize()
		local function stripRichText(str)
			return str:gsub("<[^>]->", "")
		end

		local actualWidth = frame.AbsoluteSize.X
		local scaledTextWidth = actualWidth - rightpadding - 20

		local cleanTitleText = stripRichText(elementtitle.Text)

		local _, newTh = lib.gettextbounds(cleanTitleText, elementtitle.Font, elementtitle.TextSize, Vector2.new(scaledTextWidth, math.huge))
		local _, currDh = lib.gettextbounds(description, elementdesc.Font, elementdesc.TextSize, Vector2.new(scaledTextWidth, math.huge))

		local newDescY = leftpadding + newTh + tetxgap
		local newTotalHeight = newTh + currDh + leftpadding * 2 + tetxgap + 45

		elementtitle.Size = UDim2.new(0, scaledTextWidth, 0, newTh)
		elementtitle.Position = UDim2.new(0, leftpadding + scaledTextWidth / 2, 0, leftpadding + newTh / 2 - 5)

		elementdesc.Size = UDim2.new(0, scaledTextWidth, 0, currDh)
		elementdesc.Position = UDim2.new(0, leftpadding + scaledTextWidth / 2, 0, newDescY + currDh / 2 + 5)

		if toggle then toggle.Position = UDim2.new(1, -38, 1, -30) end
		if inputbox then inputbox.Position = UDim2.new(0, leftpadding + 73, 1, -30) end

		frame.Size = UDim2.new(0, width, 0, newTotalHeight)
	end

	frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateFrameSize)

	state.elementtitle = elementtitle
	state.updateSize = updateFrameSize

	local activeGradTweens = {}

	local function getCurrentGrad(gradient)
		local keys = gradient.Color.Keypoints
		return {
			keys[1].Value,
			keys[2] and keys[2].Value or keys[1].Value,
			keys[3] and keys[3].Value or keys[2].Value,
		}
	end

	local gradCurrentColors = {}

	local function tweengrad(gradient, targetColors, tweenInfo)
		if not gradient or not tweenInfo then return end

		if activeGradTweens[gradient] then
			activeGradTweens[gradient].tween:Cancel()
			activeGradTweens[gradient].conn:Disconnect()
			activeGradTweens[gradient].completedConn:Disconnect()
			activeGradTweens[gradient] = nil
		end

		local from = gradCurrentColors[gradient] or getCurrentGrad(gradient)
		local current = {from[1], from[2], from[3]}

		local t = Instance.new("NumberValue")
		t.Value = 0

		local conn = t.Changed:Connect(function(a)
			local c1 = current[1]:Lerp(targetColors[1], a)
			local c2 = current[2]:Lerp(targetColors[2], a)
			local c3 = current[3]:Lerp(targetColors[3], a)
			gradCurrentColors[gradient] = {c1, c2, c3}
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, c1),
				ColorSequenceKeypoint.new(0.4, c2),
				ColorSequenceKeypoint.new(1, c3),
			})
		end)

		local tween = ts:Create(t, tweenInfo, { Value = 1 })
		local entry = { tween = tween, conn = conn, completedConn = nil }
		activeGradTweens[gradient] = entry

		entry.completedConn = tween.Completed:Connect(function()
			if activeGradTweens[gradient] == entry then
				activeGradTweens[gradient] = nil
				gradCurrentColors[gradient] = targetColors
			end
			conn:Disconnect()
			t:Destroy()
		end)

		tween:Play()
	end

	local function updtoggles()
		local ti = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local isEnabled = env.essentials.toggles[toggleId].enabled

		if knob then
			ts:Create(knob, ti, {
				Position = isEnabled and UDim2.new(1, -19, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
			}):Play()
		end

		if bgGrad and OFF and OFF.bg then
			tweengrad(bgGrad, isEnabled and ON.bg or OFF.bg, ti)
		end

		if stroke and OFF and OFF.stroke then
			ts:Create(stroke, ti, { Color = isEnabled and ON.stroke or OFF.stroke }):Play()
		end

		for _, buttondata in ipairs(state.createdButtons) do
			if buttondata.knob then
				ts:Create(buttondata.knob, ti, {
					Position = isEnabled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
				}):Play()
			end
			if buttondata.bgGrad and buttondata.OFF and buttondata.OFF.bg then
				tweengrad(buttondata.bgGrad, isEnabled and ON.bg or buttondata.OFF.bg, ti)
			end
			if buttondata.stroke and buttondata.OFF and buttondata.OFF.stroke then
				ts:Create(buttondata.stroke, ti, { Color = isEnabled and ON.stroke or buttondata.OFF.stroke }):Play()
			end
		end
	end

	state.updtoggles = updtoggles

	local function makeseperatebutton(destination)
		env.essentials.toggles[toggleId].dirty = true

		if state.currentButtonData then
			state.currentButtonData.frame:Destroy()
			state.createdButtons = {}
			state.currentButtonData = nil
			state.buttonFrame = nil
			return nil
		end

		lib.seperatebuttonzindexoff += 4
		local zplus = lib.seperatebuttonzindexoff

		local _, textHeight = lib.gettextbounds(title, Enum.Font.FredokaOne, 14, Vector2.new(100, math.huge))
		local baseWidth = 150
		local isTooHigh = textHeight > 30
		local buttonWidth = isTooHigh and (baseWidth + 40) or baseWidth

		local startPos = UDim2.new(0.5, 0, 0, -100)
		local targetPos = destination or UDim2.new(0.5, 0, 0, 100)

		local buttonFrame, drag = lib.makecoolframe(UDim2.new(0, buttonWidth, 0, 64), env.essentials.sgui, false, true, startPos, nil, nil, true, 90000 + zplus)
		ts:Create(buttonFrame, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPos}):Play()

		local toggleWidth, leftPadding = 46, 24
		local miniToggle = lib.makecoolframe(UDim2.new(0, toggleWidth, 0, 24), buttonFrame, false, false, UDim2.new(1, -35, 0.5, 0), true, true, true, 90001 + zplus)

		local textAreaWidth = (buttonWidth - toggleWidth) - (leftPadding * 2)
		local textPosX = leftPadding + (textAreaWidth / 2) - 4
		local titleText = lib.makecooltext(buttonFrame, UDim2.new(0, textAreaWidth, 0, textHeight), title, 14, nil, 2, UDim2.new(0, textPosX, 0.5, 0), Enum.TextXAlignment.Center, nil, nil, 90001 + zplus)
		titleText.TextWrapped = true

		local miniKnob = Instance.new("Frame")
		miniKnob.Size, miniKnob.AnchorPoint, miniKnob.BackgroundColor3, miniKnob.Parent, miniKnob.ZIndex = UDim2.new(0, 20, 0, 20), Vector2.new(0, 0.5), Color3.new(1, 1, 1), miniToggle, miniToggle.ZIndex + 1
		Instance.new("UICorner", miniKnob).CornerRadius = UDim.new(1, 0)

		local miniBgGrad = miniToggle:FindFirstChildOfClass("UIGradient")
		local miniStroke = miniToggle:FindFirstChildOfClass("UIStroke")
		local miniOFF = {
			bg = miniBgGrad and getgrad(miniBgGrad) or {Color3.fromRGB(50, 50, 50), Color3.fromRGB(40, 40, 40), Color3.fromRGB(30, 30, 30)},
			stroke = miniStroke and miniStroke.Color or Color3.fromRGB(200, 200, 200)
		}

		miniKnob.Position = state.enabled and UDim2.new(1, -23, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)

		if miniBgGrad then
			local targetColor = state.enabled and ON.bg or miniOFF.bg
			miniBgGrad.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, targetColor[1]),
				ColorSequenceKeypoint.new(0.4, targetColor[2]),
				ColorSequenceKeypoint.new(1, targetColor[3]),
			})
		end

		if miniStroke then
			miniStroke.Color = state.enabled and ON.stroke or miniOFF.stroke
		end

		local buttondata = {
			frame = buttonFrame,
			toggle = miniToggle,
			knob = miniKnob,
			bgGrad = miniBgGrad,
			stroke = miniStroke,
			OFF = miniOFF
		}

		table.insert(state.createdButtons, buttondata)
		state.currentButtonData = buttondata
		state.buttonFrame = buttonFrame

		buttonFrame.Destroying:Connect(function()
			if state.currentButtonData == buttondata then
				state.currentButtonData = nil
				state.buttonFrame = nil
			end
		end)

		local function onToggle()
			if drag.dragged then return end
			if frame:GetAttribute("locked") then return end
			env.essentials.toggles[toggleId].dirty = true
			state.enabled = not state.enabled
			lib.clik()
			updtoggles()
			if callback then spwn(callback, inputbox.Text, state.enabled) end
		end

		buttonFrame.Activated:Connect(onToggle)
		miniToggle.Activated:Connect(onToggle)

		local scale = Instance.new("UIScale", buttonFrame)
		local baseScale = env.stuf.buttonscale and env.stuf.buttonscale.Scale or 1
		scale.Scale = baseScale

		local hover, press = TweenInfo.new(0.12, Enum.EasingStyle.Quad), TweenInfo.new(0.08, Enum.EasingStyle.Quad)
		local currenttween
		local function playScale(v, info)
			if currenttween then currenttween:Cancel() end
			currenttween = ts:Create(scale, info, { Scale = baseScale * v })
			currenttween:Play()
		end

		env.stuf.buttonscalelistenercount += 1
		local id = env.stuf.buttonscalelistenercount

		env.stuf.buttonscalelisteners[id] = function(newScale)
			if buttonFrame.Parent == nil then
				env.stuf.buttonscalelisteners[id] = nil
				return
			end
			baseScale = newScale
			ts:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = newScale }):Play()
		end

		buttonFrame.Destroying:Connect(function()
			env.stuf.buttonscalelisteners[id] = nil
		end)

		buttonFrame.MouseEnter:Connect(function() lib.hov() playScale(1.02, hover) end)
		buttonFrame.MouseLeave:Connect(function() playScale(1, hover) end)
		buttonFrame.MouseButton1Down:Connect(function() playScale(0.98, press) end)
		buttonFrame.MouseButton1Up:Connect(function() playScale(1.02, hover) end)

		return buttondata
	end

	state.makeseperatebutton = makeseperatebutton

	local waitbra, listening, opened = false, false, false

	local kb = Instance.new("ImageButton", frame)
	kb.Size, kb.Position, kb.AnchorPoint = UDim2.fromOffset(14, 14), UDim2.new(1, 4, 0, -4), Vector2.new(1, 0)
	kb.BackgroundTransparency, kb.Image, kb.ZIndex = 1, "rbxassetid://9405931578", 103

	local dropdown = lib.makecoolframe(UDim2.fromOffset(18, 18), frame, false, false, UDim2.new(1, 6, 0, -6), true, true, nil, 69)
	dropdown.AnchorPoint, dropdown.ClipsDescendants = Vector2.new(1, 0), true

	local textMask = Instance.new("Frame")
	textMask.Name = "TextMask"
	textMask.Size = UDim2.new(1, -20, 1, 0)
	textMask.Position = UDim2.new(0, 0, 0, 0)
	textMask.BackgroundTransparency = 1
	textMask.ClipsDescendants = true
	textMask.Parent = dropdown

	local bindbutton = lib.makecooltext(textMask, UDim2.new(0, 30, 1, 0), "Bind", 11, nil, 0, UDim2.new(0, 20, 0.5, 0), nil, nil, true, 101)
	local sep = lib.makecooltext(textMask, UDim2.new(0, 10, 1, 0), "<b>│</b>", 10, nil, 0, UDim2.new(0, 38, 0.5, 0), nil, nil, true, 101)
	local addbuttonbutton = lib.makecooltext(textMask, UDim2.new(0, 50, 1, 0), "New button", 11, nil, 0, UDim2.new(0, 71, 0.5, 0), nil, nil, true, 101)
	addbuttonbutton.TextWrapped = false

	local function closedd()
		if not opened or waitbra then return end
		waitbra, opened, listening = true, false, false
		local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		local tween = ts:Create(dropdown, ti, {Size = UDim2.new(0, 18, 0, 18)})
		tween:Play()
		bindbutton.Text = "Bind"
		waitbra = false
	end

	bindbutton.Activated:Connect(function()
		t()
		if waitbra or listening then return end
		lib.clik() listening, bindbutton.Text = true, "..."
	end)

	addbuttonbutton.Activated:Connect(function()
		t()
		if waitbra or listening then return end
		lib.clik() makeseperatebutton() closedd()
	end)

	kb.Activated:Connect(function()
		if frame:GetAttribute("locked") or waitbra then return end
		lib.clik()
		if opened then
			closedd()
		else
			waitbra = true
			opened = true
			local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			ts:Create(dropdown, ti, {Size = UDim2.new(0, 120, 0, 18)}):Play()
			waitbra = false
		end
	end)

	uis.InputBegan:Connect(function(input, processed)
		if listening then
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				state.currentBind = nil
				listening = false
				bindbutton.Text = "Bind"
				elementtitle.Text = title
				updateFrameSize()
				closedd()
				if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
				return
			end

			if input.UserInputType == Enum.UserInputType.Keyboard then
				local key = input.KeyCode
				if key == state.currentBind then
					listening = false
					bindbutton.Text = "Bind"
					closedd()
					return
				end
				state.currentBind = key
				listening = false
				bindbutton.Text = "Bind"
				elementtitle.RichText = true
				local mappedName = lib.mapkey(key)
				elementtitle.Text = title .. " <font color='rgb(71, 190, 255)'>[" .. mappedName .. "]</font>"
				updateFrameSize()
				closedd()
				if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
				return
			end
		end

		if not processed and state.currentBind ~= nil and input.KeyCode == state.currentBind then
			if frame:GetAttribute("locked") then return end
			env.essentials.toggles[toggleId].dirty = true
			lib.clik()
			state.enabled = not state.enabled
			updtoggles()
			if callback then spwn(callback, inputbox.Text, state.enabled) end
			return
		end

		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and opened then
			local AbsPos, AbsSize = dropdown.AbsolutePosition, dropdown.AbsoluteSize
			if env.stuf.mouse.X < AbsPos.X or env.stuf.mouse.X > AbsPos.X + AbsSize.X
				or env.stuf.mouse.Y < (AbsPos.Y - 20 - 1) or env.stuf.mouse.Y > AbsPos.Y + AbsSize.Y then
				if not listening then closedd() end
			end
		end
	end)

	inputbox.Focused:Connect(function() lib.clik() end)
	inputbox.MouseEnter:Connect(function() lib.hov() end)
	frame.MouseEnter:Connect(function() lib.hov() end)

	local function onToggleActivated()
		if frame:GetAttribute("locked") then return end
		env.essentials.toggles[toggleId].dirty = true
		lib.clik()
		state.enabled = not state.enabled
		updtoggles()
		if callback then spwn(callback, inputbox.Text, state.enabled) end
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end

	inputbox.FocusLost:Connect(function()
		env.essentials.elements[inputId].dirty = true
		if state.enabled and callback then callback(inputbox.Text, state.enabled) end
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end)

	frame.Activated:Connect(onToggleActivated)

	if default then
		state.enabled = true
		updtoggles()
		if callback then spwn(callback, inputbox.Text, true) end
	end

	return frame
end

function lib.addinputandbutton(parent, title, description, defaulttext, placeholdertext, callback, autofill)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 68, -5
	local textwidth = width - rightpadding - leftpadding

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false, nil, nil, nil, true, 60)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	local buttonId = title

	env.essentials.buttons[buttonId] = {
		type = "inputbutton",
		frame = frame,
		dirty = false,
		currentBind = nil,
		title = title,
		callback = callback,
		elementtitle = nil,
		createdButtons = {},
		currentButtonData = nil,
		buttonFrame = nil,
		updateSize = nil
	}
	local state = env.essentials.buttons[buttonId]

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))
	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 45)

	local elementtitle = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	elementtitle.ZIndex = 61

	local elementdesc = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding, 0, leftpadding + th + tetxgap + 5), Enum.TextXAlignment.Left)
	elementdesc.ZIndex = 61

	local inputbox = lib.makecooltextbox(UDim2.new(0, 118, 0, 28), frame, defaulttext, 16, placeholdertext, nil, UDim2.new(0, 74, 1, -30), nil, 61)
	local executebutton = lib.makecoolbutton("▶", UDim2.new(0, 70, 0, 28), frame, UDim2.new(1, -50, 1, -30), "yes", 17, {bottom = 7}, 61)

	local function updateFrameSize()
		local function stripRichText(str)
			return str:gsub("<[^>]->", "")
		end

		local cleanTitleText = stripRichText(elementtitle.Text)

		local _, newTh = lib.gettextbounds(cleanTitleText, elementtitle.Font, elementtitle.TextSize, Vector2.new(textwidth, math.huge))
		local _, currDh = lib.gettextbounds(description, elementdesc.Font, elementdesc.TextSize, Vector2.new(textwidth, math.huge))

		local newDescY = leftpadding + newTh + tetxgap
		local newTotalHeight = newTh + currDh + leftpadding * 2 + tetxgap + 45

		elementtitle.Size = UDim2.new(0, textwidth, 0, newTh)
		elementtitle.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + newTh / 2 - 5)

		elementdesc.Size = UDim2.new(0, textwidth, 0, currDh)
		elementdesc.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, newDescY + currDh / 2 + 5)

		frame.Size = UDim2.new(0, width, 0, newTotalHeight)
	end

	frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateFrameSize)

	state.elementtitle = elementtitle
	state.updateSize = updateFrameSize

	if autofill then
		local lastSuggestion = nil

		inputbox:GetPropertyChangedSignal("Text"):Connect(function()
			if not inputbox:IsFocused() or inputbox.Text == "" then
				lastSuggestion = nil
				return
			end

			local currentText = inputbox.Text
			if not currentText:find(",") then
				local resolved = env.funcs.resolvetargets(currentText)
				if #resolved == 1 and resolved[1] ~= env.stuf.plr then
					local targetPlayer = resolved[1]
					if targetPlayer.Name:lower():sub(1, #currentText) == currentText:lower() then
						lastSuggestion = targetPlayer.Name
						return
					end
				end
			end
			lastSuggestion = nil
		end)

		inputbox.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Tab and lastSuggestion then
				inputbox.Text = lastSuggestion
				inputbox.CursorPosition = #lastSuggestion + 1
				lastSuggestion = nil
				input:CaptureFocus()
			end
		end)
	end

	inputbox.Focused:Connect(function() lib.clik() end)
	inputbox.MouseEnter:Connect(function() lib.hov() end)
	inputbox.FocusLost:Connect(function()
		env.essentials.elements[title .. "/input"].dirty = true
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end)

	env.essentials.elements[title .. "/input"] = {
		type = "input",
		instance = inputbox,
		setValue = function(val)
			inputbox.Text = tostring(val)
		end
	}

	env.essentials.elements[title] = {
		type = "element",
		frame = frame,
		instance = inputbox,
		callback = callback,
		setValue = function(val)
			inputbox.Text = tostring(val)
		end
	}

	local function makeseperatebutton(destination)
		env.essentials.buttons[buttonId].dirty = true

		if state.currentButtonData then
			state.currentButtonData.frame:Destroy()
			state.createdButtons = {}
			state.currentButtonData = nil
			state.buttonFrame = nil
			return nil
		end

		lib.seperatebuttonzindexoff += 4
		local zplus = lib.seperatebuttonzindexoff

		local _, textHeight = lib.gettextbounds(title, Enum.Font.FredokaOne, 14, Vector2.new(100, math.huge))
		local baseWidth = 150
		local isTooHigh = textHeight > 30
		local buttonWidth = isTooHigh and (baseWidth + 40) or baseWidth

		local startPos = UDim2.new(0.5, 0, 0, -100)
		local targetPos = destination or UDim2.new(0.5, 0, 0, 100)

		local buttonFrame, drag = lib.makecoolframe(UDim2.new(0, buttonWidth, 0, 64), env.essentials.sgui, false, true, startPos, nil, nil, true, 90000 + zplus)
		ts:Create(buttonFrame, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = targetPos}):Play()

		local textAreaWidth = buttonWidth - 48
		local titleText = lib.makecooltext(buttonFrame, UDim2.new(0, textAreaWidth, 0, textHeight), title, 14, nil, 2, UDim2.new(0.5, 0, 0.5, 0), Enum.TextXAlignment.Center, nil, nil, 90001 + zplus)
		titleText.TextWrapped = true

		local buttondata = { frame = buttonFrame }
		table.insert(state.createdButtons, buttondata)
		state.currentButtonData = buttondata
		state.buttonFrame = buttonFrame

		buttonFrame.Destroying:Connect(function()
			if state.currentButtonData == buttondata then state.currentButtonData = nil end
			state.buttonFrame = nil
		end)

		buttonFrame.Activated:Connect(function()
			if drag.dragged then return end
			if buttonFrame:GetAttribute("locked") then return end
			lib.clik()
			if callback then spwn(callback, inputbox.Text) end
		end)

		local scale = Instance.new("UIScale", buttonFrame)
		local baseScale = env.stuf.buttonscale and env.stuf.buttonscale.Scale or 1
		scale.Scale = baseScale

		local hover, press = TweenInfo.new(0.12, Enum.EasingStyle.Quad), TweenInfo.new(0.08, Enum.EasingStyle.Quad)
		local currenttween
		local function playScale(v, info)
			if currenttween then currenttween:Cancel() end
			currenttween = ts:Create(scale, info, { Scale = baseScale * v })
			currenttween:Play()
		end

		env.stuf.buttonscalelistenercount += 1
		local id = env.stuf.buttonscalelistenercount

		env.stuf.buttonscalelisteners[id] = function(newScale)
			if buttonFrame.Parent == nil then
				env.stuf.buttonscalelisteners[id] = nil
				return
			end
			baseScale = newScale
			ts:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = newScale }):Play()
		end

		buttonFrame.Destroying:Connect(function()
			env.stuf.buttonscalelisteners[id] = nil
		end)

		buttonFrame.MouseEnter:Connect(function() lib.hov() playScale(1.02, hover) end)
		buttonFrame.MouseLeave:Connect(function() playScale(1, hover) end)
		buttonFrame.MouseButton1Down:Connect(function() playScale(0.98, press) end)
		buttonFrame.MouseButton1Up:Connect(function() playScale(1.02, hover) end)

		return buttondata
	end

	state.makeseperatebutton = makeseperatebutton

	local waitbra, listening, opened = false, false, false

	local kb = Instance.new("ImageButton", frame)
	kb.Size, kb.Position, kb.AnchorPoint = UDim2.fromOffset(14, 14), UDim2.new(1, 4, 0, -4), Vector2.new(1, 0)
	kb.BackgroundTransparency, kb.Image, kb.ZIndex = 1, "rbxassetid://9405931578", 103

	local dropdown = lib.makecoolframe(UDim2.fromOffset(18, 18), frame, false, false, UDim2.new(1, 6, 0, -6), true, true, nil, 69)
	dropdown.AnchorPoint, dropdown.ClipsDescendants = Vector2.new(1, 0), true

	local textMask = Instance.new("Frame")
	textMask.Name = "TextMask"
	textMask.Size = UDim2.new(1, -20, 1, 0)
	textMask.Position = UDim2.new(0, 0, 0, 0)
	textMask.BackgroundTransparency = 1
	textMask.ClipsDescendants = true
	textMask.Parent = dropdown

	local bindbutton = lib.makecooltext(textMask, UDim2.new(0, 30, 1, 0), "Bind", 11, nil, 0, UDim2.new(0, 20, 0.5, 0), nil, nil, true, 101)
	local sep = lib.makecooltext(textMask, UDim2.new(0, 10, 1, 0), "<b>│</b>", 10, nil, 0, UDim2.new(0, 38, 0.5, 0), nil, nil, true, 101)
	local addbuttonbutton = lib.makecooltext(textMask, UDim2.new(0, 50, 1, 0), "New button", 11, nil, 0, UDim2.new(0, 71, 0.5, 0), nil, nil, true, 101)
	addbuttonbutton.TextWrapped = false

	local function closedd()
		if not opened or waitbra then return end
		waitbra, opened, listening = true, false, false
		local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		ts:Create(dropdown, ti, {Size = UDim2.new(0, 18, 0, 18)}):Play()
		bindbutton.Text = "Bind"
		waitbra = false
	end

	bindbutton.Activated:Connect(function()
		t()
		if waitbra or listening then return end
		lib.clik() listening, bindbutton.Text = true, "..."
	end)

	addbuttonbutton.Activated:Connect(function()
		t()
		if waitbra or listening then return end
		lib.clik() makeseperatebutton() closedd()
	end)

	kb.Activated:Connect(function()
		if frame:GetAttribute("locked") or waitbra then return end
		lib.clik()
		if opened then
			closedd()
		else
			waitbra = true
			opened = true
			local ti = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			ts:Create(dropdown, ti, {Size = UDim2.new(0, 120, 0, 18)}):Play()
			waitbra = false
		end
	end)

	uis.InputBegan:Connect(function(input, processed)
		if listening then
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				state.currentBind = nil
				listening = false
				bindbutton.Text = "Bind"
				elementtitle.Text = title
				updateFrameSize()
				closedd()
				if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
				return
			end

			if input.UserInputType == Enum.UserInputType.Keyboard then
				local key = input.KeyCode
				if key == state.currentBind then
					listening = false
					bindbutton.Text = "Bind"
					closedd()
					return
				end
				state.currentBind = key
				listening = false
				bindbutton.Text = "Bind"
				elementtitle.RichText = true
				local mappedName = lib.mapkey(key)
				elementtitle.Text = title .. " <font color='rgb(71, 190, 255)'>[" .. mappedName .. "]</font>"
				updateFrameSize()
				closedd()
				if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
				return
			end
		end

		if not processed and state.currentBind ~= nil and input.KeyCode == state.currentBind then
			if frame:GetAttribute("locked") then return end
			env.essentials.buttons[buttonId].dirty = true
			lib.clik()
			if callback then spwn(callback, inputbox.Text) end
			return
		end

		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and opened then
			local AbsPos, AbsSize = dropdown.AbsolutePosition, dropdown.AbsoluteSize
			if env.stuf.mouse.X < AbsPos.X or env.stuf.mouse.X > AbsPos.X + AbsSize.X
				or env.stuf.mouse.Y < (AbsPos.Y - 20 - 1) or env.stuf.mouse.Y > AbsPos.Y + AbsSize.Y then
				if not listening then closedd() end
			end
		end
	end)

	executebutton.Activated:Connect(function()
		lib.clik()
		if callback then callback(inputbox.Text) end
	end)

	inputbox.FocusLost:Connect(function()
		env.essentials.elements[title .. "/input"].dirty = true
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end)

	return frame
end

function lib.addslider(parent, title, description, min, max, default, step, callback)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 14, -7
	local textwidth = width - rightpadding - 20
	step = step or 1

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false, nil, nil, nil, nil)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.Active = true
	frame.LayoutOrder = #parent:GetChildren()

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))

	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap + 45)

	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + tetxgap + dh / 2 + 5), Enum.TextXAlignment.Left)

	local track = lib.makecoolframe(UDim2.new(0, width - leftpadding * 2 - 95, 0, 9), frame, false, false, UDim2.new(0.5, leftpadding - 57, 1, -30), true, true, nil, 65)
	track.Active = true

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(0, 0, 0, 5)
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.Position = UDim2.new(0, 2, 0.5, 0)
	fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	fill.BorderSizePixel = 0
	fill.Parent = track
	fill.ZIndex = 66
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0, 15, 0, 15)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BorderSizePixel = 0
	knob.Parent = track
	knob.ZIndex = 66
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local box = lib.makecooltextbox(UDim2.new(0, 70, 0, 28), frame, default, 16, "...", nil, UDim2.new(1, -50, 1, -30), nil, 67)

	local value = math.clamp(default or min, min, max)
	local function snap(v)
		local snapped = math.clamp(math.floor(v / step + 0.5) * step, min, max)
		local decimals = math.max(0, math.ceil(-math.log10(step)))
		return tonumber(string.format("%." .. decimals .. "f", snapped))
	end

	local function updateVisuals(newVal)
		if newVal then value = snap(newVal) end
		local pct = (value - min) / (max - min)
		fill.Size = UDim2.new(pct, 0, 0, 5)
		knob.Position = UDim2.new(pct, 0, 0.5, 0)
		local decimals = math.max(0, math.ceil(-math.log10(step)))
		box.Text = string.format("%." .. decimals .. "f", value)
	end

	local function setFromX(x)
		local pct = math.clamp(x / track.AbsoluteSize.X, 0, 1)
		value = snap(min + (max - min) * pct)
		updateVisuals()
		env.essentials.elements[title].value = value
		env.essentials.elements[title].dirty = true
		if callback then callback(value) end
		if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
	end

	env.essentials.elements[title] = {
		frame = frame,
		type = "slider",
		dirty = false,
		callback = callback,
		instance = box,
		setValue = function(val)
			updateVisuals(tonumber(val))
			if callback then callback(value) end
		end
	}

	task.defer(updateVisuals)

	local dragging = false
	track.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			lib.clik()
			setFromX(i.Position.X - track.AbsolutePosition.X)
			candrag = false
		end
	end)

	uis.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				dragging = false
				candrag = true
				lib.scrollbardragging = false
			end
		end
	end)

	uis.InputChanged:Connect(function(i)
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			setFromX(i.Position.X - track.AbsolutePosition.X)
		end
	end)

	box.FocusLost:Connect(function()
		env.essentials.elements[title].dirty = true

		local num = tonumber(box.Text)
		if num then
			value = snap(num)
			updateVisuals()
			if callback then callback(value) end

			if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
		else
			updateVisuals()
		end
	end)

	return frame
end

function lib.addbinder(parent, title, description, default, callback)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 94, -7
	local textwidth = width - rightpadding - 20

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, 0), parent, false, false)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = #parent:GetChildren()

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))
	frame.Size = UDim2.new(0, width, 0, th + dh + leftpadding * 2 + tetxgap)

	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)
	lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th + tetxgap + dh / 2 + 5), Enum.TextXAlignment.Left)

	local box = lib.makecooltextbox(UDim2.new(0, 70, 0, 28), frame, default or "None", 16, "...", nil, UDim2.new(1, -50, 0.5, 0))

	local listening = false

	env.essentials.elements[title] = {
		frame = frame,
		type = "binder",
		instance = box,
		callback = callback,
		setValue = function(val) 
			if typeof(val) == "string" and val ~= "" then
				pcall(function()
					box.Text = val
					if callback then callback(Enum.KeyCode[val]) end
				end)
			end
		end
	}

	box.Focused:Connect(function()
		lib.clik()
		listening = true
		box.Text = "..."
		box:ReleaseFocus()
	end)

	local inputConn
	inputConn = uis.InputBegan:Connect(function(input)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			local key = input.KeyCode

			listening = false
			box.Text = lib.mapkey(key)
			box:ReleaseFocus()

			lib.clik()
			if callback then 
				spwn(callback, key) 
			end

			if table.find(env.filemanager.persist, title) then env.filemanager.persistsave() end
		end
	end)

	frame.Destroying:Connect(function()
		if inputConn then inputConn:Disconnect() end
	end)

	return frame
end

function lib.addlabel(parent, title, description, text)
	local width, leftpadding, rightpadding, tetxgap = 235, 14, 14, -2
	local textwidth = width - (leftpadding + rightpadding)
	local innerWidth = 188
	local labelGap = 12

	local _, th = lib.gettextbounds(title, Enum.Font.FredokaOne, 13, Vector2.new(textwidth, math.huge))
	local _, dh = lib.gettextbounds(description, Enum.Font.FredokaOne, 10, Vector2.new(textwidth, math.huge))
	local _, lh = lib.gettextbounds(text, Enum.Font.FredokaOne, 9, Vector2.new(innerWidth, math.huge))

	local labelBoxHeight = lh + 10
	local totalHeight = (leftpadding * 2) + th + tetxgap + dh + labelGap + labelBoxHeight

	local frame = lib.makecoolframe(UDim2.new(0, width, 0, totalHeight), parent, false, false, nil, nil, nil, true)
	frame.LayoutOrder = #parent:GetChildren()

	local titleText = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, th), title, 13, nil, 2, UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + th / 2 - 5), Enum.TextXAlignment.Left)

	local descY = leftpadding + th + tetxgap
	local descText = lib.makecooltext(frame, UDim2.new(0, textwidth, 0, dh), description, 10, Color3.fromRGB(170,170,170), 1, UDim2.new(0, leftpadding + textwidth / 2, 0, descY + dh / 2), Enum.TextXAlignment.Left)

	local labelY = descY + dh + labelGap
	local labelContainer = lib.makecoolframe(UDim2.new(0, 208, 0, labelBoxHeight + 2), frame, false, false, UDim2.new(0.5, 0, 0, labelY + labelBoxHeight/2), false, true)
	local labeltext = lib.makecooltext(labelContainer, UDim2.new(0, innerWidth, 0, lh), text, 9, nil, 2, UDim2.new(0.5, 0, 0.5, 0), Enum.TextXAlignment.Left, Enum.TextYAlignment.Center)

	env.essentials.elements[title] = {
		type = "label",
		instance = labeltext,
		setValue = function(newText)
			labeltext.Text = tostring(newText)

			local _, currTh = lib.gettextbounds(titleText.Text, titleText.Font, titleText.TextSize, Vector2.new(textwidth, math.huge))
			local _, currDh = lib.gettextbounds(description, descText.Font, descText.TextSize, Vector2.new(textwidth, math.huge))
			local _, newLh = lib.gettextbounds(labeltext.Text, labeltext.Font, labeltext.TextSize, Vector2.new(innerWidth, math.huge))

			local newBoxHeight = newLh + 10
			local newTotalHeight = (leftpadding * 2) + currTh + tetxgap + currDh + labelGap + newBoxHeight

			local newDescY = leftpadding + currTh + tetxgap
			local newLabelY = newDescY + currDh + labelGap

			titleText.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, leftpadding + currTh / 2 - 5)
			descText.Position = UDim2.new(0, leftpadding + textwidth / 2, 0, newDescY + currDh / 2)

			labelContainer.Position = UDim2.new(0.5, 0, 0, newLabelY + newBoxHeight/2)
			labelContainer.Size = UDim2.new(0, 208, 0, newBoxHeight + 2)

			labeltext.Size = UDim2.new(0, innerWidth, 0, newLh)
			frame.Size = UDim2.new(0, width, 0, newTotalHeight)
		end
	}

	return frame
end

-------------------------------------------------------------------------------------------------------------------------------

return lib

-------------------------------------------------------------------------------------------------------------------------------
