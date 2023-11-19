ScriptName Astroneer:ParentQuest extends Quest Conditional
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
  FormList Property ShipNames Auto Const Mandatory
  Scene Property SceneMissionBoardIntro Auto Const Mandatory
  ReferenceAlias Property AtlasIntercom Auto Const
  ReferenceAlias Property Aria Auto Const
  spaceshipreference[] Property ShipCollection Auto
EndGroup

Group DialogueData
  Int Property DialogueIntroComplete = 0 Auto Conditional
  Int Property DialogueReflectComplete = 0 Auto Conditional
  Int Property DialogueBadNewsComplete = 0 Auto Conditional
  Int Property DialogueBackgroundComplete = 0 Auto Conditional
EndGroup

Bool Property AtlasWorkshopMode = False auto

Astroneer:Pack:Mission[] Missions = None

Event OnQuestInit()
  Trace("OnQuestInit")
  Actor PlayerREF = Game.GetPlayer()
  Trace("Registering for events...")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerLoadGame")
  Self.RegisterForRemoteEvent(PlayerREF as ObjectReference, "OnCellAttach")
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")

  AddMissions()
  InitIntercom()
EndEvent

Event OnMenuOpenCloseEvent(String menuName, Bool open)
  Trace("OnMenuOpenCloseEvent " + menuName + " " + open)
  if menuName == "SpaceshipEditorMenu" && AtlasWorkshopMode && !open
    RefCollectionAlias ships = PlayerShipQuest.PlayerShips
    Keyword CannotBeModified = Game.GetForm(0x003413f3) as Keyword
    Astroneer:ShipContractMissionScript mission = AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript

    Int i = 0
    While i < ships.GetCount()
      spaceshipreference ship = ships.GetAt(i) as spaceshipreference
      if ship != mission.ContractShip
        ship.RemoveKeyword(CannotBeModified)
      endif
      i += 1
    EndWhile
    AtlasWorkshopMode = False
  endif
EndEvent

Event ObjectReference.OnCellAttach(ObjectReference akRef)
  Trace("OnCellAttach")
  InitIntercom()
EndEvent

Function InitIntercom()
  Cell spaceport = Game.GetForm(0x00014cb3) as Cell
  Activator intercomForm = Game.GetForm(0x02000843) as Activator
  ActorBase ariaForm = Game.GetForm(0x02000835) as ActorBase

  if (spaceport.IsLoaded() && !AtlasIntercom.IsFilled())
    ObjectReference intercom = Game.GetPlayer().PlaceAtMe(intercomForm, 1, True, False, False, None, None, True)
    intercom.SetPosition(-828.62, 1603.28, -165.53)
    intercom.SetAngle(-0.00, -0.00, -137.15)
    Trace("Created intercom and setting ref " + intercom)
    AtlasIntercom.ForceRefTo(intercom)
  endif

  if (spaceport.IsLoaded() && !Aria.IsFilled())
    Actor ariaRef = AtlasIntercom.GetReference().PlaceActorAtMe(ariaForm, 1, None, True, False, False, None, True)
    ariaRef.SetPosition(-828.62, 1603.28, -165.53)
    ariaRef.SetAngle(-0.00, -0.00, -137.15)
    Trace("Created aria and setting ref " + ariaRef)
    Aria.ForceRefTo(ariaRef)
    PlaceAria()
  endif
EndFunction

; Dirty hack to get aria to appear near the intercom
Function PlaceAria()
  Actor ariaRef = Aria.GetActorReference()
  ariaRef.SetMotionType(ariaRef.Motion_Keyframed, True)
  ariaRef.SetPosition(-828.8, 1603.2, -165.8)
  ariaRef.SetAngle(0.00, 0.00, -137.15)
  ariaRef.SetAlpha(0.0, False)
  ariaRef.SetGhost(True)
  ariaRef.SetMotionType(ariaRef.Motion_Dynamic, True)
EndFunction

Event Actor.OnPlayerLoadGame(Actor akActor)
  AddMissions()
  InitIntercom()
  Self.UnregisterForAllMenuOpenCloseEvents()
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
  ((Self as ScriptObject) as Astroneer:ResearchProjects).RegisterEvents()
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

  Trace("Loading mission packs...")
  LoadMissionPacks()

  MB_Parent.DebugResetMissions()
