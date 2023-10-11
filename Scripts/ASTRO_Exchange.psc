ScriptName ASTRO_Exchange extends Actor

Event OnInit()
  Debug.TraceSelf(Self, "OnInit", "ASTRO_Exchange")

  Self.StartTimerGameTime(0.02, 0)
EndEvent

Event OnPlayerLoadGame()
  Debug.TraceSelf(Self, "OnPlayerLoadGame", "ASTRO_Exchange")

  Self.StartTimerGameTime(0.02, 0)
EndEvent

Event OnTimerGameTime(Int timerID)
  Float time = Utility.GetCurrentGameTime()
  Debug.TraceSelf(Self, "OnTimerGameTime", time)
  Debug.Notification("Astroneer: Exchange update")
  Self.StartTimerGameTime(0.02, 0)
EndEvent

Function Tick()
  Debug.TraceSelf(Self, "Tick", "ASTRO_Exchange")
EndFunction
