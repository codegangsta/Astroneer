ScriptName Astroneer:Aria extends Actor

Astroneer:ParentQuest Property ParentQuest Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
  ParentQuest.SceneMissionBoardIntro.Start()
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
