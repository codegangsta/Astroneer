package scenes

scene_00_misc: {
	id:     "00_Misc"
	name:   "Miscellaneous"
	notes:  "Miscellaneous topics to be used as filler or transitions between scenes."
	actors: #consts.Actors
	topics: [
		{
			id:      "00_AriaGreeting"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaGreeting"
				texts: ["Hey, Cap!", "Back again?", "What's up?", "You're here!", "Hello!"]
			}}).out
		},
		{
			id:      "00_AriaGoodbye"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaGoodbye"
				texts: ["Catch ya!", "Fly safe!", "Later!", "Good luck!", "Signing off!"]
			}}).out
		},
		{
			id:      "00_AriaNegative"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaNegative"
				texts: ["No go.", "That's a no.", "Won't work.", "Can't do it.", "Nope."]
			}}).out
		},
		{
			id:      "00_AriaAffirmative"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaAffirmative"
				texts: ["Sure thing!", "Yes!", "You got it!", "Absolutely!", "Of course!"]
			}}).out
		},
		{
			id:      "00_AriaRedirection"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaRedirection"
				texts: ["Let's switch gears.", "Moving on to the next topic.", "Changing course.", "Let's pivot here.", "Time for a new direction."]
			}}).out
		},
		{
			id:      "00_AriaGratitude"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaGratitude"
				texts: ["Thanks, Cap!", "Appreciate it!", "Grateful for that.", "Much obliged!", "Cheers for that!"]
			}}).out
		},
		{
			id:      "00_AriaQuery"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaQuery"
				texts: ["What's up?", "What's on your mind?", "What's the plan?", "What's the word?", "What's the deal?"]
			}}).out
		},
		{
			id:      "00_AriaConfirmation"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaConfirmation"
				texts: ["Got it.", "Understood.", "Roger that.", "Clear on that.", "Acknowledged."]
			}}).out
		},
		{
			id:      "00_AriaInterest"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "00_AriaInterest"
				texts: ["Tell me more.", "Interesting...", "I'm intrigued.", "Go on...", "Keep talking."]
			}}).out
		},
	]
}
