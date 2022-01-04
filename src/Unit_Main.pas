unit Unit_Main;

interface

{$REGION 'Units'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, DwmAPI, Unit_Logger;
{$ENDREGION}

{$REGION 'Constants'}
const
  CURRENT_VERSION = '0.0';
{$ENDREGION}

{$REGION 'Type - Form'}
type
  TForm_Main = class(TForm)
    Pnl_SideMenu: TPanel;
    Pnl_Dashboard: TPanel;
    Tim_PostFormCreate: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Tim_PostFormCreateTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{$ENDREGION}

{$REGION 'Global variables'}
var
  Form_Main: TForm_Main;
  logger: TLogger;
  workDir: string;
{$ENDREGION}

implementation

{$R *.dfm}

{$REGION [Form] OnCreate}
procedure TForm_Main.FormCreate(Sender: TObject);
begin
  Form_Main.Caption := 'Szakdolgozat v' + CURRENT_VERSION;
end;
{$ENDREGION}

{$REGION [Timer] Post Form Create}
procedure TForm_Main.Tim_PostFormCreateTimer(Sender: TObject);
begin
  // Initialize global variables
  Tim_PostFormCreate.Enabled := False;
  workDir := ExtractFileDir(Application.Exename) + '\';

  // Initialize logger
  logger := TLogger.Create(workDir + 'Logs\');
  logger.Save();

end;
{$ENDREGION}

end.
