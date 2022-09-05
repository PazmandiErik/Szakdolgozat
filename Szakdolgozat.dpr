program Szakdolgozat;

uses
  Vcl.Forms,
  Unit_Main in 'src\Unit_Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Unit_ConfigHandler in 'src\Unit_ConfigHandler.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  TStyleManager.TrySetStyle('Aqua Graphite');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
