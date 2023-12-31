package scenes

scene_10_alternate_paths: {
	id:     "10_AlternatePaths"
	quest:  "ParentQuest"
	name:   "Alternate Paths"
	notes:  "In this scene, Aria reflects on her career choices, showing a blend of confidence in her decision and awareness of what she's left behind. The player's responses probe deeper, revealing Aria's introspective side and her commitment to her path despite acknowledging the trade-offs."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "10_AriaResponse"
		},
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "10_PlayerResponseEncouraging"
					response: "10_AriaResponseToEncouraging"
				},
				{
					topic:    "10_PlayerResponseInquisitive"
					response: "10_AriaResponseToInquisitive"
				},
				{
					topic:    "10_PlayerResponseSupportive"
					response: "10_AriaResponseToSupportive"
				},
				{
					topic:    "10_PlayerResponseRealistic"
					response: "10_AriaResponseToRealistic"
				},
			]
		},
	]
	topics: [
		{
			id:         "10_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "10_AlternatePaths"
			infos:      (#SimpleInfos & {in: {
				prefix: "10_PlayerInquiry"
				texts: [
					"Ever wonder about staying in the corporate world instead of jumping to a startup?",
				]
			}}).out
		},
		{
			id:      "10_AriaResponse"
			speaker: #consts.Aria
			infos: [
				{
					id: "10_AriaResponse01"
					responses: [
						{
							text: "Sometimes, I think about it. The corporate route would've been smoother, sure. But then I solve a tough design problem or see my ideas take flight, and I know I chose right. It's these moments that validate my decision."
						},
						{
							text: "The 'what ifs' used to bug me more. What if I took the safer route, climbed the corporate ladder? But I prefer the roads less traveled. It’s uncertain, but it feels real, and the rewards are mine to cherish."
						},
					]
				},
			]
		},
		{
			id:      "10_PlayerResponseEncouraging"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "10_PlayerResponseEncouraging"
				texts: [
					"You’re shaping the future, not just following a preset path. That's a big deal.",
				]
			}}).out
		},
		{
			id:      "10_PlayerResponseInquisitive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "10_PlayerResponseInquisitive"
				texts: [
					"Do you think the structure of corporate life might have offered different achievements?",
				]
			}}).out
		},
		{
			id:      "10_PlayerResponseSupportive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "10_PlayerResponseSupportive"
				texts: [
					"Making your own way takes guts. It's inspiring to see where your choices have led.",
				]
			}}).out
		},
		{
			id:      "10_PlayerResponseRealistic"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "10_PlayerResponseRealistic"
				texts: [
					"Leaving stability for the unknown is a bold move. Takes a lot of guts to make that leap.",
				]
			}}).out
		},
		{
			id:         "10_AriaResponseToEncouraging"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "10_AriaResponseToEncouraging"
				texts: [
					"Thanks, that means a lot. It's about making a mark, not just earning a paycheck. I get to see my dreams become reality. That's my kind of success.",
				]
			}}).out
		},
		{
			id:         "10_AriaResponseToInquisitive"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "10_AriaResponseToInquisitive"
				texts: [
					"I've pondered that. Sure, I might have had more resources, but would I have had this much impact? Here, each project is personal, a testament to my journey.",
				]
			}}).out
		},
		{
			id:         "10_AriaResponseToSupportive"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "10_AriaResponseToSupportive"
				texts: [
					"Appreciate that. Yeah, it's risky, but also thrilling. I’m not just a part of something; I’m driving it. That's a feeling worth all the risks.",
				]
			}}).out
		},
		{
			id:         "10_AriaResponseToRealistic"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			infos:      (#SimpleInfos & {in: {
				prefix: "10_AriaResponseToRealistic"
				texts: [
					"It was a tough choice, no denying. But I believe in betting on myself. It's not just about risk; it's about potential and making things happen on my terms.",
				]
			}}).out
		},
	]
}
