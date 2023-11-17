ScriptName Astroneer:ShipContractMissionPack1

Astroneer:Pack:Mission[] Function Missions(Astroneer:Pack p) global

  Astroneer:Pack:Mission[] missions = new Astroneer:Pack:Mission[0]

  ;= Fighter 01 =================================================
  Astroneer:Pack:Mission m1 = new Astroneer:Pack:Mission
  m1.ID = "MP01_Fighter01"
  m1.ShipTemplate = p.ShipTemplateFighter
  m1.ShipType = p.ShipTypeFighter
  m1.Difficulty = p.DifficultyTier1
  m1.RewardCredits = 100000
  m1.Objective01 = p.ObjectiveMass
  m1.ObjectiveTarget01 = 2000
  m1.Objective02 = p.ObjectiveShieldHealth
  m1.ObjectiveTarget02 = 500
  m1.Objective03 = p.ObjectiveWeaponPowerEnergy
  m1.ObjectiveTarget03 = 6
  m1.Objective04 = p.ObjectiveWeaponPowerMissile
  m1.ObjectiveTarget04 = 6
  m1.Objective05 = p.ObjectiveWeaponPowerBallistic
  m1.ObjectiveTarget05 = 6

  ;= Hauler 01 =================================================
  Astroneer:Pack:Mission m2 = new Astroneer:Pack:Mission
  m2.ID = "MP01_Hauler01"
  m2.ShipTemplate = p.ShipTemplateHauler
  m2.ShipType = p.ShipTypeHauler
  m2.Difficulty = p.DifficultyTier1
  m2.RewardCredits = 100000
  m2.Objective01 = p.ObjectiveCargo
  m2.ObjectiveTarget01 = 2000
  m2.Objective02 = p.ObjectiveEnginePower
  m2.ObjectiveTarget02 = 8
  m2.Objective03 = p.ObjectiveFuel
  m2.ObjectiveTarget03 = 80
  m2.Objective04 = p.ObjectiveReactorPower
  m2.ObjectiveTarget04 = 6

  ;= Luxury 01 =================================================
  Astroneer:Pack:Mission m3 = new Astroneer:Pack:Mission
  m3.ID = "MP01_Luxury01"
  m3.ShipTemplate = p.ShipTemplateLuxury
  m3.ShipType = p.ShipTypeLuxury
  m3.Difficulty = p.DifficultyTier1
  m3.RewardCredits = 100000
  m3.Objective01 = p.ObjectiveHabs
  m3.ObjectiveTarget01 = 4
  m3.Objective02 = p.ObjectiveWindows
  m3.ObjectiveTarget02 = 4
  m3.Objective03 = p.ObjectiveShieldHealth
  m3.ObjectiveTarget03 = 500
  m3.Objective04 = p.ObjectiveWeaponPowerEM
  m3.ObjectiveTarget04 = 6

  ;= Explorer 01 =================================================
  Astroneer:Pack:Mission m4 = new Astroneer:Pack:Mission
  m4.ID = "MP01_Explorer01"
  m4.ShipTemplate = p.ShipTemplateExplorer
  m4.ShipType = p.ShipTypeExplorer
  m4.Difficulty = p.DifficultyTier1
  m4.RewardCredits = 100000
  m4.Objective01 = p.ObjectiveMass
  m4.ObjectiveTarget01 = 2000
  m4.Objective02 = p.ObjectiveGravJumpRange
  m4.ObjectiveTarget02 = 25
  m4.Objective03 = p.ObjectiveFuel
  m4.ObjectiveTarget03 = 75
  m4.Objective04 = p.ObjectiveCargo
  m4.ObjectiveTarget04 = 750
  m4.Objective05 = p.ObjectiveShieldHealth
  m4.ObjectiveTarget05 = 500

  ;= Interceptor 01 =================================================
  Astroneer:Pack:Mission m5 = new Astroneer:Pack:Mission
  m5.ID = "MP01_Interceptor01"
  m5.ShipTemplate = p.ShipTemplateInterceptor
  m5.ShipType = p.ShipTypeInterceptor
  m5.Difficulty = p.DifficultyTier1
  m5.RewardCredits = 100000
  m5.Objective01 = p.ObjectiveMass
  m5.ObjectiveTarget01 = 1200
  m5.Objective02 = p.ObjectiveTopSpeed
  m5.ObjectiveTarget02 = 300
  m5.Objective03 = p.ObjectiveWeaponPowerEM
  m5.ObjectiveTarget03 = 7
  ; TODO: Thrusters?

  m5.ObjectiveTarget01 = 2000
  m5.ObjectiveTarget02 = 100
  m5.ObjectiveTarget03 = 0

  ;m5.Objective04 = p.ObjectiveThrusters
  ;m5.ObjectiveTarget04 = 750
  ;missions.Add(m1)
  ;missions.Add(m2)
  ;missions.Add(m3)
  ;missions.Add(m4)
  missions.Add(m5)

  return missions

EndFunction
