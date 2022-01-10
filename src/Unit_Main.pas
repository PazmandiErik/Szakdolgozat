unit Unit_Main;

interface

{$REGION 'Units'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Unit_Logger,
  Vcl.Tabs, Vcl.StdCtrls, Vcl.Themes, Unit_ConfigHandler, Unit_FlowManager;
{$ENDREGION}

{$REGION 'Constants'}
const
  CURRENT_VERSION = '0.0';
{$ENDREGION}

{$REGION 'Type - Form'}
type
  TForm_Main = class(TForm)
    Tim_PostFormCreate: TTimer;
    TabSet_Main: TTabSet;
    Pnl_Dashboard: TPanel;
    Pnl_Flow: TPanel;
    Pnl_Settings: TPanel;
    Pnl_Scheduler: TPanel;
    Pnl_Settings_Footer: TPanel;
    Lab_Credits: TLabel;
    Combo_Styles: TComboBox;
    Pnl_Flow_Interface: TPanel;
    Pnl_Flow_Actual: TGridPanel;
    Btn_LoadFlow: TButton;
    Btn_NewFlow: TButton;
    Btn_SaveFlow: TButton;
    Pnl_Flow_EditStep: TPanel;
    Btn_GenerateFlowSteps: TButton;
    Pnl_EditStep_Header: TPanel;
    Lab_EditStep_Header: TLabel;
    SB_Flow_Actual: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure Tim_PostFormCreateTimer(Sender: TObject);
    procedure TabSet_MainChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure Combo_StylesChange(Sender: TObject);
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
  configHandler: TConfigHandler;
{$ENDREGION}

implementation

{$R *.dfm}

{$REGION '[Form] OnCreate'}
procedure TForm_Main.FormCreate(Sender: TObject);
begin
  Form_Main.Caption := Form_Main.Caption + ' v' + CURRENT_VERSION;
end;
{$ENDREGION}

{$REGION '[Combo box - Styles] OnChange'}
procedure TForm_Main.Combo_StylesChange(Sender: TObject);
begin
  TStyleManager.SetStyle(Combo_Styles.Text);
end;
{$ENDREGION}
{$REGION '[TabSet - Main] OnChange (Handle swapping of overlaying panels)'}
procedure TForm_Main.TabSet_MainChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  focusedPanel: TPanel;
  i: integer;
  fooControl: TControl;
begin
  case NewTab of
    0: focusedPanel := Pnl_Dashboard;
    1: focusedPanel := Pnl_Flow;
    2: focusedPanel := Pnl_Scheduler;
    3: focusedPanel := Pnl_Settings;
    else
      Exit;
  end;

  for i := 0 to Form_Main.ControlCount-1 do begin
    fooControl := Form_Main.Controls[i];
    if fooControl.ClassName = 'TPanel' then
      if fooControl.Name <> focusedPanel.Name then begin
        fooControl.Visible := False;
      end else begin
        fooControl.BringToFront;
        fooControl.Visible := True;
      end;
  end;

end;
{$ENDREGION}

{$REGION '[Timer] Post Form Create'}
procedure TForm_Main.Tim_PostFormCreateTimer(Sender: TObject);
var
  styleName: string;
  flowManager: TFlowManager;
begin
  // Initialize global variables
  Tim_PostFormCreate.Enabled := False;
  workDir := ExtractFileDir(Application.Exename) + '\';
  configHandler := TConfigHandler.Create(workDir+'\Data\!runtime\mainConfig.ini');

  // Initialize logger
  logger := TLogger.Create(workDir + 'Logs\');
  logger.Save();

  // Properly set up panel layout for startup
  TabSet_Main.TabIndex := 0;

  // Miscellaneous initialization
  Lab_Credits.Caption :=
    Form_Main.Caption + sLineBreak +
    'Contact: pazmandi.erik@gmail.com' + sLineBreak +
    'GitHub: https://github.com/PazmandiErik/Szakdolgozat';
  for styleName in TStyleManager.StyleNames do
    Combo_Styles.Items.Add(styleName);
  Combo_Styles.ItemIndex := Combo_Styles.Items.IndexOf(TStyleManager.ActiveStyle.Name);



  flowManager := TFlowManager.Create;






end;
{$ENDREGION}

end.
