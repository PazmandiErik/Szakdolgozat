unit Unit_Main;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

{$REGION 'Units'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus,

  StrUtils, VCL.Themes, Vcl.ClipBrd, Vcl.StdActns, Vcl.AppEvnts, Vcl.Samples.Spin, System.Types, System.IOUtils,
  Vcl.ComCtrls, Typinfo, System.UITypes, ShellAPI, Unit_ConfigHandler, Unit_Scheduler, System.Diagnostics;
{$ENDREGION}
{$REGION 'Global Constants'}
const
  WM_KILLCONTROL = WM_USER + 1;
  CURRENT_VERSION = '1.2';
{$ENDREGION}

type

  {$REGION 'Enumerations'}
  TInputType = (itClick, itKeyboard, itSpecialKey, itHotkey);
  TWaitType = (wtMil, wtSec, wtMin, wtHour);
  {$ENDREGION}
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
  private
    function StartKBHook_CaptureInput(): boolean;
    function StopKBHook_CaptureInput(): boolean;
    function KBHookIsStarted_CaptureInput(): boolean;
    function StartMouseHook_CaptureInput(): boolean;
    function StopMouseHook_CaptureInput(): boolean;
    function MouseHook_IsStarted(): boolean;

  protected
    procedure KillControl(var message: TMessage); message WM_KILLCONTROL;
    procedure WMSysCommand(var msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure LoadFlow(caller: string);
    function ClearLinkedList(): integer;
    function MatchStringToVirtualKey(str : string): Byte;
    function GetControlUnderCursor(cursorX, cursorY : integer) : TControl;
    function SplitTempFlowLine(stringToSplit: string): string;
    procedure MatchMessageToMouseClick(WM: string; var mouseButton, clickType: string);
    function IsSpecialKey(key: string): boolean;
  public
    procedure StopFlow();
    procedure GenerateFlow();
  end;
  {$ENDREGION}
  {$REGION 'Thread - Cursor location'}
  TCursorCheckThread = class(TThread)
    procedure Execute; override;
  end;
  {$ENDREGION}
  {$REGION 'Thread - Stop flow'}
  TStopFlowThread = class(TThread)
    public
      procedure Execute(); override;
      constructor Create;
  end;
  {$ENDREGION}
  {$REGION 'Thread - Stop input capture'}
  TStopCaptureThread = class(TThread)
    public
      procedure Execute(); override;
      constructor Create;
  end;
  {$ENDREGION}
  {$REGION 'Linked list types'}
  // Linked List pointer type
  PFlowElement = ^TFlowElement;

  // Linked List element
  TFlowElement = record
    inputType : TInputType;
    inputParam1 : string;
    inputParam2 : string;
    inputParam3 : string;
    inputParam4 : string;
    waitAfterAmount : integer;
    waitAfterType : TWaitType;
    waitAfterTypeText : string;
    deleteButton : TButton;
    panelObject : TPanel;
    labelObject : TLabel;
    NextElement : PFlowElement;
  end;
  {$ENDREGION}
  {$REGION 'Packed record - Keyboard hook'}
  PKBDLLHOOKSTRUCT = ^TKBDLLHOOKSTRUCT;
  TKBDLLHOOKSTRUCT = packed record
    vkCode: DWORD;
    scanCode: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: DWORD;
  end;
  {$ENDREGION}
  {$REGION 'Packed record - Mouse hook'}
  PMSLLHOOKSTRUCT = ^TMSLLHOOKSTRUCT;
  TMSLLHOOKSTRUCT = packed record
    pt: TPoint;
    mouseData: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
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
  rawCaptureData: TStringList;
  stopWatch: TStopWatch;
  // Mouse & KB Hooks
  llKeyboardHookHotkeys: HHOOK = 0;
  llKeyboardHookCaptureInput: HHOOK = 0;
  KeyBoardState: TKeyboardState;
  KeyBoardLayOut: HKL;
  doublePressDebug: boolean;
  mouseHook: HHOOK = 0;
  runningScreenShotThreads: integer;
{$ENDREGION}

implementation

{$R *.dfm}

uses Unit_Status;

{$REGION '[HOOK] TRANSLATE VIRTUAL KEY'}
function TranslateVirtualKey(VirtualKey: integer): WideString;
begin
  Result := '[UNKNOWN VIRTUAL KEY]';
  case VirtualKey of
    VK_RETURN:   Result := '[Enter]';
    VK_TAB:      Result := '[Tab]';
    VK_BACK:     Result := '[Backspace]';
    VK_SHIFT,
    160:         Result := '[Left Shift]';
    VK_CONTROL,
    162:         Result := '[Left Ctrl]';
    VK_MENU,
    164:         Result := '[Left Alt]';
    VK_ESCAPE:   Result := '[Escape]';
    VK_PAUSE:    Result := '[Pause]';
    VK_CAPITAL:  Result := '[Caps Lock]';
    VK_PRIOR:    Result := '[Page Up]';
    VK_NEXT:     Result := '[Page Down]';
    VK_END:      Result := '[End]';
    VK_HOME:     Result := '[Home]';
    VK_LEFT:     Result := '[Arrow: Left]';
    VK_UP:       Result := '[Arrow: Up]';
    VK_RIGHT:    Result := '[Arrow: Right]';
    VK_DOWN:     Result := '[Arrow: Down]';
    VK_SELECT:   Result := '[Select]';
    VK_PRINT:    Result := '[Print Screen]';
    VK_EXECUTE:  Result := '[Execute]';
    VK_SNAPSHOT: Result := '[PrtSc]';
    VK_INSERT:   Result := '[Ins]';
    VK_DELETE:   Result := '[Delete]';
    VK_HELP:     Result := '[Help]';
    VK_F1:       Result := '[F1]';
    VK_F2:       Result := '[F2]';
    VK_F3:       Result := '[F3]';
    VK_F4:       Result := '[F4]';
    VK_F5:       Result := '[F5]';
    VK_F6:       Result := '[F6]';
    VK_F7:       Result := '[F7]';
    VK_F8:       Result := '[F8]';
    VK_F9:       Result := '[F9]';
    VK_F10:      Result := '[F10]';
    VK_F11:      Result := '[F11]';
    VK_F12:      Result := '[F12]';
    VK_NUMPAD0:  Result := '[0]';
    VK_NUMPAD1:  Result := '[1]';
    VK_NUMPAD2:  Result := '[2]';
    VK_NUMPAD3:  Result := '[3]';
    VK_NUMPAD4:  Result := '[4]';
    VK_NUMPAD5:  Result := '[5]';
    VK_NUMPAD6:  Result := '[6]';
    VK_NUMPAD7:  Result := '[7]';
    VK_NUMPAD8:  Result := '[8]';
    VK_NUMPAD9:  Result := '[9]';
    VK_SEPARATOR:Result := '[+]';
    VK_SUBTRACT: Result := '[-]';
    VK_DECIMAL:  Result := '[.]';
    VK_DIVIDE:   Result := '[/]';
    VK_NUMLOCK:  Result := '[Num Lock]';
    VK_SCROLL:   Result := '[Scroll Lock]';
    VK_PLAY:     Result := '[Play]';
    VK_ZOOM:     Result := '[Zoom]';
    VK_LWIN:     Result := '[Windows]';
    VK_RWIN:     Result := '[Windows]';
    VK_APPS:     Result := '[Menu]';
    VK_RMENU:    Result := '[Right Alt]';
    VK_RSHIFT:   Result := '[Right Shift]';
    VK_RCONTROL: Result := '[Right Ctrl]';
    65: Result := '[a]';
    66: Result := '[b]';
    67: Result := '[c]';
    68: Result := '[d]';
    69: Result := '[e]';
    70: Result := '[f]';
    71: Result := '[g]';
    72: Result := '[h]';
    73: Result := '[i]';
    74: Result := '[j]';
    75: Result := '[k]';
    76: Result := '[l]';
    77: Result := '[m]';
    78: Result := '[n]';
    79: Result := '[o]';
    80: Result := '[p]';
    81: Result := '[q]';
    82: Result := '[r]';
    83: Result := '[s]';
    84: Result := '[t]';
    85: Result := '[u]';
    86: Result := '[v]';
    87: Result := '[w]';
    88: Result := '[x]';
    89: Result := '[y]';
    90: Result := '[z]';
  end;
end;
{$ENDREGION}

{$REGION '[HOOK] CAPTURE MOUSE INPUT - FUNCTION'}
function LowLevelMouseProc(nCode: integer; wParam: WPARAM; lParam: LPARAM): HRESULT; stdcall;
var
  fooString, fooString2: string;
  pmhs: PMSLLHOOKSTRUCT;
  doScreenshot: boolean;
//  wheelDirection: word;
begin
  doScreenshot := False;
  case wParam of
    WM_LBUTTONDOWN:begin
      fooString := '[WM_LBUTTONDOWN]';
      fooString2 := 'Left down';
      doScreenshot := True;
    end;
    WM_LBUTTONUP: begin
      fooString := '[WM_LBUTTONUP]';
      fooString2 := 'Left up';
    end;
    WM_RBUTTONDOWN: begin
      fooString := '[WM_RBUTTONDOWN]';
      fooString2 := 'Right down';
      doScreenshot := True;
    end;
    WM_RBUTTONUP: begin
      fooString := '[WM_RBUTTONUP]';
      fooString2 := 'Right up';
    end;
    WM_MBUTTONDOWN:begin
      fooString := '[WM_MBUTTONDOWN]';
      fooString2 := 'Middle down';
      doScreenshot := True;
    end;
    WM_MBUTTONUP: begin
      fooString := '[WM_MBUTTONUP]';
      fooString2 := 'Middle up';
    end;
{    WM_MOUSEMOVE: begin
      fooString := '[WM_MOUSEMOVE]';
    end;
    WM_MOUSEWHEEL: begin
      fooString := '[WM_MOUSEWHEEL]';
      wheelDirection := HiWord(pmhs.mouseData);
    end;
    WM_MOUSEHWHEEL: begin
      fooString := '[WM_MOUSEHWHEEL]';
    end;                                   }
    else begin
      fooString := '[UNKNOWN WPARAM]';
    end;
  end;

  if fooString <> '[UNKNOWN WPARAM]' then begin
    pmhs := PMSLLHOOKSTRUCT(Pointer(lParam));

    if Form_Status.Visible then begin
      Form_Status.UpdateLabel_StepID(rawCaptureData.Count);
      Form_Status.UpdateLabel_Input(
        '[Mouse] ' +  fooString2 + sLineBreak +
        IntToStr(pmhs.pt.x) + ':' + IntToStr(pmhs.pt.y) + sLineBreak +
        IntToStr(stopWatch.ElapsedMilliseconds) + 'ms'
      );
    end;

    fooString := '[' + IntToStr(rawCaptureData.Count+1) + '] [Mouse] [' + IntToStr(pmhs.pt.x) + ':' + IntToStr(pmhs.pt.y) + '] ' +
      fooString + ' [' + IntToStr(stopWatch.ElapsedMilliseconds) + ']';

    stopWatch := TStopWatch.StartNew;
    rawCaptureData.Add(fooString);
    if doScreenshot then begin
//      runningScreenShotThreads := runningScreenShotThreads + 1;
//      TScreenShotProcessThread.Create(pmhs.pt.X, pmhs.pt.Y, rawCaptureData.Count);
    end;
  end;

  Result := CallNextHookEx(mouseHook, nCode, wParam, lParam);
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE MOUSE INPUT - START'}
function TForm1.StartMouseHook_CaptureInput(): boolean;
begin
  if mouseHook = 0 then
    mouseHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc, HInstance, 0);
  Result := (mouseHook <> 0);
  runningScreenShotThreads := 0;
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE MOUSE INPUT - STOP'}
function TForm1.StopMouseHook_CaptureInput(): boolean;
begin
  Result := False;
  if (mouseHook <> 0) and UnhookWindowsHookEx(mouseHook) then begin
    mouseHook := 0;
    Result := True;
  end;
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE MOUSE INPUT - STARTED CHECK'}
function TForm1.MouseHook_IsStarted(): boolean;
begin
  Result := (mouseHook <> 0)
end;
{$ENDREGION}

{$REGION '[HOOK] CAPTURE KB INPUT - FUNCTION'}
function LowLevelKeyboardHookCaptureInput(nCode: Integer; wParam: WPARAM; lParam: LPARAM): HRESULT; stdcall;
var
  pkbhs: PKBDLLHOOKSTRUCT;
  aChr: array[0..1] of WideChar;
  virtualKey: integer;
  scanCode: integer;
  convRes: integer;
  activeWindow: HWND;
  activeThreadID: DWord;
  str: widestring;
  fooString: string;
begin
  pkbhs := PKBDLLHOOKSTRUCT(Pointer(lParam));
  if (nCode = HC_ACTION) then begin
    virtualKey := pkbhs^.vkCode;
    str := TranslateVirtualKey(virtualKey);
    if (str = '') or (str = '[UNKNOWN VIRTUAL KEY]') then begin
      activeWindow := GetForegroundWindow;
      activeThreadID := GetWindowThreadProcessId(activeWindow, nil);
      GetKeyboardState(KeyBoardState);
      KeyboardLayout := GetKeyboardLayout(activeThreadID);
      scanCode := MapVirtualKeyEx(virtualKey, 0, KeyboardLayout);
      if scanCode <> 0 then begin
        convRes := ToUnicodeEx(virtualKey, scanCode, @KeyBoardState, @aChr, SizeOf(aChr), 0, KeyboardLayout);
        if convRes = 0 then
          // Empty buffer - no translation for virtual key
          str := '[NO TRANSLATION FOR VIRTUAL KEY]'
        else if convRes >= 2 then begin
          // Multiple characters in the buffer - possibly caused by a previous dead key
          str := aChr[1];
          str := '[' + str + ']';
        end else begin
          // Dead key or single character
          str := aChr;
          str := '[' + str + ']';
        end;
      end;
    end;
    fooString := str;

    if wParam = WM_KEYDOWN then begin
      str := str + ' [WM_KEYDOWN]';
      fooString := fooString + ' Down';
    end else if wParam = WM_KEYUP then begin
      str := str + ' [WM_KEYUP]';
      fooString := fooString + ' Up';
    end else if wParam = WM_SYSKEYDOWN then begin
      str := str + ' [WM_SYSKEYDOWN]';
      fooString := fooString + ' Down';
    end else if wParam = WM_SYSKEYUP then begin
      str := str + ' [WM_SYSKEYUP]';
      fooString := fooString + ' Up';
    end else begin
      str := str + ' [UNHANDLED MESSAGE TYPE]';
      fooString := fooString + ' ?';
    end;

    if str <> '' then begin
      if Form_Status.Visible then begin
        Form_Status.UpdateLabel_StepID(rawCaptureData.Count);
        Form_Status.UpdateLabel_Input(
          '[Key] ' + sLineBreak +
          fooString + sLineBreak +
          IntToStr(stopWatch.ElapsedMilliseconds) + 'ms'
        );
      end;

      str := '[' + IntToStr(rawCaptureData.Count+1) + '] [Key] ' + str + ' [' + IntToStr(stopWatch.ElapsedMilliseconds) + ']';
      stopWatch := TStopWatch.StartNew;
      rawCaptureData.Add(str);
    end;
  end;
  Result := CallNextHookEx(llKeyboardHookCaptureInput, nCode, wParam, lParam);
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE KB INPUT - START'}
function TForm1.StartKBHook_CaptureInput: boolean;
begin
  rawCaptureData := TStringList.Create;
  if llKeyboardHookCaptureInput = 0 then
    llKeyboardHookCaptureInput := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyboardHookCaptureInput, HInstance, 0);
  Result := (llKeyboardHookCaptureInput <> 0);
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE KB INPUT - STOP'}
function TForm1.StopKBHook_CaptureInput: Boolean;
begin
  rawCaptureData.SaveToFile(workDir + '\tempFlow.szd');
  rawCaptureData.Free;
  Result := False;
  if (llKeyboardHookCaptureInput <> 0) and UnhookWindowsHookEx(llKeyboardHookCaptureInput) then begin
    llKeyboardHookCaptureInput := 0;
    Result := True;
  end;
