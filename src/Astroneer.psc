ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
  Astroneer:Player player = Game.GetPlayer() as Astroneer:Player

  SQ_TrafficManagerScript trafficManager = Game.GetForm(0x0039469d) as SQ_TrafficManagerScript
  DebugTrace("TrafficManager " + trafficManager)
  DebugTrace("Exit Points " + trafficManager.Alias_ExitPoints)
EndFunction

Function DebugContract() global
  Keyword Immobile = Game.GetForm(0x0002b71f) as Keyword
  Keyword SpaceShip = Game.GetForm(0x00249fb3) as Keyword
  Keyword PlayerShipKW = Game.GetForm(0x0020c5c4) as Keyword
  DebugTrace("Immobile KW " + Immobile)

  Astroneer:Player player = Game.GetPlayer() as Astroneer:Player

  if(player.ContractShip == None)
    DebugTrace("No Contract Ship")
    return
  endif

  DebugTrace("Contract Ship " + player.ContractShip)
  DebugTrace("immobile keyword?" + player.ContractShip.HasKeyword(Immobile))
  DebugTrace("spaceship keyword?" + player.ContractShip.HasKeyword(SpaceShip))
  DebugTrace("playership keyword?" + player.ContractShip.HasKeyword(PlayerShipKW))

  SQ_TrafficManagerScript trafficManager = Game.GetForm(0x0021b8bd) as SQ_TrafficManagerScript
  DebugTrace("TrafficManager " + trafficManager)
  DebugTrace("Exit Points " + trafficManager.Alias_ExitPoints)

  Int tempdestinationpoint = Utility.RandomInt(0, trafficManager.Alias_ExitPoints.GetCount() - 1) ; #DEBUG_LINE_NO:110
  DebugTrace("Random" + tempdestinationpoint)
  ObjectReference DestinationLink = trafficManager.Alias_ExitPoints.GetAt(tempdestinationpoint) ; #DEBUG_LINE_NO:112 
  DebugTrace("link" + DestinationLink)
  player.ContractShip.SetLinkedRef(DestinationLink, trafficManager.LinkKeywordDestination, False) ; #DEBUG_LINE_NO:122
  DebugTrace("AI" + player.ContractShip.GetSpaceshipAutopilotAI().GetCurrentPackage())
  player.ContractShip.GetSpaceshipAutopilotAI().ForceMovementSpeed(-1.0)

  player.ContractShip.SetForwardVelocity(1.0)
  player.ContractShip.EvaluatePackage(True)
EndFunction

Function DebugPlaceShip() global
  Astroneer:Player player = Game.GetPlayer() as Astroneer:Player

  DebugTrace("Contract Ship " + player.ContractShip)
  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()
  spaceshipreference ship = player.ContractShip

  ; reset ship
  DebugTrace("Resetting Ship")
  ship.Reset(None)

  SQ_TrafficManagerScript trafficManager = Game.GetForm(0x0021b8bd) as SQ_TrafficManagerScript
  DebugTrace("TrafficManager " + trafficManager)
  DebugTrace("Exit Points " + trafficManager.Alias_ExitPoints)
  ship.MoveNear(playerShip, playerShip.CONST_NearPosition_ForwardWide, playerShip.CONST_NearDistance_Close, playerShip.CONST_NearFacing_TotallyRandom)

  Int tempspawnpoint = Utility.RandomInt(0, trafficManager.Alias_EnterPoints.GetCount() - 1) ; #DEBUG_LINE_NO:109
  ObjectReference spawnmarkerref = trafficManager.Alias_EnterPoints.GetAt(tempspawnpoint) ; #DEBUG_LINE_NO:111
  ;ship.MoveTo(spawnmarkerref, 0, 0, 0, True, True)

  Int tempdestinationpoint = Utility.RandomInt(0, trafficManager.Alias_ExitPoints.GetCount() - 1) ; #DEBUG_LINE_NO:110
  ObjectReference DestinationLink = trafficManager.Alias_ExitPoints.GetAt(tempdestinationpoint) ; #DEBUG_LINE_NO:112 
  ship.EvaluatePackage(True)
  ship.EnableAI(True, True)
  ship.EnableWithGravJump()
  ship.SetForwardVelocity(1.0)
  ship.GetSpaceshipAutopilotAI().ForceMovementSpeed(-1.0)
  ship.SetLinkedRef(DestinationLink, trafficManager.LinkKeywordDestination, False) ; #DEBUG_LINE_NO:122
  DebugTrace("AI Enabled? " + ship.IsAIEnabled())

  ;spaceshipreference enemyShipRef = playerShip.PlaceShipNearMe(player.ContractShip, ship.CONST_NearPosition_ForwardWide, ship.CONST_NearDistance_Close, ship.CONST_NearFacing_Direct, 4, True, False, False, True, None) ; #DEBUG_LINE_NO:23
EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[Astroneer] " + Text, 0)
EndFunction
