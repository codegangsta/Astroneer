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

function GetGroup(signature: string): IInterface;
var
	i: Integer;
	fileI: IInterface;
begin
	Result := nil;
	for i := 0 to Pred(FileCount) do // Iterate through all files
	begin
		fileI := FileByIndex(i);
		if GetFileName(fileI) = 'Astroneer.esm' then
			Result := GroupBySignature(fileI, signature);
		if Assigned(Result) then
			Break; // Record found
	end;
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
	vmadSubrecord,script, properties, fragment, fragments: IInterface;
	i: Integer;
begin
	// Add or get VMAD subrecord
	vmadSubrecord := ElementByPath(infoRecord, 'VMAD');
	if not Assigned(vmadSubrecord) then
		vmadSubrecord := Add(infoRecord, 'VMAD', True);

	// Set VMAD properties
	SetElementEditValues(vmadSubrecord, 'Version', '6');
	SetElementEditValues(vmadSubrecord, 'Object Format', '2');

	// Add script
	script := ElementByPath(vmadSubrecord, 'Script Fragments\Script');
	SetElementEditValues(script, 'ScriptName', scriptName);
	script := ElementByPath(vmadSubrecord, 'Script Fragments\Flags');
	SetEditValue(script, '11');

	fragments := ElementByPath(vmadSubrecord, 'Script Fragments\Fragments');
	// loop over fragments and remove them
	for i := 0 to Pred(ElementCount(fragments)) do begin
		Remove(ElementByIndex(fragments, i));
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
	HandleMessages;
	HandleScenes;
end;

function Process(e: IInterface): Integer;
begin
end;

procedure HandleMessages;
var
	messages: TJsonArray;
	message: TJsonObject;
	messageGroup: IInterface;
	messageRecord: IInterface;
	formLists: TJsonArray;
	formListRecord: IInterface;
	formListElement: IInterface;
	formListEntry: IInterface;
	found: IInterface;
	formListGroup: IInterface;
	i: Integer;
	j: Integer;
	k: Integer;
begin
	AddMessage('Processing messages...');
	messages := RecordsFile.A['messages'];
	messageGroup := GetGroup('MESG');
	formListGroup := GetGroup('FLST');
	for i := 0 to messages.Count -1 do begin
		message := messages.O[i];
		messageRecord := FindRecordByEditorID(message.S['id'], 'MESG');
		if not Assigned(messageRecord) then begin
			AddMessage('Creating MESG record: ' + message.S['id']);
			messageRecord := Add(messageGroup, 'MESG', True);
			SetElementEditValues(messageRecord, 'EDID', message.S['id']);
		end;

		SetElementEditValues(messageRecord, 'FULL', message.S['message']);

		// Add form lists
		formLists := message.A['form_lists'];
		for j := 0 to formLists.Count -1 do begin
			formListRecord := FindRecordByEditorID(formLists.S[j], 'FLST');
			if not Assigned(formListRecord) then begin
				AddMessage('Adding form list' + formLists.S[j]);
				formListRecord := Add(formListGroup, 'FLST', True);
				SetElementEditValues(formListRecord, 'EDID', formLists.S[j]);
			end;

			formListElement := ElementByPath(formListRecord, 'FormIDs');
			if not Assigned(formListElement) then begin
				AddMessage('Adding form list element');
				formListElement := Add(formListRecord, 'FormIDs', True);
			end;

			for k := 0 to ElementCount(formListElement) -1 do begin
				formListEntry := ElementByIndex(formListElement, k);
				if GetNativeValue(formListEntry) = GetNativeValue(messageRecord) then begin
					found := formListEntry;
					Break;
				end;
			end;

			if not Assigned(found) then begin
				AddMessage('Adding form list entry');
				formListEntry := Add(formListElement, 'LNAM - FormID', True);
				SetEditValue(formListEntry, GetEditValue(messageRecord));
			end;

		end;
	end;
