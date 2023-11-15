package scenes

scene_20_personal_questions: {
	id:     "20_PersonalQuestions"
	name:   "Personal Questions for Aria"
	notes:  "This scene is a container for the personal questions that the player will ask Aria."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Personal Questions"}]
	actions: [
		{
			type: #consts.ActionPlayerDialogue
			choices: [
			]
		},
	]
}