EndFunction

Function LoadMissionPacks()
  Missions = new Astroneer:Pack:Mission[0]
  Astroneer:Pack consts = (Self as ScriptObject) as Astroneer:Pack
  String[] missionPacks = new String[0]
  missionPacks.Add("Astroneer:ShipContractMissionPack1")

  ForEach String pack in missionPacks
    Trace("Loading Mission Pack: " + pack)
    Var[] args = new Var[0]
    args.Add(consts)
    Astroneer:Pack:Mission[] packMissions = Utility.CallGlobalFunction(pack, "Missions", args) as Astroneer:Pack:Mission[]
    ForEach Astroneer:Pack:Mission m in packMissions
      missions.Add(m)
    EndForEach
  EndForEach
EndFunction

; Creates a ContractShip and adds it to the player's ship list
spaceshipreference Function AddContractShip(Astroneer:Pack:Mission m)
  ; HACK: This is a hack to get around the fact that the ship builder
  ; mutates the form it is given.
  Form ShipTemplate = Game.GetForm(m.ShipTemplate)
  spaceshipreference ship = GetLandingMarker().PlaceShipAtMe(ShipTemplate, 1, True, True, True, False, None, None, None, True)
  Trace("Created ship " + ship + " from template " + m.ShipTemplate)

  ship.AddKeyword(CannotBeSoldShipKeyword)
  ship.AddKeyword(CannotBeHomeShipKeyword)
  ship.AddKeyword(CannotBeCountedAgainstMaxShipsKeyword)
  ship.SetValue(SpaceshipRegistration, 1.0)
  ship.SetOverrideName(m.Title)
  PlayerShipQuest.AddPlayerOwnedShip(ship)

  return ship
EndFunction

Function RemoveContractShip(spaceshipreference ship, Bool addToCollection)
  Trace("Removing ship " + ship)
  PlayerShipQuest.RemovePlayerShip(ship)
  ship.RemoveKeyword(CannotBeSoldShipKeyword)
  ship.RemoveKeyword(CannotBeHomeShipKeyword)
  ship.RemoveKeyword(CannotBeCountedAgainstMaxShipsKeyword)
  ship.SetValue(SpaceshipRegistration, 0.0)

  if (addToCollection)
    if(ShipCollection == None)
      ShipCollection = new spaceshipreference[0]
    endif
    ShipCollection.Add(ship)
  endif
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

  elseif (objectiveType == consts.ObjectiveCrewSlots)
    ActorValue crewSlotsAV = Game.GetForm(0x002CC9EA) as ActorValue
    return ship.GetValue(crewSlotsAV)

  elseif (objectiveType == consts.ObjectiveEnginePower)
    ActorValue engineAV = Game.GetForm(0x0000ACD9) as ActorValue
    return Math.Round(1.0 / ship.GetValue(engineAV))

  elseif (objectiveType == consts.ObjectiveFuel)
    ActorValue fuelAV = Game.GetForm(0x0000854f) as ActorValue
    return ship.GetBaseValue(fuelAV)

  elseif (objectiveType == consts.ObjectiveGravJumpRange)
    return ship.GetGravJumpRange()

  elseif (objectiveType == consts.ObjectiveHabs)
    return ship.GetExteriorRefs(SBShip_Hab).length

  elseif (objectiveType == consts.ObjectiveHull)
    ActorValue hullAV = Game.GetForm(0x000002d4) as ActorValue
    return ship.GetValue(hullAV)

  elseif (objectiveType == consts.ObjectiveMass)
    return ship.GetValue(SpaceshipMass)

  elseif (objectiveType == consts.ObjectiveReactorPower)
    ActorValue reactorAV = Game.GetForm(0x00001018) as ActorValue
    return ship.GetValue(reactorAV)

  elseif (objectiveType == consts.ObjectiveShieldedCargo)
    ActorValue shieldedCargoAV = Game.GetForm(0x0002b344) as ActorValue
    return ship.GetValue(shieldedCargoAV)

  elseif (objectiveType == consts.ObjectiveShieldHealth)
    ActorValue shieldHealthAV = Game.GetForm(0x0005bfa8) as ActorValue
    return ship.GetValue(shieldHealthAV)

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
    ; TODO: fix divide by zero bug here
    return Math.Round((1.0/ship.GetValue(wg1AV)) + (1.0/ship.GetValue(wg2AV)) + (1.0/ship.GetValue(wg3AV)))

  elseif (objectiveType == consts.ObjectiveWeaponPowerBallistic)
    Keyword WeaponTypeBallistic = Game.GetForm(0x00022269) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeBallistic)

  elseif (objectiveType == consts.ObjectiveWeaponPowerContinuousBeam)
    Keyword WeaponTypeContinuousBeam = Game.GetForm(0x00146b11) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeContinuousBeam)

  elseif (objectiveType == consts.ObjectiveWeaponPowerEM)
    Keyword WeaponTypeEM = Game.GetForm(0x0002226b) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeEM)

  elseif (objectiveType == consts.ObjectiveWeaponPowerEnergy)
    Keyword WeaponTypeEnergy = Game.GetForm(0x0002226a) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeEnergy)

  elseif (objectiveType == consts.ObjectiveWeaponPowerMissile)
    Keyword WeaponTypeMissile = Game.GetForm(0x00155c6c) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeMissile)

  elseif (objectiveType == consts.ObjectiveWeaponPowerParticle)
    Keyword WeaponTypeParticle = Game.GetForm(0x001557aa) as Keyword
    return GetWeaponTypePower(ship, WeaponTypeParticle)

  elseif (objectiveType == consts.ObjectiveWeaponPowerPlasma)
    Keyword WeaponTypePlasma = Game.GetForm(0x00146b38) as Keyword
    return GetWeaponTypePower(ship, WeaponTypePlasma)

  elseif (objectiveType == consts.ObjectiveWindows)
    Keyword SbShip_Window = Game.GetForm(0x00143b37) as Keyword
    return ship.GetExteriorRefs(SBShip_Window).length

  elseif (objectiveType == consts.ObjectiveThrust)
    ActorValue Thrust = Game.GetForm(0x0000ACDC) as ActorValue
    return ship.GetValue(Thrust)

  else
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

