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

  DebugTrace("Price? " + playership.GetBaseObject().GetGoldValue())

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
  DebugTrace("ObjectiveMobility " + pq.GetObjectiveValue(playerShip, consts.ObjectiveMobility))
  DebugTrace("ObjectiveHabScienceLab " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabScienceLab))

  ; TODO: Add these in
  DebugTrace("ObjectiveCrewRating: " + playerShip.GetValue(Game.GetForm(0x00019080) as ActorValue))
  DebugTrace("ObjectiveCrewSlots: " + playerShip.GetValue(Game.GetForm(0x002cc9ea) as ActorValue))
EndFunction


Function DebugPlaceShip() global
  Astroneer:TrafficManager tm = Game.GetForm(0x020011D6) as Astroneer:TrafficManager
  tm.SpawnShip()
EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[astroneer] " + Text, 0)
EndFunction
