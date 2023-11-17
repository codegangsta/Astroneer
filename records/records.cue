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
	s.scene_07_colony_life,
	s.scene_08_startup,
	s.scene_09_work_satisfaction,
	s.scene_10_alternate_paths,
	s.scene_11_reflect,
	s.scene_12_bad_news,
	s.scene_12b_bad_news,
	s.scene_13_hidden_passions,
	s.scene_14_legacy,
	s.scene_15_sacrifices,
	s.scene_16_regrets,
	s.scene_17_intercom,
	s.scene_18_abandon_contract,
	s.scene_19_questions,
	s.scene_19b_work_questions,
	s.scene_19c_background_questions,
	s.scene_19d_personal_questions,
]

messages: list.Concat([
		m.ship_names,
		m.mission_texts,
])
