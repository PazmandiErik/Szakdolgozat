unit Unit_MinerResults;

interface

{$REGION 'Units'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, StrUtils, Unit_PetriHandler,
  System.Types, System.UITypes, Unit_Main;
{$ENDREGION}
{$REGION 'Types'}
type

  TArrayOfSets = array of array of array of integer;
  TFloatMatrix = array of array of double;
  TIntegerArray = array of integer;

  TForm_MinerResults = class(TForm)
    Pnl_EventLog: TPanel;
    Pnl_FootprintMatrix: TPanel;
    Pnl_Bottom: TPanel;
    StrGrid_EventLog: TStringGrid;
    Lab_EventLog_Title: TLabel;
    Lab_FootprintMatrix_Title: TLabel;
    StrGrid_FootprintMatrix: TStringGrid;
    Pnl_AllSets: TPanel;
    Pnl_PetriNet: TPanel;
    StrGrid_AllSets: TStringGrid;
    Lab_AllSets_Title: TLabel;
    Img_PetriNet: TImage;
    Lab_PetriNet: TLabel;
    ScrollBox_PetriNet: TScrollBox;
    Btn_SavePetri: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure StrGrid_FootprintMatrixMouseWheelUp(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure StrGrid_FootprintMatrixMouseWheelDown(Sender: TObject;
      Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure Btn_SavePetriClick(Sender: TObject);
  public
    procedure DrawPetriNet(arrayOfSets: TArrayOfSets); overload;
    procedure DrawPetriNet(dependencyMatrix, twoLoopMatrix, longDistanceMatrix: TFloatMatrix); overload;
    procedure DrawPlace(startX, startY: integer; lab: string);
    procedure DrawTransition(startX, startY: integer; lab: string);

    procedure DrawArrow(x1,y1,x2,y2: integer);

    function GetStartEvents(): TIntegerArray;
    function GetEndEvents(): TIntegerArray;
  end;

{$ENDREGION}
{$REGION 'Global variables'}
var
  Form_MinerResults: TForm_MinerResults;
{$ENDREGION}

implementation

{$R *.dfm}

{$REGION '[Form] Close Query'}
procedure TForm_MinerResults.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Sender = Form_MinerResults then begin
    CanClose := False;
    Form_MinerResults.Hide;
  end;
end;
{$ENDREGION}
{$REGION '[Form] Create'}
procedure TForm_MinerResults.FormCreate(Sender: TObject);
begin
  StrGrid_EventLog.Cells[0,0] := 'Trace ID';
  StrGrid_EventLog.Cells[1,0] := 'Activity';
  StrGrid_EventLog.Cells[2,0] := 'Elapsed time';
end;
{$ENDREGION}

{$REGION '[Button Click] Save Petri'}
procedure TForm_MinerResults.Btn_SavePetriClick(Sender: TObject);
begin
  Img_PetriNet.Picture.SaveToFile(workDir + '\PetriNet.bmp');
  showmessage('Image saved to: ' + workDir + '\PetriNet.bmp');
end;
{$ENDREGION}

{$REGION '[StrGrid] Footprint matrix - Mouse wheel down'}
procedure TForm_MinerResults.StrGrid_FootprintMatrixMouseWheelDown(
  Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if (Shift = [ssCtrl]) and (StrGrid_FootprintMatrix.DefaultColWidth >= 5) then begin
    StrGrid_FootprintMatrix.DefaultColWidth := StrGrid_FootprintMatrix.DefaultColWidth - 1;
    StrGrid_FootprintMatrix.DefaultRowHeight := StrGrid_FootprintMatrix.DefaultRowHeight - 1;
  end;
end;
{$ENDREGION}
{$REGION '[StrGrid] Footprint matrix - Mouse wheel up'}
procedure TForm_MinerResults.StrGrid_FootprintMatrixMouseWheelUp(
  Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if (Shift = [ssCtrl]) and (StrGrid_FootprintMatrix.DefaultColWidth <= 50) then begin
    StrGrid_FootprintMatrix.DefaultColWidth := StrGrid_FootprintMatrix.DefaultColWidth + 1;
    StrGrid_FootprintMatrix.DefaultRowHeight := StrGrid_FootprintMatrix.DefaultRowHeight + 1;
  end;
end;
{$ENDREGION}

{$REGION 'Draw petri net - Alpha miner'}
procedure TForm_MinerResults.DrawPetriNet(arrayOfSets: TArrayOfSets);
var
  i,j: integer;
  fooStringArray, fooStringArray2: TStringArray;
  startEvents,endEvents: TIntegerArray;
  currentIndex: integer;
  canvasCenterLine: integer;
  maxX: integer;
  maxY: integer;
  petriCollection: TPetriCollection;
begin
  // Set up Petri net
   petriCollection := TPetriCollection.Create();

  for i := 0 to Length(arrayOfSets)-1 do begin
    SetLength(fooStringArray, 0);
    SetLength(fooStringArray, Length(arrayOfSets[i][0]));
    SetLength(fooStringArray2, 0);
    SetLength(fooStringArray2, Length(arrayOfSets[i][1]));

    for j := 0 to Length(arrayOfSets[i][0])-1 do
      fooStringArray[j] := IntToStr(arrayOfSets[i][0][j]);
    for j := 0 to Length(arrayOfSets[i][1])-1 do
      fooStringArray2[j] := IntToStr(arrayOfSets[i][1][j]);

    petriCollection.NewPlace('p_' + IntToStr(i+1), fooStringArray, fooStringArray2);
  end;
  petriCollection.MapTransitions();

  // Get start events
  startEvents := GetStartEvents();
  // Get end events
  endEvents := GetEndEvents();

  // Set up place & transition locations for drawing later
  for i := 0 to Length(startEvents)-1 do begin
    try
      currentIndex := petriCollection.FindIndexOfTransition(startEvents[i]);
      petriCollection.transitions[currentIndex].location.X := 0;
      petriCollection.transitions[currentIndex].location.Y := i;
      petriCollection.MapPlaceLocation(petriCollection.transitions[currentIndex]);
    except
      ShowMessage('Error finding start event for ' + IntToStr(i) + '. index.');
    end;
  end;

  // Set up canvas
  maxX := -1;
  maxY := -1;
  for i := 0 to Length(petriCollection.places)-1 do begin
    if petriCollection.places[i].location.X > maxX then
      maxX := petriCollection.places[i].location.X;
    if petriCollection.places[i].location.Y > maxY then
      maxY := petriCollection.places[i].location.Y;    
  end;

  for i := 0 to Length(petriCollection.transitions)-1 do begin
    if petriCollection.transitions[i].location.X > maxX then
      maxX := petriCollection.transitions[i].location.X;
    if petriCollection.transitions[i].location.Y > maxY then
      maxY := petriCollection.transitions[i].location.Y;    
  end;    

  
  Img_PetriNet.Width := 500 + (maxX*50)*2;
  Img_PetriNet.Height := (250 + (maxY*50)*2)*2;
  canvasCenterLine := Round(Img_PetriNet.Height/2);

  // Draw input
  DrawPlace(50, canvasCenterLine-25, 'start');
  for i := 0 to Length(startEvents)-1  do begin
    currentIndex := petriCollection.FindIndexOfTransition(startEvents[i]);
    DrawArrow(
      100,
      canvasCenterLine,
      150 + (petriCollection.transitions[currentIndex].location.X*50)*2,
      (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2
    );
  end;

  // Draw places
  for i := 0 to Length(petriCollection.places)-1 do begin
    DrawPlace(
      150 + (petriCollection.places[i].location.X*50)*2,
      (canvasCenterLine-25) + (petriCollection.places[i].location.Y*50)*2,
      petriCollection.places[i].name
    );
    // Draw arrow to transitions
    for j := 0 to Length(petriCollection.places[i].toList)-1 do begin
      currentIndex := petriCollection.FindIndexOfTransition(StrToInt(petriCollection.places[i].toList[j]));
      DrawArrow(
        200 + (petriCollection.places[i].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.places[i].location.Y*50)*2,
        150 + (petriCollection.transitions[currentIndex].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2
      );
    end;
  end;

  
   // Draw transition
  for i := 0 to Length(petriCollection.transitions)-1 do begin
    DrawTransition(
      150 + (petriCollection.transitions[i].location.X*50)*2,
      (canvasCenterLine-25) + (petriCollection.transitions[i].location.Y*50)*2,
      IntToStr(petriCollection.transitions[i].id)
    );

    // Draw arrow to places
    for j := 0 to Length(petriCollection.transitions[i].toList)-1 do begin
      currentIndex := petriCollection.FindIndexOfPlace(petriCollection.transitions[i].toList[j]);
      DrawArrow(
        200 + (petriCollection.transitions[i].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.transitions[i].location.Y*50)*2,
        150 + (petriCollection.places[currentIndex].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.places[currentIndex].location.Y*50)*2
      );
    end;
  end;

  // Draw output
  DrawPlace(250 + (maxX*50)*2, canvasCenterLine-25, 'end');
  for i := 0 to Length(endEvents)-1  do begin
    currentIndex := petriCollection.FindIndexOfTransition(endEvents[i]);
    DrawArrow(
      200 + (petriCollection.transitions[currentIndex].location.X*50)*2,
      (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2,      
      250 + (maxX*50)*2,
      canvasCenterLine
    );
  end;

end;
{$ENDREGION}
{$REGION 'Draw petri net - Heuristic miner'}
procedure TForm_MinerResults.DrawPetriNet(dependencyMatrix, twoLoopMatrix, longDistanceMatrix: TFloatMatrix);
var
  petriCollection: TPetriCollection;
  i,j: integer;
  fooStringArray, fooStringArray2: TStringArray;
  startEvents,endEvents: TIntegerArray;
  currentIndex: integer;
  maxX, maxY, canvasCenterLine: integer;
begin
  // Set up Petri net
  petriCollection := TPetriCollection.Create();

  for i := 0 to Length(dependencyMatrix)-1 do begin
    // Iterate over column and find "from" places
    SetLength(fooStringArray, 0);
    for j := 0 to Length(dependencyMatrix)-1 do
      if dependencyMatrix[j][i] > 0 then begin
        SetLength(fooStringArray, Length(fooStringArray)+1);
        fooStringArray[Length(fooStringArray)-1] := IntToStr(j);
      end;
    // Iterate over row to find "to" places
    SetLength(fooStringArray2, 0);
    for j := 0 to Length(dependencyMatrix[i])-1 do
      if (dependencyMatrix[i][j] > 0) then begin
        SetLength(fooStringArray2, Length(fooStringArray2)+1);
        fooStringArray2[Length(fooStringArray2)-1] := IntToStr(j);
      end;
    // Create place if there is at least one "from" or "to" place
    if (Length(fooStringArray) > 0) or (Length(fooStringArray2) > 0) then
      petriCollection.NewPlace('p_' + IntToStr(i), fooStringArray, fooStringArray2);
  end;

  // Map transitions
  petriCollection.MapTransitions();
  // Get start events
  startEvents := GetStartEvents();
  // Get end events
  endEvents := GetEndEvents();

  // Set up place & transition locations for drawing later
  for i := 0 to Length(startEvents)-1 do begin
    try
      currentIndex := petriCollection.FindIndexOfTransition(startEvents[i]);
      petriCollection.transitions[currentIndex].location.X := 0;
      petriCollection.transitions[currentIndex].location.Y := i;
      petriCollection.MapPlaceLocation(petriCollection.transitions[currentIndex]);
    except
      ShowMessage('Error finding start event for ' + IntToStr(i) + '. index.');
    end;
  end;

  // Set up canvas
  maxX := -1;
  maxY := -1;
  for i := 0 to Length(petriCollection.places)-1 do begin
    if petriCollection.places[i].location.X > maxX then
      maxX := petriCollection.places[i].location.X;
    if petriCollection.places[i].location.Y > maxY then
      maxY := petriCollection.places[i].location.Y;
  end;
  for i := 0 to Length(petriCollection.transitions)-1 do begin
    if petriCollection.transitions[i].location.X > maxX then
      maxX := petriCollection.transitions[i].location.X;
    if petriCollection.transitions[i].location.Y > maxY then
      maxY := petriCollection.transitions[i].location.Y;
  end;


  Img_PetriNet.Width := 500 + (maxX*50)*2;
  Img_PetriNet.Height := (250 + (maxY*50)*2)*2;
  canvasCenterLine := Round(Img_PetriNet.Height/2);

  // Draw input
  DrawPlace(50, canvasCenterLine-25, 'start');
  for i := 0 to Length(startEvents)-1  do begin
    currentIndex := petriCollection.FindIndexOfTransition(startEvents[i]);
    DrawArrow(
      100,
      canvasCenterLine,
      150 + (petriCollection.transitions[currentIndex].location.X*50)*2,
      (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2
    );
  end;


  // Draw places
  for i := 0 to Length(petriCollection.places)-1 do begin
    DrawPlace(
      150 + (petriCollection.places[i].location.X*50)*2,
      (canvasCenterLine-25) + (petriCollection.places[i].location.Y*50)*2,
      petriCollection.places[i].name
    );
    // Draw arrow to transitions
    for j := 0 to Length(petriCollection.places[i].toList)-1 do begin
      currentIndex := petriCollection.FindIndexOfTransition(StrToInt(petriCollection.places[i].toList[j]));
      DrawArrow(
        200 + (petriCollection.places[i].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.places[i].location.Y*50)*2,
        150 + (petriCollection.transitions[currentIndex].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2
      );
    end;
  end;

   // Draw transition
  for i := 0 to Length(petriCollection.transitions)-1 do begin
    DrawTransition(
      150 + (petriCollection.transitions[i].location.X*50)*2,
      (canvasCenterLine-25) + (petriCollection.transitions[i].location.Y*50)*2,
      IntToStr(petriCollection.transitions[i].id)
    );

    // Draw arrow to places
    for j := 0 to Length(petriCollection.transitions[i].toList)-1 do begin
      currentIndex := petriCollection.FindIndexOfPlace(petriCollection.transitions[i].toList[j]);
      DrawArrow(
        200 + (petriCollection.transitions[i].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.transitions[i].location.Y*50)*2,
        150 + (petriCollection.places[currentIndex].location.X*50)*2,
        (canvasCenterLine) + (petriCollection.places[currentIndex].location.Y*50)*2
      );
    end;
  end;

  // Draw output
  DrawPlace(250 + (maxX*50)*2, canvasCenterLine-25, 'end');
  for i := 0 to Length(endEvents)-1  do begin
    currentIndex := petriCollection.FindIndexOfTransition(endEvents[i]);
    DrawArrow(
      200 + (petriCollection.transitions[currentIndex].location.X*50)*2,
      (canvasCenterLine) + (petriCollection.transitions[currentIndex].location.Y*50)*2,
      250 + (maxX*50)*2,
      canvasCenterLine
    );
  end;

end;
{$ENDREGION}

{$REGION 'Get start events'}
function TForm_MinerResults.GetStartEvents: TIntegerArray;
var
  i,j: integer;
  currentCase: integer;
  newElement: integer;
begin
  currentCase := -1;
  SetLength(Result, 0);
  for i := 1 to StrGrid_EventLog.RowCount-1 do begin
    if StrGrid_EventLog.Cells[0, i]  <> IntToStr(currentCase) then begin
      // Check if new element is present in array yet
      j := 0;
      newElement := StrToInt(RightStr(StrGrid_EventLog.Cells[1, i], Length(StrGrid_EventLog.Cells[1, i])-9));
      while (j<Length(Result)) and (Result[j] <> newElement) do
        j := j+1;
      if j = Length(Result) then begin
        SetLength(Result, Length(Result)+1);
        Result[Length(Result)-1] := newElement;
      end;
      currentCase := StrToInt(StrGrid_EventLog.Cells[0, i]);
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Get end events'}
function TForm_MinerResults.GetEndEvents: TIntegerArray;
var
  i,j: integer;
  currentCase: integer;
  newElement: integer;
begin
  currentCase := 1;
  SetLength(Result, 0);
  for i := 1 to StrGrid_EventLog.RowCount-1 do begin
    if StrGrid_EventLog.Cells[0, i] <> IntToStr(currentCase) then begin
      // Check if new element is present in array yet
      j := 0;
      newElement := StrToInt(RightStr(StrGrid_EventLog.Cells[1, i-1], Length(StrGrid_EventLog.Cells[1, i-1])-9));
      while (j<Length(Result)) and (Result[j] <> newElement) do
        j := j+1;
      if j = Length(Result) then begin
        SetLength(Result, Length(Result)+1);
        Result[Length(Result)-1] := newElement;
      end;
      currentCase := StrToInt(StrGrid_EventLog.Cells[0, i]);
    end;
  end;

  // Only one case, add it
  if (currentCase = 1) and (Length(Result) = 0) then begin
    SetLength(Result, 1);
    Result[0] := StrToInt(
      RightStr(
        StrGrid_EventLog.Cells[1, StrGrid_EventLog.RowCount-1],
        Length(StrGrid_EventLog.Cells[1, StrGrid_EventLog.RowCount-1])-9
      )
    );
     
  end;
end;
{$ENDREGION}
{$REGION 'Draw place'}
procedure TForm_MinerResults.DrawPlace(startX: Integer; startY: Integer; lab: string);
var
  textWidth: integer;
  endX, endY: integer;
begin
  endX := startX + 50;
  endY := startY + 50;
  Img_PetriNet.Canvas.Ellipse(startX, startY, endX, endY);
  textWidth := Img_PetriNet.Canvas.TextWidth(lab);
  Img_PetriNet.Canvas.TextOut(
    Round((startX+endX)/2) - Round(textWidth/2),
    endY + 1,
    lab
  );
  Img_PetriNet.Canvas.MoveTo(endX, startY+25);
end;
{$ENDREGION}
{$REGION 'Draw transition'}
procedure TForm_MinerResults.DrawTransition(startX: Integer; startY: Integer; lab: string);
var
  textWidth, textHeight: integer;
  endX, endY: integer;
begin
  endX := startX + 50;
  endY := startY + 50;
  Img_PetriNet.Canvas.Rectangle(startX, startY, endX, endY);
  textWidth := Img_PetriNet.Canvas.TextWidth(lab);
  textHeight := Img_PetriNet.Canvas.TextHeight(lab);
  Img_PetriNet.Canvas.TextOut(
    Round((startX+endX)/2) - Round(textWidth/2),
    Round((startY+endY)/2) - Round(textHeight/2),
    lab
  );
  Img_PetriNet.Canvas.MoveTo(endX, startY+25);
end;
{$ENDREGION}

{$REGION 'Draw arrow'}
procedure TForm_MinerResults.DrawArrow(x1,y1,x2,y2: integer);
var
  HeadLength : real;
  HeadWidth : real;
  xbase : Integer;
  xLineDelta : Integer;
  xLineUnitDelta : Double;
  xNormalDelta : Integer;
  xNormalUnitDelta : Double;
  ybase : Integer;
  yLineDelta : Integer;
  yLineUnitDelta : Double;
  yNormalDelta : Integer;
  yNormalUnitDelta : Double;
begin
  Img_PetriNet.Canvas.MoveTo(x1, y1);
  Img_PetriNet.Canvas.LineTo(x2, y2);

  xLineDelta := x2 - x1;
  yLineDelta := y2 - y1;
  xLineUnitDelta := xLineDelta / Sqrt( Sqr(xLineDelta) + Sqr(yLineDelta));
  yLineUnitDelta := yLineDelta / Sqrt( Sqr(xLineDelta) + Sqr(yLineDelta));

  HeadLength := 12;
  HeadWidth := 2;
  xBase := x2 - Round(HeadLength * xLineUnitDelta);
  yBase := y2 - Round(HeadLength * yLineUnitDelta);
  
  xNormalDelta := yLineDelta;
  yNormalDelta := -xLineDelta;
  xNormalUnitDelta := xNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));
  yNormalUnitDelta := yNormalDelta / Sqrt(Sqr(xNormalDelta) + Sqr(yNormalDelta));
  
  Img_PetriNet.Canvas.Polygon(
    [Point(x2,y2),
    Point(xBase + Round(HeadWidth*xNormalUnitDelta), yBase + Round(HeadWidth*yNormalUnitDelta)),
    Point(xBase - Round(HeadWidth*xNormalUnitDelta), yBase - Round(HeadWidth*yNormalUnitDelta))
  ]);
end;
{$ENDREGION}



end.