end;

procedure HandleScenes;
var
	quest: IInterface;
	scenes: TJsonArray;
	scene: TJsonObject;
	sceneRecord: IInterface;
	actions: TJsonArray;
	action: TJsonObject;
	actionsRecord: IInterface;
	actionRecord: IInterface;
	playerDialogueChoices: TJsonArray;
	dialogueListItemRecord: IInterface;
	typeSpecificActionRecord: IInterface;
	dialogueListRecord: IInterface;
	phases: TJsonArray;
	phasesRecord: IInterface;
	phaseRecord: IInterface;
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
	conditions: TJsonArray;
	condition: TJsonObject;
	conditionsRecord: IInterface;
	conditionRecord: IInterface;
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
	AddMessage('Processing scenes...');
	scenes := RecordsFile.A['scenes'];
	// loop over scenes
	for si := 0 to scenes.Count -1 do begin
		scene := scenes.O[si];
		quest := FindRecordByEditorID(scene.S['quest'], 'QUST');
		if not Assigned(quest) then begin
			AddMessage('Could not find quest: ' + scene.S['quest']);
			Continue;
		end;
		sceneRecord := FindOrCreateChildRecord(quest, 'SCEN', scene.S['id']);
		SetElementEditValues(sceneRecord, 'FULL', scene.S['name']);
		SetElementEditValues(sceneRecord, 'NNAM', scene.S['notes']);
		SetElementEditValues(sceneRecord, 'PNAM', GetEditValue(quest));
		if scene.S['flags'] <> '' then
			SetElementEditValues(sceneRecord, 'FNAM', scene.S['flags']);

		// ============================================================
		// Set scene phases
		// ============================================================
		phases := scene.A['phases'];
		phasesRecord := ElementByPath(sceneRecord, 'Phases');
		if Assigned(phasesRecord) then
			Remove(phasesRecord);
		phasesRecord := Add(sceneRecord, 'Phases', True);

		for i := 0 to phases.Count - 1 do begin
			phaseRecord := Add(phasesRecord, 'Phase', True);
			SetElementEditValues(phaseRecord, 'NAM0 - Name', phases.O[i].S['name']);
		end;
		Remove(ElementByIndex(phasesRecord, 0));

		// ============================================================
		// Set scene actors
		// ============================================================
		actors := scene.A['actors'];
		actorsRecord := ElementByPath(sceneRecord, 'Actors');
		if Assigned(actorsRecord) then
			Remove(actorsRecord);
		actorsRecord := Add(sceneRecord, 'Actors', True);

		for i := 0 to actors.Count - 1 do begin
			actorRecord := Add(actorsRecord, 'Actor', True);
			SetElementEditValues(actorRecord, 'ALID - Alias ID', actors.I[i]);
		end;

		// ============================================================
		// Set scene actions
		// ============================================================
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
			SetElementEditValues(actionRecord, 'ANAM - Type', action.I['type']);
			SetElementEditValues(actionRecord, 'SNAM - Start Phase', action.I['startPhase']);
			SetElementEditValues(actionRecord, 'ENAM - End Phase', action.I['endPhase']);

			// Dialogue
			if action.I['type'] = 0 then begin
				topicRecord := FindChildRecord(quest, 'DIAL', action.S['topic']);
				typeSpecificActionRecord := FindChildRecord(quest, 'SCEN', 'RefScene');
				typeSpecificActionRecord := ElementByPath(typeSpecificActionRecord, 'Actions\[0]\Dialogue');
				typeSpecificActionRecord := ElementAssign(actionRecord, 8, typeSpecificActionRecord, False);
				SetElementEditValues(typeSpecificActionRecord, 'DATA', GetEditValue(topicRecord));
			end;
			// Player dialogue
			if action.I['type'] = 3 then begin
				typeSpecificActionRecord := FindChildRecord(quest, 'SCEN', 'RefScene');
				typeSpecificActionRecord := ElementByPath(typeSpecificActionRecord, 'Actions\[1]\Player Dialogue');
				typeSpecificActionRecord := ElementAssign(actionRecord, 8, typeSpecificActionRecord, False);
				dialogueListRecord := ElementByPath(typeSpecificActionRecord, 'Dialogue List');
				playerDialogueChoices := action.A['choices'];

				for j := 0 to playerDialogueChoices.Count - 1 do begin
					dialogueListItemRecord := Add(dialogueListRecord, 'Item', True);
					topicRecord := FindChildRecord(quest, 'DIAL', playerDialogueChoices.O[j].S['topic']);
					SetElementEditValues(dialogueListItemRecord, 'ESCE', GetEditValue(topicRecord));
					if playerDialogueChoices.O[j].S['response'] <> '' then begin
						topicRecord := FindChildRecord(quest, 'DIAL', playerDialogueChoices.O[j].S['response']);
						SetElementEditValues(dialogueListItemRecord, 'ESCS', GetEditValue(topicRecord));
					end;
				end;
				Remove(ElementByIndex(dialogueListRecord, 0));
			end;
		end;
		Remove(ElementByIndex(actionsRecord, 0));

		topics := scene.A['topics'];
		for i := 0 to topics.Count - 1 do begin
			topic := topics.O[i];
			topicRecord := FindOrCreateChildRecord(quest, 'DIAL', topic.S['id']);
			SetElementEditValues(topicRecord, 'QNAM', GetEditValue(quest));
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
				end
				else begin
					Remove(ElementByPath(infoRecord, 'ANAM'));
				end;

				// Set Start Scene
				if topic.S['startScene'] <> '' then begin
					startSceneRecord := FindChildRecord(quest, 'SCEN', topic.S['startScene']);
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

				if info.S['flags'] <> '' then begin
					Add(infoRecord, 'ENAM', True);
					SetElementEditValues(infoRecord, 'ENAM - Response Flags\Flags', info.S['flags']);
				end;

				// add new responses
				responses := info.A['responses'];
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

				// add conditions
				conditions := info.A['conditions'];
				conditionsRecord := ElementByPath(infoRecord, 'Conditions');
				if Assigned(conditionsRecord) then
					Remove(conditionsRecord);
				conditionsRecord := Add(infoRecord, 'Conditions', true);

				for k := 0 to conditions.Count - 1 do begin
					condition := conditions.O[k];
					conditionRecord := Add(conditionsRecord, 'Condition', true);
					SetElementEditValues(conditionRecord, 'CTDA - CTDA\Function', condition.S['function']);
					SetElementEditValues(conditionRecord, 'CTDA - CTDA\Run On', 'Subject');

					if condition.S['function'] = 'GetStage' then begin
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Comparison Value', condition.S['equals']);
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Parameter #1', GetEditValue(FindRecordByEditorID(condition.S['quest'], 'QUST')));

						if condition.B['or'] then begin
							SetElementEditValues(conditionRecord, 'CTDA - CTDA\Type', '10010000');
						end;
					end;

					if condition.S['function'] = 'GetVMQuestVariable' then begin
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Comparison Value', condition.S['equals']);
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Parameter #1', GetEditValue(FindRecordByEditorID(condition.S['quest'], 'QUST')));
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Parameter #2', '::' + condition.S['variable'] + '_var');
						SetElementEditValues(conditionRecord, 'CIS2 Parameter #2', '::' + condition.S['variable'] + '_var');
					end;

					if condition.S['function'] = 'GetRandomPercent' then begin
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Comparison Value', condition.S['lessThanOrEqualTo']);
						SetElementEditValues(conditionRecord, 'CTDA - CTDA\Type', '10100000');
					end;
				end;
				Remove(ElementByIndex(conditionsRecord, 0));
			end;
		end;
	end;
end;

end.
