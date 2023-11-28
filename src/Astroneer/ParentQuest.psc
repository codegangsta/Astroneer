ScriptName Astroneer:ParentQuest extends Quest Conditional
; Parent Quest for all astroneer based functionality
; Provides some utility functions and easy access to key
; forms and refs.

Group Keywords
  Keyword Property CannotBeSoldShipKeyword Auto Const Mandatory
  Keyword Property CannotBeHomeShipKeyword Auto Const Mandatory
  Keyword Property CannotBeCountedAgainstMaxShipsKeyword Auto Const Mandatory
  Keyword Property SBShip_Hab Auto Const Mandatory
  Keyword Property CurrentContractShipKeyword Auto Const Mandatory
  ;Keyword Property GenericNoSpaceVOKeyword Auto Const Mandatory
  ;Keyword Property PlayerShipAliasKeyword Auto Const Mandatory
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
  ReferenceAlias Property AriaWall Auto Const
  ReferenceAlias Property Aria Auto Const
  spaceshipreference[] Property ShipCollection Auto
  RefCollectionAlias Property CompletedShips Auto const mandatory
  Perk Property AriaFullDiscountPerk Auto Const Mandatory
  Perk Property AriaStandardDiscountPerk Auto Const Mandatory
  ObjectReference Property ContractShipLandingMarker Auto Const Mandatory
EndGroup

Group DialogueData
  Int Property DialogueIntroComplete = 0 Auto Conditional
  Int Property DialogueReflectComplete = 0 Auto Conditional
  Int Property DialogueBadNewsComplete = 0 Auto Conditional
  Int Property DialogueBackgroundComplete = 0 Auto Conditional
EndGroup

Group Factions
  FormList Property ShipFactions Auto Const Mandatory
EndGroup

spaceshipreference[] Property BuilderDisabledShips Auto

Bool Property AtlasWorkshopMode = False auto
Astroneer:Pack:Mission[] Missions = None

Event OnQuestInit()
  Trace("OnQuestInit")
  Actor PlayerREF = Game.GetPlayer()
  Trace("Registering for events...")
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerLoadGame")
  Self.RegisterForRemoteEvent(PlayerREF as ObjectReference, "OnCellLoad")
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")

  AddMissions()
  InitAria()
  AddPerks()
EndEvent

Event OnMenuOpenCloseEvent(String menuName, Bool open)
  Trace("OnMenuOpenCloseEvent " + menuName + " " + open)

  if menuName == "SpaceshipEditorMenu" && AtlasWorkshopMode && open
    Game.GetPlayer().AddPerk(AriaFullDiscountPerk, False)
  endif

  if menuName == "SpaceshipEditorMenu" && AtlasWorkshopMode && !open
    Keyword CannotBeModified = Game.GetForm(0x003413f3) as Keyword
    ForEach spaceshipreference ship in BuilderDisabledShips
      ship.RemoveKeyword(CannotBeModified)
    EndForEach
    BuilderDisabledShips = new spaceshipreference[0]

    Game.GetPlayer().RemovePerk(AriaFullDiscountPerk)
    AtlasWorkshopMode = False
  endif
EndEvent

Event ObjectReference.OnCellLoad(ObjectReference akRef)
  Trace("OnCellLoad")
  InitAria()
EndEvent

Function InitAria()
  Trace("InitAria")
  Cell spaceport = Game.GetForm(0x00014cb3) as Cell
  Activator wallForm = Game.GetForm(0x00138911) as Activator
  ActorBase ariaForm = Game.GetForm(0x02000835) as ActorBase

  if (spaceport != None)
    if (spaceport.IsLoaded() && !AriaWall.IsFilled())
      ObjectReference wall = Game.GetPlayer().PlaceAtMe(wallForm, 1, True, False, False, None, None, True)
      ; TODO: Make this a marker
      wall.SetPosition(-805.00, 1572.85, -163.54)
      wall.SetAngle(0, 0, 0)
      Trace("Created wall and setting ref " + wall)
      AriaWall.ForceRefTo(wall)
    endif

    if (spaceport.IsLoaded() && !Aria.IsFilled())
      Actor ariaRef = AriaWall.GetReference().PlaceActorAtMe(ariaForm, 1, None, True, False, False, None, True)
      Trace("Created aria and setting ref " + ariaRef)
      Aria.ForceRefTo(ariaRef)
      ariaRef.MoveToFurniture(AriaWall.GetReference())
      ResetMissionBoard()
    endif

    if (spaceport.IsLoaded())
      PlaceAria()
    endif
  endif
EndFunction

; Dirty hack to get aria to appear near the intercom
Function PlaceAria()
  Trace("PlaceAria")
  Actor ariaRef = Aria.GetActorReference()
  AriaWall.GetReference().SetPosition(-805.00, 1572.85, -163.54)
  AriaWall.GetReference().SetAngle(0, 0, 0)
  ariaRef.MoveToFurniture(AriaWall.GetReference())
