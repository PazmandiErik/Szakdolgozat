object Form_MinerResults: TForm_MinerResults
  Left = 0
  Top = 0
  Caption = 'Miner Results'
  ClientHeight = 681
  ClientWidth = 1264
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_EventLog: TPanel
    Left = 0
    Top = 0
    Width = 340
    Height = 431
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Constraints.MaxWidth = 340
    Constraints.MinHeight = 431
    Constraints.MinWidth = 340
    TabOrder = 0
    object Lab_EventLog_Title: TLabel
      Left = 1
      Top = 1
      Width = 338
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'Event log'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 87
    end
    object StrGrid_EventLog: TStringGrid
      Left = 1
      Top = 26
      Width = 338
      Height = 404
      Align = alClient
      ColCount = 3
      DefaultColWidth = 104
      DoubleBuffered = True
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goThumbTracking]
      ParentDoubleBuffered = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Pnl_FootprintMatrix: TPanel
    Left = 340
    Top = 0
    Width = 924
    Height = 431
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Lab_FootprintMatrix_Title: TLabel
      Left = 1
      Top = 1
      Width = 922
      Height = 25
      Align = alTop
      Alignment = taCenter
      Caption = 'Footprint Matrix'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 148
    end
    object StrGrid_FootprintMatrix: TStringGrid
      Left = 1
      Top = 26
      Width = 922
      Height = 404
      Hint = 'Use Ctrl + Mouse wheel to zoom'
      Align = alClient
      ColCount = 2
      DefaultColWidth = 30
      DefaultRowHeight = 30
      DoubleBuffered = True
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goThumbTracking]
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnMouseWheelDown = StrGrid_FootprintMatrixMouseWheelDown
      OnMouseWheelUp = StrGrid_FootprintMatrixMouseWheelUp
    end
  end
  object Pnl_Bottom: TPanel
    Left = 0
    Top = 431
    Width = 1264
    Height = 250
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Constraints.MinHeight = 250
    TabOrder = 2
    object Pnl_AllSets: TPanel
      Left = 1
      Top = 1
      Width = 340
      Height = 248
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 0
      object Lab_AllSets_Title: TLabel
        Left = 1
        Top = 1
        Width = 338
        Height = 25
        Align = alTop
        Alignment = taCenter
        Caption = 'All sets'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 66
      end
      object StrGrid_AllSets: TStringGrid
        Left = 1
        Top = 26
        Width = 338
        Height = 221
        Align = alClient
        ColCount = 1
        DefaultColWidth = 340
        DoubleBuffered = True
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goThumbTracking]
        ParentDoubleBuffered = False
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Pnl_PetriNet: TPanel
      Left = 341
      Top = 1
      Width = 922
      Height = 248
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 1
      object Lab_PetriNet: TLabel
        Left = 1
        Top = 1
        Width = 920
        Height = 25
        Align = alTop
        Alignment = taCenter
        Caption = 'Petri net'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 80
      end
      object ScrollBox_PetriNet: TScrollBox
        Left = 1
        Top = 26
        Width = 920
        Height = 221
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Align = alClient
        TabOrder = 0
        object Img_PetriNet: TImage
          Left = 0
          Top = 0
          Width = 105
          Height = 105
          Stretch = True
        end
      end
    end
  end
end
