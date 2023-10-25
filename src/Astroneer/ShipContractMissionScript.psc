ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript
{ for ship contract missions }

;-- Variables ---------------------------------------

;-- Properties --------------------------------------
spaceshipreference Property ContractShip Auto
Astroneer:ParentQuest Property AstroneerParent Auto Const Mandatory

Group ShipObjectives
  Keyword Property ObjectiveType_01 Auto Const
  { The type of objective, referenced by a keyword }
  Int Property ObjectiveTarget_01 Auto Const
  { The target value for the objective }
  GlobalVariable Property ObjectiveValue_01 Auto Const
  { Global representing the current value of the objective, used for display }
  GlobalVariable Property ObjectiveTotal_01 Auto Const
  { Global representing the total value of the objective, used for display }

  Keyword Property ObjectiveType_02 Auto Const
  Int Property ObjectiveTarget_02 Auto Const
  GlobalVariable Property ObjectiveValue_02 Auto Const
  GlobalVariable Property ObjectiveTotal_02 Auto Const

  Keyword Property ObjectiveType_03 Auto Const
  Int Property ObjectiveTarget_03 Auto Const
  GlobalVariable Property ObjectiveValue_03 Auto Const
  GlobalVariable Property ObjectiveTotal_03 Auto Const

  Keyword Property ObjectiveType_04 Auto Const
  Int Property ObjectiveTarget_04 Auto Const
  GlobalVariable Property ObjectiveValue_04 Auto Const
  GlobalVariable Property ObjectiveTotal_04 Auto Const

  Keyword Property ObjectiveType_05 Auto Const
  Int Property ObjectiveTarget_05 Auto Const
  GlobalVariable Property ObjectiveValue_05 Auto Const
  GlobalVariable Property ObjectiveTotal_05 Auto Const
EndGroup

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
  Self.SetObjectiveDisplayed(10, True, False)

  ; FIXME: these should come from a property
  Form shipForm = Game.GetForm(0x0003e13e)
  Message shipName = Game.GetForm(0x003fe6d8) as Message

  Trace("Spawning ship " + shipForm)
  Self.ContractShip = AstroneerParent.AddContractShip(shipForm, shipName)

  UpdateObjectiveValues()

  ; FIXME: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function StageCompleted()
  Trace("StageCompleted")
  Self.MissionComplete()
EndFunction

Function UpdateObjectiveTargets()
  Trace("UpdateObjectiveTargets")

  UpdateObjectiveTarget(ObjectiveTotal_01, ObjectiveTarget_01)
  UpdateObjectiveTarget(ObjectiveTotal_02, ObjectiveTarget_02)
  UpdateObjectiveTarget(ObjectiveTotal_03, ObjectiveTarget_03)
  UpdateObjectiveTarget(ObjectiveTotal_04, ObjectiveTarget_04)
  UpdateObjectiveTarget(ObjectiveTotal_05, ObjectiveTarget_05)
EndFunction

Function UpdateObjectiveTarget(GlobalVariable total, Int value)
  if(total != None)
    total.SetValue(value)
    UpdateCurrentInstanceGlobal(total)
  endif
EndFunction

Function UpdateObjectiveValues()
  Trace("UpdateObjectiveValues")
  if(ContractShip != None)
    UpdateObjectiveValue(ObjectiveValue_01, ObjectiveType_01, 1, ObjectiveTarget_01)
    UpdateObjectiveValue(ObjectiveValue_02, ObjectiveType_02, 2, ObjectiveTarget_02)
    UpdateObjectiveValue(ObjectiveValue_03, ObjectiveType_03, 3, ObjectiveTarget_03)
    UpdateObjectiveValue(ObjectiveValue_04, ObjectiveType_04, 4, ObjectiveTarget_04)
    UpdateObjectiveValue(ObjectiveValue_05, ObjectiveType_05, 5, ObjectiveTarget_05)
  endif
EndFunction

Function UpdateObjectiveValue(GlobalVariable value, Keyword objectiveType, Int objective, Int target)
  if(value != None)
    value.SetValue(0) ;set to 0 since we are using mod
    AstroneerParent.GetObjectiveValue(ContractShip, objectiveType)
    ModObjectiveGlobal(objective, value, objective, target, True, True, True, True)
  endif
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
