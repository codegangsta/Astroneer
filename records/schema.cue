package records

import (
	"crypto/sha1"
	"encoding/hex"
	"strings"
)

#Action: {
	type:        0 | 3
	name?:       string
	startPhase?: int
	endPhase?:   int

	// Dialogue
	if type == 0 {
		topic: string
	}

	// Player Dialogue
	if type == 3 {
		choices: [
			...{
				topic:     string
				response?: string
			},
		]
	}
}

#Phase: {
	name: string
}

// Represents a DIAL record on a QUST
#Topic: {
	// Editor ID of the DIAL record to generate
	id: string
	// Flags to set on the DIAL record
	flags?: string
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
			// response flags
			flags?: string
			// List of responses in the INFO record
			responses: [
				...{
					text:  string
					voice: bool | *false
					if voice == true {
						// This is bullshit, but whatever
						wemfile: strings.Join(["00", strings.SliceRunes(hex.Encode(sha1.Sum(text)), 0, 6)], "")
					}
				},
			]
			conditions?: [
				...{
					function: string

					if function == "GetStage" {
						quest:  string
						equals: float
						or?:    bool
					}

					if function == "GetVMQuestVariable" {
						quest:    string
						equals:   float
						variable: string
					}

					if function == "GetRandomPercent" {
						lessThanOrEqualTo: float
					}
				},
			]
		},
	]
}

#Scene: {
	// Editor ID of the scene to generate
	id: string
	// Editor ID of the quest to generate the scene on
	quest: string
	// Name of the scene, used for internal reference
	name: string
	// Current production status of the scene, see consts for possible values
	status: int | *0
	// Flags to set on the scene
	flags?: string
	// Optional notes for the scene
	notes?: string
	// Actor aliases
	actors?: [...int]
	// List of phases in the scene
	phases?: [...#Phase]
	// List of actions in the scene
	actions?: [...#Action]
	// List of phases in the scene
	topics?: [...#Topic]
}

#Message: {
	id:      string
	message: string
	form_lists?: [...string]
}

scenes: [ ...#Scene]
messages: [ ...#Message]
