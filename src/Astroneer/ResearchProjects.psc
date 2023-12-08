ScriptName Astroneer:ResearchProjects extends Quest

Group ResearchProjects
  researchproject Property StarshipResearchCargo1 Auto Const Mandatory
  researchproject Property StarshipResearchCargo2 Auto Const Mandatory
  researchproject Property StarshipResearchCargo3 Auto Const Mandatory
  researchproject Property StarshipResearchCargo4 Auto Const Mandatory

  researchproject Property StarshipResearchGrav1 Auto Const Mandatory
  researchproject Property StarshipResearchGrav2 Auto Const Mandatory
  researchproject Property StarshipResearchGrav3 Auto Const Mandatory
  researchproject Property StarshipResearchGrav4 Auto Const Mandatory

  researchproject Property StarshipResearchRepair1 Auto Const Mandatory
  researchproject Property StarshipResearchRepair2 Auto Const Mandatory
  researchproject Property StarshipResearchRepair3 Auto Const Mandatory
  researchproject Property StarshipResearchRepair4 Auto Const Mandatory

  researchproject Property StarshipResearchThrusters1 Auto Const Mandatory
  researchproject Property StarshipResearchThrusters2 Auto Const Mandatory
  researchproject Property StarshipResearchThrusters3 Auto Const Mandatory
  researchproject Property StarshipResearchThrusters4 Auto Const Mandatory

  researchproject Property StarshipResearchWeapons1 Auto Const Mandatory
  researchproject Property StarshipResearchWeapons2 Auto Const Mandatory
  researchproject Property StarshipResearchWeapons3 Auto Const Mandatory
  researchproject Property StarshipResearchWeapons4 Auto Const Mandatory

  researchproject Property SupplyChainResearchDeimos Auto Const Mandatory
  researchproject Property SupplyChainResearchHopeTech Auto Const Mandatory
  researchproject Property SupplyChainResearchNova Auto Const Mandatory
  researchproject Property SupplyChainResearchStroud Auto Const Mandatory
  researchproject Property SupplyChainResearchTaiyo Auto Const Mandatory
  researchproject Property SupplyChainResearchTrident Auto Const Mandatory
EndGroup

Group Perks
  Perk Property ResearchCargoBuff Auto Const Mandatory
  Perk Property ResearchGravBuff Auto Const Mandatory
  Perk Property ResearchRepairBuff Auto Const Mandatory
  Perk Property ResearchThrustersBuff Auto Const Mandatory
  Perk Property ResearchWeaponsBuff Auto Const Mandatory
EndGroup

Group ShipPartsLists
  FormList Property ShipPartsDeimos Auto Const Mandatory
  FormList Property ShipPartsHopeTech Auto Const Mandatory
  FormList Property ShipPartsNova Auto Const Mandatory
  FormList Property ShipPartsStroud Auto Const Mandatory
  FormList Property ShipPartsTaiyo Auto Const Mandatory
  FormList Property ShipPartsTrident Auto Const Mandatory
EndGroup

Event OnQuestInit()
  Trace("OnQuestInit")
  RegisterEvents()
EndEvent

Function RegisterEvents()
  Trace("RegisterEvents")
  Self.UnRegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerCompleteResearch")
  Self.RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerCompleteResearch")
EndFunction

Event Actor.OnPlayerCompleteResearch(Actor akActor, ObjectReference akBench, Location akLocation, researchproject akProject)
  Trace("OnPlayerCompleteResearch: " + akProject)
  if akProject == StarshipResearchCargo1 || akProject == StarshipResearchCargo2 || akProject == StarshipResearchCargo3 || akProject == StarshipResearchCargo4
    Game.GetPlayer().AddPerk(ResearchCargoBuff, True)
  elseif akProject == StarshipResearchGrav1 || akProject == StarshipResearchGrav2 || akProject == StarshipResearchGrav3 || akProject == StarshipResearchGrav4
    Game.GetPlayer().AddPerk(ResearchGravBuff, True)
  elseif akProject == StarshipResearchRepair1 || akProject == StarshipResearchRepair2 || akProject == StarshipResearchRepair3 || akProject == StarshipResearchRepair4
    Game.GetPlayer().AddPerk(ResearchRepairBuff, True)
  elseif akProject == StarshipResearchThrusters1 || akProject == StarshipResearchThrusters2 || akProject == StarshipResearchThrusters3 || akProject == StarshipResearchThrusters4
    Game.GetPlayer().AddPerk(ResearchThrustersBuff, True)
  elseif akProject == StarshipResearchWeapons1 || akProject == StarshipResearchWeapons2 || akProject == StarshipResearchWeapons3 || akProject == StarshipResearchWeapons4
    Game.GetPlayer().AddPerk(ResearchWeaponsBuff, True)
  elseif akProject == SupplyChainResearchDeimos
    AddShipParts(ShipPartsDeimos)
  elseif akProject == SupplyChainResearchHopeTech
    AddShipParts(ShipPartsHopeTech)
  elseif akProject == SupplyChainResearchNova
    AddShipParts(ShipPartsNova)
  elseif akProject == SupplyChainResearchStroud
    AddShipParts(ShipPartsStroud)
  elseif akProject == SupplyChainResearchTaiyo
    AddShipParts(ShipPartsTaiyo)
  elseif akProject == SupplyChainResearchTrident
    AddShipParts(ShipPartsTrident)
  endif

EndEvent

Function AddShipParts(FormList shipParts)
  Actor Aria = GetAria()
  ForEach form part in shipParts
    Aria.AddKeyword(part as Keyword)
  EndForEach
EndFunction

Actor Function GetAria()
  return (Self.GetAlias(0) as ReferenceAlias).GetActorReference()
EndFunction

Function Trace(string message)
  Debug.Trace((Self as String) + " " + message, 0)
EndFunction
