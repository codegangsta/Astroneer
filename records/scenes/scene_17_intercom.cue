package scenes

scene_17_intercom: {
	id:     "17_Intercom"
	quest:  "ParentQuest"
	name:   "Intercom"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [{name: "Intercom"}]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "17_AriaResponse"
		},
	]
	topics: [
		{
			id:         "17_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "17_Intercom"
			infos:      (#SimpleInfos & {in: {
				prefix: "17_PlayerInquiry"
				texts: [
					"Why do we have to use the intercom to communicate?",
				]
			}}).out
		},
		{
			id:         "17_AriaResponse"
			startScene: "MAIN_topics"
			speaker:    #consts.Aria
			infos: [
				{
					id: "17_AriaResponse01"
					responses: [
						{
							text: "Ah, well, the workshop's in full reno mode. Picture this: a rogue drone, a misplaced laser cutter, and poof—suddenly you're embracing the minimalist aesthetic. Who knew drones were such critics of industrial design?"
						},
						{
							text: "Which means I'm marooned in my apartment, turning ship schematics and not much else. I've memorized every crack in the ceiling and named all my plant life. They're terrible conversationalists, by the way."
						},
						{
							text: "Working remote's the new rage, they say. It's all fun and games until you realize your fridge doesn't stock itself and your cat's been the boss all along. But hey, at least the commute's a breeze!"
						},
						{
							text: "Anyway, enough about my four-wall odyssey. Let's get back to spaceships and stars—because if I stare at this paint dry any longer, I might just start talking back to it."
						},
					]
				},
			]
		},
	]
}
