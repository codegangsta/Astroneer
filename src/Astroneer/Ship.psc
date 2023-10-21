ScriptName Astroneer:Ship extends spaceshipbase

Function RemoveKeyword(Keyword apKeyword)
  Trace("RemoveKeyword " + apKeyword)
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
