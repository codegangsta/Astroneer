ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
  ;DebugScene()
  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  DebugTrace("Parent quest " + astroneer)

  DebugTrace("Random Mission " + astroneer.GetRandomMission())

  astroneer.AddMissions()
EndFunction

Function DebugIntercom() global
  Activator intercomForm = Game.GetForm(0x02000843) as Activator
  DebugTrace("Intercom " + intercomForm)

  ObjectReference intercom = Game.GetPlayer().PlaceAtMe(intercomForm, 1, False, False, False, None, None, True)
  intercom.SetPosition(-828.62, 1603.28, -165.53)
  intercom.SetAngle(-0.00, -0.00, -137.15)
EndFunction

Function DebugScene() global
  DebugTrace("=DebugScene==============================================")

  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:DebugScene debugScene = astroneer.SceneMissionBoardIntro as Astroneer:DebugScene
  DebugTrace("Parent quest " + astroneer)

  ActorBase ariaForm = Game.GetForm(0x02000835) as ActorBase
  Actor aria = Game.GetPlayer().PlaceActorAtMe(ariaForm, 1, None, True, False, False, None, False)
  DebugTrace("Aria " + aria)
  (astroneer.GetAlias(0) as ReferenceAlias).ForceRefTo(aria)

  ;sarah.Enable(false)
  ;sarah.SetAlpha(0.0, false)
  ;sarah.MoveTo(Game.GetPlayer(), 0.0, 0.0, 0.0, True, False)
  ;sarah.Disable(false)

  ;DebugTrace("Mission Board Intro " + debugScene)
  ;DebugTrace("Mission Board Playing " + debugScene.IsPlaying())
  ;DebugTrace("Mission Board OwningQuest " + debugScene.GetOwningQuest())
  ;DebugTrace("ParentQuest " + astroneer.GetCurrentStageID())
EndFunction

Function DebugShipValues() global
  Astroneer:Player player = Game.GetPlayer() as Astroneer:Player

  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()
  DebugTrace("Player Ship " + playerShip)

  ActorValue SpaceshipMass = Game.GetForm(0x0000ACDB) as ActorValue
  DebugTrace("Player Ship mass " + playerShip.GetValue(SpaceshipMass))

  ActorValue SpaceshipMaxPower = Game.GetForm(0x00001018) as ActorValue
  DebugTrace("Player Reactor power " + playerShip.GetValue(SpaceshipMaxPower))

  ActorValue SpaceshipEnginePower = Game.GetForm(0x00000ff6) as ActorValue
  DebugTrace("Player Ship engine power " + playerShip.GetValue(SpaceshipEnginePower))

  ActorValue ShipSystemDamageWeightWeapon = Game.GetForm(0x001d3d7a) as ActorValue
  DebugTrace("Player ship damage weight weapon " + playerShip.GetValue(ShipSystemDamageWeightWeapon))

  Keyword SpaceshipFromShipModule = Game.GetForm(0x001bb401) as Keyword
  Keyword LinkShipModule = Game.GetForm(0x002c1001) as Keyword
  Keyword SBShip_Hab = Game.GetForm(0x002ac927) as Keyword

  ObjectReference[] exteriorRefs = playerShip.GetExteriorRefs(SBShip_Hab)
  Int i = 0
  While(i < exteriorRefs.length)
    ObjectReference exteriorRef = exteriorRefs[0]
    DebugTrace("Exterior ref " + exteriorRef.GetBaseObject())
    i += 1
  EndWhile

  ActorValue ShipSystemWeaponGroup1Health = Game.GetForm(0x000003a3) as ActorValue
  DebugTrace("Player Ship weapon group 1 " + playerShip.GetWeaponGroupBaseObject(ShipSystemWeaponGroup1Health))
  DebugTrace("Player Ship weapon group 1 is energyweaopon " + playerShip.GetWeaponGroupBaseObject(ShipSystemWeaponGroup1Health).GetState())

  ActorValue TestAV = Game.GetForm(0x00278988) as ActorValue
  DebugTrace("Top speed " + playerShip.GetValue(TestAV))
EndFunction

Function DebugResetMissions() global
  MissionParentScript missionParent = Game.GetForm(0x00015300) as MissionParentScript
  DebugTrace("Resetting missions on the mission board")
  missionParent.DebugResetMissions()
  Game.ShowMissionBoardMenu(None, 0)
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
