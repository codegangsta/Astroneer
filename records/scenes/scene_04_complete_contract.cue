package scenes

scene_04_complete_contract: {
	id:     "04_CompleteContract"
	quest:  "ParentQuest"
	name:   "Player Completes Contract"
	notes:  "The player has finished building the ship according to the contract specs, and is ready to turn it in to Aria."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Responses"},
	]

	// Each response is a random selection of one of the following, depending on
	// the type of ship contract:
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaFighter"
		},
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaExplorer"
		},
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaHauler"
		},
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaInterceptor"
		},
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaLuxury"
		},
		{
			type:  #consts.ActionDialogue
			topic: "04_AriaClosing"
		},
	]
	topics: [
		{
			id:         "04_Player"
			speaker:    #consts.Player
			startScene: "04_CompleteContract"
			infos:      (#SimpleInfos & {in: {
				prefix: "04_Player"
				flags:  #consts.InfoFlagsRandom
				texts: [
					"Design's in. Does it capture what you were looking for?",
					"Finished with the ship. How does it measure up to our standards?",
					"Completed the contract. What's your take on the final product?",
					"Just finished my design. Will it pass the Aria test?",
					"Redesign's done. Does it have the Aria stamp of approval?",
					"Contract's done. I'm eager to hear your thoughts.",
					"Wrapped up the ship. It should meet the mark.",
					"Finished the upgrade. It's ready for your review.",
					"The ship's reimagined, per your vision.",
					"Ship is done. It's a fresh take on an old classic.",
				]
				conditions: [
					{
						function: "GetStage"
						quest:    "ShipContractMission"
						equals:   30.0
					},
				]
			}}).out
		},
		{
			id:      "04_AriaFighter"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaFighter"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   0.0
					},
				]
				texts: [
					"Nice work! This fighter's gone from zero to hero.",
					"Looks sharp! It’s got stealth and swagger in spades.",
					"You've turned it tough! It's ready to rumble now.",
					"Sleek job! It's like a race car of the skies.",
					"Stellar work! This fighter's ready for its own saga.",
				]
			}}).out
		},
		{
			id:      "04_AriaExplorer"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaExplorer"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   1.0
					},
				]
				texts: [
					"Great update! It's a real cosmic explorer now.",
					"It's a star-traveler's dream! Love the new look.",
					"Those sensors are top-notch. It's a galaxy whisperer now.",
					"You've given it a real adventurous edge. Nice!",
					"Love it! It's like a toolbox of space wonders.",
				]
			}}).out
		},
		{
			id:      "04_AriaHauler"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaHauler"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   2.0
					},
				]
				texts: [
					"This hauler's a real gem now. It's got style and space!",
					"You turned it chic! It's a fashion-forward freighter.",
					"Massive upgrade! It's a cargo metropolis now.",
					"From sturdy to stunning! It's a cargo showstopper.",
					"Wow, talk about an upgrade! It's a planet mover!",
				]
			}}).out
		},
		{
			id:      "04_AriaInterceptor"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaInterceptor"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   3.0
					},
				]
				texts: [
					"This interceptor's slick and secretive now. Nice touch!",
					"That's some speed! It's a real cosmic blur.",
					"Super quick! It's got an extra dose of zoom.",
					"Instant action! This ship's redefining speed.",
					"Sleek and fast! It's a racer's dream.",
				]
			}}).out
		},
		{
			id:      "04_AriaLuxury"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaLuxury"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   4.0
					},
				]
				texts: [
					"It's like a floating palace. Absolutely luxurious!",
					"You've raised the bar! It's luxury cruising at its best.",
					"Pure elegance! Every inch whispers class.",
					"Opulent and grand! It's a journey in style.",
					"Cozy and lavish! It's a five-star trip through space.",
				]
			}}).out
		},
		{
			id:         "04_AriaClosing"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "CompleteContract"
			infos:      (#SimpleInfos & {in: {
				prefix: "04_AriaClosing"
				flags:  #consts.InfoFlagsRandom
				texts: [
					"Credits transferred. Aria signing off.",
					"Payment made. Until next time, Cap.",
					"Your reward's been sent. Aria out.",
					"Job well done. Credits in your account. Catch you later.",
					"Contract complete, payment processed. Nice doing business with you, Cap.",
					"Signing off with your credits on the way. Stay stellar, Cap.",
					"That's a wrap on this one. Your pay's been sorted. Out for now.",
					"Mission accomplished, reward sent. Aria out until the next call.",
					"Credits are en route. Good work, Cap. Signing off.",
					"Contract closed and paid. Keep an eye out for more. Aria out.",
				]
			}}).out
		},
	]
}
