package scenes

scene_11_reflect: {
	id:     "11_Reflect"
	quest:  "ParentQuest"
	name:   "Reflecting on Personal Growth"
	notes:  "In this scene, Aria starts off guarded, her usual self-assurance masking deeper uncertainties. As the player engages, she gradually reveals more of her introspective side."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
	]
	actions: [
		{
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "11_PlayerResponseUnderstanding"
					response: "11_AriaResponseToUnderstanding"
				},
				{
					topic:    "11_PlayerResponsePractical"
					response: "11_AriaResponseToPractical"
				},
				{
					topic:    "11_PlayerResponseCurious"
					response: "11_AriaResponseToCurious"
				},
				{
					topic:    "11_PlayerResponseCandid"
					response: "11_AriaResponseToCandid"
				},
			]
		},
	]
	topics: [
		{
			id:         "11_AriaInquiry"
			speaker:    #consts.Aria
			startScene: "11_Reflect"
			script:     "Astroneer:Dialogue"
			onEnd:      "CompleteDialogueReflect"
			notes:      "Aria, maintaining a composed exterior"
			infos:      (#SimpleInfos & {in: {
				prefix: "11_AriaInquiry"
				conditions: [
					{
						function:          "GetRandomPercent"
						lessThanOrEqualTo: 30.0
					},
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueIntroComplete"
						equals:   1.0
					},
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueBackgroundComplete"
						equals:   1.0
					},
					{
						function: "GetVMQuestVariable"
						quest:    "ParentQuest"
						variable: "DialogueReflectComplete"
						equals:   0.0
					},
				]
				texts: [
					"Cap, do you ever think we get so wrapped up in our goals that we miss... life happening around us? Not that I'm second-guessing myself, it's just a thought.",
				]
			}}).out
		},
		{
			id:      "11_PlayerResponseUnderstanding"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "11_PlayerResponseUnderstanding"
				texts: [
					"It's natural to wonder, Aria. Maybe it's not about changing course, but just taking a moment to appreciate where you are.",
				]
			}}).out
		},
		{
			id:      "11_PlayerResponsePractical"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "11_PlayerResponsePractical"
				texts: [
					"Focused as we are, it's easy to lose sight of other things. But balance is important, isn't it?",
				]
			}}).out
		},
		{
			id:      "11_PlayerResponseCurious"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "11_PlayerResponseCurious"
				texts: [
					"That's quite introspective. Are you feeling like you're at a turning point, perhaps?",
				]
			}}).out
		},
		{
			id:      "11_PlayerResponseCandid"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "11_PlayerResponseCandid"
				texts: [
					"Overdrive can make us miss the finer details of life. Maybe slowing down a bit isn't such a bad idea.",
				]
			}}).out
		},
		{
			id:         "11_AriaResponseToUnderstanding"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "She offers a small, contemplative smile."
			infos:      (#SimpleInfos & {in: {
				prefix: "11_AriaResponseToUnderstanding"
				texts: [
					"I suppose you're right. It wouldn't hurt to stop and look around once in a while. There's more to life than just the next achievement.",
				]
			}}).out
		},
		{
			id:         "11_AriaResponseToPractical"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "With a slight nod, she acknowledges the wisdom."
			infos:      (#SimpleInfos & {in: {
				prefix: "11_AriaResponseToPractical"
				texts: [
					"Balance... That's something I've not been great at. Maybe it's time to recalibrate a little.",
				]
			}}).out
		},
		{
			id:         "11_AriaResponseToCurious"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "There's a pause as she ponders."
			infos:      (#SimpleInfos & {in: {
				prefix: "11_AriaResponseToCurious"
				texts: [
					"Turning point? I don't know about that, but it's healthy to question things, right? To make sure we're still on track.",
				]
			}}).out
		},
		{
			id:         "11_AriaResponseToCandid"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Initially bristling, she then concedes."
			infos:      (#SimpleInfos & {in: {
				prefix: "11_AriaResponseToCandid"
				texts: [
					"I've always been pedal to the metal, but you've got a point. Maybe I do need to ease off the accelerator and enjoy the ride more.",
				]
			}}).out
		},
	]
}
