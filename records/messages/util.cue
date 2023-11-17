package messages

#ID: {
	name: string
	idx:  int

	if idx < 10 {out: "\(name)0\(idx)"}
	if idx >= 10 {out: "\(name)\(idx)"}
}

#MessageList: {
	in: {
		prefix: string
		messages: [...string]
		form_lists?: [...string]
	}
	out: [
		for index, msg in in.messages {
			id:      (#ID & {name: in.prefix, idx: index}).out
			message: msg

			if in.form_lists != _|_ {
				form_lists: in.form_lists
			}
		},
	]
}
