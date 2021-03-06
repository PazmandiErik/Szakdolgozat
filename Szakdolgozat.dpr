program Szakdolgozat;

uses
  Vcl.Forms,
  Unit_Main in 'src\Unit_Main.pas' {Form_Main},
  Unit_Logger in 'src\Unit_Logger.pas',
  Vcl.Themes,
  Vcl.Styles,
  Unit_ConfigHandler in 'src\Unit_ConfigHandler.pas',
  Unit_FlowManager in 'src\Unit_FlowManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
