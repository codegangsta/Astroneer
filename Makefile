include .env

all: remote_sync remote_compile

remote_sync::
	rsync -avz --exclude-from '.gitignore' --exclude '.git' --delete -e ssh ./ jeremy@pc-wsl:/mnt/c/Users/jerem/Documents/Code/astroneer

remote_compile::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\astroneer; ..\Caprica.exe --import ..\starfield-src\script\ --output .\out src'

ssh::
	s..sh jeremy@pc-wsl -t 'cd astroneer && bash -l'FF
