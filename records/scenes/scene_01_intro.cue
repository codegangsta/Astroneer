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
						{text: "There's the captain everyone's been talking about! I'm Aria, I'll be your design lead for all ship contracts here at Atlas", voice:                 true},
						{text: "Let's talk ship. You're about to dive into the nuts and bolts of starship customization.", voice:                                                   true},
						{text: "I'll pull the bare bones into the landing pad back there, and you put the soul into it. Match the client's requirements, and we're golden.", voice: true},
						{text: "Currently, our parts bin isn't exactly a treasure trove. But hey, help us some research projects, and we'll get you the shiny stuff.", voice:       true},
						// {text: "I hear you're quite the pilot. So I'm calling you 'Cap' from here on out! Beats saying 'O Great Shipbuilder' every time, right?", voice:                     true},
						{text: "Alright, Cap. Let's get to work!", voice: true},
					]
				},
			]
		},
	]
}
