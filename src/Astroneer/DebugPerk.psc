ScriptName Astroneer:DebugPerk Extends Perk

Event OnEntryRun(Int auiEntryID, ObjectReference akTarget, Actor akOwner)
  Trace("OnEntryRun " + auiEntryID + " " + akTarget + " " + akOwner)
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
