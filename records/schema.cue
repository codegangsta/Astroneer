package records

#Topic: {
	id:               string
	speaker?:         string
	startScene?:      string
	startScenePhase?: string
	script?:          string
	onBegin?:         string
	onEnd?:           string
	infos: [
		...{
			id: string
			responses: [
				...{
					text: string
				},
			]
		},
	]
}

#Scene: {
	id: string
	topics: [...#Topic]
}

scenes: [ ...#Scene]
