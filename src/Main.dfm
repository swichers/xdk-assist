object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'XDK Assist'
  ClientHeight = 573
  ClientWidth = 715
  Color = clBtnFace
  Constraints.MinHeight = 403
  Constraints.MinWidth = 489
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    715
    573)
  PixelsPerInch = 96
  TextHeight = 13
  object grpConsole: TGroupBox
    Left = 8
    Top = 8
    Width = 707
    Height = 185
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Console:'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    DesignSize = (
      707
      185)
    object richLog: TRichEdit
      Left = 9
      Top = 16
      Width = 688
      Height = 137
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Constraints.MinHeight = 89
      Constraints.MinWidth = 200
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = richLogChange
    end
    object edInput: TEdit
      Left = 9
      Top = 153
      Width = 688
      Height = 22
      Anchors = [akLeft, akRight, akBottom]
      BorderStyle = bsNone
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyUp = edInputKeyUp
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 556
    Width = 715
    Height = 17
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = True
  end
  object pgControl: TPageControl
    Left = 8
    Top = 200
    Width = 705
    Height = 350
    ActivePage = tbBreakpoints
    Anchors = [akLeft, akTop, akRight, akBottom]
    HotTrack = True
    Images = ImageList1
    TabOrder = 1
    object tbBreakpoints: TTabSheet
      Caption = 'Breakpoints'
      ImageIndex = -1
      DesignSize = (
        697
        321)
      object lbBPType: TLabel
        Left = 184
        Top = 0
        Width = 28
        Height = 13
        Caption = 'Type:'
      end
      object bpUnset: TButton
        Left = 632
        Top = 13
        Width = 57
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Unset'
        TabOrder = 5
        OnClick = bpUnsetClick
      end
      object bpSet: TButton
        Left = 568
        Top = 13
        Width = 57
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Set'
        TabOrder = 4
        OnClick = bpSetClick
      end
      object edBPOffset: TLabeledEdit
        Left = 8
        Top = 18
        Width = 81
        Height = 21
        EditLabel.Width = 35
        EditLabel.Height = 13
        EditLabel.Caption = 'Offset:'
        MaxLength = 10
        TabOrder = 1
        OnKeyPress = edBPOffsetKeyPress
      end
      object lvBreak: TListView
        Left = 8
        Top = 48
        Width = 681
        Height = 154
        Anchors = [akLeft, akTop, akRight, akBottom]
        Checkboxes = True
        Columns = <
          item
            Caption = 'Offset'
            MinWidth = 90
            Width = 90
          end
          item
            Caption = 'Type'
            Width = 75
          end
          item
            Caption = 'Size'
          end
          item
            Caption = 'Last Hit'
            MinWidth = 90
            Width = 90
          end
          item
            AutoSize = True
            Caption = 'Description'
          end>
        FlatScrollBars = True
        GridLines = True
        MultiSelect = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnChange = lvBreakChange
        OnKeyUp = lvBreakKeyUp
        OnSelectItem = lvBreakSelectItem
      end
      object cmbBPType: TComboBox
        Left = 184
        Top = 18
        Width = 83
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
      end
      object edBPSize: TLabeledEdit
        Left = 96
        Top = 18
        Width = 81
        Height = 21
        EditLabel.Width = 23
        EditLabel.Height = 13
        EditLabel.Caption = 'Size:'
        TabOrder = 2
        OnKeyPress = edBPSizeKeyPress
      end
      object btGetRegisters: TButton
        Left = 616
        Top = 282
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Update'
        TabOrder = 6
        OnClick = btGetRegistersClick
      end
      object lvRegisters: TListView
        Left = 8
        Top = 210
        Width = 497
        Height = 99
        Anchors = [akLeft, akRight, akBottom]
        Columns = <
          item
            MaxWidth = 45
            MinWidth = 5
            Width = 30
          end
          item
            MinWidth = 5
            Width = 74
          end
          item
            MaxWidth = 45
            MinWidth = 5
            Width = 30
          end
          item
            MinWidth = 5
            Width = 74
          end
          item
            MaxWidth = 45
            MinWidth = 5
            Width = 30
          end
          item
            MinWidth = 5
            Width = 74
          end
          item
            MinWidth = 5
            Width = 74
          end
          item
            MinWidth = 5
            Width = 74
          end>
        FlatScrollBars = True
        GridLines = True
        ShowColumnHeaders = False
        TabOrder = 7
        ViewStyle = vsReport
      end
      object edBPDesc: TLabeledEdit
        Left = 272
        Top = 18
        Width = 289
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        EditLabel.Width = 57
        EditLabel.Height = 13
        EditLabel.Caption = 'Description:'
        TabOrder = 8
      end
    end
    object tbDumping: TTabSheet
      Caption = 'Dumping'
      ImageIndex = 8
      DesignSize = (
        697
        321)
      object pbDump: TProgressBar
        Left = 208
        Top = 8
        Width = 481
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Smooth = True
        TabOrder = 0
      end
      object lvDump: TListView
        Left = 208
        Top = 32
        Width = 481
        Height = 163
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = '#'
            MaxWidth = 40
            MinWidth = 15
            Width = 30
          end
          item
            AutoSize = True
            Caption = 'Offset'
            MinWidth = 80
          end
          item
            AutoSize = True
            Caption = 'Size'
            MinWidth = 80
          end
          item
            AutoSize = True
            Caption = 'Flags'
            MinWidth = 80
          end
          item
            AutoSize = True
            Caption = 'Start'
            MinWidth = 80
          end
          item
            AutoSize = True
            Caption = 'End'
            MinWidth = 80
          end>
        FlatScrollBars = True
        GridLines = True
        HotTrack = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnSelectItem = lvDumpSelectItem
      end
      object grpMemEdit: TGroupBox
        Left = 512
        Top = 204
        Width = 177
        Height = 97
        Anchors = [akRight, akBottom]
        Caption = 'Memory Editing:'
        TabOrder = 4
        object Label1: TLabel
          Left = 8
          Top = 12
          Width = 34
          Height = 13
          Caption = 'Action:'
        end
        object cbMemEdit: TComboBox
          Left = 8
          Top = 28
          Width = 73
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'GETMEM'
          OnChange = cbMemEditChange
          Items.Strings = (
            'GETMEM'
            'SETMEM')
        end
        object edMemEditOffset: TLabeledEdit
          Left = 88
          Top = 28
          Width = 81
          Height = 21
          EditLabel.Width = 35
          EditLabel.Height = 13
          EditLabel.Caption = 'Offset:'
          MaxLength = 8
          TabOrder = 1
        end
        object edMemEditParam: TLabeledEdit
          Left = 8
          Top = 68
          Width = 121
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 37
          EditLabel.Height = 13
          EditLabel.Caption = 'Length:'
          TabOrder = 2
          OnKeyUp = edMemEditParamKeyUp
        end
        object btMemEdit: TButton
          Left = 136
          Top = 64
          Width = 33
          Height = 25
          Caption = 'Go'
          TabOrder = 3
          OnClick = btMemEditClick
        end
      end
      object grpConvOffset: TGroupBox
        Left = 320
        Top = 204
        Width = 185
        Height = 97
        Anchors = [akRight, akBottom]
        Caption = 'Offset Conversion:'
        TabOrder = 3
        object Label2: TLabel
          Left = 8
          Top = 12
          Width = 67
          Height = 13
          Caption = 'Original Type:'
        end
        object lbConvOffStat: TLabel
          Left = 80
          Top = 12
          Width = 97
          Height = 33
          AutoSize = False
        end
        object cbOffsetConvert: TComboBox
          Left = 8
          Top = 28
          Width = 65
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'PC'
          Items.Strings = (
            'PC'
            'XBOX')
        end
        object edConvOffsetTo: TLabeledEdit
          Left = 96
          Top = 68
          Width = 81
          Height = 21
          EditLabel.Width = 55
          EditLabel.Height = 13
          EditLabel.Caption = 'Converted:'
          MaxLength = 10
          ReadOnly = True
          TabOrder = 2
        end
        object edConvOffsetFrom: TLabeledEdit
          Left = 8
          Top = 68
          Width = 81
          Height = 21
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Original:'
          MaxLength = 10
          TabOrder = 1
          OnKeyPress = edConvOffsetFromKeyPress
          OnKeyUp = edConvOffsetFromKeyUp
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 4
        Width = 193
        Height = 191
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Section Flags:'
        TabOrder = 2
        DesignSize = (
          193
          191)
        object lbSectFlags: TCheckListBox
          Left = 8
          Top = 16
          Width = 177
          Height = 163
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
        end
      end
      object btDump: TButton
        Left = 8
        Top = 204
        Width = 305
        Height = 97
        Anchors = [akLeft, akRight, akBottom]
        Caption = 
          'Here is AcidFlash'#39's dump button, so he doesn'#39't have to put down ' +
          'the controller for a split second.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        WordWrap = True
        OnClick = btDumpClick
      end
    end
    object tbTools: TTabSheet
      Caption = 'Tools'
      ImageIndex = 11
      object GroupBox3: TGroupBox
        Left = 0
        Top = 0
        Width = 697
        Height = 321
        Align = alClient
        Caption = 'Tools'
        Constraints.MinHeight = 160
        Constraints.MinWidth = 210
        TabOrder = 0
        DesignSize = (
          697
          321)
        object edToolPath: TLabeledEdit
          Left = 8
          Top = 32
          Width = 649
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Path:'
          Enabled = False
          TabOrder = 0
        end
        object edToolCaption: TLabeledEdit
          Left = 8
          Top = 72
          Width = 577
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'Caption:'
          TabOrder = 1
        end
        object lvToolList: TListView
          Left = 8
          Top = 104
          Width = 681
          Height = 209
          Anchors = [akLeft, akTop, akRight, akBottom]
          Columns = <
            item
              AutoSize = True
              Caption = 'Caption'
            end
            item
              AutoSize = True
              Caption = 'Path'
            end
            item
              AutoSize = True
              Caption = 'Launch'
            end>
          FlatScrollBars = True
          GridLines = True
          SortType = stText
          TabOrder = 2
          ViewStyle = vsReport
        end
        object chkToolLaunch: TCheckBox
          Left = 592
          Top = 72
          Width = 97
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Launch On Load'
          TabOrder = 3
        end
        object btnToolSelect: TButton
          Left = 664
          Top = 32
          Width = 25
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 4
          OnClick = btnToolSelectClick
        end
      end
    end
    object tbMemView: TTabSheet
      Caption = 'Memory View'
      ImageIndex = 12
      DesignSize = (
        697
        321)
      object edByteSearch: TLabeledEdit
        Left = 256
        Top = 24
        Width = 361
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        EditLabel.Width = 62
        EditLabel.Height = 13
        EditLabel.Caption = 'Byte Search:'
        TabOrder = 1
        OnKeyPress = edByteSearchKeyPress
        OnKeyUp = edByteSearchKeyUp
      end
      object edViewOffset: TLabeledEdit
        Left = 160
        Top = 24
        Width = 89
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 78
        EditLabel.Height = 13
        EditLabel.Caption = 'Jump To Offset:'
        MaxLength = 10
        TabOrder = 0
        OnKeyPress = edViewOffsetKeyPress
        OnKeyUp = edViewOffsetKeyUp
      end
      object hxMemView: TMPHexEditor
        Left = 8
        Top = 56
        Width = 681
        Height = 251
        Cursor = crIBeam
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        PopupMenu = popMemView
        TabOrder = 3
        BytesPerRow = 16
        BytesPerColumn = 1
        Translation = tkAsIs
        OffsetFormat = '-!10:0x|'
        Colors.Background = clWindow
        Colors.ChangedBackground = 11075583
        Colors.ChangedText = clMaroon
        Colors.CursorFrame = clNavy
        Colors.Offset = clBlack
        Colors.OddColumn = clBlue
        Colors.EvenColumn = clNavy
        Colors.CurrentOffsetBackground = clMoneyGreen
        Colors.OffsetBackGround = clWindow
        Colors.CurrentOffset = clGreen
        Colors.Grid = clSkyBlue
        Colors.NonFocusCursorFrame = clAqua
        Colors.ActiveFieldBackground = clWindow
        FocusFrame = True
        NoSizeChange = True
        AllowInsertMode = False
        DrawGridLines = True
        GraySelectionIfNotFocused = True
        Version = 'December 29, 2004; '#169' markus stephany, vcl[at]mirkes[dot]de'
        OnTopLeftChanged = hxMemViewTopLeftChanged
        OnChange = hxMemViewChange
        DrawGutter3D = False
        FindProgress = True
        ExplicitHeight = 253
      end
      object btMemSrchReset: TButton
        Left = 624
        Top = 19
        Width = 65
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Reset'
        TabOrder = 2
        OnClick = btMemSrchResetClick
      end
      object chkHighlightDumpChanges: TCheckBox
        Left = 8
        Top = 23
        Width = 137
        Height = 17
        Hint = 
          'This will add a lot of time to your dumps, but will in turn allo' +
          'w you to see the changes between different dumps in the memory v' +
          'iew window.'
        Caption = 'Highlight Dump Changes'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        WordWrap = True
      end
    end
    object tbNotes: TTabSheet
      Caption = 'Notes'
      ImageIndex = 3
      DesignSize = (
        697
        321)
      object moNotes: TMemo
        Left = 8
        Top = 8
        Width = 681
        Height = 298
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 0
        WantTabs = True
        ExplicitHeight = 300
      end
    end
    object tbSettings: TTabSheet
      Caption = 'Settings'
      ImageIndex = 10
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 257
        Height = 169
        Caption = 'Searcher Offsets:'
        TabOrder = 0
        object edSearcherStart: TLabeledEdit
          Left = 8
          Top = 56
          Width = 105
          Height = 21
          EditLabel.Width = 70
          EditLabel.Height = 13
          EditLabel.Caption = 'Start Address:'
          MaxLength = 10
          TabOrder = 0
        end
        object edSearcherEnd: TLabeledEdit
          Left = 8
          Top = 96
          Width = 105
          Height = 21
          EditLabel.Width = 64
          EditLabel.Height = 13
          EditLabel.Caption = 'End Address:'
          MaxLength = 10
          TabOrder = 1
        end
        object chkUseSearchRange: TCheckBox
          Left = 120
          Top = 18
          Width = 133
          Height = 17
          Caption = 'Automatically set range'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object edSearcherCaption: TLabeledEdit
          Left = 120
          Top = 56
          Width = 113
          Height = 21
          EditLabel.Width = 82
          EditLabel.Height = 13
          EditLabel.Caption = 'Window Caption:'
          TabOrder = 3
        end
        object edSearcherClass: TLabeledEdit
          Left = 120
          Top = 96
          Width = 113
          Height = 21
          EditLabel.Width = 59
          EditLabel.Height = 13
          EditLabel.Caption = 'Class Name:'
          TabOrder = 4
        end
        object edSearcherState: TLabeledEdit
          Left = 8
          Top = 136
          Width = 105
          Height = 21
          EditLabel.Width = 84
          EditLabel.Height = 13
          EditLabel.Caption = 'Enabled Address:'
          TabOrder = 5
        end
        object cbRangePresets: TComboBox
          Left = 8
          Top = 18
          Width = 105
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 6
        end
      end
      object GroupBox4: TGroupBox
        Left = 263
        Top = 8
        Width = 170
        Height = 81
        Caption = 'Dump:'
        TabOrder = 1
        object chkDumpAutoStop: TCheckBox
          Left = 8
          Top = 19
          Width = 81
          Height = 17
          Caption = 'Auto-Pause'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object chkCopyOffToClip: TCheckBox
          Left = 8
          Top = 36
          Width = 155
          Height = 17
          Caption = 'Copy Converts To Clipboard'
          Checked = True
          State = cbChecked
          TabOrder = 1
          WordWrap = True
        end
      end
      object GroupBox5: TGroupBox
        Left = 263
        Top = 88
        Width = 170
        Height = 89
        Caption = 'Miscellaneous:'
        TabOrder = 2
        object chkWarnConnected: TCheckBox
          Left = 9
          Top = 30
          Width = 158
          Height = 19
          Caption = 'Warn on exit if connected'
          Checked = True
          State = cbChecked
          TabOrder = 0
          WordWrap = True
        end
        object chkVerboseLog: TCheckBox
          Left = 9
          Top = 14
          Width = 105
          Height = 17
          Caption = 'Verbose Logging'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkShowMainLog: TCheckBox
          Left = 8
          Top = 48
          Width = 153
          Height = 17
          Caption = 'Show main log'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = chkShowMainLogClick
        end
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.bin'
    Filter = 
      'Dumps (*.bin)|*.bin|Breakpoint List (*.bpl)|*.bpl|Notes file (*.' +
      'notes, *.txt)|*.notes;*.txt|All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Save..'
    Left = 640
    Top = 64
  end
  object ImageList1: TImageList
    Left = 672
    Top = 96
    Bitmap = {
      494C0101100013002C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008080
      8000008000000080000080808000FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00008000000080
      000000800000008000000080000080808000FFFFFF00FFFFFF00008000000080
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000C0C0C00000FF
      FF0000FFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000008000000080
      0000008000000080000080808000FFFFFF0000000000FFFFFF00008000000080
      000000800000008000000080000000800000000000008080800000000000FF00
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000C0C0C00000000000FFFF
      FF0000FFFF008080800000000000000000000000000000000000000000000000
      0000000000FF5F5F5FFF00000000000000000000000000000000000000000000
      00FF5F5F5FFF000000000000000000000000FFFFFF0000800000008000000080
      00008080800080808000FFFFFF000000000000000000FFFFFF00008000000080
      0000008000000080000000800000808080000000000000000000FF00FF00FF00
      FF00FFFFFF0000000000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000FFFF0000FFFF000000
      0000C0C0C0000000000000000000000000000000000000000000000000000000
      000000000000000000FF5F5F5FFF000000000000000000000000000000FF5F5F
      5FFF000000000000000000000000000000000080000000800000008000000080
      000080808000FFFFFF00000000000000000000000000FFFFFF00008000000080
      0000008000000080000000800000808080000000000000000000FF00FF00FFFF
      FF000000000000FFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800000FFFF0000FF
      FF00808080000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF5F5F5FFF00000000000000FF5F5F5FFF0000
      0000000000000000000000000000000000000080000000800000008000008080
      8000FFFFFF000000000000000000000000000000000080808000008000000080
      0000008000000080000000800000808080000000000000000000808080008080
      8000FFFFFF0000FFFF0000FFFF0000000000000000008080800080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF5F5F5FFF000000000000
      0000000000000000000000000000000000000080000000800000008000008080
      8000FFFFFF000000000000000000000000000000000080808000808080008080
      8000008000000080000000800000808080008080800000000000000000000000
      000080808000FFFFFF0000FFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF5F5F5FFF000000000000
      0000000000000000000000000000000000000080000000800000008000008080
      8000FFFFFF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000800000008000000080000080808000000000000000000000000000FFFF
      000000000000FFFFFF00FFFFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF5F5F5FFF00000000000000FF5F5F5FFF0000
      0000000000000000000000000000000000000080000000800000008000008080
      8000FFFFFF00FFFFFF0000000000000000000000000000000000000000008080
      8000008000000080000000800000808080000000000000000000FFFFFF000000
      000000000000FFFFFF0080808000C0C0C000FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000FFFFFF008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF5F5F5FFF000000000000000000000000000000FF5F5F
      5FFF000000000000000000000000000000008080800000800000008000000080
      000080808000FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF000080
      0000008000000080000080808000FFFFFF000000000000000000808080000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000FFFFFF008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000FF5F5F5FFF00000000000000000000000000000000000000000000
      00FF5F5F5FFF000000000000000000000000FFFFFF0000800000008000000080
      00008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00008000000080
      0000008000000080000080808000FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF008080
      8000808080008080800080808000FFFFFF008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000008000000080
      0000008000000080000080808000808080008080800000800000008000000080
      00000080000080808000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00808080000080
      0000008000000080000000800000008000000080000000800000008000000080
      000080808000FFFFFF0000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      000080000000800000008000000080000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0080808000008000000080000000800000008000000080000080808000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000800000008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000800000008000000080000000800000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F5F5F50AFCFCFC03000000000000000004040400040404000404
      0400040404000404040004040400040404000404040004040400040404000404
      0400040404000404040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AAAAAA16202020F24C4C4CD1E6E6E6060000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00C0C0C000C0C0
      C000C0C0C000C0C0C00080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B4B6
      B41A1F1F1FF2929292FF383838FFAFB0AF040000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C00000000000000000000080800000808000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      80000080800000808000008080000000000080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001D1D1D1F2424
      24F19C9C9CFF373737FEE7E7E704000000000000000086868600CBCBCB00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C6D6EF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0080000000FF0000000000000000FFFF00FF00FF000000800000FF
      FF0000FFFF0000FFFF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0080808000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F3F3F302000000000000000000000000D8D8D821262626F0A6A6
      A6FF393939FE0000000000000000000000000000000086868600FFFFFF0090A9
      AD0066FFCC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000CC
      9900FFFFFF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0080000000FF0000000000000000FFFF00FF00FF000000800000FF
      FF0000FFFF0000FFFF0000FFFF000000000080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D5D5D50CCCCC
      CC23B8B8B838BABABA3BB8B8B834C6C6C632F3F3F3052D2D2DE9B3B3B3FF3A3A
      3AFD000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF0033CC990000CC9900FFFFFF00FFFFFF00FFFFFF00F0FBFF0000CC6600F8F8
      F800FFFFFF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF008000000000FFFF0000FFFF00000080000000800000FF
      FF0000FFFF0000FFFF0000FFFF000000000080808000C0C0C000C0C0C000C0C0
      C000808080008080800080808000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E9E9E90A7D7D7D96C2C2
      C2CECECECE6EDDDDDD64CDCDCDB3888888BF7A7A7A7EAEAEAEFF3E3E3EFD0000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF000099330000CC9900FFFFFF0099FFFF0000993300C0DCC000EAEA
      EA00FFFFFF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00C0C0C00000FFFF0000FFFF00808080000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000080808000808080008080
      8000000000000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000959595DECFCFCF2DD9D9
      D934DEDEDE4DEEEEEE50D9D9D93EDBDBDB1CB9B9B9F1828282B3000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000CC660000CC660000CC990033996600D7D7D700EAEA
      EA00F1F1F100C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF000000
      000000FFFF0000000000C0C0C0000000000000FFFF00000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009E9F9F64D9D9D934E0E0E03BECEC
      EC56ECECEC55E8E8E855E6E6E657EDEDED49E5E5E519898989CCD4D4D4240000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000CC9900009933000099330090A9AD00D7D7D700E3E3
      E300F1F1F100C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF00C0C0
      C00080808000C0C0C000C0C0C000C0C0C00080808000FFFFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000929292E0DDDDDD26CFCECE46D4D4
      D440E7E7E745E0E0E050D7D7D743D5D5D549DEDEDE32A9A9A9A2AEAEAE320000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF0000CC99000099330099CC9900008000000099330099CCCC00EAEA
      EA00FFFFFF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF00FFFF
      FF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0008080800000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000000000000000000000000000000000929292A4DCDCDB2ADDDDDD33E2E1
      E22AE8E8E82FE9E9E937E2E2E12CDFE0DF32DCDBDB32C3C3C250B1B1B0410000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF0000CC6600C0DCC000EAEAEA00DDDDDD00DDDDDD00CBCBCB000099660099CC
      CC00FFFFFF00C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00C0C0C0008080800000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000080800000FFFF0000FFFF0000FF
      FF00FFFFFF000080800000808000000000008A8989ABDCDCDC27E5E4E524BFBE
      BE1DCACACA25ECEBEC24D2D0D11FC1C0C023C2C1C1299E9E9E5FA9A9A92D0000
      0000000000000000000000000000000000000000000086868600FFFFFF00CCCC
      CC00FFFFFF00FFFFFF00FFFFFF00F1F1F100F1F1F100FFFFFF00FFFFFF00DDDD
      DD00F1F1F100C0C0C0000000000000000000FFFFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00808080008080800000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000008080
      8000C0C0C000C0C0C00000000000000000000000000000FFFF0000FFFF000080
      8000FFFFFF00000000000000000000000000939292EDE2E1E131DBDBDA20BCBC
      BC22EBEBEB36DFDFDF33C7C6C620D2D2D222DADADA2A7D7D7DCA000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C0C0C0000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00008080800080808000808080008080800000FFFF0000FFFF00000000000080
      8000FFFFFF00FFFFFF000080800000000000D5D4D457C8C7C762F7F7F753FBFA
      FA45FAF9F947FAF9F941FAF8F93AF0F0F050D3D2D24F9B9A9AB4000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00C0C0C0000404040000000000000000008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000FFFF0000FFFF0000C0C0C0000000000000FFFF00008080000000
      0000FFFFFF0000808000000000000000000000000000C1C1C1D0D1D1D162FFFF
      FF5DFFFFFF69FFFFFF68FFFFFF5CE3E3E349BBBBBBFB00000000000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000040404000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000FFFF0000FFFF0000C0C0C0000080800000FFFF000000000000FF
      FF00FFFFFF000080800000808000000000000000000000000000D1D1D1748888
      88F3939393B29D9D9DA87D7D7DE9DDDDDDA60000000000000000000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000404
      0400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000080800000FF
      FF00008080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000DBF7DF2E9FECAB6092E99E6D92E89D6DB2EEB84DF6FCF7190000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000CC660099CCCC0099CCCC0000CC
      660000993300009966000099660099CCCC00006633000099660000993300F0FB
      FF0000993300FFFFFF0000993300F0FBFF00000000000000000000000000CBF6
      D44296ECA7699AECAA659FEDAE60A1EDAE5EA1ECAD5E9EEBA9619AEAA46597E8
      9F68F9FDF9110000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E3E3E300CCCC9900CC996600CC996600F0CAA600FFFFFF000000
      000000000000000000000000000000000000FFFFFF0000CC660000996600F0FB
      FF0000800000009933000099330066CC990000CC6600FFFFFF00FFFFFF0000CC
      9900FFFFFF0000800000FFFFFF00FFFFFF0000000000000000009FEFB2609CEF
      B063A9F0BA56BAF4C745C7F5D138BAECC345C3F0CB3CC3F3CB3CB3F0BC4CA3EC
      AD5C99E9A166E8F9EA2800000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00CC999900996633009966330099663300996633009966330099663300F0CA
      A6000000000000000000000000000000000000CC6600F0FBFF00F0FBFF000099
      660000996600009933000099330099CCCC00009933000099330000993300F0FB
      FF0000996600FFFFFF0000996600F0FBFF0000000000A7F1BC589DF0B462B2F3
      C44DC5F2D03A21AE2FDE00E420FF00DE19FF00D910FF00CD06FF7DCB8382C4F3
      CB3BA8EDB15799E9A166F9FDF911000000000000000000000000000000000000
      0000000000003130310031303100313031003130310031303100000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00CC99
      6600996633009966330099663300996633009966330099663300996633009966
      3300C0C0C000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ECFCF11C9AF1B565AFF4C450C1F2
      CE3E01D82FFF12F658FF0ADE3AFF02E230FF00CF1DFF00DE1AFF00D00BFF27A6
      28D8C4F3CB3BA3ECAD5C97E89F68000000000000000000000000000000003130
      3100313031003130310031303100313031003130310031303100313031003130
      3100000000000000000000000000000000000000000000000000CCCC99009966
      330099663300CC996600E3E3E300FFFFFF00FFFFFF00F0CAA600996633009966
      330099663300F1F1F1000000000000000000FFFFFF00FFFFFF00FFECCC00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0FBFF00FFFFFF00FFFFFF009FF3BB60A2F3BE5DC6F7D73907D5
      38F832E469FF4FE882FF54EB8CFF32E161FF16D941FF01D224FF00CC17FF00D5
      0CFF7DCB8382B3F0BC4C9AEAA465F6FCF7190000000000000000000000003130
      3100313031003130310031303100313031003130310031303100313031003130
      31000000000000000000000000000000000000000000FFFFFF00996633009966
      330099663300FFFFFF00CC9999009966330099663300CCCCCC00E3E3E3009966
      330099663300CC9999000000000000000000FFFFFF00FFFFFF00FFFFFF006699
      6600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0099FF
      FF00C0DCC000FFFFFF00FFFFFF00FFFFFF0096F3B869ACF7C75399E1A76621E5
      65FF7DEFACFF82EFA9FF72EC9CFF63EA92FF49E67CFF20DB4DFF03D92BFF00D3
      18FF00C608FFC3F3CB3C9EEBA961B2EEB94D0000000000000000313031003130
      3100313031003130310031303100313031003130310031303100313031003130
      31003130310000000000000000000000000000000000FFFFFF00996633009966
      3300CCCC9900CCCCCC0099663300996633009966330099663300F1F1F1009999
      330099663300999966000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000099660099FFCC00FFFFFF00FFFFFF00FFFFFF00FFFFFF0066CC990099CC
      CC00F0FBFF00FFFFFF00FFFFFF00FFFFFF0096F4BB69B1F7CD4E40D865BF55EF
      9EFFB6F7CFFFAAF6C7FFA1F4C0FF7FEFA7FF66EB95FF3FE26DFF1AE04CFF00CC
      1CFF00D511FFC3F0CB3CA1ECAE5E92E89D6D0000000000000000313031003130
      3100313031003130310031303100313031003130310031303100313031003130
      31003130310000000000000000000000000000000000F1F1F100996633009966
      3300D7D7D700CC99990099663300CCCC99009999660099663300DDDDDD009999
      660099663300996633000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000066330066CC9900FFFFFF00FFFFFF0000CC660066CC9900C0DC
      C000FFECCC00F0FBFF00FFFFFF00FFFFFF0096F6BF69B2F7D04D37DB6DC85EF3
      AFFFBEF9D8FFCBFAE0FFADF7CDFFA2F5C3FF7AEFA6FF55E886FF2EE260FF04D8
      2FFF00D71AFFBAECC345A1EDAF5E92E99F6D0000000000000000313031003130
      3100313031003130310031303100313031003130310031303100313031003130
      31003130310000000000000000000000000000000000FFFFFF00996633009966
      3300CC999900DDDDDD0099663300DDDDDD009999660099663300FFFFFF009966
      330099663300CC9966000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00B2B2B2000099660000CC990000CC660000996600A4A0A000C0DC
      C000FFECCC00F0FBFF00FFFFFF00FFFFFF0095F7C16AAFF9D15069E28C965AF5
      ADFFD8FCEAFFDBFCECFFC9FBE1FFAEF8CEFF8BF3B3FF71F0ABFF41E97BFF0BDF
      3EFF00E224FFC7F5D1389FEDAE609FECAC600000000000000000313031003130
      3100313031003130310031303100313031003130310031303100313031003130
      31003130310000000000000000000000000000000000FFFFFF00996666009966
      330099663300F1F1F100F0CAA600DDDDDD00CC996600EAEAEA00F0CAA6009966
      330099663300CCCC99000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000CC66000099660000993300A4A0A00086868600B2B2
      B200FFECCC00F0FBFF00FFFFFF00FFFFFF0096F7C569A6F9CF59D3FCE72C10F2
      96FFC9FDE5FFEBFEF5FFCEFCE5FFADF9D0FFA4F6C6FF63EC96FF3DE677FF0CDE
      40FF21BC32DEBAF4C8459AEDAB65DBF7E02E0000000000000000313031003130
      310031303100313031003130310031303100FFFFFF00FFFFFF00FFFFFF003130
      3100313031000000000000000000000000000000000000000000CCCCCC009966
      33009966330099663300CCCC9900DDDDDD00CC996600CC999900996633009966
      330099663300FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0066CCCC000099330000CC66000033330000663300A4A0A000C0DC
      C000FFECCC00F0FBFF00FFFFFF00FFFFFF00C0FBDE469EFBCD61BBFCDD445CD4
      87A341FBB6FFB6FDDDFFD4FCE9FF99F7C4FF90F4BCFF64EFA3FF2EED7DFF00E0
      3EFFC5F2D03AA9F2BB5696ECA969000000000000000000000000000000003130
      310031303100313031003130310031303100FFFFFF00FFFFFF00FFFFFF003130
      310000000000000000000000000000000000000000000000000000000000CC99
      9900996633009966330099663300DDDDDD00CC99660099663300996633009966
      3300DDDDDD00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0066CC990066CC6600C0DCC000A4A0A000A4A0A0007777770000333300FFEC
      CC00F0FBFF00FFFFFF00FFFFFF00FFFFFF000000000098FCCD67A6FBD559C4FD
      E33B60E783B018F7A2FF4DF6ACFF52F4AFFF4DF2ADFF26F596FF07E352F8C1F2
      CF3EB2F4C54D9CEFB263CBF7D542000000000000000000000000000000003130
      3100313031003130310031303100313031003130310031303100313031003130
      3100000000000000000000000000000000000000000000000000000000000000
      0000F0CAA6009966330099663300996633009966330099663300CC996600E3E3
      E30000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00C0DC
      C000FFECCC00FFECCC00FFECCC00C0DCC000FFECCC00FFECCC00F0FBFF00A4A0
      A000F0FBFF00FFFFFF00FFFFFF00FFFFFF0000000000F3FEF81999FDD266A6FC
      D659BBFCDD44D3FDE82C61E08FB037E171C840DE71BF96E6A66AC6F7D839AFF4
      C6509DF1B6629FF0B46000000000000000000000000000000000000000000000
      0000000000003130310031303100313031003130310031303100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00DDDDDD00F0CAA600D7D7D700EAEAEA00000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000F3FEF91998FD
      D0679EFBCF61A6FAD059AFFAD350B2F8D24DB1F7CF4EACF7C953A2F4BF5D9AF3
      B765A7F2BD580000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000C0FCDF4696F9C76995F7C36A96F7C16996F5BD6996F4BA699FF4BD60ECFC
      F11C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000080800000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000000000000000000080808000808080000000
      0000808080000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000008080800000000000000000008080
      8000000000008080800000000000000000000000000000000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080000000000000000000808080000000000000000000000000000000
      0000808080000000000080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000080808000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      0000000000008080800000000000000000000000000000000000808080000000
      0000000000000000000000000000008080000000000000000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000080800000000000000000008080
      8000000000000000000000000000808080008080800000000000000000000000
      0000000000000080800000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000
      00000000000000000000000000000000000000FFFF0000000000808080000000
      0000000000000000000080808000808080000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000FFFFFF008000
      0000800000008000000080000000800000008000000080000000800000008000
      0000FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000000000000000
      0000000000000000000080808000000000000000000000000000000000000080
      8000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800000000000000000008080
      800080808000808080000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800000000000000000000000000000808000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF008000
      00008000000080000000800000008000000080000000FFFFFF00FFFFFF00C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFDFFFFFFFFFF0FFFF9FFFCFFFFFC040
      FF3FFF83FFFF8000C87F0001FFFF808080000001F3E7018000000001F9CF0380
      C0000003FC9F0780C0000007FE3F078040000007FE3F078040000007FC9F03E0
      80000007F9CF0180C0000007F3E70000C0000007FFFF8001C0000007FFFF8003
      C0000007FFFFC007C0000007FFFFF01FFFF98003FFFF80FFFFF08003FFFF80FF
      FFE08003000000FFFFC18003000000FFFB878003000000FFC00F8003000001FF
      801F8003000089FF803F80030000FFFF001F80030000FDE7001F80030000FF81
      001F80030000F001001F80030000E001003F80030001F000003F800300FFF001
      807F800781FFF001C0FF800FFFFFF043FFFF0000F81FFFFFFFFF0000E007F01F
      F81F0000C003E00FE00F00008001C007C007000000018003C003000000000001
      8003000000000001800300000000000180030000000000018003000000000001
      8003000000000001C003000000010001E007000080018003F00F00008003C007
      F83F0000C007E00FFFFF0000F00FF01FFFFFFFFFFF5FFFFFFFFFFFFFFF0FC003
      E007FFFFFD07C003C003E3FFFC03C003C003C0FFF401C003C003C03FF001C003
      C003C007D000C003C003C003C004C003C003C0034003C003C003C0030013C003
      C003C007000FC003C003C03F004FC007C003C0FF803FC00FE007E3FFC13FC01F
      FFFFFFFFE0FFC03FFFFFFFFFF4FFFFFF00000000000000000000000000000000
      000000000000}
  end
  object mnuMain: TMainMenu
    Images = ImageList1
    Left = 608
    Top = 96
    object Application1: TMenuItem
      Caption = '&Application'
      object Tools1: TMenuItem
        Caption = 'Tools'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object SaveLog1: TMenuItem
        Caption = 'Save Log'
        ShortCut = 16467
        OnClick = SaveLog1Click
      end
      object Settings1: TMenuItem
        Caption = 'Settings'
        ImageIndex = 10
        object SetXBOXAddress1: TMenuItem
          Caption = 'Set XBOX Address'
          OnClick = SetXBOXAddress1Click
        end
        object SetListenPort1: TMenuItem
          Caption = 'Set Listen Port'
          OnClick = SetListenPort1Click
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        ImageIndex = 14
        ShortCut = 49240
        OnClick = Exit1Click
      end
    end
    object XDK1: TMenuItem
      Caption = '&XDK'
      object Connect1: TMenuItem
        Caption = '&Connect'
        ImageIndex = 7
        ShortCut = 112
        OnClick = Connect1Click
      end
      object Dumpmemory1: TMenuItem
        Caption = '&Dump memory'
        ImageIndex = 8
        ShortCut = 16452
        OnClick = Dumpmemory1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Stop1: TMenuItem
        Caption = 'Stop'
        ImageIndex = 0
        ShortCut = 114
        OnClick = Stop1Click
      end
      object Go1: TMenuItem
        Caption = 'Go'
        ImageIndex = 1
        ShortCut = 115
        OnClick = Go1Click
      end
      object ContinueThread1: TMenuItem
        Caption = 'Continue Thread'
        ImageIndex = 1
        ShortCut = 116
        OnClick = ContinueThread1Click
      end
      object Modules1: TMenuItem
        Caption = 'Modules'
        ImageIndex = 2
        ShortCut = 16461
        OnClick = Modules1Click
      end
      object Threads1: TMenuItem
        Caption = 'Threads'
        ImageIndex = 13
        ShortCut = 16468
        OnClick = Threads1Click
      end
      object GetProcessID1: TMenuItem
        Caption = 'Get Process ID'
        ImageIndex = 13
        ShortCut = 16464
        OnClick = GetProcessID1Click
      end
      object XBEInfo1: TMenuItem
        Caption = 'XBE Info'
        ImageIndex = 9
        ShortCut = 16457
        OnClick = XBEInfo1Click
      end
      object WarmReboot1: TMenuItem
        Caption = 'Reboot Warm'
        ImageIndex = 4
        ShortCut = 120
        OnClick = WarmReboot1Click
      end
      object RebootCold1: TMenuItem
        Caption = 'Reboot Cold'
        ImageIndex = 4
        ShortCut = 121
        OnClick = RebootCold1Click
      end
      object RestartTitle1: TMenuItem
        Caption = 'Restart Title'
        ImageIndex = 15
        ShortCut = 123
        OnClick = RestartTitle1Click
      end
    end
    object Help1: TMenuItem
      Caption = '&Help'
      object About1: TMenuItem
        Caption = '&About'
        OnClick = About1Click
      end
    end
  end
  object ClientThread: TIdThreadComponent
    Active = False
    Loop = True
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = ClientThreadRun
    Left = 672
    Top = 32
  end
  object popMemView: TPopupMenu
    Left = 640
    Top = 96
    object JumpbyPCAddress1: TMenuItem
      Caption = 'Jump by PC Address'
      OnClick = JumpbyPCAddress1Click
    end
    object JumpbyXBOXAddress1: TMenuItem
      Caption = 'Jump by XBOX Address'
      OnClick = JumpbyXBOXAddress1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object SavetoFile1: TMenuItem
      Caption = 'Save to File'
      OnClick = SavetoFile1Click
    end
  end
  object XClient: TIdTCPClient
    OnStatus = XClientStatus
    ConnectTimeout = 0
    Host = '192.168.1.153'
    IPVersion = Id_IPv4
    Port = 731
    ReadTimeout = 0
    Left = 672
    Top = 64
  end
  object Server: TIdTCPServer
    Bindings = <>
    DefaultPort = 2000
    MaxConnections = 1
    OnExecute = ServerExecute
    Left = 640
    Top = 32
  end
  object odToolSelect: TOpenDialog
    DefaultExt = '*.exe'
    Filter = 'Programs|*.exe|All Files|*.*'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Title = 'Select a tool'
    Left = 608
    Top = 64
  end
end
