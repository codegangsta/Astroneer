ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
  DebugPlaceShip()
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
  DebugTrace("Reactor Class " + playerShip.GetReactorClassKeyword())
  DebugTrace("ObjectiveCargo " + pq.GetObjectiveValue(playerShip, consts.ObjectiveCargo))
  DebugTrace("ObjectivePassengerSlots " + pq.GetObjectiveValue(playerShip, consts.ObjectivePassengerSlots))
  DebugTrace("ObjectiveEnginePower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveEnginePower))
  DebugTrace("ObjectiveFuel " + pq.GetObjectiveValue(playerShip, consts.ObjectiveFuel))
  DebugTrace("ObjectiveGravJumpRange " + pq.GetObjectiveValue(playerShip, consts.ObjectiveGravJumpRange))
  DebugTrace("ObjectiveHabs " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabs))
  DebugTrace("ObjectiveHull " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHull))
  DebugTrace("ObjectiveMass " + pq.GetObjectiveValue(playerShip, consts.ObjectiveMass))
  DebugTrace("ObjectiveReactorPower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveReactorPower))
  DebugTrace("ObjectiveShieldHealth " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldHealth))
  DebugTrace("ObjectiveShieldPower " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldPower))
  DebugTrace("ObjectiveShieldedCargo " + pq.GetObjectiveValue(playerShip, consts.ObjectiveShieldedCargo))
  DebugTrace("ObjectiveThrust " + pq.GetObjectiveValue(playerShip, consts.ObjectiveThrust))
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

Function DebugPlaceShip() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  spaceshipreference playerShip = Game.GetPlayerHomeSpaceShip()
  spaceshipreference ship = pq.ShipCollection[0]

  ; reset ship
  DebugTrace("Resetting Ship")
  ship.Reset(None)
  ship.MoveNear(playerShip, playerShip.CONST_NearPosition_Random, playerShip.CONST_NearDistance_Close, playerShip.CONST_NearFacing_TotallyRandom)

  ship.EnableWithGravJump()
  DebugTrace("Autopilot AI " + ship.GetSpaceshipAutopilotAI().GetBaseObject())
  DebugTrace("AI Enabled: " + ship.IsAIEnabled())
  ship.EvaluatePackage(True)
  Form XMarker = Game.GetFormFromFile(59, "Starfield.esm") ; #DEBUG_LINE_NO:1574
  ObjectReference targetMarker = playership.PlaceAtMe(XMarker, 1, False, False, True, None, None, True) ; #DEBUG_LINE_NO:1575
  targetMarker.MoveNear(playership, playership.CONST_NearPosition_Random, playership.CONST_NearDistance_VeryLong, playership.CONST_NearFacing_TotallyRandom) ; #DEBUG_LINE_NO:1576
  targetMarker.SetPosition(targetMarker.X + 1000.0, targetMarker.Y, targetMarker.Z) ; #DEBUG_LINE_NO:1577
  ship.PathToReference(targetMarker, 0.25, 0.25, 1.0, 1.0)

  ;ship.GetSpaceshipAutopilotAI().ForceMovementSpeed(-1.0)
  ;ship.SetAttackShipOnSight(True)
  ;ship.SetUnconscious(True)
  ;ship.SetUnconscious(False)

EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[astroneer] " + Text, 0);;
EndFunction
