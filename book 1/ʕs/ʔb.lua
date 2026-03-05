--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Builder]
   
---------------------------------------------------------------------------------------------------------------------------]]--

local version 2 -- its wed jan 4 26

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local plrs = FindFirstChildOfClass(game, "Players")
local uis = FindFirstChildOfClass(game, "UserInputService")
local https = FindFirstChildOfClass(game, "HttpService")

local GetChildren = getins(game, "GetChildren") 
local GetPropertyChangedSignal = getins(game, "GetPropertyChangedSignal")
local Destroy = getins(game, "Destroy") 
local IsA = getins(game, "IsA")

local getgenv = getgenv() or _G
local writefile = (syn and syn.writefile) or writefile
local readfile = (syn and syn.readfile) or readfile
local isfile = (syn and syn.isfile) or isfile
local delfile = (syn and syn.delfile) or delfile
local listfiles = (syn and syn.listfiles) or listfiles

local folder = "Bоxten Sеx GUI"
local mobile = uis.TouchEnabled
local env = getgenv.BSGUI
local load = env.funcs.recursivels

-------------------------------------------------------------------------------------------------------------------------------

-- load
env.stuf.sectionsloaded = false

local maincat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94m.lua", true)
env.funcs.introconsolelog("\"Main\" section loaded. (" .. maincat.version .. ")")
if maincat.version ~= env.expectedcompiledscriptversions.mainsection then
	env.funcs.introconsolelog("The \"Main\" section is out of date. (" .. maincat.version .. "OoD)", "warn")
end

env.funcs.introprogress(63)

local navigcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94n.lua", true)
env.funcs.introconsolelog("\"Navigation\" section loaded. (" .. navigcat.version .. ")")
if navigcat.version ~= env.expectedcompiledscriptversions.navigationsection then
	env.funcs.introconsolelog("The \"Navigation\" section is out of date. (" .. navigcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(66)

env.stuf.visualssectionloaded = false
local viscat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94v.lua", true)
env.funcs.introconsolelog("\"Visuals\" section loaded. (" .. viscat.version .. ")")
if viscat.version ~= env.expectedcompiledscriptversions.visualssection then
	env.funcs.introconsolelog("The \"Visuals\" section is out of date. (" .. viscat.version .. "OoD)", "warn")
end
env.stuf.visualssectionloaded = true

env.funcs.introprogress(69)

local lpcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94lp.lua", true)
env.funcs.introconsolelog("\"Local Player\" section loaded. (" .. lpcat.version .. ")")
if lpcat.version ~= env.expectedcompiledscriptversions.localplayersection then
	env.funcs.introconsolelog("The \"Local Player\" section is out of date. (" .. lpcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(71)

local autocat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94au.lua", true)
env.funcs.introconsolelog("\"Automation\" section loaded. (" .. autocat.version .. ")")
if autocat.version ~= env.expectedcompiledscriptversions.automationsection then
	env.funcs.introconsolelog("The \"Automation\" section is out of date. (" .. autocat.version .. "OoD)", "warn")
end

env.funcs.introprogress(74)

local animcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94an.lua", true)
env.funcs.introconsolelog("\"Animations\" section loaded. (" .. animcat.version .. ")")
if animcat.version ~= env.expectedcompiledscriptversions.animationssection then
	env.funcs.introconsolelog("The \"Animations\" section is out of date. (" .. animcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(77)

local funcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94f.lua", true)
env.funcs.introconsolelog("\"Fun\" section loaded. (" .. funcat.version .. ")")
if funcat.version ~= env.expectedcompiledscriptversions.funsection then
	env.funcs.introconsolelog("The \"Fun\" section is out of date. (" .. funcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(80)

local donorcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94d.lua", true) 
env.funcs.introconsolelog("\"Donor\" section loaded. (" .. donorcat.version .. ")")
if donorcat.version ~= env.expectedcompiledscriptversions.donorsection then
	env.funcs.introconsolelog("The \"Donor\" section is out of date. (" .. donorcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(83)

local scriptinfocats = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94si%26f.lua", true)
env.funcs.introconsolelog("Script info sections loaded. (" .. scriptinfocats.version .. ")")
if scriptinfocats.version ~= env.expectedcompiledscriptversions.scriptinformationandchangelogssections then
	env.funcs.introconsolelog("The script info sections is out of date. (" .. scriptinfocats.version .. "OoD)", "warn")
end

env.funcs.introprogress(86)

local clcat = env.funcs.recursivels("book%201/%CA%95s/%EF%BD%A1s/%CA%94cl.lua", true)
env.funcs.introconsolelog("Config loading sections loaded. (" .. clcat.version .. ")")
if clcat.version ~= env.expectedcompiledscriptversions.configloadingsection then
	env.funcs.introconsolelog("The config loading sections are out of date. (" .. clcat.version .. "OoD)", "warn")
end

env.funcs.introprogress(90)

env.stuf.sectionsloaded = true

-------------------------------------------------------------------------------------------------------------------------------

-- category integration
typingseshids = {}
sendinchat = false
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
					t(0.01)
				end
				i += #matchedterm
			else
				local currentchar = string.sub(new, i, i)
				label.Text = label.Text .. currentchar
				if puncdelays[currentchar] and not forcepausepoppymsgs then
					t(puncdelays[currentchar])
				else
					t(0.01)
				end
				i += 1
			end
		end
	end)
end

local commands = {}
local commandcats = {
	["All Commands"] = {}, ["Pinned"] = {}, ["Main"] = {},
	["Local Player"] = {}, ["Visuals"] = {}, ["Automation"] = {},
	["Fun"] = {}, ["Donor"] = {},
}

local mainframe, sections = env.stuf.mainframe, env.stuf.mainframesections
local mainsection, commandssection, settingssection, chatsection, configsection = sections[1], sections[2], sections[3], sections[4], sections[5]
local togglebutton

local function newcat(catparent, categories, defaultcat, catdat, infoframe)
	local searchbar = env.essentials.library.makecooltextbox(UDim2.new(0, 260, 0, 32), catparent, "", 20, "Search...", "rbxassetid://124167325570984", UDim2.new(1, -138, 0, 38))
	local catconts = {}

	local function buildcat(cat)
		local scroll, bg = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 264, 0, 217), catparent, UDim2.new(1, -140, 0.5, 31))
		bg.Visible = false

		local searchsep = env.essentials.library.addseperator(scroll, "Search Results")
		searchsep.Visible = false searchsep.LayoutOrder = 0

		catconts[cat] = {ins = bg, elements = {}, seps = {}, searchseparator = searchsep}
		if not categories[cat] then return end

		for i, item in ipairs(categories[cat]) do
			local element

			if item.commandcat then
				local targetcat = commandcats[item.commandcat]

				if item.command then
					table.insert(targetcat, {
						title = item.command,
						desc = item.commanddesc or item.desc,
						aliases = item.aliases or {},
						realTitle = item.title
					})
				end

				if item.encommands and #item.encommands > 0 then
					table.insert(targetcat, {
						title = item.encommands[1],
						desc = item.encommanddesc,
						aliases = item.enaliases or {},
						realTitle = item.title
					})
				end

				if item.discommands and #item.discommands > 0 then
					table.insert(targetcat, {
						title = item.discommands[1],
						desc = item.discommanddesc,
						aliases = item.disaliases or {},
						realTitle = item.title
					})
				end
			end

			local function reg(cmd, val, override)
				if not cmd then return end
				local cleaned = cmd:lower():gsub("%s?%[.-%]", "")

				commands[cleaned] = {
					title = item.title,
					type = override or item.type,
					forcedval = val,
					hasargs = cmd:find("%[.-%]") ~= nil
				}
			end

			if item.command then
				reg(item.command, nil)
				if item.aliases then
					for _, a in ipairs(item.aliases) do reg(a, nil) end
				end
			end

			if item.encommands then
				for _, a in ipairs(item.encommands) do reg(a, true) end
			end
			if item.enaliases then
				for _, a in ipairs(item.enaliases) do reg(a, true) end
			end

			if item.discommands then
				for _, a in ipairs(item.discommands) do reg(a, false) end
			end
			if item.disaliases then
				for _, a in ipairs(item.disaliases) do reg(a, false) end
			end

			if item.type == "separator" then
				element = env.essentials.library.addseperator(scroll, 
					item.title
				)

			elseif item.type == "toggle" then
				element = env.essentials.library.addtoggle(scroll, 
					item.title, item.desc or "", 
					function(state) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran \"" .. tostring(state) .. "\" callback for toggle \"" .. item.title .. "\"") end 
							item.callback(state) 
						end 
					end, 
					nil, 
					item.default, 
					item.locked, item.lockreason
				)

			elseif item.type == "input" then
				element = env.essentials.library.addinput(scroll, 
					item.title, item.desc or "", 
					item.default or "", 
					item.placeholder or "", 
					function(text) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran callback for input \"" .. item.title .. "\" with value \"" .. text .. "\"") end 
							item.callback(text) 
						end 
					end,
					item.autofill
				)

			elseif item.type == "input and toggle" then
				element = env.essentials.library.addinputandtoggle(scroll, 
					item.title, item.desc or "", 
					item.default or "", 
					item.placeholder or "", 
					function(text, state) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran " .. tostring(state) .. "callback for input and toggle \"" .. item.title .. "\" with value \"" .. text .. "\"") end 
							item.callback(text, state) 
						end 
					end,
					item.default, 
					item.locked, item.lockreason,
					item.autofill
				)

			elseif item.type == "input and button" then
				element = env.essentials.library.addinputandbutton(scroll, 
					item.title, item.desc or "", 
					item.default or "", 
					item.placeholder or "", 
					function(text, state) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran " .. tostring(state) .. " callback for input and button \"" .. item.title .. "\" with value \"" .. text .. "\"") end 
							item.callback(text, state) 
						end 
					end,
					item.autofill
				)

			elseif item.type == "button" then
				element = env.essentials.library.addbutton(scroll, 
					item.title, item.desc or "", 
					function() 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran callback for button \"" .. item.title .. "\"") end 
							item.callback() 
						end 
					end, 
					nil, 
					item.locked, item.lockreason
				)

			elseif item.type == "dropdown" then
				element = env.essentials.library.adddropdown(scroll, 
					item.title, item.desc or "", 
					item.options or {}, 
					function(selected) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran callback for dropdown \"" .. item.title .. "\"") end 
							item.callback(selected) 
						end 
					end, 
					item.playerlist or false, 
					item.multiselect or false,
					item.default or nil,
					item.canbeempty
				)

			elseif item.type == "slider" then
				element = env.essentials.library.addslider(scroll, 
					item.title, item.desc or "", 
					item.min or 0, item.max or 100, 
					item.default or 50,
					item.step or 5, 
					function(value) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran callback for slider \"" .. item.title .. "\" with value \"" .. tostring(value) .. "\"") end 
							item.callback(value) 
						end 
					end
				)

			elseif item.type == "label" then
				element = env.essentials.library.addlabel(scroll, 
					item.title, item.desc or "", 
					item.content
				)

			elseif item.type == "binder" then
				element = env.essentials.library.addbinder(scroll, 
					item.title, item.desc or "", 
					item.default or "", 
					function(key) 
						if item.callback then 
							if env.gear.general.debugmode then env.funcs.box("ran keybind callback for binder \"" .. item.title .. "\"") end 
							item.callback(key) 
						end 
					end
				)
			end

			if element then				
				element.LayoutOrder = i

				if item.type == "separator" then
					table.insert(catconts[cat].seps, element)
				else
					table.insert(catconts[cat].elements, {
						Instance = element,
						Title = item.title:lower()
					})
				end
			end
		end
	end

	for cat, _ in pairs(categories) do
		buildcat(cat)
	end

	local currentcat = defaultcat

	local function filter(query)
		query = query:lower()
		local container = catconts[currentcat]
		if not container then return end

		local searching = query ~= ""

		for _, sep in ipairs(container.seps) do
			sep.Visible = not searching
		end

		container.searchseparator.Visible = searching

		for _, data in ipairs(container.elements) do
			if searching then
				data.Instance.Visible = data.Title:find(query, 1, true) ~= nil
			else
				data.Instance.Visible = true
			end
		end
	end

	searchbar:GetPropertyChangedSignal("Text"):Connect(function()
		filter(searchbar.Text)
	end)

	local function showcat(cat)
		currentcat = cat
		searchbar.Text = ""
		for name, container in pairs(catconts) do
			container.ins.Visible = (name == cat)
		end
	end

	local function hookcatbtn(btn, cat)
		btn.Activated:Connect(function()
			showcat(cat)
		end)
	end

	for _, btndat in ipairs(catdat) do
		hookcatbtn(btndat.button, btndat.category)
	end

	showcat(defaultcat)

	if infoframe then
		infoframe(catparent)
	end