Astroneer:Pack:Mission Function GenerateMission()
  Astroneer:Pack consts = (Self as ScriptObject) as Astroneer:Pack
  Astroneer:Pack:Mission mission = Astroneer:Pack.Copy(missions[Utility.RandomInt(0, missions.Length-1)]) 

  if mission.Title == None
    mission.Title = ShipNames.GetAt(Utility.RandomInt(0, ShipNames.GetSize()-1)) as Message
  endif
  if mission.ShipType == None
    mission.ShipType = consts.ShipTypeFighter
  endif
  if mission.Text == None
    if mission.ShipType == consts.ShipTypeFighter
      mission.Text = consts.MissionTextsFighter.GetAt(Utility.RandomInt(0, consts.MissionTextsFighter.GetSize()-1)) as Message
    elseif mission.ShipType == consts.ShipTypeExplorer
      mission.Text = consts.MissionTextsExplorer.GetAt(Utility.RandomInt(0, consts.MissionTextsExplorer.GetSize()-1)) as Message
    elseif mission.ShipType == consts.ShipTypeHauler
      mission.Text = consts.MissionTextsHauler.GetAt(Utility.RandomInt(0, consts.MissionTextsHauler.GetSize()-1)) as Message
    elseif mission.ShipType == consts.ShipTypeInterceptor
      mission.Text = consts.MissionTextsInterceptor.GetAt(Utility.RandomInt(0, consts.MissionTextsInterceptor.GetSize()-1)) as Message
    elseif mission.ShipType == consts.ShipTypeLuxury
      mission.Text = consts.MissionTextsLuxury.GetAt(Utility.RandomInt(0, consts.MissionTextsLuxury.GetSize()-1)) as Message
    endif
  endif
  if mission.ShipTemplate == 0
    mission.ShipTemplate = consts.ShipTemplateDefault
  endif
  if mission.Difficulty == None
    mission.Difficulty = consts.DifficultyClassA
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
	; a bit advanced as Actor as Actor
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
	; this should never happen as String as String
	Trace("GetLandingMarker Milestone D")
	Return (Player as ObjectReference)
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
