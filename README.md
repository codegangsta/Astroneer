### Astroneer: Become a Starship Designer

**Live your dream as a starship designer!**

Welcome to **Astroneer**, a mod for Starfield that puts you in the shoes of a freelance ship designer. With this mod, you're not just exploring the galaxy – you're shaping it, one ship at a time.

**Features:**

- **Ship Contracts Galore**: Dive into a variety of contracts from the mission board, each tailored to a specific type of vessel - Explorers, Fighters, Haulers, Luxury ships, and Interceptors. Whether it's maximizing firepower for a Fighter or ensuring the opulence of a Luxury cruiser, each contract comes with its unique challenges and requirements.

- **Meet Aria Collins**: Your guide and collaborator in the shipbuilding world. Aria, from Atlas Astronautics, is a witty, hands-on ship designer who will work with you on every project. She's more at home with a wrench in hand than behind a desk – a true gearhead who brings personality and expertise to your journey.

- **Progression System**: Your work pays off! Completing contracts earns you XP, Credits, and Salvage resources. Use salvage to complete over 25 new research projects for global upgrades, new ship parts, or discounts through Aria.

- **Space Encounters**: Ever wondered what happens to your ships after they leave the dock? In Astroneer, you'll encounter your creations out in the vastness of space. Hail them, steal them, or engage in a little space piracy – the choice is yours!

**Ready to take the helm of your shipbuilding career?** Download Astroneer now and start forging the future of space travel in Starfield!

## Installation
This mod requires Plugins.txt Enabler which also requires SFSE or ASIL (GamePass) because it was made in xEdit and is packaged as .ESM﻿ plugin file.

Please read detailed instructions provided by SFSE and Plugins.txt Enabler if you have not used any ESM mods yet! Open their respective pages and the instructions are all there!

After you have requirements taken care of, please add the following lines to your Plugins.txt file, complete text file should look like this:
﻿# This file is used by Starfield to keep track of your downloaded content.
*Astroneer.esm

Save the file and start the game using sfse_loader.exe. (Or for GamePass follow instructions provided by Plugins.txt Enabler)

Note that this mod should work just fine with GamePass version as well, please just make sure to follow Plugin.txt Enabler instructions specific for the GamePass modding and ASIL. I only have Steam version so can't provide any support unless you get the Plugins.exe Enabler and ASI Loader to work on your installation, as I have no experience with GamePass version.


## Common issues

This mod is still in its infancy, and naturally there will be some bugs or conflicts with other mods that may crop up, here are some common issues and some ways to fix them:

### Reactor Class Requirement not working properly
If the reactor class is not being calculated properly, it is likely due to another mod that modifies the reactors in a certain way. Astroneer uses a Native Papyrus function to get the reactor class keyword, and if it doesn't return the proper keyword it is likey due to a mod changing it.

To fix this issue, and still keep using all your mods, you can disable the reactor class requirement via the console command:

```
cgf "Astroneer.DisableReactorClass"
```

To enable it again, you can simply call:

```
cgf "Astroneer.DisableReactorClass"
```

### Aria not spawned/spawning in my ship.
Aria should always be in New Atlantis, but if for some reason she isn't, you can try and force reset here location with the following command:

```
cgf "Astroneer.DebugResetAria"
```

### Hab Calculations not working properly
Any mods that add new habs or completely replace existing habs may cause problems with detecting the type of hab that it is. To fix this, there must be a patch for your mod and Astroneer. Feel free to give a detailed report of the mods in use and I can investigate the feasibility of adding a patch.


## Credits

- @codegangsta - Game design, scripting, narrative crafting
- Elisabeth Saenz - Voice of Aria, narrative contributor
