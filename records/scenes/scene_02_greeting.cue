package scenes

scene_02_greeting: {
	id:   "02_Greeting"
	name: "Aria Greets the Player"
	topics: [
		{
			id:      "02_AriaGreeting"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "02_AriaGreeting"
				texts: [
					"Hey there, Cap! What ship are we tackling today?",
					"Back for more? Let's see what's on the docket.",
					"Hello again! Ready to jump into another design?",
					"Got a new ship on your mind? Let's hear it.",
					"Ah, the master shipwright returns. What's the plan?",
					"Hey! What exciting project are we looking at today?",
					"Welcome back! Any new adventures in ship design?",
					"Hi there! What ship will we be shaping up today?",
					"Ready for another round of shipbuilding?",
					"Great to see you! What's our design mission this time?",
				]
			}}).out
		},
	]
}
