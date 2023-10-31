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

Group Aliases
  ReferenceAlias Property MissionText Auto Const
  ReferenceAlias Property Archetype Auto Const
  ReferenceAlias Property Difficulty Auto Const

  ReferenceAlias Property Objective_01 Auto Const
  ReferenceAlias Property Objective_02 Auto Const
  ReferenceAlias Property Objective_03 Auto Const
  ReferenceAlias Property Objective_04 Auto Const
  ReferenceAlias Property Objective_05 Auto Const
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
  FormList Property MissionTexts Auto Const Mandatory
  Form Property Blank Auto Const Mandatory
EndGroup


Message Property CompleteMessage Auto Const Mandatory
{ Message to display when the player visits the mission board after finishing the ship }

Astroneer:Plugin:Mission Property Mission Auto

;-- Functions ---------------------------------------

Event OnQuestStarted()
  Trace("OnQuestStarted")

  ; Generate a new mission
  Mission = new Astroneer:Plugin:Mission
  Mission.ID = "my_awesome_mission"
  Mission.ObjectiveType_01 = AstroneerParent.ShipContractObjectiveCargo
  Mission.ObjectiveTarget_01 = 100.0

  Actor Player = Game.GetPlayer()

  ; Fill refs
  Message mt = MissionTexts.GetAt(0) as Message
  Player.PlaceAtMe(Blank, 0, True, True, False, None, MissionText, False)
  MissionText.GetRef().SetOverrideName(mt)

  FillObjectiveRef(Objective_01, ObjectiveType_01)
  FillObjectiveRef(Objective_02, ObjectiveType_02)
  FillObjectiveRef(Objective_03, ObjectiveType_03)
  FillObjectiveRef(Objective_04, ObjectiveType_04)
  FillObjectiveRef(Objective_05, ObjectiveType_05)

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

Function FillObjectiveRef(ReferenceAlias objectiveAlias, Keyword objectiveType)
  Actor Player = Game.GetPlayer()

  if objectiveType != None
    Form objectiveForm = ObjectiveTypes.GetAt(0) ;FIXME: Search by keyword here
    Player.PlaceAtMe(objectiveForm, 0, True, True, False, None, objectiveAlias, False)
  endif
EndFunction

Function StageAccepted()
  Trace("StageAccepted")

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

  if AllShipObjectivesComplete()
    SetObjectiveDisplayedAtTop(CompleteObjective)
  endif
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
