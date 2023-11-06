# Astroneer - Starship Manufacturing Tycoon

Embark on a journey of innovation and prestige in Starfield with Astroneer, the groundbreaking new mod that transforms you into a galaxy-renowned starship architect. This mod revolutionizes the game with fresh mechanics, captivating story developments, and dynamic gameplay experiences.

## Features

### Forge Your Path as a Starship Artisan

Astroneer introduces a new mission category to the mission boards: Ship Contracts. These radiant quests challenge you to customize starships to meet specific thematic criteria. Successful completion of a ship contract garners you credits, experience points, and more, fueling your rise to interstellar fame.

### Collaborate with Aria Collins and Atlas Astronautics

At the heart of these ship contracts is Atlas Astronautics, an emerging name in starship manufacturing and retrofitting. Journey through the Astroneer narrative and watch Atlas ascend from a fledgling company to a behemoth in the cosmos of ship production.

Meet Aria Collins, a new, fully voiced NPC who will guide you through your ship contract endeavors. Engage with the unfolding story to uncover Aria's past and her driving forces.

### Witness Your Masterpieces in Action

Upon fulfilling a ship contract, your stellar designs will appear across the universe—be it in the void of space, docked at a trading post, or landed on a foreign planet. Whether you choose to purchase your creation, commandeer it, or engage in a bit of space piracy, remember that it was brought to life by your hands.

### ...and the Voyage Continues

Astroneer is not just a mod; it's a commitment to continuous expansion and enrichment. Peek at our Roadmap for a glimpse into the future enhancements we have in store.

## Installation

You will need {TODO: Plugins.txt enabler} in order to use Astroneer.

### Step 1:

Download the latest version of Astroneer, and extract the zip file into your Starfield data director {TODO: Add directory here}.

### Step 2:

Add `Astroneer.esm` to your Plugins.txt

## Gameplay Enhancements

Astroneer introduces a variety of new systems, most having to do with ship design system and its modularity.

### Ship Contracts

Ship Contracts can be obtained at the Mission Board, one at a time. A ship contract contains the following information:

{TODO: Image Here}

- Mission Title and Text
- Ship Type
- 1-5 Objectives
- Reward

### Ship Types

Ship types categorize vessels within thematic lines, adding a layer of depth and direction to the ship contract mechanic:

The following ship types are currently supported:

- **Explorer**: Designed for exploring the outer reaches of space. Typically focused on endurance and balance.
- **Fighter**: Designed for firepower and nimbleness. Typically focused on weapons, shields and mass.
- **Hauler**: Designed for hauling large amounts of cargo. Typically focused on cargo, fuel and engines.
- **Luxury**: Designed for opulence and wealthy buyers. Typically focused on amenities, crew slots, habs and protection.
- **Interceptor**: Designed for speed. Typically focused on top speed, manueverability and balance.

### Design Objectives

Each contract comes with objectives that dictate the requirements for the ship's design, ranging from cargo space to weapon power.

We're open to community suggestions for additional ship attributes to be included in future contracts.

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

### Mission Packs

Astroneer was designed to be modular, making it easy to add and update missions as part of the core mod or as an addon mod. Whether you are mod author who wants to add support for your ship mod to Astroneer, or you just want to put together some cool new ship contract missions, Astroneer has been designed with that in mind.

**Mission Packs** offer an API for crafting and integrating new ship contracts, requiring minimal papyrus scripting to implement. Below is a sample framework for a mission pack:

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

Astroneer is set to evolve with a series of updates that will enrich the gameplay, narrative, and systems over time. As the mod matures, you'll have the opportunity to advance your reputation as a master starship designer and observe the growth of Atlas Astronautics and its key players.

### Chapter 1: Freelancer

The current release of Astroneer, "Freelancer" contains the following features

- Ship Contract System
- Mission Packs
- Space encounters for ship designs

### Chapter 2: Titans of Industry

The forthcoming expansion, "Titans of Industry," charts the ascent of Atlas Astronautics:

- Embark on a journey with Atlas, starting as an up-and-coming designer and soaring to industry prominence.
- Unlock new research projects as you turn in ship designs.
- Delve deeper into Aria's personal and professional narrative.
- Engage with your creations in new planetside encounters.

### Chapter 3: Red Ocean

The third phase, "Red Ocean," transforms the ship-building sector into an intricate market simulation:

- Rise through the ranks to become an executive at Atlas Astronautics.
- Engage in corporate warfare against rival manufacturers, making key decisions in Marketing, R&D, and supply chain management.
- Strategize to outmaneuver the competition in a cutthroat industry.
- Shape your legacy as a benevolent innovator or a ruthless industrial magnate.

## FAQ

### Is Astroneer safe to install?

In short, yes. Astroneer has been meticulously crafted with a strong emphasis on safety and compatibility.

The mod does not modify or overwrite any existing scripts, records, or assets from the original Starfield game. Instead, Astroneer introduces entirely new code and records, significantly minimizing the risk of conflicts. This also means that Astroneer is relatively safe to uninstall mid-game, though it's still recommended to keep it installed for the duration of your playthrough.

The development of Astroneer utilized the most recent versions of SF1Edit and the Caprica script compiler for optimal stability.

However, it's important to note that modding for Starfield is still emerging, and this mod is part of that pioneering wave. While every precaution has been taken to ensure safety, as with any mod, there's always a small chance of unexpected issues arising.

### Upset that this wasn't in Starfield's vanilla experience?

It's understandable to feel passionate about the content of the games you love. If you find yourself frustrated, consider stepping away for a moment. A breath of fresh air and a change of scenery can do wonders.

Remember, expressing dissatisfaction won't change the game. Instead, why not use that passion constructively? Your energy could greatly contribute to enhancing this mod and the community's experience!

### How can I contribute to Astroneer?

Your involvement is what shapes the future of Astroneer. We're on the lookout for players who can test and offer insights on mission balance and overall gameplay.

Feedback is welcome through GitHub Issues, GitHub Discussions, or on Nexus Mods.

For those interested in a more hands-on role, such as mod authors looking to contribute directly to Astroneer's development, please initiate a conversation via GitHub Discussions. Let's collaborate to make something incredible!

## Credits

@codegangsta - Game design, scripting, narrative crafting
Elisabeth Saenz - Voice of Aria, narrative contributor
