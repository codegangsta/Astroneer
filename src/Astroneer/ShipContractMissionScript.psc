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
  Int Property ShipObjective_ReactorClass = 10 Auto Const
  Int Property ShipObjective_01 = 11 Auto Const
  Int Property ShipObjective_02 = 12 Auto Const
  Int Property ShipObjective_03 = 13 Auto Const
  Int Property ShipObjective_04 = 14 Auto Const
  Int Property ShipObjective_05 = 15 Auto Const
  Int Property CompleteObjective = 100 Auto Const
EndGroup

Group Salvage
  Form Property SalvageFighter Auto Const Mandatory
  Form Property SalvageExplorer Auto Const Mandatory
  Form Property SalvageHauler Auto Const Mandatory
  Form Property SalvageInterceptor Auto Const Mandatory
  Form Property SalvageLuxury Auto Const Mandatory
EndGroup

Group ShipModuleClass
  Keyword Property ShipModuleClassA Auto Const Mandatory
  Keyword Property ShipModuleClassB Auto Const Mandatory
  Keyword Property ShipModuleClassC Auto Const Mandatory
  Keyword Property ShipModuleClassM Auto Const Mandatory
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

  if(stageId == FailStage)
    StageFailed()
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
  Self.SetObjectiveDisplayedAtTop(0)

  Self.SetObjectiveDisplayed(ShipObjective_ReactorClass, True, False)
  if mission.Objective01 != None
    Self.SetObjectiveDisplayed(ShipObjective_01, True, False)
  endif
  if mission.Objective02 != None
    Self.SetObjectiveDisplayed(ShipObjective_02, True, False)
  endif
  if mission.Objective03 != None
    Self.SetObjectiveDisplayed(ShipObjective_03, True, False)
  endif
  if mission.Objective04 != None
    Self.SetObjectiveDisplayed(ShipObjective_04, True, False)
  endif
  if mission.Objective05 != None
    Self.SetObjectiveDisplayed(ShipObjective_05, True, False)
  endif
EndFunction

Function StageDesign()
  Trace("StageDesign")

  Self.ContractShip = AstroneerParent.AddContractShip(Mission)

  Actor player = Game.GetPlayer()
  Self.RegisterForRemoteEvent(player as ScriptObject, "OnPlayerModifiedShip")

  UpdateObjectiveValues()

  Self.SetObjectiveDisplayed(ShipObjective_ReactorClass, True, False)

  Self.SetObjectiveCompleted(0, True)
EndFunction

Function StageCompleted()
  Trace("StageCompleted")

  Actor player = Game.GetPlayer()
  Self.UnRegisterForRemoteEvent(player as ScriptObject, "OnPlayerModifiedShip")
  Player.AddItem(GetSalvageForm(), GetSalvageRewardAmount(), False)

  ; Block activation for the pilot seat
  (Self.GetAlias(22) as ReferenceAlias).GetReference().BlockActivation(False, False)
  (Self.GetAlias(20) as ReferenceAlias).Clear()
  (Self.GetAlias(21) as LocationAlias).Clear()
  (Self.GetAlias(22) as ReferenceAlias).Clear()
  AstroneerParent.RemoveContractShip(Self.ContractShip, True)
  Self.ContractShip = None
EndFunction

Function StageFailed()
  Trace("StageFailed")

  Actor player = Game.GetPlayer()
  Self.UnRegisterForRemoteEvent(player as ScriptObject, "OnPlayerModifiedShip")
  Self.UnRegisterForRemoteEvent(ContractShip as ObjectReference, "OnUnload")

  (Self.GetAlias(22) as ReferenceAlias).GetReference().BlockActivation(False, False)
  (Self.GetAlias(20) as ReferenceAlias).Clear()
  (Self.GetAlias(21) as LocationAlias).Clear()
  (Self.GetAlias(22) as ReferenceAlias).Clear()
  AstroneerParent.RemoveContractShip(Self.ContractShip, False)
  Self.ContractShip = None
EndFunction

Function StageTurnIn()
EndFunction