end

-------------------------------------------------------------------------------------------------------------------------------

local function initmainsection()
	local cats = {
		Main = maincat,
		Navigation = navigcat,
		Visuals = viscat,
		["Local Player"] = lpcat,
		Automation = autocat,
		Animations = animcat,
		Fun = funcat,
		Donor = donorcat,
	}

	local catlist = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 211, 0, 164), mainsection, UDim2.new(0, 107, 0.5, -56), 10)

	local buttons = {
		{button = env.essentials.library.makecoolbutton("Main", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 20), "no", 21), category = "Main"},
		{button = env.essentials.library.makecoolbutton("Navigation", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 60), "orang", 21), category = "Navigation"},
		{button = env.essentials.library.makecoolbutton("Visuals", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 100), "yellow", 21), category = "Visuals"},
		{button = env.essentials.library.makecoolbutton("Local Player", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 140), "yes", 21), category = "Local Player"},
		{button = env.essentials.library.makecoolbutton("Automation", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 180), "info", 21), category = "Automation"},
		{button = env.essentials.library.makecoolbutton("Animations", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 220), "purpl", 21), category = "Animations"},
		{button = env.essentials.library.makecoolbutton("Fun", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 260), "pink", 21), category = "Fun"},
		{button = env.essentials.library.makecoolbutton("Donor", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 300), "rb", 21), category = "Donor"},
	}

	local function loadspeaker(catparent)
		local boxten = env.essentials.library.makecoolframe(UDim2.new(0, 209, 0, 100), catparent, false, false, UDim2.new(0, 109, 0.5, 89), false, true)
		local boxtenfacecam = Instance.new("ImageLabel")
		boxtenfacecam.Image = "rbxassetid://71634162052478"
		boxtenfacecam.Size = UDim2.new(0, 50, 0, 50)
		boxtenfacecam.Position = UDim2.new(0, 6, 0, 6)
		boxtenfacecam.Parent = boxten
		boxtenfacecam.BackgroundTransparency = 1
		Instance.new("UICorner", boxtenfacecam).CornerRadius = UDim.new(0, 14)

		local swapbutton = env.essentials.library.makecoolbutton(">>", UDim2.new(0, 42, 0, 28), boxten, UDim2.new(0, 31, 0.5, 27), "info", 21, {bottom = 7})

		local nametag = env.essentials.library.makecooltext(boxten, UDim2.new(0, 60, 0, 20), "Boxten", 15, nil, 2, UDim2.new(0, 92, 0, 15), Enum.TextXAlignment.Left)
		local saying = env.essentials.library.makecooltext(boxten, UDim2.new(0, 140, 0, 70), "welcome to Boxten Sex GUI. the most over-the-top script ever made for Dandy's World.", 11, Color3.fromRGB(170, 170, 170), 2, UDim2.new(0, 132, 0, 60), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)
	end

	-- unlock donor things
	task.delay(1, function()
		if env.funcs.datacheck(env.essentials.data.classes.autodonors) 
			or env.funcs.datacheck(env.essentials.data.classes.unable)
			or env.funcs.datacheck(env.essentials.data.classes.teammembers) 
			or env.funcs.datacheck(env.essentials.data.classes.hypnic) then
			env.funcs.box("user has donor, updating donor section", true)

			env.essentials.library.lock("Exclude yourself", false)

			env.essentials.library.lock("Flashbang script users", false)
			env.essentials.library.lock("Confuse script users", false)
			env.essentials.library.lock("Freeze time", false)

			env.essentials.library.lock("Script user revolver", false)
			env.essentials.library.lock("Script user double-barrel shotgun", false)
		end
	end)

	newcat(mainsection, cats, "Main", buttons, loadspeaker)
end

-------------------------------------------------------------------------------------------------------------------------------

