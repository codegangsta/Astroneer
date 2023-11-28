ScriptName Astroneer:TrafficManager extends Quest

spaceshipreference Property SpawnedShip Auto
ReferenceAlias Property PlayerShip Auto Const Mandatory
Astroneer:ParentQuest Property ParentQuest Auto Const Mandatory
Astroneer:ShipContractMissionScript Property ContractMission Auto Const Mandatory

Int CheckStateTimerID = 1 Const
Float TimerMin = 60.0 Const
Float TimerMax = 300.0 Const
Int SpawnPercentage = 10 Const

Event OnQuestInit()
  Trace("OnQuestInit")
  Self.RegisterForRemoteEvent(PlayerShip as ScriptObject, "OnLocationChange")
EndEvent

Event ReferenceAlias.OnLocationChange(ReferenceAlias source, Location akOldLoc, Location akNewLoc)
  Trace("OnLocationChange")
  if PlayerShip.GetShipReference().IsInSpace()
    ResetTimer(5.0, 25.0)

    if ContractMission.ContractShip != None
      ContractMission.ContractShip.Disable(True)
    endif
  else
    CancelTimer(CheckStateTimerID)
    if SpawnedShip != None
      SpawnedShip.Disable(False)
    endif
  endif
EndEvent

Function ResetTimer(Float min, Float max)
  Float timerDuration = Utility.RandomFloat(min, max)
  Self.StartTimer(TimerDuration, CheckStateTimerID)
  Trace("ResetTimer " + timerDuration)
EndFunction

Event OnTimer(Int timerID)
  if !PlayerShip.GetShipReference().IsInSpace()
    return
  endif

  Trace("Checking to spawn ship")
  If timerID == CheckStateTimerID
    if Utility.RandomInt(0, 100) <= SpawnPercentage
      SpawnShip()
    endif

    ResetTimer(TimerMin, TimerMax)
  EndIf
EndEvent

Function SpawnShip()
  Trace("SpawnShip")
  spaceshipreference pShip = PlayerShip.GetShipReference()
  spaceshipreference ship = None
  while ship == None
    if ParentQuest.CompletedShips.GetCount() == 0
      Trace("No completed ships")
      return
    endif

    ship = ParentQuest.CompletedShips.GetRandom() as spaceshipreference
    if Game.IsPlayerSpaceshipOwner(ship) || ship.IsDead()
      ParentQuest.CompletedShips.RemoveRef(ship)
      ship = None
    endif
  endwhile

  if SpawnedShip != None
    SpawnedShip.DisableWithGravJump()
  endif
  SpawnedShip = ship

  ; reset ship
  ship.Reset(None)
  ship.MoveNear(pShip, pShip.CONST_NearPosition_ForwardWide, pShip.CONST_NearDistance_Close, pShip.CONST_NearFacing_TotallyRandom)

  ship.EnableWithGravJump()
  Form XMarker = Game.GetFormFromFile(59, "Starfield.esm")
  ObjectReference targetMarker = pShip.PlaceAtMe(XMarker, 1, False, False, True, None, None, True)
  targetMarker.MoveNear(pShip, pShip.CONST_NearPosition_Random, pShip.CONST_NearDistance_VeryLong, pShip.CONST_NearFacing_TotallyRandom)
  ship.SetLinkedRef(targetMarker, None, False)
  ship.EvaluatePackage(True)
  ship.SetForwardVelocity(0.1)
  Trace("Package " + ship.GetCurrentPackage())
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
