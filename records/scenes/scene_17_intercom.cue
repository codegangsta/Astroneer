package scenes

scene_17_intercom: {
	id:   "17_Intercom"
	name: "Intercom"
	topics: [
		{
			id:      "17_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "17_PlayerInquiry"
				texts: [
					"Why do we have to use the intercom to communicate?",
				]
			}}).out
		},
		{
			id:      "17_AriaResponse"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "17_AriaResponse"
				texts: [
					"Ah, well, the workshop's in full reno mode. Picture this: a rogue drone, a misplaced laser cutter, and poof—suddenly you're embracing the minimalist aesthetic. Who knew drones were such critics of industrial design?",
					"Which means I'm marooned in my apartment, turning ship schematics and not much else. I've memorized every crack in the ceiling and named all my plant life. They're terrible conversationalists, by the way.",
					"Working remote's the new rage, they say. It's all fun and games until you realize your fridge doesn't stock itself and your cat's been the boss all along. But hey, at least the commute's a breeze!",
					"Anyway, enough about my four-wall odyssey. Let's get back to spaceships and stars—because if I stare at this paint dry any longer, I might just start talking back to it.",
				]
			}}).out
		},
	]
}
