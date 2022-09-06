{****************************************
►                                       ◄
►              Created by:              ◄
►             Pázmándi Erik             ◄
►         pazmandi.erik@gmail.com       ◄
►                                       ◄
****************************************}

unit Unit_ConfigHandler;

interface

uses
  System.Classes;

type

  TConfigHandler = class(TObject)
    configFile: string;
    configArray : array of array of string;

  public
    procedure Save(Key: string; Value: string);
    function Load(Key: string; Fallback: string): string;

    constructor Create(filePath: string);
    destructor Destroy; override;

    function Encrypt(const value: string): UnicodeString;
    function Decrypt(const value: string): UnicodeString;

    function MatchCharToArrayIndex(const character: char): integer;
  end;



const
  charArray: array[0..255] of WideChar = (
   'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
   'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
   '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '@', '#', '$', '%', '^', '&', '*', '(', ',', '.', '/', ';', '"', ':', '?',
   '>', '<', '=', '-', '`', '~', '[', ']', ')', '\', '{', '}', 'å', '®', 'þ', 'é', 'ü', 'ú', 'í', 'ó', 'ö', '«', '»', '¬', '¡', '²',
   '³', '¤', '€', '¼', '½', '¾', '‘', '’', '¥', '×', 'á', 'ß', 'ð', 'ø', '¶', '´', 'æ', '©', 'ñ', 'µ', 'ç', '¿', '+', 'Ͽ', 'Ͼ', 'Δ',
   'Θ', 'Ʃ', 'Ʊ', 'Ƶ', 'Ʒ', 'Ʌ', '■', 'ř', 'Ř', 'ű', '˙', '¨', '°', '¸', '÷', '§', '˘', 'ˇ', '˛', '˝', '´', 'ţ', 'Ý', 'ý', 'Ű', 'ŕ',
   'Ú', 'Ŕ', 'š', 'Š', 'ň', 'ń', 'Ń', 'Ô', 'ß', 'Ó', '▀', 'Ů', 'Ţ', '▄', '█', '┌', '┘', 'ě', 'Î', 'Í', 'Ň', 'Ë', 'Ď', '¤', '╬',
   '▓', '▒', '░', '»', '«', 'ş', 'Č', 'ź', '¬', 'ę', 'Ę', 'ž', '_', 'Ž', 'ą', 'Ą', '☺', '☻', '♥', '♦', '♣', '♠', '•', '◘', '◙',
   '♂', '♀', '♪', '♫', '☼', '►', '◄', '↕', '‼', '↨', '↑', '↓', '→', '←', '↔', '▲', '▼', 'ɯ', 'ʣ', 'ʧ', 'ʯ', 'ϑ', 'Ϟ', 'ϡ', 'ϫ',
   '╠', '╦', '╩', '╔', '╚', 'ă', 'Ă', '┼', '├', '┬', '┴', '└', '┐', 'ż', 'Ż', '╝', '╗', '║', '╣', 'Ş', 'Ě', ' ', 'Á', '┤', '│'
  );

implementation

uses
  StrUtils, System.Types, System.SysUtils, Winapi.Windows;

//------------------------------- MATCH CHAR TO ARRAY INDEX
function TConfigHandler.MatchCharToArrayIndex(const character: char): integer;
var
  i: integer;
begin
  i := 0;
  while (i <= 255) and (character <> charArray[i]) do
    i := i+1;

  if i > 255 then
    Result := -1
  else
    Result := i;
end;

//------------------------------- ENCRYPT
function TConfigHandler.Encrypt(const value: string): UnicodeString;
var
  i, j : integer;
  key: WideChar;
  matchedIndex, actualIndex: integer;
