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
					// Modifying ships
					topic:    "MAIN_PlayerModifyShips"
					response: "Aria_ModifyShip"
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
	]
}