local function initsettingssection()
	local cats = {
		["Script Settings"] = scriptinfocats["1"],
		["UI Settings"] = scriptinfocats["2"],
		Changelogs = scriptinfocats["3"]
	}

	local buttons = {
		{button = env.essentials.library.makecoolbutton("Script Settings", UDim2.new(0, 204, 0, 32), settingssection, UDim2.new(0, 108, 0, 24), "neutral", 21), category = "Script Settings"},
		{button = env.essentials.library.makecoolbutton("UI Settings", UDim2.new(0, 204, 0, 32), settingssection, UDim2.new(0, 108, 0, 66), "neutral", 21), category = "UI Settings"},
		{button = env.essentials.library.makecoolbutton("Changelogs", UDim2.new(0, 204, 0, 32), settingssection, UDim2.new(0, 108, 0, 108), "neutral", 21), category = "Changelogs"},
	}

	local function versionInfo(catparent)
		local boxten = env.essentials.library.makecoolframe(UDim2.new(0, 209, 0, 146), catparent, false, false, UDim2.new(0, 109, 0.5, 66), false, true)
		local nametag = env.essentials.library.makecooltext(boxten, UDim2.new(0, 188, 0, 20), [[
Noxious: Boxten Sex GUI
<font color='rgb(130,130,130)' size='11'>Developed by unable</font>

Version: 1.3.0
<font color='rgb(130,130,130)' size='11'>Sub-version: 1273</font>

Supported executors:
<font color='rgb(130,200,130)' size='13'>Hydrogen, Macsploit, Xeno, Delta, Velocity,</font> <font color='rgb(180,180,130)' size='12'>Zenith, Vega X, Seliware, Bunni.lol, Ronix,</font> <font color='rgb(130,130,130)' size='11'>Volcano</font>
        ]], 14, nil, 2, UDim2.new(0.5, -1, 0, 16), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)
	end

	newcat(settingssection, cats, "Script Settings", buttons, versionInfo)
end

-------------------------------------------------------------------------------------------------------------------------------

local function initconfigssection()
	local cats = {
		["Config Loading"] = clcat,
		["Community Configs"] = {},
	}

	local buttons = {
		{button = env.essentials.library.makecoolbutton("Config Loading", UDim2.new(0, 204, 0, 32), configsection, UDim2.new(0, 108, 0, 24), "neutral", 21), category = "Config Loading"},
		{button = env.essentials.library.makecoolbutton("Community Configs", UDim2.new(0, 204, 0, 32), configsection, UDim2.new(0, 108, 0, 66), "neutral", 21), category = "Community Configs"},
	}

	local function info(p)
		local shrimpo = env.essentials.library.makecoolframe(UDim2.new(0, 209, 0, 100), p, false, false, UDim2.new(0, 109, 0.5, 1), false, true)
		local shrimpofacecam = Instance.new("ImageLabel")
		shrimpofacecam.Image = "rbxassetid://128280226165950"
		shrimpofacecam.Size = UDim2.new(0, 50, 0, 50)
		shrimpofacecam.Position = UDim2.new(0, 6, 0, 6)
		shrimpofacecam.Parent = shrimpo
		shrimpofacecam.BackgroundTransparency = 1
		Instance.new("UICorner", shrimpofacecam).CornerRadius = UDim.new(0, 14)

		local swapbutton = env.essentials.library.makecoolbutton(">>", UDim2.new(0, 42, 0, 28), shrimpo, UDim2.new(0, 31, 0.5, 27), "info", 21, {bottom = 7})

		local nametag = env.essentials.library.makecooltext(shrimpo, UDim2.new(0, 60, 0, 20), "Shrimpo", 15, nil, 2, UDim2.new(0, 92, 0, 15), Enum.TextXAlignment.Left)
		local saying = env.essentials.library.makecooltext(shrimpo, UDim2.new(0, 140, 0, 70), "HEY!!! YOU THERE!!! I HATE YOU!!!", 11, Color3.fromRGB(170, 170, 170), 2, UDim2.new(0, 132, 0, 60), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)

		local fileinfo = env.essentials.library.makecoolframe(UDim2.new(0, 209, 0, 76), p, false, false, UDim2.new(0, 109, 1, -42), false, true)
		env.stuf.fileinfolabel = env.essentials.library.makecooltext(fileinfo, UDim2.new(0, 200, 0, 20), [[
Total configs: ]] .. env.filemanager.getconfigcount() .. [[

<font color='rgb(130,130,130)' size='11'>All files fetched successfully.</font>

Current executor: ]] .. env.funcs.identifyexec() .. [[

<font color='rgb(130,130,130)' size='11'>Your executor is supported.</font>
        ]], 14, nil, 2, UDim2.new(0.5, 5, 0, 16), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)
	end

	newcat(configsection, cats, "Config Loading", buttons, info)
end

-------------------------------------------------------------------------------------------------------------------------------

local function execcmd(cmd)
	local args = cmd:split(" ")
	local name = args[1]:lower()
	table.remove(args, 1) 

	local entry = commands[name]
	if not entry then return false end

	local elet = entry.title
	local forced = entry.forcedval
	local fullArg = table.concat(args, " ") 

	if entry.type == "toggle" then
		local cur = env.essentials.toggles[elet].enabled
		local new

		if forced ~= nil then
			new = forced
		else
			local arg1 = args[1] and args[1]:lower()
			if arg1 == "on" or arg1 == "true" then new = true
			elseif arg1 == "off" or arg1 == "false" then new = false
			else new = not cur end
		end
		env.essentials.library.update(elet, new)

	elseif entry.type == "input and toggle" then
		local state = env.essentials.toggles[elet]
		local newEnabled

		if forced ~= nil then
			newEnabled = forced
		else
			newEnabled = not state.enabled
		end

		if fullArg ~= "" then
			env.essentials.library.update(elet, {text = fullArg, enabled = newEnabled})
		else
			env.essentials.library.update(elet, {enabled = newEnabled})
		end

	elseif entry.type == "input and button" then
		if fullArg ~= "" then
			env.essentials.library.update(elet .. "/input", fullArg)
		else
			env.essentials.library.update(elet) 
		end

	elseif entry.type == "slider" or entry.type == "input" then
		local val = (forced ~= nil) and forced or fullArg
		if entry.type == "slider" then val = tonumber(val) end
		if val ~= nil and val ~= "" then env.essentials.library.update(elet, val) end

	elseif entry.type == "button" then
		env.essentials.library.update(elet)

	elseif entry.type == "dropdown" then
		if fullArg ~= "" then
			env.essentials.library.update(elet, fullArg)
		end
	end

	return true
