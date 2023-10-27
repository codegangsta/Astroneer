ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript
{ for ship contract missions }

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
spaceshipreference Property ContractShip Auto
Astroneer:ParentQuest Property AstroneerParent Auto Const Mandatory

Group ShipObjectives
  Keyword Property ObjectiveType_01 Auto Const
  { The type of objective, referenced by a keyword }
  Float Property ObjectiveTarget_01 Auto Const
  { The target value for the objective }
  GlobalVariable Property ObjectiveValue_01 Auto Const
  { Global representing the current value of the objective, used for display }
  GlobalVariable Property ObjectiveTotal_01 Auto Const
  { Global representing the total value of the objective, used for display }

  Keyword Property ObjectiveType_02 Auto Const
  Float Property ObjectiveTarget_02 Auto Const
  GlobalVariable Property ObjectiveValue_02 Auto Const
  GlobalVariable Property ObjectiveTotal_02 Auto Const

  Keyword Property ObjectiveType_03 Auto Const
  Float Property ObjectiveTarget_03 Auto Const
  GlobalVariable Property ObjectiveValue_03 Auto Const
  GlobalVariable Property ObjectiveTotal_03 Auto Const

  Keyword Property ObjectiveType_04 Auto Const
  Float Property ObjectiveTarget_04 Auto Const
  GlobalVariable Property ObjectiveValue_04 Auto Const
  GlobalVariable Property ObjectiveTotal_04 Auto Const

  Keyword Property ObjectiveType_05 Auto Const
  Float Property ObjectiveTarget_05 Auto Const
  GlobalVariable Property ObjectiveValue_05 Auto Const
  GlobalVariable Property ObjectiveTotal_05 Auto Const
EndGroup

Group ObjectiveIndexes
  Int Property ShipObjective_01 = 11 Auto Const
  Int Property ShipObjective_02 = 12 Auto Const
  Int Property ShipObjective_03 = 13 Auto Const
  Int Property ShipObjective_04 = 14 Auto Const
  Int Property ShipObjective_05 = 15 Auto Const
  Int Property CompleteObjective = 100 Auto Const
EndGroup

Message Property CompleteMessage Auto Const Mandatory
{ Message to display when the player visits the mission board after finishing the ship }

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")
  UpdateObjectiveTargets()
  Parent.OnQuestStarted()
EndEvent

Event OnStageSet(Int stageId, Int itemId)
  if(stageId == AcceptStage)
    StageAccepted()
    return
  endif

  if(stageId == CompleteStage)
    StageCompleted()
    return
  endif
EndEvent

Function StageAccepted()
  Trace("StageAccepted")
  ; FIXME: Put objective indexes in consts
  Self.SetObjectiveDisplayed(ShipObjective_01, True, False)
  Self.SetObjectiveDisplayed(ShipObjective_02, True, False)
  Self.SetObjectiveDisplayed(ShipObjective_03, True, False)
  Self.SetObjectiveDisplayed(ShipObjective_04, True, False)
  Self.SetObjectiveDisplayed(ShipObjective_05, True, False)

  ; FIXME: these should come from a property
  Form shipForm = Game.GetForm(0x0003e13e)
  Message shipName = Game.GetForm(0x003fe6d8) as Message

  Trace("Spawning ship " + shipForm)
  Self.ContractShip = AstroneerParent.AddContractShip(shipForm, shipName)

  Actor PlayerREF = Game.GetPlayer() ; #DEBUG_LINE_NO:74
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")

  UpdateObjectiveValues()

  ; FIXME: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function StageCompleted()
  Trace("StageCompleted")
  Self.MissionComplete()

  Actor PlayerREF = Game.GetPlayer()
  Self.UnRegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")
EndFunction

Event Actor.OnPlayerModifiedShip(Actor akActor, spaceshipreference akShip)
  Trace("OnPlayerModifiedShip")
  if(akShip == Self.ContractShip)
    UpdateObjectiveValues()

    if AllShipObjectivesComplete()
      Int turnIn = CompleteMessage.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      ;SetObjectiveDisplayedAtTop(CompleteObjective)
    endif
  endif
EndEvent

Function UpdateObjectiveTargets()
  Trace("UpdateObjectiveTargets")

  UpdateObjectiveTarget(ObjectiveTotal_01, ObjectiveTarget_01)
  UpdateObjectiveTarget(ObjectiveTotal_02, ObjectiveTarget_02)
  UpdateObjectiveTarget(ObjectiveTotal_03, ObjectiveTarget_03)
  UpdateObjectiveTarget(ObjectiveTotal_04, ObjectiveTarget_04)
  UpdateObjectiveTarget(ObjectiveTotal_05, ObjectiveTarget_05)
EndFunction

Bool Function AllShipObjectivesComplete()
  Trace("ShipObjectivesComplete")
  if(HasObjective(ShipObjective_01) && !IsObjectiveCompleted(ShipObjective_01))
    return False
  endif
  if(HasObjective(ShipObjective_02) && !IsObjectiveCompleted(ShipObjective_02))
    return False
  endif
  if(HasObjective(ShipObjective_03) && !IsObjectiveCompleted(ShipObjective_03))
    return False
  endif
  if(HasObjective(ShipObjective_04) && !IsObjectiveCompleted(ShipObjective_04))
    return False
  endif
  if(HasObjective(ShipObjective_05) && !IsObjectiveCompleted(ShipObjective_05))
    return False
  endif

  return True
EndFunction

Function UpdateObjectiveTarget(GlobalVariable total, Float value)
  if(total != None)
    total.SetValue(value)
    UpdateCurrentInstanceGlobal(total)
  endif
EndFunction

Function UpdateObjectiveValues()
  Trace("UpdateObjectiveValues")
  UpdateObjectiveValue(ObjectiveValue_01, ObjectiveType_01, ShipObjective_01, ObjectiveTarget_01)
  UpdateObjectiveValue(ObjectiveValue_02, ObjectiveType_02, ShipObjective_02, ObjectiveTarget_02)
  UpdateObjectiveValue(ObjectiveValue_03, ObjectiveType_03, ShipObjective_03, ObjectiveTarget_03)
  UpdateObjectiveValue(ObjectiveValue_04, ObjectiveType_04, ShipObjective_04, ObjectiveTarget_04)
  UpdateObjectiveValue(ObjectiveValue_05, ObjectiveType_05, ShipObjective_05, ObjectiveTarget_05)
EndFunction

Function UpdateObjectiveValue(GlobalVariable value, Keyword objectiveType, Int objective, Float target)
  Trace("UpdateObjectiveValue " + objectiveType + " - " + value)
  if(value != None && objectiveType != None)
    value.SetValue(0) ;set to 0 since we are using mod
    Float val = AstroneerParent.GetObjectiveValue(ContractShip, objectiveType)
    Trace("Updating objective " + objectiveType + " to " + val)
    ModObjectiveGlobal(val, value, objective, target, True, True, True, True)
  endif
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
