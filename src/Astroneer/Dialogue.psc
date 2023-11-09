ScriptName Astroneer:Dialogue extends TopicInfo

Function CompleteContract(ObjectReference speaker)
  Astroneer:ShipContractMissionScript mission = GetMission()
  mission.MissionComplete()
EndFunction

Function ModifyShips(ObjectReference speaker)
  Game.GetPlayer().ShowHangarMenu(0, GetAria(), None, False)
EndFunction

Function SetDesignStage(ObjectReference speaker)
  Astroneer:ShipContractMissionScript mission = GetMission()
  mission.SetStage(mission.DesignStage)
EndFunction

Actor Function GetAria()
  return (GetOwningQuest().GetAlias(0) as ReferenceAlias).GetActorReference()
EndFunction

Astroneer:ShipContractMissionScript Function GetMission()
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  return pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
