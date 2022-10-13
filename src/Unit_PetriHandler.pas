unit Unit_PetriHandler;

interface

uses
  Winapi.Windows, System.SysUtils;

type

  TStringArray = array of string;

  TPetriPlace = record
    name: string;
    fromList: TStringArray;
    toList: TStringArray;
    location: TPoint;
    recursionLock: boolean;
  end;

  TPetriTransition = record
    id: integer;
    fromList: TStringArray;
    toList: TStringArray;
    location: TPoint;
    recursionLock: boolean;
  end;

  TPetriCollection = class(TObject)
    places: array of TPetriPlace;
    transitions: array of TPetriTransition;
    objectSize: integer;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure NewPlace(_name: string; _fromList, _toList: TStringArray);
    procedure NewTransition(_id: integer; _fromList, _toList: TStringArray);
    function FindIndexOfPlace(name: string): integer;
    function FindIndexOfTransition(id: integer): integer;
    procedure MapTransitions();
    procedure MapPlaceLocation(currentTransition: TPetriTransition);
    procedure MapTransitionLocation(currentPlace: TPetriPlace);
    procedure UpdateList(var list: TStringArray; newValue: string);
    function GetMaxIndexInColumn(col: integer): integer;
  end;

implementation

{$REGION 'Find index of place'}
function TPetriCollection.FindIndexOfPlace(name: string): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < Length(places)-1) and (places[i].name <> name) do
    i := i+1;
  if (i <> Length(places)) and (places[i].name = name) then
    Result := i;
end;
{$ENDREGION}
{$REGION 'Find index of transition'}
function TPetriCollection.FindIndexOfTransition(id: integer): integer;
var
  i: integer;
begin
  Result := -1;
  i := 0;
  while (i < Length(transitions)-1) and (transitions[i].id <> id) do
    i := i+1;
  if (i < Length(transitions)) and (transitions[i].id = id) then
    Result := i;
end;
{$ENDREGION}

{$REGION 'New place'}
procedure TPetriCollection.NewPlace(_name: string; _fromList, _toList: TStringArray);
begin
  SetLength(places, Length(places)+1);
  places[Length(places)-1].name := _name;
  SetLength(places[Length(places)-1].fromList, Length(_fromList));
  places[Length(places)-1].fromList := _fromList;
  SetLength(places[Length(places)-1].toList, Length(_toList));
  places[Length(places)-1].toList := _toList;
  places[Length(places)-1].location.X := -1;
  places[Length(places)-1].location.Y := -1;
end;
{$ENDREGION}
{$REGION 'New transition'}
procedure TPetriCollection.NewTransition(_id: integer; _fromList, _toList: TStringArray);
begin
  SetLength(transitions, Length(transitions)+1);
  transitions[Length(transitions)-1].id := _id;
  SetLength(transitions[Length(transitions)-1].fromList, Length(_fromList));
  transitions[Length(transitions)-1].fromList := _fromList;
  SetLength(transitions[Length(transitions)-1].toList, Length(_toList));
  transitions[Length(transitions)-1].toList := _toList;
  transitions[Length(transitions)-1].location.X := -1;
  transitions[Length(transitions)-1].location.Y := -1;
end;
{$ENDREGION}

{$REGION 'Map transitions'}
procedure TPetriCollection.MapTransitions;
var
  i,j: integer;
  newFromList, newToList: TStringArray;
  transitionIndex: integer;