begin
  Randomize();
  j := 1;
  key := WideChar(75);
  Result := '';
  i := 1;
  repeat
    SetLength(Result, Length(Result)+1);
    if i mod 2 = 0 then begin
      matchedIndex := MatchCharToArrayIndex(value[j]);
      if matchedIndex >= 0 then begin
        if j mod 2 = 0 then begin
          actualIndex := (255 + (matchedIndex+ord(key)-64)) mod 255;
          Result[i] := charArray[actualIndex];
        end else begin
          actualIndex := (255 + (matchedIndex-ord(key)+64)) mod 255;
          Result[i] := charArray[actualIndex];
        end;
      end else
        raise Exception.Create('Configuration encoding exception: 0x01');
      j := j+1;
    end else begin
      Result[i] := WideChar(random(5)+35);
    end;
    i := i+1;
  until i > Length(value)*2;
end;

//------------------------------- DECRYPT
function TConfigHandler.Decrypt(const value: string): UnicodeString;
var
  i: integer;
  key: WideChar;
  matchedIndex: integer;
begin
  Result := '';
  key := WideChar(ord(75));
  i := 1;
  repeat
    if i mod 2 = 0 then begin
      SetLength(Result, Length(Result)+1);
      matchedIndex := MatchCharToArrayIndex(value[i]);
      if matchedIndex >= 0 then begin
        if Length(Result) mod 2 = 0 then
          Result[Length(Result)] := charArray[(255 + (matchedIndex-ord(key)+64)) mod 255]
        else
          Result[Length(Result)] := charArray[(255 + (matchedIndex+ord(key)-64)) mod 255];
      end else
        raise Exception.Create('Configuration encoding exception: 0x02');
    end;
    i := i+1;
  until i > Length(value);
end;

//------------------------------- LOAD
function TConfigHandler.Load(Key: string; Fallback: string): string;
var
  i : integer;
begin
  i := 0;
  while ((i < Length(configArray)-1) and (configArray[i][0] <> Key)) do
    i := i+1;
  if (configArray <> nil) and (configArray[i][0] = Key) then
    Result := configArray[i][1]
  else begin
    Save(Key, Fallback);
    Result := Fallback;
  end;
end;

//------------------------------- SAVE
procedure TConfigHandler.Save(Key: string; Value: string);
var
  i : integer;
  tempList : TStringList;
begin
  i := 0;
  while ((i < Length(configArray)) and (configArray[i][0] <> Key)) do
    i := i+1;
  if not(i >= Length(configArray)) then
    configArray[i][1] := Value
  else begin
    SetLength(configArray, Length(configArray)+1, 2);
    configArray[i][0] := Key;
    configArray[i][1] := Value
  end;

  tempList := TStringList.Create;
  for i := 0 to Length(configArray)-1 do begin
    tempList.Add(configArray[i][0] + '=' + configArray[i][1]);
    tempList[i] := Encrypt(tempList[i]);
  end;
  tempList.SaveToFile(configFile, TEncoding.UTF8);
  tempList.Free;

end;

//------------------------------- CONSTRUCTOR
constructor TConfigHandler.Create(filePath: string);
var
  configList : TStringList;
  fileHandle, i : integer;
  tempString : string;
  splitDelimiter : array[0..0] of Char;
  splitText : TStringDynArray;
begin
  configFile := filePath;

  configList := TStringList.Create;
  try
    configList.LoadFromFile(filePath, TEncoding.UTF8);
  except
    fileHandle := FileCreate(filePath);
    FileClose(fileHandle)
  end;
  SetLength(configArray,0,2);
  SetLength(splitText,2);
  splitDelimiter[0] := '=';
  for i := 0 to configList.Count-1 do begin
    tempString := configList[i];
    tempString := Decrypt(tempString);
    splitText := SplitString(tempstring, splitDelimiter);
    SetLength(configArray, Length(configArray)+1, 2);
    configArray[i][0] := splitText[0];
    configArray[i][1] := splitText[1];
  end;
  configList.Free;
end;

//------------------------------- DESTRUCTOR
destructor TConfigHandler.Destroy;
begin
  inherited Destroy;
end;

end.
