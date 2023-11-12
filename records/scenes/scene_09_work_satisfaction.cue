package scenes

scene_09_work_satisfaction: {
	id:     "09_WorkSatisfaction"
	name:   "Work Satisfaction"
	notes:  "Aria talks about her work at Atlas and how she feels about it."
	actors: #consts.Actors
	topics: [
		{
			id:      "09_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "09_PlayerInquiry"
				texts: [
					"Moving from a big corporation to a startup must be a big change. How do you feel about your work now?",
				]
			}}).out
		},
		{
			id:      "09_AriaResponse"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "09_AriaResponse"
				texts: [
					"It's liberating. I used to follow strict guidelines, but here I get to experiment. It’s thrilling to turn my ideas into reality, even with the ups and downs.",
					"The pressure's real, but it's a good kind. It pushes me to be creative, to really dive into my work. It's tough, but it’s where I see my true potential shine.",
				]
			}}).out
		},
		{
			id:      "09_PlayerResponsePraiseFreedom"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "09_PlayerResponsePraiseFreedom"
				texts: [
					"That sounds empowering. Seeing your own concepts come to life must be incredibly fulfilling.",
				]
			}}).out
		},
		{
			id:      "09_PlayerResponseQuestionFreedom"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "09_PlayerResponseQuestionFreedom"
				texts: [
					"Do you ever find that freedom overwhelming, without the structure of a big company?",
				]
			}}).out
		},
		{
			id:      "09_PlayerResponseAdmirePressure"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "09_PlayerResponseAdmirePressure"
				texts: [
					"Using pressure as a catalyst for creativity? That’s impressive. It shows your dedication.",
				]
			}}).out
		},
		{
			id:      "09_PlayerResponseConcernPressure"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "09_PlayerResponseConcernPressure"
				texts: [
					"It’s great to be driven, but don’t forget to unwind. Balance is key, right?",
				]
			}}).out
		},
		{
			id:      "09_AriaResponseToPraiseFreedom"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "09_AriaResponseToPraiseFreedom"
				texts: [
					"It really is. Every project feels like a part of me is taking off. It’s personal, every win and every challenge.",
				]
			}}).out
		},
		{
			id:      "09_AriaResponseToQuestionFreedom"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "09_AriaResponseToQuestionFreedom"
				texts: [
					"Sometimes, yes. But I prefer it. I thrive in this kind of environment where every day is different, and every challenge is a chance to innovate.",
				]
			}}).out
		},
		{
			id:      "09_AriaResponseToAdmirePressure"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "09_AriaResponseToAdmirePressure"
				texts: [
					"Thanks, I believe in turning challenges into opportunities. It's demanding but seeing my ideas come alive? Worth it.",
				]
			}}).out
		},
		{
			id:      "09_AriaResponseToConcernPressure"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "09_AriaResponseToConcernPressure"
				texts: [
					"Good advice. I try to keep a balance – a moment under the stars can be as refreshing as a day in the workshop. Keeps me grounded.",
				]
			}}).out
		},
	]
}