end;
{$ENDREGION}
{$REGION '[HOOK] CAPTURE KB INPUT - STARTED CHECK'}
function TForm1.KBHookIsStarted_CaptureInput: Boolean;
begin
  Result := (llKeyboardHookCaptureInput <> 0)
end;
{$ENDREGION}

{$REGION '[Thread - Stop Flow] Create'}
constructor TStopFlowThread.Create;
begin
  inherited Create;
end;
{$ENDREGION}
{$REGION '[Thread - Stop Flow] Execute'}
procedure TStopFlowThread.Execute;
begin
  repeat
    if (GetKeyState(VK_F2) < 0) and (GetKeyState(VK_F3) < 0) then begin
      Form1.StopFlow;
    end;
  until not runStopFlow;
end;
{$ENDREGION}

{$REGION '[Thread - Stop input capture] Create'}
constructor TStopCaptureThread.Create;
begin
  inherited Create;
end;
{$ENDREGION}
{$REGION '[Thread - Stop input capture] Execute'}
procedure TStopCaptureThread.Execute;
begin
  repeat
    if (GetKeyState(VK_F2) < 0) and (GetKeyState(VK_F4) < 0) then begin
      runStopCapture := False;
      Form1.Tim_FlowGenerateDebugger.Enabled := True;
    end;
  until not runStopCapture;
