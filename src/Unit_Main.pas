unit Unit_Main;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{$REGION 'Units'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ActnList, Vcl.Menus, StrUtils,
  VCL.Themes, Vcl.StdActns, Vcl.Samples.Spin, Vcl.ComCtrls, System.Actions,

  Unit_AuxiliaryFunctions, Unit_CursorCheckThread, Unit_StopFlowThread, Unit_ConfigHandler, Unit_Scheduler,
  Unit_Status, Unit_StopCaptureThread, Unit_LinkedListHandler, Unit_HookHandler, Unit_FlowHandler,
  Unit_DataGenerator, Unit_Miner;
{$ENDREGION}
{$REGION 'Global Constants'}
const
  WM_KILLCONTROL = WM_USER + 1;
  CURRENT_VERSION = '1.5';
{$ENDREGION}

type

{$REGION 'Form - Main'}
  TForm1 = class(TForm)
    Btn_Add: TButton;
    Pnl_Cursor: TPanel;
    Lab_Cursor_Title: TLabel;
    Lab_Cursor_X: TLabel;
    Lab_Cursor_Y: TLabel;
    Btn_StartRecord: TButton;
    ActionList1: TActionList;
    Act_Hotkey_Record: TAction;
    Edt_Cursor_X: TEdit;
    MainMenu1: TMainMenu;
    About1: TMenuItem;
    Lab_Edt_Cursor_X: TLabel;
    Edt_Cursor_Y: TEdit;
    Lab_Edt_Cursor_Y: TLabel;
    Edt_WaitAfter: TEdit;
    Lab_Edt_WaitAfter: TLabel;
    CB_WaitAfter: TComboBox;
    InputType1: TMenuItem;
    Mouse1: TMenuItem;
    Key1: TMenuItem;
    Pnl_Mouse: TPanel;
    Btn_StartFlow: TButton;
    Btn_Dummy: TButton;
    Themes1: TMenuItem;
    Dummy1: TMenuItem;
    Pnl_Keyboard: TPanel;
    Edt_KeyboardInput: TEdit;
    Pnl_FlowStatus: TPanel;
    Lab_Status: TLabel;
    Tim_WaitAfter: TTimer;
    CB_ClickType: TComboBox;
    Lab_ClickType: TLabel;
    Lab_Button: TLabel;
    CB_MouseButton: TComboBox;
    Pnl_SpecialKeys: TPanel;
    RadGroup_SpecialKeys: TRadioGroup;
    Btn_SpecialKeys_Close: TButton;
    Btn_SpecialKeys_Open: TButton;
    Schedule1: TMenuItem;
    File1: TMenuItem;
    NewFlow1: TMenuItem;
    Load1: TMenuItem;
    Save1: TMenuItem;
    Pnl_Schedule: TPanel;
    Btn_Schedule_Close: TButton;
    TrayIcon1: TTrayIcon;
    SE_TotalRuns: TSpinEdit;
    Lab_FlowRunAmount: TLabel;
    Lab_WaitBetween: TLabel;
    Edt_WaitBetween: TEdit;
    CB_WaitBetween: TComboBox;
    N1: TMenuItem;
    Dummy2: TMenuItem;
    Tim_PostFormCreate: TTimer;
    CB_ExtraKey: TCheckBox;
    Edt_ExtraKey: TEdit;
    SB_Flow: TScrollBox;
    Btn_AddSchedule: TButton;
    DTP_ScheduleTime: TDateTimePicker;
    Edt_ScheduleFilePath: TEdit;
    Btn_BrowseSchF: TButton;
    CB_ScheduleFrequency: TComboBox;
    Lab_Frequency: TLabel;
    Lab_FrequencyAmount: TLabel;
    SE_FrequencyAmount: TSpinEdit;
    Lab_ScheduleTitle: TLabel;
    Pnl_Flow: TGridPanel;
    Pnl_Dummy: TPanel;
    StartRecordingInput1: TMenuItem;
    Tim_FlowGenerateDebugger: TTimer;
    GenerateData1: TMenuItem;
    Mining1: TMenuItem;
    Alphaminer1: TMenuItem;
    procedure Btn_StartRecordClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Act_Hotkey_RecordExecute(Sender: TObject);
    procedure Btn_AddClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DeleteStep(Sender: TObject);
    procedure Dummy1Click(Sender: TObject);
    procedure InputChangeClick(Sender: TObject);
    procedure Btn_StartFlowClick(Sender: TObject);
    procedure Tim_WaitAfterTimer(Sender: TObject);
    procedure Btn_SpecialKeys_OpenClick(Sender: TObject);
    procedure Btn_SpecialKeys_CloseClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Schedule1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Tim_PostFormCreateTimer(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure NewFlow1Click(Sender: TObject);
    procedure SE_TotalRunsChange(Sender: TObject);
    procedure Edt_WaitBetweenChange(Sender: TObject);
    procedure CB_WaitBetweenChange(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Btn_AddScheduleClick(Sender: TObject);
    procedure Btn_BrowseSchFClick(Sender: TObject);
    procedure CB_ScheduleFrequencyChange(Sender: TObject);
    procedure Pnl_DummyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Pnl_DummyMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StartRecordingInput1Click(Sender: TObject);
    procedure Tim_FlowGenerateDebuggerTimer(Sender: TObject);
    procedure GenerateData1Click(Sender: TObject);
    procedure Alphaminer1Click(Sender: TObject);
  protected
    procedure KillControl(var message: TMessage); message WM_KILLCONTROL;
    procedure WMSysCommand(var msg: TWMSysCommand); message WM_SYSCOMMAND;
    function GetControlUnderCursor(cursorX, cursorY : integer) : TControl;
  end;
  {$ENDREGION}

{$REGION 'Global variables'}
var
  Form1: TForm1;
  workDir : string;

  cursorThread : TCursorCheckThread;
  stopFlowThread : TStopFlowThread;
  stopCaptureThread: TStopCaptureThread;

  runCursorPos, runStopFlow, runStopCapture: boolean;
  flowHead : PFlowElement;
  currentStep : PFlowElement;
  currentRunId, totalRuns : integer;
  unsavedProgress : boolean;

  configFile : TConfigHandler;
  scheduler: TScheduleHandler;

  waitBetweenFlow : TWaitType;

  // Grid Panel control reorder
  sourceControl: TControl;
  sourceIndex, sourceRow, sourceCol: integer;

  // Input capture stuff
{$ENDREGION}

implementation

{$R *.dfm}

{$REGION '[Form - Flow panel] Get control under cursor'}
function TForm1.GetControlUnderCursor(cursorX: Integer; cursorY: Integer): TControl;
var
  rowPos, colPos : integer;
  // Height: 41
  // Width: 210
begin
  colPos := cursorX div 210;
  rowPos := cursorY div 41;
  Result := Pnl_Flow.ControlCollection.Controls[colPos, rowPos];
end;
{$ENDREGION}
{$REGION '[Form - Flow panel] Panel mouse down'}
procedure TForm1.Pnl_DummyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p : TPoint;
begin
  p := Mouse.CursorPos;
  p.X := p.X-3;
  p.Y := P.Y-3;
  p := Pnl_Flow.ScreenToClient(p);
  sourceControl := GetControlUnderCursor(p.X, p.Y);
  sourceIndex := Pnl_Flow.ControlCollection.IndexOf(sourceControl);
  sourceCol := Pnl_Flow.ControlCollection.Items[sourceIndex].Column;
  sourceRow := Pnl_Flow.ControlCollection.Items[sourceIndex].Row;
end;
{$ENDREGION}
{$REGION '[Form - Flow panel] Panel mouse up'}
procedure TForm1.Pnl_DummyMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  targetIndex, targetCol, targetRow: integer;
  targetControl : TControl;
  preSource, preTarget, sourceElement, targetElement, bufferElement : PFlowElement;
  bufferCaption: string;

begin
  // Find control in grid and replace
  p := Mouse.CursorPos;
  p.X := p.X-3;
  p.Y := P.Y-3;
  p := Pnl_Flow.ScreenToClient(p);
  targetControl := GetControlUnderCursor(p.X, p.Y);
  targetIndex := Pnl_Flow.ControlCollection.IndexOf(targetControl);
  if (targetIndex <> -1) and (sourceIndex <> targetIndex) then begin
    targetCol := Pnl_Flow.ControlCollection.Items[targetIndex].Column;
    targetRow := Pnl_Flow.ControlCollection.Items[targetIndex].Row;
    Pnl_Flow.ControlCollection.Items[sourceIndex].SetLocation(targetCol, targetRow, false);

    // Search source in linked list
    preSource := flowHead;
    while LeftStr(preSource.NextElement.panelObject.Caption,
          Length(preSource.NextElement.panelObject.Caption)-9) <>
          LeftStr(TPanel(sourceControl).Caption, Length(TPanel(sourceControl).Caption)-9) do
      preSource := preSource.NextElement;
    sourceElement := preSource.NextElement;

    // Search target in linked list
    preTarget := flowHead;
    while LeftStr(preTarget.NextElement.panelObject.Caption,
            Length(preTarget.NextElement.panelObject.Caption)-9) <>
          LeftStr(TPanel(targetControl).Caption, Length(TPanel(targetControl).Caption)-9) do
      preTarget := preTarget.NextElement;
    targetElement := preTarget.NextElement;

    // Reconnect linked list
    try
      preSource.NextElement := targetElement;
      preTarget.NextElement := sourceElement;

      bufferElement := sourceElement.NextElement;
      sourceElement.NextElement := targetElement.NextElement;
      targetElement.NextElement := bufferElement;

      // Replace panel captions
      bufferCaption := targetElement.panelObject.Caption;
      targetElement.panelObject.Caption := sourceElement.panelObject.Caption;
      sourceElement.panelObject.Caption := bufferCaption;

      // Rename buttons
      bufferCaption := targetElement.deleteButton.Name;
      targetElement.deleteButton.Name := sourceElement.deleteButton.Name + 'a';
      sourceElement.deleteButton.Name := bufferCaption;
      targetElement.deleteButton.Name := LeftStr(targetElement.deleteButton.Name,
        Length(targetElement.deleteButton.Name)-1);

    except
      raise Exception.Create('Exception raised: Linked list reconnection' + sLineBreak +
                             sLineBreak +
                             'preTargetFlowElement: ' + preTarget.panelObject.Caption + sLineBreak +
                             'TargetControl: ' + TPanel(targetControl).Caption + sLineBreak +
                             'preSourceFlowElement: ' + preSource.panelObject.Caption + sLineBreak +
                             'SourceControl: ' + TPanel(sourceControl).Caption);
    end;
  end;
end;
{$ENDREGION}
{$REGION '[Form - Flow panel] Kill control'}
procedure TForm1.KillControl(var message: TMessage);
var
  control: TControl;
  p: TPanel;
  i : integer;
  tarRow, tarCol, pid: integer;
begin
  control := TObject(message.LParam) as TControl;
  p := TPanel(control);
  // Free children
  try
    while p.ControlCount>0 do
      p.Controls[0].Free;
  except
    on e: exception do begin
      raise Exception.Create('Failed to delete panel: '+e.Message);
    end;
  end;
  // Free object
  control.Free;
  for i := 0 to Pnl_Flow.ControlCollection.Count-1 do begin

    pid := StrToInt(LeftStr(TPanel(Pnl_Flow.ControlCollection.Items[i].Control).Caption,
      Length(TPanel(Pnl_Flow.ControlCollection.Items[i].Control).Caption)-10));

    pid := pid-1;
    tarCol := pid div 8;
    tarRow := pid mod 8;
    Pnl_Flow.ControlCollection.Items[i].SetLocation(tarCol, tarRow, false);
  end;
end;
{$ENDREGION}
{$REGION '[Form - Flow panel] Delete step'}
procedure TForm1.DeleteStep(Sender: TObject);
var
  id, i: integer;
  tempString : string;
  flowElement, tempElement : PFlowElement;
begin

  // Get button ID
  id := StrToInt(RightStr(TButton(Sender).Name, Length(TButton(Sender).Name)-11));

  // Find button in the list by ID
  flowElement := flowHead;
  repeat
    // Extract button ID from list element
    tempString := RightStr(flowElement.NextElement.deleteButton.Name, Length(flowElement.NextElement.deleteButton.Name)-11);
    // Button found (?)
    if tempString = IntToStr(id) then begin
      // Button is found
      if flowElement.NextElement.NextElement = nil then begin
        // Delete last element from list
        PostMessage(self.Handle, WM_KILLCONTROL, 0, integer(flowElement.NextElement.panelObject));
        flowElement.NextElement := nil;
      end else begin
        // Rebind list and delete sender element
        tempElement := flowElement.NextElement;
        flowElement.NextElement := flowElement.NextElement.NextElement;
        PostMessage(self.Handle, WM_KILLCONTROL, 0, integer(tempElement.panelObject));
      end;
    end else
      // Button not found yet
      flowElement := flowElement.NextElement;
  until (flowElement.NextElement = nil) or (tempString = IntToStr(id));

  // Reconfigure list element button IDs
  if flowhead.NextElement <> nil then begin
    flowElement := flowHead;
    i := 1;

    while (flowElement.NextElement <> nil) do begin
      flowElement := flowElement.NextElement;
      flowElement.deleteButton.Name := 'flowButton_'+IntToStr(i);
      flowElement.panelObject.Caption := IntToStr(i) +  '.         ';
      i := i+1;
    end;
    Pnl_Flow.Width :=  ((((i-2) div 8) + 1)  *flowElement.panelObject.Width) + 5;
  end;
end;
{$ENDREGION}
{$REGION '[Form - Flow Panel] Add Element'}
procedure TForm1.Btn_AddClick(Sender: TObject);
var
  newLinkElement, test : PFlowElement;
  i : integer;
  canCreate : boolean;
  newPanelColumn : TColumnItem;
begin
  canCreate := False;

  // Check if there are enough parameters
  if Pnl_Mouse.Visible then begin
    // Input type: Mouse
    if (Edt_Cursor_X.Text <> '') and (Edt_Cursor_Y.Text <> '') then
      canCreate := True
    else
      showmessage('Not enough actual parameters.');
  end else if Pnl_SpecialKeys.Visible then begin
    // Input type: Special Key
    if RadGroup_SpecialKeys.ItemIndex <> -1 then
      canCreate := True
    else
      showmessage('Not enough actual parameters.');
  end else if Pnl_Keyboard.Visible then begin
    // Input type: Keyboard
    canCreate := True;
  end;

  if canCreate then begin
    // Find the end of the linked list
    test := flowHead;
    i := 1;
    while (test.NextElement <> nil) do begin
      test := test.NextElement;
      i := i+1;
    end;

    // Create new element then add it to the end of the list
    newLinkElement := new(PFlowElement);
    test.NextElement := newLinkElement;
    newLinkElement.nextElement := nil;

    // Create Panel & expand flow panel
    newLinkElement.panelObject := TPanel.Create(Pnl_Flow);

    if (i mod 8) = 0 then begin
      newPanelColumn := Pnl_Flow.ColumnCollection.Add();
      newPanelColumn.SizeStyle := ssAuto;
    end;
    Pnl_Flow.ControlCollection.AddControl(newLinkElement.panelObject, ((i-1) div 8), ((i-1) mod 8));
    newLinkElement.panelObject.Parent := Pnl_Flow;
    newLinkElement.panelObject.Alignment := taRightJustify;
    newLinkElement.panelObject.Font.Style := [fsBold];
    newLinkElement.panelObject.Font.Size := 12;
    newLinkElement.panelObject.Caption := IntToStr(i) +  '.         ';
    newLinkElement.panelObject.Width := 210;
    newLinkElement.panelObject.OnMouseDown := Pnl_Dummy.OnMouseDown;
    newLinkElement.panelObject.OnMouseUp := Pnl_Dummy.OnMouseUp;

    // Create Button
    newLinkElement.deleteButton := TButton.Create(newLinkElement.panelObject);
    newLinkElement.deleteButton.Parent := newLinkElement.panelObject;
    newLinkElement.deleteButton.Font.Style := [];
    newLinkElement.deleteButton.Font.Size := 8;
    newLinkElement.deleteButton.Caption := 'Delete';
    newLinkElement.deleteButton.Align := alRight;
    newLinkElement.deleteButton.Anchors := [akRight, akTop, akBottom];
    newLinkElement.deleteButton.Width := 40;
    newLinkElement.deleteButton.Name := 'flowButton_'+IntToStr(i);
    newLinkElement.deleteButton.OnClick := Btn_Dummy.OnClick;

    // Create Label
    newLinkElement.labelObject := TLabel.Create(newLinkElement.panelObject);
    newLinkElement.labelObject.Parent := newLinkElement.panelObject;
    newLinkElement.labelObject.Font.Style := [];
    newLinkElement.labelObject.Font.Size := 8;
    newLinkElement.labelObject.OnMouseDown := Pnl_Dummy.OnMouseDown;
    newLinkElement.labelObject.OnMouseUp := Pnl_Dummy.OnMouseUp;

    // Set wait time
    newLinkElement.waitAfterAmount := StrToInt(Edt_WaitAfter.Text);
    newLinkElement.waitAfterTypeText := CB_WaitAfter.Text;
    if CB_WaitAfter.ItemIndex = 0 then
      newLinkElement.waitAfterType := wtMil
    else if CB_WaitAfter.ItemIndex = 1 then
      newLinkElement.waitAfterType := wtSec
    else if CB_WaitAfter.ItemIndex = 2 then
      newLinkElement.waitAfterType := wtMin
    else if CB_WaitAfter.ItemIndex = 3 then
      newLinkElement.waitAfterType := wtHour
    else
      showmessage('ERROR SETTING TIME! DO NOT START THE FLOW!');

    if Pnl_Mouse.Visible then begin
      // Input type: Mouse
      newLinkElement.inputType := itClick;
      newLinkElement.inputParam1 := Edt_Cursor_X.Text;
      newLinkElement.inputParam2 := Edt_Cursor_Y.Text;
      newLinkElement.inputParam3 := CB_MouseButton.Text;
      newLinkElement.inputParam4 := CB_ClickType.Text;
      newLinkElement.labelObject.Caption :=
        'Type: ' + CB_MouseButton.Text + ' ' + CB_ClickType.Text + sLineBreak +
        'x: ' + Edt_Cursor_X.Text + ', y: ' + Edt_Cursor_Y.Text + sLineBreak +
        'wait ' + Edt_WaitAfter.Text + ' ' + LowerCase(CB_WaitAfter.Text);
    end else if Pnl_SpecialKeys.Visible then begin
      // Input type: Hotkey
      if CB_ExtraKey.Checked then begin
        if RadGroup_SpecialKeys.ItemIndex <> -1 then begin
          newLinkElement.inputType := itHotkey;
          newLinkElement.inputParam1 := RadGroup_SpecialKeys.Buttons[RadGroup_SpecialKeys.ItemIndex].Caption;
          newLinkElement.inputParam2 := Edt_ExtraKey.Text;
          newLinkElement.labelObject.Caption :=
            'Type: Hotkey' + sLineBreak +
            'Key: ' + newLinkElement.inputParam1 + ' + ' + newLinkElement.inputParam2 + sLineBreak +
            'wait ' + Edt_WaitAfter.Text + ' ' + LowerCase(CB_WaitAfter.Text);
          Pnl_SpecialKeys.Visible := False;
        end;
      end else begin
        // Input type: Special Key
        if RadGroup_SpecialKeys.ItemIndex <> -1 then begin
          newLinkElement.inputType := itSpecialKey;
          newLinkElement.inputParam1 := RadGroup_SpecialKeys.Buttons[RadGroup_SpecialKeys.ItemIndex].Caption;
          newLinkElement.labelObject.Caption :=
            'Type: Special Key' + sLineBreak +
            'Key: ' + newLinkElement.inputParam1 + sLineBreak +
            'wait ' + Edt_WaitAfter.Text + ' ' + LowerCase(CB_WaitAfter.Text);
          Pnl_SpecialKeys.Visible := False;
        end;
      end;
    end else if Pnl_Keyboard.Visible then begin
      newLinkElement.inputType := itKeyboard;
      newLinkElement.inputParam1 := Edt_KeyboardInput.Text;
      if Length(Edt_KeyboardInput.Text) > 15 then begin
        newLinkElement.labelObject.Hint := Edt_KeyboardInput.Text;
        newLinkElement.labelObject.ShowHint := True;
        newLinkElement.labelObject.Caption :=
          'Type: Keyboard Input' + sLineBreak +
          'Input: ' + LeftStr(Edt_KeyboardInput.Text,12) + '...*' + sLineBreak +
          'wait ' + Edt_WaitAfter.Text + ' ' + LowerCase(CB_WaitAfter.Text)
      end else begin
        newLinkElement.labelObject.Caption :=
          'Type: Keyboard Input' + sLineBreak +
          'Input: ' + Edt_KeyboardInput.Text + sLineBreak +
          'wait ' + Edt_WaitAfter.Text + ' ' + LowerCase(CB_WaitAfter.Text);
      end;
      Edt_KeyboardInput.Text := '';
    end;
    unsavedProgress := true;
    Pnl_Flow.Width :=  ((((i-1) div 8) + 1)  * newLinkElement.panelObject.Width) + 5;
  end;
end;
{$ENDREGION}

{$REGION '[Form - System Message] Minimize'}
procedure TForm1.WMSysCommand(var msg: TWmSysCommand);
begin
  if msg.CmdType = SC_MINIMIZE then begin
    Form1.WindowState := wsMinimized;

    TrayIcon1.Visible := True;
    TrayIcon1.Animate := True;
    TrayIcon1.ShowBalloonHint;
  end;

  inherited;
end;
{$ENDREGION}

{$REGION '[Form - Hotkey] - "R"'}
procedure TForm1.Act_Hotkey_RecordExecute(Sender: TObject);
begin
  Btn_StartRecordClick(Form1);
end;
{$ENDREGION}

{$REGION '[Form - Events] OnClose'}
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  runCursorPos := false;
  Form_Status.Close;
  Form_Generator.Close;
end;
{$ENDREGION}
{$REGION '[Form - Events] OnResize'}
procedure TForm1.FormResize(Sender: TObject);
begin
  Pnl_Flow.Realign;
end;
{$ENDREGION}

{$REGION '[Form - menu click] Alphaminer1 Click'}
procedure TForm1.Alphaminer1Click(Sender: TObject);
begin
  Form_Miner.Show;
end;
{$ENDREGION}
{$REGION '[Form - menu click] Generate data Click'}
procedure TForm1.GenerateData1Click(Sender: TObject);
begin
  Form_Generator.Show;
end;
{$ENDREGION}
{$REGION '[Form - menu click] Input Change Click'}
procedure TForm1.InputChangeClick(Sender: TObject);
var
  selected : TPanel;
begin
  Lab_Edt_WaitAfter.Visible := True;
  Pnl_Schedule.Visible := False;
  Act_Hotkey_Record.Enabled := False;
  if Key1.Checked then
    selected := Pnl_Keyboard
  else begin
    Act_Hotkey_Record.Enabled := True;
    selected := Pnl_Mouse;
  end;

  Pnl_Keyboard.Visible := False;
  Pnl_Mouse.Visible := False;

  selected.Visible := True;

end;
{$ENDREGION}
{$REGION '[Form - menu click] About Click'}
procedure TForm1.About1Click(Sender: TObject);
begin
  showmessage('Szakdolgozat v' + CURRENT_VERSION +  sLineBreak +
              'Application design and coding by Pázmándi Erik: pazmandi.erik@gmail.com');
end;
{$ENDREGION}
{$REGION '[Form - menu click] Tray Icon Double Click'}
procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;
{$ENDREGION}
{$REGION '[Form - menu click] Dummy1 Click (Set Style)'}
procedure TForm1.Dummy1Click(Sender: TObject);
begin
  TStyleManager.SetStyle(TMenuItem(Sender).Caption);
  ConfigFile.Save('Style',TMenuItem(Sender).Caption);
end;
{$ENDREGION}
{$REGION '[Form - menu click] Schedule1 Click'}
procedure TForm1.Schedule1Click(Sender: TObject);
begin
  Pnl_Schedule.BringToFront;
  Lab_Edt_WaitAfter.Visible := False;
  Pnl_Schedule.Visible := True;
  Pnl_Schedule.SetFocus();
end;
{$ENDREGION}
{$REGION '[Form - menu click] Save1Click'}
procedure TForm1.Save1Click(Sender: TObject);
begin
  SaveFlow();
end;
{$ENDREGION}
{$REGION '[Form - menu click] Load1 Click'}
procedure TForm1.Load1Click(Sender: TObject);
begin
  LoadFlow('user');
end;
{$ENDREGION}
{$REGION '[Form - menu click] New1 Click'}
procedure TForm1.NewFlow1Click(Sender: TObject);
begin
  ClearLinkedList();
end;
{$ENDREGION}
{$REGION '[Form - menu click] StartRecordingInput1 Click'}
procedure TForm1.StartRecordingInput1Click(Sender: TObject);
begin
  StartRecordingInput1.Tag := (StartRecordingInput1.Tag + 1) mod 2;
  if StartRecordingInput1.Tag = 1 then begin
    // Keyboard hook
    if not StartKBHook_CaptureInput then
      Exception.Create('Error starting keyboard hook!');
    // Mouse hook
    if not StartMouseHook_CaptureInput then
      Exception.Create('Error starting mouse hook!');
    // UI update
    StartRecordingInput1.Caption := 'Stop recording input';
    // Start stopwatch
    stopWatch.Start;
    // Change main form for minimization purposes
    Form_Status.Show();
    // Start hotkey thread for stopping capture
    stopCaptureThread := TStopCaptureThread.Create();
    runStopCapture := True;
  end else begin
    // Mouse hook
    if not StopMouseHook_CaptureInput then
      Exception.Create('Error stoppping mouse hook!');
    // Keyboard hook
    if not StopKBHook_CaptureInput then
      Exception.Create('Error stoppping keyboard hook!');
    // UI update
    StartRecordingInput1.Caption := 'Start recording input';
    // Reset stopwatch
    stopWatch.Reset;
    // Change main form for minimization purposes
    Form_Status.Hide();
    // Generate flow
    GenerateFlow();
    unsavedProgress := True;
  end;
end;
{$ENDREGION}

{$REGION '[Form] Edit_WaitBetween Change'}
procedure TForm1.Edt_WaitBetweenChange(Sender: TObject);
begin
 unsavedProgress := true;
end;
{$ENDREGION}
{$REGION '[Form] CB_WaitBetween Change'}
procedure TForm1.CB_WaitBetweenChange(Sender: TObject);
begin
  unsavedProgress := true;
end;
{$ENDREGION}
{$REGION '[Form] CB_ScheduleFrequency Change'}
procedure TForm1.CB_ScheduleFrequencyChange(Sender: TObject);
begin
  SE_FrequencyAmount.Enabled := True;
  SE_FrequencyAmount.Text := '1';
  case CB_ScheduleFrequency.ItemIndex of
    0: SE_FrequencyAmount.MaxValue := 1439;
    1: SE_FrequencyAmount.MaxValue := 23;
    2: SE_FrequencyAmount.MaxValue := 365;
    3: SE_FrequencyAmount.MaxValue := 52;
    4: SE_FrequencyAmount.MaxValue := 12;
    5: begin
      SE_FrequencyAmount.MaxValue := 1;
      SE_FrequencyAmount.Enabled := False;
    end;
    6: begin
      SE_FrequencyAmount.MaxValue := 1;
      SE_FrequencyAmount.Enabled := False;
    end;
  end;
end;
{$ENDREGION}
{$REGION '[Form] Btn_StartRecord Click (Mouse recording)'}
procedure TForm1.Btn_StartRecordClick(Sender: TObject);
var
  recordButton : TButton;
  i : integer;
begin
  // Find Button
  recordButton := nil;
  for i := 0 to Form1.ComponentCount-1 do
    if (Form1.Components[i].Name = 'Btn_StopRecord') or (Form1.Components[i].Name = 'Btn_StartRecord') then
      recordButton := TButton(Form1.Components[i]);

  if not (runCursorPos) and (recordButton <> nil) then begin
    runCursorPos := true;
    cursorThread := TCursorCheckThread.Create();
    recordButton.Caption := 'Stop recording (R)';
    recordButton.Name := 'Btn_StopRecord';
  end else begin
    cursorThread.Terminate;
    runCursorPos := false;
    recordButton.Caption := 'Start recording (R)';
    recordButton.Name := 'Btn_StartRecord';
    Edt_Cursor_X.Text := RightStr(Lab_Cursor_X.Caption, Length(Lab_Cursor_X.Caption)-3);
    Edt_Cursor_Y.Text := RightStr(Lab_Cursor_Y.Caption, Length(Lab_Cursor_Y.Caption)-3);
  end;
end;
{$ENDREGION}
{$REGION '[Form] Btn_SpecialKeys_Close Click'}
procedure TForm1.Btn_SpecialKeys_CloseClick(Sender: TObject);
begin
  Lab_Edt_WaitAfter.Visible := True;
  Pnl_SpecialKeys.Visible := False;
  Pnl_Schedule.Visible := False;
end;
{$ENDREGION}
{$REGION '[Form] Btn_SpecialKeys_Open Click'}
procedure TForm1.Btn_SpecialKeys_OpenClick(Sender: TObject);
begin
  Pnl_SpecialKeys.Visible := True;
  Pnl_SpecialKeys.BringToFront();
end;
{$ENDREGION}
{$REGION '[Form] Btn_StartFlow Click'}
procedure TForm1.Btn_StartFlowClick(Sender: TObject);
var
  menuItem : TMenuItem;
  flowElement : PFlowElement;
  i : integer;
  flowButton : TButton;
begin
  // Check if flow is empty
  flowElement := flowHead;
  if flowElement.NextElement = nil then
    showmessage('Flow is empty.')
  else begin

    // Init wait time
    if CB_WaitAfter.ItemIndex = 0 then
      waitBetweenFlow := wtMil
    else if CB_WaitAfter.ItemIndex = 1 then
      waitBetweenFlow := wtSec
    else if CB_WaitAfter.ItemIndex = 2 then
      waitBetweenFlow := wtMin
    else if CB_WaitAfter.ItemIndex = 3 then
      waitBetweenFlow := wtHour
    else
      showmessage('ERROR SETTING TIME! DO NOT START THE FLOW!');

    // Find Button
    flowButton := nil;
    for i := 0 to Form1.ComponentCount-1 do
      if (Form1.Components[i].Name = 'Btn_HaltFlow') or (Form1.Components[i].Name = 'Btn_StartFlow') then
        flowButton := TButton(Form1.Components[i]);


    // Check if flow is started
    if (flowButton.Name = 'Btn_StartFlow') and (flowButton <> nil) then begin

      // Swap controls
      flowButton.Name := 'Btn_HaltFlow';
      flowButton.Caption := 'Stop flow';
      Btn_Add.Visible := False;
      Pnl_Keyboard.Visible := False;
      Pnl_Mouse.Visible := False;
      CB_WaitAfter.Visible := False;
      Lab_Edt_WaitAfter.Visible := False;
      Edt_WaitAfter.Visible := False;
      Pnl_SpecialKeys.Visible := False;
      Pnl_FlowStatus.Visible := True;

      // Disable menu
      for menuItem in MainMenu1.Items do
        menuItem.Enabled := false;

      // Disable delete buttons on flow element panels
      while flowElement.NextElement <> nil do begin
        flowElement := flowElement.NextElement;
        flowElement.deleteButton.Enabled := False;
      end;

      // Start Flow
      currentRunId := 1;
      totalRuns := SE_TotalRuns.Value;
      Lab_Status.Caption := 'Next step: 1.';
      currentStep := flowHead.NextElement;
      Tim_WaitAfter.Enabled := True;
      stopFlowThread := TStopFlowThread.Create;
      runStopFlow := true;

    // Flow is started
    end else begin

      // Stop Flow
      Lab_Status.Caption := 'Stopping...';
      Tim_WaitAfter.Enabled := False;
      runStopFlow := False;
      stopFlowThread.Terminate;
//      stopFlowThread.Free;
      // Swap controls
      flowButton.Name := 'Btn_StartFlow';
      flowButton.Caption := 'Start flow';
      Pnl_FlowStatus.Visible := False;
      Btn_Add.Visible:= True;
      Pnl_Mouse.Visible := True;
      Mouse1.Checked := True;
      CB_WaitAfter.Visible := True;
      Lab_Edt_WaitAfter.Visible := True;
      Edt_WaitAfter.Visible := True;
      Act_Hotkey_Record.Enabled := True;

      // Enable menu
      for menuItem in MainMenu1.Items do
        menuItem.Enabled := true;

      // Re-enable delete buttons on flow element panels
      while flowElement.NextElement <> nil do begin
        flowElement := flowElement.NextElement;
        flowElement.deleteButton.Enabled := True;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION '[Form] SpinEdit_TotalRuns Change'}
procedure TForm1.SE_TotalRunsChange(Sender: TObject);
begin
  unsavedProgress := true;
end;
{$ENDREGION}

{$REGION '[Form - Schedule] Add'}
procedure TForm1.Btn_AddScheduleClick(Sender: TObject);
const
  cnMaxUserNameLen = 254;
var
  scSchedule : string;
begin
  if RightStr(Edt_ScheduleFilePath.Text, 4) = '.sdf' then begin

    // Get modifier
    case CB_ScheduleFrequency.ItemIndex of                             //  /rl highest
      0: scSchedule := '/sc "MINUTE" /mo '+ SE_FrequencyAmount.Text + ' /st "' + formatdatetime('hh:mm' ,DTP_ScheduleTime.Time) +'"';
      1: scSchedule := '/sc "HOURLY" /mo '+ SE_FrequencyAmount.Text + ' /st "' + formatdatetime('hh:mm' ,DTP_ScheduleTime.Time) +'"';
      2: scSchedule := '/sc "DAILY" /mo '+ SE_FrequencyAmount.Text + ' /st "' + formatdatetime('hh:mm' ,DTP_ScheduleTime.Time) +'"';
      3: scSchedule := '/sc "WEEKLY" /mo '+ SE_FrequencyAmount.Text + ' /st "' + formatdatetime('hh:mm' ,DTP_ScheduleTime.Time) +'"';
      4: scSchedule := '/sc "MONTHLY" /mo '+ SE_FrequencyAmount.Text + ' /st "' + formatdatetime('hh:mm' ,DTP_ScheduleTime.Time) +'"';
      5: scSchedule := '/sc "ONCE"';
      6: scSchedule := '/sc "ONLOGON"';
      else showmessage('Error! Cannot get modifiers!');
    end;

     scheduler.DeleteTask('szd_'+ ExtractFileName(Edt_ScheduleFilePath.Text));
     scheduler.AddTask(
      'szd_' + ExtractFileName(Edt_ScheduleFilePath.Text),
      workDir + '\Szakdolgozat.exe ' + Edt_ScheduleFilePath.Text + '" ' + scSchedule
     );

  end else begin
    showmessage('You must select a flow!');
  end;
end;
{$ENDREGION}
{$REGION '[Form - Schedule] Browse'}
procedure TForm1.Btn_BrowseSchFClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
    try
      Options := [fdoStrictFileTypes];
      if Execute then begin
        Edt_ScheduleFilePath.Text := FileName;
      end;
    finally
      Free;
    end
end;
{$ENDREGION}

{$REGION '[Form - Timer] Process Flow Element (Wait after)'}
procedure TForm1.Tim_WaitAfterTimer(Sender: TObject);
begin
  ProcessFlowElement();
end;
{$ENDREGION}
{$REGION '[Form - Timer] Flow generation debugger'}
procedure TForm1.Tim_FlowGenerateDebuggerTimer(Sender: TObject);
begin
  Tim_FlowGenerateDebugger.Enabled := False;
  Form1.StartRecordingInput1Click(Form1);
end;
{$ENDREGION}
{$REGION '[Form - Timer] Post Form Create'}
procedure TForm1.Tim_PostFormCreateTimer(Sender: TObject);
var
  styleName : string;
  newMenuItem : TMenuItem;
  MyIcon : TIcon;

  styleNames: TStringList;

begin
  //Misc init
  Tim_PostFormCreate.Enabled := False;
  unsavedProgress := False;
  workDir := ExpandFileName(ExtractFileDir(Application.ExeName));
  flowHead := new(PFlowElement);
  flowHead.nextElement := nil;
  flowHead.waitAfterAmount := 2;
  flowHead.waitAfterTypeText := 'Seconds';
  flowHead.waitAfterType := wtSec;
  DTP_ScheduleTime.Time := Now();

  //Place objects in place and properly resize
  SB_Flow.Top := 0;
  SB_Flow.Left := 0;
  SB_Flow.Height := 360;
  SB_Flow.Width := 587;

  Btn_StartFlow.Top := SB_Flow.Height;
  Btn_StartFlow.Left := 0;
  Btn_StartFlow.Height := 36;
  Btn_StartFlow.Width := 570;

  Pnl_Mouse.Top := SB_Flow.Height + Btn_StartFlow.Height;
  Pnl_Mouse.Left := 0;
  Pnl_Mouse.Height := 120;
  Pnl_Mouse.Width := 587;

  Pnl_Keyboard.Top := SB_Flow.Height + Btn_StartFlow.Height;
  Pnl_Keyboard.Left := 0;
  Pnl_Keyboard.Height := 120;
  Pnl_Keyboard.Width := 587;

  Pnl_FlowStatus.Top := SB_Flow.Height + Btn_StartFlow.Height;
  Pnl_FlowStatus.Left := 0;
  Pnl_FlowStatus.Height := 120;
  Pnl_FlowStatus.Width := 587;

  Pnl_Schedule.Top := 0;
  Pnl_Schedule.Left := 0;
  Pnl_Schedule.Height := Form1.Height;
  Pnl_Schedule.Width := Form1.Width;

  Lab_Cursor_Title.Top := 0;;
  Lab_Cursor_Title.Left := 0;
  Lab_Cursor_Title.Width := Pnl_Cursor.Width;

  Lab_Cursor_X.Left := 10;
  Lab_Cursor_Y.Left := 10;

  Lab_Cursor_X.Top := 20;
  Lab_Cursor_Y.Top := 35;

  Lab_Cursor_X.Width := Pnl_Cursor.Width-10;
  Lab_Cursor_Y.Width := Pnl_Cursor.Width-10;
  Btn_StartFlow.BringToFront;

  // Init scheduler
  scheduler := TScheduleHandler.Create;

  // Load config file
  if not System.SysUtils.DirectoryExists(workDir + '\Data\') then
    CreateDir(workDir + '\Data');
  configFile := TConfigHandler.Create(workDir+'\Data\mainConfig.ini');

  Form_Miner.Edt_DataPath.Text := configFile.Load('alphaminer_datapath', 'C:\');

    //Load style
  TStyleManager.TrySetStyle(ConfigFile.Load('Style', 'Aqua Graphite'));

  // System tray stuff
  TrayIcon1.Icons := TImageList.Create(Self);
  MyIcon := TIcon.Create;
  TrayIcon1.Icon.Assign(MyIcon);
  TrayIcon1.Icons.AddIcon(MyIcon);
  TrayIcon1.Hint := 'Double click to restore the window.';
  TrayIcon1.AnimateInterval := 200;
  TrayIcon1.BalloonTitle := 'Szakdolgozat is now minimized.';
  TrayIcon1.BalloonHint := 'Double click the system tray icon to restore the window.';
  TrayIcon1.BalloonFlags := bfInfo;

  //Init initial selections
  Pnl_Mouse.Visible := True;
  Pnl_Keyboard.Visible := False;
  Pnl_SpecialKeys.Visible := False;
  Pnl_Schedule.Visible := False;
  CB_WaitAfter.Text := 'Seconds';

  //Init form caption
  Form1.Caption := 'Szakdolgozat v' + CURRENT_VERSION;

  //Copy styles to StringList
  styleNames := TStringList.Create;
  for styleName in TStyleManager.StyleNames do begin
    styleNames.Add(styleName)
  end;
  //Sort styles
  styleNames.Sort;
  //Init styles
  for styleName in styleNames do begin
    newMenuItem := TMenuItem.Create(Themes1);
    newMenuItem.SetParentComponent(Themes1);
    newMenuItem.Caption := styleName;
    newMenuItem.RadioItem := True;
    newMenuItem.OnClick := Dummy1.OnClick;
    newMenuItem.AutoCheck := True;
    newMenuItem.Tag := 1;
    if styleName = TStyleManager.ActiveStyle.Name then
      newMenuItem.Checked := True;
  end;
  styleNames.Free;
  Form1.Show();

  if ParamCount > 0 then begin
    LoadFlow(ParamStr(1));
    Btn_StartFlowClick(Form1);
  end;
end;
{$ENDREGION}

end.
