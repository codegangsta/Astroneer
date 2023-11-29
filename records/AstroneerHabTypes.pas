{
    Converts the JSON based dialogue definition to records for Astroneer
    ---------------------------------------
    Hotkey: Shift+Ctrl+H
}
unit AstroneerHabTypes;

function Initialize: Integer;
begin
end;

function Process(e: IInterface): Integer;
begin
	AddMessage(EditorID(e) + ' ' + IntToHex(FormID(e), 8));
end;

end.
