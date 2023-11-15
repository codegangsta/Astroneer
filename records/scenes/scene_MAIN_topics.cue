package scenes

scene_MAIN_topics: {
	id:     "MAIN_topics"
	name:   "Main Topics"
	notes:  "This is the main topics scene"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Topics"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					// Getting a mission
					topic: "03_Player"
				},
				{
					// Turning in a mission
					topic: "04_Player"
				},
				{
					// Trouble with a contract
					topic: "18_PlayerInquiry"
				},
				{
					// Modifying ships
					topic:    "MAIN_PlayerModifyShips"
					response: "MAIN_AriaModifyShipsResponse"
				},
				{
					// Asking questions
					topic:    "MAIN_PlayerQuestions"
					response: "MAIN_AriaQuestionsResponse"
				},
			]
		},
	]

	topics: [
		{
			id:      "MAIN_PlayerModifyShips"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "MAIN_PlayerModifyShips"
				texts: ["I'd like to modify my ships"]
			}}).out
		},
		{
			id:      "MAIN_AriaModifyShipsResponse"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "MAIN_AriaModifyShipsResponse"
				flags:  #consts.InfoFlagsRandom
				texts: ["Sure thing!", "You got it!", "Absolutely!", "Of course!"]
			}}).out
		},
		{
			id:      "MAIN_PlayerQuestions"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "MAIN_PlayerQuestions"
				texts: ["Mind if I ask you a few questions?"]
			}}).out
		},
		{
			id:         "MAIN_AriaQuestionsResponse"
			speaker:    #consts.Player
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "MAIN_AriaQuestionsResponse"
				flags:  #consts.InfoFlagsRandom
				texts: ["Don't mind at all!", "What's on your mind, Cap?"]
			}}).out
		},
	]
}
