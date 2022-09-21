unit Unit_FlowHandler;

interface

uses
  System.Classes, Unit_LinkedListHandler, Vcl.Dialogs, System.TypInfo, System.SysUtils, Vcl.ExtCtrls,
  Vcl.StdCtrls, StrUtils, Vcl.Controls, Vcl.Graphics, System.Types, Unit_AuxiliaryFunctions, Winapi.Windows;

procedure SaveFlow();
procedure LoadFlow(caller: string);
procedure GenerateFlow();
procedure ProcessFlowElement();

implementation

uses Unit_Main;

{$REGION 'Save flow'}
procedure SaveFlow();
var
  saveDialog : TSaveDialog;
  saveData : TStringList;
  currentElement : PFlowElement;
begin

  saveDialog := TSaveDialog.Create(Form1);
  try
    saveDialog.Title := 'Save your flow into a file.';
    saveDialog.InitialDir := workDir + '\Saves';
    saveDialog.Filter := 'Szakdolgozat flow |*.sdf';
    saveDialog.DefaultExt := 'sdf';
    saveDialog.FilterIndex := 1;
    if saveDialog.Execute then begin
      saveData := TStringList.Create;
      currentElement := flowHead;
      try
        // Save schedule
        saveData.Add(
          Form1.SE_TotalRuns.Text + ';' + Form1.Edt_WaitBetween.Text + ';' + Form1.CB_WaitBetween.Text
        );

        // Save flow elements
        while currentElement.NextElement <> nil do begin
          currentElement := currentElement.NextElement;
          if currentElement.inputParam1 = '' then
            currentElement.inputParam1 := '?';
          if currentElement.inputParam2 = '' then
            currentElement.inputParam2 := '?';
          if currentElement.inputParam3 = '' then
            currentElement.inputParam3 := '?';
          if currentElement.inputParam4 = '' then
            currentElement.inputParam4 := '?';
          saveData.Add(
            GetEnumName(typeInfo(TInputType), Ord(currentElement.inputType)) +
            ';' + currentElement.inputParam1 + ';' +
            currentElement.inputParam2 + ';' + currentElement.inputParam3 + ';' +
            currentElement.inputParam4 + ';' + IntToStr(currentElement.waitAfterAmount) + ';' +
            GetEnumName(typeInfo(TWaitType), Ord(currentElement.waitAfterType))
          );
        end;
        saveData.SaveToFile(saveDialog.FileName);
      finally
        saveData.Free;
      end;
      unsavedProgress := false;
    end;
  finally
    saveDialog.Free;
  end;

end;
{$ENDREGION}
{$REGION 'Load flow'}
procedure LoadFlow(caller: string);
var
  loadedFile: TStringList;
  schedulesettings: TStringList;
  i : integer;
  newFlowElement, prevElement : PFlowElement;
  elementCount : integer;
  newPanelColumn : TColumnItem;
