unit Unit_CursorCheckThread;

interface

uses
  System.Classes, System.Types, System.SysUtils, Windows;

type
  TCursorCheckThread = class(TThread)
    procedure Execute; override;
  end;

implementation

uses Unit_Main;

procedure TCursorCheckThread.Execute;
var
  p: TPoint;
begin
  FreeOnTerminate := true;
  repeat
    GetCursorPos(p);
    Form1.Lab_Cursor_X.Caption := 'x: ' + IntToStr(p.X);
    Form1.Lab_Cursor_Y.Caption := 'y: ' + IntToStr(p.Y);
  until not runCursorPos;
end;

end.
