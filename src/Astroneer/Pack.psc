ScriptName Astroneer:Pack Extends ScriptObject

Struct Mission
  String ID
  Message Title
  Message Text
  Form ShipTemplate
  Message ShipType
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

Group MissionTitles
  Message Property MissionTitleDefault Auto Const Mandatory
  Message Property MissionTitleExplorer01 Auto Const Mandatory
  Message Property MissionTitleFighter01 Auto Const Mandatory
  Message Property MissionTitleHauler01 Auto Const Mandatory
  Message Property MissionTitleInterceptor01 Auto Const Mandatory
  Message Property MissionTitleLuxury01 Auto Const Mandatory
EndGroup

Group MissionTexts
  Message Property MissionTextDefault Auto Const Mandatory
  Message Property MissionTextExplorer01 Auto Const Mandatory
  Message Property MissionTextFighter01 Auto Const Mandatory
  Message Property MissionTextHauler01 Auto Const Mandatory
  Message Property MissionTextInterceptor01 Auto Const Mandatory
  Message Property MissionTextLuxury01 Auto Const Mandatory
EndGroup

Group Objectives
  Message Property ObjectiveCargo Auto Const Mandatory
  Message Property ObjectiveCrewSlots Auto Const Mandatory
  Message Property ObjectiveEnginePower Auto Const Mandatory
  Message Property ObjectiveFuel Auto Const Mandatory
  Message Property ObjectiveGravJumpRange Auto Const Mandatory
  Message Property ObjectiveHabs Auto Const Mandatory
  Message Property ObjectiveHull Auto Const Mandatory
  Message Property ObjectiveMass Auto Const Mandatory
  Message Property ObjectiveReactorPower Auto Const Mandatory
  Message Property ObjectiveShieldedCargo Auto Const Mandatory
  Message Property ObjectiveShieldHealth Auto Const Mandatory
  Message Property ObjectiveShieldPower Auto Const Mandatory
  Message Property ObjectiveTopSpeed Auto Const Mandatory
  Message Property ObjectiveTotalWeaponPower Auto Const Mandatory
  Message Property ObjectiveWeaponPowerBallistic Auto Const Mandatory
  Message Property ObjectiveWeaponPowerContinuousBeam Auto Const Mandatory
  Message Property ObjectiveWeaponPowerEM Auto Const Mandatory
  Message Property ObjectiveWeaponPowerEnergy Auto Const Mandatory
  Message Property ObjectiveWeaponPowerMissile Auto Const Mandatory
  Message Property ObjectiveWeaponPowerParticle Auto Const Mandatory
  Message Property ObjectiveWeaponPowerPlasma Auto Const Mandatory
  Message Property ObjectiveWindows Auto Const Mandatory
EndGroup

Group ShipTemplates
  ; TODO: Rename to ShipTemplateGeneric
  Form Property ShipTemplateDefault Auto Const Mandatory
  Form Property ShipTemplateExplorer Auto Const Mandatory
  Form Property ShipTemplateFighter Auto Const Mandatory
  Form Property ShipTemplateHauler Auto Const Mandatory
  Form Property ShipTemplateInterceptor Auto Const Mandatory
  Form Property ShipTemplateLuxury Auto Const Mandatory
EndGroup

Group ShipTypes
  Message Property ShipTypeExplorer Auto Const Mandatory
  Message Property ShipTypeFighter Auto Const Mandatory
  Message Property ShipTypeGeneric Auto Const Mandatory
  Message Property ShipTypeHauler Auto Const Mandatory
  Message Property ShipTypeInterceptor Auto Const Mandatory
  Message Property ShipTypeLuxury Auto Const Mandatory
EndGroup
