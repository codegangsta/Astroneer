package scenes

scene_12b_bad_news: {
	id:     "12b_BadNews"
	name:   "Bad News followup scene"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			name:       "Player Deeper Responses"
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "12_PlayerResponseEmpathy"
					response: "12_AriaResponseToEmpathy"
				},
				{
					topic:    "12_PlayerResponsePracticalSupport"
					response: "12_AriaResponseToPracticalSupport"
				},
				{
					topic:    "12_PlayerResponseSharedExperience"
					response: "12_AriaResponseToSharedExperience"
				},
				{
					topic:    "12_PlayerResponseEncouragingOptimism"
					response: "12_AriaResponseToEncouragingOptimism"
				},
				{
					topic:    "12_PlayerResponseOfferSpace"
					response: "12_AriaResponseToOfferSpace"
				},
			]
		},
	]
}
