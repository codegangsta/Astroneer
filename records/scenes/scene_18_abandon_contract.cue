package scenes

scene_18_abandon_contract: {
	id:     "18_AbandonContract"
	name:   "Abandon Contract"
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Responses"},
	]
	actions: [
		{
			type:  #consts.ActionDialogue
			topic: "18_AriaResponse"
		},
	]
	topics: [
		{
			id:         "18_PlayerInquiry"
			speaker:    #consts.Player
			startScene: "18_AbandonContract"
			infos:      (#SimpleInfos & {in: {
				prefix: "18_PlayerInquiry"
				conditions: [
					{
						function: "GetStage"
						quest:    "ShipContractMission"
						equals:   20.0
					},
				]
				texts: [
					"I'm having trouble with this contract. Can we switch it up?",
				]
			}}).out
		},
		{
			id:      "18_AriaResponse"
			speaker: #consts.Aria
			script:  "Astroneer:Dialogue"
			onBegin: "AbandonContract"
			infos:   (#SimpleInfos & {in: {
				prefix: "18_AriaResponse"
				flags:  #consts.InfoFlagsRandom
				texts: [
					"No problem, Cap! Not every ship is a perfect match. I'll find this one a new captain.",
					"I'm updating the mission board right now. Let's find you a project that's more your speed.",
					"Sometimes a detour is part of the journey. Let's get you on a path that feels right.",
					"Keep your chin up. Space is vast, and there's always something else out there for you.",
				]
			}}).out
		},
	]
}
