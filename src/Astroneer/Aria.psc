ScriptName Astroneer:Aria extends Actor

Event OnActivate(ObjectReference akActionRef)

  ; TODO: add this as a property
  Topic greetTopic = Game.GetForm(0x02000838) as Topic
  Trace("Aria OnActivate " + greetTopic)

  Self.Say(greetTopic, None, True, None)
EndEvent

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
