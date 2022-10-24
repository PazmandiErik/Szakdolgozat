object Form_Status: TForm_Status
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Form_Status'
  ClientHeight = 250
  ClientWidth = 250
  Color = clActiveBorder
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Main: TPanel
    Left = 5
    Top = 5
    Width = 240
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    BevelWidth = 5
    ParentBackground = False
    TabOrder = 0
    object Lab_Finish: TLabel
      Left = 0
      Top = 194
      Width = 240
      Height = 46
      Align = alBottom
      Alignment = taCenter
      Caption = 'To finish input capture,  hold [F2] + [F4]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 208
    end
    object Lab_Input: TLabel
      Left = 5
      Top = 63
      Width = 188
      Height = 114
      AutoSize = False
      Caption = '[Key] '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Lab_Input_Title: TLabel
      Left = 5
      Top = 34
      Width = 53
      Height = 23
      Caption = 'Input:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Lab_StepID: TLabel
      Left = 89
      Top = 5
      Width = 104
      Height = 23
      AutoSize = False
      Caption = '0 '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Lab_StepID_Title: TLabel
      Left = 5
      Top = 5
      Width = 78
      Height = 23
      Caption = 'Step no.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
  end
end
