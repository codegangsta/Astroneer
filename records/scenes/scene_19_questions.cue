package scenes

scene_19_questions: {
	id:     "19_Questions"
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
					// Colony life
					topic: "07_PlayerInquiry"
				},
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
				{
					// Hidden Passions
					topic: "13_PlayerInquiry"
				},
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
}
