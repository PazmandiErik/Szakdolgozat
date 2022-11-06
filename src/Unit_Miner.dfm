object Form_Miner: TForm_Miner
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Miner'
  ClientHeight = 490
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel_Interface: TPanel
    Left = 0
    Top = 290
    Width = 650
    Height = 200
    Align = alBottom
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    DesignSize = (
      650
      200)
    object Pnl_DataPath: TPanel
      Left = 11
      Top = 11
      Width = 628
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Lab_DataPath: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 302
        Height = 14
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Path to flows:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 31
        ExplicitHeight = 13
      end
      object Edt_DataPath: TEdit
        Left = 308
        Top = 0
        Width = 300
        Height = 20
        Align = alRight
        TabOrder = 0
        TextHint = 'C:/'
        ExplicitHeight = 21
      end
      object Btn_DataPath_Browse: TButton
        Left = 608
        Top = 0
        Width = 20
        Height = 20
        Align = alRight
        Caption = '...'
        TabOrder = 1
        OnClick = Btn_DataPath_BrowseClick
      end
    end
    object Btn_Begin: TButton
      Left = 454
      Top = 140
      Width = 185
      Height = 50
      Anchors = [akRight, akBottom]
      Caption = 'Begin mining'
      TabOrder = 0
      OnClick = Btn_BeginClick
    end
    object RadGroup_MinerType: TRadioGroup
      Left = 454
      Top = 93
      Width = 185
      Height = 41
      Caption = 'Miner type'
      Columns = 2
      Items.Strings = (
        'Alpha'
        'Heuristic')
      TabOrder = 2
    end
  end
  object Mem_Log: TMemo
    Left = 0
    Top = 0
    Width = 650
    Height = 290
    Align = alClient
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
