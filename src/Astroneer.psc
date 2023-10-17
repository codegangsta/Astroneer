ScriptName Astroneer

Function init() global
  Debug.Notification("ASTRO_Main init")
  Debug.TraceSelf(Self, "init", "Hello world")

EndFunction

Function addShip() global
  Form shipForm = Game.GetForm(0x00215E9B)
  Debug.TraceSelf(Self, "addShip", "adding player ship " + shipForm)

  ObjectReference ship = GetLandingMarker().PlaceShipAtMe(shipForm, 1, False, False, True, True, None, None, None, True)

  Debug.TraceSelf(Self, "addShip", "created objectref " + ship)

  sq_playershipscript PlayerShip = Game.GetForm(95394) as sq_playershipscript ; #DEBUG_LINE_NO:25
  PlayerShip.AddPlayerOwnedShip(ship as spaceshipreference)
EndFunction

Function cleanup() global
  Debug.Notification("ASTRO_Main cleanup")
EndFunction

ObjectReference Function GetLandingMarker() Global
	; easy way
	SQ_PlayerShipScript PlayerShipQuest = (Game.GetForm(0x174A2) as Quest) as SQ_PlayerShipScript
	ObjectReference LandingMarkerA = PlayerShipQuest.PlayerShipLandingMarker.GetReference()
	If (LandingMarkerA as Bool)
		DebugTrace("GetLandingMarker Milestone A")
		Return LandingMarkerA
	EndIf
	; a bit advanced
	SpaceshipReference PlayerShipA = PlayerShipQuest.PlayerShip.GetShipReference()
	ObjectReference LandingMarkerB = PlayerShipA.GetLinkedRef(PlayerShipQuest.LandingMarkerKeyword)
	If (LandingMarkerB as Bool)
		DebugTrace("GetLandingMarker Milestone B")
		Return LandingMarkerB
	EndIf
	; alias issue?
	Actor Player = Game.GetForm(0x14) as Actor
	SpaceshipReference PlayerShipB = Player.GetCurrentShipRef()
	ObjectReference LandingMarkerC = PlayerShipB.GetLinkedRef(Game.GetForm(0x1940B) as Keyword)
	If (LandingMarkerC as Bool)
		DebugTrace("GetLandingMarker Milestone C")
		Return LandingMarkerC
	EndIf
	; this should never happen
	DebugTrace("GetLandingMarker Milestone D")
	Return (Player as ObjectReference)
EndFunction

Function DebugTrace(String Text) Global
	Debug.Trace("[Astroneer] " + Text, 0)
EndFunction
