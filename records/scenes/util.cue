package scenes

#consts: {
	Aria:        "AriaCollins"
	Player:      "Player"
	AliasAria:   0
	AliasPlayer: -2
	Actors: [AliasPlayer]
	ActionDialogue:       0
	ActionPlayerDialogue: 3
	SceneFlags:           "0000100000001"
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
		texts: [...string]
		conditions?: [
			...{
				function: string
				quest:    string
				equals:   float
			},
		]
	}
	out: [
		for index, info in in.texts {
			id: (#ID & {name: in.prefix, idx: index + 1}).out
			responses: [
				{text: info},
			]
			if in.conditions != _|_ {
				conditions: in.conditions
			}
		},
	]
}
