--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/

   Made by unable | Boxten Sex GUI (Script data)

---------------------------------------------------------------------------------------------------------------------------]]--

local version = 3

-------------------------------------------------------------------------------------------------------------------------------

-- services & instances
local t, spwn = task.wait, task.spawn
local getmmfromerr = function(userdata, f, test) local ret = nil xpcall(f, function() ret = debug.info(2, "f") end, userdata, nil, 0) if (type(ret) ~= "function") or not test(ret) then return f end return ret end
local randstring = function() local s = "" for i = 1, math.random(8, 15) do if math.random(2) == 2 then s = s .. string.char(math.random(65, 90)) else s = s .. string.char(math.random(97, 122)) end end return s end

local getins = getmmfromerr(game, function(a,b) return a[b] end, function(f) local a = Instance.new("Folder") local b = randstring() a.Name = b return f(a, "Name") == b end)
local FindFirstChildOfClass = getins(game, "FindFirstChildOfClass") 

local https = FindFirstChildOfClass(game, "HttpService")

local req = (syn and syn.request) or (http and http.request) or request

-------------------------------------------------------------------------------------------------------------------------------

local function bywiki(template)
	local encoded = "https://dandys-world-robloxhorror.fandom.com/api.php?action=parse&page=Template%3A" .. template .. "&prop=wikitext&format=json"
	local ok, response = pcall(req, {Url = encoded, Method = "GET"})
	if not ok or not response or not response.Body then return nil end
	local ok2, data = pcall(https.JSONDecode, https, response.Body)
	if not ok2 or not data or not data.parse then return nil end
	return data.parse.wikitext["*"]
end

local ToTD, toonamount, twistedamount = "???", "???", "???"
spwn(function()
	local twistedoftheday = bywiki("TOTDName")
	if twistedoftheday then ToTD = twistedoftheday:match("^%s*(.-)%s*$") end
	t(0.5)

	local toons = bywiki("ToonAmount")
	if toons then toonamount = toons:match("|(%d+)%}%}") end
	t(0.5)

	local twisteds = bywiki("TwistedAmount")
	if twisteds then twistedamount = twisteds:match("|(%d+)%}%}") end
end)

-------------------------------------------------------------------------------------------------------------------------------

