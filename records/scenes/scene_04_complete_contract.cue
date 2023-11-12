package scenes

scene_04_complete_contract: {
	id:   "04_CompleteContract"
	name: "Player Accepts Contract"
	topics: [
		{
			id:      "04_Player"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "04_Player"
				texts: [
					"Design's in. Does it capture what you were looking for?",
					"Finished with the ship. How does it measure up to our standards?",
					"Completed the contract. What's your take on the final product?",
					"Just finished my design. Will it pass the Aria test?",
					"Redesign's done. Does it have the Aria stamp of approval?",
					"Contract's done. I'm eager to hear your thoughts.",
					"Wrapped up the ship. It should meet the mark.",
					"Finished the upgrade. It's ready for your review.",
					"The ship's reimagined, per your vision.",
					"Ship is done. It's a fresh take on an old classic.",
				]
			}}).out
		},
		{
			id:      "04_AriaFighter"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaFighter"
				texts: [
					"Nice work! This fighter's gone from zero to hero.",
					"Looks sharp! It’s got stealth and swagger in spades.",
					"You've turned it tough! It's ready to rumble now.",
					"Sleek job! It's like a race car of the skies.",
					"Stellar work! This fighter's ready for its own saga.",
				]
			}}).out
		},
		{
			id:      "04_AriaExplorer"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaExplorer"
				texts: [
					"Great update! It's a real cosmic explorer now.",
					"It's a star-traveler's dream! Love the new look.",
					"Those sensors are top-notch. It's a galaxy whisperer now.",
					"You've given it a real adventurous edge. Nice!",
					"Love it! It's like a toolbox of space wonders.",
				]
			}}).out
		},
		{
			id:      "04_AriaHauler"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaHauler"
				texts: [
					"This hauler's a real gem now. It's got style and space!",
					"You turned it chic! It's a fashion-forward freighter.",
					"Massive upgrade! It's a cargo metropolis now.",
					"From sturdy to stunning! It's a cargo showstopper.",
					"Wow, talk about an upgrade! It's a planet mover!",
				]
			}}).out
		},
		{
			id:      "04_AriaInterceptor"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaInterceptor"
				texts: [
					"This interceptor's slick and secretive now. Nice touch!",
					"That's some speed! It's a real cosmic blur.",
					"Super quick! It's got an extra dose of zoom.",
					"Instant action! This ship's redefining speed.",
					"Sleek and fast! It's a racer's dream.",
				]
			}}).out
		},
		{
			id:      "04_AriaLuxury"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "04_AriaLuxury"
				texts: [
					"It's like a floating palace. Absolutely luxurious!",
					"You've raised the bar! It's luxury cruising at its best.",
					"Pure elegance! Every inch whispers class.",
					"Opulent and grand! It's a journey in style.",
					"Cozy and lavish! It's a five-star trip through space.",
				]
			}}).out
		},
	]
}
