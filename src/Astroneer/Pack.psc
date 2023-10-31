ScriptName Astroneer:Pack Extends ScriptObject

Struct Mission
  String ID
  Message Text
  Form ShipTemplate
  Message Difficulty
  Int RewardCredits
  Int RewardXP
  Message Objective01
  Float ObjectiveTarget01
  Message Objective02
  Float ObjectiveTarget02
  Message Objective03
  Float ObjectiveTarget03
  Message Objective04
  Float ObjectiveTarget04
  Message Objective05
  Float ObjectiveTarget05
EndStruct

Group DifficultyTiers
  Message Property DifficultyTier1 Auto Const Mandatory ; Novice
  Message Property DifficultyTier2 Auto Const Mandatory ; Advanced
  Message Property DifficultyTier3 Auto Const Mandatory ; Expert
  Message Property DifficultyTier4 Auto Const Mandatory ; Master
EndGroup

Group MissionTexts
  Message Property MissionTextDefault Auto Const Mandatory
EndGroup

Group Objectives
  Message Property ObjectiveCargo Auto Const Mandatory
  Message Property ObjectiveMass Auto Const Mandatory
EndGroup

Group ShipTemplates
  Form Property ShipTemplateDefault Auto Const Mandatory
EndGroup
