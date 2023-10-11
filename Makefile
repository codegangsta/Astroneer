all: scp compile

scp::
	scp -r Scripts jerem@192.168.50.181:/Users/jerem/Documents/Code/

compile::
	ssh jerem@192.168.50.181 "cd C:\Users\jerem\Documents\Code\Scripts && ..\bin\Caprica.exe --import ..\starfield-src\script ."
