package scenes

#consts: {
	Aria:        "AriaCollins"
	Player:      "" // Keep blank to make null
	AliasAria:   0
	AliasPlayer: -2
	Actors: [AliasPlayer]
	ActionDialogue:       0
	ActionPlayerDialogue: 3
	SceneFlags:           "0000100000001"
	InfoFlagsRandom:      "01"
	InfoFlagsRandomNoLip: "010000000001"
	InfoFlagsNoLip:       "000000000001"
	StatusNotReady:       0 // Not ready for recording
	StatusReady:          1 // Ready for recording
	StatusRecorded:       2 // Recorded
	StatusInGame:         3 // In game
}

#ID: {
	name: string
	idx:  int

	if idx < 10 {out: "\(name)0\(idx)"}
	if idx >= 10 {out: "\(name)\(idx)"}
}

// SimpleInfo renders dialog infos inside of a topic and generates
// IDs automatically. Great for topics with a lot of infos that
// may be chosen randomly.
#SimpleInfos: {
	in: {
		prefix: string
		voice:  bool | *false
		texts: [...string]
		flags?: string
		conditions?: [
			...{
				function: string

				if function == "GetStage" {
					quest:  string
					equals: float
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
	}
	out: [
		for index, info in in.texts {
			id: (#ID & {name: in.prefix, idx: index + 1}).out
			responses: [
				{
					text:  info
					voice: in.voice
				},
			]
			if in.conditions != _|_ {
				conditions: in.conditions
			}
			if in.flags != _|_ {
				flags: in.flags
			}
		},
	]
}
