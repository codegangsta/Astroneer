package scenes

scene_01_intro: {
	id:     "01_Intro"
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
			id:      "01_AriaIntro"
			speaker: #consts.Aria
			infos: [
				{
					id: "01_AriaIntro01"
					responses: [
						{text: "Whoa, an intercom call? That's a rare vintage. Aria here—your ship-building maestro and Atlas Astronautics' semi-official welcome wagon."},
						{text: "Let's talk ship. You're about to dive into the nuts and bolts of starship customization. I'll transfer the bare bones to your hangar, and you put the soul into the machine. Match the contract specs, and we're golden."},
						{text: "Once you're done, bring her back so we can give her the old spaceworthy stamp. Keep your sensors peeled out there—your handiwork will be zipping around the galaxy before you know it."},
						{text: "Got questions, or floating in confusion? Buzz me on this line. I'm like a walking, talking encyclopedia of space oddities, minus the boring parts."},
						{text: "I hear you're quite the pilot. So I'm calling you 'Cap' from here on out! Beats saying 'O Great Shipbuilder' every time, right?"},
						{text: "Alright, Cap. Aria signing off—don't be a stranger, or do, but come back with stories!"},
					]
				},
			]
		},
	]
}
