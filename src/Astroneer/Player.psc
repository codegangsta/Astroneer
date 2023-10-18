ScriptName Astroneer:Player extends Actor

spaceshipreference Property ContractShip Auto

Function OnInit()
  Trace("OnInit()")
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")
EndFunction

Event OnMenuOpenCloseEvent(String asMenuName, Bool abOpening)
  Trace("OnMenuOpenCloseEvent(" + asMenuName + ", " + abOpening + ")")
  if(asMenuName == "SpaceshipEditorMenu" && abOpening && ContractShip as Bool)
    Debug.MessageBox("You have a ship contract!")
  endif
EndEvent

Event OnPlayerModifiedShip(spaceshipreference akShip)
  Trace("OnPlayerModifiedShip(" + akShip + ")")
  if(akShip == ContractShip)
    Debug.MessageBox("This is where we show how you've done with your ship")
  endif
EndEvent

Function AcceptContract()
  Trace("AcceptContract()")

  if(ContractShip as Bool)
    Trace("Contract Ship already exists")
    return
  endif

  Form shipForm = Game.GetForm(0x00215E9B)

  Trace("Spawning ship " + shipForm + " to world")
  spaceshipreference ship = GetLandingMarker().PlaceShipAtMe(shipForm, 1, False, True, True, False, None, None, None, True) as spaceshipreference

  Keyword cannotBeSoldShipKeyword = Game.GetForm(0x003413f2) as Keyword
  Trace("Adding keyword " + cannotBeSoldShipKeyword + " to ship")
  ship.AddKeyword(cannotBeSoldShipKeyword)

  Keyword cannotBeHomeShipKeyword = Game.GetForm(0x0014fc8d) as Keyword
  Trace("Adding keyword " + cannotBeHomeShipKeyword + " to ship")
  ship.AddKeyword(cannotBeHomeShipKeyword)

  Keyword cannotBeCountedAgainstMaxShipsKeyword = Game.GetForm(0x00107b20) as Keyword
  Trace("Adding keyword " + cannotBeCountedAgainstMaxShipsKeyword + " to ship")
  ship.AddKeyword(cannotBeCountedAgainstMaxShipsKeyword)

  Message shipNameMessage = Game.GetForm(0x003fe6d8) as Message
  Trace("Renaming ship to " + shipNameMessage)
  ship.SetOverrideName(shipNameMessage)

  ActorValue spaceshipRegistration = Game.GetForm(0x000C55B1) as ActorValue
  ship.SetValue(spaceshipRegistration, 1.0)

  Trace("Adding ship " + ship + " to player ships")
  sq_playershipscript playerShip = Game.GetForm(95394) as sq_playershipscript
  playerShip.AddPlayerOwnedShip(ship)
  Self.ContractShip = ship

  ; TODO: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function CompleteContract()
  if(ContractShip == None)
    Debug.Notification("You don't have a ship contract")
    return
  endif

  sq_playershipscript playerShip = Game.GetForm(95394) as sq_playershipscript
  playerShip.RemovePlayerShip(ContractShip)

  MiscObject credits = Game.GetCredits()
  ; TODO: Figure out a good system for pricing these out
  Self.AddItem(credits as Form, 50000, False)

  ; TODO: Add to reflist of spawnable ships
  ; TODO: Add to list of ships that can be sold by faction ship vendor

  Self.ContractShip = None
  Debug.Notification("Ship XXX removed from hangar")
EndFunction

Function CancelContract()
  if(ContractShip == None)
    Debug.Notification("You don't have a ship contract")
    return
  endif

  sq_playershipscript playerShip = Game.GetForm(95394) as sq_playershipscript
  playerShip.RemovePlayerShip(ContractShip)

  ; FIXME: Cannot delete ship, maybe there is a better way to clean up this ref?
  ; ContractShip.Delete()
  Self.ContractShip = None
  Debug.Notification("Ship XXX removed from hangar")
EndFunction

Function JoinCompany()
  ; TODO: Find company faction: in this case it's just Taiyo for now
  ; TODO: Add player to company faction
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
