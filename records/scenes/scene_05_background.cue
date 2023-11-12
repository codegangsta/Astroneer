package scenes

scene_05_background: {
	id:     "05_Background"
	name:   "Aria's Background"
	actors: #consts.Actors
	topics: [
		{
			id:      "05_PlayerInquiry"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "05_PlayerInquiry"
				texts: [
					"Can you tell me more about yourself?",
				]
			}}).out
		},
		{
			id:      "05_AriaResponse"
			speaker: #consts.Aria
			infos:   (#SimpleInfos & {in: {
				prefix: "05_AriaResponse"
				texts: [
					"More about me? Well, let's see... I'm a product of the colonies. A tiny speck on the edge of the frontier that you won't find on any tourist brochure. The scrapyard was my playground, I dreamt of one day inventing something big and important, something that would propel humanity forward. My folks figured I'd be a mechanic, but I had my eyes on the stars and my mind on the ships that could reach them.",
					"So, I made it off-world, thanks to a scholarship at the University here. It was my shot, my big break. I was going to build the future. But the corporate shipyards weren't buying what a starry-eyed colony kid was selling.",
					"But then, Atlas Astronautics happened. A startup with ambition and, more importantly, a willingness to gamble on a wildcard like me. They needed someone who could think outside the proverbial box—or ship, in this case. So I jumped ship—literally—and it's been a wild ride since.",
					"I'm not just building ships here. I'm building dreams—my dreams—into every hull, every thruster array. And yeah, I miss home sometimes, but this place... it's where I can make a real impact. It's where I belong.",
					"And when things get too serious, I just remind myself that no matter how advanced our tech gets, we're still a bunch of primates trying to figure out how to not crash into the nearest celestial body. It's grounding, in an anti-gravity sort of way.",
					"What else would you like to know?",
				]
			}}).out
		},
	]
}