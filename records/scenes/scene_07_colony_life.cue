package scenes

scene_07_colony_life: {
	id:     "07_ColonyLife"
	quest:  "ParentQuest"
	name:   "Colony Life"
	notes:  "In this scene, Aria fondly recalls her upbringing in a space colony, subtly hinting at the contrast between her ambitious career path and the simpler life she left behind. Her responses subtly reflect her inner conflict, though she remains somewhat steadfast in her choices."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "07_AriaResponse"
		},
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "07_PlayerResponseAdmireImagination"
					response: "07_AriaResponseToAdmireImagination"
				},
				{
					topic:    "07_PlayerResponseCuriousImagination"
					response: "07_AriaResponseToCuriousImagination"
				},
				{
					topic:    "07_PlayerResponseAdmireResilience"
					response: "07_AriaResponseToAdmireResilience"
				},
				// {
				// 	topic:    "07_PlayerResponseCuriousResilience"
				// 	response: "07_AriaResponseToCuriousResilience"
				// },
			]
		},
	]
	topics: [
		{
			id:         "07_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "07_ColonyLife"
			infos:      (#SimpleInfos & {in: {
				prefix: "07_PlayerInquiry"
				texts: [
					"Growing up on a colony must have been unique. What was it like?",
				]
			}}).out
		},
		{
			id:      "07_AriaResponse"
			speaker: #consts.Aria
			infos: [
				{
					id: "07_AriaResponse01"
					responses: [
						{
							text: "It was a mix of hardship and creativity. Building dreams out of scraps, I always knew there was more out there for me. I miss the simplicity at times, but the stars called louder than the past."
						},
						{
							text: "Life there was about making do and dreaming big. I learned to be resourceful, to see potential in everything. It's a part of me, but there's a part that always yearned for something... more."
						},
					]
				},
			]
		},
		{
			id:      "07_PlayerResponseAdmireImagination"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "07_PlayerResponseAdmireImagination"
				texts: [
					"Sounds like it was the perfect breeding ground for your creativity and drive.",
				]
			}}).out
		},
		{
			id:      "07_PlayerResponseCuriousImagination"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "07_PlayerResponseCuriousImagination"
				texts: [
					"Do you think your childhood dreams pushed you to pursue such ambitious goals?",
				]
			}}).out
		},
		{
			id:      "07_PlayerResponseAdmireResilience"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "07_PlayerResponseAdmireResilience"
				texts: [
					"Your resilience is inspiring. From small beginnings to grand achievements.",
				]
			}}).out
		},
		{
			id:      "07_PlayerResponseCuriousResilience"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "07_PlayerResponseCuriousResilience"
				texts: [
					"It seems like your roots gave you both the strength and vision for your journey.",
				]
			}}).out
		},
		{
			id:         "07_AriaResponseToAdmireImagination"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "07_AriaResponseToAdmireImagination"
				texts: [
					"Definitely. My imagination took root there, but it always stretched towards the stars. Can't help but wonder sometimes though, about the roads not taken.",
				]
			}}).out
		},
		{
			id:         "07_AriaResponseToCuriousImagination"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "07_AriaResponseToCuriousImagination"
				texts: [
					"They did. I was always reaching for the next big thing. I guess a part of me still clings to those simple days, even if I don't admit it often.",
				]
			}}).out
		},
		{
			id:         "07_AriaResponseToAdmireResilience"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "07_AriaResponseToAdmireResilience"
				texts: [
					"It's been quite the journey. I've come far, but the lessons from back then keep me grounded... in a way.",
				]
			}}).out
		},
	]
}
