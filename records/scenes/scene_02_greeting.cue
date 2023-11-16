package scenes

scene_02_greeting: {
	id:     "02_Greeting"
	name:   "Aria Greets the Player"
	notes:  "The player has just accepted a mission from the mission board and has walked over to the Atlas Astronautics intercom to speak with Aria. Upon pushing the 'Call' button, Aria responds from the intercom. This response is typically played after the introductory quest, so Aria has already been introduced to the player."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Greet"},
	]
	actions: [
		{
			name:  "Aria's Reflection"
			type:  #consts.ActionDialogue
			topic: "11_AriaInquiry"
		},
		{
			name:  "Bad news from home"
			type:  #consts.ActionDialogue
			topic: "12_AriaInquiry"
		},
		{
			name:  "Intro Dialogue"
			type:  #consts.ActionDialogue
			topic: "01_AriaIntro"
		},
		{
			name:  "Aria Funny Greetings"
			type:  #consts.ActionDialogue
			topic: "02_AriaGreetingFunny"
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
				flags:  #consts.InfoFlagsRandom
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
		{
			id:         "02_AriaGreetingFunny"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			infos:      (#SimpleInfos & {in: {
				prefix: "02_AriaGreetingFunny"
				flags:  #consts.InfoFlagsRandom
				conditions: [
					{
						function:          "GetRandomPercent"
						lessThanOrEqualTo: 3.0
					},
				]
				texts: [
					"Hello from Aria's isolation station! If I start making spaceship noises, just go with it.",
					"Atlas’s remote ship designer here, where my biggest debate is talking to the toaster or the TV. What’s your crisis?",
					"Day 47 in the apartment wilderness, and I've started assigning starship roles to my furniture. What can I do for you?",
					"Reporting from Fort Couch Cushion. If I don't design something soon, I might start crafting a spaceship out of pillows. Help?",
					"Aria’s remote work hub, where the space adventures are imaginary, but the boredom is real. Got any projects to save me?",
					"Hey, Cap! Ready to swap my solo monologue for some actual dialogue. What’s on the drawing board?",
					"Greetings from my personal space dock – also known as the living room. Let's brainstorm before I start chatting with the ceiling fan.",
					"Stir-crazy ship designer Aria here, currently debating space ethics with my reflection. What's our mission?",
					"Shuttle commander of the S.S. Sofa at your service. Shall we embark on a design journey today?",
					"Aria, reporting from the homefront! I'm one cup of coffee away from teaching my plant astrophysics. What's on the agenda?",
					"Your trusty starship engineer, now doubling as an apartment explorer. Found anything interesting out there in the real world?",
					"Broadcasting live from Aria’s space station (aka my kitchen). Let's talk ships before I start making rocket ships out of cutlery.",
					"Who's there? Oh, just me, Aria, chatting with the door again. Let's focus on something productive, shall we?",
					"Mission control (aka my window seat) to Cap. I'm ready for some actual work before I start mapping constellations in my coffee.",
					"Welcome to Aria's interstellar talk show, where the guest list is... well, nonexistent. Let's make some spaceship magic!",
				]
			}}).out
		},
	]
}
