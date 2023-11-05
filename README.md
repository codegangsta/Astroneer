# Astroneer - Starship Manufacturing Tycoon

Astroneer is an ambitious new mode for Starfield that allows you to become a world-renown ship designer. It updates Starfield with all new mechanics, narrative elements, and emergent gameplay.

## Features

### Become a Freelance Ship Designer

Astroneer adds a new type of mission to the mission boards: **Ship Contracts**. Ship contracts are radiant quests that require you to modify a ship to meet certain thematic requirements. Finishing a ship contract rewards you with credits, XP, and more!

### Meet Aria Collins and Atlas Astronautics

All ship contracts are managed by **Atlas Astronautics**, a small-time ship manufacturer and refitter. As Astroneer continues to develop, you'll witness Atlas go from underdog to top of the foodchain in ship manufacturing.

Aria Collins is a brand new, fully voiced NPC that will be your point person for all ship contracts. Continue playing Astroneer to discover more about Aria and her motivations.

### See your creations in the wild

When you complete a ship contract, you'll have a chance to see your marvelous creation in space, at a vendor, or maybe even planetside. Buy it, steal it, or blow it up - You are, in fact, it's designer.

### ...and much more to come

Astroneer is an ambitious mod with many cool updates planned. See our [Roadmap](#Roadmap) for future updates.

## Installation

You will need {TODO: Plugins.txt enabler} in order to use Astroneer.

### Step 1:

Download the latest version of Astroneer, and extract the zip file into your Starfield data director {TODO: Add directory here}.

### Step 2:

Add `Astroneer.esm` to your Plugins.txt

## Gameplay Systems

Astroneer introduces a variety of new systems, most having to do with ship design system and its modularity.

### Ship Contracts

Ship Contracts can be obtained at the Mission Board, one at a time. A ship contract contains the following information:

{TODO: Image Here}

- Mission Title and Text
- Ship Type
- 1-5 Objectives
- Reward

### Ship Types

Ship types help Astroneer organize ships thematically, and give the ship contract mechanic a bit of flair to guide the player in a build.

The following ship types are currently supported:

- **Explorer**: Designed for exploring the outer reaches of space. Typically focused on endurance and balance.
- **Fighter**: Designed for firepower and nimbleness. Typically focused on weapons, shields and mass.
- **Hauler**: Designed for hauling large amounts of cargo. Typically focused on cargo, fuel and engines.
- **Luxury**: Designed for opulence and wealthy buyers. Typically focused on amenities, crew slots, habs and protection.
- **Interceptor**: Designed for speed. Typically focused on top speed, manueverability and balance.

### Objective Types

Each ship contract includes 1-5 objectives for the mission. Each objective represents a requirement for the ship build.

The following objective types are currently supported:

- **Cargo**: Cargo capacity
- **CrewSlots**: # of crew slots
- **Engine Power**: Max power for engines
- **Fuel**: Max fuel
- **Grav Jump Range**: Max grav jump range
- **Habs**: # of habs
- **Hull**: Hull health
- **Mass**: Total ship mass
- **Reactor Power**: Reactor power capacity
- **Shielded Cargo**: Shielded cargo capacity
- **Shield Health**: Shield health
- **Shield Power**: Shield max power
- **Top Speed**: Top ship speed
- **Total Weapon Power**: Combined total weapon power
- **Weapon Power Ballistic**: Max ballistic weapon power
- **Weapon Power Continuous Beam**: Max continuous beam weapon power
- **Weapon Power EM**: Max EM weapon power
- **Weapon Power Energy**: Max energy weapon power
- **Weapon Power Missile**: Max missile weapon power
- **Weapon Power Particle**: Max particle weapon power
- **Weapon Power Plasma**: Max plasma weapon power
- **Windows**: Number of windows

If you feel like there is a ship attribute you'd like to see as part of a contract, feel free to reach out and we will see if it can be implemented.

### Mission Packs

Astroneer was designed to be modular, making it easy to add and update missions as part of the core mod or as an addon mod. Whether you are mod author who wants to add support for your ship mod to Astroneer, or you just want to put together some cool new ship contract missions, Astroneer has been designed with that in mind.

**Mission Packs** provide an API for creating and loading new ship contracts into the game, it requires only papyrus scripting and is very easy to implement. Here is an example of how one might implement a mission pack:

```
ScriptName MyAwesomeMissionPack

Astroneer:Pack:Mission[] Function Missions(Astroneer:Pack p) global

  Astroneer:Pack:Mission[] missions = new Astroneer:Pack:Mission[0]

  ;= Fighter 01 =================================================
  Astroneer:Pack:Mission m1 = new Astroneer:Pack:Mission
  m1.ID = "MP01_Fighter01"
  m1.Title = p.MissionTitleFighter01
  m1.Text = p.MissionTextFighter01
  m1.ShipTemplate = p.ShipTemplateFighter
  m1.ShipType = p.ShipTypeFighter
  m1.Difficulty = p.DifficultyTier1
  m1.RewardCredits = 100000
  m1.RewardXP = 250
  m1.Objective01 = p.ObjectiveMass
  m1.ObjectiveTarget01 = 2000
  m1.Objective02 = p.ObjectiveShieldHealth
  m1.ObjectiveTarget02 = 500
  m1.Objective03 = p.ObjectiveWeaponPowerEnergy
  m1.ObjectiveTarget03 = 6
  m1.Objective04 = p.ObjectiveWeaponPowerMissile
  m1.ObjectiveTarget04 = 6
  m1.Objective05 = p.ObjectiveWeaponPowerBallistic
  m1.ObjectiveTarget05 = 6
  missions.Add(m1)

  return missions

EndFunction
```

#### Building your own mission pack

TODO: Add a tutorial for adding your own mission pack

## Roadmap

### Chapter 1: Freelancer

### Chapter 2: Titans of Industry

### Chapter 3: Red Ocean

## FAQ

### Is Astroneer safe to install?

## Credits

@codegangsta - Game design, scripting, narrative
Elisabeth Saenz - VO (Aria), narrative
