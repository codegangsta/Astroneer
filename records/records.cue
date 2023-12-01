package records

import (
	s "github.com/codegangsta/astroneer/records/scenes"
	m "github.com/codegangsta/astroneer/records/messages"
	"list"
)

scenes: [
	s.scene_MAIN_topics,
	s.scene_00_misc,
	s.scene_01_intro,
	s.scene_02_greeting,
	s.scene_03_accept_contract,
	s.scene_04_complete_contract,
	s.scene_05_background,
	s.scene_06_player_background,
	s.scene_18_abandon_contract,
	s.scene_19_questions,
]

messages: list.Concat([
		m.ship_names,
		m.mission_texts,
])
