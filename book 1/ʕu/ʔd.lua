--[[---------------------------------------------------------------------------------------------------------------------------
  __   __     ______     __  __     __     ______     __  __     ______    
 /\ "-.\ \   /\  __ \   /\_\_\_\   /\ \   /\  __ \   /\ \/\ \   /\  ___\   
 \ \ \-.  \  \ \ \/\ \  \/_/\_\/_  \ \ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  
  \ \_\\"\_\  \ \_____\   /\_\/\_\  \ \_\  \ \_____\  \ \_____\  \/\_____\ 
   \/_/ \/_/   \/_____/   \/_/\/_/   \/_/   \/_____/   \/_____/   \/_____/
   
   Made by Team Noxious -- Boxten Sex GUI [Dialogue]
   
---------------------------------------------------------------------------------------------------------------------------]]--

-- cringe warning lmfao
local dialogue = {}
dialogue.version = 2

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

-- BSGUI boxten: sullen, sarcastic, satirical, passive-aggressive, but nice sometimes ig idk
dialogue.boxten = {
	mainsection = {
		randomlobbymessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		misexecutionmessages = {
			"wrong game, bud.",
			"im not sure if this was an accident on your end, but this script was only built for Dandy's World.",
		},

		randomrunmessages = {
			itemnear = {
				"theres a& {item} over there. you should take it, it could be useful in the future, maybe.",
				"{item}. {direction}.",
			},

			machinenear = {
				"theres an incomplete machine {direction}, buddy. claim it before someone else does.",
				"machine. {direction}.",
			},

			twistednear = {
				walkinginyourdirection = {
					"i hate to be the bearer of all things bad, but {twisted} is walking towards your direction.",
					"hey, get to moving. {twisted} is walking towards you.",
					"{direction}! {twisted}s gonna get you!",
				},

				isnear = {
					"watch out.",
					"incoming!!",
					"hey, hey, hey. are you spatially unaware?",
				}
			},

			playernear = {
				walkedpast = {
					"wheres {player} runnin off to?"
				},

				idlingnearyou = {
					"what is {player} looking at.",
					"i dont like how {player}& lookin at you like that.",
					"got a problem, {player}?",
				},

				walkingtowardsyou = {
					"{player}& here. say hi!",
					"looks like {player} wants to tell you something.",
				},

				hastwistedsgathered = {
					"could {player} be trying to grief you?",
					"{player} should be more careful about where theyre taking these Twisteds.",
					"what is {player} doing?",
				}
			}
		},

		runjoinedmessages = {
			whenvoting = {
				"pick a Toon to play as for the remainder of this run until you die. its that simple!",
				"a run is starting. im so excited. whoo.",
			},

			started = {
				"good luck out there.",
				"alright, the time has come. dont let me down.",
				"lets hope you dont die at floor " .. math.random(3, 15) .. ".",
				"blackout on floor " .. math.random(6, 20) .. ", im calling it.",
				"you will NOT fail me, alright?",
				"make sure to give every Twisted you encounter a kiss before returning to the elevator.",
				"new run, new you... if that makes sense. probably doesnt. i dont care.",
			}
		},

		damagedmessages = {
			inlessthan20seconds = {
				"not even 20 seconds in and youve already gotten yourself hit? thats kinda pathetic.",
				"youve gotta be kidding me.",
				"dude. you have EXPLOITS. you are using an EXPLOIT SCRIPT. USE IT!!!",
				"you suck. you are the mere definition of terrible.",
				"skill issue tbh.",
			},

			ononeheart = {
				"woah, woah, woah. dont die on me now.",
				"1 heart. dont die now, man.",
				"one more hit and youre done for.",
				"maybe its time to use a medkit or a bandage, if you have one.",
				"that cant be good.",
				"lock the fuck in, bro. what is you doing?",
				"what the hell are you doing?",
				"aye bruh, now you really gotta be careful twin.",
				"dude, come on. youre better than this.",
			},

			regular = {
				"its just a scratch, youll walk it off.",
				"damn, are you gonna let that slide?",
				"be careful next time.",
				"on my Toon Handler's life {twisted} was nowhere near you.",
				"are you kidding me?",
				"wow! that was exceptionally stupid!",
				"HEY! i know youre better than that.",
				"get a move on, will ya?",
				"are you playing on {ping} or something? what was THAT!?",
				"if i see that again im resetting your data. NO excuse for what just happened.",
				"you playing tag with the Twisteds or something? sounds fun.",
				"not sure if you already know about this, but the Twisteds arent your friends. their goal is to kill you.",
				"its alright, everyone makes mistakes. try to find something or someone that can heal you.",
			},

			bylowerclasstwisted = {
				"ahh, {twisted}, eh? they piss me off sometimes.",
				"really? youre just gonna let {twisted} fuck you up like that?",
			},

			bymaintwisted = {
				"ouch. i felt that.",
				"be more careful next time.",
				"good thing {twisted} isnt a Lethal or that wouldve ended badly.",
			},

			byblotshand = {
				"watch where youre going.",
				"maybe its time to get your eyes checked.",
				"whoopsie daisy!",
			},

			bysproutstendril = {
				"these tendrils always piss me the fuck off.",
				"quick! grab it and bite it. hopefully Twisted Sprout can feel it and starts crying in pain and agony as you bite deeper into his tendril until youve managed to fully tear off a part of it.",
			},

			byconnie = {
				"i... dont have any words.",
				"LOCK THE FUCK IN!!!",
				"are you fucking kidding me? for the love of god, PLEASE enable ESP.",
			},

			bygoob = {
				"damn. that was unexpected.",
				"Twisted Goob's about to grab you! im totally not saying this right after you got hit by him!",
			},

			byscraps = {
				"daaaamn, you got sniped.",
				"shouldve seen the glare.",
			},

			byrazzleanddazzle = {
				"watch where youre going next time.",
				"dude? are you okay? what the hell are you doing?",
			},

			hitbutignoringhealininventory = {
				"you should have used that {heal} earlier.",
				"hey, dude. im convinced that youre blind. you have a {heal}. use it.",
			},

			hitbutignoringhealonfloor = {
				"that {heal} on the floor is literally calling out for your name.",
				"oh nooo, you got hit... but dont worry! {heal}-on-the-floor-kun will save you! it cant move, though, so youre gonna have to walk towards it and pick it up.",
			},

			hitandbassiepresentwithheal = {
				"hey, you should ask Bassie for that {heal} she has in her inventory.",
				"good thing Bassie has a {heal}! you should probably ask for it if youre willing to.",
			}
		},

		diedmessages = {
			infloorlessthan3 = {
				"wow. that was... wow.",
				"you suck at this game, even with exploits.",
				"thats hella embarrassing!",
				"seriously? your dumbass couldnt even get past 3 floors?",
				"how can you be this bad?",
				"youre playing a prank on me... right?",
			},

			regular = {
				"feelsbadman.",
				"Smart thinking!",
				"youre terrible at this.",
				"that wasnt supposed to happen!",
				"hey, its alright, everyone makes mistakes. just kidding, youre horrible.",
				"really!? all you had to do was not die!",
				"pathetic, how could you do this to yourself?",
			},

			bylowerclasstwisted = {
				"ouch, unlucky.",
				"damn. by {twisted} too?, pfft...",
				"you should try harder next time.",
				"me, personally, i would have gotten out of {twisted}& path and avoided them at all costs in order to not die.",
				"dont worry. i also think that {twisted}& a huge pain in the ass sometimes.",
			},

			bymaintwisted = {
				"lol.",
				"them main Twisteds aint shit...",
				"{twisted}? theyre easy to manage. try harder.",
			},

			bylethaltwisted = {
				"hey, dont worry. you can visit {twisted} back in the lobby in their normal forms and start beating their asses for killing you.",
				"{twisted} is a Lethal, and can kill you in just one shot, in case you were wondering.",
			},

			byblotshand = {
				"pffft, ha ha!",
				"yeah, good going, noooooooob.",
			},

			bysproutstendril = {
				"classic.",
				"im not even gonna flame you for dying to Twisted Sprout's tendril. hes annoying as shit.",
			},

			byconnie = {
				"there are over 130000 words in the english dictionnary and none of them can describe the amount of.. idiocracy ive had to witness.",
				"out of all the idiotic ways you could have died...",
				"youre playing a prank on me... right?",
			},

			bygoob = {
				"looks like he hugged you a little too hard.",
				"and all you had to do was get out of Twisted Goob's line of sight.",
			},

			byscraps = {
				"lmfaoooo you just got 360 noscoped by Twisted Scraps!!!",
				"and all you had to do was get out of Twisted Scraps' line of sight.",
			},

			byrazzleanddazzle = {
				"not the stupidest death ive seen, but hey.",
				"ooooops...",
			},

			diedandignoredhealmessages = {
				"did you not notice the {heal} in your inventory?",
				"you know... you could have healed yourself... using an item that was in your inventory...",
			},

			diedandhasanondeathoptiontoggled = {
				"welp, see ya dude.",
				"back to the lobby you go!",
			},

			diedbecausepanictimerranout = {
				"too late!",
				"damn. and you were SOOOOO close to the elevator.",
				"run faster next time.",
			}
		},

		spottedmessages = {
			byregular = {
				"looks like {twisted} wants to give you a hug. stick your arms out and run towards them!",
				"dont flip out, but {twisted} is chasing you.",
				"AHHHHHHHHH!!! {twisted} IS CHASING YOU!!! YOURE GONNA DIE!!!",
				"quickly! get out of {twisted}& sight before they getcha!",
				"youre probably gonna want to start moving or {twisted}& gonna touch you.",
				"{twisted}& coming for you!",
				"uh oh, {twisted}& chasing ya?",
				"{twisted}& boutta give you a fade.",
				"{twisted} has a knuckle sandwich prepared for ya.",
			},

			bylethal = {
				"oh shoot. {twisted}& coming for you. HIDE!!!",
				"OH MY GOD ITS- oh. its {twisted}? yeah, theyre harmless.",
				"{twisted}& gonna TOUCH you!",
			}
		},

		machinecompletedmessages = {
			byuser = {
				"nice. {machinesleft} left to go.",
				"that was light work. {machinesleft} left.",
				"hey, good job, man.",
				"{machinesleft} left!!!",
				"one less machine left to go.",
			},

			bysomeoneelse = {
				"only {machinesleft} machines left to go.",
				"{machinesleft} machines left! im so excited!",
				"woohoo. wow. {machinesleft} machines left to complete. yay. im so happy. im jumping for joy.",
				"{machinesleft} machines left. you got this!",
			},
		},

		failedskillcheckmessages = {
			alertedtwisted = {
				"idiot. you caught {twisted}& attention.",
				"maybe its time to turn on auto calibration in the automation section.",
				"oh come on. it cant be that heard.",
				"{twisted} wants in on the fun.",
			},

			indylesfloor = {
				"ahhhh, you asked for it.",
				"quick, turn on noclip and clip into an object!",
				"you IDIOT! youre gonna get yourself KILLED!!!",
			}
		},

		floorloadedmessages = {
			healsonthefloorandlow = {
				"oh hey, a {item} is on the floor, and youre on {health}. you should take it and use it.",
				"nice, theres a {item}. but you dont need it, do you?",
				"are you gonna be greedy and take that {item} while- uhhh, umm, uhhhhh...",
			},

			rareitemonthefloor = {
				"cool, a& {item}.",
				"hey, look at that, a& {item} is on the floor.",
			},

			mainonthefloor = {
				"ooh, {twisted}? good luck dude.",
				"nice, a main Twisted.",
				"{twisted} is easy to manage anyway.",
			},

			dandyinthefloor = {
				"uh oh. that cant be good.",
				"hey, tell him that im sorry for all the things ive said... not.",
				"well, well, well. look who it is.",
			},

			ichorleak = {
				"what could that sound possibly mean?",
				"pipes busted. just dont walk on the puddles.",
				"sounds like one of the Twisteds couldnt hold it in... eugh... you know what actually? forget i ever said that.",
			},

			regular = {
				"this floor cant be that bad.",
				"alright, pretty normal-looking floor.",
				"this floor is gonna be boring, thats for sure.",
			}
		},

		elevatorrelatedmessages = {
			opened = {
				blackout = {
					"that cant be good.",
					"who turned out the lights?",
					"who the HELL flipped the light switch!?",
					"looks like Delilah and Arthur didnt pay for the electric bills.",
					"hey? where is everyone? hello? where did that lights go?",
					"dont worry, the lights are sound-activated. just clap twice and itll turn on again.",
				},

				dylesfloor = {
					"welp, good luck out there.",
					"25 machines to complete...",
					"alright, just dont fail a skillcheck.",
				},

				regular = {
					"get out there and dont die! there will be consequences.",
					"alright, listen up. plan A is complete this floor, and plan B is to not mess up plan A. got it?",
					"okay, heres the plan: just survive! its that easy.",
					"take care of this quickly.",
					"try running into a Twisted, it gives you a rare item, i think.",
				}
			},

			closed = {
				multiplepeopledied = {
					"what the hell were they thinking?",
					"NOOOOOOOOOOOBS!!!",
					"Smart thinking!",
				},

				endedquickly = {
					"god damn dude, are you doing a fucking speedrun? that floor lasted {time}.",
					"{time}? im posting this to speedrun.com.",
					"world record pace over here.",
					"breezed through that floor like it was nothing.",
					"that floor lasted {time}! hey, great job!",
					"damn, i gotta say, that was very quick.",
					"you put on a good show out there, congratulations.",
					"ive gotta say, that is some excellent work.",
					"great work out there. you did exceptionally well.",
				},

				reasonabletime = {
					"glad thats over with.",
					"awesome. you made it out alive.",
					"that took you {time}. not bad.",
					"in surprised you made it out alive. i mean, you arent bad, youre just-, you-, you know what? nevermind. good job.",
					"*sniffs* im so proud of you, you did so good out there.",
					"ive gotta say, that is some excellent work.",
					"nice work out there, that was actually worth my time.",
					"wow, that was great. you should take a screenshot, print it out and hang it on your fridge for your mom to see.",
					"you put on a good show out there, congratulations.",
				},

				toolong = {
					"{time}? that dragged on...",
					"was the floor really that hard to the point where it took you {time} to get past?",
					"uncommon Dandy's World slowrun.",
					"did it seriously take you {time}? man yall are slow as fuck.",
					"its about time. nearly fell asleep over here! good job anyway, get ready for the next floor.",
				},

				waytoolong = {
					"{time}... did you fall asleep or something?",
					"theres no reason for that floor lasting {time}.",
					"that floor lasted a fucking decade.",
					"FINALLY!!!",
				}
			},

			dandysstock = {
				regular = {
					"take that {randitem} and shove it up his ass.",
					"take that {randitem} and shove it down his throat.",
					"take that {randitem} and shove it up his... nose..?",
					"you should probably buy that {randitem}. youll need it for later, maybe.",
					"you got a large selection of items over there at Dandy's Shop.. and by large selection, i mean 3.",
					"i think you should rip Dandy's petals off and force feed them to his pet rock because of the items hes selling us. i mean, come on. a {randitem}?",
					"does he have anything useful to sell to us? i mean, hes selling a {item1}, a {item2}, and a {item3}.",
					"{item1}, {item2}, and a {item3}. decent items, i guess.",
					"hello again, Dandy. got any actual useful items to sell?",
				},

				usefulitems = {
					"heeeey. a {randitem}! thanks Dandy!",
					"i knew you could provide us with good items!",
					"see Dandy, was it that hard?",
				},

				sameitemsforallslots = {
					"woah, what are the chances?",
					"three {item1}&, haha.",
				},

				alluselessitems = {
					"Dandy, if you sell us that {randitem} one more damn time, i swear to god im gonna shove my foot up your ass. with your consent, of course.",
					"selling us more useless slop again? classical.",
				}
			}
		},

		panicmodemessages = {
			started = {
				"run to the elevator!",
				"its about time. get to the elevator.",
				"last machines done. get your fat ass to the elevator or DIE!",
				"quick, stay still and do nothing!",
				"you better start running towards the elevator, or you will suffer consequences.",
			},

			hurryup = {
				"hey, ya there? hurry up.",
				"what are you waiting for, dude? get to the elevator!",
				"chop chop, motherfucker, them legs aint gon walk themselves to the elevator.",
			},

			hurrythehellup = {
				inelevatorbutsomeonestillout = {
					"{player}, PLEASE, FOR THE LOVE OF GOD, GET THE FUCK IN THE ELEVATOR.",
					"im boutta beat the shit out of {player}.",
					"WHAT IS {player} DOING!?",
				},

				stillout = {
					"dude. youre about to fucking die.",
					"are you blind? the elevators gonna close and youre gonna die.",
					"HURRY UP!!!",
				}
			}
		},

		someonedamagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someonediedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		usedabilityonsomeone = {
			healedthem = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedtheirextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredtheirstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someoneusedabilityonyou = {
			healedyou = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedyourextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredyourstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		}
	},

	commandssection = {
		randomcommandmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		commandclicked = {
			wholecommand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			includealias = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandexecuted = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			invalidarguments = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandsuggestions = {
			whendamaged = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			blackout = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		}
	},

	configssection = {
		randomconfigmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		configsaved = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		configloaded = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		autoconfigset = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			set = {
				lobby = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				run = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				roleplay = {
					"thequickbrownfoxjumpsoverthelazydog"
				},
			},
		}
	}
}

-------------------------------------------------------------------------------------------------------------------------------

-- boxten (SC-004): shy, nervous, pessimistic (?), anxious, stutters sometimes
dialogue.altboxten = {
	mainsection = {
		randomlobbymessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		misexecutionmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		randomrunmessages = {
			itemnear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			machinenear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			twistednear = {
				walkinginyourdirection = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				isnear = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			playernear = {
				walkedpast = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				idlingnearyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				walkingtowardsyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				hastwistedsgathered = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		runjoinedmessages = {
			whenvoting = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		damagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealininventory = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealonfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitandbassiepresentwithheal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		diedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandignoredhealmessages = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandhasanondeathoptiontoggled = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		spottedmessages = {
			byregular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		machinecompletedmessages = {
			byuser = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysomeoneelse = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		},

		failedskillcheckmessages = {
			alertedtwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			indylesfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		floorloadedmessages = {
			healsonthefloorandlow = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			rareitemonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			mainonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			dandyinthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ichorleak = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		elevatorrelatedmessages = {
			opened = {
				blackout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				dylesfloor = {
					"thequickbrownfoxjumpsoverthelazydog"					
				},

				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			closed = {
				multiplepeopledied = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				endedquickly = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				reasonabletime = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				toolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				waytoolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			dandysstock = {
				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				usefulitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				sameitemsforallslots = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				alluselessitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		panicmodemessages = {
			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurryup = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurrythehellup = {
				inelevatorbutsomeonestillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				stillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		someonedamagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someonediedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		usedabilityonsomeone = {
			healedthem = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedtheirextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredtheirstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someoneusedabilityonyou = {
			healedyou = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedyourextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredyourstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		}
	},

	commandssection = {
		randomcommandmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		commandclicked = {
			wholecommand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			includealias = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandexecuted = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			invalidarguments = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandsuggestions = {
			whendamaged = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			blackout = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		}
	},

	configssection = {
		randomconfigmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		configsaved = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		configloaded = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		autoconfigset = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			set = {
				lobby = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				run = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				roleplay = {
					"thequickbrownfoxjumpsoverthelazydog"
				},
			},
		}
	}
}

-------------------------------------------------------------------------------------------------------------------------------

-- poppy (SC-003): confident, optimistic, loud and fuckin proud
dialogue.poppy = {
	mainsection = {
		randomlobbymessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		misexecutionmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		randomrunmessages = {
			itemnear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			machinenear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			twistednear = {
				walkinginyourdirection = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				isnear = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			playernear = {
				walkedpast = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				idlingnearyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				walkingtowardsyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				hastwistedsgathered = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		runjoinedmessages = {
			whenvoting = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		damagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealininventory = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealonfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitandbassiepresentwithheal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		diedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandignoredhealmessages = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandhasanondeathoptiontoggled = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		spottedmessages = {
			byregular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		machinecompletedmessages = {
			byuser = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysomeoneelse = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		},

		failedskillcheckmessages = {
			alertedtwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			indylesfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		floorloadedmessages = {
			healsonthefloorandlow = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			rareitemonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			mainonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			dandyinthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ichorleak = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		elevatorrelatedmessages = {
			opened = {
				blackout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				dylesfloor = {
					"thequickbrownfoxjumpsoverthelazydog"					
				},

				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			closed = {
				multiplepeopledied = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				endedquickly = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				reasonabletime = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				toolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				waytoolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			dandysstock = {
				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				usefulitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				sameitemsforallslots = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				alluselessitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		panicmodemessages = {
			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurryup = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurrythehellup = {
				inelevatorbutsomeonestillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				stillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		someonedamagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someonediedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		usedabilityonsomeone = {
			healedthem = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedtheirextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredtheirstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someoneusedabilityonyou = {
			healedyou = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedyourextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredyourstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		}
	},

	commandssection = {
		randomcommandmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		commandclicked = {
			wholecommand = {
				"Executing \"{command}\" {commanddesc}!",
				"Running \"{command}\" {commanddesc}!",
				"The \"{command}\" command {commanddesc}!",
			},

			includealias = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandexecuted = {
			empty = {
				"You forgot to input a command, silly!",
				"I don't think \"\" is a command!",
				"You have to type something in the command bar first!"
			},

			notfound = {
				"I couldn't find \"{input}\" in the list of commands... Try checking your spelling!",
				"Looks like \"{command}\" isn't a valid command..!",
				"I don't remember \"{command}\" being in our list of commands!",
			},

			invalidarguments = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandsuggestions = {
			whendamaged = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			blackout = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		}
	},

	configssection = {
		randomconfigmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		configsaved = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		configloaded = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		autoconfigset = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			set = {
				lobby = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				run = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				roleplay = {
					"thequickbrownfoxjumpsoverthelazydog"
				},
			},
		}
	}
}

-------------------------------------------------------------------------------------------------------------------------------

-- shrimpo (SC-001): constantly shouting, rude, short-tempered, abrasive, arrogant
dialogue.shrimpo = {
	mainsection = {
		randomlobbymessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		misexecutionmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		randomrunmessages = {
			itemnear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			machinenear = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			twistednear = {
				walkinginyourdirection = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				isnear = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			playernear = {
				walkedpast = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				idlingnearyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				walkingtowardsyou = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				hastwistedsgathered = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		runjoinedmessages = {
			whenvoting = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		damagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealininventory = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitbutignoringhealonfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hitandbassiepresentwithheal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		diedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandignoredhealmessages = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedandhasanondeathoptiontoggled = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		spottedmessages = {
			byregular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethal = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		machinecompletedmessages = {
			byuser = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysomeoneelse = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		},

		failedskillcheckmessages = {
			alertedtwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			indylesfloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		floorloadedmessages = {
			healsonthefloorandlow = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			rareitemonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			mainonthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			dandyinthefloor = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ichorleak = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		elevatorrelatedmessages = {
			opened = {
				blackout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				dylesfloor = {
					"thequickbrownfoxjumpsoverthelazydog"					
				},

				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			closed = {
				multiplepeopledied = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				endedquickly = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				reasonabletime = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				toolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				waytoolong = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			},

			dandysstock = {
				regular = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				usefulitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				sameitemsforallslots = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				alluselessitems = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		panicmodemessages = {
			started = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurryup = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			hurrythehellup = {
				inelevatorbutsomeonestillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				stillout = {
					"thequickbrownfoxjumpsoverthelazydog"
				}
			}
		},

		someonedamagedmessages = {
			inlessthan20seconds = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			ononeheart = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someonediedmessages = {
			infloorlessthan3 = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			regular = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylowerclasstwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bymaintwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bylethaltwisted = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byblotshand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bysproutstendril = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byconnie = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			bygoob = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byscraps = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			byrazzleanddazzle = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			diedbecausepanictimerranout = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		usedabilityonsomeone = {
			healedthem = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedtheirextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredtheirstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		someoneusedabilityonyou = {
			healedyou = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			boostedyourextractionspeed = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			restoredyourstamina = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		}
	},

	commandssection = {
		randomcommandmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		commandclicked = {
			wholecommand = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			includealias = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandexecuted = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			invalidarguments = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		commandsuggestions = {
			whendamaged = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			blackout = {
				"thequickbrownfoxjumpsoverthelazydog"
			},
		}
	},

	configssection = {
		randomconfigmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		configsaved = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		configloaded = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			success = {
				"thequickbrownfoxjumpsoverthelazydog"
			}
		},

		autoconfigset = {
			empty = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			notfound = {
				"thequickbrownfoxjumpsoverthelazydog"
			},

			set = {
				lobby = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				run = {
					"thequickbrownfoxjumpsoverthelazydog"
				},

				roleplay = {
					"thequickbrownfoxjumpsoverthelazydog"
				},
			},
		}
	}
}

-------------------------------------------------------------------------------------------------------------------------------

conversations = {
	playerdamaged = {
		inlessthan20seconds = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylowerclasstwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bymaintwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byblotshand = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bysproutstendril = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byconnie = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bygoob = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byscraps = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byrazzleanddazzle = {
			"thequickbrownfoxjumpsoverthelazydog"
		}
	},

	playerdied = {
		infloorlessthan3 = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylowerclasstwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bymaintwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylethaltwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byblotshand = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bysproutstendril = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byconnie = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bygoob = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byscraps = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byrazzleanddazzle = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedandignoredhealmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedandhasanondeathoptiontoggled = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedbecausepanictimerranout = {
			"thequickbrownfoxjumpsoverthelazydog"
		}
	},

	workingonamachine = {

	},

	usedabilityonsomeone = {
		didntgetthanked = {

		},

		regular = {

		}
	},

	someonedamaged = {
		inlessthan20seconds = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylowerclasstwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bymaintwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byblotshand = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bysproutstendril = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byconnie = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bygoob = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byscraps = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byrazzleanddazzle = {
			"thequickbrownfoxjumpsoverthelazydog"
		}
	},

	someonedied = {
		infloorlessthan3 = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylowerclasstwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bymaintwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bylethaltwisted = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byblotshand = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bysproutstendril = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byconnie = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		bygoob = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byscraps = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		byrazzleanddazzle = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedandignoredhealmessages = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedandhasanondeathoptiontoggled = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		diedbecausepanictimerranout = {
			"thequickbrownfoxjumpsoverthelazydog"
		}
	},

	someoneusedabilityonyou = {
		healedontwohearts = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		helpfulbutnotthanking = {
			"thequickbrownfoxjumpsoverthelazydog"
		},

		regular = {
			"thequickbrownfoxjumpsoverthelazydog"
		}
	},

	random = {
		"thequickbrownfoxjumpsoverthelazydog"
	},
}

-------------------------------------------------------------------------------------------------------------------------------

return dialogue

-------------------------------------------------------------------------------------------------------------------------------
