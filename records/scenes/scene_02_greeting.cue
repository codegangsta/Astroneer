package scenes

scene_02_greeting: {
	id:     "02_Greeting"
	quest:  "ParentQuest"
	name:   "Aria Greets the Player"
	notes:  "The player has just accepted a mission from the mission board and has walked over to the Atlas Astronautics intercom to speak with Aria. Upon pushing the 'Call' button, Aria responds from the intercom. This response is typically played after the introductory quest, so Aria has already been introduced to the player."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Greet"},
	]
	actions: [
		{
			name:  "Intro Dialogue"
			type:  #consts.ActionDialogue
			topic: "01_AriaIntro"
		},
		{
			name:  "Aria Greeting"
			type:  #consts.ActionDialogue
			topic: "02_AriaGreeting"
		},
	]
	topics: [
		{
			id:         "02_AriaGreeting"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			infos:      (#SimpleInfos & {in: {
				prefix: "02_AriaGreeting"
				flags:  #consts.InfoFlagsRandomNoLip
				voice:  true
				texts: [
					"Hey there, Cap! What ship are we tackling today?",
					"Back for more? Let's see what's on the docket.",
					"Hello again! Ready to jump into another design?",
					"Got a new ship on your mind? Let's hear it.",
					"Ah, the master shipwright returns. What's the plan?",
					"Hey! What exciting project are we looking at today?",
					"Welcome back! Any new adventures in ship design?",
					"Well hello there! What ship will we be shaping up today?",
					"Ready for another round of shipbuilding?",
					"What's our design mission this time?",
				]
			}}).out
		},
	]
}
