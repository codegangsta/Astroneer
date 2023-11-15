ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript Conditional

;-- Properties --------------------------------------

Group ObjectiveGlobals
  GlobalVariable Property ObjectiveValue_01 Auto Const
  GlobalVariable Property ObjectiveValue_02 Auto Const
  GlobalVariable Property ObjectiveValue_03 Auto Const
  GlobalVariable Property ObjectiveValue_04 Auto Const
  GlobalVariable Property ObjectiveValue_05 Auto Const

  GlobalVariable Property ObjectiveTotal_01 Auto Const
  GlobalVariable Property ObjectiveTotal_02 Auto Const
  GlobalVariable Property ObjectiveTotal_03 Auto Const
  GlobalVariable Property ObjectiveTotal_04 Auto Const
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

Group FormLists
  FormList Property ObjectiveTypes Auto Const Mandatory
EndGroup

Astroneer:ParentQuest Property AstroneerParent Auto Const Mandatory
Message Property CompleteMessage Auto Const Mandatory

; Blank form (book) used for text replacement
Form Property TextReplacementForm Auto Const Mandatory
Message Property BlankMessage Auto Const Mandatory

Astroneer:Pack:Mission Property Mission Auto
spaceshipreference Property ContractShip Auto

Int Property DesignStage = 20 Auto Const
Int Property TurnInStage = 30 Auto Const

Int Property ShipType = 0 Auto Conditional

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")
  Self.Mission = AstroneerParent.GenerateMission()
  Self.ShipType = GetShipType()
  Trace("ShipType: " + Self.ShipType)

  UpdateObjectiveTargets()
  Parent.OnQuestStarted()
EndEvent

Int Function GetActualReward()
  return Mission.RewardCredits
EndFunction

Event OnStageSet(Int stageId, Int itemId)
  Trace("OnStageSet " + stageId + " " + itemId)
  if(stageId == ReadyStage)
    StageReady()
    return
  endif

  if(stageId == AcceptStage)
    StageAccepted()
    return
  endif

  if(stageId == DesignStage)
    StageDesign()
    return
  endif

  if(stageId == TurnInStage)
    StageTurnIn()
    return
  endif

  if(stageId == CompleteStage)
    StageCompleted()
    return
  endif
EndEvent

Function StageReady()
    FillRef(Self.GetAlias(9) as ReferenceAlias, Mission.Text)
    FillRef(Self.GetAlias(10) as ReferenceAlias, Mission.Title)
    FillRef(Self.GetAlias(11) as ReferenceAlias, Mission.Difficulty)
    FillRef(Self.GetAlias(12) as ReferenceAlias, Mission.Objective01)
    FillRef(Self.GetAlias(13) as ReferenceAlias, Mission.Objective02)
    FillRef(Self.GetAlias(14) as ReferenceAlias, Mission.Objective03)
    FillRef(Self.GetAlias(15) as ReferenceAlias, Mission.Objective04)
    FillRef(Self.GetAlias(16) as ReferenceAlias, Mission.Objective05)
    FillRef(Self.GetAlias(17) as ReferenceAlias, Mission.ShipType)

    UpdateObjectiveTargets()
EndFunction

Function StageAccepted()
  Trace("StageAccepted")
  Self.SetObjectiveDisplayed(0, True, False)
EndFunction

Function StageDesign()
  Trace("StageDesign")
  Self.SetObjectiveCompleted(0, True)

  if Mission.Objective01 != None
    Self.SetObjectiveDisplayed(ShipObjective_01, True, False)
  endif
  if Mission.Objective02 != None
    Self.SetObjectiveDisplayed(ShipObjective_02, True, False)
  endif
  if Mission.Objective03 != None
    Self.SetObjectiveDisplayed(ShipObjective_03, True, False)
  endif
  if Mission.Objective04 != None
    Self.SetObjectiveDisplayed(ShipObjective_04, True, False)
  endif
  if Mission.Objective05 != None
    Self.SetObjectiveDisplayed(ShipObjective_05, True, False)
  endif

  Self.ContractShip = AstroneerParent.AddContractShip(Mission)

  Actor PlayerREF = Game.GetPlayer() ; #DEBUG_LINE_NO:74
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")

  UpdateObjectiveValues()
EndFunction

Function StageCompleted()
  Trace("StageCompleted")

  Actor PlayerREF = Game.GetPlayer()
  Self.UnRegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")
  Self.UnRegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")

  AstroneerParent.RemoveContractShip(Self.ContractShip)
  Self.ContractShip = None
EndFunction

Function StageTurnIn()
EndFunction

