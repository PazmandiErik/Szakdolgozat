unit Unit_DataGenerator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TForm_Generator = class(TForm)
    Mem_Log: TMemo;
    Pnl_Interface: TPanel;
    Btn_Generate: TButton;
    RadGroup_GenCategory: TRadioGroup;
    Spin_GenCount: TSpinEdit;
    procedure Btn_GenerateClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure Generate_ComputerShutdown(count: integer);
    procedure Generate_ComputerRestart(count: integer);
    procedure Generate_BrowserLaunch(count: integer);
    procedure AddToLog(msg: string);

    function GetClickDelay(_type: integer): integer;
    function GetRandomMouseCoordinate(min, max: integer):integer;
  public
    { Public declarations }
  end;

var
  Form_Generator: TForm_Generator;

implementation

uses
  Unit_Main;

{$R *.dfm}

{$REGION 'Generate - Computer shutdown'}
procedure TForm_Generator.Generate_ComputerShutdown(count: Integer);
var
  scenario_id: integer;
  inputList: TStringList;
  currentRun: integer;
  fooInt1, fooInt2: integer;
  fooString: string;
begin
  Randomize;

  currentRun := 1;
  while currentRun <= count do begin
    inputList := TStringList.Create;
    try
      scenario_id := Random(7);
      case scenario_id of
        0: begin
          {$REGION 'Scenario 0'}
          fooInt1 := GetRandomMouseCoordinate(0,47);
          fooInt2 := GetRandomMouseCoordinate(1044,1079);
          inputList.Add(
            '[1] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[2] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          fooInt1 := GetRandomMouseCoordinate(0,45);
          fooInt2 := GetRandomMouseCoordinate(992,1033);
          inputList.Add(
            '[3] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[4] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          fooInt1 := GetRandomMouseCoordinate(3,255);
          fooInt2 := GetRandomMouseCoordinate(920,947);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        1: begin
          {$REGION 'Scenario 1'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(0,45);
          fooInt2 := GetRandomMouseCoordinate(992,1033);
          inputList.Add(
            '[3] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[4] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          fooInt1 := GetRandomMouseCoordinate(3,255);
          fooInt2 := GetRandomMouseCoordinate(920,947);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        2: begin
          {$REGION 'Scenario 2'}
          inputList.Add(            '[1] [Key] [Left Alt] [WM_SYSKEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [F4] [WM_SYSKEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [F4] [WM_SYSKEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Left Alt] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [Enter] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [Ente] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        3: begin
          {$REGION 'Scenario 3'}
          inputList.Add(            '[1] [Key] [Left Alt] [WM_SYSKEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [F4] [WM_SYSKEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [F4] [WM_SYSKEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Left Alt] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(937,1020);
          fooInt2 := GetRandomMouseCoordinate(500,520);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        4: begin
          {$REGION 'Scenario 4'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [r] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [r] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [c] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [c] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [m] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [m] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [d] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [h] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [h] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [u] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [u] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [t] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [t] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [d] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [o] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [o] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [w] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [w] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [n] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [n] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [ ] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [ ] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [-] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [-] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[35] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[36] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        5: begin
          {$REGION 'Scenario 5'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [o] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [m] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [a] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [a] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [n] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [n] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [d] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [ ] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [ ] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [p] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [p] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [o] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [m] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [p] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [p] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [t] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [t] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[35] [Key] [h] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[36] [Key] [h] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[37] [Key] [u] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[38] [Key] [u] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[39] [Key] [t] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[40] [Key] [t] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[41] [Key] [d] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[42] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[43] [Key] [o] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[44] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[45] [Key] [w] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[46] [Key] [w] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[47] [Key] [n] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[48] [Key] [n] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[49] [Key] [ ] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[50] [Key] [ ] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[51] [Key] [-] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[52] [Key] [-] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[53] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[54] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[55] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[56] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        6: begin
          {$REGION 'Scenario 6'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [m] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [m] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [d] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [h] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [h] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [u] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [u] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [t] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [t] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [d] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [o] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [o] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [w] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [w] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [n] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [n] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [ ] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [ ] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [-] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [-] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
      end;
      fooString := workDir + '\Generated_data\shutdown_' + IntToStr(currentRun) + '.szd';
      inputList.SaveToFile(fooString);
      AddToLog('Saved ' + fooString + '. (Scenario ' + IntToStr(scenario_id) + '.)');
    finally
      inputList.Free;
    end;
    currentRun := currentRun + 1;
  end;
  AddToLog('Generation complete.');
end;
{$ENDREGION}
{$REGION 'Generate - Computer restart'}
procedure TForm_Generator.Generate_ComputerRestart(count: Integer);
var
  scenario_id: integer;
  inputList: TStringList;
  currentRun: integer;
  fooInt1, fooInt2: integer;
  fooString: string;
begin
  Randomize;
  currentRun := 1;
  while currentRun <= count do begin
    inputList := TStringList.Create;
    try
      scenario_id := Random(7);
      case scenario_id of
        0: begin
          {$REGION 'Scenario 0'}
          fooInt1 := GetRandomMouseCoordinate(0,47);
          fooInt2 := GetRandomMouseCoordinate(1044,1079);
          inputList.Add(
            '[1] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[2] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          fooInt1 := GetRandomMouseCoordinate(0,45);
          fooInt2 := GetRandomMouseCoordinate(992,1033);
          inputList.Add(
            '[3] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[4] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          fooInt1 := GetRandomMouseCoordinate(3,255);
          fooInt2 := GetRandomMouseCoordinate(951,981);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        1: begin
          {$REGION 'Scenario 1'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(0,45);
          fooInt2 := GetRandomMouseCoordinate(992,1033);
          inputList.Add(
            '[3] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[4] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          fooInt1 := GetRandomMouseCoordinate(3,255);
          fooInt2 := GetRandomMouseCoordinate(951,981);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        2: begin
          {$REGION 'Scenario 2'}
          inputList.Add(            '[1] [Key] [Left Alt] [WM_SYSKEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [F4] [WM_SYSKEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [F4] [WM_SYSKEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Left Alt] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(772,1131);
          fooInt2 := GetRandomMouseCoordinate(406,427);
          inputList.Add(
            '[5] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[6] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          fooInt1 := GetRandomMouseCoordinate(937,1020);
          fooInt2 := GetRandomMouseCoordinate(500,520);
          inputList.Add(
            '[7] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[8] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          {$ENDREGION}
        end;
        3: begin
          {$REGION 'Scenario 3'}
          inputList.Add(            '[1] [Key] [Left Alt] [WM_SYSKEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [F4] [WM_SYSKEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [F4] [WM_SYSKEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Left Alt] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [Arrow: Down] [WM_KEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [Arrow: Down] [WM_KEYUP] [' +      IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [Enter] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [Enter] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        4: begin
          {$REGION 'Scenario 4'}
          inputList.Add(            '[1] [Key] [Left Alt] [WM_SYSKEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [F4] [WM_SYSKEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [F4] [WM_SYSKEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Left Alt] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [Arrow: Down] [WM_KEYDOWN] [' +    IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [Arrow: Down] [WM_KEYUP] [' +      IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(937,1020);
          fooInt2 := GetRandomMouseCoordinate(500,520);
          inputList.Add(
            '[7] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[8] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );


          {$ENDREGION}
        end;
        5: begin
          {$REGION 'Scenario 5'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [r] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [r] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [c] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [c] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [m] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [m] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [d] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [h] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [h] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [u] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [u] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [t] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [t] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [d] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [o] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [o] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [w] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [w] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [n] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [n] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [ ] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [ ] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [-] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [-] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [r] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [r] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[35] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[36] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        6: begin
          {$REGION 'Scenario 6'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [o] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [m] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [a] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [a] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [n] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [n] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [d] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [ ] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [ ] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [p] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [p] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [o] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [m] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [p] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [p] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [t] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [t] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[35] [Key] [h] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[36] [Key] [h] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[37] [Key] [u] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[38] [Key] [u] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[39] [Key] [t] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[40] [Key] [t] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[41] [Key] [d] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[42] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[43] [Key] [o] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[44] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[45] [Key] [w] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[46] [Key] [w] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[47] [Key] [n] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[48] [Key] [n] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[49] [Key] [ ] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[50] [Key] [ ] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[51] [Key] [-] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[52] [Key] [-] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[53] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[54] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[55] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[56] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        7: begin
          {$REGION 'Scenario 7'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [m] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [m] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [d] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [s] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [s] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [h] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [h] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [u] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [u] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [t] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [t] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[19] [Key] [d] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[20] [Key] [d] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[21] [Key] [o] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[22] [Key] [o] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[23] [Key] [w] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[24] [Key] [w] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[25] [Key] [n] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[26] [Key] [n] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[27] [Key] [ ] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[28] [Key] [ ] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[29] [Key] [-] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[30] [Key] [-] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[31] [Key] [r] [WM_KEYDOWN] [' +            IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[32] [Key] [r] [WM_KEYUP] [' +              IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[33] [Key] [Enter] [WM_KEYDOWN] [' +        IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[34] [Key] [Enter] [WM_KEYUP] [' +          IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
      end;
      fooString := workDir + '\Generated_data\restart_' + IntToStr(currentRun) + '.szd';
      inputList.SaveToFile(fooString);
      AddToLog('Saved ' + fooString + '. (Scenario ' + IntToStr(scenario_id) + '.)');
    finally
      inputList.Free;
    end;
    currentRun := currentRun + 1;
  end;
  AddToLog('Generation complete.');
end;
{$ENDREGION}
{$REGION 'Generate - Browser launch'}
procedure TForm_Generator.Generate_BrowserLaunch(count: Integer);
var
  scenario_id: integer;
  inputList: TStringList;
  currentRun: integer;
  fooInt1, fooInt2: integer;
  fooString: string;
begin
  Randomize;
  currentRun := 1;
  while currentRun <= count do begin
    inputList := TStringList.Create;
    try
      scenario_id := Random(7);
      case scenario_id of
        0: begin
          {$REGION 'Scenario 0'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [m] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [s] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [s] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [ ] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [ ] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [d] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [g] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [g] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        1: begin
          {$REGION 'Scenario 1'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [e] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [d] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [d] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [g] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [g] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        2: begin
          {$REGION 'Scenario 2'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [h] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [h] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [m] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        3: begin
          {$REGION 'Scenario 3'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [b] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [b] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [o] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [w] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [w] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        4: begin
          {$REGION 'Scenario 4'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [e] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [d] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [d] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [g] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [g] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(48,390);
          fooInt2 := GetRandomMouseCoordinate(535,593);
          inputList.Add(
            '[11] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[12] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          {$ENDREGION}
        end;
        5: begin
          {$REGION 'Scenario 5'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [c] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [c] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [h] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [h] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [m] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(48,390);
          fooInt2 := GetRandomMouseCoordinate(535,593);
          inputList.Add(
            '[15] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[116] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          {$ENDREGION}
        end;
        6: begin
          {$REGION 'Scenario 6'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +     IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [Windows] [WM_KEYUP] [' +       IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [b] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [b] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [o] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [w] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [w] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          fooInt1 := GetRandomMouseCoordinate(48,390);
          fooInt2 := GetRandomMouseCoordinate(535,593);
          inputList.Add(
            '[17] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[18] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );

          {$ENDREGION}
        end;
        7: begin
          {$REGION 'Scenario 7'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [r] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [r] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [m] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [m] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [s] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [s] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [e] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [d] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [d] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [g] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [g] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        8: begin
          {$REGION 'Scenario 8'}
          inputList.Add(            '[1] [Key] [Windows] [WM_KEYDOWN] [' +       IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[2] [Key] [r] [WM_KEYUP] [' +               IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[3] [Key] [r] [WM_KEYDOWN] [' +             IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [Windows] [WM_KEYUP] [' +         IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [c] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [c] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [h] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [h] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [o] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [m] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [m] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;
        9: begin
          {$REGION 'Scenario 9'}
          fooInt1 := GetRandomMouseCoordinate(0,47);
          fooInt2 := GetRandomMouseCoordinate(1044,1079);
          inputList.Add(
            '[1] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[2] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          inputList.Add(            '[3] [Key] [b] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [b] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [r] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [r] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [o] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [o] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [w] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [w] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [s] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [s] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[13] [Key] [e] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[14] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[15] [Key] [r] [WM_KEYDOWN] [' +          IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[16] [Key] [r] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[17] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[18] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );

          {$ENDREGION}
        end;
        10: begin
          {$REGION 'Scenario 10'}
          fooInt1 := GetRandomMouseCoordinate(0,47);
          fooInt2 := GetRandomMouseCoordinate(1044,1079);
          inputList.Add(
            '[1] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONDOWN] [' +
            IntToStr(GetClickDelay(0)) + ']'
          );
          inputList.Add(
            '[2] [Mouse] [' +
            IntToStr(fooInt1) + ':' + IntToStr(fooInt2) + '] [WM_LBUTTONUP] [' +
            IntToStr(GetClickDelay(1)) + ']'
          );
          inputList.Add(            '[3] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[4] [Key] [e] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[5] [Key] [d] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[6] [Key] [d] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[7] [Key] [g] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[8] [Key] [g] [WM_KEYUP] [' +             IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[9] [Key] [e] [WM_KEYDOWN] [' +           IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[10] [Key] [e] [WM_KEYUP] [' +            IntToStr(GetClickDelay(1)) + ']'          );
          inputList.Add(            '[11] [Key] [Enter] [WM_KEYDOWN] [' +      IntToStr(GetClickDelay(0)) + ']'          );
          inputList.Add(            '[12] [Key] [Enter] [WM_KEYUP] [' +        IntToStr(GetClickDelay(1)) + ']'          );
          {$ENDREGION}
        end;

      end;
      fooString := workDir + '\Generated_data\browserLaunch_' + IntToStr(currentRun) + '.szd';
      inputList.SaveToFile(fooString);
      AddToLog('Saved ' + fooString + '. (Scenario ' + IntToStr(scenario_id) + '.)');
    finally
      inputList.Free;
    end;
    currentRun := currentRun + 1;
  end;
  AddToLog('Generation complete.');
end;
{$ENDREGION}

{$REGION 'Get click delay'}
function TForm_Generator.GetClickDelay(_type: Integer): integer;
begin
  Result := 1000;
  case _type of
    // WM_LBUTTONDOWN.
    0: Result := Random(2000)+500;
    // WM_LBUTTONUP.
    1: Result := Random(60)+60
  end;

end;
{$ENDREGION}
{$REGION 'Get random mouse coordinate'}
function TForm_Generator.GetRandomMouseCoordinate(min, max: integer):integer;
begin
  Result := Random(max-min)+min;
end;
{$ENDREGION}

{$REGION '[Form] Close Query'}
procedure TForm_Generator.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Sender = Form_Generator then begin
    CanClose := False;
    Form_Generator.Hide;
  end;
end;
{$ENDREGION}
{$REGION '[Button Click] Generate'}
procedure TForm_Generator.Btn_GenerateClick(Sender: TObject);
begin

  AddToLog(
    'Starting generation of ' +  IntToStr(Spin_GenCount.Value) +
    ' flow in "' + RadGroup_GenCategory.Items[RadGroup_GenCategory.ItemIndex] + '" category...'
  );

  if not System.SysUtils.DirectoryExists(workDir + '\Generated_data\') then
    CreateDir(workDir + '\Generated_data');

  case RadGroup_GenCategory.ItemIndex of
    0: Generate_ComputerShutdown(Spin_GenCount.Value);
    1: Generate_ComputerRestart(Spin_GenCount.Value);
    2: Generate_BrowserLaunch(Spin_GenCount.Value);
  end;
end;
{$ENDREGION}
{$REGION 'Add to log }
procedure TForm_Generator.AddToLog(msg: string);
begin
  Mem_Log.Lines.Add(FormatDateTime('[yyyy.MM.dd. hh:mm:ss] ', Now()) + msg);
end;
{$ENDREGION}


end.
