object Form_Main: TForm_Main
  Left = 274
  Top = 154
  BorderStyle = bsSingle
  ClientHeight = 730
  ClientWidth = 1290
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
  object Pnl_SideMenu: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 730
    Align = alLeft
    BevelOuter = bvNone
    Color = 15066597
    ParentBackground = False
    TabOrder = 0
  end
  object Pnl_Dashboard: TPanel
    Left = 200
    Top = 0
    Width = 1090
    Height = 730
    Align = alClient
    BevelOuter = bvNone
    Color = 15658734
    ParentBackground = False
    TabOrder = 1
  end
  object Tim_PostFormCreate: TTimer
    OnTimer = Tim_PostFormCreateTimer
    Left = 1200
    Top = 8
  end
end
