package scenes

scene_16_regrets: {
	id:     "16_Regrets"
	quest:  "ParentQuest"
	name:   "Aria Reflects on Family and Regrets"
	notes:  "This emotionally complex scene starts with Aria's rare moment of vulnerability about her family, which she either opens up more about or distances herself from, depending on the player's approach."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "16_AriaResponse"
		},
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "16_PlayerResponseCompassionate"
					response: "16_AriaResponseToCompassionate"
				},
				{
					topic:    "16_PlayerResponsePractical"
					response: "16_AriaResponseToPractical"
				},
				{
					topic:    "16_PlayerResponseProbing"
					response: "16_AriaResponseToProbing"
				},
				{
					topic:    "16_PlayerResponseDismissive"
					response: "16_AriaResponseToDismissive"
				},
			]
		},
	]
	topics: [
		{
			id:         "16_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "16_Regrets"
			infos:      (#SimpleInfos & {in: {
				prefix: "16_PlayerInquiry"
				texts: [
					"How has your career affected ties with family?",
				]
			}}).out
		},
		{
			id:      "16_AriaResponse"
			speaker: #consts.Aria
			notes:   "Aria's facade momentarily slips, revealing a raw, emotional undercurrent."
			infos: [
				{
					id: "16_AriaResponse01"
					responses: [
						{
							text: "It's... it's been hard. I've been so wrapped up in my work, I've let those connections fade. It's one of those things you don't notice until it hits you."
						},
						{
							text: "I left for the stars so young, so eager. I told myself it was for the greater good, but... I missed so much back home. It's a silence that's grown too loud to ignore."
						},
					]
				},
			]
		},
		{
			id:      "16_PlayerResponseCompassionate"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "16_PlayerResponseCompassionate"
				texts: [
					"It's a tough balance to strike. Maybe it's not too late to start bridging that gap, to reconnect.",
				]
			}}).out
		},
		{
			id:      "16_PlayerResponsePractical"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "16_PlayerResponsePractical"
				texts: [
					"Your achievements are incredible, but sometimes, reconnecting with family can bring a different sense of accomplishment.",
				]
			}}).out
		},
		{
			id:      "16_PlayerResponseProbing"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "16_PlayerResponseProbing"
				texts: [
					"Is that silence something you're thinking of addressing? It might bring you a different kind of peace.",
				]
			}}).out
		},
		{
			id:      "16_PlayerResponseDismissive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "16_PlayerResponseDismissive"
				texts: [
					"Well, sacrifices are part of the job, right? You can’t reach the stars without leaving something behind.",
				]
			}}).out
		},
		{
			id:         "16_AriaResponseToCompassionate"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "The vulnerability in Aria’s voice is palpable, her usual confidence replaced by a rare sense of fear."
			infos:      (#SimpleInfos & {in: {
				prefix: "16_AriaResponseToCompassionate"
				texts: [
					"You might be right, but... it terrifies me. The thought of reaching out after all this time, facing them... it feels like standing on the edge of a black hole. I don't know if I'm ready to confront that darkness yet.",
				]
			}}).out
		},
		{
			id:         "16_AriaResponseToPractical"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "There's a shift in her demeanor, a mix of acceptance and hesitation."
			infos:      (#SimpleInfos & {in: {
				prefix: "16_AriaResponseToPractical"
				texts: [
					"You have a point. My work has always been my focus, but... maybe there's room for both in my life.",
				]
			}}).out
		},
		{
			id:         "16_AriaResponseToProbing"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "A brief flicker of contemplation crosses her face, then she retreats slightly."
			infos:      (#SimpleInfos & {in: {
				prefix: "16_AriaResponseToProbing"
				texts: [
					"It's something I'm wrestling with. Maybe addressing it will bring peace, but... let's just say I'm not there yet.",
				]
			}}).out
		},
		{
			id:         "16_AriaResponseToDismissive"
			speaker:    #consts.Aria
			startScene: "19_Questions"
			notes:      "Her defenses snap back up, the vulnerability gone."
			infos:      (#SimpleInfos & {in: {
				prefix: "16_AriaResponseToDismissive"
				texts: [
					"Exactly. You get it. Can't make an omelet without breaking a few eggs, right? I've made my choice, for better or worse.",
				]
			}}).out
		},
	]
}
