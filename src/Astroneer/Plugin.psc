ScriptName Astroneer:Plugin Extends ScriptObject

Struct Mission
{ Represents a ship contract mission on the mission board }

  String ID
  { Unique ID of the mission, used for testing and debugging }

  Message NameOverride
  { Name of the mission }

  Message DescriptionOverride
  { Description of the mission }

  Keyword Archetype
  { Archetype of the ship }

  Form ShipTemplate
  { Template of the ship to spawn }

  Keyword Difficulty
  { Difficulty of the mission }

  GlobalVariable MissionReward
  { Reward tier for the mission }

  ; Ship contract Objectives
  Keyword ObjectiveType_01
  Int ObjectectiveTarget_01

  Keyword ObjectiveType_02
  Int ObjectectiveTarget_02

  Keyword ObjectiveType_03
  Int ObjectectiveTarget_03

  Keyword ObjectiveType_04
  Int ObjectectiveTarget_04

  Keyword ObjectiveType_05
  Int ObjectectiveTarget_05
EndStruct

Struct Options
  ; Fill out options here
EndStruct

Astroneer:Plugin:Mission[] Function GetMissions(Astroneer:Plugin:Options options) global
  ; no-op
EndFunction