end;
{$ENDREGION}

{$REGION '[Thread - Cursor Check] Execute'}
procedure TCursorCheckThread.Execute;
var
  p: TPoint;
begin
  FreeOnTerminate := true;
  repeat
    GetCursorPos(p);
    Form1.Lab_Cursor_X.Caption := 'x: ' + Inttostr(p.X);
    Form1.Lab_Cursor_Y.Caption := 'y: ' + Inttostr(p.Y);
  until not runCursorPos;
end;
{$ENDREGION}

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

  inherited ;
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
end;
{$ENDREGION}
{$REGION '[Form - Events] OnResize'}
procedure TForm1.FormResize(Sender: TObject);
begin
  Pnl_Flow.Realign;
end;
{$ENDREGION}

{$REGION '[Form] Input Change Click'}
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
{$REGION '[Form] About Click'}
procedure TForm1.About1Click(Sender: TObject);
begin
  showmessage('Szakdolgozat v' + CURRENT_VERSION +  sLineBreak +
              'Application design and coding by Pázmándi Erik: pazmandi.erik@gmail.com');
end;
{$ENDREGION}
{$REGION '[Form] Tray Icon Double Click'}
procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;
{$ENDREGION}
{$REGION '[Form] Dummy1 Click (Set Style)'}
procedure TForm1.Dummy1Click(Sender: TObject);
begin
  TStyleManager.SetStyle(TMenuItem(Sender).Caption);
  ConfigFile.Save('Style',TMenuItem(Sender).Caption);
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
{$REGION '[Form] Schedule1 Click'}
procedure TForm1.Schedule1Click(Sender: TObject);
begin
  Pnl_Schedule.BringToFront;
  Lab_Edt_WaitAfter.Visible := False;
  Pnl_Schedule.Visible := True;
  Pnl_Schedule.SetFocus();
