ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript
{ for ship contract missions }

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
spaceshipreference Property ContractShip Auto
Astroneer:ParentQuest Property AstroneerParent Auto Const Mandatory

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
  UpdateShipRequirements()
  Parent.OnQuestStarted()
EndEvent

Function StageAccepted()
  Trace("StageAccepted")
  Self.SetObjectiveDisplayed(10, True, False)

  ; FIXME: these should come from a property
  Form shipForm = Game.GetForm(0x0003e13e)
  Message shipName = Game.GetForm(0x003fe6d8) as Message

  Trace("Spawning ship " + shipForm)
  Self.ContractShip = AstroneerParent.AddContractShip(shipForm, shipName)

  UpdateShipValues()

  ; FIXME: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function StageCompleted()
  Trace("StageCompleted")
  Self.MissionComplete()
EndFunction

Function UpdateShipRequirements()
  ; Override this in child scripts
EndFunction

Function UpdateShipValues()
  ; Override this in child scripts
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
