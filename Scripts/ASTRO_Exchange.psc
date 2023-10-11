ScriptName ASTRO_Exchange extends Actor

ASTRO_Company[] Companies

Event OnInit()
  Debug.TraceSelf(Self, "OnInit", "Building companies")
  ;TODO: make this more resilient
  Companies = new ASTRO_Company[2]
  Companies[0] = (Self as ObjectReference) as Astro_Company_STEK
  Companies[1] = (Self as ObjectReference) as Astro_Company_HPTC

  Debug.TraceSelf(Self, "OnInit", "Starting timer")
  Self.CancelTimerGameTime(0)
  Self.StartTimerGameTime(0.02, 0)
EndEvent

Event OnPlayerLoadGame()
  Debug.TraceSelf(Self, "OnPlayerLoadGame", "ASTRO_Exchange")
EndEvent

; TODO Use state machine and drip out phases over time
; for better performance
Event OnTimerGameTime(Int timerID)
  Float time = Utility.GetCurrentGameTime()
  Debug.TraceSelf(Self, "OnTimerGameTime", time)
  Debug.Notification("Astroneer: Exchange update")
  Self.AdvanceSimulation()

  Self.CancelTimerGameTime(0)
  Self.StartTimerGameTime(0.02, 0)

  Int i = 0

  While i < Companies.Length
    Debug.TraceSelf(Self, "OnTimerGameTime", Companies[i].Name)
    i += 1
  EndWhile
EndEvent

Function AdvanceSimulation()
  Debug.TraceSelf(Self, "Tick", "ASTRO_Exchange")
EndFunction

Function ForecastPhase()
  Debug.TraceSelf(Self, "ForecastPhase", "ASTRO_Exchange")
EndFunction

Function StrategyPhase()
  Companies[0] = (Self as ObjectReference) as Astro_Company_STEK
  Debug.TraceSelf(Self, "StrategyPhase", "ASTRO_Exchange")
  Companies[0] = (Self as ObjectReference) as Astro_Company_STEK
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