begin
  if ClearLinkedList() = 0 then begin
    if caller = 'user' then begin
      // Load was called by user
      with TFileOpenDialog.Create(nil) do
      try
        Options := [fdoStrictFileTypes];
        with FileTypes.Add do begin
          DisplayName := 'Szakdolgozat flow';
          FileMask := '*.sdf';
        end;
        if Execute then begin
          caller := FileName;
        end;
      finally
        Free;
      end
    end;
    if caller <> 'user' then begin
      // Possibly valid file
      loadedFile := TStringList.Create();
      try
        loadedFile.LoadFromFile(caller);
        scheduleSettings := TStringList.Create;
        try
          // Set Schedule Settings
          scheduleSettings.Add(loadedFile[0]);
          scheduleSettings.Text := StringReplace(scheduleSettings.Text, ';', #13#10, [rfReplaceAll]);
          Form1.SE_TotalRuns.Text := scheduleSettings[0];
          Form1.Edt_WaitBetween.Text := scheduleSettings[1];
          i := 0;
          while (i < Form1.CB_WaitBetween.Items.Count) and (scheduleSettings[2] <> Form1.CB_WaitBetween.Items[i]) do
            i := i+1;
          if scheduleSettings[2] = Form1.CB_WaitBetween.Items[i] then
            Form1.CB_WaitBetween.ItemIndex := i;
        finally
          scheduleSettings.Free;
        end;
        loadedFile[0].Empty;

        // Load linked list
        loadedFile.Text := StringReplace(loadedFile.Text, ';', #13#10, [rfReplaceAll]);
        elementCount := 0;
        prevElement := nil;
        for i := 0 to loadedFile.Count-7 do begin

          if (loadedFile[i] = 'itClick') or (loadedFile[i] = 'itKeyboard') or
          (loadedFile[i] = 'itHotkey') or(loadedFile[i] = 'itSpecialKey') then begin
            elementCount := elementCount+1;

            newFlowElement := new(PFlowElement);
            if flowHead.NextElement = nil then
              flowHead.NextElement := newFlowElement
            else
              prevElement.NextElement := newFlowElement;

            // Create Panel & expand flow panel
            newFlowElement.panelObject := TPanel.Create(Form1.Pnl_Flow);

            if (elementCount mod 8) = 0 then begin
              newPanelColumn := Form1.Pnl_Flow.ColumnCollection.Add();
              newPanelColumn.SizeStyle := ssAuto;
            end;
            Form1.Pnl_Flow.ControlCollection.AddControl(newFlowElement.panelObject, ((elementCount-1) div 8), ((elementCount-1) mod 8));
            newFlowElement.panelObject.Parent := Form1.Pnl_Flow;
            newFlowElement.panelObject.Alignment := taRightJustify;
            newFlowElement.panelObject.Font.Style := [fsBold];
            newFlowElement.panelObject.Font.Size := 12;
            newFlowElement.panelObject.Caption := IntToStr(elementCount) +  '.         ';
            newFlowElement.panelObject.Width := 210;
            newFlowElement.panelObject.OnMouseDown := Form1.Pnl_Dummy.OnMouseDown;
            newFlowElement.panelObject.OnMouseUp := Form1.Pnl_Dummy.OnMouseUp;

            // Create Button
            newFlowElement.deleteButton := TButton.Create(newFlowElement.panelObject);
            newFlowElement.deleteButton.Parent := newFlowElement.panelObject;
            newFlowElement.deleteButton.Font.Style := [];
            newFlowElement.deleteButton.Font.Size := 8;
            newFlowElement.deleteButton.Caption := 'Delete';
            newFlowElement.deleteButton.Align := alRight;
            newFlowElement.deleteButton.Anchors := [akRight, akTop, akBottom];
            newFlowElement.deleteButton.Width := 40;
            newFlowElement.deleteButton.Name := 'flowButton_'+IntToStr(elementCount);
            newFlowElement.deleteButton.OnClick := Form1.Btn_Dummy.OnClick;

            // Create Label
            newFlowElement.labelObject := TLabel.Create(newFlowElement.panelObject);
            newFlowElement.labelObject.Parent := newFlowElement.panelObject;
            newFlowElement.labelObject.Font.Style := [];
            newFlowElement.labelObject.Font.Size := 8;
            newFlowElement.labelObject.OnMouseDown := Form1.Pnl_Dummy.OnMouseDown;
            newFlowElement.labelObject.OnMouseUp := Form1.Pnl_Dummy.OnMouseUp;

            // Set wait time
            newFlowElement.waitAfterAmount := StrToInt(loadedFile[i+5]);
            if loadedFile[i+6] = 'wtMil' then begin
              newFlowElement.waitAfterType := wtMil;
              newFlowElement.waitAfterTypeText := 'MilliSeconds'
            end else if loadedFile[i+6] = 'wtSec' then begin
              newFlowElement.waitAfterType := wtSec;
              newFlowElement.waitAfterTypeText := 'Seconds'
            end else if loadedFile[i+6] = 'wtMin' then begin
              newFlowElement.waitAfterType := wtMin;
              newFlowElement.waitAfterTypeText := 'Minutes'
            end else if loadedFile[i+6] = 'wtHour' then begin
              newFlowElement.waitAfterType := wtHour;
              newFlowElement.waitAfterTypeText := 'Hours'
            end else
              showmessage('ERROR SETTING TIME! DO NOT START THE FLOW!');

            if loadedFile[i] = 'itClick' then begin
              // Input type: Mouse
              newFlowElement.inputType := itClick;
              newFlowElement.inputParam1 := loadedFile[i+1];
              newFlowElement.inputParam2 := loadedFile[i+2];
              newFlowElement.inputParam3 := loadedFile[i+3];
              newFlowElement.inputParam4 := loadedFile[i+4];
              newFlowElement.labelObject.Caption :=
                'Type: ' + newFlowElement.inputParam3 + ' ' + newFlowElement.inputParam4 + sLineBreak +
                'x: ' + newFlowElement.inputParam1 + ', y: ' + newFlowElement.inputParam2 + sLineBreak +
                'wait ' + IntToStr(newFlowElement.waitAfterAmount) + ' ' +
                LowerCase(newFlowElement.waitAfterTypeText);
            end else if (loadedFile[i] = 'itHotkey') or (loadedFile[i] = 'itSpecialKey') then begin
              // Input type: Hotkey
              if loadedFile[i] = 'itHotkey' then begin
                newFlowElement.inputType := itHotkey;
                newFlowElement.inputParam1 := loadedFile[i+1];
                newFlowElement.inputParam2 := loadedFile[i+2];
                newFlowElement.labelObject.Caption :=
                  'Type: Hotkey' + sLineBreak +
                  'Key: ' + newFlowElement.inputParam1 + ' + ' + newFlowElement.inputParam2 + sLineBreak +
                  'wait ' + IntToStr(newFlowElement.waitAfterAmount) + ' ' +
                  LowerCase(newFlowElement.waitAfterTypeText);
              end else begin
                // Input type: Special Key
                if loadedFile[i] = 'itSpecialKey' then begin
                  newFlowElement.inputType := itSpecialKey;
                  newFlowElement.inputParam1 :=  loadedFile[i+1];
                  newFlowElement.labelObject.Caption :=
                    'Type: Special Key' + sLineBreak +
                    'Key: ' + newFlowElement.inputParam1 + sLineBreak +
                    'wait ' + IntToStr(newFlowElement.waitAfterAmount) + ' ' +
                    LowerCase(newFlowElement.waitAfterTypeText);
                end;
              end;
            end else if loadedFile[i] = 'itKeyboard' then begin
              newFlowElement.inputType := itKeyboard;
              newFlowElement.inputParam1 := loadedFile[i+1];
              if Length(loadedFile[i+1]) > 15 then begin
                newFlowElement.labelObject.Hint := loadedFile[i+1];
                newFlowElement.labelObject.ShowHint := True;
                newFlowElement.labelObject.Caption :=
                  'Type: Keyboard Input' + sLineBreak +
                  'Input: ' + LeftStr(loadedFile[i+1],12) + '...*' + sLineBreak +
                  'wait' + IntToStr(newFlowElement.waitAfterAmount) + ' ' +
                  LowerCase(newFlowElement.waitAfterTypeText);
              end else begin
                newFlowElement.labelObject.Caption :=
                  'Type: Keyboard Input' + sLineBreak +
                  'Input: ' + loadedFile[i+1] + sLineBreak +
                  'wait ' + IntToStr(newFlowElement.waitAfterAmount) + ' ' +
                  LowerCase(newFlowElement.waitAfterTypeText);
              end;
            end;
            prevElement := newFlowElement;
            prevElement.NextElement := nil;
            Form1.Pnl_Flow.Width :=  ((((elementCount-1) div 8) + 1)  * newFlowElement.panelObject.Width) + 5;
          end;
        end;
      finally
        loadedFile.Free;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Generate flow from captured input'}
procedure GenerateFlow;
var
  tempList: TStringList;
  splitLines: array of TStringList;
  i, j: integer;
  test, newLinkElement, prevElement: PFlowElement;
  fooString, fooString2: string;
  newPanelColumn : TColumnItem;

  splitDelimiter : array[0..0] of Char;
  splitText : TStringDynArray;

  mouseCO: integer; // mouseConcatenationOffset

begin
  // Load temporary flow
  tempList := TStringList.Create();
  tempList.LoadFromFile(workDir + '\tempFlow.szd');

  // Split raw data into string list array
  SetLength(splitLines, tempList.Count);
  for i := 0 to tempList.Count-1 do begin
    splitLines[i] := TStringList.Create;
    splitLines[i].Text := SplitTempFlowLine(tempList[i]);
  end;

 // Process loaded temporary flow lines
  i := 0;
  while i <= tempList.Count-3 do begin   // Skip last 2: those are used to stop the flow
    {$REGION 'Universal init'}
    // Find the end of the linked list
    test := flowHead;
    j := 1;
    while (test.NextElement <> nil) do begin
      test := test.NextElement;
      j := j+1;
    end;
    prevElement := test;

    // Create new element then add it to the end of the list
    newLinkElement := new(PFlowElement);
    test.NextElement := newLinkElement;
    newLinkElement.nextElement := nil;
    if flowHead.NextElement = nil then
      flowHead.NextElement := newLinkElement
    else
      prevElement.NextElement := newLinkElement;


    // Create Panel & expand flow panel
    newLinkElement.panelObject := TPanel.Create(Form1.Pnl_Flow);

    if (j mod 8) = 0 then begin
      newPanelColumn := Form1.Pnl_Flow.ColumnCollection.Add();
      newPanelColumn.SizeStyle := ssAuto;
    end;
    Form1.Pnl_Flow.ControlCollection.AddControl(newLinkElement.panelObject, ((j-1) div 8), ((j-1) mod 8));
    newLinkElement.panelObject.Parent := Form1.Pnl_Flow;
    newLinkElement.panelObject.Alignment := taRightJustify;
    newLinkElement.panelObject.Font.Style := [fsBold];
    newLinkElement.panelObject.Font.Size := 12;
    newLinkElement.panelObject.Caption := IntToStr(j) +  '.         ';
    newLinkElement.panelObject.Width := 210;
    newLinkElement.panelObject.OnMouseDown := Form1.Pnl_Dummy.OnMouseDown;
    newLinkElement.panelObject.OnMouseUp := Form1.Pnl_Dummy.OnMouseUp;

    // Create Button
    newLinkElement.deleteButton := TButton.Create(newLinkElement.panelObject);
    newLinkElement.deleteButton.Parent := newLinkElement.panelObject;
    newLinkElement.deleteButton.Font.Style := [];
    newLinkElement.deleteButton.Font.Size := 8;
    newLinkElement.deleteButton.Caption := 'Delete';
    newLinkElement.deleteButton.Align := alRight;
    newLinkElement.deleteButton.Anchors := [akRight, akTop, akBottom];
    newLinkElement.deleteButton.Width := 40;
    newLinkElement.deleteButton.Name := 'flowButton_'+IntToStr(j);
    newLinkElement.deleteButton.OnClick := Form1.Btn_Dummy.OnClick;

    // Create Label
    newLinkElement.labelObject := TLabel.Create(newLinkElement.panelObject);
    newLinkElement.labelObject.Parent := newLinkElement.panelObject;
    newLinkElement.labelObject.Font.Style := [];
    newLinkElement.labelObject.Font.Size := 8;
    newLinkElement.labelObject.OnMouseDown := Form1.Pnl_Dummy.OnMouseDown;
    newLinkElement.labelObject.OnMouseUp := Form1.Pnl_Dummy.OnMouseUp;

    // Set wait time
    newLinkElement.waitAfterAmount := 1000;
    newLinkElement.waitAfterTypeText := 'Millisecond';
    newLinkElement.waitAfterType := wtMil;

    // Properly set wait time of previous step
    splitLines[i][4] := LeftStr(splitLines[i][4], Length(splitLines[i][4])-1);
    splitLines[i][4] := RightStr(splitLines[i][4], Length(splitLines[i][4])-1);
    if prevElement <> flowHead then begin
      newLinkElement.waitAfterAmount := StrToInt(splitLines[i][4]);
      newLinkElement.waitAfterTypeText := 'Millisecond';
      newLinkElement.waitAfterType := wtMil;
    end;
    {$ENDREGION}
    if splitLines[i][1] = '[Mouse]' then begin
      {$REGION '[Input type] Mouse'}
      newLinkElement.inputType := itClick;

      splitDelimiter[0] := ':';
      SetLength(splitText, 2);
      splitText := SplitString(splitLines[i][2], splitDelimiter);
      splitText[0] := RightStr(splitText[0], Length(splitText[0])-1);
      splitText[1] := LeftStr(splitText[1], Length(splitText[1])-1);
      newLinkElement.inputParam1 := splitText[0];
      newLinkElement.inputParam2 := splitText[1];

      // Detect down+up mouse clicks
      mouseCO := 0;
      MatchMessageToMouseClick(splitLines[i][3], newLinkElement.inputParam3, newLinkElement.inputParam4);
      if (LeftStr(newLinkElement.inputParam4, 9) = 'Down only') then begin
        MatchMessageToMouseClick(splitLines[i+1][3], fooString, fooString2);
        if (fooString = newLinkElement.inputParam3) and (LeftStr(fooString2, 7) = 'Up only') and
          ('[' + newLinkElement.inputParam1 + ':' + newLinkElement.inputParam2 + ']' = splitLines[i+1][2]) then begin
           mouseCO := 1;
           newLinkElement.inputParam4 := 'Down+Up (single)';
        end;
      end;

      newLinkElement.labelObject.Caption :=
        'Type: ' + newLinkElement.inputParam3 + ' ' + newLinkElement.inputParam4 + sLineBreak +
        'x: ' + newLinkElement.inputParam1 + ', y: ' + newLinkElement.inputParam2 + sLineBreak +
        'wait ' + IntToStr(newLinkElement.waitAfterAmount) + ' ' + LowerCase(newLinkElement.waitAfterTypeText);
      i := i + mouseCO;
      {$ENDREGION}
    end else if splitLines[i][1] = '[Key]' then begin
      {$REGION '[Input type] Key'}
      if not IsSpecialKey(splitLines[i][2]) then begin
        // Text input
        fooString2 := '';
        while (i <= Length(splitLines)) and (Length(splitLines[i][2]) = 3) do begin
          if splitLines[i][3] = '[WM_KEYDOWN]' then begin
            fooString := splitLines[i][2];
            fooString := LeftStr(fooString, Length(fooString)-1);
            fooString := RightStr(fooString, Length(fooString)-1);
            fooString2 := fooString2 + fooString;
          end;
          i := i+1;
        end;
        newLinkElement.inputType := itKeyboard;
        newLinkElement.inputParam1 := fooString2;
        if Length(fooString2) > 15 then begin
          newLinkElement.labelObject.Hint := fooString2;
          newLinkElement.labelObject.ShowHint := True;
          newLinkElement.labelObject.Caption :=
            'Type: Keyboard Input' + sLineBreak +
            'Input: ' + LeftStr(fooString2,12) + '...*' + sLineBreak +
            'wait ' + IntToStr(newLinkElement.waitAfterAmount) + ' ' + LowerCase(newLinkElement.waitAfterTypeText);
        end else begin
          newLinkElement.labelObject.Caption :=
            'Type: Keyboard Input' + sLineBreak +
            'Input: ' + fooString2 + sLineBreak +
            'wait ' + IntToStr(newLinkElement.waitAfterAmount) + ' ' + LowerCase(newLinkElement.waitAfterTypeText);
        end;
        i := i-1;
      end else begin
        if (splitLines[i][3] = '[WM_KEYDOWN]') and (splitLines[i+1][3] = '[WM_KEYUP]') then begin
           // Special Key
          newLinkElement.inputType := itSpecialKey;
          fooString := LeftStr(splitLines[i][2], Length(splitLines[i][2])-1);
          fooString := RightStr(fooString, Length(fooString)-1);
          newLinkElement.inputParam1 := fooString;
          newLinkElement.labelObject.Caption :=
            'Type: Special Key' + sLineBreak +
            'Key: ' + newLinkElement.inputParam1 + sLineBreak +
            'wait ' + IntToStr(newLinkElement.waitAfterAmount) + ' ' + LowerCase(newLinkElement.waitAfterTypeText);
          i := i+1;

        end else begin
          // Hotkey
          newLinkElement.inputType := itHotkey;

          fooString := LeftStr(splitLines[i][2], Length(splitLines[i][2])-1);
          fooString := RightStr(fooString, Length(fooString)-1);
          newLinkElement.inputParam1 := fooString;

          fooString := LeftStr(splitLines[i+1][2], Length(splitLines[i+1][2])-1);
          fooString := RightStr(fooString, Length(fooString)-1);
          newLinkElement.inputParam2 := fooString;

          newLinkElement.labelObject.Caption :=
            'Type: Hotkey' + sLineBreak +
            'Key: ' + newLinkElement.inputParam1 + ' + ' + newLinkElement.inputParam2 + sLineBreak +
            'wait ' + IntToStr(newLinkElement.waitAfterAmount) + ' ' + LowerCase(newLinkElement.waitAfterTypeText);

          i := i+3

        end;
      end;
      {$ENDREGION}
    end else begin
      // Unknown input type
      showmessage('Corrupted file, can not generate flow.');
      Exit();
    end;

    prevElement := newLinkElement;
    prevElement.NextElement := nil;
    unsavedProgress := true;
    Form1.Pnl_Flow.Width :=  ((((j-1) div 8) + 1)  * newLinkElement.panelObject.Width) + 5;
    i := i+1;
  end;

end;
{$ENDREGION}
{$REGION 'Process flow element'}
procedure ProcessFlowElement();
var
  id, i : integer;
  modifier : integer;
  inputChar : char;
  debugCharState : integer;
begin
  if currentStep <> nil then begin
    case currentStep.inputType of
      itClick : begin
        SetCursorPos(StrToInt(currentStep.inputParam1), StrToInt(currentStep.inputParam2));
        //Left mouse button events
        if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Down+Up (single)') then begin
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Down only (single)') then begin
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Up only (single)') then begin
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Down+Up (double)') then begin
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Down (double)') then begin
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Left') and (currentStep.inputParam4 = 'Up Only (double)') then begin
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
        end else
        //Middle mouse button events
        if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Down+Up (single)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Down only (single)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Up only (single)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Down+Up (double)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Down (double)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Middle') and (currentStep.inputParam4 = 'Up Only (double)') then begin
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0);
        end else
        //Right mouse button events
        if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Down+Up (single)') then begin
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Down only (single)') then begin
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Up only (single)') then begin
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Down+Up (double)') then begin
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Down (double)') then begin
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0);
        end else if (currentStep.inputParam3 = 'Right') and (currentStep.inputParam4 = 'Up Only (double)') then begin
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
          GetDoubleClickTime;
          mouse_event(MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0);
        end;
      end;
       //Special Key input
      itSpecialKey: begin
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1, Form1.RadGroup_SpecialKeys.Items), 0, 0, 0);
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1, Form1.RadGroup_SpecialKeys.Items), 0, KEYEVENTF_KEYUP, 0);
      end;
      //Hotkey input
      itHotkey: begin
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1, Form1.RadGroup_SpecialKeys.Items), 0, 0, 0);
        keybd_event(VkKeyScan(currentStep.inputParam2[1]), 0, 0, 0);
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1, Form1.RadGroup_SpecialKeys.Items), 0, KEYEVENTF_KEYUP, 0);
        keybd_event(VkKeyScan(currentStep.inputParam2[1]), 1, KEYEVENTF_KEYUP, 0);
      end;
      //Keyboard input
      itKeyboard: begin
        for i := 1 to Length(currentStep.inputParam1) do begin
          inputChar := currentStep.inputParam1[i];
          debugCharState := Hi(VKKeyScan(inputChar));
          case debugCharState of
            0: begin
              //Character is lowercase
              keybd_event(VkKeyScan(inputChar), 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 1, KEYEVENTF_KEYUP, 0);
            end;
            1: begin
              //Character is modified by SHIFT
              keybd_event(VK_SHIFT, 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 1, KEYEVENTF_KEYUP, 0);
              keybd_event(VK_SHIFT, 0, KEYEVENTF_KEYUP, 0);
            end;
            2: begin
              //Character is modified by CTRL
              keybd_event(VK_CONTROL, 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 1, KEYEVENTF_KEYUP, 0);
              keybd_event(VK_CONTROL, 0, KEYEVENTF_KEYUP, 0);
            end;
            4: begin
              //Character is modified by ALT
              keybd_event(VK_LMENU, 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 0, 0, 0);
              keybd_event(VkKeyScan(inputChar), 1, KEYEVENTF_KEYUP, 0);
              keybd_event(VK_LMENU, 0, KEYEVENTF_KEYUP, 0);
            end;
            else begin
              // Could not write character
              currentStep.panelObject.StyleElements := [seFont, seBorder];
              currentStep.panelObject.Color := clRed;
              currentStep.panelObject.ShowHint := True;
              currentStep.panelObject.Hint := 'Could not write one or more characters! Last attempted input: ' + inputChar;
            end;
          end;
        end;
      end;
    end;
    // Extract ID of 'next' flow element's button
    if currentStep.NextElement <> nil then begin
      if LeftStr(RightStr(currentStep.NextElement.deleteButton.Name,2),1) = '_' then
        id := StrToInt(RightStr(currentStep.NextElement.deleteButton.Name, 1))
      else
        id := StrToInt(RightStr(currentStep.NextElement.deleteButton.Name, 2));
    end else begin
      if LeftStr(RightStr(currentStep.deleteButton.Name,2),1) = '_' then
        id := StrToInt(RightStr(currentStep.deleteButton.Name, 1))
      else
        id := StrToInt(RightStr(currentStep.deleteButton.Name, 2));
      id := id+1;
    end;
  // Update Label
  Form1.Lab_Status.Caption :=
    'Next step: ' + IntToStr(id) + '.' + sLineBreak +
    'Waiting: ' + IntToStr(currentStep.waitAfterAmount) + ' ' + currentStep.waitAfterTypeText + sLineBreak +
    'Current run: ' + IntToStr(currentRunID) + ' / ' + IntToStr(totalRuns);
  // Set timer
  if currentStep.waitAfterType = wtSec then
    modifier := 1000
  else if currentStep.waitAfterType = wtMin then
    modifier := 60000
  else if currentStep.waitAfterType = wtHour then
    modifier := 3600000
  else
    modifier := 1;

  Form1.Tim_WaitAfter.Interval := currentStep.waitAfterAmount * modifier;

  // Set pointer to next element
  currentStep := currentStep.NextElement;

  end else begin
    // Flow is over
    if currentRunID < totalRuns then begin
      // Current flow completed
      currentRunID := currentRunID+1;

      Form1.Lab_Status.Caption := 'Next step: 1.';
      currentStep := flowHead.NextElement;
      if waitBetweenFlow = wtSec then
        modifier := 1000
      else if waitBetweenFlow = wtMin then
        modifier := 60000
      else if waitBetweenFlow = wtHour then
        modifier := 3600000
      else
        modifier := 1;
      Form1.Tim_WaitAfter.Interval := StrToInt(Form1.Edt_WaitBetween.Text) * modifier;
      Form1.Lab_Status.Caption := 'Flow ' + IntToStr(currentRunID-1) + ' of ' + IntToStr(totalRuns) + ' completed.' + sLineBreak +
                            'Next one starts ' + Form1.Edt_WaitBetween.Text + ' ' +
                             LowerCase(Form1.CB_WaitBetween.Text) + ' after ' + DateTimeToStr(Now());
    end else begin
      // All the flows are done
      Form1.Tim_WaitAfter.Enabled := False;
      runStopFlow := False;
      stopFlowThread.Terminate;
      Form1.Btn_StartFlow.Caption := 'Return to flow editor.';
      Form1.Lab_Status.Caption := 'Flow completed!';
    end;
  end;
end;
{$ENDREGION}


end.
