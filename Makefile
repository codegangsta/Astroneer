include .env

all: scp compile

scp::
	scp -r src jerem@pc:/Users/jerem/Documents/Code/

compile::
	ssh jerem@pc 'cd C:\Users\jerem\Documents\Code\Scripts && ..\bin\Caprica.exe --import ..\starfield-src\script --output "..\..\My Games\Starfield\Data\Scripts" .'
