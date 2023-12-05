ScriptName Astroneer

Function DebugInit() global
  DebugTrace("=DebugInit==============================================")
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
  DebugTrace("ObjectiveMobility " + pq.GetObjectiveValue(playerShip, consts.ObjectiveMobility))
  DebugTrace("ObjectiveHabArmory " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabArmory))
  DebugTrace("ObjectiveHabBattleStations " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabBattleStations))
  DebugTrace("ObjectiveHabBrig " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabBrig))
  DebugTrace("ObjectiveHabCaptainsQuarters " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabCaptainsQuarters))
  DebugTrace("ObjectiveHabCargo " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabCargo))
  DebugTrace("ObjectiveHabComputerCore " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabComputerCore))
  DebugTrace("ObjectiveHabControl " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabControl))
  DebugTrace("ObjectiveHabEngineering " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabEngineering))
  DebugTrace("ObjectiveHabInfirmary " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabInfirmary))
  DebugTrace("ObjectiveHabLivingSpace " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabLivingSpace))
  DebugTrace("ObjectiveHabMessHall " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabMessHall))
  DebugTrace("ObjectiveHabScienceLab " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabScienceLab))
  DebugTrace("ObjectiveHabStorage " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabStorage))
  DebugTrace("ObjectiveHabWorkshop " + pq.GetObjectiveValue(playerShip, consts.ObjectiveHabWorkshop))

  ; TODO: Add these in
  DebugTrace("ObjectiveCrewRating: " + playerShip.GetValue(Game.GetForm(0x00019080) as ActorValue))
  DebugTrace("ObjectiveCrewSlots: " + playerShip.GetValue(Game.GetForm(0x002cc9ea) as ActorValue))
EndFunction


Function DebugPlaceShip() global
  Astroneer:TrafficManager tm = Game.GetForm(0x020011D6) as Astroneer:TrafficManager
  tm.SpawnShip(False)
EndFunction

Function DebugPlaceEnemyShip() global
  Astroneer:TrafficManager tm = Game.GetForm(0x020011D6) as Astroneer:TrafficManager
  tm.SpawnShip(True)
EndFunction

Function DebugRemoveShip() global
  sq_playershipscript playerShip = Game.GetForm(95394) as sq_playershipscript
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest

  ObjectReference marker = pq.ContractShipLandingMarker
  ;TODO: Use a more specific keyword
  DebugTrace(marker.FindAllReferencesWithKeyword(Game.GetForm(0x0249fb3) as Keyword, 100))
EndFunction

Function DebugResetMissions() global
  Astroneer:ParentQuest pq = Game.GetForm(0x0200080d) as Astroneer:ParentQuest
  ForEach Form mission in pq.AstroneerMBQuests
    (mission as Astroneer:ShipContractMissionScript).ResetAliases()
  EndForEach
  pq.ResetMissionBoard()
  pq.MB_Parent.DebugResetMissions()
EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[astroneer] " + Text, 0)
EndFunction
