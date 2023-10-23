ScriptName Astroneer:ShipContractFighterMissionScript Extends Astroneer:ShipContractMissionScript

Function SetShipRequirements()
  Trace("SetShipRequirements")
  ; Weapon Power
  if(ShipStatRequirement1 != None)
    Trace("Set ShipRequirement1")
    ShipStatRequirement1.SetValue(100)
    UpdateCurrentInstanceGlobal(ShipStatRequirement1)
  endif
EndFunction

Function SetShipValues()
  Trace("SetShipValues")
  ;Self.ModObjectiveGlobal(100)
EndFunction
