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
EndGroup

Group ObjectiveKeywords
  Keyword Property ShipContractObjectiveCargo Auto Const Mandatory
  Keyword Property ShipContractObjectiveEnginePower Auto Const Mandatory
  Keyword Property ShipContractObjectiveGravJumpRange Auto Const Mandatory
  Keyword Property ShipContractObjectiveMass Auto Const Mandatory
EndGroup

Group QuestData
  sq_playershipscript Property PlayerShipQuest Auto Const Mandatory
  MissionParentScript Property MB_Parent Auto Const Mandatory
  FormList Property AstroneerMBQuests Auto Const Mandatory
  Scene Property SceneMissionBoardIntro Auto Const Mandatory
  ObjectReference[] Property ShipCollection Auto
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
  if(ShipCollection == None)
    Trace("Adding ship collection...")
    ShipCollection = new ObjectReference[0]
  endif

  Trace("Adding ship contract missions...")

  ; FIXME: Bind these to the script
  GlobalVariable MissionCompletedShipContract = Game.GetForm(0x02000802) as GlobalVariable
  Keyword MissionTypeShipContract = Game.GetForm(0x02000803) as Keyword

  MissionParentScript:MissionType shipContract = new MissionParentScript:MissionType
  shipContract.missionTypeKeyword = MissionTypeShipContract
  shipContract.MissionCompletedCount = MissionCompletedShipContract
  shipContract.RandomStoryEventOrder = True

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

  If (nameOverride as Bool)
    ship.SetOverrideName(nameOverride)
  EndIf

  PlayerShipQuest.AddPlayerOwnedShip(ship)

  return ship
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

Float Function GetObjectiveValue(spaceshipreference ship, Keyword objectiveType)
  if (objectiveType == ShipContractObjectiveCargo)
    return ship.GetShipMaxCargoWeight()

  elseif (objectiveType == ShipContractObjectiveEnginePower)
    return ship.GetValue(SpaceshipEnginePower)

  elseif (objectiveType == ShipContractObjectiveGravJumpRange)
    return ship.GetGravJumpRange()

  elseif (objectiveType == ShipContractObjectiveMass)
    return ship.GetValue(SpaceshipMass)

  else
    Trace("GetObjectiveValue: Unknown objective type: " + objectiveType)
    return -1
  endif
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