Function FillRef(ReferenceAlias akAlias, Message akMessage)
  Trace("FillRef " + akAlias + " " + akMessage)
  akAlias.TryToDelete()

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
    ;DisableShip()
    EnableShip(False)
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

Function EnableShip(Bool withLanding)
  Trace("EnableShip")
  (Self.GetAlias(20) as ReferenceAlias).ForceRefTo(ContractShip)
  (Self.GetAlias(21) as LocationAlias).ClearAndRefillAlias()
  (Self.GetAlias(22) as ReferenceAlias).ClearAndRefillAlias()
  ; Block activation for the pilot seat
  (Self.GetAlias(22) as ReferenceAlias).GetReference().BlockActivation(True, True)
  ; Land the ship in New Atlantis and unlock it
  ContractShip.SetLinkedRef(AstroneerParent.ContractShipLandingMarker, AstroneerParent.PlayerShipQuest.LandingMarkerKeyword, False)
  if(withLanding)
    ContractShip.EnableWithLandingNoWait()
  else
    ContractShip.Enable(False)
  endif
  ContractShip.SetExteriorLoadDoorInaccessible(False)
EndFunction

Function DisableShip()
  if(ContractShip != None)
    ContractShip.Disable(False)
  endif
EndFunction

Bool Function AllShipObjectivesComplete()
  Trace("ShipObjectivesComplete")

  if(!IsObjectiveCompleted(ShipObjective_ReactorClass))
    return False
  endif

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

  if ContractShip.GetReactorClassKeyword() == GetObjectiveReactorClass()
    if !IsObjectiveCompleted(ShipObjective_ReactorClass)
      SetObjectiveCompleted(ShipObjective_ReactorClass, True)
    endif
  else
    if IsObjectiveCompleted(ShipObjective_ReactorClass)
      SetObjectiveCompleted(ShipObjective_ReactorClass, False)
    endif
  endif

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

    Float val = AstroneerParent.GetObjectiveValue(ContractShip, objectiveType)
    value.SetValue(0) ;set to 0 since we are using mod
    Trace("Updating objective " + objectiveType + " to " + val)
    if objectiveType == consts.ObjectiveMass
      ModObjectiveGlobal(val, value, objective, target, False, True, False, True)
    else
      ModObjectiveGlobal(val, value, objective, target, True, True, False, True)
    endif
  endif
EndFunction

Keyword Function GetObjectiveReactorClass()
  Astroneer:Pack consts = (AstroneerParent as ScriptObject) as Astroneer:Pack
  if Mission.Difficulty == consts.DifficultyClassA
    return ShipModuleClassA
  elseif Mission.Difficulty == consts.DifficultyClassB
    return ShipModuleClassB
  elseif Mission.Difficulty == consts.DifficultyClassC
    return ShipModuleClassC
  elseif Mission.Difficulty == consts.DifficultyClassM
    return ShipModuleClassM
  endif
EndFunction

Int Function GetSalvageRewardAmount()
  Astroneer:Pack consts = (AstroneerParent as ScriptObject) as Astroneer:Pack
  if Mission.Difficulty == consts.DifficultyClassA
    return 3
  elseif Mission.Difficulty == consts.DifficultyClassB
    return 5
  elseif Mission.Difficulty == consts.DifficultyClassC
    return 7
  elseif Mission.Difficulty == consts.DifficultyClassM
    return 11
  endif
EndFunction

Form Function GetSalvageForm()
  Astroneer:Pack consts = (AstroneerParent as ScriptObject) as Astroneer:Pack
  if Mission.ShipType == consts.ShipTypeFighter
    return SalvageFighter
  elseif Mission.ShipType == consts.ShipTypeExplorer
    return SalvageExplorer
  elseif Mission.ShipType == consts.ShipTypeHauler
    return SalvageHauler
  elseif Mission.ShipType == consts.ShipTypeInterceptor
    return SalvageInterceptor
  elseif Mission.ShipType == consts.ShipTypeLuxury
    return SalvageLuxury
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
