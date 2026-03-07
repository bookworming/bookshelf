--[[---------------------------------------------------------------------------------------------------------------------------
⠀⠀⠀⠀⠀⠀⣀⣤⣀
⠀⠀⠀⣀⠀⠀⢹⣿⣿⠀⠀⣀
⠀⢰⣿⣿⠀⠀⠀⢻⣿⠀⠀⣿⣿⡆
⠀⢸⣿⣿⠀⠀⠀⠀⢻⠀⠀⣿⣿⡇⠀⠀Team Noxious
⠀⢸⣿⣿⠀⠀⡀⠀⠈⠀⠀⣿⣿⡇⠀⠀Boxten Sex GUI | Developed by unable
⠀⢸⣿⣿⠀⠀⣧⠀⠀⠀⠀⣿⣿⡇⠀⠀:: "Dialogue handler"
⠀⠸⣿⣿⠀⠀⣿⣧⠀⠀⠀⣿⣿⠇
⠀⠀⠀⠉⠀⠀⣿⣿⣇⠀⠀⠉
⠀⠀⠀⠀⠀⠀⠉⠛⠉
---------------------------------------------------------------------------------------------------------------------------]]--

-- skidjolt was here kyehehehe
local dh = {}
dh.version = 1

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local txts = FindFirstChildOfClass(game, "TextService")
local txtcs = FindFirstChildOfClass(game, "TextChatService")
local plrs = FindFirstChildOfClass(game, "Players")
local rs = FindFirstChildOfClass(game, "RunService")
local uis = FindFirstChildOfClass(game, "UserInputService")
local ts = FindFirstChildOfClass(game, "TweenService")

local getgenv = (syn and syn.getgenv) or getgenv() or _G

local folder = "Bоxten Sеx GUI"
local env = getgenv.BSGUI
local sgui = env.essentials.sgui

-------------------------------------------------------------------------------------------------------------------------------

-- THEYRE ALL SPEAKING!!! IHRE MÄULEN SIND ALLE OFFEN!!! (some of them have their teeth shown too)
local expressions = {
	-- BSGUI boxten
	boxten = {
		neutral = "rbxassetid://122111994185494", -- / uninterested / resting
		ticked = "rbxassetid://119698259738476", -- / disgusted / shocked (disgusted)
		annoyed = "rbxassetid://87876871905320", -- / pissed
		disgusted = "rbxassetid://117471778623435", -- / holding back
		proud = "rbxassetid://121200224630300", -- / overconfident / somewhat ragebaitish / sarcastic?
		nervous = "placeholder", -- / unreadable / apathetic / somewhat uninterested
		sad = "placeholder", -- / sarcastic, a bit of a "boo hoo" type thing
		happy = "placeholder", -- / unreadable / slightly happy. the smile is still there.
		shoutingmad = "rbxassetid://138041333635868", -- / rage / mega mega fucking fuming
		shoutinghappy = "placeholder", -- / laughing / call or insult
	},

	-- SC-004 boxten
	altboxten = {
		neutral = "rbxassetid://104366477729543", -- / sad / nervous looking / resting
		ticked = "rbxassetid://95507962845165", -- / shocked (disgusted) / bit of the "SSSHHHH... OOOHH..." you say while trying to suppress the pain of your toe after stubbing it 
		annoyed = "placeholder", -- / uninterested / sad
		disgusted = "placeholder", -- / holding back / still sad lol
		proud = "rbxassetid://108675658414571", -- / happy / ^_^ type thing
		nervous = "rbxassetid://123129368409117", -- / come on. do i need to explain?
		sad = "placeholder", -- / looking down (emotionally and literally)
		happy = "rbxassetid://104366477729543", -- / happy (nervosity)
		shoutingmad = "rbxassetid://120792697294977", -- / tense
		shoutinghappy = "placeholder", -- / ^ᗜ^
	},

	-- SC-003 poppy
	poppy = {
		neutral = "rbxassetid://104725304950571", -- / very generic smile
		ticked = "rbxassetid://71699034161008", -- / shocked (worried) / kind of like a "ouch, you okay there?" type thing
		annoyed = "placeholder", -- / i think this is only gonna be used in convos between her and shrimpo lol
		disgusted = "placeholder", -- / holding baaaaack
		proud = "placeholder", -- / ecstatic / overconfident
		nervous = "rbxassetid://106522771451375", -- / worried
		sad = "placeholder", -- / kinda like worried but more sadder?? idk
		happy = "rbxassetid://104725304950571", -- / fucking overjoyed
		shoutingmad = "placeholder", -- / tense like SC-004 boxten
		shoutinghappy = "placeholder", -- / decibel battle
	},

	-- SC-001 shrimpo
	shrimpo = {
		neutral = "rbxassetid://98476525830185", -- / smiling
		ticked = "rbxassetid://71382889666653", -- / shocked (annoyed)
		annoyed = "rbxassetid://105837335646604", -- / do your best "UGHHH" look and then envision it
		disgusted = "placeholder", -- / "EEEWWWW!!!"
		proud = "rbxassetid://87338047321463", -- / overproud / overconfident
		nervous = "placeholder", -- / probably gonna get used when BSGUI boxten tells him to kiss him out of nowhere
		sad = "placeholder", -- / sarcastic obviously this bitch is always angry
		happy = "placeholder", -- / overconfident and crossing their arms
		shoutingmad = "rbxassetid://71382889666653", -- / drunk dad yelling at their son
		shoutinghappy = "placeholder", -- / when the ragebait is successful
	}
}

