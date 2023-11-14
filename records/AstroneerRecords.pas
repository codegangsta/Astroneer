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
    fragment := Add(fragments, 'Fragment', True);
    SetElementEditValues(fragment, 'Unknown', '0');
    SetElementEditValues(fragment, 'ScriptName', scriptName);
    SetElementEditValues(fragment, 'FragmentName', onBegin);
  end;

  if onEnd <> '' then
  begin
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
    sceneRecord: IInterface;
    actions: TJsonArray;
    action: TJsonObject;
    actionsRecord: IInterface;
    actionRecord: IInterface;
    typeSpecificActionRecord: IInterface;
    actors: TJsonArray;
    actorsRecord: IInterface;
    actorRecord: IInterface;
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
    startSceneRecord: IInterface;
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
      sceneRecord := FindOrCreateChildRecord(e, 'SCEN', scene.S['id']);
      SetElementEditValues(sceneRecord, 'FULL', scene.S['name']);
      SetElementEditValues(sceneRecord, 'NNAM', scene.S['notes']);
      SetElementEditValues(sceneRecord, 'PNAM', GetEditValue(e));

      actors := scene.A['actors'];
      actorsRecord := ElementByPath(sceneRecord, 'Actors');
      if Assigned(actorsRecord) then
        Remove(actorsRecord);
      actorsRecord := Add(sceneRecord, 'Actors', True);

      for i := 0 to actors.Count - 1 do begin
        actorRecord := Add(actorsRecord, 'Actor', True);
        SetElementEditValues(actorRecord, 'ALID - Alias ID', actors.I[i]);
      end;

      actions := scene.A['actions'];
      actionsRecord := ElementByPath(sceneRecord, 'Actions');
      if Assigned(actionsRecord) then
        Remove(actionsRecord);
      actionsRecord := Add(sceneRecord, 'Actions', True);

      for i := 0 to actions.Count - 1 do begin
        action := actions.O[i];
        actionRecord := Add(actionsRecord, 'Action', True);
        SetElementEditValues(actionRecord, 'INAM - Index', i);
        SetElementEditValues(actionRecord, 'NAM0 - Name', action.S['name']);
        SetElementEditValues(actionRecord, 'ANAM - Type', action.S['type']);
        SetElementEditValues(actionRecord, 'SNAM - Start Phase', action.I['startPhase']);
        SetElementEditValues(actionRecord, 'ENAM - End Phase', action.I['endPhase']);

        if action.S['type'] = 'Dialogue' then begin
          AddMessage('topic: ' + action.S['topic']);
          topicRecord := FindChildRecord(e, 'DIAL', action.S['topic']);
          typeSpecificActionRecord := Add(actionRecord, 'DATA', True);
          SetElementEditValues(typeSpecificActionRecord, 'DATA', GetEditValue(topicRecord));
        end;
      end;
      // Remove first element thats generated
      Remove(ElementByIndex(actionsRecord, 0));

      topics := scene.A['topics'];

      for i := 0 to topics.Count - 1 do begin
          topic := topics.O[i];
          topicRecord := FindOrCreateChildRecord(e, 'DIAL', topic.S['id']);
          SetElementEditValues(topicRecord, 'QNAM', GetEditValue(e));
          SetElementEditValues(topicRecord, 'FULL', topic.S['notes']);
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
                  startSceneRecord := FindChildRecord(e, 'SCEN', topic.S['startScene']);
                  if not Assigned(startSceneRecord) then begin
                      AddMessage('Could not find scene: ' + topic.S['startScene']);
                  end
                  else begin
                      SetElementEditValues(infoRecord, 'TSCE', GetEditValue(startSceneRecord));
                  end;
              end;

              // Set start scene phase
              if topic.S['startScenePhase'] <> '' then begin
                  SetElementEditValues(infoRecord, 'NAM0', topic.S['startScenePhase']);
              end;

              // Set VMAD script
              if topic.S['script'] <> '' then begin
                  AddInfoScript(infoRecord, topic.S['script'], topic.S['onBegin'], topic.S['onEnd']);
              end;

              responses := info.A['responses'];

              // add new responses
              responsesRecord := ElementByPath(infoRecord, 'Responses');
              if Assigned(responsesRecord) then
                Remove(responsesRecord);
              responsesRecord := Add(infoRecord, 'Responses', true);

              for k := 0 to responses.Count - 1 do begin
                  response := responses.O[k];
                  responseRecord := Add(responsesRecord, 'Response', true);
                  SetElementEditValues(responseRecord, 'NAM1', response.S['text']);
              
                  // Set none for emotion for now, maybe this can be configurable later
                  SetElementEditValues(responseRecord, 'TRDA - Response Data\Emotion', 'FFFFFFFF');
              end;
              Remove(ElementByIndex(responsesRecord, 0));
          end;
      end;
    end;
end;

end.
