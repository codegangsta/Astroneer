package scenes

scene_19d_personal_questions: {
	id:     "19d_PersonalQuestions"
	name:   "Personal Questions for Aria"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Personal Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					// Legacy
					topic: "14_PlayerInquiry"
				},
				{
					// Sacrifices
					topic: "15_PlayerInquiry"
				},
				{
					// Regrets
					topic: "16_PlayerInquiry"
				},
			]
		},
	]
	topics: [
		{
			id:         "19d_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "19d_PersonalQuestions"
			infos:      (#SimpleInfos & {in: {
				prefix: "19d_PlayerInquiry"
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueBackgroundComplete"
						equals:   1.0
					},
				]
				texts: [
					"About something personal...",
				]
			}}).out
		},
	]
}
