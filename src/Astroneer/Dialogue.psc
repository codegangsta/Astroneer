ScriptName Astroneer:Dialogue extends TopicInfo

Function CompleteContract(ObjectReference speaker)
  Trace("CompleteContract")
EndFunction

Function ModifyShips(ObjectReference speaker)
  Trace("ModifyShips")
EndFunction

Function SetDesignStage(ObjectReference speaker)
  Trace("Starting Design stage")
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript
  mission.SetStage(mission.DesignStage)
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
