ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript
{ for ship contract missions }

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
spaceshipreference Property ContractShip Auto

Group ShipStats
  GlobalVariable Property ShipStat1 Auto Const
  GlobalVariable Property ShipStatRequirement1 Auto Const

  GlobalVariable Property ShipStat2 Auto Const
  GlobalVariable Property ShipStatRequirement2 Auto Const

  GlobalVariable Property ShipStat3 Auto Const
  GlobalVariable Property ShipStatRequirement3 Auto Const

  GlobalVariable Property ShipStat4 Auto Const
  GlobalVariable Property ShipStatRequirement4 Auto Const

  GlobalVariable Property ShipStat5 Auto Const
  GlobalVariable Property ShipStatRequirement5 Auto Const
EndGroup

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")
  SetShipRequirements()
  Parent.OnQuestStarted()
EndEvent

Function StageAccepted()
  Trace("StageAccepted")
  Self.SetObjectiveDisplayed(10, True, False)

  ; TODO: This should be a property
  Form shipForm = Game.GetForm(0x0003e13e)

  Trace("Spawning ship " + shipForm + " to world")
  spaceshipreference ship = GetLandingMarker().PlaceShipAtMe(shipForm, 1, True, True, True, False, None, None, None, True)

  ; TODO: Make these properties
  Keyword cannotBeSoldShipKeyword = Game.GetForm(0x003413f2) as Keyword
  Trace("Adding keyword " + cannotBeSoldShipKeyword + " to ship")
  ship.AddKeyword(cannotBeSoldShipKeyword)

  Keyword cannotBeHomeShipKeyword = Game.GetForm(0x0014fc8d) as Keyword
  Trace("Adding keyword " + cannotBeHomeShipKeyword + " to ship")
  ship.AddKeyword(cannotBeHomeShipKeyword)

  Keyword cannotBeCountedAgainstMaxShipsKeyword = Game.GetForm(0x00107b20) as Keyword
  Trace("Adding keyword " + cannotBeCountedAgainstMaxShipsKeyword + " to ship")
  ship.AddKeyword(cannotBeCountedAgainstMaxShipsKeyword)

  ; TODO: Pull this from a formlist
  Message shipNameMessage = Game.GetForm(0x003fe6d8) as Message
  Trace("Renaming ship to " + shipNameMessage)
  ship.SetOverrideName(shipNameMessage)

  ; TODO: Make this a property
  ActorValue spaceshipRegistration = Game.GetForm(0x000C55B1) as ActorValue
  ship.SetValue(spaceshipRegistration, 1.0)

  ; TODO: Use a property here as well
  Trace("Adding ship " + ship + " to player ships")
  sq_playershipscript playerShipQuest = Game.GetForm(95394) as sq_playershipscript
  playerShipQuest.AddPlayerOwnedShip(ship)
  Self.ContractShip = ship

  ; TODO: Add Ships
  SetShipValues()

  ; TODO: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function StageCompleted()
  Trace("StageCompleted")
  Self.MissionComplete()
EndFunction

Function SetShipRequirements()
  ; Override this in child scripts
EndFunction

Function SetShipValues()
  ; Override this in child scripts
EndFunction

ObjectReference Function GetLandingMarker()
	; easy way
	SQ_PlayerShipScript PlayerShipQuest = (Game.GetForm(0x174A2) as Quest) as SQ_PlayerShipScript
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