--[[---------------------------------------------------------------------------------------------------------------------------

   the & is used to determine whether the word behind it should use "'s" or "s", or transforms "a" to an "an" depending on the word in front of it

   {player} = indicates the player, will appear as their selected Toon's name
   {twisted} = indicates the Twisted, will appear as "Twisted [name]"
   {item} = indicates the item
   {direction} = indicates the direction of an object, will show up as "to the [direction]" or "further [direction]"
   {machinesleft} = indicates the amount of machines left to complete
   {health} = indicates the user's current health
   {heal} = like {item}, but just indicates a bandage or a health kit on the floor or in the user's inventory
   {time} = indicates the time it took for the last floor to end, will appear in the "00m00s" format
   {randitem} = picks out a random item from one of the three slots for sale in Dandy's Shop
   {item1, 2, 3} = indicates the target slot of the item being sold in Dandy's Shop

   {prefix} = indicates the command prefix
   {command} = indicates the command
   {commanddesc} = indicates the command's description
   {randalias} = picks a random alias of the command if it has one
   {input} = indicates the command bar's current input

   {configname} = indicates the inputted text in the config name field
   {totalconfigs} = indicates the total number of configs saved

---------------------------------------------------------------------------------------------------------------------------]]--

local padding, textsize = 2, 16
local notifications = {}

local function dialoguenoise()
	env.funcs.playsound("rbxassetid://4841731967")
end

local function tweeny(obj, newY)
	ts:Create(obj, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0.5, 0, 1, newY)
	}):Play()
end

local function recalcy()
	local currentOffset = 0
	for _, label in ipairs(notifications) do
		local height = label.AbsoluteSize.Y
		tweeny(label, -currentOffset)
		currentOffset += height + padding
	end
end

local tagcolors = {
	box = Color3.fromRGB(175, 52, 209),
	altbox = Color3.fromRGB(175, 52, 209),
	pop = Color3.fromRGB(112, 234, 255),
	shr = Color3.fromRGB(247, 109, 40),
}

-------------------------------------------------------------------------------------------------------------------------------

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 1)
container.Position = UDim2.new(0.5, 0, 1, -60)
container.Size = UDim2.new(0, 400, 0, 300)
container.BackgroundTransparency = 1
container.Parent = env.essentials.sgui

local layout = Instance.new("UIListLayout")
layout.Parent = container
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local dialoguecount = 0