end;
{$ENDREGION}
{$REGION '[Form] Load1 Click'}
procedure TForm1.Load1Click(Sender: TObject);
begin
  LoadFlow('user');
end;
{$ENDREGION}
{$REGION '[Form] New1 Click'}
procedure TForm1.NewFlow1Click(Sender: TObject);
begin
  ClearLinkedList();
end;
{$ENDREGION}
{$REGION '[Form] StartRecordingInput1 Click'}
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

{$REGION '[Flow] Process Flow Element'}
procedure TForm1.Tim_WaitAfterTimer(Sender: TObject);
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
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1), 0, 0, 0);
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1), 0, KEYEVENTF_KEYUP, 0);
      end;
      //Hotkey input
      itHotkey: begin
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1), 0, 0, 0);
        keybd_event(VkKeyScan(currentStep.inputParam2[1]), 0, 0, 0);
        keybd_event(MatchStringToVirtualKey(currentStep.inputParam1), 0, KEYEVENTF_KEYUP, 0);
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
  Lab_Status.Caption := 'Next step: ' + IntToStr(id) + '.' + sLineBreak +
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

  Tim_WaitAfter.Interval := currentStep.waitAfterAmount * modifier;

  // Set pointer to next element
  currentStep := currentStep.NextElement;

  end else begin
    // Flow is over
    if currentRunID < totalRuns then begin
      // Current flow completed
      currentRunID := currentRunID+1;

      Lab_Status.Caption := 'Next step: 1.';
      currentStep := flowHead.NextElement;
      if waitBetweenFlow = wtSec then
        modifier := 1000
      else if waitBetweenFlow = wtMin then
        modifier := 60000
      else if waitBetweenFlow = wtHour then
        modifier := 3600000
      else
        modifier := 1;
      Tim_WaitAfter.Interval := StrToInt(Edt_WaitBetween.Text) * modifier;
      Lab_Status.Caption := 'Flow ' + IntToStr(currentRunID-1) + ' of ' + IntToStr(totalRuns) + ' completed.' + sLineBreak +
                            'Next one starts ' + Edt_WaitBetween.Text + ' ' +
                             LowerCase(CB_WaitBetween.Text) + ' after ' + DateTimeToStr(Now());
    end else begin
      // All the flows are done
      Tim_WaitAfter.Enabled := False;
      runStopFlow := False;
      stopFlowThread.Terminate;
      Btn_StartFlow.Caption := 'Return to flow editor.';
      Lab_Status.Caption := 'Flow completed!';
    end;
  end;
