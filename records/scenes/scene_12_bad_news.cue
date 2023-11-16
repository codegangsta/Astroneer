package scenes

scene_12_bad_news: {
	id:     "12_BadNews"
	name:   "Bad News from Home"
	notes:  "Aria is subdued, and the player can sense something is wrong. Aria reveals that her sister is ill, and she's feeling the distance from home. The player can offer support and encouragement."
	actors: #consts.Actors
	flags:  #consts.SceneFlags
	phases: [
		{name: "Aria Response"},
		{name: "Player Response"},
		{name: "Player Followup Responses"},
		{name: "Player Deeper Responses"},
	]
	actions: [
		{
			name:       "Player Responses"
			type:       #consts.ActionPlayerDialogue
			startPhase: 1
			endPhase:   1
			choices: [
				{
					topic:    "12_PlayerResponseConcerned"
					response: "12_AriaResponseToConcerned"
				},
				{
					topic:    "12_PlayerResponseGentleProbing"
					response: "12_AriaResponseToGentleProbing"
				},
				{
					topic:    "12_PlayerResponseRespectfulDistance"
					response: "12_AriaResponseToRespectfulDistance"
				},
				{
					topic:    "12_PlayerResponseDirect"
					response: "12_AriaResponseToDirect"
				},
			]
		},
		{
			name:       "Player Followup Responses"
			type:       #consts.ActionPlayerDialogue
			startPhase: 2
			endPhase:   2
			choices: [
				{
					topic:    "12_PlayerFollowupResponseSympathetic"
					response: "12_AriaFollowupResponseToSympathetic"
				},
				{
					topic:    "12_PlayerFollowupResponseInquisitive"
					response: "12_AriaFollowupResponseToInquisitive"
				},
				{
					topic:    "12_PlayerFollowupResponseSupportive"
					response: "12_AriaFollowupResponseToSupportive"
				},
				{
					topic:    "12_PlayerFollowupResponseNonIntrusive"
					response: "12_AriaFollowupResponseToNonIntrusive"
				},
			]
		},
	]
	topics: [
		{
			id:         "12_AriaInquiry"
			speaker:    #consts.Aria
			startScene: "12_BadNews"
			script:     "Astroneer:Dialogue"
			onEnd:      "CompleteDialogueBadNews"
			notes:      "Aria appears on the intercom, her usual vibrancy dimmed, her tone subdued."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaInquiry"
				conditions: [
					{
						function:          "GetRandomPercent"
						lessThanOrEqualTo: 20.0
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
						variable: "DialogueBadNewsComplete"
						equals:   0.0
					},
				]
				texts: [
					"Hey, Cap... Sorry, I'm a bit out of sorts today. What's up?",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseConcerned"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseConcerned"
				texts: [
					"You don’t seem yourself. Anything you want to share?",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseGentleProbing"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseGentleProbing"
				texts: [
					"You're usually more animated, Aria. Is something troubling you?",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseRespectfulDistance"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseRespectfulDistance"
				texts: [
					"If you're not up for talking, that's okay. We can keep it work-related if you prefer.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseDirect"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseDirect"
				texts: [
					"You look like something's weighing on you. If you want to talk, I'm here.",
				]
			}}).out
		},
		{
			id:      "12_AriaResponseToConcerned"
			speaker: #consts.Aria
			notes:   "She hesitates, offering a strained smile."
			infos:   (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToConcerned"
				texts: [
					"Just family things, you know? It's tough being so far away sometimes.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToGentleProbing"
			speaker:    #consts.Aria
			notes:      "Aria lets out a soft sigh."
			startScene: "12b_BadNews"
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToGentleProbing"
				texts: [
					"It's hard to hide anything from you, isn't it? It's my little sister; shes ill. And I'm here, worlds away. Makes you think about life choices.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToRespectfulDistance"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Gratefully nodding"
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToRespectfulDistance"
				texts: [
					"Thanks for understanding. Let's just focus on work today. Helps to keep the mind occupied.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToDirect"
			speaker:    #consts.Aria
			notes:      "Pausing briefly"
			startScene: "12b_BadNews"
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToDirect"
				texts: [
					"I appreciate your straightforwardness. It's my little sister; shes ill. And I'm here, worlds away.",
				]
			}}).out
		},
		{
			id:      "12_PlayerFollowupResponseSympathetic"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerFollowupResponseSympathetic"
				texts: [
					"It's tough, being so far. If talking about it helps, I'm here to listen.",
				]
			}}).out
		},
		{
			id:      "12_PlayerFollowupResponseInquisitive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerFollowupResponseInquisitive"
				texts: [
					"Do you feel like being here, pursuing your dreams, is worth the distance from family?",
				]
			}}).out
		},
		{
			id:      "12_PlayerFollowupResponseSupportive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerFollowupResponseSupportive"
				texts: [
					"Focus on what you can control, Aria. You're doing important work here.",
				]
			}}).out
		},
		{
			id:      "12_PlayerFollowupResponseNonIntrusive"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerFollowupResponseNonIntrusive"
				texts: [
					"We don’t have to talk about it more if you don’t want to. Just know, you’re not alone.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseEmpathy"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseEmpathy"
				texts: [
					"It's never easy to be away from family, especially in times like these. If you need to talk or just take a break, I'm here.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponsePracticalSupport"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponsePracticalSupport"
				texts: [
					"That's tough to hear. Are there ways we can help from here? Maybe there's something we can do, even from afar.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseSharedExperience"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseSharedExperience"
				texts: [
					"I've been there, Aria. Distance can make these things harder. Just remember, she knows you're thinking of her.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseEncouragingOptimism"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseEncouragingOptimism"
				texts: [
					"I'm sorry about your sister. Let's hold onto hope, though. Sometimes, good news can travel just as fast as the bad.",
				]
			}}).out
		},
		{
			id:      "12_PlayerResponseOfferSpace"
			speaker: #consts.Player
			infos:   (#SimpleInfos & {in: {
				prefix: "12_PlayerResponseOfferSpace"
				texts: [
					"If you need some time to process this or make a call, take all the time you need. Work can wait.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToEmpathy"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Aria's eyes reflect gratitude."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToEmpathy"
				texts: [
					"Thanks. It means a lot just knowing you're here to listen. Makes the distance feel a little less vast.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToPracticalSupport"
			speaker:    #consts.Aria
			notes:      "She considers this."
			startScene: "MAIN_topics"
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToPracticalSupport"
				texts: [
					"That's a kind thought. Maybe there's something we can do from here. I'll think about it. Thank you.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToSharedExperience"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "You can see the comfort in her expression."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToSharedExperience"
				texts: [
					"It helps to know someone understands. Just having people around who get it... it's a big deal.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToEncouragingOptimism"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Her smile is small but genuine."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToEncouragingOptimism"
				texts: [
					"Optimism, right? I need a bit of that right now. Thanks for the reminder to stay hopeful.",
				]
			}}).out
		},
		{
			id:         "12_AriaResponseToOfferSpace"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Relief washes over her."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaResponseToOfferSpace"
				texts: [
					"I might take you up on that. Just a little time to gather my thoughts could help. Thanks, Cap.",
				]
			}}).out
		},
		{
			id:         "12_AriaFollowupResponseToSympathetic"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "Her eyes soften."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaFollowupResponseToSympathetic"
				texts: [
					"Thanks, it means a lot. Sometimes I wonder if I made the right choice, being here while my family's back there.",
				]
			}}).out
		},
		{
			id:         "12_AriaFollowupResponseToInquisitive"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "She looks thoughtful."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaFollowupResponseToInquisitive"
				texts: [
					"That's the question, isn't it? I believe in what I'm doing here, but at moments like this, I question the cost.",
				]
			}}).out
		},
		{
			id:         "12_AriaFollowupResponseToSupportive"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "A nod of acknowledgement."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaFollowupResponseToSupportive"
				texts: [
					"You're right. I chose this path for a reason. Just need to remember why on days like this.",
				]
			}}).out
		},
		{
			id:         "12_AriaFollowupResponseToNonIntrusive"
			speaker:    #consts.Aria
			startScene: "MAIN_topics"
			notes:      "There's a hint of relief in her voice."
			infos:      (#SimpleInfos & {in: {
				prefix: "12_AriaFollowupResponseToNonIntrusive"
				texts: [
					"I appreciate that, really. Sometimes just knowing someone's there to listen is enough.",
				]
			}}).out
		},
	]
}
