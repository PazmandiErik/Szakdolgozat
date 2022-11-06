unit Unit_Miner;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IOUtils, System.Types, StrUtils;

type
  TForm_Miner = class(TForm)
    Panel_Interface: TPanel;
    Mem_Log: TMemo;
    Edt_DataPath: TEdit;
    Pnl_DataPath: TPanel;
    Lab_DataPath: TLabel;
    Btn_DataPath_Browse: TButton;
    Btn_Begin: TButton;
    RadGroup_MinerType: TRadioGroup;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Btn_DataPath_BrowseClick(Sender: TObject);
    procedure Btn_BeginClick(Sender: TObject);
  private
    procedure AddToLog(msg: string);
    procedure AlphaMine();
    procedure HeuristicMine();
    procedure ChangeUserControl(newState: boolean);
    function RemoveBracketsFromString(str: string): string;
    function IsInActivityList(str: string): boolean;
    function GetNewActivityID: string;
    function FindActivityID(str: string): string;
    procedure ConstructEventLog();
  end;

var
  Form_Miner: TForm_Miner;
  activityList: array of array of string;
  eventLog: array of array of string;

implementation

uses
  Unit_Main, Unit_AuxiliaryFunctions, Unit_MinerResults;

{$R *.dfm}

{$REGION '[Button Click] Begin mining'}
procedure TForm_Miner.Btn_BeginClick(Sender: TObject);
begin
  try
    ChangeUserControl(False);
    if Length(Edt_DataPath.Text) > 3 then begin
      case RadGroup_MinerType.ItemIndex of
        0: begin
          AddToLog('Starting Alpha mining in: ' + Edt_DataPath.Text);
          AlphaMine();

        end;
        1: begin
          AddToLog('Starting Heuristic mining in: ' + Edt_DataPath.Text);
          HeuristicMine();
        end else begin
          AddToLog('Please select the miner type.');
        end;
      end;
    end else begin
      AddToLog('Invalid data path!');
    end;
  finally
    AddToLog('Finished.');
    ChangeUserControl(True);
  end;
end;
{$ENDREGION}
{$REGION '[Button Click] Browse Data Path'}
procedure TForm_Miner.Btn_DataPath_BrowseClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
    try
      DefaultFolder := workDir;
      Options := [fdoPickFolders];
      if Execute then begin
        Edt_DataPath.Text := FileName;
        configFile.Save('alphaminer_datapath', FileName);
      end;
    finally
      Free;
    end;
end;
{$ENDREGION}
{$REGION '[Form] Close Query'}
procedure TForm_Miner.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Sender = Form_Miner then begin
    CanClose := False;
    Form_Miner.Hide;
  end;
end;
{$ENDREGION}
{$REGION '[Form] Change User Control'}
procedure TForm_Miner.ChangeUserControl(newState: Boolean);
begin
  Btn_Begin.Enabled := newState;
  Edt_DataPath.Enabled := newState;
  Btn_DataPath_Browse.Enabled := newState;
