object Form_Generator: TForm_Generator
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Data Generation'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Mem_Log: TMemo
    Left = 0
    Top = 0
    Width = 640
    Height = 364
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 671
    ExplicitHeight = 281
  end
  object Pnl_Interface: TPanel
    Left = 0
    Top = 364
    Width = 640
    Height = 116
    Align = alBottom
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    TabOrder = 0
    ExplicitTop = 264
    ExplicitWidth = 671
    DesignSize = (
      640
      116)
    object Btn_Generate: TButton
      Left = 457
      Top = 63
      Width = 175
      Height = 41
      Anchors = [akRight, akBottom]
      Caption = 'Generate'
      TabOrder = 0
      OnClick = Btn_GenerateClick
      ExplicitLeft = 488
    end
    object RadGroup_GenCategory: TRadioGroup
      Left = 6
      Top = 6
      Width = 185
      Height = 104
      Align = alLeft
      Caption = 'Generation category'
      ItemIndex = 0
      Items.Strings = (
        'Computer shutdown'
        'Computer restart'
        'Browser launch')
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 105
    end
    object Spin_GenCount: TSpinEdit
      Left = 552
      Top = 35
      Width = 80
      Height = 22
      Anchors = [akRight, akBottom]
      Increment = 100
      MaxLength = 4
      MaxValue = 2000
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
  end
end
