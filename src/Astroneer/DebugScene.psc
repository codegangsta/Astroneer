ScriptName Astroneer:DebugScene extends Scene

Event OnAction(int actionID,  ReferenceAlias akAlias)
  Trace("OnAction " + actionID + " " + akAlias)
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