end

local pinnedcommands = {}
function cmdpinned(cmd) return table.find(pinnedcommands, cmd) ~= nil end
local pinnedfile = folder .. "/Pinned Commands.json"

local function savepinned()
	if writefile then
		writefile(pinnedfile, https:JSONEncode(pinnedcommands))
	end
end

local function loadpinned()
	if readfile and isfile and isfile(pinnedfile) then
		local ok, data = pcall(function()
			return https:JSONDecode(readfile(pinnedfile))
		end)
		if ok and typeof(data) == "table" then
			pinnedcommands = data
		end
	end
end

loadpinned()

local function initcommandssection()
	local buttonlist_right = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 264, 0, 217), commandssection, UDim2.new(1, -140, 0.5, -16))
	local catlist = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 211, 0, 164), commandssection, UDim2.new(0, 107, 0.5, -56), 10)

	local buttons = {
		{button = env.essentials.library.makecoolbutton("All Commands", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 20), "no", 21), category = "All Commands"},
		{button = env.essentials.library.makecoolbutton("Pinned", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 60), "orang", 21), category = "Pinned"},
		{button = env.essentials.library.makecoolbutton("Main", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 100), "yellow", 21), category = "Main"},
		{button = env.essentials.library.makecoolbutton("Local Player", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 140), "yes", 21), category = "Local Player"},
		{button = env.essentials.library.makecoolbutton("Visuals", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 180), "info", 21), category = "Visuals"},
		{button = env.essentials.library.makecoolbutton("Automation", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 220), "purpl", 21), category = "Automation"},
		{button = env.essentials.library.makecoolbutton("Fun", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 260), "pink", 21), category = "Fun"},
		{button = env.essentials.library.makecoolbutton("Donor", UDim2.new(0, 183, 0, 32), catlist, UDim2.new(0.5, -9, 0, 300), "rb", 21), category = "Donor"},
	}

	local poppy = env.essentials.library.makecoolframe(UDim2.new(0, 209, 0, 100), commandssection, false, false, UDim2.new(0, 109, 0.5, 89), false, true)
	local poppyfacecam = Instance.new("ImageLabel")
	poppyfacecam.Image = "rbxassetid://123745750450142"
	poppyfacecam.Size = UDim2.new(0, 50, 0, 50)
	poppyfacecam.Position = UDim2.new(0, 6, 0, 6)
	poppyfacecam.Parent = poppy
	poppyfacecam.BackgroundTransparency = 1
	Instance.new("UICorner", poppyfacecam).CornerRadius = UDim.new(0, 14)

	local swapbutton = env.essentials.library.makecoolbutton(">>", UDim2.new(0, 42, 0, 28), poppy, UDim2.new(0, 31, 0.5, 27), "info", 21, {bottom = 7})

	local nametag = env.essentials.library.makecooltext(poppy, UDim2.new(0, 60, 0, 20), "Poppy", 15, nil, 2, UDim2.new(0, 92, 0, 15), Enum.TextXAlignment.Left)
	local saying = env.essentials.library.makecooltext(poppy, UDim2.new(0, 140, 0, 70), "Hello! I'm Poppy! It's nice to meet you!", 11, Color3.fromRGB(170, 170, 170), 2, UDim2.new(0, 132, 0, 60), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)

	local commandbar = env.essentials.library.makecooltextbox(UDim2.new(0, 216, 0, 32), commandssection, "", 20, "Command Bar", nil, UDim2.new(1, -160, 1, -23))
	local executebutton = env.essentials.library.makecoolbutton("▶", UDim2.new(0, 32, 0, 32), commandssection, UDim2.new(1, -22, 1, -23), "yes", 20, {bottom = 7})

	executebutton.Activated:Connect(function()
		local input = commandbar.Text
		if input ~= "" then
			local success, err = execcmd(input)
			if not success then
				taip(saying, "Sorry, I couldn't find a command named '" .. input .. "'.")
			end
		end
	end)

	commandbar.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local input = commandbar.Text
			if input ~= "" then
				local success, err = execcmd(input)
				if success then
					commandbar.Text = ""
				else
					taip(saying, "Sorry, I couldn't find a command named '" .. input .. "'.")
				end
			end
		end
	end)

	local currentcat
	local CategorySeparators = {}

	local function clearList(scroll)
		for _, c in ipairs(scroll:GetChildren()) do
			if c:IsA("Frame") or c:IsA("GuiObject") then 
				if not c:IsA("UIListLayout") then c:Destroy() end
			end
		end
	end

	local function buildCategory(scroll, cat)
		clearList(scroll)
		CategorySeparators[cat] = {}

		local categoriesToBuild = {}

		if cat == "All Commands" then
			categoriesToBuild = {"Main", "Local Player", "Visuals", "Automation", "Fun", "Donor"}
		elseif cat == "Pinned" then
			env.essentials.library.addseperator(scroll, "Pinned Commands")
			local foundPinned = false
			for _, cat in ipairs({"Main", "Local Player", "Visuals", "Automation", "Fun", "Donor"}) do
				for _, item in ipairs(commandcats[cat] or {}) do
					if cmdpinned(item.title) then
						env.funcs.createCommandUI(scroll, item)
						foundPinned = true
					end
				end
			end
			if not foundPinned then
				env.essentials.library.makecooltext(scroll, UDim2.new(0, 237, 0, 0), "No pinned commands yet.", 13, nil, 1, UDim2.new(0, 0, 0, 0), Enum.TextXAlignment.Left)
			end
			return
		else
			categoriesToBuild = {cat}
		end

		for _, cat in ipairs(categoriesToBuild) do
			local items = commandcats[cat]
			if not items or #items == 0 then continue end

			env.essentials.library.addseperator(scroll, cat)

			for _, item in ipairs(items) do
				env.funcs.createCommandUI(scroll, item)
			end
		end
	end

	function env.funcs.createCommandUI(parent, item)
		local cmdFrame = Instance.new("Frame")
		cmdFrame.Size = UDim2.new(1, -10, 0, 3)
		cmdFrame.BackgroundTransparency = 1
		cmdFrame.Parent = parent

		local pinIcon = Instance.new("ImageButton")
		pinIcon.Size = UDim2.new(0, 14, 0, 15)
		pinIcon.Position = UDim2.new(0, 16, 0.5, -8)
		pinIcon.BackgroundTransparency = 1
		pinIcon.ZIndex = 60
		pinIcon.Image = cmdpinned(item.title) and "rbxassetid://84270520426892" or "rbxassetid://133442819545161"
		pinIcon.Parent = cmdFrame

		local display = item.title 
		if item.aliases and #item.aliases > 0 then
			display = display .. " <font color='rgb(130,130,130)' size='10'>(" .. table.concat(item.aliases, ", ") .. ")</font>"
		end

		local cmdBtn = env.essentials.library.makecooltext(cmdFrame, UDim2.new(2, 0, 1, 6), display .. " - " .. (item.desc or ""), 13, nil, 1, UDim2.new(1, 34, 0, 0), Enum.TextXAlignment.Left, nil, true)
		cmdBtn.TextWrapped = false

		cmdBtn.Activated:Connect(function()
			env.essentials.library.clik()
			taip(saying, "Executing \"" .. item.title .. "\" " .. item.desc .. "!")
			commandbar.Text = item.title
		end)

		pinIcon.Activated:Connect(function()
			env.essentials.library.clik()
			if cmdpinned(item.title) then
				table.remove(pinnedcommands, table.find(pinnedcommands, item.title))
				pinIcon.Image = "rbxassetid://133442819545161"
			else
				table.insert(pinnedcommands, item.title)
				pinIcon.Image = "rbxassetid://84270520426892"
			end
			savepinned()
			if currentcat == "Pinned" or currentcat == "All Commands" then
				buildCategory(buttonlist_right, currentcat)
			end
		end)
	end

	local function hookcatbtn(btn, cat)
		btn.Activated:Connect(function()
			currentcat = cat
			buildCategory(buttonlist_right, cat)
		end)
	end

	for _, btnData in ipairs(buttons) do
		hookcatbtn(btnData.button, btnData.category)
	end

	buildCategory(buttonlist_right, "All Commands")
	currentcat = "All Commands"