end;
{$ENDREGION}
{$REGION '[Flow] Stop Flow Method'}
procedure TForm1.StopFlow;
begin
  Btn_StartFlowClick(Form1);
end;
{$ENDREGION}
{$REGION '[Flow] Match String to Virtual Key'}
function TForm1.MatchStringToVirtualKey(str : string): Byte;
var
  strArray : array[1..40] of string;
  vkArray : array[1..40] of byte;
  i : integer;
begin
  for i := 0 to 29 do
    strArray[i+1] := RadGroup_SpecialKeys.Items[i];

  vkArray[1] := VK_F1;
  vkArray[2] := VK_F2;
  vkArray[3] := VK_F3;
  vkArray[4] := VK_F4;
  vkArray[5] := VK_F5;
  vkArray[6] := VK_F6;
  vkArray[7] := VK_F7;
  vkArray[8] := VK_F8;
  vkArray[9] := VK_F9;
  vkArray[10] := VK_F10;
  vkArray[11] := VK_F11;
  vkArray[12] := VK_F12;
  vkArray[13] := VK_LEFT;
  vkArray[14] := VK_RIGHT;
  vkArray[15] := VK_UP;
  vkArray[16] := VK_DOWN;
  vkArray[17] := VK_BACK;
  vkArray[18] := VK_CAPITAL;
  vkArray[19] := VK_RETURN;
  vkArray[20] := VK_ESCAPE;
  vkArray[21] := VK_LMENU;
  vkArray[22] := VK_LCONTROL;
  vkArray[23] := VK_LSHIFT;
  vkArray[24] := VK_SNAPSHOT;
  vkArray[25] := VK_RMENU;
  vkArray[26] := VK_RCONTROL;
  vkArray[27] := VK_RSHIFT;
  vkArray[28] := VK_SPACE;
  vkArray[29] := VK_TAB;
  vkArray[30] := VK_LWIN;

  strArray[31] := 'Enter';
  vkArray[31] := VK_RETURN;

  strArray[32] := 'Home';
  vkArray[32] := VK_HOME;

  strArray[33] := 'End';
  vkArray[33] := VK_END ;

  strArray[34] := 'Insert';
  vkArray[34] := VK_INSERT ;

  strArray[35] := 'Delete';
  vkArray[35] := VK_DELETE ;

  strArray[36] := 'Pause';
  vkArray[36] := VK_PAUSE ;

  strArray[37] := 'Num Lock';
  vkArray[37] := VK_NUMLOCK ;

  strArray[38] := 'Scroll Lock';
  vkArray[38] := VK_SCROLL ;

  strArray[39] := 'Page Up';
  vkArray[39] := VK_PRIOR ;

  strArray[40] := 'Page Down';
  vkArray[40] := VK_NEXT ;

  Result := 0;
  for i := 1 to Length(vkArray) do
    if str = strArray[i] then
      Result := vkArray[i];

