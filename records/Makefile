all: records remote_sync

records::
	cue export schema.cue records.cue -f -s -o records_generated.json

remote_sync::
	rsync -avz -e ssh ./records_generated.json "jeremy@pc-wsl:/mnt/c/Users/jerem/Documents/Code/XEdit/Edit\ Scripts/records.json"
	rsync -avz -e ssh ./AstroneerRecords.pas "jeremy@pc-wsl:/mnt/c/Users/jerem/Documents/Code/XEdit/Edit\ Scripts/AstroneerRecords.pas"
