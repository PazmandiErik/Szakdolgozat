program Szakdolgozat;

uses
  Vcl.Forms,
  Unit_Main in 'src\Unit_Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Unit_ConfigHandler in 'src\Unit_ConfigHandler.pas',
  Unit_Scheduler in 'src\Unit_Scheduler.pas',
  Unit_Status in 'src\Unit_Status.pas' {Form_Status};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  TStyleManager.TrySetStyle('Aqua Graphite');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_Status, Form_Status);
  Application.Run;
end.