local dB = {
	version = version,

	-- changelogs
	cl = {
		current = {
			version = "1.3.0",
			subversion = 1273,
			lastupdated = "Sunday, Feburary 22, 2025",

			changelog = [[
• Re-designed the UI.
• Fully re-factored and optimized the script and hopefully made it more performant.
• Renamed a few elements and updated their descriptions.
• Renamed the "Teleports" category to "Navigation".
• Removed the "Donor" section from Boxten's Section/Fun and gave it its own category. (Boxten's Section)
• Gave the script changelogs its own category. (Settings section)

• Added a "Kite distract" toggle. (Automation/Distracting)
• Added a "Kite distract island target toggle" toggle. (Automation/Distracting)
• Added a "Force stop extraction when teleporting to machine" toggle. (Automation/Teleports)
• Added a "Auto teleport to machine condition" dropdown. (Automation/Teleports)
• Added a "Auto teleport to elevator condition" dropdown. (Automation/Teleports)
• Added a "Machine aura condition" Dropdown. (Local Player/Utility)
• Added a "Auto escape Twisted Squirm" toggle + input. (Automation/Player)
• Added a "Hide machine ESP conditions" dropdown. (Environment/ESPs)
• Added a "Hover ESP" toggle. (Environment/ESPs)
• Added a "Toggle barriers" toggle. (Environment/Utility)
• Added a "Orbit player" toggle + input. (Fun/Actions)
• Added a "Adjust orbit radius" slider. (Fun/Actions)
• Added a "Adjust orbit speed" slider. (Fun/Actions)
• Added a "Autofarm priority" dropdown. (Automation/Autofarm settings)
• Added a "Item capacity limit" slider. (Automation/Autofarm settings)
• Added a "Toon ability replication" section. (Local Player)
• Added a "Access" section. (Donor)
• Added a "Actions" section. (Donor)
• Added a "Tools" section. (Donor)
• Added a "Teleports" section. (Navigation)
• Added a "Tweens" section. (Navigation)
• Added a "Pathfinding" section. (Navigation)

• Removed the "Roleplay" section from (Fun) due to all of its functions being patched.
• Removed the "Twisteds" section from (Local Player) due to most of the functions being patched.
• Removed the "Buy event sticker" button due to it requiring event currency in order for it to work.
• Removed the "Buy event skin" button due to it requiring event currency in order for it to work.

• Moved the Item, Buy, and Machine auras to (Local Player/Utility).
• Updated the list of available animations and made it so the animation target list only shows Toons that have animations that can only be applied on your current Toon.
• Moved the "Animatons" section to Boxten's Section.
• Moved the "Autofarm" section to Boxten's Section.
• Made it so the "Encounter all Twisteds" button only encounters Twisteds that haven't spotted you yet.
• Made it so the "Auto boost player extraction speed" now targets appropriate players.

• Attempted to fix an issue regarding DNS lookup, and hopefully reduced the chances of a DNSResolve error blocking the script from executing.
• Attempted to fix the script not being able to load properly on some occasions.

• Introduced Shrimpo.
• Added more messages to Poppy.
• Added an expand button to Poppy.
• Added more messages to Boxten.
• Fixed an issue where Boxten is unable to properly display or the time spent on a floor. ]]
		},
		older = {
			["1.2.9"] = {
				version = "1.2.9",
				subversions = 115,
				finaldate = "Saturday, December 30, 2025",

				changelog = [[
• Added a "Exclude Yourself" toggle. (Fun/Donor)
• Added a "Ad Barrage Script Users" button. (Fun/Donor)
• Added a "Punch Script Uers Tool" toggle. (Fun/Donor)
• Added a "Uncoordinate Script Users" toggle. (Fun/Donor)
• Added a "Notify Script Users Message" input. (Fun/Donor)
• Added a "Notify Script Users" button. (Fun/Donor)
• Added a "Stack Script Users" button. (Fun/Donor)

• Brung back the "Semi-God Mode" toggle. (Local Player/Behavior)

• Included the amount of times you've been hit while autofarming for the Webhook death embed.
• Improved the autofarm a little bit.

• Fixed the "Buy Event Sticker" button not working at all.
• Fixed the "Buy Event Skin" toggle not working at all.
• Fixed the "Noclip" toggle still not working properly for some Toons.
• Fixed the Donor functions not working at all.
• Fixed the "Anti Ice" toggle not working on some occasions.

• Attempted to fix the "Auto Heal Nearby Players" toggle not working for Ginger. ]]
			},

			["1.2.8"] = {
				finaldate = "Wednesday, December 10, 2025",
				subversions = 29,

				changelog = [[
• Added a "Exclude Blacklisted Items For "Pick Up All ..." Functions" toggle. (Settings/Script)

• Improved the autofarm a little bit.
• Updated the teleport bypass method.

• Attempted to fix the Donor functions not working at all.
• Attempted to fix the script not executing properly for Delta users. ]]
			}
		}
	},

	-- developer note
	devnote = [[]],

	-- player classes
	classes = {
		teammembers = { ""
		},
		unable = {
			"fatcosmolover", "notunaqle", "directredirect", "gayboxten", "gaybox", "gayestboxten", 
			"boxtenkeyes", "decompyler", "astrosconstellations", "boxtenwhimperaudio", "unaqle", 
			"c00lunable", "stupiddumbmusicalbox", "uwunable", "CerebralAneurysms", "trinketIess",
			"findbypropslazy", "ksuuuuuuuuuuuuuuuuvi", "eL8x94nSlddwxjX3rdPs", "apophists",
			"roblox_user_8429009562", "zestyassboxten", "ksuvee", "renophic", "ksytrict", "boxclockwork",
			"xhantist", "penqulum", "heartcloak", "boxtengexsui", "bcxten", "ichorichorichorichor"
		},
		hypnic = {
			"gaydandy", "gayastro", "parabrasque", "hyqnic", "stymuli"
		},
		qwelver = {
			"Qwelver"
		},
		autodonors = {
			"fatcosmolover", "notunaqle", "directredirect", "gayboxten", "gaybox", "gayestboxten", 
			"boxtenkeyes", "decompyler", "astrosconstellations", "boxtenwhimperaudio", "unaqle", 
			"c00lunable", "stupiddumbmusicalbox", "uwunable", "CerebralAneurysms", "trinketIess",
			"findbypropslazy", "ksuuuuuuuuuuuuuuuuvi", "eL8x94nSlddwxjX3rdPs", "apophists",
			"roblox_user_8429009562", "zestyassboxten", "ksuvee", "renophic", "ksytrict",
			"gaydandy", "gayastro", "parabrasque", "hyqnic", "stymuli", "boxclockwork", "xhantist",
			"Eva1718282", "heartcloak", "Chance_XLC", "Breadis_cool67", "husdgjhalw100", "asdasd2safwefsd",
			"blotxboxten", "boxtengexsui", "ichorichorichorichor"
		},
		blacklisted = {
			"KINGMOBMEDIA"
		}
	},

	-- animations
	animations = {
		Astro = {
			idle = "rbxassetid://112602905752015",
			walk = "rbxassetid://99830561123237",
			run = "rbxassetid://75856022532736",
			extracting = "rbxassetid://82600544001248",
			ability = "rbxassetid://86612812701056",
			quirk1 = "rbxassetid://82767619921654",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "unavailable",
			twisted_walk = "unavailable",
			twisted_run = "unavailable",
			twisted_ability = "unavailable",
			twisted_attacking = "unavailable",
			twisted_lost_interest = "unavailable",
		},
		Bassie = {
			idle = "rbxassetid://113260830809862",
			walk = "rbxassetid://132205223700091",
			run = "rbxassetid://101081520249096",
			extracting = "rbxassetid://119621623204298",
			ability = "unavailable",
			quirk1 = "rbxassetid://131560581034341",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://72811631558470",
			twisted_walk = "rbxassetid://130316854498842",
			twisted_run = "rbxassetid://80250651929564",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://86896889708382",
			twisted_lost_interest = "rbxassetid://139011044166224",

			store_sit = "rbxassetid://75597599641198"
		},
		Blot = {
			idle = "rbxassetid://73993990162132",
			walk = "rbxassetid://76703698283994",
			run = "rbxassetid://105628011122110",
			extracting = "rbxassetid://116500889072011",
			ability = "rbxassetid://87795204428993",
			quirk1 = "rbxassetid://108937676109525",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://111341564828974",
			twisted_walk = "rbxassetid://136494123759902",
			twisted_run = "rbxassetid://102718775893345",
			twisted_ability = "rbxassetid://136213222759279",
			twisted_attacking = "rbxassetid://86596451974030",
			twisted_lost_interest = "rbxassetid://113443913568233",

			dismiss_hands = "rbxassetid://99140355940646",
			twisted_quirk = "rbxassetid://90821930666498",
		},
		Bobette = {
			idle = "rbxassetid://121960921916341",
			walk = "rbxassetid://108971895466704",
			run = "rbxassetid://98111731270842",
			extracting = "rbxassetid://72425276030716",
			ability = "unavailable",
			quirk1 = "rbxassetid://123797291224009",
			quirk2 = "rbxassetid://113260134852958",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://92649757944698",
			twisted_walk = "rbxassetid://112758791648621",
			twisted_run = "rbxassetid://124902427828033",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://110457418675287",
			twisted_lost_interest = "rbxassetid://139014858392831",

			store_sit = "rbxassetid://135757794031874"
		},
		Boxten = {
			idle = "rbxassetid://95727319423093",
			walk = "rbxassetid://123141912082344",
			run = "rbxassetid://123088431322768",
			extracting = "rbxassetid://107107862171236",
			ability = "unavailable",
			quirk1 = "rbxassetid://109390279112826",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://112873555468785",
			twisted_walk = "rbxassetid://85920017605876",
			twisted_run = "rbxassetid://76555864904864",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://95375900370480",
			twisted_lost_interest = "rbxassetid://89715408307054",

			old_optimized_extracting = "rbxassetid://73586337053820"
		},
		Brightney = {
			idle = "rbxassetid://71346563606973",
			walk = "rbxassetid://121011188690718",
			run = "rbxassetid://97412580110612",
			extracting = "rbxassetid://94253339018052",
			ability = "rbxassetid://96528339507257",
			quirk1 = "rbxassetid://82252907674266",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://116170928283344",
			twisted_walk = "rbxassetid://89370863229185",
			twisted_run = "rbxassetid://86246359459049",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://100633962836877",
			twisted_lost_interest = "rbxassetid://136454867646714",
		},
		Brusha = {
			idle = "rbxassetid://120995305446330",
			walk = "rbxassetid://88042548060423",
			run = "rbxassetid://92652433020704",
			extracting = "rbxassetid://137606735770200",
			ability = "rbxassetid://136989683733742",
			quirk1 = "rbxassetid://140672190679079",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://122123246629207",
			twisted_walk = "rbxassetid://99268483331258",
			twisted_run = "rbxassetid://95016300494521",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://136331754033175",
			twisted_lost_interest = "rbxassetid://138555477963908",

			pull_out_canvas = "rbsassetid://97174260659481",
			put_away_canvas = "rbsassetid://129092207051880",
		},
		Coal = {
			idle = "rbxassetid://131700177149552",
			walk = "rbxassetid://116657137600663",
			run = "rbxassetid://75018575525754",
			extracting = "rbxassetid://128454844417288",
			ability = "unavailable",
			quirk1 = "rbxassetid://123892393885796",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://101231527013004",
			twisted_walk = "rbxassetid://132967583757528",
			twisted_run = "rbxassetid://88133391461421",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://90067465470355",
			twisted_lost_interest = "rbxassetid://130429201619542",
		},
		Cocoa = {
			idle = "rbxassetid://128300795612869",
			walk = "rbxassetid://113856775888112",
			run = "rbxassetid://112748305182855",
			extracting = "rbxassetid://1157632328364",
			ability = "rbxassetid://96543133816454",
			quirk1 = "rbxassetid://103831359026898",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://89407029329628",
			twisted_walk = "rbxassetid://124995985864941",
			twisted_run = "rbxassetid://77242325839730",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://103678252903225",
			twisted_lost_interest = "rbxassetid://70835462817471",
		},
		Connie = {
			idle = "rbxassetid://96412679901902",
			walk = "rbxassetid://71819089910283",
			run = "rbxassetid://71819089910283",
			extracting = "rbxassetid://133500601575506",
			ability = "unavailable",
			quirk1 = "rbxassetid://113665293377170",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://140696695675999",
			twisted_walk = "rbxassetid://73609609622544",
			twisted_run = "rbxassetid://81505996760447",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://123465626752220",
			twisted_lost_interest = "rbxassetid://88637009290048",
		},
		Cosmo = {
			idle = "rbxassetid://97099524343316",
			walk = "rbxassetid://95597558305842",
			run = "rbxassetid://71584405037730",
			extracting = "rbxassetid://109174138839095",
			ability = "rbxassetid://98874686617515",
			quirk1 = "rbxassetid://71701359955259",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://71318591294356",
			twisted_walk = "rbxassetid://95353122605055",
			twisted_run = "rbxassetid://107284633129144",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://131601332654193",
			twisted_lost_interest = "rbxassetid://75955446097347",
		},
		Dandy = {
			idle = "rbxassetid://88005353573809",
			walk = "rbxassetid://74214760501035",
			run = "rbxassetid://92967868773562",
			extracting = "rbxassetid://71589450143013",
			ability = "unavailable",
			quirk1 = "rbxassetid://116488437568451",

			twisted_idle = "rbxassetid://93574478063660",
			twisted_walk = "rbxassetid://137994906463591",
			twisted_run = "rbxassetid://78926641657944",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://101132930892437",
			twisted_lost_interest = "rbxassetid://89607154649004",

			store_sit = "rbxassetid://122698084348337",
			bought_from_store = "rbxassetid://132632063439293",
			bought_from_store_2 = "rbsassetid://122017642044208",
			gossipping = "rbxassetid://114972299511770",
			pulling_shop_lever = "rbxassetid://138207618683117",
			pulling_shop_lever_2 = "rbxassetid://112826066093514",
		},
		Dyle = {
			idle = "rbxassetid://77638301662090",
			walk = "rbxassetid://112567884647580",
			run = "rbxassetid://117639393329109",
			extracting = "rbxassetid://82638765867226",
			ability = "unavailable",
			quirk1 = "rbxassetid://85794703402674",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://139886336881690",
			twisted_walk = "rbxassetid://117483289959872",
			twisted_run = "rbxassetid://103691735003760",
			twisted_ability = "rbxassetid://77216203934263",
			twisted_attacking = "rbxassetid://77216203934263",
			twisted_lost_interest = "rbxassetid://112193361748129",

			twisted_slow_speed = "rbxassetid://92405825685826",
			twisted_normal_speed = "rbxassetid://86153924241292",
			twisted_fast_speed = "rbxassetid://87060532656442",
		},
		Eclipse = {
			idle = "rbxassetid://101297586465019",
			walk = "rbxassetid://80227782431048",
			run = "rbxassetid://113933928349907",
			extracting = "rbxassetid://119301286398499",
			ability = "rbxassetid://73198786877309",
			quirk1 = "rbxassetid://134729240113033",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://101719797746517",
			twisted_walk = "rbxassetid://111415947717115",
			twisted_run = "rbxassetid://111138216843634",
			twisted_ability = "rbxassetid://77203626514357",
			twisted_attacking = "rbxassetid://108473465812216",
			twisted_lost_interest = "rbxassetid://110932578991747",

			werewolf_extracting = "rbxassetid://118927755912778",
			werewolf_untransform = "rbxassetid://102315873839934",
			werewolf_transform = "rbxassetid://73198786877309",
			werewolf_transform_2 = "rbxassetid://136787270701306",
			werewolf_transform_3 = "rbxassetid://83450956736616",
		},
		Eggson = {
			idle = "rbxassetid://129628437580538",
			walk = "rbxassetid://74613594041941",
			run = "rbxassetid://140018826183412",
			extracting = "rbxassetid://71945598652324",
			ability = "rbxassetid://85753601555117",
			quirk1 = "rbxassetid://75546965724661",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://94997531878151",
			twisted_walk = "rbxassetid://70943522849975",
			twisted_run = "rbxassetid://134803511177431",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://129440980737755",
			twisted_lost_interest = "unavailable",
		},
		Finn = {
			idle = "rbxassetid://90623055577265",
			walk = "rbxassetid://136279202205935",
			run = "rbxassetid://130851351246480",
			extracting = "rbxassetid://106205750895773",
			ability = "unavailable",
			quirk1 = "rbxassetid://80290995342702",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://99343300734486",
			twisted_walk = "rbxassetid://87654208794570",
			twisted_run = "rbxassetid://99984974593681",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://131753033150717",
			twisted_lost_interest = "rbxassetid://89634188067916",
		},
		Flutter = {
			idle = "rbxassetid://114371645858993",
			walk = "rbxassetid://82362067360374",
			run = "rbxassetid://109438752615622",
			extracting = "rbxassetid://108289942108152",
			ability = "rbxassetid://104966321633572",
			quirk1 = "rbxassetid://112081529479855",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://112024138939540",
			twisted_walk = "rbxassetid://107773423382516",
			twisted_run = "rbxassetid://84147397883351",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://86392922458989",
			twisted_lost_interest = "rbxassetid://83233493108615",
		},
		Flyte = {
			idle = "rbxassetid://71907669576411",
			walk = "rbxassetid://132121208809384",
			run = "rbxassetid://98768698423249",
			extracting = "rbxassetid://80233910746374",
			ability = "rbxassetid://88091931881960",
			quirk1 = "rbxassetid://73037781965316",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://101910614628814",
			twisted_walk = "rbxassetid://102707652492072",
			twisted_run = "rbxassetid://105764212938666",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://71818321243756",
			twisted_lost_interest = "rbxassetid://116589773251470",
		},
		Gourdy = {
			idle = "rbxassetid://139969994295032",
			walk = "rbxassetid://99465780231519",
			run = "rbxassetid://72719917770090",
			extracting = "rbxassetid://112117584626127",
			ability = "rbxassetid://117040006124925",
			quirk1 = "rbxassetid://99840317570192",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://114525665778913",
			twisted_walk = "rbxassetid://73522200890405",
			twisted_run = "rbxassetid://116670910565469",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://87439143871938",
			twisted_lost_interest = "rbxassetid://106030369896751",

			grounded_angry = "rbxassetid://84135804828482",
			grounded_angry_idle = "rbxassetid://119593501335783",
			grounded_emerge = "rbxassetid://109553649381306",
			grounded_happy = "rbxassetid://122423912238311",
			grounded_idle = "rbxassetid://91883346043403",
			store_sit = "rbxassetid://135321308070083",
			gossipping = "rbxassetid://107921893312007",
			bought_from_store = "rbxassetid://131246335148028",
		},
		Gigi = {
			idle = "rbxassetid://125686660526683",
			walk = "rbxassetid://88140844483455",
			run = "rbxassetid://81385930060961",
			extracting = "rbxassetid://98963387488985",
			ability = "rbxassetid://92455041576210",
			quirk1 = "rbxassetid://97537374452563",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://89379060070412",
			twisted_walk = "rbxassetid://86154965787827",
			twisted_run = "rbxassetid://94852327969050",
			twisted_ability = "rbxassetid://116643929725729",
			twisted_attacking = "rbxassetid://106872927462435",
			twisted_lost_interest = "rbxassetid://94052243014703",
		},
		Ginger = {
			idle = "rbxassetid://85220873784968",
			walk = "rbxassetid://79443874564334",
			run = "rbxassetid://73716601731008",
			extracting = "rbxassetid://76382478901588",
			ability = "rbxassetid://84809804057554",
			quirk1 = "rbxassetid://136714856551357",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://82455189191938",
			twisted_walk = "rbxassetid://87274628660556",
			twisted_run = "rbxassetid://75137556095690",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://137520427453859",
			twisted_lost_interest = "rbxassetid://131331420784709",
		},
		Glisten = {
			idle = "rbxassetid://102101190927539",
			walk = "rbxassetid://123057882391547",
			run = "rbxassetid://139284491533724",
			extracting = "rbxassetid://113939057860845",
			ability = "rbxassetid://133111515917934",
			quirk1 = "rbxassetid://91776423337906",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://139032602395740",
			twisted_walk = "rbxassetid://99163528213976",
			twisted_run = "rbxassetid://121947942763776",
			twisted_ability = "rbxassetid://72252889967512",
			twisted_attacking = "rbxassetid://109837193619675",
			twisted_lost_interest = "rbxassetid://73762238611008",

			twisted_enraged_movement = "rbxassetid://106872925454867",
		},
		Goob = {
			idle = "rbxassetid://73747645695432",
			walk = "rbxassetid://80575668298605",
			run = "rbxassetid://122049167943521",
			extracting = "rbxassetid://80142292252154",
			ability = "rbxassetid://77747170232741",
			quirk1 = "rbxassetid://116117556022601",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://96656148743605",
			twisted_walk = "rbxassetid://73924035862251",
			twisted_run = "rbxassetid://89452606547339",
			twisted_ability = "rbxassetid://136163891093842",
			twisted_attacking = "rbxassetid://94889513327752",
			twisted_lost_interest = "rbxassetid://72957690481481",
		},
		Looey = {
			idle = "rbxassetid://78197156369403",
			walk = "rbxassetid://124245470232056",
			run = "rbxassetid://131545440842534",
			extracting = "rbxassetid://124702329627784",
			ability = "unavailable",
			quirk1 = "rbxassetid://103731301723965",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://112606771950932",
			twisted_walk = "rbxassetid://100370803921306",
			twisted_run = "rbxassetid://131136472849981",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://110454030222904",
			twisted_lost_interest = "rbxassetid://101633908025346",
		},
		Pebble = {
			idle = "rbxassetid://94925084807494",
			walk = "rbxassetid://108621188713265",
			run = "rbxassetid://82078521925458",
			extracting = "rbxassetid://130124125865280",
			ability = "unavailable",
			quirk1 = "rbxassetid://81686244378448",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://86668456413735",
			twisted_walk = "rbxassetid://88523747432650",
			twisted_run = "rbxassetid://108053760580353",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://92392240437202",
			twisted_lost_interest = "rbxassetid://131291463687727",
		},
		Poppy = {
			idle = "rbxassetid://104172965206178",
			walk = "rbxassetid://94095022971268",
			run = "rbxassetid://116891220692511",
			extracting = "rbxassetid://84268683127401",
			ability = "unavailable",
			quirk1 = "rbxassetid://114447599656041",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "unavailable",
			twisted_walk = "unavailable",
			twisted_run = "unavailable",
			twisted_ability = "unavailable",
			twisted_attacking = "unavailable",
			twisted_lost_interest = "unavailable",
		},
		Razzle = {
			idle = "rbxassetid://123101626847955",
			walk = "rbxassetid://139284449676655",
			run = "rbxassetid://131008610884429",
			extracting = "rbxassetid://105816926501555",
			ability = "rbxassetid://78564750414534",
			quirk1 = "rbxassetid://77597199950787",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://130925049770009",
			twisted_walk = "rbxassetid://134459370783019",
			twisted_run = "rbxassetid://105388242822572",
			twisted_ability = "rbxassetid://75665313695744",
			twisted_attacking = "rbxassetid://115004983183813",
			twisted_lost_interest = "rbxassetid://127985997430283",
		},
		Dazzle = {
			idle = "rbxassetid://123101626847955",
			walk = "rbxassetid://109753602785063",
			run = "rbxassetid://134714665469933",
			extracting = "rbxassetid://117093472408004",
			ability = "rbxassetid://78564750414534",
			quirk1 = "rbxassetid://106726185123532",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://130925049770009",
			twisted_walk = "rbxassetid://134459370783019",
			twisted_run = "rbxassetid://105388242822572",
			twisted_ability = "rbxassetid://75665313695744",
			twisted_attacking = "rbxassetid://115004983183813",
			twisted_lost_interest = "rbxassetid://127985997430283",
		},
		Rodger = {
			idle = "rbxassetid://116632192663655",
			walk = "rbxassetid://125823000111969",
			run = "rbxassetid://72255967621198",
			extracting = "rbxassetid://96274777168731",
			ability = "rbxassetid://91214158723001",
			quirk1 = "rbxassetid://133972153975384",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://89337725074329",
			twisted_walk = "unavailable",
			twisted_run = "unavailable",
			twisted_ability = "rbxassetid://136059017878028",
			twisted_attacking = "rbxassetid://132435956907061",
			twisted_attacking_loop = "rbxassetid://132435956907061",
			twisted_lost_interest = "rbxassetid://82436298975081",
			point = "rbxassetid://110515751665050",
		},
		Ribecca = {
			idle = "rbxassetid://125992632625452",
			walk = "rbxassetid://118986232555393",
			run = "rbxassetid://106122176927729",
			extracting = "rbxassetid://77346006959018",
			ability = "rbxassetid://82114603220952",
			quirk1 = "rbxassetid://132107930977833",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://84437851746964",
			twisted_walk = "rbxassetid://130481155732477",
			twisted_run = "rbxassetid://91775713305430",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://88021882835969",
			twisted_lost_interest = "rbxassetid://103728669948918",
		},
		Rudie = {
			idle = "rbxassetid://80667484406688",
			walk = "rbxassetid://89752421989409",
			run = "rbxassetid://139414767968411",
			extracting = "rbxassetid://95207747046768",
			ability = "rbxassetid://82114603220952",
			quirk1 = "rbxassetid://81015322214585",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://122501058377674",
			twisted_walk = "rbxassetid://94861044577621",
			twisted_run = "rbxassetid://137822127469681",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://100664979016648",
			twisted_lost_interest = "rbxassetid://102004443378644",
		},
		Scraps = {
			idle = "rbxassetid://134272548635232",
			walk = "rbxassetid://103105474019093",
			run = "rbxassetid://112111022093091",
			extracting = "rbxassetid://76886834369462",
			ability = "rbxassetid://81986487044485",
			quirk1 = "rbxassetid://128830992461003",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://139174267105577",
			twisted_walk = "rbxassetid://111821488545412",
			twisted_run = "rbxassetid://88088648590918",
			twisted_ability = "rbxassetid://83822564195417",
			twisted_attacking = "rbxassetid://104485969907637",
			twisted_lost_interest = "rbxassetid://118414700001108",
		},
		Soulvester = {
			idle = "rbxassetid://87619555490099",
			walk = "rbxassetid://70520238008961",
			run = "rbxassetid://133253678576937",
			extracting = "rbxassetid://109213385520053",
			ability = "unavailable",
			quirk1 = "rbxassetid://89104814329436",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://71954249296679",
			twisted_walk = "rbxassetid://124588738513012",
			twisted_run = "rbxassetid://79814961469926",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://119816191964033",
			twisted_lost_interest = "rbxassetid://124357795496043",
		},
		Shelly = {
			idle = "rbxassetid://81739221582887",
			walk = "rbxassetid://97569421338492",
			run = "rbxassetid://87952146739155",
			extracting = "rbxassetid://110404137593348",
			ability = "rbxassetid://132074253259163",
			quirk1 = "rbxassetid://82843565036740",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "unavailable",
			twisted_walk = "unavailable",
			twisted_run = "unavailable",
			twisted_ability = "unavailable",
			twisted_attacking = "unavailable",
			twisted_lost_interest = "unavailable",
		},
		Shrimpo = {
			idle = "rbxassetid://104855983361844",
			walk = "rbxassetid://83797003369894",
			run = "rbxassetid://118408617438325",
			extracting = "rbxassetid://82115028837237",
			ability = "unavailable",
			quirk1 = "rbxassetid://118596195257950",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://116481247301256",
			twisted_walk = "rbxassetid://111132998582131",
			twisted_run = "rbxassetid://99355157689749",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://85919717023303",
			twisted_lost_interest = "rbxassetid://101562397422358",
		},
		Sprout = {
			idle = "rbxassetid://115089547773515",
			walk = "rbxassetid://71337605453012",
			run = "rbxassetid://124716518938445",
			extracting = "rbxassetid://107578580990867",
			ability = "rbxassetid://119810008227544",
			quirk1 = "rbxassetid://89427258175304",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://120388640080430",
			twisted_walk = "rbxassetid://127806534408120",
			twisted_run = "rbxassetid://126212244949811",
			twisted_ability = "rbxassetid://112281460011580",
			twisted_attacking = "rbxassetid://128710825378720",
			twisted_lost_interest = "rbxassetid://100966930839128",
		},
		Squirm = {
			idle = "unavailable",
			walk = "unavailable",
			run = "unavailable",
			extracting = "unavailable",
			ability = "unavailable",
			quirk1 = "unavailable",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "unavailable",
			twisted_walk = "unavailable",
			twisted_run = "unavailable",
			twisted_ability = "unavailable",
			twisted_attacking = "unavailable",
			twisted_lost_interest = "unavailable",
		},
		Teagan = {
			idle = "rbxassetid://92977796659755",
			walk = "rbxassetid://85177977707813",
			run = "rbxassetid://119824713441123",
			extracting = "rbxassetid://99386595014319",
			ability = "rbxassetid://112095063596532",
			quirk1 = "rbxassetid://136373988219558",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://123449196305388",
			twisted_walk = "rbxassetid://125197415920586",
			twisted_run = "rbxassetid://81307173524862",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://138990728557079",
			twisted_lost_interest = "rbxassetid://135123155720084",
		},
		Tisha = {
			idle = "rbxassetid://97897013860675",
			walk = "rbxassetid://121018887759941",
			run = "rbxassetid://109515193459041",
			extracting = "rbxassetid://73194617893805",
			ability = "rbxassetid://120724675605411",
			quirk1 = "rbxassetid://114872199014464",
			quirk2 = "rbxassetid://85238767773454",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://73852763320187",
			twisted_walk = "rbxassetid://71239402554532",
			twisted_run = "rbxassetid://77777629677290",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://120156200738056",
			twisted_lost_interest = "rbxassetid://138223746048751",
		},
		Toodles = {
			idle = "rbxassetid://115248574081941",
			walk = "rbxassetid://86131025925458",
			run = "rbxassetid://115447780832387",
			extracting = "rbxassetid://138471228217526",
			ability = "rbxassetid://81541930770593",
			quirk1 = "rbxassetid://74987639793755",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://114626600596441",
			twisted_walk = "rbxassetid://95061902377153",
			twisted_run = "rbxassetid://106522945418088",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://126192309051074",
			twisted_lost_interest = "rbxassetid://98808060374554",
		},
		Vee = {
			idle = "rbxassetid://87154718270671",
			walk = "rbxassetid://97897738117999",
			run = "rbxassetid://72678141337718",
			extracting = "rbxassetid://106108686337103",
			ability = "rbxassetid://93283143418307",
			quirk1 = "rbxassetid://81440563810050",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://121275292923999",
			twisted_walk = "rbxassetid://140422342173966",
			twisted_run = "rbxassetid://73725947198210",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://122320701385700",
			twisted_lost_interest = "rbxassetid://123014360614322",
		},
		Yatta = {
			idle = "rbxassetid://94672939370149",
			walk = "rbxassetid://113493276030799",
			run = "rbxassetid://121887597056169",
			extracting = "rbxassetid://81195350931735",
			ability = "unavailable",
			quirk1 = "rbxassetid://120524896657767",
			quirk2 = "unavailable",
			quirk3 = "unavailable",

			twisted_idle = "rbxassetid://118127032092109",
			twisted_walk = "rbxassetid://130346494434784",
			twisted_run = "rbxassetid://104220653814120",
			twisted_ability = "unavailable",
			twisted_attacking = "rbxassetid://97409614067549",
			twisted_lost_interest = "rbxassetid://136414501780962",
		}
	},

	-- other external info
	wiki = {
		twistedoftheday = ToTD,
		tooncount = toonamount,
		twistedcount = twistedamount
	}
}

-------------------------------------------------------------------------------------------------------------------------------

return dB

-------------------------------------------------------------------------------------------------------------------------------
