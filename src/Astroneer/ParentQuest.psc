ScriptName Astroneer:ParentQuest extends Quest Conditional
; Parent Quest for all astroneer based functionality
; Provides some utility functions and easy access to key
; forms and refs.

Group Keywords
  Keyword Property CannotBeSoldShipKeyword Auto Const Mandatory
  Keyword Property CannotBeHomeShipKeyword Auto Const Mandatory
  Keyword Property CannotBeCountedAgainstMaxShipsKeyword Auto Const Mandatory
  Keyword Property SBShip_Hab Auto Const Mandatory
  Keyword Property SBShip_Window Auto Const Mandatory
  Keyword Property CurrentContractShipKeyword Auto Const Mandatory
  Keyword Property CannotBeModifiedShipKeyword Auto Const Mandatory
  Keyword Property MissionTypeShipContract Auto Const Mandatory
  Keyword Property SpaceshipBallisticWeapon Auto Const Mandatory
  Keyword Property SpaceshipContinuousBeamWeapon Auto Const Mandatory
  Keyword Property SpaceshipEMWeapon Auto Const Mandatory
  Keyword Property SpaceshipEnergyWeapon Auto Const Mandatory
  Keyword Property SpaceshipMissileWeapon Auto Const Mandatory
  Keyword Property SpaceshipParticleWeapon Auto Const Mandatory
  Keyword Property SpaceshipPlasmaWeapon Auto Const Mandatory
EndGroup

Group ActorValues
  ActorValue Property ShipWeaponSystemGroup1Health Auto Const Mandatory
  ActorValue Property ShipWeaponSystemGroup2Health Auto Const Mandatory
  ActorValue Property ShipWeaponSystemGroup3Health Auto Const Mandatory
  ActorValue Property SpaceshipBuildableEnginePower Auto Const Mandatory
  ActorValue Property SpaceshipBuildableShieldPower Auto Const Mandatory
  ActorValue Property SpaceshipEnginePower Auto Const Mandatory
  ActorValue Property SpaceshipEngineThrust Auto Const Mandatory
  ActorValue Property SpaceshipGravJumpFuel Auto Const Mandatory
  ActorValue Property SpaceshipHealth Auto Const Mandatory
  ActorValue Property SpaceshipManeuveringThrust Auto Const Mandatory
  ActorValue Property SpaceshipMass Auto Const Mandatory
  ActorValue Property SpaceshipMaxPower Auto Const Mandatory
  ActorValue Property SpaceshipPassengerSlots Auto Const Mandatory
  ActorValue Property SpaceshipRegistration Auto Const Mandatory
  ActorValue Property SpaceshipShieldedCargo Auto Const Mandatory
  ActorValue Property SpaceshipShieldHealth Auto Const Mandatory
  ActorValue Property SpaceshipThrustPerPower Auto Const Mandatory
  ActorValue Property SpaceshipTopSpeed Auto Const Mandatory
  ActorValue Property SpaceshipWeaponPowerGroup1 Auto Const Mandatory
  ActorValue Property SpaceshipWeaponPowerGroup2 Auto Const Mandatory
  ActorValue Property SpaceshipWeaponPowerGroup3 Auto Const Mandatory
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
  ReferenceAlias Property ShipMarker Auto Const
EndGroup

Group Globals
  GlobalVariable Property MissionCompletedShipContract Auto Const Mandatory
EndGroup

Group Forms
  Form Property AriaForm Auto Const Mandatory
  Form Property WallForm Auto Const Mandatory
  Form Property ShipMarkerForm Auto Const Mandatory
  ObjectReference Property AriaLocation Auto Mandatory
EndGroup

Group DialogueData
  Int Property DialogueIntroComplete = 0 Auto Conditional
  Int Property DialogueReflectComplete = 0 Auto Conditional
  Int Property DialogueBadNewsComplete = 0 Auto Conditional
  Int Property DialogueBackgroundComplete = 0 Auto Conditional
EndGroup

Group Factions
  FormList Property ShipFactions Auto Const Mandatory
  FormList Property EnemyShipFactions Auto Const Mandatory
EndGroup

spaceshipreference[] Property BuilderDisabledShips Auto

Bool Property AtlasWorkshopMode = False auto
Astroneer:Pack:Mission[] Missions = None
Bool Property DisableReactorClass = False Auto

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
    ForEach spaceshipreference ship in BuilderDisabledShips
      ship.RemoveKeyword(CannotBeModifiedShipKeyword)
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

Function DeleteAria()
  Trace("DeleteAria")
  Aria.GetActorReference().Delete()
  Aria.ForceRefTo(None)
  AriaWall.GetReference().Delete()
  AriaWall.ForceRefTo(None)
EndFunction

