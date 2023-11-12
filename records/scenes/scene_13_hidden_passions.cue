package scenes

scene_13_hidden_passions: {
	id:     "13_HiddenPassions"
	name:   "Hidden Passions - Humble Revelations"
	notes:  "Aria reveals her hobbies and the joy of learning for its own sake."
	actors: #consts.Actors
	topics: [
		{
			id:      "13_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "13_PlayerInquiry"
				texts: [
					"What's your downtime look like, Aria? Any unique hobbies outside of your ship work?",
				]
			}}).out
		},
		{
			id:      "13_AriaResponse"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "13_AriaResponse"
				texts: [
					"I've taken up cooking. I'm no chef, mind you. Half the time, it's more of an experiment than a meal. But there's something satisfying about creating with your hands, even if it's just a quirky sandwich.",
					"And I dabble in amateur astronomy. I’m not particularly great at it – I can barely tell the constellations apart! But gazing at the stars, not as a designer but just as myself, it's kind of liberating.",
				]
			}}).out
		},
		{
			id:      "13_PlayerResponseEncouraging"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "13_PlayerResponseEncouraging"
				texts: [
					"Exploring new territories, even in the kitchen or the night sky. That's exciting, even if it's not about perfection.",
				]
			}}).out
		},
		{
			id:      "13_PlayerResponseLightTease"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "13_PlayerResponseLightTease"
				texts: [
					"Chef Aria and the star-gazer who can't find Orion? Sounds like you're enjoying the learning curve.",
				]
			}}).out
		},
		{
			id:      "13_PlayerResponseUnderstanding"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "13_PlayerResponseUnderstanding"
				texts: [
					"Those sound like great ways to unwind. It's not always about being the best, but enjoying the process.",
				]
			}}).out
		},
		{
			id:      "13_PlayerResponseReflective"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "13_PlayerResponseReflective"
				texts: [
					"It’s good to hear you doing things just for the joy of it, not just for the end result. That’s important.",
				]
			}}).out
		},
		{
			id:      "13_AriaResponseToEncouraging"
			speaker: #consts.Aria
			notes:   "Aria chuckles, a touch of self-deprecation in her tone."
			infos:   (#SimpleInfos & {in: {
				prefix: "13_AriaResponseToEncouraging"
				texts: [
					"Exciting and a little humbling! But you're right, it's not about perfection. It's about the joy of trying, of creating.",
				]
			}}).out
		},
		{
			id:      "13_AriaResponseToLightTease"
			speaker: #consts.Aria
			notes:   "Her laughter is genuine, tinged with a hint of embarrassment."
			infos:   (#SimpleInfos & {in: {
				prefix: "13_AriaResponseToLightTease"
				texts: [
					"Yeah, I'm embracing the 'amateur' in both! There's freedom in just being a novice, a learner. It's a nice change of pace.",
				]
			}}).out
		},
		{
			id:      "13_AriaResponseToUnderstanding"
			speaker: #consts.Aria
			notes:   "She nods appreciatively, a reflective look in her eyes."
			infos:   (#SimpleInfos & {in: {
				prefix: "13_AriaResponseToUnderstanding"
				texts: [
					"Exactly. For so long, I've been driven by the need to excel. It's refreshing to do something just for the sheer enjoyment, even if I'm not the best at it.",
				]
			}}).out
		},
		{
			id:      "13_AriaResponseToReflective"
			speaker: #consts.Aria
			notes:   "There's a moment of vulnerability in her expression."
			infos:   (#SimpleInfos & {in: {
				prefix: "13_AriaResponseToReflective"
				texts: [
					"You've hit the nail on the head. I'm used to valuing time for productivity. Learning to value it just for the experience – that's new for me.",
				]
			}}).out
		},
	]
}
