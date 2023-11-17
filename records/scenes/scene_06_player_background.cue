package scenes

scene_06_player_background: {
	id:     "06_PlayerBackground"
	quest:  "ParentQuest"
	name:   "Player's Background"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria's Inquiry"},
		{name: "Player's Response"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "06_AriaInquiry"
		},
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "06_PlayerResponseAmbition"
					response: "06_AriaResponseToAmbition"
				},
				{
					topic:    "06_PlayerResponseKinship"
					response: "06_AriaResponseToKinship"
				},
				{
					topic:    "06_PlayerResponseHorizon"
					response: "06_AriaResponseToHorizon"
				},
			]
		},
	]
	topics: [
		{
			id:      "06_AriaInquiry"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "06_AriaInquiry"
				texts: [
					// TODO: Maybe make this a bit more playful. She was just a bit vulnerable
					// so maybe she tries to lighten the mood and redirect
					"So, Cap, what's your story? Here for the thrill, the cash, or something more?",
				]
			}}).out
		},
		{
			id:      "06_PlayerResponseAmbition"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "06_PlayerResponseAmbition"
				texts: [
					"I'm all about the adventure. And hey, the money's a nice bonus.",
				]
			}}).out
		},
		{
			id:      "06_PlayerResponseKinship"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "06_PlayerResponseKinship"
				texts: [
					"Got big dreams, like you. I want to leave my mark out here.",
				]
			}}).out
		},
		{
			id:      "06_PlayerResponseHorizon"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "06_PlayerResponseHorizon"
				texts: [
					"I'm chasing what's beyond the horizon. Always looking further.",
				]
			}}).out
		},
		{
			id:         "06_AriaResponseToAmbition"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "06_AriaResponseToAmbition"
				texts: [
					"Thrills and bills, a classic mix. Just watch your back; adventure can be costly out here.",
				]
			}}).out
		},
		{
			id:         "06_AriaResponseToKinship"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "06_AriaResponseToKinship"
				texts: [
					"Another star chaser, huh? Good. The galaxy's vast, and there's plenty of room for names like ours.",
				]
			}}).out
		},
		{
			id:         "06_AriaResponseToHorizon"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "06_AriaResponseToHorizon"
				texts: [
					"The eternal explorer, huh? Good choice. There's more out there than we can imagine. Let's uncover it together.",
				]
			}}).out
		},
	]
}
