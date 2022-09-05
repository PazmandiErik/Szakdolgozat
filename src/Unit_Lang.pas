unit Unit_Lang;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, StrUtils,

  Types, IOUtils, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    RadGroup_Template: TRadioGroup;
    Btn_AddLanguage: TButton;
    Edt_Abbreviation: TEdit;
    Lab_Abbreviation: TLabel;
    Lab_LangName: TLabel;
    Edt_LanguageName: TEdit;
    Edt_FilePath: TEdit;
    Lab_FileName: TLabel;
    Btn_Browse: TButton;
    procedure Btn_AddLanguageClick(Sender: TObject);
    procedure Btn_BrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  filePath : string;

implementation

{$R *.dfm}

uses
  Unit_Main;

//------------------------------ ADD LANGUAGE
procedure TForm2.Btn_AddLanguageClick(Sender: TObject);
var
  i : integer;
  canAdd : boolean;
  errReason : string;
  testFile : textFile;
  templateList, newLang : TStringList;
begin
  canAdd := True;

  // Check if template is selected
  if (RadGroup_Template.ItemIndex = -1) then begin
    canAdd := False;
    errReason := f2dt_noTemplate;
  end else

  // Check if abbreviation is properly formatted
  if (Length(Edt_Abbreviation.Text) <> 2) then begin
    canAdd := False;
    errReason := f2dt_shortAbbrev;
  end else

  // Check if language is empty
  if (Length(Edt_LanguageName.Text) = 0) then begin
    canAdd := False;
    errReason := f2dt_noLangName;
  end;

  // Check if language exists
  for i := 0 to Length(availableLanguages)-1 do
    if (LowerCase(availableLanguages[i].displayText) = LowerCase(Edt_LanguageName.Text)) then begin
      canAdd := False;
      errReason := f2dt_langExists;
    end;

  // Check if abbrevation is already in use
  for i := 0 to Length(availableLanguages)-1 do
    if (LowerCase(availableLanguages[i].abbreviation) = LowerCase(Edt_Abbreviation.Text)) then begin
      canAdd := False;
      errReason := f2dt_abbrevUsed;
    end;

  // Check if file exists
  try
    AssignFile(testFile, Edt_FilePath.Text);
    Reset(testFile);
    CloseFile(testFile);
  except
    canAdd := False;
    errReason := f2dt_noFileExists;
  end;

  if canAdd then begin
    // Check if number of lines match template
    templateList := TStringList.Create();
    templateList.LoadFromFile(workDir + '\Data\Locale\template.ini');
    newLang := TStringList.Create();
    newLang.LoadFromFile(Edt_FilePath.Text);
    if newLang.Count <> templateList.Count then
    raise Exception.Create(
      f2dt_badLineNumber + ' ' + IntToStr(newLang.Count)+' / '+IntToStr(templateList.Count));

    if RadGroup_Template.ItemIndex = 0 then begin
      // Add Simple
      try
        for i := 0 to templateList.Count-1 do
          templateList[i] := templateList[i] + newLang[i];
        templateList.SaveToFile(workDir + '\Data\Locale\Locale_' + UpperCase(Edt_Abbreviation.Text) + '_' +
          Edt_LanguageName.Text + '.ini');
        showmessage(f2dt_finishedAddingLang);
        Form1.Show();
        Form2.Hide();
      except
        showmessage(f2dt_unknownErr);
      end;
    end else begin
      // Add advanced
      try
        CopyFile(PWideChar(Edt_FilePath.Text), PWideChar(
        workDir + '\Data\Locale\Locale_'
          + UpperCase(Edt_Abbreviation.Text) + '_' + Edt_LanguageName.Text + '.ini'), False);
        showmessage(f2dt_finishedAddingLang);
        Form1.Show();
        Form2.Hide();
      except
        showmessage(f2dt_unknownErr);
      end;
    end;
    // Load languages & free variables
    Form1.LoadLocaleFiles();
    templateList.Free;
    newLang.Free;
    end else begin
    //Can't add
    showmessage(errReason);
  end;
end;

//------------------------------ BROWSE BUTTON CLICK
procedure TForm2.Btn_BrowseClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
  try
    Options := [fdoStrictFileTypes];
    if Execute then begin
      filePath := FileName;
      Edt_FilePath.Text := fileName;
    end;
  finally
    Free;
  end;
end;

end.
