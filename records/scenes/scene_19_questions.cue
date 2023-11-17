package scenes

scene_19_questions: {
	id:     "19_Questions"
	quest:  "ParentQuest"
	name:   "Questions for Aria"
	notes:  "This scene is a container for the standard questions that the player will ask Aria."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					// Intercom
					topic: "17_PlayerInquiry"
				},
				{
					// Background
					topic: "05_PlayerInquiry"
				},
				{
					// About your work...
					topic: "19b_PlayerInquiry"
				},
				{
					// About your background...
					topic: "19c_PlayerInquiry"
				},
				{
					// About something personal...
					topic: "19d_PlayerInquiry"
				},
			]
		},
	]
}
