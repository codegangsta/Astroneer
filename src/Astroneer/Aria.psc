ScriptName Astroneer:Aria extends Actor

;Astroneer:ParentQuest Property ParentQuest Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  pq.SceneMissionBoardIntro.Start()
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
