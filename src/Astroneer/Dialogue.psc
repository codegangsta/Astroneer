ScriptName Astroneer:Dialogue extends TopicInfo

Function CompleteContract(ObjectReference speaker)
  Astroneer:ShipContractMissionScript mission = GetMission()
  mission.MissionComplete()
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.ResetMissionBoard()
EndFunction

Function ModifyContractShip(ObjectReference speaker)
  Trace("ModifyContractShip")
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  Astroneer:ShipContractMissionScript mission = GetMission()

  RefCollectionAlias ships = pq.PlayerShipQuest.PlayerShips
  pq.AtlasWorkshopMode = True

  if pq.BuilderDisabledShips == None
    pq.BuilderDisabledShips = new spaceshipreference[0]
  endif

  Int i = 0
  While i < ships.GetCount()
    spaceshipreference ship = ships.GetAt(i) as spaceshipreference
    if ship != mission.ContractShip && ship.HasKeyword(pq.CannotBeModifiedShipKeyword) == False
      ship.AddKeyword(pq.CannotBeModifiedShipKeyword)
      pq.BuilderDisabledShips.Add(ship)
    endif
    i += 1
  EndWhile

  mission.ContractShip.Disable(False)
  Game.GetPlayer().ShowHangarMenu(0, GetAria(), mission.ContractShip, False)
EndFunction

Function ModifyShips(ObjectReference speaker)
  Trace("ModifyShips")
  Game.GetPlayer().ShowHangarMenu(0, GetAria(), None, False)
EndFunction

Function CompleteIntro(ObjectReference speaker)
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.DialogueIntroComplete = 1
EndFunction

Function CompleteDialogueReflect(ObjectReference speaker)
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.DialogueReflectComplete = 1
EndFunction

Function CompleteDialogueBackground(ObjectReference speaker)
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.DialogueBackgroundComplete = 1
EndFunction

Function CompleteDialogueBadNews(ObjectReference speaker)
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.DialogueBadNewsComplete = 1
EndFunction

Function SetDesignStage(ObjectReference speaker)
  Astroneer:ShipContractMissionScript mission = GetMission()
  mission.SetStage(mission.DesignStage)
EndFunction

Function AbandonContract(ObjectReference speaker)
  GetMission().MissionFailed()
  GetMission().Stop()
  GetMission().Reset()
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.ResetMissionBoard()
EndFunction

Function ResetMissions(ObjectReference speaker)
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  pq.ResetMissionBoard()
EndFunction

Actor Function GetAria()
  return (GetOwningQuest().GetAlias(0) as ReferenceAlias).GetActorReference()
EndFunction

Astroneer:ShipContractMissionScript Function GetMission()
  Astroneer:ParentQuest pq = GetOwningQuest() as Astroneer:ParentQuest
  return pq.AstroneerMBQuests.GetAt(0) as Astroneer:ShipContractMissionScript
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
