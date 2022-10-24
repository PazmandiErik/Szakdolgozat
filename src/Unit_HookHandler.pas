unit Unit_HookHandler;

interface

uses
  System.Types, Windows, System.Classes, System.Diagnostics, System.SysUtils, Winapi.Messages;

type
  {$REGION 'KB hook packed record'}
  PKBDLLHOOKSTRUCT = ^TKBDLLHOOKSTRUCT;
  TKBDLLHOOKSTRUCT = packed record
    vkCode: DWORD;
    scanCode: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: DWORD;
  end;
  {$ENDREGION}
  {$REGION 'Mouse hook packed record'}
  PMSLLHOOKSTRUCT = ^TMSLLHOOKSTRUCT;
  TMSLLHOOKSTRUCT = packed record
    pt: TPoint;
    mouseData: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: ULONG_PTR;
  end;
  {$ENDREGION}

var
  rawCaptureData: TStringList;
  stopWatch: TStopWatch;
  llKeyboardHookHotkeys: HHOOK = 0;
  llKeyboardHookCaptureInput: HHOOK = 0;
  KeyBoardState: TKeyboardState;
  KeyBoardLayOut: HKL;
  doublePressDebug: boolean;
  mouseHook: HHOOK = 0;


function StartMouseHook_CaptureInput(): boolean;
function StopMouseHook_CaptureInput(): boolean;
function MouseHook_IsStarted(): boolean;
function StartKBHook_CaptureInput(): boolean;
function StopKBHook_CaptureInput(): boolean;
function KBHook_IsStarted(): boolean;

implementation

uses Unit_Main, Unit_Status;

{$REGION 'Translate virtual key'}
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

{$REGION 'KB - Function'}
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
{$REGION 'KB - Start'}
function StartKBHook_CaptureInput: boolean;
begin
  rawCaptureData := TStringList.Create;
  if llKeyboardHookCaptureInput = 0 then
    llKeyboardHookCaptureInput := SetWindowsHookEx(WH_KEYBOARD_LL, @LowLevelKeyboardHookCaptureInput, HInstance, 0);
  Result := (llKeyboardHookCaptureInput <> 0);
end;
{$ENDREGION}
{$REGION 'KB - Stop'}
function StopKBHook_CaptureInput: Boolean;
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
{$REGION 'KB - Started Check'}
function KBHook_IsStarted: Boolean;
begin
  Result := (llKeyboardHookCaptureInput <> 0)
end;
{$ENDREGION}


{$REGION 'Mouse - Function'}
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
{$REGION 'Mouse - Start'}
function StartMouseHook_CaptureInput(): boolean;
begin
  if mouseHook = 0 then
    mouseHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc, HInstance, 0);
  Result := (mouseHook <> 0);
end;
{$ENDREGION}
{$REGION 'Mouse - Stop'}
function StopMouseHook_CaptureInput(): boolean;
begin
  Result := False;
  if (mouseHook <> 0) and UnhookWindowsHookEx(mouseHook) then begin
    mouseHook := 0;
    Result := True;
  end;
end;
{$ENDREGION}
{$REGION 'Mouse - Started Check'}
function MouseHook_IsStarted(): boolean;
begin
  Result := (mouseHook <> 0)
end;
{$ENDREGION}




end.
