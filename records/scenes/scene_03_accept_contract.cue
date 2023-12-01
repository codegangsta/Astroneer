package scenes

scene_03_accept_contract: {
	id:     "03_AcceptContract"
	quest:  "ParentQuest"
	name:   "Player Accepts Contract"
	notes:  "The player has accepted a mission from the mission board, and has walked over to the Atlas Astronautics intercom to speak with Aria. Aria greets the player, then the player chooses to ask about the contract they've just accepted. Based on the type of Ship contract, a randomly generated response from Aria will be chosen. The intent is to have enough dialog and variety that each mission feels fresh and new"
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
			topic: "03_AriaFighter"
		},
		{
			type:  #consts.ActionDialogue
			topic: "03_AriaExplorer"
		},
		{
			type:  #consts.ActionDialogue
			topic: "03_AriaHauler"
		},
		{
			type:  #consts.ActionDialogue
			topic: "03_AriaInterceptor"
		},
		{
			type:  #consts.ActionDialogue
			topic: "03_AriaLuxury"
		},
	]
	topics: [
		// This topic kicks off the conversation.
		{
			id:         "03_Player"
			speaker:    #consts.Player
			startScene: "03_AcceptContract"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_Player"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				texts: [
					"Any ships in need of a hand today?",
					"Is there a new vessel for me to take under my wing?",
					"Got a ship that needs some love?",
					"I'm here for that contract—what's the assignment?",
					"What's the latest ship on the roster?",
					"Ready for a new project; what have you got?",
					"Looking for a ship that could use a tune-up?",
					"Heard about a ship needing a fix, is it mine to take?",
					"What's the word on that new contract?",
				]
				conditions: [
					{
						function: "GetStage"
						quest:    "ShipContractMission"
						equals:   10.0
					},
				]
			}}).out
		},
		{
			id:         "03_AriaFighter"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "SetDesignStage"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_AriaFighter"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   0.0
					},
				]
				texts: [
					"Got a fighter that's seen better days. Time to turn it from a zero to a hero.",
					"There's a fighter itching for some speed. Think you can make it break the sound barrier... quietly?",
					"Here’s a fighter that's begging for some flair. Ready to spice it up?",
					"This one's a zippy fighter, but it's more mouse than lion right now. Fancy beefing it up?",
					"Got a veteran fighter here. Fancy turning its old stories into new legends?",
				]
			}}).out
		},
		{
			id:         "03_AriaExplorer"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "SetDesignStage"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_AriaExplorer"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   1.0
					},
				]
				texts: [
					"An explorer's waiting. It's got more miles than my coffee machine and twice the untapped potential.",
					"I’ve got an explorer that’s seen galaxies galore. Ready to turn it into a space legend?",
					"There's a research ship that's been flirting with black holes. Needs a bit of your charm now.",
					"This explorer's got wanderlust. Think you can make it the envy of the cosmos?",
					"Here’s an explorer that's craving adventure. Ready to be its genie?",
				]
			}}).out
		},
		{
			id:         "03_AriaHauler"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "SetDesignStage"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_AriaHauler"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   2.0
					},
				]
				texts: [
					"Got a hauler that's been lugging more than cargo. Time to jazz up its routine.",
					"There's a sturdy hauler here. Could use a touch of pizzazz. Fancy giving it some sparkle?",
					"Here's a freighter with dreams of being a starship. Think you can grant its wish?",
					"This old freighter's solid but could use some fun. How about disco lights in the cargo bay?",
					"There’s a hauler here with space to spare. Maybe add a bowling alley?",
				]
			}}).out
		},
		{
			id:         "03_AriaInterceptor"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "SetDesignStage"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_AriaInterceptor"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   3.0
					},
				]
				texts: [
					"Interceptor in the bay is ready for some zing. Think you can make it zoom and boom?",
					"Got an interceptor that’s quick but not slick. Fancy giving it a secret identity?",
					"There’s a need-for-speed ship here. Think you can make it go 'vroom' with style?",
					"An interceptor's lined up. It’s fast, but can you make it furious?",
					"Here's a racer that's been dreaming of rocket boosters. Fancy turning it into a speed demon?",
				]
			}}).out
		},
		{
			id:         "03_AriaLuxury"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onBegin:    "SetDesignStage"
			infos:      (#SimpleInfos & {in: {
				prefix: "03_AriaLuxury"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ShipContractMission"
						variable: "ShipType"
						equals:   4.0
					},
				]
				texts: [
					"There's a luxury cruiser that's more plain Jane than star queen. Ready for a royal makeover?",
					"Got a fancy vessel that's feeling a bit old-fashioned. Time to bring it into the space age?",
					"There’s a floating five-star hotel here. Think you can add a sixth star?",
					"Ever fancied decking out a spaceship like a Hollywood mansion? Here’s your chance.",
					"Got a luxury ship here that's secretly a diva. Ready to dress it for the red carpet?",
				]
			}}).out
		},
	]
}
