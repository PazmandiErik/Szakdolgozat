unit Unit_LinkedListHandler;

interface

uses
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Dialogs, Winapi.Windows, System.UITypes;

type

  // Enum
  TInputType = (itClick, itKeyboard, itSpecialKey, itHotkey);
  TWaitType = (wtMil, wtSec, wtMin, wtHour);

  // Linked List pointer type
  PFlowElement = ^TFlowElement;

  // Linked List element
  TFlowElement = record
    inputType : TInputType;
    inputParam1 : string;
    inputParam2 : string;
    inputParam3 : string;
    inputParam4 : string;
    waitAfterAmount : integer;
    waitAfterType : TWaitType;
    waitAfterTypeText : string;
    deleteButton : TButton;
    panelObject : TPanel;
    labelObject : TLabel;
    NextElement : PFlowElement;
  end;

function ClearLinkedList(): integer;

implementation

uses Unit_Main;

function ClearLinkedList(): integer;
var
  doNewFlow : boolean;
  confirmButton : integer;
  currentElement, prevElement : PFlowElement;
begin
  doNewFlow := false;
  if unsavedProgress then begin
    confirmButton := messagedlg('All unsaved changes will be lost.' + sLineBreak + 'Would you like to continue?', mtWarning, mbOkCancel, 0);
    if confirmButton = 1 then
      doNewFlow := true;
  end else
    doNewFlow := true;

  if doNewFlow then begin
    Result := 0;
    if flowHead.NextElement <> nil then begin
      currentElement := flowHead.NextElement;
    end else
      currentElement := flowHead;

    while currentElement.NextElement <> nil do begin
      prevElement := currentElement;
      currentElement := currentElement.NextElement;
      PostMessage(Form1.Handle, WM_KILLCONTROL, 0, integer(prevElement.panelObject));
      FreeMem(prevElement);
    end;
    if currentElement <> flowHead then begin
      PostMessage(Form1.Handle, WM_KILLCONTROL, 0, integer(currentElement.panelObject));
      FreeMem(currentElement);
    end;
    flowHead.NextElement := nil;
    Form1.Pnl_Flow.Width :=  0;
    Form1.Edt_WaitBetween.Text := '1';
    Form1.SE_TotalRuns.Text := '1';
    Form1.CB_WaitBetween.ItemIndex := 0;
  end else
    Result := 1;
end;



end.