local function newdialogue(text, whosaidit, expression)
	if type(expression) == "table" then
		expression = expression[1]
	end
	if type(expression) ~= "string" then
		expression = "neutral"
	end
	
	local nameText = ""
	text = text or ""
	expression = expression or "neutral"
	local nameColor = Color3.new(1, 1, 1)

	local name =
		(whosaidit == "box") and "boxten" or
		(whosaidit == "altbox") and "altboxten" or
		(whosaidit == "pop") and "poppy" or
		(whosaidit == "shr") and "shrimpo"

	if name then
		local expressionset = expressions[name]
	end

	if whosaidit and tagcolors[whosaidit] then
		nameText = "[" .. (
			(whosaidit == "box" or whosaidit == "altbox") and "Boxten" or
				whosaidit == "pop" and "Poppy" or
				whosaidit == "shr" and "Shrimpo"
		) .. "]: "
		nameColor = tagcolors[whosaidit]
		dialoguenoise()
	end

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.new(1, 0, 0, 16)
	holder.AutomaticSize = Enum.AutomaticSize.Y
	holder.AnchorPoint = Vector2.new(0.5, 1)
	holder.Position = UDim2.new(0.5, 0, 1, 0)
	holder.ClipsDescendants = false
	holder.LayoutOrder = dialoguecount
	holder.Parent = container

	local tofade = {}
	local letters = {}
	local cursorX = 0

	if name and expression then
		local expressionset = expressions[name]
		local image = expressionset and expressionset[expression]

		if image and image ~= "placeholder" then
			local iconsize = 25
			local icon = Instance.new("ImageLabel")
			icon.BackgroundTransparency = 1
			icon.Size = UDim2.new(0, iconsize, 0, iconsize)
			icon.Position = UDim2.new(0, cursorX, 0.5, -iconsize / 2)
			icon.Image = image
			icon.ImageTransparency = 1
			icon.Parent = holder
			cursorX += iconsize + 4

			spwn(function()
				ts:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { ImageTransparency = 0 }):Play()
				ts:Create(icon, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Rotation = 10 }):Play()
				t(1)
				ts:Create(icon, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Rotation = 5 }):Play()
			end)

			table.insert(tofade, { label = icon, stroke = nil, baseX = icon.Position.X.Offset, iconpresent = true })
		end
	end

	if nameText ~= "" then
		local nametagw = env.essentials.library.gettextbounds(nameText, Enum.Font.FredokaOne, textsize)

		local nametag = Instance.new("TextLabel")
		nametag.BackgroundTransparency = 1
		nametag.Text = nameText
		nametag.TextColor3 = nameColor
		nametag.Font = Enum.Font.FredokaOne
		nametag.TextSize = textsize
		nametag.Size = UDim2.new(0, nametagw, 1, 0)
		nametag.Position = UDim2.new(0, cursorX, 0, 0)
		nametag.TextTransparency = 1
		nametag.TextXAlignment = Enum.TextXAlignment.Left
		nametag.Parent = holder

		local border = Instance.new("UIStroke")
		border.Parent = nametag
		border.Thickness = 1
		border.Color = Color3.fromRGB(0, 0, 0)
		border.Transparency = 1

		table.insert(tofade, { label = nametag, stroke = border, baseX = cursorX })
		cursorX += nametagw
	end

	local textStartX = cursorX

	for i = 1, #text do
		local char = text:sub(i, i)

		local widthUpToHere = env.essentials.library.gettextbounds(text:sub(1, i), Enum.Font.FredokaOne, textsize)
		local widthUpToPrev = i > 1 and env.essentials.library.gettextbounds(text:sub(1, i - 1), Enum.Font.FredokaOne, textsize) or 0
		local charWidth = widthUpToHere - widthUpToPrev
		local xPos = textStartX + widthUpToPrev

		local letter = Instance.new("TextLabel")
		letter.BackgroundTransparency = 1
		letter.Text = char
		letter.TextColor3 = Color3.new(1, 1, 1)
		letter.Font = Enum.Font.FredokaOne
		letter.TextSize = textsize
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

	cursorX = textStartX + env.essentials.library.gettextbounds(text, Enum.Font.FredokaOne, textsize)
	holder.Size = UDim2.new(0, cursorX, 0, 16)

	local shiftAmount = holder.Size.Y.Offset + (padding or 5)

	for _, existingHolder in ipairs(notifications) do
		local targetPosition = UDim2.new(
			existingHolder.Position.X.Scale, 
			existingHolder.Position.X.Offset, 
			existingHolder.Position.Y.Scale, 
			existingHolder.Position.Y.Offset - shiftAmount
		)

		ts:Create(existingHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = targetPosition
		}):Play()
	end

	table.insert(notifications, 1, holder)
	ts:Create(holder, TweenInfo.new(0.5), { Position = UDim2.new(0.5, 0, 1, 0) }):Play()

	for _, entry in ipairs(tofade) do
		if entry.iconpresent then
			ts:Create(entry.label, TweenInfo.new(0.5), { ImageTransparency = 0 }):Play()
		else
			ts:Create(entry.label, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
			if entry.stroke then
				ts:Create(entry.stroke, TweenInfo.new(0.5), { Transparency = 0 }):Play()
			end
		end
	end

	spwn(function()
		local fadein = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		for _, entry in ipairs(letters) do
			ts:Create(entry.label, TweenInfo.new(0.5), {
				TextTransparency = 0,
				Position = UDim2.new(0, entry.baseX, 0, 0),
			}):Play()
			if entry.stroke then
				ts:Create(entry.stroke, fadein, { Transparency = 0 }):Play()
			end
			rs.RenderStepped:Wait()
		end
	end)

	task.delay(5, function()
		local fadeout = TweenInfo.new(1)

		for _, entry in ipairs(tofade) do
			if entry.iconpresent then
				ts:Create(entry.label, fadeout, { ImageTransparency = 1 }):Play()
			else
				ts:Create(entry.label, fadeout, { TextTransparency = 1 }):Play()
				if entry.stroke then
					ts:Create(entry.stroke, fadeout, { Transparency = 1 }):Play()
				end
			end
		end

		for _, entry in ipairs(letters) do
			ts:Create(entry.label, fadeout, { TextTransparency = 1 }):Play()
			if entry.stroke then
				ts:Create(entry.stroke, fadeout, { Transparency = 1 }):Play()
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
		recalcy()
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

typingseshids = {}
forcepausepoppymsgs = false

function taip(label, new)
	typingseshids = typingseshids or {}

	typingseshids[label] = (typingseshids[label] or 0) + 1
	local sesh = typingseshids[label]

	label.Text = ""

	local skipterms = {
		"\".\"",
		"1.0.4",
		"friends, cosmo",
		"me, random, random",
		"!!",
		"speedrun.com",
		"x39.x93.x19.x45.x19.x29.x00.x29.x49.x24.x19.x29.x84.x00.x18.x49.x00.x18.x37.x18.x00.x38.x12.x48.x58.x00.x45.x82.x00.x83.x00.x38.x58.x35.x18.x93.x00.x83.x19.x53.x83",
		"[X, Y, Z]"
	}

	local puncdelays = {
		["."] = 0.5,
		[","] = 0.5,
		["!"] = 0.5,
		["?"] = 0.5,
	}

	spwn(function()
		local i = 1
		while i <= #new do
			if sesh ~= typingseshids[label] then return end

			local matchedterm
			for _, term in ipairs(skipterms) do
				if string.sub(new, i, i + #term - 1) == term then
					matchedterm = term
					break
				end
			end

			if matchedterm then
				for j = 1, #matchedterm do
					if sesh ~= typingseshids[label] then return end
					label.Text = label.Text .. string.sub(matchedterm, j, j)
					t()
				end
				i += #matchedterm
			else
				local currentchar = string.sub(new, i, i)
				label.Text = label.Text .. currentchar
				if puncdelays[currentchar] and not forcepausepoppymsgs then
					t(puncdelays[currentchar])
				else
					t()
				end
				i += 1
			end
		end
	end)
end

-------------------------------------------------------------------------------------------------------------------------------

-- universal functions
function env.funcs.boxtensaid(text, expression)
	taip(env.stuf.boxtenschatbox, text)

	if env.gear.toons.sendmsgsinchat then
		txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(175, 52, 209)\">Boxten:</font> " .. text)
	end

	if env.gear.toons.closedcaptions then
		newdialogue(text, "box", expression or "neutral")
	end
end

function env.funcs.poppysaid(text, expression)
	taip(env.stuf.poppyschatbox, text)

	if env.gear.toons.sendmsgsinchat then
		txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(112, 234, 255)\">Poppy:</font> " .. text)
	end

	if env.gear.toons.closedcaptions then
		newdialogue(text, "pop", expression or "neutral")
	end
end

function env.funcs.shrimposaid(text, expression)
	taip(env.stuf.shrimposchatbox, text)

	if env.gear.toons.sendmsgsinchat then
		txtcs.TextChannels.RBXGeneral:DisplaySystemMessage("<font color=\"rgb(247, 109, 40)\">Shrimpo:</font> " .. text)
	end

	if env.gear.toons.closedcaptions then
		newdialogue(text, "shr", expression or "neutral")
	end
end

-------------------------------------------------------------------------------------------------------------------------------

-- listeners
if env.stuf.inlobby then

elseif env.stuf.inrun then

elseif env.stuf.inrp then

end

-------------------------------------------------------------------------------------------------------------------------------

return dh

-------------------------------------------------------------------------------------------------------------------------------
