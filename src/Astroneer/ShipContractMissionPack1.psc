ScriptName Astroneer:ShipContractMissionPack1

Message Function GetRandomHabObjective(FormList objectives) global
  int index = Utility.RandomInt(0, objectives.GetSize() - 1)
  return objectives.GetAt(index) as Message
EndFunction

Astroneer:Pack:Mission[] Function Missions(Astroneer:Pack p) global

  Astroneer:Pack:Mission[] missions = new Astroneer:Pack:Mission[0]

  ;= Class A Fighter Mission =======================================
  Astroneer:Pack:Mission ma1 = new Astroneer:Pack:Mission
  ma1.ID = "MP01_FighterA"
  ma1.ShipTemplate = p.ShipTemplateFighter
  ma1.ShipType = p.ShipTypeFighter
  ma1.Difficulty = p.DifficultyClassA
  ma1.RewardCredits = 4000
  ma1.Objective01 = p.ObjectiveMass
  ma1.ObjectiveTarget01 = 500
  ma1.Objective02 = p.ObjectiveWeaponPowerBallistic
  ma1.ObjectiveTarget02 = 6
  ma1.Objective03 = p.ObjectiveWeaponPowerEnergy
  ma1.ObjectiveTarget03 = 6
  ma1.Objective04 = p.ObjectiveWeaponPowerMissile
  ma1.ObjectiveTarget04 = 6
  ma1.Objective05 = GetRandomHabObjective(p.HabObjectivesFighter)
  ma1.ObjectiveTarget05 = 1

  ;= Class A Hauler Mission ========================================
  Astroneer:Pack:Mission ma2 = new Astroneer:Pack:Mission
  ma2.ID = "MP01_HaulerA"
  ma2.ShipTemplate = p.ShipTemplateHauler
  ma2.ShipType = p.ShipTypeHauler
  ma2.Difficulty = p.DifficultyClassA
  ma2.RewardCredits = 4500
  ma2.Objective01 = p.ObjectiveCargo
  ma2.ObjectiveTarget01 = 2000
  ma2.Objective02 = p.ObjectiveEnginePower
  ma2.ObjectiveTarget02 = 8
  ma2.Objective03 = p.ObjectiveFuel
  ma2.ObjectiveTarget03 = 400
  ma2.Objective04 = p.ObjectiveMass
  ma2.ObjectiveTarget04 = 1100
  ma2.Objective05 = GetRandomHabObjective(p.HabObjectivesHauler)
  ma2.ObjectiveTarget05 = 1

  ;= Class A Luxury Mission ========================================
  Astroneer:Pack:Mission ma3 = new Astroneer:Pack:Mission
  ma3.ID = "MP01_LuxuryA"
  ma3.ShipTemplate = p.ShipTemplateLuxury
  ma3.ShipType = p.ShipTypeLuxury
  ma3.Difficulty = p.DifficultyClassA
  ma3.RewardCredits = 6000
  ma3.Objective01 = p.ObjectivePassengerSlots
  ma3.ObjectiveTarget01 = 4
  ma3.Objective02 = p.ObjectiveHabs
  ma3.ObjectiveTarget02 = 4
  ma3.Objective03 = p.ObjectiveMobility
  ma3.ObjectiveTarget03 = 100
  ma3.Objective04 = p.ObjectiveWindows
  ma3.ObjectiveTarget04 = 4
  ma3.Objective05 = GetRandomHabObjective(p.HabObjectivesLuxury)
  ma3.ObjectiveTarget05 = 1

  ;= Class A Explorer Mission ======================================
  Astroneer:Pack:Mission ma4 = new Astroneer:Pack:Mission
  ma4.ID = "MP01_ExplorerA"
  ma4.ShipTemplate = p.ShipTemplateExplorer
  ma4.ShipType = p.ShipTypeExplorer
  ma4.Difficulty = p.DifficultyClassA
  ma4.RewardCredits = 5000
  ma4.Objective01 = p.ObjectiveGravJumpRange
  ma4.ObjectiveTarget01 = 16
  ma4.Objective02 = p.ObjectiveFuel
  ma4.ObjectiveTarget02 = 280
  ma4.Objective03 = p.ObjectiveHull
  ma4.ObjectiveTarget03 = 450
  ma4.Objective04 = p.ObjectiveReactorPower
  ma4.ObjectiveTarget04 = 16
  ma4.Objective05 = GetRandomHabObjective(p.HabObjectivesExplorer)
  ma4.ObjectiveTarget05 = 1

  ;= Class A Interceptor Mission ===================================
  Astroneer:Pack:Mission ma5 = new Astroneer:Pack:Mission
  ma5.ID = "MP01_InterceptorA"
  ma5.ShipTemplate = p.ShipTemplateInterceptor
  ma5.ShipType = p.ShipTypeInterceptor
  ma5.Difficulty = p.DifficultyClassA
  ma5.RewardCredits = 4800
  ma5.Objective01 = p.ObjectiveTopSpeed
  ma5.ObjectiveTarget01 = 150
  ma5.Objective02 = p.ObjectiveThrust
  ma5.ObjectiveTarget02 = 5000
  ma5.Objective03 = p.ObjectiveMobility
  ma5.ObjectiveTarget03 = 100
  ma5.Objective04 = p.ObjectiveWeaponPowerMissile
  ma5.ObjectiveTarget04 = 6
  ma5.Objective05 = p.ObjectiveHabEngineering
  ma5.ObjectiveTarget05 = 1

    ;= Class B Explorer Mission ======================================
  Astroneer:Pack:Mission mb1 = new Astroneer:Pack:Mission
  mb1.ID = "MP01_ExplorerB"
  mb1.ShipTemplate = p.ShipTemplateExplorer
  mb1.ShipType = p.ShipTypeExplorer
  mb1.Difficulty = p.DifficultyClassB
  mb1.RewardCredits = 6000
  mb1.Objective01 = p.ObjectiveFuel
  mb1.ObjectiveTarget01 = 13500
  mb1.Objective02 = p.ObjectiveGravJumpRange
  mb1.ObjectiveTarget02 = 49
  mb1.Objective03 = p.ObjectiveReactorPower
  mb1.ObjectiveTarget03 = 505

  ;= Class B Fighter Mission =======================================
  Astroneer:Pack:Mission mb2 = new Astroneer:Pack:Mission
  mb2.ID = "MP01_FighterB"
  mb2.ShipTemplate = p.ShipTemplateFighter
  mb2.ShipType = p.ShipTypeFighter
  mb2.Difficulty = p.DifficultyClassB
  mb2.RewardCredits = 6500
  mb2.Objective01 = p.ObjectiveShieldHealth
  mb2.ObjectiveTarget01 = 610
  mb2.Objective02 = p.ObjectiveTotalWeaponPower
  mb2.ObjectiveTarget02 = 102
  mb2.Objective03 = p.ObjectiveWeaponPowerEnergy
  mb2.ObjectiveTarget03 = 7
  mb2.Objective04 = p.ObjectiveWeaponPowerMissile
  mb2.ObjectiveTarget04 = 7

  ;= Class B Hauler Mission ========================================
  Astroneer:Pack:Mission mb3 = new Astroneer:Pack:Mission
  mb3.ID = "MP01_HaulerB"
  mb3.ShipTemplate = p.ShipTemplateHauler
  mb3.ShipType = p.ShipTypeHauler
  mb3.Difficulty = p.DifficultyClassB
  mb3.RewardCredits = 6200
  mb3.Objective01 = p.ObjectiveCargo
  mb3.ObjectiveTarget01 = 13500
  mb3.Objective02 = p.ObjectiveEnginePower
  mb3.ObjectiveTarget02 = 505
  mb3.Objective03 = p.ObjectiveFuel
  mb3.ObjectiveTarget03 = 13500

  ;= Class B Luxury Mission ========================================
  Astroneer:Pack:Mission mb4 = new Astroneer:Pack:Mission
  mb4.ID = "MP01_LuxuryB"
  mb4.ShipTemplate = p.ShipTemplateLuxury
  mb4.ShipType = p.ShipTypeLuxury
  mb4.Difficulty = p.DifficultyClassB
  mb4.RewardCredits = 7000
  mb4.Objective01 = p.ObjectivePassengerSlots
  mb4.ObjectiveTarget01 = 5
  mb4.Objective02 = p.ObjectiveHabs
  mb4.ObjectiveTarget02 = 2
  mb4.Objective03 = p.ObjectiveShieldHealth
  mb4.ObjectiveTarget03 = 505

  ;= Class B Interceptor Mission ===================================
  Astroneer:Pack:Mission mb5 = new Astroneer:Pack:Mission
  mb5.ID = "MP01_InterceptorB"
  mb5.ShipTemplate = p.ShipTemplateInterceptor
  mb5.ShipType = p.ShipTypeInterceptor
  mb5.Difficulty = p.DifficultyClassB
  mb5.RewardCredits = 6300
  mb5.Objective01 = p.ObjectiveTopSpeed
  mb5.ObjectiveTarget01 = 610
  mb5.Objective02 = p.ObjectiveThrust
  mb5.ObjectiveTarget02 = 610
  mb5.Objective03 = p.ObjectiveMass
  mb5.ObjectiveTarget03 = 57

  ;= Class C Explorer Mission ======================================
  Astroneer:Pack:Mission mc1 = new Astroneer:Pack:Mission
  mc1.ID = "MP01_ExplorerC"
  mc1.ShipTemplate = p.ShipTemplateExplorer
  mc1.ShipType = p.ShipTypeExplorer
  mc1.Difficulty = p.DifficultyClassC
  mc1.RewardCredits = 8000
  mc1.Objective01 = p.ObjectiveFuel
  mc1.ObjectiveTarget01 = 25100
  mc1.Objective02 = p.ObjectiveGravJumpRange
  mc1.ObjectiveTarget02 = 85
  mc1.Objective03 = p.ObjectiveReactorPower
  mc1.ObjectiveTarget03 = 680

  ;= Class C Fighter Mission =======================================
  Astroneer:Pack:Mission mc2 = new Astroneer:Pack:Mission
  mc2.ID = "MP01_FighterC"
  mc2.ShipTemplate = p.ShipTemplateFighter
  mc2.ShipType = p.ShipTypeFighter
  mc2.Difficulty = p.DifficultyClassC
  mc2.RewardCredits = 8500
  mc2.Objective01 = p.ObjectiveShieldHealth
  mc2.ObjectiveTarget01 = 680
  mc2.Objective02 = p.ObjectiveTotalWeaponPower
  mc2.ObjectiveTarget02 = 113
  mc2.Objective03 = p.ObjectiveWeaponPowerEnergy
  mc2.ObjectiveTarget03 = 8
  mc2.Objective04 = p.ObjectiveWeaponPowerMissile
  mc2.ObjectiveTarget04 = 8

  ;= Class C Hauler Mission ========================================
  Astroneer:Pack:Mission mc3 = new Astroneer:Pack:Mission
  mc3.ID = "MP01_HaulerC"
  mc3.ShipTemplate = p.ShipTemplateHauler
  mc3.ShipType = p.ShipTypeHauler
  mc3.Difficulty = p.DifficultyClassC
  mc3.RewardCredits = 8200
  mc3.Objective01 = p.ObjectiveCargo
  mc3.ObjectiveTarget01 = 25100
  mc3.Objective02 = p.ObjectiveEnginePower
  mc3.ObjectiveTarget02 = 680
  mc3.Objective03 = p.ObjectiveFuel
  mc3.ObjectiveTarget03 = 25100

  ;= Class C Luxury Mission ========================================
  Astroneer:Pack:Mission mc4 = new Astroneer:Pack:Mission
  mc4.ID = "MP01_LuxuryC"
  mc4.ShipTemplate = p.ShipTemplateLuxury
  mc4.ShipType = p.ShipTypeLuxury
  mc4.Difficulty = p.DifficultyClassC
  mc4.RewardCredits = 9000
  mc4.Objective01 = p.ObjectivePassengerSlots
  mc4.ObjectiveTarget01 = 6
  mc4.Objective02 = p.ObjectiveHabs
  mc4.ObjectiveTarget02 = 3
  mc4.Objective03 = p.ObjectiveShieldHealth
  mc4.ObjectiveTarget03 = 680

  ;= Class C Interceptor Mission ===================================
  Astroneer:Pack:Mission mc5 = new Astroneer:Pack:Mission
  mc5.ID = "MP01_InterceptorC"
  mc5.ShipTemplate = p.ShipTemplateInterceptor
  mc5.ShipType = p.ShipTypeInterceptor
  mc5.Difficulty = p.DifficultyClassC
  mc5.RewardCredits = 8300
  mc5.Objective01 = p.ObjectiveTopSpeed
  mc5.ObjectiveTarget01 = 850
  mc5.Objective02 = p.ObjectiveThrust
  mc5.ObjectiveTarget02 = 850
  mc5.Objective03 = p.ObjectiveMass
  mc5.ObjectiveTarget03 = 91


  ;missions.Add(ma1)
  ;missions.Add(ma2)
  ;missions.Add(ma3)
  ;missions.Add(ma4)
missions.Add(ma5)
; missions.Add(mb1)
; missions.Add(mb2)
; missions.Add(mb3)
; missions.Add(mb4)
; missions.Add(mb5)
; missions.Add(mc1)
; missions.Add(mc2)
; missions.Add(mc3)
; missions.Add(mc4)
; missions.Add(mc5)

  return missions
EndFunction
