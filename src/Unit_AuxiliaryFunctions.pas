unit Unit_AuxiliaryFunctions;

interface

uses
  Winapi.Windows, System.Classes;


procedure MatchMessageToMouseClick(WM: string; var mouseButton, clickType: string);
function MatchStringToVirtualKey(str : string; strs: TStrings): Byte;
function SplitTempFlowLine(stringToSplit: string): string;
function IsSpecialKey(key: string): boolean;

implementation

{$REGION 'Match message to mouse click'}
procedure MatchMessageToMouseClick(WM: string; var mouseButton, clickType: string);
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
{$REGION 'Match string to virtual key'}
function MatchStringToVirtualKey(str : string; strs: TStrings): Byte;
var
  strArray : array[1..40] of string;
  vkArray : array[1..40] of byte;
  i : integer;
begin
  for i := 0 to 29 do
    strArray[i+1] := strs[i];

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
{$REGION 'Split temp flow line'}
function SplitTempFlowLine(stringToSplit: string): string;
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
{$REGION 'Is Special Key'}
function IsSpecialKey(key: string): boolean;
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

end.
