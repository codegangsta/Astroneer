package scenes

scene_03_accept_contract: {
	id:   "03_AcceptContract"
	name: "Player Accepts Contract"
	topics: [
		{
			id:      "03_Player"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "03_Player"
				texts: [
					"Any ships in need of a hand today?",
					"Is there a new vessel for me to take under my wing?",
					"Got a ship that needs some love?",
					"I'm here for that contract—what's the assignment?",
					"What's the latest ship on the roster?",
					"Ready for a new project; what have you got?",
					"Looking for a ship that could use a tune-up?",
					"Heard about a ship needing a fix, is it mine to take?",
					"What's the word on that new contract?",
				]
			}}).out
		},
		{
			id:      "03_AriaFighter"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "03_AriaFighter"
				texts: [
					"Got a fighter that's seen better days. Time to turn it from a zero to a hero.",
					"There's a fighter itching for some speed. Think you can make it break the sound barrier... quietly?",
					"Here’s a fighter that's begging for some flair. Ready to spice it up?",
					"This one's a zippy fighter, but it's more mouse than lion right now. Fancy beefing it up?",
					"Got a veteran fighter here. Fancy turning its old stories into new legends?",
				]
			}}).out
		},
	]
}
