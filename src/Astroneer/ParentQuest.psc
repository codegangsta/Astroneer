ScriptName Astroneer:ParentQuest extends Quest
; Parent Quest for all astroneer based functionality
; Provides some utility functions and easy access to key
; forms and refs.

Group Keywords
  Keyword Property CannotBeSoldShipKeyword Auto Const Mandatory
  Keyword Property CannotBeHomeShipKeyword Auto Const Mandatory
  Keyword Property CannotBeCountedAgainstMaxShipsKeyword Auto Const Mandatory
  Keyword Property SBShip_Hab Auto Const Mandatory
EndGroup

Group ActorValues
  ActorValue Property SpaceshipRegistration Auto Const Mandatory
  ActorValue Property SpaceshipMass Auto Const Mandatory
  ActorValue Property SpaceshipMaxPower Auto Const Mandatory
  ActorValue Property SpaceshipEnginePower Auto Const Mandatory
  ActorValue Property SpaceshipTopSpeed Auto Const Mandatory
  ActorValue Property ShipWeaponSystemGroup1Health Auto Const Mandatory
  ActorValue Property ShipWeaponSystemGroup2Health Auto Const Mandatory
  ActorValue Property ShipWeaponSystemGroup3Health Auto Const Mandatory
EndGroup

Group QuestData
  sq_playershipscript Property PlayerShipQuest Auto Const Mandatory
  MissionParentScript Property MB_Parent Auto Const Mandatory
  FormList Property AstroneerMBQuests Auto Const Mandatory
  Scene Property SceneMissionBoardIntro Auto Const Mandatory
  ObjectReference[] Property ShipCollection Auto Const
EndGroup


Event OnQuestInit()
  Trace("OnQuestInit")
  Actor PlayerREF = Game.GetPlayer()
  Trace("Registering for events...")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerLoadGame")
  Self.RegisterForRemoteEvent(PlayerREF as ObjectReference, "OnCellAttach")
  AddMissions()
EndEvent

Event ObjectReference.OnCellAttach(ObjectReference akRef)
  Trace("OnCellAttach")

  Cell spaceport = Game.GetForm(0x00014cb3) as Cell
  if (spaceport.IsLoaded())
    Activator intercomForm = Game.GetForm(0x02000843) as Activator
    Trace("Intercom " + intercomForm)

    ; FIXME: force this to an alias and check before placing
    ObjectReference intercom = Game.GetPlayer().PlaceAtMe(intercomForm, 1, False, False, False, None, None, True)
    intercom.SetPosition(-828.62, 1603.28, -165.53)
    intercom.SetAngle(-0.00, -0.00, -137.15)

    ; FIXME: use a property here
    (Self.GetAlias(1) as ReferenceAlias).ForceRefTo(intercom)
  endif
EndEvent

Event Actor.OnPlayerLoadGame(Actor akActor)
  AddMissions()
EndEvent

Function AddMissions()
  Trace("Adding ship contract missions...")

  ; FIXME: Bind these to the script
  GlobalVariable MissionCompletedShipContract = Game.GetForm(0x02000802) as GlobalVariable
  Keyword MissionTypeShipContract = Game.GetForm(0x02000803) as Keyword

  MissionParentScript:MissionType shipContract = new MissionParentScript:MissionType
  shipContract.missionTypeKeyword = MissionTypeShipContract
  shipContract.MissionCompletedCount = MissionCompletedShipContract
  shipContract.RandomStoryEventOrder = False

  Trace("Adding mission type... " + shipContract)
  MB_Parent.MissionTypes.Add(shipContract)

  ForEach Form mission in AstroneerMBQuests
    Trace("Adding mission... " + mission)
    MB_Parent.missionQuests.Add(mission as Astroneer:ShipContractMissionScript)
  EndForEach

  MB_Parent.DebugResetMissions()
EndFunction