end;
{$ENDREGION}
{$REGION '[Flow] Clear linked list'}
function TForm1.ClearLinkedList(): integer;
var
  doNewFlow : boolean;
  confirmButton : integer;
  currentElement, prevElement : PFlowElement;
begin
  doNewFlow := false;
  if unsavedProgress then begin
    confirmButton := messagedlg('All unsaved changes will be lost.' + sLineBreak + 'Would you like to continue?', mtWarning, mbOkCancel, 0);
    if confirmButton = 1 then
      doNewFlow := true;
  end else
    doNewFlow := true;

  if doNewFlow then begin
    Result := 0;
    if flowHead.NextElement <> nil then begin
      currentElement := flowHead.NextElement;
    end else
      currentElement := flowHead;

    while currentElement.NextElement <> nil do begin
      prevElement := currentElement;
      currentElement := currentElement.NextElement;
      PostMessage(self.Handle, WM_KILLCONTROL, 0, integer(prevElement.panelObject));
      FreeMem(prevElement);
    end;
    if currentElement <> flowHead then begin
      PostMessage(self.Handle, WM_KILLCONTROL, 0, integer(currentElement.panelObject));
      FreeMem(currentElement);
    end;
    flowHead.NextElement := nil;
    Pnl_Flow.Width :=  0;
    Edt_WaitBetween.Text := '1';
    SE_TotalRuns.Text := '1';
    CB_WaitBetween.ItemIndex := 0;
  end else
    Result := 1;
