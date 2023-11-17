package scenes

scene_19c_background_questions: {
	id:     "19c_BackgroundQuestions"
	quest:  "ParentQuest"
	name:   "Background Questions for Aria"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Background Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					// Colony life
					topic: "07_PlayerInquiry"
				},
				{
					// Hidden Passions
					topic: "13_PlayerInquiry"
				},
			]
		},
	]
	topics: [
		{
			id:         "19c_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "19c_BackgroundQuestions"
			infos:      (#SimpleInfos & {in: {
				prefix: "19c_PlayerInquiry"
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueBackgroundComplete"
						equals:   1.0
					},
				]
				texts: [
					"About your background...",
				]
			}}).out
		},
	]
}
