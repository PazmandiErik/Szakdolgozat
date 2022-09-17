unit Unit_Status;

interface

{$REGION 'UNITS'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;
{$ENDREGION}

{$REGION 'TYPES'}
type
  TForm_Status = class(TForm)
    Lab_Input: TLabel;
    Lab_Finish: TLabel;
    Lab_Input_Title: TLabel;
    Lab_StepID_Title: TLabel;
    Pnl_Main: TPanel;
    Lab_StepID: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateLabel_Input(newText: string);
    procedure UpdateLabel_StepID(newID: integer);
  end;
{$ENDREGION}

var
  Form_Status: TForm_Status;

implementation

{$R *.dfm}

{$REGION '[LABEL UPDATE] INPUT'}
procedure TForm_Status.UpdateLabel_Input(newText: string);
begin
  if Form_Status.Visible then
    Lab_Input.Caption := newText;
end;
{$ENDREGION}
{$REGION '[LABEL UPDATE] STEP ID'}
procedure TForm_Status.UpdateLabel_StepID(newID: Integer);
begin
  if Form_Status.Visible then
    Lab_StepID.Caption := IntToStr(newID + 1);
end;
{$ENDREGION}

{$REGION '[FORM] OnCreate'}
procedure TForm_Status.FormCreate(Sender: TObject);
begin
  Form_Status.Left := Screen.Width-Form_Status.Width - 5;
  Form_Status.Top := 5;
end;
{$ENDREGION}
{$REGION '[FORM] OnShow'}
procedure TForm_Status.FormShow(Sender: TObject);
begin
  Lab_StepID.Caption := '0';
  Lab_Input.Caption := '';
end;
{$ENDREGION}
{$REGION '[FORM] OnMouseMove'}
procedure TForm_Status.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  cursorPos: TPointF;
begin
  cursorPos := Mouse.CursorPos;
  Form_Status.OnMouseMove := nil;
  Pnl_Main.OnMouseMove := nil;

  if cursorPos.X > Screen.Width/2 then begin
    Form_Status.Left := 5;
    Form_Status.Top := Screen.Height-Form_Status.Height - 5;

  end else begin
    Form_Status.Left := Screen.Width-Form_Status.Width - 5;
    Form_Status.Top := 5;

  end;
  Application.ProcessMessages;
  Form_Status.OnMouseMove := FormMouseMove;
  Pnl_Main.OnMouseMove := FormMouseMove;
end;
{$ENDREGION}





end.