end;
{$ENDREGION}
{$REGION '[Flow] Load'}
procedure TForm1.LoadFlow(caller: string);
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
          SE_TotalRuns.Text := scheduleSettings[0];
          Edt_WaitBetween.Text := scheduleSettings[1];
          i := 0;
          while (i < CB_WaitBetween.Items.Count) and (scheduleSettings[2] <> CB_WaitBetween.Items[i]) do
            i := i+1;
          if scheduleSettings[2] = CB_WaitBetween.Items[i] then
            CB_WaitBetween.ItemIndex := i;
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
            newFlowElement.panelObject := TPanel.Create(Pnl_Flow);

            if (elementCount mod 8) = 0 then begin
              newPanelColumn := Pnl_Flow.ColumnCollection.Add();
              newPanelColumn.SizeStyle := ssAuto;
            end;
            Pnl_Flow.ControlCollection.AddControl(newFlowElement.panelObject, ((elementCount-1) div 8), ((elementCount-1) mod 8));
            newFlowElement.panelObject.Parent := Pnl_Flow;
            newFlowElement.panelObject.Alignment := taRightJustify;
            newFlowElement.panelObject.Font.Style := [fsBold];
            newFlowElement.panelObject.Font.Size := 12;
            newFlowElement.panelObject.Caption := IntToStr(elementCount) +  '.         ';
            newFlowElement.panelObject.Width := 210;
            newFlowElement.panelObject.OnMouseDown := Pnl_Dummy.OnMouseDown;
            newFlowElement.panelObject.OnMouseUp := Pnl_Dummy.OnMouseUp;

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
            newFlowElement.deleteButton.OnClick := Btn_Dummy.OnClick;

            // Create Label
            newFlowElement.labelObject := TLabel.Create(newFlowElement.panelObject);
            newFlowElement.labelObject.Parent := newFlowElement.panelObject;
            newFlowElement.labelObject.Font.Style := [];
            newFlowElement.labelObject.Font.Size := 8;
            newFlowElement.labelObject.OnMouseDown := Pnl_Dummy.OnMouseDown;
            newFlowElement.labelObject.OnMouseUp := Pnl_Dummy.OnMouseUp;

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
            Pnl_Flow.Width :=  ((((elementCount-1) div 8) + 1)  * newFlowElement.panelObject.Width) + 5;
          end;
        end;
      finally
        loadedFile.Free;
      end;
    end;
  end;
end;
{$ENDREGION}
{$REGION '[Flow] Save'}
procedure TForm1.Save1Click(Sender: TObject);
var
  saveDialog : TSaveDialog;
  saveData : TStringList;
  currentElement : PFlowElement;
begin

  saveDialog := TSaveDialog.Create(self);
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
          SE_TotalRuns.Text + ';' + Edt_WaitBetween.Text + ';' + CB_WaitBetween.Text
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

{$REGION '[Flow - Generate] Main function'}
procedure TForm1.GenerateFlow;
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
    newLinkElement.panelObject := TPanel.Create(Pnl_Flow);

    if (j mod 8) = 0 then begin
      newPanelColumn := Pnl_Flow.ColumnCollection.Add();
      newPanelColumn.SizeStyle := ssAuto;
    end;
    Pnl_Flow.ControlCollection.AddControl(newLinkElement.panelObject, ((j-1) div 8), ((j-1) mod 8));
    newLinkElement.panelObject.Parent := Pnl_Flow;
    newLinkElement.panelObject.Alignment := taRightJustify;
    newLinkElement.panelObject.Font.Style := [fsBold];
    newLinkElement.panelObject.Font.Size := 12;
    newLinkElement.panelObject.Caption := IntToStr(j) +  '.         ';
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
    newLinkElement.deleteButton.Name := 'flowButton_'+IntToStr(j);
    newLinkElement.deleteButton.OnClick := Btn_Dummy.OnClick;

    // Create Label
    newLinkElement.labelObject := TLabel.Create(newLinkElement.panelObject);
    newLinkElement.labelObject.Parent := newLinkElement.panelObject;
    newLinkElement.labelObject.Font.Style := [];
    newLinkElement.labelObject.Font.Size := 8;
    newLinkElement.labelObject.OnMouseDown := Pnl_Dummy.OnMouseDown;
    newLinkElement.labelObject.OnMouseUp := Pnl_Dummy.OnMouseUp;

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
    Pnl_Flow.Width :=  ((((j-1) div 8) + 1)  * newLinkElement.panelObject.Width) + 5;
    i := i+1;
  end;

