// Schema for the dialogue system
#topic: {
	id:               string
	speaker?:         string
	startScene?:      string
	startScenePhase?: string
	script?:          string
	onBegin?:         string
	onEnd?:           string
	infos: [
		{
			id: string
			responses: [
				...{
					text: string
				},
			]
		},
	]
}
#topics: [...#topic]

topics: #topics
topics: [
	{
		id:              "DialogueTest"
		speaker:         "AriaCollins"
		startScene:      "Scene_Aria_Greet"
		startScenePhase: "TestPhase"
		script:          "Astroneer:Dialog"
		onBegin:         "OnBegin"
		onEnd:           "OnBegin"
		infos: [
			{
				id: "DialogueTest01"
				responses: [
					{
						text: "Hello world"
					},
				]
			},
		]
	},
]
