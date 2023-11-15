package scenes

scene_14_legacy: {
	id:     "14_Legacy"
	name:   "Legacy and Impact"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "14_AriaResponse"
		},
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "14_PlayerResponseSupport"
					response: "14_AriaResponseToSupport"
				},
				{
					topic:    "14_PlayerResponseThoughtful"
					response: "14_AriaResponseToThoughtful"
				},
				{
					topic:    "14_PlayerResponseConcern"
					response: "14_AriaResponseToConcern"
				},
				{
					topic:    "14_PlayerResponseChallenging"
					response: "14_AriaResponseToChallenging"
				},
			]
		},
	]
	topics: [
		{
			id:         "14_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "14_Legacy"
			infos:      (#SimpleInfos & {in: {
				prefix: "14_PlayerInquiry"
				texts: [
					"What kind of legacy are you hoping to build?",
				]
			}}).out
		},
		{
			id:      "14_AriaResponse"
			speaker: #consts.Aria
			notes:   "Aria's voice carries a mix of passion and a hint of defensiveness."
			infos: [
				{
					id: "14_AriaResponse01"
					responses: [
						{
							text: "Legacy? I'm here to revolutionize space travel. To be a name that changed the industry, not just a footnote in its history."
						},
						{
							text: "But it's not just about making a name. It's about today's work impacting tomorrow. If my ships can inspire or protect, then I've done my job."
						},
					]
				},
			]
		},
		{
			id:      "14_PlayerResponseSupport"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "14_PlayerResponseSupport"
				texts: [
					"Your determination is admirable. You're not just building ships; you're building the future. That's a legacy in itself.",
				]
			}}).out
		},
		{
			id:      "14_PlayerResponseThoughtful"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "14_PlayerResponseThoughtful"
				texts: [
					"It's good to aim high, but remember, the greatest legacies are often the unexpected impacts, the ripples we create.",
				]
			}}).out
		},
		{
			id:      "14_PlayerResponseConcern"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "14_PlayerResponseConcern"
				texts: [
					"It's great to have goals, Aria, but don't get lost chasing them. Sometimes the best legacy is a life well-lived, not just well-worked.",
				]
			}}).out
		},
		{
			id:      "14_PlayerResponseChallenging"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "14_PlayerResponseChallenging"
				texts: [
					"A legacy, huh? Is this about making a mark, or is there something deeper you're searching for in your work?",
				]
			}}).out
		},
		{
			id:         "14_AriaResponseToSupport"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "She nods, her eyes bright."
			infos:      (#SimpleInfos & {in: {
				prefix: "14_AriaResponseToSupport"
				texts: [
					"Thanks, that's the plan. To push the boundaries, to leave something lasting and meaningful.",
				]
			}}).out
		},
		{
			id:         "14_AriaResponseToThoughtful"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "Her gaze drifts, contemplative."
			infos:      (#SimpleInfos & {in: {
				prefix: "14_AriaResponseToThoughtful"
				texts: [
					"I never thought of it that way. Maybe the legacy isn't just the ships, but the journeys they enable, the stories they become part of.",
				]
			}}).out
		},
		{
			id:         "14_AriaResponseToConcern"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "A moment of genuine reflection crosses her face."
			infos:      (#SimpleInfos & {in: {
				prefix: "14_AriaResponseToConcern"
				texts: [
					"You're right; it's easy to get caught up. I've been so focused on the destination, I might be missing the journey.",
				]
			}}).out
		},
		{
			id:         "14_AriaResponseToChallenging"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "Aria's response is tinged with defensiveness, her expression firm."
			infos:      (#SimpleInfos & {in: {
				prefix: "14_AriaResponseToChallenging"
				texts: [
					"Look, I know what I'm doing. This isn't just about making my mark. It's about fulfilling a vision, a purpose. Sure, I'm driven, but who isn't in this field? I'm here to make a difference, and that's exactly what I plan to do.",
				]
			}}).out
		},
	]
}
