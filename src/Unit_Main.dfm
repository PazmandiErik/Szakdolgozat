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
  object Pnl_Dashboard: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 0
    ExplicitHeight = 538
  end
  object Pnl_Flow: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 432
    ExplicitTop = 208
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  object Pnl_Scheduler: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 0
  end
  object Pnl_Settings: TPanel
    Left = 0
    Top = 21
    Width = 800
    Height = 579
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitLeft = -8
    ExplicitTop = 141
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
    ExplicitWidth = 185
  end
  object Tim_PostFormCreate: TTimer
    Interval = 20
    OnTimer = Tim_PostFormCreateTimer
    Left = 1200
    Top = 8
  end
end
