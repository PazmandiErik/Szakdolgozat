unit Unit_Logger;

interface

uses
  System.Types, System.SysUtils, System.IOUtils;

type
  TLogger = class
  private
    logFolder: string;
    logArray: TStringDynArray;
  public
    constructor Create(logFolderPath: string);
    destructor Destroy; override;

    procedure Add(newLine: string);
    procedure Save();
    procedure RemoveRedundantLogs();
    function GetLog(): TStringDynArray;
  end;


implementation

// --------------------------------------------- Get log
function TLogger.GetLog(): TStringDynArray;
begin
  Result := logArray;
end;

// --------------------------------------------- Remove redundant logs
procedure TLogger.RemoveRedundantLogs();
var
  dirArray: TStringDynArray;
  currentDir: string;
  fileNameArray: TStringDynArray;
  currentFileName: string;
  fooFile: TextFile;
  fooString: string;
begin
  try
    dirArray := TDirectory.GetDirectories(logFolder);
    if Length(dirArray) > 0 then begin
      for currentDir in dirArray do begin
        fileNameArray := TDirectory.GetFiles(currentDir);
        for currentFileName in fileNameArray do begin
          assignFile(fooFile, currentFileName);
          try
            Reset(fooFile);
            ReadLn(fooFile, fooString);
            if fooString = logArray[0] then begin
              CloseFile(fooFile);
              DeleteFile(currentFileName);
            end;
          finally
            if TTextRec(fooFile).Mode <> 55216 then
              CloseFile(fooFile);
          end;
        end;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create('Error removing redundant logs: ' + E.Message);
  end;
end;

// --------------------------------------------- Add new line to log
procedure TLogger.Add(newLine: string);
begin
  try
    // Setup timestamp
    SetLength(logArray, Length(logArray)+1);
    logArray[Length(logArray)-1] := FormatDateTime('[yyyy.MM.dd. hh:mm:ss] ', Now()) + newLine;
  except
    on E: Exception do
      raise Exception.Create('Error adding new line to log: ' + E.Message);
  end;
end;

// --------------------------------------------- Save log to file
procedure TLogger.Save;
var
  saveFile: TextFile;
  currentLine: string;
  currentDayFolder: string;
begin
  try
    // Check if base folder exists, create if not
    if not (System.SysUtils.DirectoryExists(logFolder)) then
      CreateDir(logFolder);
    // Check if current day folder exists, create if not
    currentDayFolder := logFolder + FormatDateTime('yyyy_MM_dd', Now()) + '\';
    if not (System.SysUtils.DirectoryExists(currentDayFolder)) then
      CreateDir(currentDayFolder);
    // Create log file
    assignFile(saveFile, currentDayFolder + FormatDateTime('hh_mm_ss', Now()) + '.log');
    ReWrite(saveFile);
    // Save log to file
    for currentLine in logArray do
      WriteLn(saveFile, currentLine);
    // Finalize
    CloseFile(saveFile);

  except
    on E: Exception do
      raise Exception.Create('Error saving log: ' + E.Message);
  end;
end;

// --------------------------------------------- Constructor
constructor TLogger.Create(logFolderPath: string);
begin
  try
    logFolder := logFolderPath;
    if not (System.SysUtils.DirectoryExists(logFolderPath)) then
      CreateDir(logFolderPath);
    SetLength(logArray, 0);
    Add('Logger created.');
    inherited Create;
  except
    on E: Exception do
      raise Exception.Create('Error creating logger: ' + E.Message);
  end;
end;

// --------------------------------------------- Destructor
destructor TLogger.Destroy;
begin
  try
    SetLength(logArray, 0);
    inherited Destroy;
  except
    on E: Exception do
      raise Exception.Create('Error destroying logger: ' + E.Message);
  end;
end;


end.