end

-------------------------------------------------------------------------------------------------------------------------------

local function getanonid(name)
	local hash = 0
	for i = 1, #name do
		hash = (hash * 31 + string.byte(name, i)) % 1000000
	end
	return tostring((hash % 90000) + 10000)
end

local function initchatsection()
	local userlist = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 209, 0, 207), chatsection, UDim2.new(0, 108, 0.5, -11))

	local function makeemptyframe()
		local f = Instance.new("Frame")
		f.Size = UDim2.new(0, 181, 0, 38)
		f.BorderSizePixel = 0
		f.AnchorPoint = Vector2.new(0.5, 0.5)
		f.Position = UDim2.new(1, -147, 0.5, -16)
		f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		f.BackgroundTransparency = 0.7
		f.Parent = userlist

		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 18)

		local fb = Instance.new("UIStroke")
		fb.Thickness = 2
		fb.Color = Color3.fromRGB(0, 0, 0)
		fb.Transparency = 0.6
		fb.Parent = f

		local fakepfp = Instance.new("Frame")
		fakepfp.Size = UDim2.new(0, 22, 0, 22)
		fakepfp.BorderSizePixel = 0
		fakepfp.AnchorPoint = Vector2.new(0.5, 0.5)
		fakepfp.Position = UDim2.new(0, 21, 0.5, 0)
		fakepfp.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		fakepfp.BackgroundTransparency = 1
		fakepfp.Parent = f

		Instance.new("UICorner", fakepfp).CornerRadius = UDim.new(1, 0)

		local pb = Instance.new("UIStroke")
		pb.Thickness = 2
		pb.Color = Color3.fromRGB(0, 0, 0)
		pb.Transparency = 0.8
		pb.Parent = fakepfp
	end

	env.essentials.library.makecooltext(chatsection, UDim2.new(0, 209, 0, 20), "Script users (Current server)", 16, nil, 2, UDim2.new(0, 108, 0, 12))

	local section1scrollframe2 = Instance.new("Frame")
	section1scrollframe2.Size = UDim2.new(0, 240, 0, 212)
	section1scrollframe2.BorderSizePixel = 0
	section1scrollframe2.AnchorPoint = Vector2.new(0.5, 0.5)
	section1scrollframe2.Position = UDim2.new(1, -147, 0.5, -16)
	section1scrollframe2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	section1scrollframe2.BackgroundTransparency = 0.7
	section1scrollframe2.Parent = chatsection

	Instance.new("UICorner", section1scrollframe2).CornerRadius = UDim.new(0, 14)

	local pb = Instance.new("UIStroke")
	pb.Thickness = 2
	pb.Color = Color3.fromRGB(0, 0, 0)
	pb.Transparency = 0.6
	pb.Parent = section1scrollframe2

	local chatlogs = env.essentials.library.makecoolscrollingframe(UDim2.new(0, 264, 0, 216), chatsection, UDim2.new(1, -137, 0.5, -16), 5)
	chatlogs:GetPropertyChangedSignal("CanvasSize"):Connect(function()
		chatlogs.CanvasPosition = Vector2.new(0, chatlogs.CanvasSize.Y.Offset)
	end)

	local chatbar = env.essentials.library.makecooltextbox(UDim2.new(0, 356, 0, 32), chatsection, "", 20, "Message", nil, UDim2.new(0.5, -63, 1, -23), 100)
	local sendbutton, sendtext = env.essentials.library.makecoolbutton("Send", UDim2.new(0, 66, 0, 32), chatsection, UDim2.new(1, -40, 1, -23), "yes", 21, {bottom = 7})
	local plusbutton = env.essentials.library.makecoolbutton("+", UDim2.new(0, 32, 0, 32), chatsection, UDim2.new(1, -102, 1, -23), "info", 24, {bottom = 9})

	local padding = Instance.new("Frame")
	padding.Size = UDim2.new(1, 0, 0, 0)
	padding.BackgroundTransparency = 1
	padding.Parent = chatlogs

	local function createplayerframe(user)
		local ins = plrs:FindFirstChild(user)
		if not ins then return end

		local anonCode = getanonid(ins.Name)
		local displayname, name

		local isBoxten = table.find(env.stuf.handshaker.handshakenclients, ins.Name)

		if isBoxten then
			displayname = "Anonymous " .. anonCode
			name = "anon_" .. anonCode
		else
			displayname = "Riddance user " .. anonCode
			name = "riddance_" .. anonCode
		end

		if ins.DisplayName == env.stuf.displayname then 
			displayname = displayname .. "<font color='rgb(255,244,69)'> [You]</font>" 
		end

		if env.funcs.datacheck(env.essentials.data.classes.unable, ins.Name) then 
			displayname = "Boxten <font color='rgb(197, 61, 224)'> [unable]</font>" 
			name = "boxten"
		end

		local template = env.essentials.library.makecoolframe(UDim2.new(0, 181, 0, 38), userlist, false, false, UDim2.new(0, 0, 0, 0), false, true)
		template.ClipsDescendants = true

		local pfpholder = env.essentials.library.makecoolframe(UDim2.new(0, 22, 0, 22), template, false, false, UDim2.new(0, 21, 0.5, 0), true)

		env.essentials.library.makecooltext(template, UDim2.new(0, 260, 0, 20), displayname, 11, nil, 2, UDim2.new(0.5, 82, 0.5, -7), Enum.TextXAlignment.Left)
		env.essentials.library.makecooltext(template, UDim2.new(0, 260, 0, 20), "@" .. name, 9, Color3.fromRGB(187, 187, 187), 2, UDim2.new(0.5, 82, 0.5, 7), Enum.TextXAlignment.Left)

		local profilepic = Instance.new("ImageLabel")
		profilepic.Image = env.funcs.datacheck(env.essentials.data.classes.unable, ins.Name) and "rbxassetid://71634162052478" or "https://www.roblox.com/headshot-thumbnail/image?userId=7277426403&width=420&height=420&format=png"
		profilepic.Parent = pfpholder
		profilepic.Size = UDim2.new(1, 0, 1, 0)
		profilepic.AnchorPoint = Vector2.new(0.5, 0.5)
		profilepic.Position = UDim2.new(0.5, 0, 0.5, 0)
		profilepic.BackgroundTransparency = 1
		Instance.new("UICorner", profilepic).CornerRadius = UDim.new(1, 0)
	end

	function env.funcs.refreshuserlist()
		for _, child in ipairs(userlist:GetChildren()) do
			if child:IsA("Frame") or child:IsA("ScrollingFrame") then child:Destroy() end
		end

		for _, username in ipairs(env.stuf.handshaker.handshakenclients) do
			createplayerframe(username)
		end

		for _, username in ipairs(env.stuf.handshaker.detectedRiddance) do
			if not table.find(env.stuf.handshaker.handshakenclients, username) then
				createplayerframe(username)
			end
		end

		local emptyCount = 30 - #env.stuf.handshaker.handshakenclients
		for i = 1, emptyCount do
			makeemptyframe()
		end
	end

	local lastmessage = nil

	function env.funcs.logchat(message, user, isRiddance)
		local ins = plrs:FindFirstChild(user)
		if not ins then return end

		if lastmessage then
			local oldLine = lastmessage:FindFirstChild("sep")
			if oldLine then oldLine.Visible = true end

			local oldMsgHeight = lastmessage:GetAttribute("h")
			local isSystem = lastmessage:GetAttribute("sys")
			local headerH = isSystem and 2 or 20 
			local pad = 10
			lastmessage.Size = UDim2.new(0, 225, 0, math.max(isSystem and 10 or 45, headerH + oldMsgHeight + pad))
		end

		local width = 225
		local messageWidth = 180
		local padding = 6
		local nameheight = 20

		local _, msgheight = env.essentials.library.gettextbounds(message, Enum.Font.FredokaOne, 9, Vector2.new(messageWidth, math.huge))

		local currentHeight = math.max(41, nameheight + msgheight + (padding - 4))

		local template = Instance.new("Frame")
		template.Size = UDim2.new(0, width, 0, currentHeight)
		template.BorderSizePixel = 0
		template.BackgroundTransparency = 1
		template.Parent = chatlogs

		template:SetAttribute("h", msgheight)

		local pfpholder = env.essentials.library.makecoolframe(UDim2.new(0, 29, 0, 29), template, false, false, UDim2.new(0, 16, 0, 19), true)

		local anonCode = getanonid(ins.Name)
		local displayname

		if isRiddance then
			displayname = "Riddance user " .. anonCode
		else
			displayname = "Anonymous " .. anonCode
		end

		if ins.DisplayName == env.stuf.displayname then 
			displayname = displayname .. "<font color='rgb(255,244,69)'> [You]</font>" 
		end

		if env.funcs.datacheck(env.essentials.data.classes.unable, ins.Name) then 
			displayname = "Boxten <font color='rgb(197, 61, 224)'> [unable]</font>" 
		end

		env.essentials.library.makecooltext(template, UDim2.new(0, 290, 0, nameheight), displayname, 11, nil, 2, UDim2.new(0.5, 74, 0, -2 + nameheight/2), Enum.TextXAlignment.Left)

		local msg = env.essentials.library.makecooltext(template, UDim2.new(0, messageWidth, 0, msgheight), message, 9, nil, 2, UDim2.new(0.5, 19, 0, -3 + nameheight + msgheight/2), Enum.TextXAlignment.Left, Enum.TextYAlignment.Top)
		msg.TextWrapped = true

		local profilepic = Instance.new("ImageLabel")
		profilepic.Image = env.funcs.datacheck(env.essentials.data.classes.unable, ins.Name) and "rbxassetid://71634162052478" or "https://www.roblox.com/headshot-thumbnail/image?userId=7277426403&width=420&height=420&format=png"
		profilepic.Parent = pfpholder
		profilepic.Size = UDim2.new(1, 0, 1, 0)
		profilepic.AnchorPoint = Vector2.new(0.5, 0.5)
		profilepic.Position = UDim2.new(0.5, 0, 0.5, 0)
		profilepic.BackgroundTransparency = 1
		Instance.new("UICorner", profilepic).CornerRadius = UDim.new(1, 0)

		local line = Instance.new("Frame")
		line.Name = "sep"
		line.Size = UDim2.new(0, width, 0, 2)
		line.BorderSizePixel = 0
		line.AnchorPoint = Vector2.new(0.5, 1)
		line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		line.Position = UDim2.new(0.5, 0, 1, 0)
		line.BackgroundTransparency = 0.8
		line.Visible = false
		line.Parent = template
		Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)

		template:SetAttribute("sys", false)
		lastmessage = template
	end

	function env.funcs.consolelog(message)
		message = "[" .. env.funcs.getservertime() .. "] " .. message
		if lastmessage then
			local oldLine = lastmessage:FindFirstChild("sep")
			if oldLine then oldLine.Visible = true end

			local oldMsgHeight = lastmessage:GetAttribute("h")
			local isSystem = lastmessage:GetAttribute("sys")
			local headerH = isSystem and 2 or 20
			local pad = 10

			lastmessage.Size = UDim2.new(0, 225, 0, math.max(isSystem and 10 or 45, headerH + oldMsgHeight + pad))
		end

		local width = 225
		local w = 200
		local padding = 12

		local _, h = env.essentials.library.gettextbounds(message, Enum.Font.FredokaOne, 10, Vector2.new(w, math.huge))

		local trueh = h + padding 

		local template = Instance.new("Frame")
		template.Size = UDim2.new(0, width, 0, trueh)
		template.BorderSizePixel = 0
		template.BackgroundTransparency = 1
		template.Parent = chatlogs

		template:SetAttribute("h", h)
		template:SetAttribute("sys", true)

		local logLabel = env.essentials.library.makecooltext(template, UDim2.new(0, w, 0, h), message, 10, Color3.fromRGB(187, 187, 187),2, UDim2.new(0.5, 0, 0.5, -4), Enum.TextXAlignment.Center)
		logLabel.TextWrapped = true

		local line = Instance.new("Frame")
		line.Name = "sep"
		line.Size = UDim2.new(0, width, 0, 2)
		line.BorderSizePixel = 0
		line.AnchorPoint = Vector2.new(0.5, 1)
		line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		line.Position = UDim2.new(0.5, 0, 1, 0)
		line.BackgroundTransparency = 0.8
		line.Visible = false
		line.Parent = template
		Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)

		lastmessage = template
	end

	local slowmode = false

	local function send()
		if slowmode or chatbar.Text == "" or chatbar.Text == " " then 
			return 
		end

		env.stuf.handshaker.donorsend("send " .. chatbar.Text)
		chatbar.Text = ""

		if not env.funcs.datacheck(env.essentials.data.classes.unable) then
			slowmode = true

			spwn(function()
				local dur = 5.0
				local start = os.clock()

				local ogtxt = sendtext.Text

				while os.clock() - start < dur do
					local remaining = dur - (os.clock() - start)
					sendtext.Text = string.format("%.1f", remaining)
					t()
				end

				sendtext.Text = ogtxt
				slowmode = false
			end)
		end
	end

	chatbar.FocusLost:Connect(function(entered)
		if entered then
			send()
		end
	end)

	sendbutton.MouseButton1Click:Connect(send)

	env.funcs.refreshuserlist()
end

-------------------------------------------------------------------------------------------------------------------------------

initmainsection()
initcommandssection()
initsettingssection()
initchatsection()
initconfigssection()

-------------------------------------------------------------------------------------------------------------------------------

spwn(function() 
	repeat t() until env.stuf.togglebutton
	togglebutton = env.stuf.togglebutton
end)

spwn(function() 
	env.stuf.handshaker.handshaking = true 

	while t(5) do 
		env.stuf.handshaker.requesthandshake() 
		if not env.stuf.handshaker.handshaking then 
			break 
		end 
	end 
end)

task.delay(0.6, function() 
	env.stuf.handshaker.requesthandshake() 
end)

spwn(function()
	env.funcs.recursivels("book%201/%CA%95u/%CA%94dh.lua", true)
end)

-------------------------------------------------------------------------------------------------------------------------------

return true

-------------------------------------------------------------------------------------------------------------------------------
