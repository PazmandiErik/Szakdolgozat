unit Unit_StopFlowThread;

interface

uses
  System.Classes, Windows;

type

  TStopFlowThread = class(TThread)
    public
      procedure Execute(); override;
      constructor Create;
  end;

implementation

uses Unit_Main;

constructor TStopFlowThread.Create;
begin
  inherited Create;
end;

procedure TStopFlowThread.Execute;
begin
  repeat
    if (GetKeyState(VK_F2) < 0) and (GetKeyState(VK_F3) < 0) then begin
      Form1.Btn_StartFlowClick(stopFlowThread);
    end;
  until not runStopFlow;
end;

end.
