ScriptName Astroneer:ShipContractMissionPack1

Astroneer:Pack:Mission[] Function Missions(Astroneer:Pack p)
  Astroneer:Pack:Mission[] missions = new Astroneer:Pack:Mission[0]

  Astroneer:Pack:Mission m = new Astroneer:Pack:Mission
  m.ID = "debug"
  m.Text = p.MissionTextDefault
  m.ShipTemplate = p.ShipTemplateDefault
  m.Difficulty = p.DifficultyTier1
  m.RewardCredits = 100000
  m.RewardXP = 250
  m.Objective01 = p.ObjectiveCargo
  m.ObjectiveTarget01 = 2000
  m.Objective02 = p.ObjectiveMass
  m.ObjectiveTarget02 = 100

  return missions
EndFunction
