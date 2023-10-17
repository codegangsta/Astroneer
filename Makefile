include .env

all: remote_sync remote_compile install

## Perform an rsync to a running WSL instance on my windows computer
remote_sync::
	rsync -avz --exclude-from '.gitignore' --exclude '.git' --delete -e ssh ./ jeremy@pc-wsl:/mnt/c/Users/jerem/Documents/Code/astroneer

## Perform compilation on Windows. No WSL here as it's super slow
remote_compile::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\astroneer; ..\Caprica.exe --import ..\starfield-src\script\ --output ./out src'


## Installs scripts into starfield folder
install::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\astroneer; cp -r ./out/* "..\..\My Games\Starfield\Data\Scripts\"'

clean::
	ssh jerem@pc 'rm -r C:\Users\jerem\Documents\Code\astroneer\out'

# Tail logs
tail::
	ssh jerem@pc 'Get-Content -Path ".\Documents\My Games\Starfield\Logs\Script\Papyrus.0.log" -Tail 10 -Wait'

## SSH into windows
ssh::
	ssh jerem@pc
