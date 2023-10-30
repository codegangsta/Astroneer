ScriptName MyMissionPack
{ example of a mission pack, where anyone can add their own missions via script. Users can compile this script, drop it in their scripts folder, and include the mission pack in the ini file as a game setting }

Astroneer:Plugin:Mission[] Function GetMissions(Astroneer:Plugin:Options options) global
  missions = new Astroneer:Plugin:Mission[0]

  Astroneer:Plugin:Mission m = new Astroneer:Plugin:Mission
  m.ID = "my_awesome_mission"
  m.Difficulty = options.DifficultyTier1
  m.MissionReward = options.MissionRewardTier1
  m.Archetype = options.ArchetypeFighter

  m.ObjectiveType_01 = options.ObjectiveCargo
  m.ObjectiveTarget_01 = 1000

  m.ObjectiveType_02 = options.ObjectiveMass
  m.ObjectiveTarget_02 = 1000

  missions.Add(m)

  return missions
EndFunction
