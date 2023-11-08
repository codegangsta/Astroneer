ScriptName Astroneer:DebugScene extends Scene

Group Phases
  Int Property PhaseGreet = 1 Auto Const
  Int Property PhaseTopics = 2 Auto Const
  Int Property PhaseModifyShip = 3 Auto Const
  Int Property PhaseCompleteContract = 4 Auto Const
EndGroup

Function ModifyShip()
  Trace("ModifyShip")
  Game.GetPlayer().ShowHangarMenu(0, GetAria(), None, False)
  Stop()
EndFunction

Function CompleteContract()
  Trace("CompleteContract")
  Stop()
EndFunction

Actor Function GetAria()
  return (GetOwningQuest().GetAlias(0) as ReferenceAlias).GetActorReference()
EndFunction

Event OnBegin()
  Trace("OnBegin")
EndEvent

Event OnEnd()
  Trace("OnEnd")
EndEvent

Event OnPhaseBegin(Int phase)
  Trace("OnPhaseBegin " + phase)
EndEvent

Event OnPhaseEnd(Int phase)
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