end;
{$ENDREGION}
{$REGION '[Flow - Generate] Split temp flow line'}
function TForm1.SplitTempFlowLine(stringToSplit: string): string;
var
  fooString: string;
  resultString: string;
  i: integer;
begin
  // Misc init
  resultString := '';
  i := 1;
  // Process first element (ID)
  while stringToSplit[i] <> ' ' do begin
      resultString := resultString + stringToSplit[i];
    i := i+1;
  end;
  // Process remaining screenshotElements
  fooString := '';
  while i <= Length(stringToSplit)+1 do begin
    if (i > Length(stringToSplit)) or ((stringToSplit[i] = ' ') and (stringToSplit[i-1] = ']') and (stringToSplit[i+1] = '[')) then begin
      // Start new
      resultString := resultString + fooString + sLineBreak;
      fooString := '';
    end else begin
      // Add to current
      fooString := fooString + stringToSplit[i];
    end;
    i := i+1;
  end;
  Result := resultString;
end;
{$ENDREGION}
{$REGION '[Flow - Generate] Match Message to mouse click'}
procedure TForm1.MatchMessageToMouseClick(WM: string; var mouseButton, clickType: string);
begin
  if WM = '[WM_LBUTTONDOWN]' then begin
    mouseButton := 'Left';
    clickType := 'Down only (single)';
  end else if WM = '[WM_LBUTTONUP]' then begin
    mouseButton := 'Left';
    clickType := 'Up only (single)';
  end else if WM = '[WM_RBUTTONDOWN]' then begin
    mouseButton := 'Right';
    clickType := 'Down only (single)';
  end else if WM = '[WM_RBUTTONUP]' then begin
    mouseButton := 'Right';
    clickType := 'Up only (single)';
  end else if WM = '[WM_MBUTTONDOWN]' then begin
    mouseButton := 'Middle';
    clickType := 'Down only (single)';
  end else if WM = '[WM_MBUTTONUP]' then begin
    mouseButton := 'Middle';
    clickType := 'Up only (single)';
  end else begin
    mouseButton := 'Err';
    clickType := 'Err';
  end;
end;
{$ENDREGION}
{$REGION '[Flow - Generate] Is Special Key'}
function TForm1.IsSpecialKey(key: string): boolean;
const
  KEY_ARRAY: array of string = [
    '[F1]','[F2]','[F3]','[F4]','[F5]','[F6]','[F7]','[F8]','[F9]','[F10]','[F11]','[F12]',
    '[Arrow: Left]','[Arrow: Down]','[Arrow: Right]','[Arrow: Up]','[Backspace]','[Caps Lock]',
    '[Enter]','[Escape]','[Left Alt]','[Left Ctrl]','[Left Shift]','[PrtSc]','[Right Alt]','[Right Ctrl]',
    '[Right Shift]','[Tab]','[Windows]','[Home]','[End]','[Ins]','[Delete]','[Page Up]','[Page Down]','[Num Lock]',
    '[Scroll Lock]','[Pause]'
  ];
var
  i: integer;
begin
  i := 1;
  while (i <= Length(KEY_ARRAY)) and (key <> KEY_ARRAY[i]) do begin
    i := i+1;
  end;
  if i <= Length(KEY_ARRAY) then
    Result := True
  else
    Result := False;
end;
{$ENDREGION}


{$REGION '[Timer] Flow generation debugger'}
procedure TForm1.Tim_FlowGenerateDebuggerTimer(Sender: TObject);
begin
  Tim_FlowGenerateDebugger.Enabled := False;
  Form1.StartRecordingInput1Click(Form1);
end;
{$ENDREGION}
{$REGION '[Timer] Post Form Create'}
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
