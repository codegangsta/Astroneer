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
  Self.AdvanceSimulation()
  Self.StartTimerGameTime(0.02, 0)
EndEvent

Function AdvanceSimulation()
  Debug.TraceSelf(Self, "Tick", "ASTRO_Exchange")
EndFunction

Function ForecastPhase()
  Debug.TraceSelf(Self, "ForecastPhase", "ASTRO_Exchange")
EndFunction

Function StrategyPhase()
  Debug.TraceSelf(Self, "StrategyPhase", "ASTRO_Exchange")
EndFunction

Function ExecutionPhase()
  Debug.TraceSelf(Self, "ExecutionPhase", "ASTRO_Exchange")
EndFunction

Function ImpactPhase()
  Debug.TraceSelf(Self, "ImpactPhase", "ASTRO_Exchange")
EndFunction

Function ImpactPhase()
  Debug.TraceSelf(Self, "AnalysisPhase", "ASTRO_Exchange")
EndFunction
