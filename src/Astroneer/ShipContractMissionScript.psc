ScriptName Astroneer:ShipContractMissionScript Extends missionquestscript

;-- Variables ---------------------------------------

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

;Group Aliases
  ;ReferenceAlias Property MissionText Auto Const Mandatory
  ;ReferenceAlias Property Difficulty Auto Const Mandatory

  ;ReferenceAlias Property Objective_01 Auto Const Mandatory
  ;ReferenceAlias Property Objective_02 Auto Const Mandatory
  ;ReferenceAlias Property Objective_03 Auto Const Mandatory
  ;ReferenceAlias Property Objective_04 Auto Const Mandatory
  ;ReferenceAlias Property Objective_05 Auto Const Mandatory
;EndGroup

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

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")
  Self.Mission = AstroneerParent.GetRandomMission()

  UpdateObjectiveTargets()
  Parent.OnQuestStarted()
EndEvent

Event OnStageSet(Int stageId, Int itemId)
  if(stageId == ReadyStage)
    FillRef(Self.GetAlias(9) as ReferenceAlias, Mission.Text)
    FillRef(Self.GetAlias(10) as ReferenceAlias, Mission.Title)
    FillRef(Self.GetAlias(11) as ReferenceAlias, Mission.Difficulty)
    FillRef(Self.GetAlias(12) as ReferenceAlias, Mission.Objective01)
    FillRef(Self.GetAlias(13) as ReferenceAlias, Mission.Objective02)
    FillRef(Self.GetAlias(14) as ReferenceAlias, Mission.Objective03)
    FillRef(Self.GetAlias(15) as ReferenceAlias, Mission.Objective04)
    FillRef(Self.GetAlias(16) as ReferenceAlias, Mission.Objective05)

    UpdateObjectiveTargets()
    return
  endif

  if(stageId == AcceptStage)
    StageAccepted()
    return
  endif

  if(stageId == CompleteStage)
    StageCompleted()
    return
  endif
EndEvent

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

Function StageAccepted()
  Trace("StageAccepted")

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

  ; FIXME: these should come from a property
  Form shipForm = Game.GetForm(0x0003e13e)
  Message shipName = Game.GetForm(0x003fe6d8) as Message

  Trace("Spawning ship " + shipForm)
  Self.ContractShip = AstroneerParent.AddContractShip(shipForm, shipName)

  Actor PlayerREF = Game.GetPlayer() ; #DEBUG_LINE_NO:74
  Self.RegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")
  Self.RegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")

  UpdateObjectiveValues()

  ; FIXME: This should use a message
  Debug.Notification("Ship XXX added to hangar")
EndFunction

Function StageCompleted()
  Trace("StageCompleted")

  Actor PlayerREF = Game.GetPlayer()
  Self.UnRegisterForRemoteEvent(PlayerREF as ScriptObject, "OnPlayerModifiedShip")
  Self.UnRegisterForMenuOpenCloseEvent("SpaceshipEditorMenu")

  AstroneerParent.PlayerShipQuest.RemovePlayerShip(Self.ContractShip)
  AstroneerParent.ShipCollection.Add(Self.ContractShip)
  Self.ContractShip = None

  Self.MissionComplete()
EndFunction

Event Actor.OnPlayerModifiedShip(Actor akActor, spaceshipreference akShip)
  Trace("OnPlayerModifiedShip")
  if(akShip == Self.ContractShip)
    UpdateObjectiveValues()
  endif
EndEvent

Event OnMenuOpenCloseEvent(String menuName, bool opening)
  Trace("OnMenuOpenCloseEvent")
  if(menuName == "SpaceshipEditorMenu" && !opening)


    if AllShipObjectivesComplete()
      Int turnIn = CompleteMessage.Show(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
      if(turnIn == 0)
        StageCompleted()
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
  UpdateObjectiveValue(ObjectiveValue_01, Mission.Objective01, ShipObjective_01, Mission.ObjectiveTarget01)
  UpdateObjectiveValue(ObjectiveValue_02, Mission.Objective02, ShipObjective_02, Mission.ObjectiveTarget02)
  UpdateObjectiveValue(ObjectiveValue_03, Mission.Objective03, ShipObjective_03, Mission.ObjectiveTarget03)
  UpdateObjectiveValue(ObjectiveValue_04, Mission.Objective04, ShipObjective_04, Mission.ObjectiveTarget04)
  UpdateObjectiveValue(ObjectiveValue_05, Mission.Objective05, ShipObjective_05, Mission.ObjectiveTarget05)

  if AllShipObjectivesComplete()
    SetObjectiveDisplayedAtTop(CompleteObjective)
  endif
EndFunction

Function UpdateObjectiveValue(GlobalVariable value, Form objectiveType, Int objective, Float target)
  Trace("UpdateObjectiveValue " + objectiveType + " - " + value)
  if(objectiveType != None)
    value.SetValue(0) ;set to 0 since we are using mod
    Float val = AstroneerParent.GetObjectiveValue(ContractShip, objectiveType)
    Trace("Updating objective " + objectiveType + " to " + val)
    ModObjectiveGlobal(val, value, objective, target, True, True, True, True)
  endif
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