Function InitAria()
  Trace("InitAria")
  Cell spaceport = Game.GetForm(0x00014cb3) as Cell

  if (spaceport != None)
    if (spaceport.IsLoaded() && !AriaWall.IsFilled())
      ObjectReference wall = AriaLocation.PlaceAtMe(wallForm, 1, True, False, False, None, None, True)
      wall.SetPosition(-805.00, 1572.85, -163.54)
      wall.SetAngle(0, 0, 0)
      Trace("Created wall and setting ref " + wall)
      AriaWall.ForceRefTo(wall)
    endif

    Bool fillAria = !Aria.IsFilled() || Aria.GetActorReference().GetBaseObject() != AriaForm

    if (spaceport.IsLoaded() && fillAria)
      Actor ariaRef = AriaWall.GetReference().PlaceActorAtMe(AriaForm as ActorBase, 1, None, True, False, False, None, True)
      Trace("Created aria and setting ref " + ariaRef)
      Aria.ForceRefTo(ariaRef)
      ariaRef.MoveToFurniture(AriaWall.GetReference())
      ResetMissionBoard()
    endif

    if(!spaceport.IsLoaded() && fillAria)
      Trace("Forcing Arias to none")
      Aria.ForceRefTo(None)
    endif

    if (spaceport.IsLoaded() && !ShipMarker.isFilled())
      ResetLandingMarker()
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
  spaceshipreference ship = GetLandingMarker().PlaceShipAtMe(ShipTemplate, Game.GetPlayerLevel(), True, True, True, False, None, None, None, True)
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
  ; Remove landing marker ref

  ship.DisableWithTakeoffOrLandingNoWait()
  ship.SetLinkedRef(None, PlayerShipQuest.LandingMarkerKeyword, False)
  PlayerShipQuest.RemovePlayerShip(ship)

  ResetLandingMarker()
EndFunction