; Creates a ContractShip and adds it to the player's ship list
spaceshipreference Function AddContractShip(Form shipform, Message nameOverride)
  spaceshipreference ship = GetLandingMarker().PlaceShipAtMe(shipForm, 1, True, True, True, False, None, None, None, True)

  ship.AddKeyword(CannotBeSoldShipKeyword)
  ship.AddKeyword(CannotBeHomeShipKeyword)
  ship.AddKeyword(CannotBeCountedAgainstMaxShipsKeyword)
  ship.SetValue(SpaceshipRegistration, 1.0)

  ; Set ship allocations to zero for accurate
  ; objective value calculations
  SetAllPartPowers(ship, 0)
  SetAllPartPowers(ship, 1)

  If (nameOverride as Bool)
    ship.SetOverrideName(nameOverride)
  EndIf

  PlayerShipQuest.AddPlayerOwnedShip(ship)

  return ship
EndFunction

Function SetAllPartPowers(spaceshipreference ship, Int power)
  Int partType = 0
  While partType < 4
    Int partCount = ship.GetPartCount(partType)
    Int partIndex = 0
    While partIndex < partCount
      ship.SetPartPower(partType, partIndex, power)
      partIndex += 1
    EndWhile
    partType += 1
  EndWhile
EndFunction

Float Function GetObjectiveValue(spaceshipreference ship, Form objectiveType)
  Astroneer:Pack consts = (Self as ScriptObject) as Astroneer:Pack

  if (objectiveType == consts.ObjectiveCargo)
    return ship.GetShipMaxCargoWeight()

  elseif (objectiveType == consts.ObjectiveEnginePower)
    ActorValue engineAV = Game.GetForm(0x0000ACD9) as ActorValue
    return Math.Round(1.0 / ship.GetValue(engineAV))

  elseif (objectiveType == consts.ObjectiveGravJumpRange)
    return ship.GetGravJumpRange()

  elseif (objectiveType == consts.ObjectiveHabs)
    return ship.GetExteriorRefs(SBShip_Hab).length

  elseif (objectiveType == consts.ObjectiveMass)
    return ship.GetValue(SpaceshipMass)

  elseif (objectiveType == consts.ObjectiveCrewSlots)
    ActorValue crewSlotsAV = Game.GetForm(0x002CC9EA) as ActorValue
    return ship.GetValue(crewSlotsAV)

  elseif (objectiveType == consts.ObjectiveShieldpower)
    ActorValue shieldAV = Game.GetForm(0x0001ecce) as ActorValue
    return Math.Round(1.0 / ship.GetValue(shieldAV))

  elseif (objectiveType == consts.ObjectiveTopSpeed)
    ActorValue speedAV = Game.GetForm(0x00278988) as ActorValue
    return ship.GetValue(speedAV)

  elseif (objectiveType == consts.ObjectiveTotalWeaponPower)
    ActorValue wg1AV = Game.GetForm(0x00219625) as ActorValue
    ActorValue wg2AV = Game.GetForm(0x00219624) as ActorValue
    ActorValue wg3AV = Game.GetForm(0x00219623) as ActorValue
    return Math.Round((1.0/ship.GetValue(wg1AV)) + (1.0/ship.GetValue(wg2AV)) + (1.0/ship.GetValue(wg3AV)))

  elseif (objectiveType == consts.ObjectiveWindows)
    Keyword SbShip_Window = Game.GetForm(0x00143b37) as Keyword
    return ship.GetExteriorRefs(SBShip_Window).length

  else
    Trace("Fuel " + ship.GetValue(Game.GetForm(0x0000854f) as ActorValue))
    Trace("Shield Health " + ship.GetValue(Game.GetForm(0x0005bfa8) as ActorValue))
    Trace("Forward Force per power " + ship.GetValue(Game.GetForm(0x000fc913) as ActorValue))
    Trace("Reactor Power " + ship.GetValue(Game.GetForm(0x00001018) as ActorValue))
    Trace("Shielded Cargo " + ship.GetValue(Game.GetForm(0x0002b344) as ActorValue))
    Trace("Hull " + ship.GetValue(Game.GetForm(0x000002d4) as ActorValue))
    Trace("Energy Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x0002226a) as Keyword))
    Trace("Kinetic Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x00022269) as Keyword))
    Trace("Missile Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x00155c6c) as Keyword))
    Trace("Particle Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x001557aa) as Keyword))
    Trace("Plasma Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x00146b38) as Keyword))
    Trace("EM Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x0002226b) as Keyword))
    Trace("Continuous Beam Weapon Power " + GetWeaponTypePower(ship, Game.GetForm(0x00146b11) as Keyword))
    Trace("GetObjectiveValue: Unknown objective type: " + objectiveType)

    Trace("Links " + ship.GetLinkedRefChain(None, 100))

    return -1
  endif
EndFunction

Float Function GetWeaponTypePower(spaceshipreference ship, Keyword type)
  ActorValue wg1AV = Game.GetForm(0x00219625) as ActorValue
  ActorValue wg2AV = Game.GetForm(0x00219624) as ActorValue
  ActorValue wg3AV = Game.GetForm(0x00219623) as ActorValue

  Weapon group1 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup1Health)
  Weapon group2 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup2Health)
  Weapon group3 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup3Health)

  if group1 != None && group1.HasKeyword(type)
    return 1.0 / ship.GetValue(wg1AV)
  elseif group2 != None && group2.HasKeyword(type)
    return 1.0 / ship.GetValue(wg2AV)
  elseif group3 != None && group3.HasKeyword(type)
    return 1.0 / ship.GetValue(wg3AV)
  else
    return 0
  endif
EndFunction

; TODO: Run this on startup and cache the results
Astroneer:Pack:Mission Function GetRandomMission()
  Astroneer:Pack:Mission[] missions = new Astroneer:Pack:Mission[0]
  String[] missionPacks = new String[0]
  Astroneer:Pack consts = (Self as ScriptObject) as Astroneer:Pack
  
  missionPacks.Add("Astroneer:ShipContractMissionPack1")

  ForEach String pack in missionPacks
    Var[] args = new Var[0]
    args.Add(consts)
    Astroneer:Pack:Mission[] packMissions = Utility.CallGlobalFunction(pack, "Missions", args) as Astroneer:Pack:Mission[]
    ForEach Astroneer:Pack:Mission m in packMissions
      Trace("GetRandomMission: " + m)
      missions.Add(m)
    EndForEach
  EndForEach

  Astroneer:Pack:Mission mission = missions[Utility.RandomInt(0, missions.Length-1)] 
  if mission.Title == None
    mission.Title = consts.MissionTextDefault
  endif
  if mission.Text == None
    mission.Text = consts.MissionTextDefault
  endif
  if mission.ShipTemplate == None
    mission.ShipTemplate = consts.ShipTemplateDefault
  endif
  if mission.Difficulty == None
    mission.Difficulty = consts.DifficultyTier1
  endif
  
  return mission
EndFunction

ObjectReference Function GetLandingMarker()
	; easy way
	ObjectReference LandingMarkerA = PlayerShipQuest.PlayerShipLandingMarker.GetReference()
	If (LandingMarkerA as Bool)
		Trace("GetLandingMarker Milestone A")
		Return LandingMarkerA
	EndIf
	; a bit advanced
	SpaceshipReference PlayerShipA = PlayerShipQuest.PlayerShip.GetShipReference()
	ObjectReference LandingMarkerB = PlayerShipA.GetLinkedRef(PlayerShipQuest.LandingMarkerKeyword)
	If (LandingMarkerB as Bool)
		Trace("GetLandingMarker Milestone B")
		Return LandingMarkerB
	EndIf
	; alias issue?
	Actor Player = Game.GetForm(0x14) as Actor
	SpaceshipReference PlayerShipB = Player.GetCurrentShipRef()
	ObjectReference LandingMarkerC = PlayerShipB.GetLinkedRef(Game.GetForm(0x1940B) as Keyword)
	If (LandingMarkerC as Bool)
		Trace("GetLandingMarker Milestone C")
		Return LandingMarkerC
	EndIf
	; this should never happen
	Trace("GetLandingMarker Milestone D")
	Return (Player as ObjectReference)
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
