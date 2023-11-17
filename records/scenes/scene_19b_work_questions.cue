package scenes

scene_19b_work_questions: {
	id:     "19b_WorkQuestions"
	quest:  "ParentQuest"
	name:   "Work Questions for Aria"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Work Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					// Startup
					topic: "08_PlayerInquiry"
				},
				{
					// Work Satisfaction
					topic: "09_PlayerInquiry"
				},
				{
					// Alternate Paths
					topic: "10_PlayerInquiry"
				},
			]
		},
	]
	topics: [
		{
			id:         "19b_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "19b_WorkQuestions"
			infos:      (#SimpleInfos & {in: {
				prefix: "19b_PlayerInquiry"
				conditions: [
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueBackgroundComplete"
						equals:   1.0
					},
				]
				texts: [
					"About your work...",
				]
			}}).out
		},
	]
}