end;
{$ENDREGION}
{$REGION 'Add to log }
procedure TForm_Miner.AddToLog(msg: string);
begin
  Mem_Log.Lines.Add(FormatDateTime('[yyyy.MM.dd. hh:mm:ss] ', Now()) + msg);
end;
{$ENDREGION}

{$REGION 'Construct event Log'}
procedure TForm_Miner.ConstructEventLog;
var
 currentTrace, elapsedTime: integer;
 currentFileName, fooString, activityName: string;
 fooStringList, splitText: TStringList;
begin
  AddToLog('Constructing event log from traces...');
  currentTrace := 0;
  SetLength(eventLog, 0, 3);
  SetLength(activityList, 0, 2);
  for currentFileName in TDirectory.GetFiles(Edt_DataPath.Text) do begin
    // Process current file
    fooStringList := TStringList.Create();
    try
      AddToLog('Processing ' + currentFileName + '.');
      fooStringList.LoadFromFile(currentFileName);
      currentTrace := currentTrace + 1;
      elapsedTime := 0;
      for fooString in fooStringList do begin
        // Process line in current file
        SetLength(eventLog, Length(eventLog)+1, 3);
        eventLog[Length(eventLog)-1][0] := IntToStr(currentTrace);

        // Split data line into individually processable elements
        splitText := TStringList.Create;
        try
          splitText.Text := RemoveBracketsFromString(SplitTempFlowLine(fooString));
          // Activity
          activityName := splitText[1] + ' ' + splitText[2] + ' ' + splitText[3];
          if IsInActivityList(activityName) then begin
            eventLog[Length(eventLog)-1][1] := FindActivityID(activityName)
          end else begin
            SetLength(activityList, Length(activityList)+1, 2);
            activityList[Length(activityList)-1][0] := activityName;
            activityList[Length(activityList)-1][1] := GetNewActivityID();
            eventLog[Length(eventLog)-1][1] := activityList[Length(activityList)-1][1];
          end;
          // Elapsed time
          eventLog[Length(eventLog)-1][2] := IntToStr(elapsedTime);
          elapsedTime := elapsedTime + StrToInt(splitText[4]);

        finally
          splitText.Free;
        end;
      end;
    finally
      fooStringList.Free;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Alpha mine'}
procedure TForm_Miner.AlphaMine();
var
  fooString: string;
  i,j,k,l,m : integer;
  footprintMatrix: array of array of integer; // 2d matrix
  currentActivity, nextActivity, prevActivity: integer;
  allSets: TArrayOfSets;
  finalSetList: TArrayOfSets; // after deleting non-maximals
  fooArray, fooArray2, dependenceIndexes: array of integer;
  elementsInSet: integer;
  isSubset: boolean;

begin
  ConstructEventLog();
  {$REGION 'Construct footprint matrix'}
  AddToLog('Event log constructed, converting into footprint matrix...');
  SetLength(footprintMatrix, Length(activityList), Length(activityList));
  // 0: Independence (#)
  // 1: Dependence ( -> )
  // 2: Inverse dependence ( <- )
  // 3: Parallel ( || )

  for i := 0 to Length(footprintMatrix)-1 do
    for j := 0 to Length(footprintMatrix)-1 do
      footprintMatrix[i][j] := 0;

  i := 0;
  while i < Length(eventLog) do begin
    currentActivity := StrToInt(eventLog[i][1]);
    // If current Activity is last element, do not check next one.
    if i < Length(eventLog)-1 then begin
      nextActivity := StrToInt(eventLog[i+1][1]);
      // Check if trace is matching
      if eventLog[i][0] = eventLog[i+1][0] then begin
        if footprintMatrix[currentActivity][nextActivity] = 0 then begin
          // Independent, make dependent
          footprintMatrix[currentActivity][nextActivity] := 1;
          footprintMatrix[nextActivity][currentActivity] := 2;
        end else if footprintMatrix[currentActivity][nextActivity] = 2 then begin
          // Inverse dependent, make parallel
          footprintMatrix[currentActivity][nextActivity] := 3;
          footprintMatrix[nextActivity][currentActivity] := 3;
        end;
      end;
    end;
    i := i+1;
  end;
  {$ENDREGION}
  {$REGION 'Calculate all sets (1:1)'}
  AddToLog('Calculating all possible set combinations...');
  SetLength(allSets, 0, 2, 0);
  for i := 0 to Length(footprintMatrix)-1 do begin
    for j := 0 to Length(footprintMatrix)-1 do begin
      if (footprintMatrix[i][j] = 1) then begin
        SetLength(allSets, Length(allSets)+1, 2, 1);
        allSets[Length(allSets)-1][0][0] := i;
        allSets[Length(allSets)-1][1][0] := j;
      end;
    end;
  end;
  {$ENDREGION}
  {$REGION 'Calculate all sets (1:n)'}
  for i := 0 to Length(footprintMatrix)-1 do begin
    SetLength(dependenceIndexes, 0);
    // Compute how many dependencies are in the current line.
    for j := 0 to Length(allSets)-1 do begin
      if (Length(allSets[j][1]) = 1) and (allSets[j][0][0] = i) then begin
        SetLength(dependenceIndexes, Length(dependenceIndexes)+1);
        dependenceIndexes[Length(dependenceIndexes)-1] := allSets[j][1][0];
      end;
    end;
    // Iterate over each dependency for multiple matchings on given line
    for j := 0 to Length(dependenceIndexes)-1 do begin
      SetLength(fooArray, 1);
      fooArray[0] := dependenceIndexes[j];
      // Iterate over footprint matrix and add to fooArray when set is independent
      for k := fooArray[0]+1 to Length(footprintMatrix)-1 do begin
        // Check if current element is a temporal dependency
        if (footprintMatrix[i][k] = 1) then begin
          // Iterate over fooArray to see if current element is added yet
          l := 0;
          while (l < Length(fooArray)) and (footprintMatrix[k][fooArray[l]] = 0) do
            l := l+1;
          if (l = Length(fooArray)) then begin
            SetLength(fooArray, Length(fooArray)+1);
            fooArray[Length(fooArray)-1] := k;
          end;
        end;
      end;
      // If element count in fooArray is > 1, add to allSets
      if Length(fooArray) > 1 then begin
        SetLength(allSets, Length(allSets)+1, 2);
        SetLength(allSets[Length(allSets)-1][0], 1);
        SetLength(allSets[Length(allSets)-1][1], Length(fooArray));
        allSets[Length(allSets)-1][0][0] := i;
        for k := 0 to Length(fooArray)-1 do begin
          allSets[Length(allSets)-1][1][k] := fooArray[k];
        end;
      end;
    end;
  end;
  {$ENDREGION}
  {$REGION 'Calculate all sets (n:1)'}
  for i := 0 to Length(footprintMatrix)-1 do begin
     SetLength(dependenceIndexes, 0);
    // Compute how many inverse dependencies are in the current line.
    for j := 0 to Length(allSets)-1 do begin
      if (Length(allSets[j][0]) = 1) and (allSets[j][1][0] = i) then begin
        // Check for duplicate indexes
        k := 0;
        while (k < Length(dependenceIndexes)) and (dependenceIndexes[k] <> allSets[j][0][0]) do
          k := k+1;
        if k = Length(dependenceIndexes) then begin
          SetLength(dependenceIndexes, Length(dependenceIndexes)+1);
          dependenceIndexes[Length(dependenceIndexes)-1] := allSets[j][0][0];
        end;
      end;
    end;

    // Iterate over each inverse dependency for multiple matchings on given line
    for j := 0 to Length(dependenceIndexes)-1 do begin
      SetLength(fooArray, 1);
      fooArray[0] := dependenceIndexes[j];
      // Iterate over footprint matrix and add to fooArray when set is independent
      for k := fooArray[0]+1 to Length(footprintMatrix)-1 do begin
        // Check if current element is a temporal inverse dependency
        if (footprintMatrix[i][k] = 2) then begin
          // Iterate over fooArray to see if current element is added yet
          l := 0;
          while (l < Length(fooArray)) and (footprintMatrix[k][fooArray[l]] = 0) do
            l := l+1;
          if (l = Length(fooArray)) then begin
            SetLength(fooArray, Length(fooArray)+1);
            fooArray[Length(fooArray)-1] := k;
          end;
        end;
      end;
      // If element count in fooArray is > 1, add to allSets
      if Length(fooArray) > 1 then begin
        SetLength(allSets, Length(allSets)+1, 2);
        SetLength(allSets[Length(allSets)-1][1], 1);
        SetLength(allSets[Length(allSets)-1][0], Length(fooArray));
        allSets[Length(allSets)-1][1][0] := i;
        for k := 0 to Length(fooArray)-1 do begin
          allSets[Length(allSets)-1][0][k] := fooArray[k];
        end;
      end;
    end;
  end;
  {$ENDREGION}
  {$REGION 'Calculate all sets (n:n)'}
  for i := 0 to Length(footprintMatrix)-1 do begin
    for j := 0 to Length(footprintMatrix)-1 do begin
      // Check if element is dependency
      if footprintMatrix[i][j] = 1 then begin
        // Add current elements to appropriate sets
        SetLength(fooArray, 1);
        SetLength(fooArray2, 1);
        fooArray[Length(fooArray)-1] := i;
        fooArray2[Length(fooArray2)-1] := j;

        // Iterate over remainder of matrix
        for k := i to Length(footprintMatrix)-1 do begin
          for l := j+1 to Length(footprintMatrix)-1 do  begin
            // Check if element is dependency
            if footprintMatrix[k][l] = 1 then begin
              // Check if element is independent of all elements in the set
              m := 0;
              while (m < Length(fooArray2)) and (l <> fooArray2[m]) and (footprintMatrix[l][fooArray2[m]] = 0) do
                m := m+1;
              if (m = Length(fooArray2)) then begin
                SetLength(fooArray2, Length(fooArray2)+1);
                fooArray2[Length(fooArray2)-1] := l;
              end;
            end else if footprintMatrix[k][l] = 2 then begin
              // Check if element is independent of all elements in the set
              m := 0;
              while (m < Length(fooArray)) and (l <> fooArray[m]) and (footprintMatrix[l][fooArray[m]] = 0) do
                m := m+1;
              if m = Length(fooArray) then begin
                SetLength(fooArray, Length(fooArray)+1);
                fooArray[Length(fooArray)-1] := l;
              end;
            end;
          end;
        end;

        // If element count in  both arrays is > 1, add to allSets
        if (Length(fooArray) > 1) and (Length(fooArray2) > 1) then begin
          SetLength(allSets, Length(allSets)+1, 2);
          SetLength(allSets[Length(allSets)-1][0], Length(fooArray));
          SetLength(allSets[Length(allSets)-1][1], Length(fooArray2));
          for k := 0 to Length(fooArray)-1 do begin
            allSets[Length(allSets)-1][0][k] := fooArray[k];
          end;
          for k := 0 to Length(fooArray2)-1 do begin
            allSets[Length(allSets)-1][1][k] := fooArray2[k];
          end;
        end;
      end;
    end;
  end;
  {$ENDREGION}
  {$REGION 'Remove non-maxmial sets'}
  SetLength(finalSetList, 0, 2, 0);

  for i := 0 to Length(allSets)-1 do begin

    // Save "A" set to fooArray
    SetLength(fooArray, Length(allSets[i][0]));
    for j := 0 to Length(allSets[i][0])-1 do begin
      fooArray[j] := allSets[i][0][j];
    end;
    
    // Save "B" set to fooArray2
    SetLength(fooArray2, Length(allSets[i][1]));
    for j := 0 to Length(allSets[i][1])-1 do begin
      fooArray2[j] := allSets[i][1][j];
    end;

    // Iterate over other sets
    isSubset := False;
    for j := 0 to Length(allSets)-1 do begin
      // Skip same index
      if j <> i then begin
        // Check if fooArray is part of the current set
        elementsInSet := 0;
        for k := 0 to Length(allSets[j][0])-1 do begin
          l := 0;
          while (l < Length(fooArray)-1) and (fooArray[l] <> allSets[j][0][k]) do
            l := l+1;
          if (fooArray[l] = allSets[j][0][k]) then
            elementsInSet := elementsInSet+1;
        end;
      
        if elementsInSet = Length(fooArray) then begin
          // fooArray is a subset - check if fooArray2 is subset too
          elementsInSet := 0;
          for k := 0 to Length(allSets[j][1])-1 do begin
            l := 0;
            while (l < Length(fooArray2)-1) and (fooArray2[l] <> allSets[j][1][k]) do
              l := l+1;
            if (fooArray2[l] = allSets[j][1][k]) then
              elementsInSet := elementsInSet+1;
          end;

          if elementsInSet = Length(fooArray2) then
            isSubset := True;
        end;
      end;
    end;




    if not isSubset then begin
      SetLength(finalSetList, Length(finalSetList)+1, 2);
      SetLength(finalSetList[Length(finalSetList)-1][0], Length(fooArray));
      SetLength(finalSetList[Length(finalSetList)-1][1], Length(fooArray2));
      for j := 0 to Length(fooArray)-1 do begin
        finalSetList[Length(finalSetList)-1][0][j] := fooArray[j];
      end;
      for j := 0 to Length(fooArray2)-1 do begin
        finalSetList[Length(finalSetList)-1][1][j] := fooArray2[j];
      end;
    end;

    SetLength(fooArray, 0);
    SetLength(fooArray2, 0);
  end;
  {$ENDREGION}
  {$REGION 'Display results on "MinerResults"'}  
  // Display results on "MinerResults" form
  AddToLog('Displaying results...');
  with Form_MinerResults do begin
    // Fill event log
    StrGrid_EventLog.RowCount := Length(eventLog)+1;
    for i := 0 to Length(eventLog)-1 do begin
      StrGrid_EventLog.Cells[0, i+1] := eventLog[i][0];
      StrGrid_EventLog.Cells[1, i+1] := 'Activity_' + eventLog[i][1];
      StrGrid_EventLog.Cells[2, i+1] := eventLog[i][2];
    end;

    // Fill footprint matrix
    Lab_FootprintMatrix_Title.Caption := 'Footprint Matrix';
    StrGrid_FootprintMatrix.ColCount := Length(footprintMatrix)+1;
    StrGrid_FootprintMatrix.RowCount := Length(footprintMatrix)+1;
    for i := 0 to Length(footprintMatrix)-1 do begin
      StrGrid_FootprintMatrix.Cells[0, i+1] := activityList[i][1];
      StrGrid_FootprintMatrix.Cells[i+1, 0] := activityList[i][1];
    end;

    for i := 0 to Length(footprintMatrix)-1 do begin
      for j := 0 to Length(footprintMatrix)-1 do begin
        case footprintMatrix[i][j] of
          0: StrGrid_FootprintMatrix.Cells[j+1,i+1] := '#';
          1: StrGrid_FootprintMatrix.Cells[j+1,i+1] := '→';
          2: StrGrid_FootprintMatrix.Cells[j+1,i+1] := '←';
          3: StrGrid_FootprintMatrix.Cells[j+1,i+1] := '||';
        end;
      end;
    end;

     // Show all sets
    StrGrid_AllSets.RowCount := Length(finalSetList)+1;
    for i := 0 to Length(finalSetList)-1 do begin
      fooString := '({';
      for j := 0 to Length(finalSetList[i])-1 do begin
        for k := 0 to Length(finalSetList[i][j])-1 do begin
          fooString := fooString + IntToStr(finalSetList[i][j][k]) + ',';
        end;
        fooString := LeftStr(fooString, Length(fooString)-1);
        fooString := fooString + '}, {'
      end;
      fooString := LeftStr(fooString, Length(fooString)-3);
      fooString := fooString + ')';
      StrGrid_AllSets.Cells[0, i] := fooString;
    end;
    Pnl_AllSets.Visible := True;
  end;

  // Draw Petri net
  try
    try
      Form_MinerResults.DrawPetriNet(finalSetList);
    except
      on E: Exception do
        ShowMessage('Error drawing Petri net:' + E.Message);
    end;
  finally
    Form_MinerResults.Show;
  end;
  {$ENDREGION}
end;
{$ENDREGION}
{$REGION 'Heuristic mine'}
procedure TForm_Miner.HeuristicMine();
var
  fooMatrix: array of array of double;
  dependencyMatrix: TFloatMatrix;
  i,j,k: integer;
  currentActivity, nextActivity: integer;
  // two-length loop vars
  twoLoopMatrix: TFloatMatrix;
  // long distance vars
  longDistanceMatrix: TFloatMatrix;
  totalOccurences: array of integer;
begin
  ConstructEventLog();
  {$REGION 'Direct sequence & 1 length loops'}
  SetLength(fooMatrix, Length(activityList), Length(activityList));
  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do
      fooMatrix[i][j] := 0;
  i := 0;
  while i < Length(eventLog) do begin
    currentActivity := StrToInt(eventLog[i][1]);
    // If current Activity is last element, do not check next one.
    if i < Length(eventLog)-1 then begin
      nextActivity := StrToInt(eventLog[i+1][1]);
      // Check if trace is matching
      if eventLog[i][0] = eventLog[i+1][0] then begin
        fooMatrix[currentActivity][nextActivity] := fooMatrix[currentActivity][nextActivity] + 1;
      end;
    end;
    i := i+1;
  end;
  SetLength(dependencyMatrix, Length(fooMatrix), Length(fooMatrix));

  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do begin
      if i = j then
        // Measure 1 length loops
        dependencyMatrix[i][j] := fooMatrix[i][j] / (fooMatrix[i][j] + 1)
      else
        // Measure direct sequence relations
        dependencyMatrix[i][j] :=(fooMatrix[i][j] - fooMatrix[j][i]) / ((fooMatrix[i][j] + fooMatrix[j][i]) + 1);
    end;
  {$ENDREGION}
  {$REGION 'Two-length loops'}
  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do
      fooMatrix[i][j] := 0;
  SetLength(twoLoopMatrix, Length(dependencyMatrix), Length(dependencyMatrix));
  for i := 0 to Length(twoLoopMatrix)-1 do
    for j := 0 to Length(twoLoopMatrix)-1 do
      twoLoopMatrix[i][j] := 0;

  // Iterate over activityList
  for i := 0 to Length(activityList)-1 do
    // i: main activity, j: secondary activity
    for j := 0 to Length(activityList)-1 do
      // Count these sequences in the event log. [Main] [Secondary] [Main]
      for k := 0 to Length(eventLog)-3 do
        // Check for a single trace
        if (eventLog[k][0] = eventLog[k+1][0]) and (eventLog[k+1][0] = eventLog[k+2][0]) then
          // Check if events are matching
          if (eventLog[k][1] = activityList[i][1]) and (eventLog[k+1][1] = activityList[j][1]) and
          (eventLog[k+2][1] = activityList[i][1]) then
            fooMatrix[i][j] := fooMatrix[i][j] + 1;

  // Calculate twoLengthMatrix values
  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do
      if i <> j then
        twoLoopMatrix[i][j] := (fooMatrix[i][j] + fooMatrix[j][i]) / ((fooMatrix[i][j] + fooMatrix[j][i]) + 1);
  {$ENDREGION}
  {$REGION 'Long-distance relations'}
  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do
      fooMatrix[i][j] := 0;
  SetLength(longDistanceMatrix, Length(fooMatrix), Length(fooMatrix));
  for i := 0 to Length(longDistanceMatrix)-1 do
    for j := 0 to Length(longDistanceMatrix)-1 do
      longDistanceMatrix[i][j] := 0;

  // Iterate over event log
  for i := 0 to Length(eventLog)-2 do begin
    j := i;
    k := j+1;
    while (k <= Length(eventLog)-1) and (eventLog[j][0] = eventLog[k][0]) do begin
      fooMatrix[StrToInt(eventLog[j][1])][StrToInt(eventLog[k][1])] :=
        fooMatrix[StrToInt(eventLog[j][1])][StrToInt(eventLog[k][1])] + 1;
      k := k +1;
    end;
  end;

  // Count event occurences
  SetLength(totalOccurences, Length(fooMatrix));
  for i := 0 to Length(totalOccurences)-1 do
    totalOccurences[i] := 0;

  for i := 0 to Length(eventLog)-1 do
    totalOccurences[StrToInt(eventLog[i][1])] := totalOccurences[StrToInt(eventLog[i][1])] + 1;

  // Build long-distance dependency matrix
  for i := 0 to Length(fooMatrix)-1 do
    for j := 0 to Length(fooMatrix)-1 do begin
      if fooMatrix[i][j] > totalOccurences[i] then
        fooMatrix[i][j] := totalOccurences[i];
      longDistanceMatrix[i][j] := (fooMatrix[i][j]) / (totalOccurences[i]+1);
    end;
  {$ENDREGION}
  {$REGION 'Display results'}
  AddToLog('Displaying results...');
  with Form_MinerResults do begin
    // Fill event log
    StrGrid_EventLog.RowCount := Length(eventLog)+1;
    for i := 0 to Length(eventLog)-1 do begin
      StrGrid_EventLog.Cells[0, i+1] := eventLog[i][0];
      StrGrid_EventLog.Cells[1, i+1] := 'Activity_' + eventLog[i][1];
      StrGrid_EventLog.Cells[2, i+1] := eventLog[i][2];
    end;

    // Fill new matrix
    Lab_FootprintMatrix_Title.Caption := 'Dependency Matrix';
    StrGrid_FootprintMatrix.ColCount := Length(dependencyMatrix)+1;
    StrGrid_FootprintMatrix.RowCount := Length(dependencyMatrix)+1;
    for i := 0 to Length(dependencyMatrix)-1 do begin
      StrGrid_FootprintMatrix.Cells[0, i+1] := activityList[i][1];
      StrGrid_FootprintMatrix.Cells[i+1, 0] := activityList[i][1];
    end;

    for i := 0 to Length(dependencyMatrix)-1 do begin
      for j := 0 to Length(dependencyMatrix)-1 do begin
         if dependencyMatrix[i][j] = 0 then
          StrGrid_FootprintMatrix.Cells[j+1,i+1] := '0'
         else
          StrGrid_FootprintMatrix.Cells[j+1,i+1] := FloatToStrF(dependencyMatrix[i][j], ffNumber, 15, 2);
      end;
    end;
    Pnl_AllSets.Visible := False;
  end;

  // Draw Petri net
  try
    try
      Form_MinerResults.DrawPetriNet(dependencyMatrix, twoLoopMatrix, longDistanceMatrix);
    except
      on E: Exception do
        ShowMessage('Error drawing Petri net:' + E.Message);
    end;
  finally
    Form_MinerResults.Show;
  end;

  {$ENDREGION}
end;
{$ENDREGION}

{$REGION 'Remove brackets from string'}
function TForm_Miner.RemoveBracketsFromString(str: string): string;
var
  c: char;
begin
  Result := '';
  for c in str do
    if (c <> '[') and (c <> ']') then
      Result := Result + c;
end;
{$ENDREGION}
{$REGION 'Find string in activity list'}
function TForm_Miner.IsInActivityList(str: string): boolean;
var
  i: integer;
begin
  if Length(activityList) = 0 then
    Exit(False);

  i := 0;
  while (i <> Length(activityList)) and (str <> activityList[i][0]) do
    i := i+1;

  if i = Length(activityList) then
    Result := False
  else
    Result := True;
end;
{$ENDREGION}
{$REGION 'Get new activity ID'}
function TForm_Miner.GetNewActivityID: string;
begin
  Result := IntToStr(Length(activityList)-1);
///  Result := 'Activity_' + IntToStr(Length(activityList)-1);
end;
{$ENDREGION}
{$REGION 'Find Activity ID'}
function TForm_Miner.FindActivityID(str: string): string;
var
  i: integer;
begin
  if Length(activityList) = 0 then
    Exit('ERROR FINDING ACTIVITY ID');

  i := 0;
  while (i <> Length(activityList)) and (str <> activityList[i][0]) do
    i := i+ 1;

  if i = Length(activityList) then
    Result := 'ERROR FINDING ACTIVITY ID'
  else
    Result := activityList[i][1];
end;
{$ENDREGION}


end.