Function FillRef(ReferenceAlias akAlias, Message akMessage)
  Trace("FillRef " + akAlias + " " + akMessage)
  ObjectReference item = Game.GetPlayer().PlaceAtMe(TextReplacementForm, 1, True, True, False, None, None, False)
  akAlias.ForceRefTo(item)

  if akMessage != None
    item.SetOverrideName(akMessage)
  else
    item.SetOverrideName(BlankMessage)
  endif
EndFunction


Event Actor.OnPlayerModifiedShip(Actor akActor, spaceshipreference akShip)
  if(akShip == Self.ContractShip)
    UpdateObjectiveValues()

    if AllShipObjectivesComplete()
      SetObjectiveDisplayedAtTop(CompleteObjective)
      if GetCurrentStageID() != TurnInStage
        SetStage(TurnInStage)
      endif
    else
      SetObjectiveDisplayed(CompleteObjective, False, False)
      if GetCurrentStageID() != DesignStage
        SetStage(DesignStage)
      endif
    endif
  endif
EndEvent

Bool Function AllShipObjectivesComplete()
  Trace("ShipObjectivesComplete")
  if(Mission.Objective01 != None && !IsObjectiveCompleted(ShipObjective_01))
    return False
  endif
  if(Mission.Objective02 != None && !IsObjectiveCompleted(ShipObjective_02))
    return False
  endif
  if(Mission.Objective03 != None && !IsObjectiveCompleted(ShipObjective_03))
    return False
  endif
  if(Mission.Objective04 != None && !IsObjectiveCompleted(ShipObjective_04))
    return False
  endif
  if(Mission.Objective05 != None && !IsObjectiveCompleted(ShipObjective_05))
    return False
  endif

  return True
EndFunction

Function UpdateObjectiveTargets()
  Trace("UpdateObjectiveTargets")

  UpdateObjectiveTarget(ObjectiveTotal_01, Mission.ObjectiveTarget01)
  UpdateObjectiveTarget(ObjectiveTotal_02, Mission.ObjectiveTarget02)
  UpdateObjectiveTarget(ObjectiveTotal_03, Mission.ObjectiveTarget03)
  UpdateObjectiveTarget(ObjectiveTotal_04, Mission.ObjectiveTarget04)
  UpdateObjectiveTarget(ObjectiveTotal_05, Mission.ObjectiveTarget05)
EndFunction

Function UpdateObjectiveTarget(GlobalVariable total, Float value)
  if(total != None)
    total.SetValue(value)
    UpdateCurrentInstanceGlobal(total)
  endif
EndFunction

Function UpdateObjectiveValues()
  Trace("UpdateObjectiveValues")

  ; Set ship allocations to zero for accurate
  ; objective value calculations
  AstroneerParent.SetAllPartPowers(ContractShip, 0)
  AstroneerParent.SetAllPartPowers(ContractShip, 1)

  UpdateObjectiveValue(ObjectiveValue_01, Mission.Objective01, ShipObjective_01, Mission.ObjectiveTarget01)
  UpdateObjectiveValue(ObjectiveValue_02, Mission.Objective02, ShipObjective_02, Mission.ObjectiveTarget02)
  UpdateObjectiveValue(ObjectiveValue_03, Mission.Objective03, ShipObjective_03, Mission.ObjectiveTarget03)
  UpdateObjectiveValue(ObjectiveValue_04, Mission.Objective04, ShipObjective_04, Mission.ObjectiveTarget04)
  UpdateObjectiveValue(ObjectiveValue_05, Mission.Objective05, ShipObjective_05, Mission.ObjectiveTarget05)
EndFunction

Function UpdateObjectiveValue(GlobalVariable value, Message objectiveType, Int objective, Float target)
  Trace("UpdateObjectiveValue " + objectiveType + " - " + value)
  if(objectiveType != None)
    Astroneer:Pack consts = (AstroneerParent as ScriptObject) as Astroneer:Pack

    value.SetValue(0) ;set to 0 since we are using mod
    Float val = AstroneerParent.GetObjectiveValue(ContractShip, objectiveType)
    Trace("Updating objective " + objectiveType + " to " + val)
    if objectiveType == consts.ObjectiveMass
      ModObjectiveGlobal(val, value, objective, target, False, True, True, True)
    else
      ModObjectiveGlobal(val, value, objective, target, True, True, True, True)
    endif
  endif
EndFunction

Int Function GetShipType()
  Astroneer:Pack consts = (AstroneerParent as ScriptObject) as Astroneer:Pack

  if(Mission.ShipType == consts.ShipTypeFighter)
    return 0
  elseif(Mission.ShipType == consts.ShipTypeExplorer)
    return 1
  elseif(Mission.ShipType == consts.ShipTypeHauler)
    return 2
  elseif(Mission.ShipType == consts.ShipTypeInterceptor)
    return 3
  elseif(Mission.ShipType == consts.ShipTypeLuxury)
    return 4
  endif
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
