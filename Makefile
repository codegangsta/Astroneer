include .env

all: remote_sync remote_compile install reload_scripts debug_init

## Perform an rsync to a running WSL instance on my windows computer
remote_sync::
	rsync -avz --exclude-from '.gitignore' --exclude '.git' --exclude "starfield-modding-misc-extract" --delete -e ssh ./ jeremy@pc-wsl:/mnt/c/Users/jerem/Documents/Code/astroneer

sync_esm::
	rsync -avz -e ssh jeremy@pc-wsl:/mnt/d/SteamLibrary/steamapps/common/Starfield/Data/Astroneer.esm ./records

## Perform compilation on Windows. No WSL here as it's super slow
remote_compile::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\astroneer; ..\Caprica.exe --enable-language-extensions=1 -R --import ..\starfield-src\script\ --output ./out src'

## Installs scripts into starfield folder
install::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\astroneer; cp -r -Force ./out/* "..\..\My Games\Starfield\Data\Scripts\"'

clean::
	ssh jerem@pc 'rm -r C:\Users\jerem\Documents\Code\astroneer\out'

debug_init::
	sfc 'cgf "Astroneer.DebugInit"'

# Reloads scripts in game
reload_scripts::
	sfc 'ReloadScript "Astroneer"'
	sfc 'ReloadScript "Astroneer:ParentQuest"'
	sfc 'ReloadScript "Astroneer:ShipContractMissionScript"'
	sfc 'ReloadScript "Astroneer:ShipContractMissionPack1"'
	sfc 'ReloadScript "Astroneer:Dialogue"'

ready_mission::
	sfc 'cgf "Astroneer.DebugReadyMission"'

accept_mission::
	sfc 'cgf "Astroneer.DebugAcceptMission"'

complete_mission::
	sfc 'cgf "Astroneer.DebugCompleteMission"'

# Tail logs
tail::
	ssh jerem@pc 'Get-Content -Path ".\Documents\My Games\Starfield\Logs\Script\Papyrus.0.log" -Tail 1000 -Wait'

# Start a remote starfield console
console::
	@sfc

load_save::
	# sfc "LoadGame ref_save_1" # cleanish save
	# sfc "LoadGame ref_save_2" # intercom
	# sfc "LoadGame ref_save_3" # space
	sfc "LoadGame ref_save_4" # research

stop_game:
	sfc "QuitGame"

add_starship_design_perk:
	sfc "player.addperk 002c59dc"

## SSH into windows
ssh::
	ssh jerem@pc

vo_script::
	gomplate -f ./docs/vo_script.md.tmpl -d records=./records/records_generated.json -o ./docs/vo_script.md
