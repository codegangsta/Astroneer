ScriptName Astroneer:Pack Extends ScriptObject

Struct Mission
  String ID
  Message Title
  Message Text
  Int ShipTemplate
  Message ShipType
  Message Difficulty
  Int RewardCredits
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

Mission Function Copy(Mission m) global
  Mission newMission = new Mission
  newMission.ID = m.ID
  newMission.Title = m.Title
  newMission.Text = m.Text
  newMission.ShipTemplate = m.ShipTemplate
  newMission.ShipType = m.ShipType
  newMission.Difficulty = m.Difficulty
  newMission.RewardCredits = m.RewardCredits
  newMission.Objective01 = m.Objective01
  newMission.ObjectiveTarget01 = m.ObjectiveTarget01
  newMission.Objective02 = m.Objective02
  newMission.ObjectiveTarget02 = m.ObjectiveTarget02
  newMission.Objective03 = m.Objective03
  newMission.ObjectiveTarget03 = m.ObjectiveTarget03
  newMission.Objective04 = m.Objective04
  newMission.ObjectiveTarget04 = m.ObjectiveTarget04
  newMission.Objective05 = m.Objective05
  newMission.ObjectiveTarget05 = m.ObjectiveTarget05
  return newMission
EndFunction

Group DifficultyTiers
  Message Property DifficultyClassA Auto Const Mandatory ; Class A
  Message Property DifficultyClassB Auto Const Mandatory ; Class B
  Message Property DifficultyClassC Auto Const Mandatory ; Class C
  Message Property DifficultyClassM Auto Const Mandatory ; Class M
EndGroup

Group MissionTexts
  FormList Property MissionTextsExplorer Auto Const Mandatory
  FormList Property MissionTextsFighter Auto Const Mandatory
  FormList Property MissionTextsHauler Auto Const Mandatory
  FormList Property MissionTextsInterceptor Auto Const Mandatory
  FormList Property MissionTextsLuxury Auto Const Mandatory
EndGroup

Group Objectives
  Message Property ObjectiveCargo Auto Const Mandatory
  Message Property ObjectivePassengerSlots Auto Const Mandatory
  Message Property ObjectiveEnginePower Auto Const Mandatory
  Message Property ObjectiveFuel Auto Const Mandatory
  Message Property ObjectiveGravJumpRange Auto Const Mandatory
  Message Property ObjectiveHabs Auto Const Mandatory
  Message Property ObjectiveHull Auto Const Mandatory
  Message Property ObjectiveMass Auto Const Mandatory
  Message Property ObjectiveReactorPower Auto Const Mandatory
  Message Property ObjectiveShieldHealth Auto Const Mandatory
  Message Property ObjectiveShieldPower Auto Const Mandatory
  Message Property ObjectiveShieldedCargo Auto Const Mandatory
  Message Property ObjectiveThrust Auto Const Mandatory
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
  Message Property ObjectiveMobility Auto Const Mandatory
  Message Property ObjectiveHabArmory Auto Const Mandatory
  Message Property ObjectiveHabBattleStations Auto Const Mandatory
  Message Property ObjectiveHabBrig Auto Const Mandatory
  Message Property ObjectiveHabCaptainsQuarters Auto Const Mandatory
  Message Property ObjectiveHabCargo Auto Const Mandatory
  Message Property ObjectiveHabComputerCore Auto Const Mandatory
  Message Property ObjectiveHabControl Auto Const Mandatory
  Message Property ObjectiveHabEngineering Auto Const Mandatory
  Message Property ObjectiveHabInfirmary Auto Const Mandatory
  Message Property ObjectiveHabLivingSpace Auto Const Mandatory
  Message Property ObjectiveHabMessHall Auto Const Mandatory
  Message Property ObjectiveHabScienceLab Auto Const Mandatory
  Message Property ObjectiveHabStorage Auto Const Mandatory
  Message Property ObjectiveHabWorkshop Auto Const Mandatory
EndGroup

Group HabTypes
  FormList Property HabTypeArmory Auto Const Mandatory
  FormList Property HabTypeBattleStations Auto Const Mandatory
  FormList Property HabTypeBrig Auto Const Mandatory
  FormList Property HabTypeCaptainsQuarters Auto Const Mandatory
  FormList Property HabTypeCargo Auto Const Mandatory
  FormList Property HabTypeComputerCore Auto Const Mandatory
  FormList Property HabTypeControl Auto Const Mandatory
  FormList Property HabTypeEngineering Auto Const Mandatory
  FormList Property HabTypeInfirmary Auto Const Mandatory
  FormList Property HabTypeLivingSpace Auto Const Mandatory
  FormList Property HabTypeMessHall Auto Const Mandatory
  FormList Property HabTypeScienceLab Auto Const Mandatory
  FormList Property HabTypeStorage Auto Const Mandatory
  FormList Property HabTypeWorkshop Auto Const Mandatory
EndGroup

; Ship templates must be IDs instead of forms because the game
; overrwrites the ship form when the player customizes a ship.
Group ShipTemplates
  Int Property ShipTemplateExplorer = 0x0005B554 Auto Const
  Int Property ShipTemplateFighter = 0x0033CA69 Auto Const
  Int Property ShipTemplateHauler = 0x000FAFD8 Auto Const
  Int Property ShipTemplateInterceptor = 0x0033E765 Auto Const
  Int Property ShipTemplateLuxury = 0x001EB556 Auto Const
EndGroup

Group ShipTypes
  Message Property ShipTypeFighter Auto Const Mandatory
  Message Property ShipTypeExplorer Auto Const Mandatory
  Message Property ShipTypeGeneric Auto Const Mandatory
  Message Property ShipTypeHauler Auto Const Mandatory
  Message Property ShipTypeInterceptor Auto Const Mandatory
  Message Property ShipTypeLuxury Auto Const Mandatory
EndGroup
