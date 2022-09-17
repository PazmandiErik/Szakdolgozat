unit Unit_Scheduler;

interface

uses Winapi.Windows, ShellAPI;

type
  TScheduleHandler = class(TObject)
  public
    function DeleteTask(fPath: string): integer;
    function AddTask(fPath, sPath: string): integer;
  end;


implementation

function TScheduleHandler.DeleteTask(fPath: string): integer;
begin
    ShellExecute(0, nil, 'schtasks', PChar('/delete /f /tn "' + fPath + '"'), nil, SW_HIDE);
    Result := 0;
end;

function TScheduleHandler.AddTask(fPath, sPath: string): integer;
begin
    ShellExecute(0, nil, 'schtasks', PChar('/create /tn "' + fPath + '" /tr "' + sPath), nil, SW_SHOW);
    Result := 0;
end;

end.