EndFunction

Event Actor.OnPlayerLoadGame(Actor akActor)
  AddMissions()
  InitAria()
  AddPerks()
  Self.UnregisterForAllMenuOpenCloseEvents()
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
  Self.UnRegisterForRemoteEvent(Game.GetPlayer() as ObjectReference, "OnCellLoad")
  Self.RegisterForRemoteEvent(Game.GetPlayer() as ObjectReference, "OnCellLoad")
  ((Self as ScriptObject) as Astroneer:ResearchProjects).RegisterEvents()
EndEvent

Function AddPerks()
  Actor player = Game.GetPlayer()
  if (!player.HasPerk(AriaStandardDiscountPerk))
    Trace("Adding aria discount perk...")
    player.AddPerk(AriaStandardDiscountPerk, False)
  endif
EndFunction

Function AddMissions()
  Trace("Adding ship contract missions...")

  ; FIXME: Bind these to the script
  GlobalVariable MissionCompletedShipContract = Game.GetForm(0x02000802) as GlobalVariable
  Keyword MissionTypeShipContract = Game.GetForm(0x02000803) as Keyword

  ForEach MissionParentScript:MissionType missionType in MB_Parent.MissionTypes
    if missionType.missionTypeKeyword == MissionTypeShipContract
      Trace("Mission Type already exists: " + missionType)
      return
    endif
  EndForEach

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

  ResetMissionBoard()
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
  ship.AddKeyword(CurrentContractShipKeyword)
  ship.SetValue(SpaceshipRegistration, 1.0)
  ship.SetOverrideName(m.Title)
  PlayerShipQuest.AddPlayerOwnedShip(ship)

  return ship
EndFunction

Function RemoveContractShip(spaceshipreference ship, Bool addToCollection)
  if addToCollection
    CompletedShips.AddRef(ship)
  endif

  ship.RemoveKeyword(CannotBeSoldShipKeyword)
  ship.RemoveKeyword(CannotBeHomeShipKeyword)
  ship.RemoveKeyword(CannotBeCountedAgainstMaxShipsKeyword)
  ship.RemoveKeyword(CurrentContractShipKeyword)
  ship.SetValue(SpaceshipRegistration, 0.0)
  ship.DisableWithTakeoffOrLandingNoWait()
  PlayerShipQuest.RemovePlayerShip(ship)

  ; Add it to a random faction
  Faction shipFaction = ShipFactions.GetAt(Utility.RandomInt(0, ShipFactions.GetSize()-1)) as Faction
  ship.AddToFaction(shipFaction)
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

  elseif (objectiveType == consts.ObjectivePassengerSlots)
    ActorValue passengerSlotsAV = Game.GetForm(0x0001e7de) as ActorValue
    return ship.GetValue(passengerSlotsAV)

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

  elseif (objectiveType == consts.ObjectiveMobility)
    ; Mobility=Round ( 11.9*(Maneuvering Thrust / Mass)-47.6)

    ; Manueverint thrust per power
    ActorValue ManeuveringThrustAV = Game.GetForm(0x0000ACDE) as ActorValue
    ActorValue ThrustAV = Game.GetForm(0x0000ACDC) as ActorValue
    ActorValue ThrustPerPowerAV = Game.GetForm(0x000FC913) as ActorValue
    ActorValue engineAV = Game.GetForm(0x0000ACD9) as ActorValue

    Float enginePower = 1.0 / ship.GetValue(engineAV)
    Float mass = ship.GetValue(SpaceshipMass)
    Float maneuveringThrust = ship.GetValue(ManeuveringThrustAV)
    Float thrust = ship.GetValue(ThrustAV)
    Float thrustPerPower = ship.GetValue(ThrustPerPowerAV)
    Float enginePowerPer = (thrustPerPower*enginePower) / thrust

    return Math.Clamp(Math.Ceiling((11.9 * ((maneuveringThrust*enginePowerPer) / mass)) - 47.6), 0.0, 100.0)
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
    mission.ShipTemplate = consts.ShipTemplateFighter
  endif
  if mission.Difficulty == None
    mission.Difficulty = consts.DifficultyClassA
  endif
  
  return mission
EndFunction

Function ResetMissionBoard()
  Trace("ResetMissionBoard")
  Keyword MissionTypeShipContract = Game.GetForm(0x02000803) as Keyword
  Int i = 0
  While i < AstroneerMBQuests.GetSize()
    Quest mission = AstroneerMBQuests.GetAt(i) as Quest
    if mission.IsRunning() && mission.GetStage() > 5
      ; Return early if there is a mission that is in progress
      return
    endif
    mission.Stop()
    mission.Reset()
    i += 1
  EndWhile
  MissionTypeShipContract.SendStoryEvent(None, None, None, 0, 0)
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
