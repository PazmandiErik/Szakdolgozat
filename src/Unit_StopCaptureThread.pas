unit Unit_StopCaptureThread;

interface

uses
  System.Classes, Windows;

type
  TStopCaptureThread = class(TThread)
  public
    procedure Execute(); override;
    constructor Create;
  end;

implementation

uses Unit_Main;

constructor TStopCaptureThread.Create;
begin
  inherited Create;
end;

procedure TStopCaptureThread.Execute;
begin
  repeat
    if (GetKeyState(VK_F2) < 0) and (GetKeyState(VK_F4) < 0) then begin
      runStopCapture := False;
      Form1.Tim_FlowGenerateDebugger.Enabled := True;
    end;
  until not runStopCapture;
end;

end.