begin
  for i := 0 to Length(places)-1 do begin
    for j := 0 to Length(places[i].fromList)-1 do begin
      transitionIndex := FindIndexOfTransition(StrToInt(places[i].fromList[j]));
      if transitionIndex = -1 then begin
        // Transition doesn't exist yet, create new.
        SetLength(newToList, 1);
        newToList[0] := places[i].name;
        SetLength(newFromList, 0);
        NewTransition(StrToInt(places[i].fromList[j]), newFromList, newToList);
      end else begin
        // Transition exists, update fromList and toList as neccessary
        UpdateList(transitions[transitionIndex].toList, places[i].name);
      end;
    end;

    for j := 0 to Length(places[i].toList)-1 do begin
      transitionIndex := FindIndexOfTransition(StrToInt(places[i].toList[j]));
      if transitionIndex = -1 then begin
        // Transition doesn't exist yet, create new.
        SetLength(newToList, 0);
        SetLength(newFromList, 1);
        newFromList[0] := places[i].name;
        NewTransition(StrToInt(places[i].toList[j]), newFromList, newToList);
      end else begin
        // Transition exists, update fromList and toList as neccessary
        UpdateList(transitions[transitionIndex].fromList, places[i].name);
      end;
    end;


  end;
end;
{$ENDREGION}
{$REGION 'Map Place location'}
procedure TPetriCollection.MapPlaceLocation(currentTransition: TPetriTransition);
var
  i: integer;
  currentIndex: integer;
begin
  if not transitions[FindIndexOfTransition(currentTransition.id)].recursionLock then begin
    transitions[FindIndexOfTransition(currentTransition.id)].recursionLock:= True;
    for i := 0 to Length(currentTransition.toList)-1 do begin
      currentIndex := FindIndexOfPlace(currentTransition.toList[i]);
      places[currentIndex].location.X := currentTransition.location.X+1;
      if places[currentIndex].location.Y = -1 then
        places[currentIndex].location.Y := GetMaxIndexInColumn(places[currentIndex].location.X) + 1;
      MapTransitionLocation(places[currentIndex]);
    end;
  end;

end;
{$ENDREGION}
{$REGION 'Map Transition location'}
procedure TPetriCollection.MapTransitionLocation(currentPlace: TPetriPlace);
var
  i: integer;
  currentIndex: integer;
begin
  if not places[FindIndexOfPlace(currentPlace.name)].recursionLock then begin
    places[FindIndexOfPlace(currentPlace.name)].recursionLock:= True;
    for i := 0 to Length(currentPlace.toList)-1 do begin
      currentIndex := FindIndexOfTransition(StrToInt(currentPlace.toList[i]));
      transitions[currentIndex].location.X := currentPlace.location.X+1;
      if transitions[currentIndex].location.Y = -1 then
        transitions[currentIndex].location.Y := GetMaxIndexInColumn(transitions[currentIndex].location.X)+1;
      MapPlaceLocation(transitions[currentIndex]);
    end;
  end;
end;
{$ENDREGION}
{$REGION 'Get max index in column'}
function TPetriCollection.GetMaxIndexInColumn(col: Integer): integer;
var
  i: integer;
begin
  Result := -1;
  if col mod 2 = 0 then begin
    // Even colummn (Transition)
    for i := 0 to Length(transitions)-1 do
      if (transitions[i].location.X = col) and (transitions[i].location.Y > Result) then
        Result := transitions[i].location.Y;
  end else begin
    // Odd column (Place)
    for i := 0 to Length(places)-1 do
      if (places[i].location.X = col) and (places[i].location.Y > Result) then
        Result := places[i].location.Y;
  end;
end;
{$ENDREGION}


{$REGION 'Update list'}
procedure TPetriCollection.UpdateList(var list: TStringArray; newValue: string);
var
  i: integer;
begin
  i := 0;
  while (i < Length(list)) and (list[i] <> newValue) do
    i := i+1;
  if i = Length(list) then begin
    SetLength(list, Length(list)+1);
    list[Length(list)-1] := newValue;
  end;
end;
{$ENDREGION}

{$REGION 'Create'}
constructor TPetriCollection.Create;
begin
  inherited;
  SetLength(places, 0);
  SetLength(transitions, 0);
end;
{$ENDREGION}
{$REGION 'Destroy'}
destructor TPetriCollection.Destroy;
begin
  SetLength(places, 0);
  SetLength(transitions, 0);
  inherited;
end;
{$ENDREGION}

end.
