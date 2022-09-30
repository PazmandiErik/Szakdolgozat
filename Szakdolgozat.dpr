program Szakdolgozat;

uses
  Vcl.Forms,
  Unit_Main in 'src\Unit_Main.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  Unit_ConfigHandler in 'src\Unit_ConfigHandler.pas',
  Unit_Scheduler in 'src\Unit_Scheduler.pas',
  Unit_Status in 'src\Unit_Status.pas' {Form_Status},
  Unit_AuxiliaryFunctions in 'src\Unit_AuxiliaryFunctions.pas',
  Unit_CursorCheckThread in 'src\Unit_CursorCheckThread.pas',
  Unit_StopFlowThread in 'src\Unit_StopFlowThread.pas',
  Unit_StopCaptureThread in 'src\Unit_StopCaptureThread.pas',
  Unit_LinkedListHandler in 'src\Unit_LinkedListHandler.pas',
  Unit_HookHandler in 'src\Unit_HookHandler.pas',
  Unit_FlowHandler in 'src\Unit_FlowHandler.pas',
  Unit_DataGenerator in 'src\Unit_DataGenerator.pas' {Form_Generator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  TStyleManager.TrySetStyle('Aqua Graphite');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_Status, Form_Status);
  Application.CreateForm(TForm_Generator, Form_Generator);
  Application.Run;
end.
