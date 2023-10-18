ScriptName Astroneer

Function AddShip() global


  ;TODO: Add it to a ReferenceCollection or something
EndFunction

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")

  Keyword CannotBeSoldShipKeyword = Game.GetForm(0x003413f2) as Keyword
  DebugTrace(CannotBeSoldShipKeyword)
EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[Astroneer] " + Text, 0)
EndFunction
