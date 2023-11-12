package scenes

scene_15_sacrifices: {
	id:     "15_Sacrifices"
	name:   "Sacrifices"
	notes:  "This scene delves into the complex nature of Aria's career-driven life, challenging her to confront the personal costs and momentarily revealing the vulnerability behind her confident facade."
	actors: #consts.Actors
	topics: [
		{
			id:      "15_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "15_PlayerInquiry"
				texts: [
					"You’ve climbed high in your field, Aria. But I have to wonder, what personal costs came with that ascent?",
				]
			}}).out
		},
		{
			id:      "15_AriaResponse"
			speaker: #consts.Aria
			notes:   "There's an edge to her voice. "
			infos: [
				{
					id: "15_AriaResponse01"
					responses: [
						{
							text: "Sacrifice is part of the game. I’ve let go of the conventional, sure. But what I’m doing here... it’s worth more than any traditional path."
						},
						{
							text: "I’ve traded simplicity for complexity, and I don't regret it. I’m not one for stillness; I need the rush of creation, of discovery."
						},
					]
				},
			]
		},
		{
			id:      "15_PlayerResponseUnderstanding"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "15_PlayerResponseUnderstanding"
				texts: [
					"Your focus and dedication are truly remarkable. Just be careful not to lose yourself completely in the pursuit.",
				]
			}}).out
		},
		{
			id:      "15_PlayerResponseInquisitive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "15_PlayerResponseInquisitive"
				texts: [
					"But doesn't that ever weigh on you? The things you've had to leave behind in chasing this dream?",
				]
			}}).out
		},
		{
			id:      "15_PlayerResponseSupportive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "15_PlayerResponseSupportive"
				texts: [
					"It's clear you're exactly where you're meant to be, Aria. Your work speaks volumes about your passion and commitment.",
				]
			}}).out
		},
		{
			id:      "15_PlayerResponseIntimate"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "15_PlayerResponseIntimate"
				texts: [
					"Ever think about what a different Aria, one with a quieter life, might be like? Sometimes the roads not taken are worth a thought too.",
				]
			}}).out
		},
		{
			id:      "15_AriaResponseToUnderstanding"
			speaker: #consts.Aria
			notes:   "Aria nods, her confidence intact."
			infos:   (#SimpleInfos & {in: {
				prefix: "15_AriaResponseToUnderstanding"
				texts: [
					"I'm well aware of what I've chosen. This is my world, and I wouldn’t have it any other way.",
				]
			}}).out
		},
		{
			id:      "15_AriaResponseToInquisitive"
			speaker: #consts.Aria
			notes:   "She responds briskly."
			infos:   (#SimpleInfos & {in: {
				prefix: "15_AriaResponseToInquisitive"
				texts: [
					"Sure, it weighs on me. But regret is a distraction. I’m here to push boundaries, not dwell on what-ifs.",
				]
			}}).out
		},
		{
			id:      "15_AriaResponseToSupportive"
			speaker: #consts.Aria
			notes:   "Her expression brightens, reaffirming her path."
			infos:   (#SimpleInfos & {in: {
				prefix: "15_AriaResponseToSupportive"
				texts: [
					"Thank you. I’ve never been one for the sidelines. I'm here to make waves, to make a difference.",
				]
			}}).out
		},
		{
			id:      "15_AriaResponseToIntimate"
			speaker: #consts.Aria
			notes:   "Caught off guard, her usual composure falters."
			infos:   (#SimpleInfos & {in: {
				prefix: "15_AriaResponseToIntimate"
				texts: [
					"A quieter life... I don't often let myself think about that. Maybe... maybe I should, even if just for a moment.",
				]
			}}).out
		},
	]
}
