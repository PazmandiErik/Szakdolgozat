object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Language'
  ClientHeight = 175
  ClientWidth = 441
  Color = clBtnFace
  Constraints.MaxHeight = 204
  Constraints.MaxWidth = 447
  Constraints.MinHeight = 204
  Constraints.MinWidth = 447
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Lab_Abbreviation: TLabel
    Left = 327
    Top = 120
    Width = 61
    Height = 13
    Alignment = taRightJustify
    Caption = 'Abbreviation'
  end
  object Lab_LangName: TLabel
    Left = 224
    Top = 90
    Width = 76
    Height = 13
    Alignment = taRightJustify
    Caption = 'Language name'
  end
  object Lab_FileName: TLabel
    Left = 22
    Top = 63
    Width = 20
    Height = 13
    Alignment = taRightJustify
    Caption = 'File:'
  end
  object RadGroup_Template: TRadioGroup
    Left = 8
    Top = 5
    Width = 410
    Height = 49
    Caption = 'Template Type'
    Items.Strings = (
      'Simple'
      'Advanced')
    TabOrder = 0
  end
  object Btn_AddLanguage: TButton
    Left = 8
    Top = 144
    Width = 129
    Height = 27
    Caption = 'Add'
    TabOrder = 5
    OnClick = Btn_AddLanguageClick
  end
  object Edt_Abbreviation: TEdit
    Left = 394
    Top = 117
    Width = 24
    Height = 21
    MaxLength = 2
    TabOrder = 4
    Text = 'XX'
  end
  object Edt_LanguageName: TEdit
    Left = 306
    Top = 87
    Width = 112
    Height = 21
    MaxLength = 32
    TabOrder = 3
    Text = '...'
  end
  object Edt_FilePath: TEdit
    Left = 48
    Top = 60
    Width = 273
    Height = 21
    TabOrder = 1
    Text = 'C:\...'
  end
  object Btn_Browse: TButton
    Left = 327
    Top = 60
    Width = 91
    Height = 21
    Caption = 'Browse'
    TabOrder = 2
    OnClick = Btn_BrowseClick
  end
end
