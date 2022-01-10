unit Unit_FlowManager;

interface

uses
  Vcl.StdCtrls, Vcl.ExtCtrls, System.SysUtils;

type
  // Enumerations
  TInputType = (itClick, itKeyboard, itSpecialKey);

  // Linked List element
  TFlowElement = record
    inputType : TInputType;
    inputParam1 : string;
    inputParam2 : string;
    inputParam3 : string;
    inputParam4 : string;
    waitAfterAmount : integer;
    waitAfterTypeText : string;
    deleteButton : TButton;
    panelObject : TPanel;
    labelObject : TLabel;
  end;

  // Main class
  TFlowManager = class(TObject)
  private
    flowArray: array of TFlowElement;
  public
    function GetLength: integer;
    function GetElementDetails(index: integer): TFlowElement;

    procedure AddElement; //needs more params
//    procedure Remove(elementIndex: integer);
//    procedure Switch(index1, index2: integer);
//    procedure InsertAfter(index: integer);

//    procedure SaveToFile(savePath: string);
//    procedure LoadFromFile(loadPath: string);

    constructor Create();
//    destructor Destroy; override;
  end;

implementation

function TFlowManager.GetLength: integer;
begin
  Result := Length(flowArray);
end;

function TFlowManager.GetElementDetails(index:integer): TFlowElement;
begin
  Result := flowArray[index];
end;

procedure TFlowManager.AddElement;
begin
  SetLength(flowArray, Length(flowArray)+1);
  // UNFINISHED - needs more params
end;

constructor TFlowManager.Create;
begin
  try
    inherited Create;
  except
    on E: Exception do
      raise Exception.Create('Error creating flow manager: ' + E.Message);
  end;
end;




end.
