ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript
{ for ship contract missions }

;-- Variables ---------------------------------------

;-- Properties --------------------------------------


;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
