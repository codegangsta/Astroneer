package scenes

scene_01_intro: {
	id:     "01_Intro"
	quest:  "ParentQuest"
	name:   "Aria is Introduced to the Player"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Intro"},
	]
	actions: [
		{
			name:  "Aria Intro Dialogue"
			type:  #consts.ActionDialogue
			topic: "01_AriaIntro"
		},
	]
	topics: [
		{
			id:         "01_AriaIntro"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			script:     "Astroneer:Dialogue"
			onEnd:      "CompleteIntro"
			infos: [
				{
					id: "01_AriaIntro01"
					conditions: [
						{
							function: "GetVMQuestVariable"
							quest:    "ParentQuest"
							variable: "DialogueIntroComplete"
							equals:   0.0
						},
					]
					responses: [
						{text: "Whoa, an intercom call? That's a rare vintage. Aria here—your ship-building maestro and Atlas Astronautics' semi-official welcome wagon."},
						{text: "Here’s the deal: I supply ship parts, you make them awesome. Match the specs, dazzle me."},
						{text: "Starting out, our parts bin isn't exactly a treasure trove. But hey, do some research, and we'll get you the shiny stuff."},
						{text: "Stuck or curious? Ping me. I'm like a shipbuilding oracle, but with more jokes and less cryptic mumbo jumbo."},
						{text: "I'm dubbing you 'Cap'. Short, sweet, and saves time. I mean, 'Esteemed Shipwright' is a bit of a mouthful, right?"},
						{text: "Okay, Cap, Aria out. Don't be a stranger, and keep your eyes on the prize - or, you know, the mission board."},
					]
				},
			]
		},
	]
}
