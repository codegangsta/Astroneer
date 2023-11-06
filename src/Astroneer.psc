ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
  PrintCurrentShipObjectives()
EndFunction

Function PrintCurrentShipObjectives() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:Pack consts = (pq as ScriptObject) as Astroneer:Pack
  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()

  pq.SetAllPartPowers(playerShip, 0)
  pq.SetAllPartPowers(playerShip, 1)

  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript
  if mission.ContractShip != None
    playerShip = mission.ContractShip
  endif

  DebugTrace("Current Ship " + playerShip)
  DebugTrace("=Objectives==============================================")
  DebugTrace("ObjectiveCargo " + pq.GetObjectiveValue(playerShip, consts.ObjectiveCargo))
  DebugTrace("ObjectiveCrewSlots " + pq.GetObjectiveValue(playerShip, consts.ObjectiveCrewSlots))
  DebugTrace("ObjectiveEnginePower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveEnginePower))
  DebugTrace("ObjectiveFuel " + pq.GetObjectiveValue(playerShip, consts.ObjectiveFuel))
  DebugTrace("ObjectiveGravJumpRange " + pq.GetObjectiveValue(playerShip, consts.ObjectiveGravJumpRange))
  DebugTrace("ObjectiveHabs " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabs))
  DebugTrace("ObjectiveHull " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHull))
  DebugTrace("ObjectiveMass " + pq.GetObjectiveValue(playerShip, consts.ObjectiveMass))
  DebugTrace("ObjectiveReactorPower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveReactorPower))
  DebugTrace("ObjectiveShieldedCargo " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldedCargo))
  DebugTrace("ObjectiveShieldHealth " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldHealth))
  DebugTrace("ObjectiveShieldPower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldPower))
  DebugTrace("ObjectiveTopSpeed " + pq.GetObjectiveValue(playerShip, consts.ObjectiveTopSpeed))
  DebugTrace("ObjectiveTotalWeaponPower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveTotalWeaponPower))
  DebugTrace("ObjectiveWeaponPowerBallistic " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerBallistic))
  DebugTrace("ObjectiveWeaponPowerContinuousBeam " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerContinuousBeam))
  DebugTrace("ObjectiveWeaponPowerEM " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerEM))
  DebugTrace("ObjectiveWeaponPowerEnergy " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerEnergy))
  DebugTrace("ObjectiveWeaponPowerMissile " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerMissile))
  DebugTrace("ObjectiveWeaponPowerParticle " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerParticle))
  DebugTrace("ObjectiveWeaponPowerPlasma " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWeaponPowerPlasma))
  DebugTrace("ObjectiveWindows " + pq.GetObjectiveValue(playerShip, consts.ObjectiveWindows))
EndFunction

Function DebugReadyMission() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  pq.LoadMissionPacks()
  Keyword MissionTypeShipContract = Game.GetForm(0x02000803) as Keyword
  MissionTypeShipContract.SendStoryEvent(None, None, None, 0, 0)
EndFunction

Function DebugAcceptMission() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  mission.MissionAccepted(true)
EndFunction

Function DebugCompleteMission() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  mission.StageCompleted()
EndFunction

Function DebugResetMissions() global
  MissionParentScript missionParent = Game.GetForm(0x00015300) as MissionParentScript
  DebugTrace("Resetting missions on the mission board")
  missionParent.DebugResetMissions()
  Game.ShowMissionBoardMenu(None, 0)
EndFunction

Function DebugPlaceShip() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

  DebugTrace("Contract Ship " + mission.ContractShip)
  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()
  spaceshipreference ship = mission.ContractShip

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
