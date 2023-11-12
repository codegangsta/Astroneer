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
		{
			id:      "03_AriaExplorer"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "03_AriaExplorer"
				texts: [
					"An explorer's waiting. It's got more miles than my coffee machine and twice the untapped potential.",
					"I’ve got an explorer that’s seen galaxies galore. Ready to turn it into a space legend?",
					"There's a research ship that's been flirting with black holes. Needs a bit of your charm now.",
					"This explorer's got wanderlust. Think you can make it the envy of the cosmos?",
					"Here’s an explorer that's craving adventure. Ready to be its genie?",
				]
			}}).out
		},
		{
			id:      "03_AriaHauler"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "03_AriaHauler"
				texts: [
					"Got a hauler that's been lugging more than cargo. Time to jazz up its routine.",
					"There's a sturdy hauler here. Could use a touch of pizzazz. Fancy giving it some sparkle?",
					"Here's a freighter with dreams of being a starship. Think you can grant its wish?",
					"This old freighter's solid but could use some fun. How about disco lights in the cargo bay?",
					"There’s a hauler here with space to spare. Maybe add a bowling alley?",
				]
			}}).out
		},
		{
			id:      "03_AriaInterceptor"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "03_AriaInterceptor"
				texts: [
					"Interceptor in the bay is ready for some zing. Think you can make it zoom and boom?",
					"Got an interceptor that’s quick but not slick. Fancy giving it a secret identity?",
					"There’s a need-for-speed ship here. Think you can make it go 'vroom' with style?",
					"An interceptor's lined up. It’s fast, but can you make it furious?",
					"Here's a racer that's been dreaming of rocket boosters. Fancy turning it into a speed demon?",
				]
			}}).out
		},
		{
			id:      "03_AriaLuxury"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "03_AriaLuxury"
				texts: [
					"There's a luxury cruiser that's more plain Jane than star queen. Ready for a royal makeover?",
					"Got a fancy vessel that's feeling a bit old-fashioned. Time to bring it into the space age?",
					"There’s a floating five-star hotel here. Think you can add a sixth star?",
					"Ever fancied decking out a spaceship like a Hollywood mansion? Here’s your chance.",
					"Got a luxury ship here that's secretly a diva. Ready to dress it for the red carpet?",
				]
			}}).out
		},
	]
}
