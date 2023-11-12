package scenes

scene_08_startup: {
	id:    "08_Startup"
	name:  "Startup vs Corporations"
	notes: "In this scene, Aria explains her choice of leaving a stable corporate job for a dynamic startup environment, subtly indicating her personal drive and aspiration despite the inherent risks."
	topics: [
		{
			id:      "08_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "08_PlayerInquiry"
				texts: [
					"Why leave the stability of a big corporation for a startup?",
				]
			}}).out
		},
		{
			id:      "08_AriaResponse"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "08_AriaResponse"
				texts: [
					"In corporations, you're a cog in a vast machine. I needed more than that. I wanted to create, to have my designs mean something more than just profit.",
					"Atlas Astronautics? It's uncharted territory, full of risk, sure, but alive with potential. It's not just a job; it's a chance to make real impact, to innovate.",
				]
			}}).out
		},
		{
			id:      "08_PlayerResponseUnderstandingCorporate"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "08_PlayerResponseUnderstandingCorporate"
				texts: [
					"Seems like you were after something meaningful, not just routine. That's impressive.",
				]
			}}).out
		},
		{
			id:      "08_PlayerResponseCriticalCorporate"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "08_PlayerResponseCriticalCorporate"
				texts: [
					"But there's a lot at stake with startups. Aren't you worried about stability?",
				]
			}}).out
		},
		{
			id:      "08_PlayerResponseEnthusiasticStartup"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "08_PlayerResponseEnthusiasticStartup"
				texts: [
					"Risk is part of progress. You must be excited to have that freedom for your ideas.",
				]
			}}).out
		},
		{
			id:      "08_PlayerResponseSkepticalStartup"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "08_PlayerResponseSkepticalStartup"
				texts: [
					"Is it worth the risk, though? How do you balance that with the need for security?",
				]
			}}).out
		},
		{
			id:      "08_AriaResponseToUnderstandingCorporate"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "08_AriaResponseToUnderstandingCorporate"
				texts: [
					"Right. Stability is comforting, but there's no real growth in comfort. At Atlas, every day is a chance to be part of something new, something big.",
				]
			}}).out
		},
		{
			id:      "08_AriaResponseToCriticalCorporate"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "08_AriaResponseToCriticalCorporate"
				texts: [
					"It's a gamble, I won't lie. But sometimes, you have to risk the safety net to reach higher. We might stumble, but we're also free to soar.",
				]
			}}).out
		},
		{
			id:      "08_AriaResponseToEnthusiasticStartup"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "08_AriaResponseToEnthusiasticStartup"
				texts: [
					"Exactly, it's exhilarating! There's this energy here, a buzz of creating something from scratch. That's where true innovation happens.",
				]
			}}).out
		},
		{
			id:      "08_AriaResponseToSkepticalStartup"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "08_AriaResponseToSkepticalStartup"
				texts: [
					"It's a tough call. But I believe in calculated risks. Atlas is a leap, but it's not blind faith. It's about chasing something bigger, something meaningful.",
				]
			}}).out
		},
	]
}
