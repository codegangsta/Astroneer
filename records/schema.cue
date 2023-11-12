package records

// Represents a DIAL record on a QUST
#Topic: {
	// Editor ID of the DIAL record to generate
	id: string
	// Optional notes for the topic
	notes?: string
	// Editor ID of the speaker
	speaker?: string
	// Editor ID of the scene to start at the end of this topic
	startScene?: string
	// Phase name to start at the end of this topic
	startScenePhase?: string
	// Name of the script to run as a fragment either at the beginning or end of this topic
	script?: string
	// Script function name to run at the beginning of this topic
	onBegin?: string
	// Script function name to run at the end of this topic
	onEnd?: string
	// Topic info records
	infos: [
		...{
			// ID of the INFO record to generate. Useful for linking to other topics.
			// Required to keep generation generally idempotent
			id: string
			// List of responses in the INFO record
			responses: [
				...{
					text: string
				},
			]
		},
	]
}

#Scene: {
	// Editor ID of the scene to generate
	id: string
	// Name of the scene, used for internal reference
	name: string
	// Optional notes for the scene
	notes?: string
	// List of phases in the scene
	topics: [...#Topic]
}

scenes: [ ...#Scene]
