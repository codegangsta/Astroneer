ScriptName Astroneer:DebugScene extends Scene

Event OnAction(int actionID,  ReferenceAlias akAlias)
  Trace("OnAction " + actionID + " " + akAlias)
EndEvent

Event OnBegin()
  Trace("OnBegin")
EndEvent

Event OnEnd()
  Trace("OnEnd")
EndEvent

Event OnPhaseBegin(Int auiPhaseIndex)
  Trace("OnPhaseBegin " + auiPhaseIndex)
EndEvent

Event OnPhaseEnd(Int auiPhaseIndex)
  Trace("OnPhaseEnd " + auiPhaseIndex)
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
