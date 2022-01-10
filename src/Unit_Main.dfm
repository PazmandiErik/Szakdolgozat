object Form_Main: TForm_Main
  Left = 274
  Top = 154
  BorderStyle = bsSingle
  Caption = 'Routine Assistant'
  ClientHeight = 600
  ClientWidth = 800
  Color = 15066597
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  GlassFrame.Enabled = True
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Scheduler: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Pnl_Settings: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Pnl_Settings_Footer: TPanel
      Left = 0
      Top = 499
      Width = 800
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object Lab_Credits: TLabel
        Left = 0
        Top = 0
        Width = 800
        Height = 80
        Align = alClient
        Alignment = taCenter
        Caption = 'Credits'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 49
        ExplicitHeight = 19
      end
    end
    object Combo_Styles: TComboBox
      Left = 8
      Top = 6
      Width = 145
      Height = 21
      Style = csDropDownList
      DropDownCount = 25
      Sorted = True
      TabOrder = 1
      OnChange = Combo_StylesChange
    end
  end
  object Pnl_Dashboard: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Welcome!'
    TabOrder = 4
  end
  object Pnl_Flow: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    Padding.Right = 3
    Padding.Bottom = 3
    TabOrder = 0
    object Pnl_Flow_Interface: TPanel
      Left = 0
      Top = 0
      Width = 281
      Height = 576
      Align = alLeft
      BevelOuter = bvNone
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      TabOrder = 0
      object Btn_LoadFlow: TButton
        AlignWithMargins = True
        Left = 8
        Top = 45
        Width = 265
        Height = 25
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Load'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Btn_NewFlow: TButton
        AlignWithMargins = True
        Left = 8
        Top = 10
        Width = 265
        Height = 25
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'New'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Btn_SaveFlow: TButton
        AlignWithMargins = True
        Left = 8
        Top = 80
        Width = 265
        Height = 25
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Save'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object Pnl_Flow_EditStep: TPanel
        Left = 5
        Top = 145
        Width = 271
        Height = 426
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 3
        object Pnl_EditStep_Header: TPanel
          Left = 0
          Top = 0
          Width = 267
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Lab_EditStep_Header: TLabel
            Left = 0
            Top = 0
            Width = 267
            Height = 33
            Align = alClient
            Alignment = taCenter
            Caption = 'Current step data'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 122
            ExplicitHeight = 19
          end
        end
      end
      object Btn_GenerateFlowSteps: TButton
        AlignWithMargins = True
        Left = 8
        Top = 115
        Width = 265
        Height = 25
        Margins.Top = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Generate steps'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
    end
    object SB_Flow_Actual: TScrollBox
      Left = 281
      Top = 0
      Width = 516
      Height = 576
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 312
      ExplicitTop = 296
      ExplicitWidth = 185
      ExplicitHeight = 41
      object Pnl_Flow_Actual: TGridPanel
        Left = 0
        Top = 0
        Width = 512
        Height = 572
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        ColumnCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ControlCollection = <>
        RowCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        TabOrder = 0
        ExplicitLeft = 281
        ExplicitWidth = 516
        ExplicitHeight = 576
      end
    end
  end
  object TabSet_Main: TTabSet
    Left = 0
    Top = 0
    Width = 800
    Height = 21
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = True
    Tabs.Strings = (
      'Dashboard'
      'Flow'
      'Scheduer'
      'Settings')
    OnChange = TabSet_MainChange
  end
  object Tim_PostFormCreate: TTimer
    Interval = 20
    OnTimer = Tim_PostFormCreateTimer
    Left = 1200
    Top = 8
  end
end
