program Szakdolgozat;

uses
  Vcl.Forms,
  Unit_Main in 'src\Unit_Main.pas' {Form_Main},
  Unit_Logger in 'src\Unit_Logger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
