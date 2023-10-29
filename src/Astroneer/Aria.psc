ScriptName Astroneer:Aria extends Actor

Event OnActivate(ObjectReference akActionRef)

  ; TODO: add this as a property
  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:DebugScene debugScene = astroneer.SceneMissionBoardIntro as Astroneer:DebugScene
  ;debugScene.Start()
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
