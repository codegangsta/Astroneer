package scenes

scene_19_questions: {
	id:     "19_Questions"
	name:   "Personal Questions for Aria"
	notes:  "This scene is a container for the personal questions that the player will ask Aria."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
				{
					topic: "05_PlayerInquiry"
				},
				{
					topic: "07_PlayerInquiry"
				},
				{
					topic: "08_PlayerInquiry"
				},
				{
					topic: "09_PlayerInquiry"
				},
				{
					topic: "10_PlayerInquiry"
				},
				{
					topic: "13_PlayerInquiry"
				},
				{
					topic: "14_PlayerInquiry"
				},
				{
					topic: "15_PlayerInquiry"
				},
				{
					topic: "16_PlayerInquiry"
				},
				{
					topic: "17_PlayerInquiry"
				},
			]
		},
	]
}
