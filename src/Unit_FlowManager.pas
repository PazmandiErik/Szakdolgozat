unit Unit_FlowManager;

interface

uses
  Vcl.StdCtrls, Vcl.ExtCtrls, System.SysUtils, Vcl.Controls, System.Classes;

const
  FLOW_PANEL_HEIGHT = 50;

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

    procedure AddElement(var gridPanel: TGridPanel);
//    procedure Remove(elementIndex: integer);
//    procedure Switch(index1, index2: integer);
//    procedure InsertAfter(index: integer);

//    procedure SaveToFile(savePath: string);
//    procedure LoadFromFile(loadPath: string);

    constructor Create();
    destructor Destroy; override;
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

procedure TFlowManager.AddElement(var gridPanel: TGridPanel);
var
  newGridRow: TRowItem;
begin
  SetLength(flowArray, Length(flowArray)+1);
  with flowArray[Length(flowArray)-1] do begin
    // Create Panel & expand flow panel
    panelObject := TPanel.Create(gridPanel);

    if (Length(flowArray) mod 4) = 0 then begin
      newGridRow := gridPanel.RowCollection.Add();
      newGridRow.SizeStyle := ssAbsolute;
      newGridRow.Value := FLOW_PANEL_HEIGHT;
    end;
    panelObject.Name := 'Pnl_FlowMain_' + IntToStr(Length(flowArray));
    panelObject.Parent := gridPanel;
    panelObject.Font.Size := 12;
    panelObject.Caption := IntToStr(Length(flowArray));
    panelObject.Align := alClient;

    panelObject.Anchors := [akLeft, akTop];

  end;

  // Set height of Grid Panel for scrolling purposes
  gridPanel.Height := gridPanel.RowCollection.Count * FLOW_PANEL_HEIGHT;

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

destructor TFlowManager.Destroy;
begin

  // Maybe not sufficent? Destroying objects may be neccessary
  SetLength(flowArray, 0);
end;



end.
