{
    Converts the JSON based dialogue definition to records for Astroneer
    ---------------------------------------
    Hotkey: Shift+Ctrl+D
}
unit AstroneerRecords;

var RecordsFile: TJsonObject;

procedure LoadJSON;
begin
    SetJDOLineBreak(#13#10);  // default #10
    RecordsFile := TJsonObject.Create;
    RecordsFile.LoadFromFile(ScriptsPath + 'records.json');
end;

function FindChildRecord(parent: IInterface; signature: string; editorID: string): IInterface;
var
    i: Integer;
    group, rec: IInterface;
begin

  group := ChildGroup(parent);
  for i := 0 to Pred(ElementCount(group)) do begin
    rec := ElementByIndex(group, i);
    if GetElementEditValues(rec, 'EDID') = editorID then begin
      Result := rec;
      Exit;
    end;
  end;
end;

function FindOrCreateChildRecord(parent: IInterface; signature: string; editorID: string): IInterface;
var
    i: Integer;
    group, rec: IInterface;
begin

  group := ChildGroup(parent);
  for i := 0 to Pred(ElementCount(group)) do begin
    rec := ElementByIndex(group, i);
    if GetElementEditValues(rec, 'EDID') = editorID then begin
      AddMessage('Found existing record: ' + editorID);
      Result := rec;
      Exit;
    end;
  end;

    AddMessage('Creating new record: ' + editorID);
    rec := Add(parent, signature, true);
    SetEditorID(rec, editorID);

    Result := rec;
end;

function FindRecordByEditorID(const editorID, recordSignature: String): IInterface;
var
  i: Integer;
  fileI: IInterface;
begin
  Result := nil;
  for i := 0 to Pred(FileCount) do // Iterate through all files
  begin
    fileI := FileByIndex(i);
    Result := MainRecordByEditorID(GroupBySignature(fileI, recordSignature), editorID);
    if Assigned(Result) then
      Break; // Record found
  end;
end;

function AddInfoScript(infoRecord: IInterface; scriptName: string; onBegin: string; onEnd: string): IInterface;
var
  vmadSubrecord, scripts, script, properties, fragment, fragments: IInterface;
  i Integer;
begin
  // Add or get VMAD subrecord
  vmadSubrecord := ElementByPath(infoRecord, 'VMAD');
  if not Assigned(vmadSubrecord) then
    vmadSubrecord := Add(infoRecord, 'VMAD', True);

  // Set VMAD properties
  SetElementEditValues(vmadSubrecord, 'Version', '6');
  SetElementEditValues(vmadSubrecord, 'Object Format', '2');
  // INFO \ VMAD - Virtual Machine Adapter \ Script Fragments \ Script \ ScriptName

  // Add script
  scripts := ElementByPath(vmadSubrecord, 'Script Fragments\Script');
  SetElementEditValues(script, 'ScriptName', scriptName);

  fragments := ElementByPath(vmadSubrecord, 'Script Fragments\Fragments');
  // loop over fragments and remove them
  for i := 0 to Pred(ElementCount(fragments)) do begin
    RemoveByIndex(fragment, i);
  end;

  // Add fragments
  if onBegin <> '' then
  begin
    AddMessage('Adding onBegin: ' + onBegin);
    fragment := Add(fragments, 'Fragment', True);
    SetElementEditValues(fragment, 'Unknown', '0');
    SetElementEditValues(fragment, 'ScriptName', scriptName);
    SetElementEditValues(fragment, 'FragmentName', onBegin);
  end;

  if onEnd <> '' then
  begin
    AddMessage('Adding onEnd: ' + onEnd);
    fragment := Add(fragments, 'Fragment', True);
    SetElementEditValues(fragment, 'Unknown', '1');
    SetElementEditValues(fragment, 'ScriptName', scriptName);
    SetElementEditValues(fragment, 'FragmentName', onEnd);
  end;

  Result := vmadSubrecord;
end;

function Initialize: Integer;
begin
    AddMessage('Loading json...');
    LoadJSON;
end;

function Process(e: IInterface): Integer;
var
    scenes: TJsonArray;
    scene: TJsonObject;
    topics: TJsonArray;
    topic: TJsonObject;
    topicRecord: IInterface;
    topicDataRecord: IInterface;
    infos: TJsonArray;
    info: TJsonObject;
    infoRecord: IInterface;
    responses: TJsonArray;
    response: TJsonObject;
    responsesRecord: IInterface;
    responseRecord: IInterface;
    speakerRecord: IInterface;
    sceneRecord: IInterface;
    file: IInterface;
    si: Integer;
    i: Integer;
    j: Integer;
    k: Integer;
begin
    if Signature(e) <> 'QUST' then
        Exit;

    file := GetFile(e);

    scenes := RecordsFile.A['scenes'];
    // loop over scenes
    for si := 0 to scenes.Count -1 do begin
      scene := scenes.O[si];
      topics := scene.A['topics'];

      for i := 0 to topics.Count - 1 do begin
          topic := topics.O[i];
          topicRecord := FindOrCreateChildRecord(e, 'DIAL', topic.S['id']);
          SetElementEditValues(topicRecord, 'QNAM', GetEditValue(e));
          topicDataRecord := ElementBySignature(topicRecord, 'DATA');

          if not Assigned(topicDataRecord) then
              topicDataRecord := Add(topicRecord, 'DATA', True);

          SetElementEditValues(topicDataRecord, 'Category', 'Scene');
          SetElementEditValues(topicDataRecord, 'Subtype', 'Custom Scene');

          infos := topic.A['infos'];
          for j := 0 to infos.Count - 1 do begin
              info := infos.O[j];
              infoRecord := FindOrCreateChildRecord(topicRecord, 'INFO', info.S['id']);

              // Set the speaker
              if topic.S['speaker'] <> '' then begin
                  AddMessage('Setting speaker: ' + topic.S['speaker']);
                  speakerRecord := FindRecordByEditorID(topic.S['speaker'], 'NPC_');
                  if not Assigned(speakerRecord) then begin
                      AddMessage('Could not find speaker: ' + topic.S['speaker']);
                  end
                  else begin
                      SetElementEditValues(infoRecord, 'ANAM', GetEditValue(speakerRecord));
                  end;
              end;

              // Set Start Scene
              if topic.S['startScene'] <> '' then begin
                  AddMessage('Setting start scene: ' + topic.S['startScene']);
                  sceneRecord := FindChildRecord(e, 'SCEN', topic.S['startScene']);
                  if not Assigned(sceneRecord) then begin
                      AddMessage('Could not find scene: ' + topic.S['startScene']);
                  end
                  else begin
                      SetElementEditValues(infoRecord, 'TSCE', GetEditValue(sceneRecord));
                  end;
              end;

              // Set start scene phase
              if topic.S['startScenePhase'] <> '' then begin
                  AddMessage('Setting start scene phase: ' + topic.S['startScenePhase']);
                  SetElementEditValues(infoRecord, 'NAM0', topic.S['startScenePhase']);
              end;

              // Set VMAD script
              if topic.S['script'] <> '' then begin
                  AddMessage('Setting script: ' + topic.S['script']);
                  AddInfoScript(infoRecord, topic.S['script'], topic.S['onBegin'], topic.S['onEnd']);
              end;

              // Set responses
              responses := info.A['responses'];
              responsesRecord := ElementByName(infoRecord, 'Responses');
              // Remove existing responses
              if Assigned(responsesRecord) then
                  Remove(responseRecord);
              // add new responses
              responsesRecord := Add(infoRecord, 'Responses', true);
              // Remove first element thats generated
              Remove(ElementByIndex(responsesRecord, 0));

              for k := 0 to responses.Count - 1 do begin
                  response := responses.O[k];
                  AddMessage('Adding response: ' + response.S['text']);
                  responseRecord := Add(responsesRecord, 'Response', true);
                  SetElementEditValues(responseRecord, 'NAM1', response.S['text']);

                  // Set none for emotion for now, maybe this can be configurable later
                  SetElementEditValues(responseRecord, 'TRDA - Response Data\Emotion', 'FFFFFFFF');
              end;

          end;
      end;
    end;
end;

end.
