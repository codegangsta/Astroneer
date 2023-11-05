ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
  PrintCurrentShipObjectives()
EndFunction

Function PrintCurrentShipObjectives() global
  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:Pack consts = (astroneer as ScriptObject) as Astroneer:Pack
  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()

  astroneer.SetAllPartPowers(playerShip, 0)
  astroneer.SetAllPartPowers(playerShip, 1)

  Astroneer:ShipContractMissionScript mission = astroneer.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript
  if mission.ContractShip != None
    playerShip = mission.ContractShip
  endif

  DebugTrace("Current Ship " + playerShip)
  DebugTrace("=Objectives==============================================")
  DebugTrace("ObjectiveCargo " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveCargo))
  DebugTrace("ObjectiveCrewSlots " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveCrewSlots))
  DebugTrace("ObjectiveEnginePower " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveEnginePower))
  DebugTrace("ObjectiveFuel " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveFuel))
  DebugTrace("ObjectiveGravJumpRange " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveGravJumpRange))
  DebugTrace("ObjectiveHabs " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveHabs))
  DebugTrace("ObjectiveHull " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveHull))
  DebugTrace("ObjectiveMass " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveMass))
  DebugTrace("ObjectiveReactorPower " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveReactorPower))
  DebugTrace("ObjectiveShieldedCargo " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveShieldedCargo))
  DebugTrace("ObjectiveShieldHealth " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveShieldHealth))
  DebugTrace("ObjectiveShieldPower " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveShieldPower))
  DebugTrace("ObjectiveTopSpeed " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveTopSpeed))
  DebugTrace("ObjectiveTotalWeaponPower " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveTotalWeaponPower))
  DebugTrace("ObjectiveWeaponPowerBallistic " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerBallistic))
  DebugTrace("ObjectiveWeaponPowerContinuousBeam " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerContinuousBeam))
  DebugTrace("ObjectiveWeaponPowerEM " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerEM))
  DebugTrace("ObjectiveWeaponPowerEnergy " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerEnergy))
  DebugTrace("ObjectiveWeaponPowerMissile " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerMissile))
  DebugTrace("ObjectiveWeaponPowerParticle " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerParticle))
  DebugTrace("ObjectiveWeaponPowerPlasma " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerPlasma))
  DebugTrace("ObjectiveWindows " + astroneer.GetObjectiveValue(playerShip, consts.ObjectiveWindows))
EndFunction

Function DebugAcceptMission(String missionID) global
  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = astroneer.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  astroneer.LoadMissionPacks()
  mission.ForceMissionID = missionID
  mission.Start()
  mission.MissionAccepted(true)
  mission.ForceMissionID = ""
EndFunction

Function DebugRejectMission() global
  Astroneer:ParentQuest astroneer = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = astroneer.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  mission.MissionFailed()
EndFunction

Function DebugResetMissions() global
  MissionParentScript missionParent = Game.GetForm(0x00015300) as MissionParentScript
  DebugTrace("Resetting missions on the mission board")
  missionParent.DebugResetMissions()
  Game.ShowMissionBoardMenu(None, 0)
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
	Debug.Trace("[astroneer] " + Text, 0)
EndFunction
