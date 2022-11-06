object Form1: TForm1
  Left = 69
  Top = 77
  Caption = 'Form1'
  ClientHeight = 650
  ClientWidth = 570
  Color = clBtnFace
  Constraints.MinHeight = 650
  Constraints.MinWidth = 570
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  PrintScale = poNone
  Visible = True
  OnClose = FormClose
  OnResize = FormResize
  DesignSize = (
    570
    650)
  PixelsPerInch = 96
  TextHeight = 13
  object Lab_Edt_WaitAfter: TLabel
    Left = 321
    Top = 589
    Width = 53
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = 'Wait after:'
    ExplicitLeft = 273
    ExplicitTop = 524
  end
  object Pnl_SpecialKeys: TPanel
    Left = 0
    Top = 0
    Width = 570
    Height = 575
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    Visible = False
    DesignSize = (
      570
      575)
    object RadGroup_SpecialKeys: TRadioGroup
      Left = 1
      Top = 1
      Width = 568
      Height = 500
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Items.Strings = (
        'F1'
        'F2'
        'F3'
        'F4'
        'F5'
        'F6'
        'F7'
        'F8'
        'F9'
        'F10'
        'F11'
        'F12'
        'Arrow: Left'
        'Arrow: Right'
        'Arrow: Up'
        'Arrow: Down'
        'Backspace'
        'Caps Lock'
        'Carriage Return'
        'Escape'
        'Left Alt'
        'Left Control'
        'Left Shift'
        'Print Screen'
        'Right Alt'
        'Right Control'
        'Right Shift'
        'Space'
        'Tab'
        'Windows')
      ParentFont = False
      TabOrder = 0
    end
    object Btn_SpecialKeys_Close: TButton
      Left = 302
      Top = 505
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Close'
      TabOrder = 1
      OnClick = Btn_SpecialKeys_CloseClick
    end
    object CB_ExtraKey: TCheckBox
      Left = 154
      Top = 505
      Width = 97
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = 'Add Extra Key'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Edt_ExtraKey: TEdit
      Left = 264
      Top = 505
      Width = 19
      Height = 21
      Alignment = taCenter
      Anchors = [akBottom]
      MaxLength = 1
      TabOrder = 3
      Text = 'X'
    end
  end
  object Pnl_Schedule: TPanel
    Left = 6
    Top = 0
    Width = 570
    Height = 575
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    Visible = False
    DesignSize = (
      570
      575)
    object Lab_FlowRunAmount: TLabel
      Left = 206
      Top = 28
      Width = 212
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Run flow this many number of times:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 158
    end
    object Lab_WaitBetween: TLabel
      Left = 235
      Top = 63
      Width = 118
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Wait between flows:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 187
    end
    object Lab_Frequency: TLabel
      Left = 242
      Top = 204
      Width = 64
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Frequency:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 259
    end
    object Lab_FrequencyAmount: TLabel
      Left = 282
      Top = 233
      Width = 111
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Frequency amount:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 299
    end
    object Lab_ScheduleTitle: TLabel
      Left = 95
      Top = 144
      Width = 458
      Height = 26
      Alignment = taCenter
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Schedule saved flow'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      ExplicitLeft = 112
    end
    object Btn_Schedule_Close: TButton
      Left = 217
      Top = 467
      Width = 123
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'Close'
      TabOrder = 0
      OnClick = Btn_SpecialKeys_CloseClick
    end
    object SE_TotalRuns: TSpinEdit
      Left = 424
      Top = 22
      Width = 121
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 65535
      MinValue = 1
      TabOrder = 1
      Value = 1
      OnChange = SE_TotalRunsChange
    end
    object Edt_WaitBetween: TEdit
      Left = 359
      Top = 58
      Width = 54
      Height = 21
      Anchors = [akTop, akRight]
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 2
      Text = '1'
      OnChange = Edt_WaitBetweenChange
    end
    object CB_WaitBetween: TComboBox
      Left = 419
      Top = 58
      Width = 126
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      DropDownCount = 4
      ItemIndex = 1
      TabOrder = 3
      Text = 'Seconds'
      OnChange = CB_WaitBetweenChange
      Items.Strings = (
        'Millisecond'
        'Seconds'
        'Minutes'
        'Hours')
    end
    object Btn_AddSchedule: TButton
      Left = 463
      Top = 230
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Schedule'
      TabOrder = 4
      OnClick = Btn_AddScheduleClick
    end
    object DTP_ScheduleTime: TDateTimePicker
      Left = 463
      Top = 203
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Date = 43689.000000000000000000
      Time = 0.592504652770003300
      Kind = dtkTime
      TabOrder = 5
    end
    object Edt_ScheduleFilePath: TEdit
      Left = 95
      Top = 176
      Width = 370
      Height = 21
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 6
      Text = 'C:\...'
    end
    object Btn_BrowseSchF: TButton
      Left = 463
      Top = 176
      Width = 90
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Browse'
      TabOrder = 7
      OnClick = Btn_BrowseSchFClick
    end
    object CB_ScheduleFrequency: TComboBox
      Left = 312
      Top = 203
      Width = 145
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 8
      OnChange = CB_ScheduleFrequencyChange
      Items.Strings = (
        'Minute'
        'Hourly'
        'Daily'
        'Weekly'
        'Monthly'
        'Once'
        'OnLogon'
        'OnIdle')
    end
    object SE_FrequencyAmount: TSpinEdit
      Left = 399
      Top = 232
      Width = 58
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 1439
      MinValue = 1
      TabOrder = 9
      Value = 1
      OnChange = SE_TotalRunsChange
    end
  end
  object Pnl_FlowStatus: TPanel
    Left = -1
    Top = 385
    Width = 570
    Height = 190
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    Visible = False
    object Lab_Status: TLabel
      Left = 5
      Top = 5
      Width = 35
      Height = 19
      Caption = 'State'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Pnl_Keyboard: TPanel
    Left = 0
    Top = 385
    Width = 570
    Height = 121
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object Edt_KeyboardInput: TEdit
      Left = 8
      Top = 6
      Width = 501
      Height = 23
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 80
      ParentFont = False
      TabOrder = 0
      Text = 'Enter keyboard input here...'
    end
    object Btn_SpecialKeys_Open: TButton
      Left = 8
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Special Keys'
      TabOrder = 1
      OnClick = Btn_SpecialKeys_OpenClick
    end
  end
  object Btn_Add: TButton
    Left = 0
    Top = 608
    Width = 570
    Height = 42
    Align = alBottom
    Caption = 'Add'
    TabOrder = 4
    OnClick = Btn_AddClick
  end
  object Edt_WaitAfter: TEdit
    Left = 380
    Top = 581
    Width = 54
    Height = 21
    Anchors = [akRight, akBottom]
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 2
    Text = '1'
  end
  object CB_WaitAfter: TComboBox
    Left = 440
    Top = 581
    Width = 129
    Height = 21
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    DropDownCount = 4
    ItemIndex = 1
    TabOrder = 3
    Text = 'Seconds'
    Items.Strings = (
      'Millisecond'
      'Seconds'
      'Minutes'
      'Hours')
  end
  object Btn_Dummy: TButton
    Left = 0
    Top = -55
    Width = 48
    Height = 96
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = False
    Enabled = False
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    Visible = False
    OnClick = DeleteStep
  end
  object SB_Flow: TScrollBox
    Left = 0
    Top = 0
    Width = 570
    Height = 360
    HorzScrollBar.Increment = 46
    VertScrollBar.Visible = False
    Align = alTop
    TabOrder = 10
    object Pnl_Flow: TGridPanel
      Left = 2
      Top = 2
      Width = 0
      Height = 346
      BevelOuter = bvLowered
      BevelWidth = 3
      ColumnCollection = <
        item
          SizeStyle = ssAuto
          Value = 100.000000000000000000
        end>
      Constraints.MaxHeight = 346
      ControlCollection = <>
      ParentBackground = False
      RowCollection = <
        item
          SizeStyle = ssAuto
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAuto
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
          Value = 16.666666666666670000
        end
        item
          SizeStyle = ssAuto
          Value = 20.000000000000000000
        end
        item
          SizeStyle = ssAuto
          Value = 25.000000000000000000
        end
        item
          SizeStyle = ssAuto
          Value = 33.333333333333340000
        end
        item
          SizeStyle = ssAuto
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAuto
          Value = 100.000000000000000000
        end>
      TabOrder = 0
    end
  end
  object Btn_StartFlow: TButton
    Left = -1
    Top = 348
    Width = 570
    Height = 36
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Start Flow'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = Btn_StartFlowClick
  end
  object Pnl_Dummy: TPanel
    Left = 0
    Top = 0
    Width = 0
    Height = 0
    Caption = 'Pnl_Dummy'
    TabOrder = 11
    Visible = False
    OnMouseDown = Pnl_DummyMouseDown
    OnMouseUp = Pnl_DummyMouseUp
  end
  object Pnl_Mouse: TPanel
    Left = 56
    Top = 761
    Width = 570
    Height = 148
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      570
      148)
    object Lab_Edt_Cursor_X: TLabel
      Left = 8
      Top = 28
      Width = 45
      Height = 13
      Caption = 'Cursor X:'
    end
    object Lab_Edt_Cursor_Y: TLabel
      Left = 8
      Top = 55
      Width = 45
      Height = 13
      Caption = 'Cursor Y:'
    end
    object Lab_ClickType: TLabel
      Left = 169
      Top = 71
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Click Type'
      ExplicitLeft = 186
    end
    object Lab_Button: TLabel
      Left = 152
      Top = 35
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Mouse Button'
      ExplicitLeft = 169
    end
    object Edt_Cursor_X: TEdit
      Left = 67
      Top = 20
      Width = 54
      Height = 21
      NumbersOnly = True
      TabOrder = 0
    end
    object Edt_Cursor_Y: TEdit
      Left = 67
      Top = 47
      Width = 54
      Height = 21
      NumbersOnly = True
      TabOrder = 2
    end
    object Pnl_Cursor: TPanel
      Left = 425
      Top = 0
      Width = 130
      Height = 80
      Anchors = [akTop, akRight]
      TabOrder = 1
      object Lab_Cursor_Title: TLabel
        Left = 8
        Top = 6
        Width = 97
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Cursor Location'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
      end
      object Lab_Cursor_X: TLabel
        Left = 16
        Top = 27
        Width = 13
        Height = 13
        AutoSize = False
        Caption = 'x: 0'
      end
      object Lab_Cursor_Y: TLabel
        Left = 16
        Top = 35
        Width = 13
        Height = 13
        AutoSize = False
        Caption = 'y: 0'
      end
      object Btn_StartRecord: TButton
        Left = 1
        Top = 54
        Width = 128
        Height = 25
        Align = alBottom
        Caption = 'Start Recording (R)'
        TabOrder = 0
        TabStop = False
        OnClick = Btn_StartRecordClick
      end
    end
    object CB_ClickType: TComboBox
      Left = 224
      Top = 66
      Width = 145
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemIndex = 0
      TabOrder = 3
      Text = 'Down+Up (single)'
      Items.Strings = (
        'Down+Up (single)'
        'Down only (single)'
        'Up only (single)'
        'Down+Up (double)'
        'Down only (double)'
        'Up only (double)')
    end
    object CB_MouseButton: TComboBox
      Left = 227
      Top = 31
      Width = 145
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemIndex = 0
      TabOrder = 4
      Text = 'Left'
      Items.Strings = (
        'Left'
        'Right'
        'Middle')
    end
  end
  object ActionList1: TActionList
    Left = 16
    Top = 480
    object Act_Hotkey_Record: TAction
      Caption = 'Act_Hotkey_Record'
      ShortCut = 82
      OnExecute = Act_Hotkey_RecordExecute
    end
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 56
    Top = 480
    object File1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'File'
      object NewFlow1: TMenuItem
        AutoHotkeys = maManual
        Caption = 'New Flow'
        OnClick = NewFlow1Click
      end
      object N1: TMenuItem
        Tag = 1
        Caption = '-'
      end
      object Load1: TMenuItem
        AutoHotkeys = maManual
        Caption = 'Load'
        ImageIndex = 0
        OnClick = Load1Click
      end
      object Save1: TMenuItem
        AutoHotkeys = maManual
        Caption = 'Save'
        OnClick = Save1Click
      end
    end
    object Themes1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Themes'
    end
    object InputType1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Input Type'
      object Mouse1: TMenuItem
        AutoCheck = True
        AutoHotkeys = maManual
        Caption = 'Mouse'
        Checked = True
        RadioItem = True
        OnClick = InputChangeClick
      end
      object Key1: TMenuItem
        AutoCheck = True
        AutoHotkeys = maManual
        Caption = 'Keyboard Input'
        RadioItem = True
        OnClick = InputChangeClick
      end
      object StartRecordingInput1: TMenuItem
        AutoHotkeys = maManual
        Caption = 'Start Recording Input'
        OnClick = StartRecordingInput1Click
      end
    end
    object Schedule1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Schedule'
      OnClick = Schedule1Click
    end
    object GenerateData1: TMenuItem
      Caption = 'Generate data'
      OnClick = GenerateData1Click
    end
    object Mining1: TMenuItem
      Caption = 'Mining'
      OnClick = Mining1Click
    end
    object About1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'About'
      OnClick = About1Click
    end
    object Dummy1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Dummy'
      Enabled = False
      Visible = False
      OnClick = Dummy1Click
      object Dummy2: TMenuItem
        Caption = 'Dummy2'
        Enabled = False
        Visible = False
      end
    end
  end
  object Tim_WaitAfter: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Tim_WaitAfterTimer
    Left = 96
    Top = 480
  end
  object TrayIcon1: TTrayIcon
    BalloonTimeout = 1000
    OnDblClick = TrayIcon1DblClick
    Left = 136
    Top = 480
  end
  object Tim_PostFormCreate: TTimer
    Interval = 1
    OnTimer = Tim_PostFormCreateTimer
    Left = 216
    Top = 480
  end
  object Tim_FlowGenerateDebugger: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Tim_FlowGenerateDebuggerTimer
    Left = 272
    Top = 481
  end
end