Function ResetLandingMarker()
  ShipMarker.TryToDelete()
  ObjectReference marker = ContractShipLandingMarker.PlaceAtMe(ShipMarkerForm, 1, True, False, False, None, None, True)
  Trace("Created marker and setting ref " + marker)
  ShipMarker.ForceRefTo(marker)
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
    return ship.GetValue(SpaceshipPassengerSlots)

  elseif (objectiveType == consts.ObjectiveEnginePower)
    return Math.Round(1.0 / ship.GetValue(SpaceshipBuildableEnginePower))

  elseif (objectiveType == consts.ObjectiveFuel)
    return ship.GetBaseValue(SpaceshipGravJumpFuel)

  elseif (objectiveType == consts.ObjectiveGravJumpRange)
    return ship.GetGravJumpRange()

  elseif (objectiveType == consts.ObjectiveHabs)
    return ship.GetExteriorRefs(SBShip_Hab).length

  elseif (objectiveType == consts.ObjectiveHull)
    return ship.GetValue(SpaceshipHealth)

  elseif (objectiveType == consts.ObjectiveMass)
    return ship.GetValue(SpaceshipMass)

  elseif (objectiveType == consts.ObjectiveReactorPower)
    return ship.GetValue(SpaceshipMaxPower)

  elseif (objectiveType == consts.ObjectiveShieldedCargo)
    return ship.GetValue(SpaceshipShieldedCargo)

  elseif (objectiveType == consts.ObjectiveShieldHealth)
    return ship.GetValue(SpaceshipShieldHealth)

  elseif (objectiveType == consts.ObjectiveShieldpower)
    return Math.Round(1.0 / ship.GetValue(SpaceshipBuildableShieldPower))

  elseif (objectiveType == consts.ObjectiveTopSpeed)
    return ship.GetValue(SpaceshipTopSpeed)

  elseif (objectiveType == consts.ObjectiveTotalWeaponPower)
    ; TODO: fix divide by zero bug here
    return Math.Round((1.0/ship.GetValue(SpaceshipWeaponPowerGroup1)) + (1.0/ship.GetValue(SpaceshipWeaponPowerGroup2)) + (1.0/ship.GetValue(SpaceshipWeaponPowerGroup3)))

  elseif (objectiveType == consts.ObjectiveWeaponPowerBallistic)
    return GetWeaponTypePower(ship, SpaceshipBallisticWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerContinuousBeam)
    return GetWeaponTypePower(ship, SpaceshipContinuousBeamWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerEM)
    return GetWeaponTypePower(ship, SpaceshipEMWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerEnergy)
    return GetWeaponTypePower(ship, SpaceshipEnergyWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerMissile)
    return GetWeaponTypePower(ship, SpaceshipMissileWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerParticle)
    return GetWeaponTypePower(ship, SpaceshipParticleWeapon)

  elseif (objectiveType == consts.ObjectiveWeaponPowerPlasma)
    return GetWeaponTypePower(ship, SpaceshipPlasmaWeapon)

  elseif (objectiveType == consts.ObjectiveWindows)
    return ship.GetExteriorRefs(SBShip_Window).length

  elseif (objectiveType == consts.ObjectiveThrust)
    return ship.GetValue(SpaceshipEngineThrust)

  elseif (objectiveType == consts.ObjectiveMobility)
    Float enginePower = 1.0 / ship.GetValue(SpaceshipBuildableEnginePower)
    Float mass = ship.GetValue(SpaceshipMass)
    Float maneuveringThrust = ship.GetValue(SpaceshipManeuveringThrust)
    Float thrust = ship.GetValue(SpaceshipEngineThrust)
    Float thrustPerPower = ship.GetValue(SpaceshipThrustPerPower)
    Float enginePowerPer = (thrustPerPower*enginePower) / thrust
    return Math.Clamp(Math.Round((11.9 * ((maneuveringThrust*enginePowerPer) / mass)) - 47.6), 0.0, 100.0)

  elseif (objectiveType == consts.ObjectiveHabArmory)
    return GetNumHabsByType(ship, consts.HabTypeArmory)

  elseif (objectiveType == consts.ObjectiveHabBattleStations)
    return GetNumHabsByType(ship, consts.HabTypeBattleStations)

  elseif (objectiveType == consts.ObjectiveHabBrig)
    return GetNumHabsByType(ship, consts.HabTypeBrig)

  elseif (objectiveType == consts.ObjectiveHabCaptainsQuarters)
    return GetNumHabsByType(ship, consts.HabTypeCaptainsQuarters)

  elseif (objectiveType == consts.ObjectiveHabCargo)
    return GetNumHabsByType(ship, consts.HabTypeCargo)

  elseif (objectiveType == consts.ObjectiveHabComputerCore)
    return GetNumHabsByType(ship, consts.HabTypeComputerCore)

  elseif (objectiveType == consts.ObjectiveHabControl)
    return GetNumHabsByType(ship, consts.HabTypeControl)

  elseif (objectiveType == consts.ObjectiveHabEngineering)
    return GetNumHabsByType(ship, consts.HabTypeEngineering)

  elseif (objectiveType == consts.ObjectiveHabInfirmary)
    return GetNumHabsByType(ship, consts.HabTypeInfirmary)

  elseif (objectiveType == consts.ObjectiveHabLivingSpace)
    return GetNumHabsByType(ship, consts.HabTypeLivingSpace)

  elseif (objectiveType == consts.ObjectiveHabMessHall)
    return GetNumHabsByType(ship, consts.HabTypeMessHall)
    
  elseif (objectiveType == consts.ObjectiveHabScienceLab)
    return GetNumHabsByType(ship, consts.HabTypeScienceLab)

  elseif (objectiveType == consts.ObjectiveHabStorage)
    return GetNumHabsByType(ship, consts.HabTypeStorage)

  elseif (objectiveType == consts.ObjectiveHabWorkshop)
    return GetNumHabsByType(ship, consts.HabTypeWorkshop)

  else
    return -1
  endif
EndFunction

Int Function GetNumHabsByType(spaceshipreference ship, FormList habType)
  Int count = 0
  ForEach ObjectReference hab in ship.GetExteriorRefs(SBShip_Hab)
    if habType.HasForm(hab.GetBaseObject())
      count += 1
    endif
  EndForEach
  return count
EndFunction

Float Function GetWeaponTypePower(spaceshipreference ship, Keyword type)
  Weapon group1 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup1Health)
  Weapon group2 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup2Health)
  Weapon group3 = ship.GetWeaponGroupBaseObject(ShipWeaponSystemGroup3Health)

  if group1 != None && group1.HasKeyword(type)
    return 1.0 / ship.GetValue(SpaceshipWeaponPowerGroup1)
  elseif group2 != None && group2.HasKeyword(type)
    return 1.0 / ship.GetValue(SpaceshipWeaponPowerGroup2)
  elseif group3 != None && group3.HasKeyword(type)
    return 1.0 / ship.GetValue(SpaceshipWeaponPowerGroup3)
  else
    return 0
  endif
EndFunction

Astroneer:Pack:Mission Function GenerateMission()
  Astroneer:Pack consts = (Self as ScriptObject) as Astroneer:Pack
  Astroneer:Pack:Mission[] filteredMissions = new Astroneer:Pack:Mission[0]
  ForEach Astroneer:Pack:Mission m in missions
    if m.MinLevel <= Game.GetPlayerLevel()
      filteredMissions.Add(m)
    endif
  EndForEach
  Astroneer:Pack:Mission mission = Astroneer:Pack.Copy(filteredMissions[Utility.RandomInt(0, filteredMissions.Length-1)]) 

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
  return ShipMarker.GetReference()
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
