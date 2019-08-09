unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls,CommCtrl, IdThreadComponent, IdGlobal,
  IdTCPConnection, IdBaseComponent, IdComponent, IdTCPClient,
  IdStreamVCL, StrUtils, IdExceptionCore,IdException,
  Breakpoint, Tabs, CategoryButtons, IdContext,INIFiles,IdIPAddress,
  TypInfo, IdTCPServer, ShellApi, IdStack, Grids, MPHexEditor, AppGlobal, LogStream,
  CheckLst, ImgList, ValEdit, XBOXManager, IdCustomTCPServer;

const
  WM_NEWTEXT = WM_USER+0;
  WM_NEWDUMP = WM_USER+1;
  PAGE_WRITECOMBINE = $400;
  MEM_LARGE_PAGES   = $20000000;
  MEM_4MB_PAGES     = $80000000;

type
  TfrmMain = class(TForm)
    grpConsole: TGroupBox;
    edInput: TEdit;
    mnuMain: TMainMenu;
    Application1: TMenuItem;
    Exit1: TMenuItem;
    XDK1: TMenuItem;
    Connect1: TMenuItem;
    Dumpmemory1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ClientThread: TIdThreadComponent;
    richLog: TRichEdit;
    StatusBar: TStatusBar;
    N1: TMenuItem;
    Modules1: TMenuItem;
    Threads1: TMenuItem;
    WarmReboot1: TMenuItem;
    GetProcessID1: TMenuItem;
    XBEInfo1: TMenuItem;
    RebootCold1: TMenuItem;
    Stop1: TMenuItem;
    Go1: TMenuItem;
    N2: TMenuItem;
    pgControl: TPageControl;
    tbBreakpoints: TTabSheet;
    bpUnset: TButton;
    bpSet: TButton;
    edBPOffset: TLabeledEdit;
    lvBreak: TListView;
    tbDumping: TTabSheet;
    ContinueThread1: TMenuItem;
    XClient: TIdTCPClient;
    Server: TIdTCPServer;
    pbDump: TProgressBar;
    lvDump: TListView;
    cmbBPType: TComboBox;
    edBPSize: TLabeledEdit;
    tbTools: TTabSheet;
    tbMemView: TTabSheet;
    edByteSearch: TLabeledEdit;
    edViewOffset: TLabeledEdit;
    hxMemView: TMPHexEditor;
    btMemSrchReset: TButton;
    tbNotes: TTabSheet;
    moNotes: TMemo;
    SetXBOXAddress1: TMenuItem;
    SetListenPort1: TMenuItem;
    SaveDialog: TSaveDialog;
    Tools1: TMenuItem;
    N4: TMenuItem;
    Settings1: TMenuItem;
    popMemView: TPopupMenu;
    JumpbyPCAddress1: TMenuItem;
    JumpbyXBOXAddress1: TMenuItem;
    N3: TMenuItem;
    SavetoFile1: TMenuItem;
    tbSettings: TTabSheet;
    grpMemEdit: TGroupBox;
    cbMemEdit: TComboBox;
    Label1: TLabel;
    edMemEditOffset: TLabeledEdit;
    edMemEditParam: TLabeledEdit;
    btMemEdit: TButton;
    grpConvOffset: TGroupBox;
    cbOffsetConvert: TComboBox;
    Label2: TLabel;
    edConvOffsetTo: TLabeledEdit;
    edConvOffsetFrom: TLabeledEdit;
    lbConvOffStat: TLabel;
    lbBPType: TLabel;
    GroupBox1: TGroupBox;
    lbSectFlags: TCheckListBox;
    ImageList1: TImageList;
    btDump: TButton;
    GroupBox2: TGroupBox;
    edSearcherStart: TLabeledEdit;
    edSearcherEnd: TLabeledEdit;
    chkUseSearchRange: TCheckBox;
    GroupBox4: TGroupBox;
    chkDumpAutoStop: TCheckBox;
    chkCopyOffToClip: TCheckBox;
    edSearcherCaption: TLabeledEdit;
    edSearcherClass: TLabeledEdit;
    edSearcherState: TLabeledEdit;
    RestartTitle1: TMenuItem;
    SaveLog1: TMenuItem;
    btGetRegisters: TButton;
    lvRegisters: TListView;
    cbRangePresets: TComboBox;
    chkHighlightDumpChanges: TCheckBox;
    GroupBox5: TGroupBox;
    chkWarnConnected: TCheckBox;
    chkVerboseLog: TCheckBox;
    chkShowMainLog: TCheckBox;
    edBPDesc: TLabeledEdit;
    GroupBox3: TGroupBox;
    edToolPath: TLabeledEdit;
    edToolCaption: TLabeledEdit;
    lvToolList: TListView;
    chkToolLaunch: TCheckBox;
    btnToolSelect: TButton;
    odToolSelect: TOpenDialog;
    procedure btnToolSelectClick(Sender: TObject);
    procedure chkShowMainLogClick(Sender: TObject);
    procedure btGetRegistersClick(Sender: TObject);
    procedure hxMemViewTopLeftChanged(Sender: TObject);
    procedure SaveLog1Click(Sender: TObject);
    procedure lvBreakSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure RestartTitle1Click(Sender: TObject);
    procedure btDumpClick(Sender: TObject);
    procedure lvDumpSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvBreakChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure edMemEditParamKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edConvOffsetFromKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edConvOffsetFromKeyPress(Sender: TObject; var Key: Char);
    procedure GenericMenuItemClick(Sender: TObject);
    procedure btMemEditClick(Sender: TObject);
    procedure cbMemEditChange(Sender: TObject);
    procedure hxMemViewChange(Sender: TObject);
    procedure SavetoFile1Click(Sender: TObject);
    procedure JumpbyPCAddress1Click(Sender: TObject);
    procedure JumpbyXBOXAddress1Click(Sender: TObject);
    procedure SetListenPort1Click(Sender: TObject);
    procedure SetXBOXAddress1Click(Sender: TObject);
    procedure btMemSrchResetClick(Sender: TObject);
    procedure edByteSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edByteSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edViewOffsetKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edViewOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edBPSizeKeyPress(Sender: TObject; var Key: Char);
    procedure edBPOffsetKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerExecute(AContext: TIdContext);
    procedure ContinueThread1Click(Sender: TObject);
    procedure bpUnsetClick(Sender: TObject);
    procedure bpSetClick(Sender: TObject);
    procedure lvBreakKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Go1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure RebootCold1Click(Sender: TObject);
    procedure XBEInfo1Click(Sender: TObject);
    procedure GetProcessID1Click(Sender: TObject);
    procedure WarmReboot1Click(Sender: TObject);
    procedure Threads1Click(Sender: TObject);
    procedure Modules1Click(Sender: TObject);
    procedure ClientThreadRun(Sender: TIdThreadComponent);
    procedure richLogChange(Sender: TObject);
    procedure XClientStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Exit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edInputKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Dumpmemory1Click(Sender: TObject);
    procedure Connect1Click(Sender: TObject);

    procedure OnNewText(var Msg: TMessage); message WM_NEWTEXT;
    procedure OnNewDump(var Msg: TMessage); message WM_NEWDUMP;

  private
    { Private declarations }
    MemSrchPos:Integer;
  public
    { Public declarations }
    function SendData(Data:String):Boolean;
    procedure ConnectToggle(Tog:Boolean);
  end;

  procedure FillDumpPages(hDump:HWND);
  procedure GetDumpData(hProgress:HWND;hWin:HWND;Verbose:Boolean);
  function IsValidHexBoxInput(var Key: Char):Boolean;
  function IsValidIP(const AAddr : String): Boolean;
//  function LaunchAsChild(EXEName:String;EXEClass:PAnsiChar;EXECaption:PAnsiChar;Parent:HWND):HWND;

var
//  XBEName:String;
  ProgressBar:HWND;
  DumpList:HWND;
  SavedDump:TMemoryStream;
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Connect1Click(Sender: TObject);
begin
  if XClient.Connected then
  begin
    XClient.Disconnect;
    Exit;
  end;

  try
    XClient.Connect;
  except
    On E : Exception do Log.AddLn('Connect: ' + E.Message);
  end;
end;

procedure TfrmMain.Dumpmemory1Click(Sender: TObject);
begin
  if (XClient.Connected) and
    (ProgStatus = stNorm) then
  begin
    ProgStatus := stDump;
    SendData('WALKMEM');
  end;
end;

procedure TfrmMain.About1Click(Sender: TObject);
begin
  ShowMessage('Coded by ddh for EvoX-T.'+#13#10+'Current official download site:'+#13#10+'http://trainers.evolutionx.info');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
count:TBPTypes;
iniSet:TINIFile;
Sections:TStringList;
Counter:Integer;
//r:TRect;
mi:TMenuItem;
ExIcon:HICON;
NewIcon:TIcon;
begin
  Log := TLogStream.create('',WM_NEWTEXT,frmMain.Handle);
  DebugBox := TXBOX.Create(@XClient);

//  richlog.SelStart := richlog.GetTextLen;
//  richlog.seltext := '{\rtf1\ansi\deff0\deftab720\fnil\deflang1033\pard{\colortbl\red0\green0\blue0;\red0\green200\blue200;}\cf1 test \par}';
//  log.AddLn('{\rtf1\ansi\fnil{\colortbl\red110\green0\blue0;\red0\green200\blue20;}\cf0 Another test \par}');

  lbSectFlags.Clear;
  lbSectFlags.AddItem('PAGE_NOACCESS',Self);
  lbSectFlags.AddItem('PAGE_READONLY',Self);
  lbSectFlags.AddItem('PAGE_READWRITE',Self);
  lbSectFlags.AddItem('PAGE_WRITECOPY',Self);
  lbSectFlags.AddItem('PAGE_EXECUTE',Self);
  lbSectFlags.AddItem('PAGE_EXECUTE_READ',Self);
  lbSectFlags.AddItem('PAGE_EXECUTE_READWRITE',Self);
  lbSectFlags.AddItem('PAGE_EXECUTE_WRITECOPY',Self);
  lbSectFlags.AddItem('PAGE_GUARD',Self);
  lbSectFlags.AddItem('PAGE_NOCACHE',Self);
  lbSectFlags.AddItem('PAGE_WRITECOMBINE',Self);
  lbSectFlags.AddItem('MEM_COMMIT',Self);
  lbSectFlags.AddItem('MEM_RESERVE',Self);
  lbSectFlags.AddItem('MEM_DECOMMIT',Self);
  lbSectFlags.AddItem('MEM_RELEASE',Self);
  lbSectFlags.AddItem('MEM_FREE',Self);
  lbSectFlags.AddItem('MEM_PRIVATE',Self);
  lbSectFlags.AddItem('MEM_MAPPED',Self);
  lbSectFlags.AddItem('MEM_RESET',Self);
  lbSectFlags.AddItem('MEM_TOP_DOWN',Self);
  lbSectFlags.AddItem('MEM_LARGE_PAGES',Self);
  lbSectFlags.AddItem('MEM_4MB_PAGES',Self);
  lbSectFlags.AddItem('SEC_RESERVE',Self);

  cmbBPType.Clear;
  for count := Low(TBPTypes) to High(TBPTypes) do
  begin
    cmbBPType.Items.Add(GetEnumName(TypeInfo(TBPTypes),ord(count)));
  end;
  cmbBPType.ItemIndex := 0;

  edInput.Enabled := false;
  lvBreak.Enabled := false;
//  Membuffer := TMemoryStream.Create;
  SavedDump := TMemoryStream.Create;

  try
  begin
    iniSet := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'xdkassist.ini');
    XClient.Host := iniSet.ReadString('Connection','Host','192.168.1.153');
    Server.DefaultPort := iniSet.ReadInteger('Connection','Port',2000);
    cmbBPType.ItemIndex := cmbBPType.Items.IndexOf(
            iniSet.ReadString('Breakpoints','Type','Read'));
    if cmbBPType.ItemIndex < 0 then cmbBPType.ItemIndex := 0;

    Sections := TStringList.Create;

{    tbTools.TabVisible := false;}

    iniSet.ReadSections(Sections);
    for Counter := 0 to (Sections.Count-1) do
    begin
      if (not AnsiStartsText('Tool',Sections.Strings[Counter])) then Continue;

      SetLength(Tools,Length(Tools)+1);
      with Tools[High(Tools)] do
      begin
        Name := iniSet.ReadString(Sections[Counter],'Name','');
//        WinClass := iniSet.ReadString(Sections[Counter],'Class','');
        WinText := iniSet.ReadString(Sections[Counter],'Caption','');
        Load := iniSet.ReadBool(Sections[Counter],'Load',false);

        if (Name = '') or (not FileExists(Name)){and (WinClass = '') and (WinText = '')} then
        begin
          SetLength(Tools,Length(Tools)-1);
          Continue;
        end;

        mi := TMenuItem.Create(mnuMain);
        if WinText <> '' then
          mi.Caption := WinText
        else if Name <> '' then
        begin
          mi.Caption := Name;
        end
{        else if WinClass <> '' then
          mi.Caption := WinClass       }
        else
          mi.Caption := 'Unknown Tool #' + IntToStr(High(Tools));

        mi.OnClick := GenericMenuItemClick;
        mi.Tag := High(Tools);

        if Name <> '' then
        begin
          ExIcon := ExtractIcon(Handle,PAnsiChar(Name+#0),0);
          if ExIcon <> 0 then
          begin
            NewIcon := TIcon.Create;
            NewIcon.Handle := ExIcon;
            mi.ImageIndex := ImageList1.AddIcon(NewIcon);
          end;
        end;

        Tools1.Add(mi);

        if (Load = true) then ShellExecute(0,'open',PAnsiChar(Name),#0,#0,SW_NORMAL);

{        if (Load = true) then
        begin
          tbTools.TabVisible := true;

          Handle := LaunchAsChild(Name,PAnsiChar(WinClass+#0),PAnsiChar(WinText+#0),ScrollBox1.handle);
          if Handle <> 0 then
          begin
            Log.AddLn('Launched and captured ' + WinText + ' for your pleasure!');
            if Length(Tools) > 1 then
            begin
              GetWindowRect(Tools[Length(Tools)-2].handle,r);
              SetWindowPos(Handle,0,r.right+5,5,0,0,SWP_NOSIZE or SWP_NOZORDER);
            end
            else
              SetWindowPos(Handle,0,5,5,0,0,SWP_NOSIZE or SWP_NOZORDER);
          end;
        end;    }
      end;
    end;
    FreeAndNil(Sections);

    frmMain.Width := iniSet.ReadInteger('Window','Width',frmMain.Width);
    frmMain.Height := iniSet.ReadInteger('Window','Height',frmMain.Height);
    frmMain.WindowState := TWindowState(iniSet.ReadInteger('Window','State',Integer(frmMain.WindowState)));
    pgControl.ActivePageIndex := iniSet.ReadInteger('Window','LastTab',pgControl.ActivePageIndex);
    chkDumpAutoStop.Checked := iniSet.ReadBool('Dumping','AutoStop',true);
    chkCopyOffToClip.Checked := iniSet.ReadBool('Dumping','AutoCopy',true);
    chkHighlightDumpChanges.Checked := iniSet.ReadBool('Dumping','Highlight',false);
    chkVerboseLog.Checked := iniSet.ReadBool('Logging','Verbose',true);

    chkWarnConnected.Checked := iniSet.ReadBool('Misc','WarnConClose',true);
    chkShowMainLog.Checked := iniSet.ReadBool('Layout','ShowMainLog',true);

    chkUseSearchRange.Checked := iniSet.ReadBool('Range','Enabled',true);
    edSearcherStart.Text := iniSet.ReadString('Range','Start','');
    edSearcherEnd.Text := iniSet.ReadString('Range','End','');
    edSearcherCaption.Text := iniSet.ReadString('Range','Caption','');
    edSearcherClass.Text := iniSet.ReadString('Range','Class','');
    edSearcherState.Text := iniSet.ReadString('Range','State','');

    FreeAndNil(iniSet);
    Log.AddLn('Settings have been read.');
  end
  except
    on E:Exception do Log.AddLn('Failed loading settings: ' + E.Message);
  end;

  if Length(Tools) > 0 then
    Log.AddLn(IntToStr(Length(Tools)) + ' tools were loaded.'); {If any were set to autolaunch, and the application ' +
                'crashes, or is terminated without it being able to clean up you ' +
                'will have to manually close the launched tools with task manager.'); }

  ConnectToggle(false);
  {if ((tbTools.TabVisible = false) and (pgControl.ActivePage = tbTools)) then
    pgControl.ActivePage := tbDumping;      }
  Log.AddLn(Application.Title + ' started.');

  Progressbar := pbDump.Handle;
  DumpList := lvDump.Handle;
  if FileExists('xdkassist.notes') then
  begin
    moNotes.Lines.LoadFromFile('xdkassist.notes');
    Log.addln('Notes loaded from a previous session.');
  end;

end;

procedure TfrmMain.edInputKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
Pos:Cardinal;
Buf:String;
ConvOff:Int64;
ret:Integer;
begin
  if Key = VK_RETURN then
  begin
    if StartsStr('/conv',edInput.Text) then
    begin
      Buf := edInput.Text;
      Pos := AnsiPos(' ',Buf);
      if (Pos = 0) then
      begin
        Log.AddLn('/conv offset');
        Exit;
      end;

      Buf := RightStr(Buf,(Cardinal(Length(Buf)) - Pos));
      ret := ConvPC2XBOX(StrToInt64(Buf),@ConvOff);
      if(ret <> EConvOkay) then begin
        Log.AddLn(ConvError(ret));
      end else begin
        Log.AddLn(Format('0x%.80x -> 0x%.80x',[Cardinal(Buf),ConvOff]));
        if(chkCopyOffToClip.Checked) then
          TextToClip(IntToHex(ConvOff,8));
      end;
    end
    else if AnsiStartsStr('/clear',edInput.Text) then
    begin
      Log.Clear;
      richlog.Clear;
    end
    else
    begin
      SendData(edInput.Text);
    end;
    edInput.Text := '';
  end;
end;

function TfrmMain.SendData(Data:String):Boolean;
begin
  Result := DebugBox.IsConnected;
  try
    if (DebugBox.IsConnected = true) then
    begin
      Log.AddLn('s: ' + Data);
      DebugBox.SendCmd(AnsiString(Data));
    end
    else
    begin
      Log.AddLn('Not connected.');
    end;
  except
    on E: Exception do
    begin
      Log.AddLn('Send Data: ' + E.message);
      Result := false;
    end;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
Ret: Integer;
begin
  CanClose := true;
  if ((DebugBox.IsConnected = true) and (chkWarnConnected.Checked)) then
  begin
    Ret := MessageDlg('You are still connected to an XBOX. Are you sure you want to disconnect?',
        mtConfirmation,[mbYes, mbNo],0);

    if Ret = mrYes then XClient.Disconnect
    else CanClose := false;
  end;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  frmMain.Close;
end;

procedure TfrmMain.XClientStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
 {
hsResolving A host name is being resolved to an IP Address.
hsConnecting A connection is being opened.
hsConnected A connection has been made.
hsDisconnecting The connection is being closed.
hsDisconnected The connection has been closed.
hsStatusText The connection is generating an informational message.
ftpTransfer An FTP connection is beginning its transfer.
ftpReady An FTP connection is ready.
ftpAborted An FTP transfer has been aborted.
}
  StatusBar.SimpleText := AStatusText;
  try
  begin
    if AStatus = hsDisconnecting then
    begin
      try
        try
        begin
          DebugBox.Notify(Server.DefaultPort,true);
          ClientThread.Terminate;
        end
        except
          on E: Exception do Log.AddLn('Status (Disconnecting): ' + E.Message);
        end;
      finally
        ProgStatus := stNorm;
      end;
    end
    else if AStatus = hsDisconnected then
    begin
      Log.AddLn('Disconnected from ' + XClient.Host + '.');
      ConnectToggle(false);
    end
    else if AStatus = hsConnected then
    begin
      try
        Log.AddLn('Connected to ' + XClient.Host + '. Listening on port ' + IntToStr(Server.DefaultPort) + '.');
      except
        on E: Exception do Log.AddLn('Status (Connected): ' + E.Message);
      end;
      ConnectToggle(true);
    end;
  end
  except
    on E : Exception do Log.AddLn('Status: ' + E.Message);
  end;
end;

procedure TfrmMain.richLogChange(Sender: TObject);
begin
  richLog.Perform(EM_SCROLL,SB_PAGEDOWN,0);
end;

procedure TfrmMain.ClientThreadRun(Sender: TIdThreadComponent);
var
Read: String;
Time:Cardinal;
Buffer:PAnsiChar;
begin
  while (not ClientThread.Terminated) and
    (XClient.Connected) do
  begin
    try
      Read := '';
      if Assigned(XClient.IOHandler) then
        Read := XClient.IOHandler.ReadLn;
    except
      on E: Exception do
      begin
        if (E is EIdReadTimeout) or (E is EIdNoDataToRead) then Continue
        else if (E is EIdConnClosedGracefully) or
                (E is EIdNotConnected) or (E is EIdTCPConnectionError) then
        begin
          ClientThread.Terminate;
        end
        else if (E is EIdSocketError) then
        begin
          Log.AddLn('Thread: ' + E.Message);
          XClient.Socket.Close;
          ConnectToggle(false);
          ClientThread.Terminate;
          Continue;
        end;
        Log.AddLn('Thread: ' + E.Message);
        Continue;
      end;
    end;

    if Read = '' then Continue
    else if Read = '201- connected' then
    begin
      DebugBox.Connect(Server.DefaultPort);
{      SendData('NOTIFYAT PORT=' + IntToStr(Server.DefaultPort));
      SendData('DEBUGGER CONNECT');}
    end
    else if Read = '202- bye' then
    begin
      XClient.Disconnect;
      ClientThread.Terminate;
    end
    else if Read = '202- Valid Virtual Address Ranges Follow' then
    begin
      if ProgStatus = stDump then
      begin
        Log.AddLn(Read);
        if chkDumpAutoStop.Checked then SendData('STOP');
        PostMessage(ProgressBar,PBM_SETPOS,0,0);
        PostMessage(DumpList,LVM_DELETEALLITEMS,0,0);

        Time := GetTickCount;
        FillDumpPages(DumpList);
        GetDumpData(ProgressBar,frmMain.handle,frmMain.chkVerboseLog.Checked);

        Log.AddLn(Format('All done (0x%.8p - 0x%.8x). The dump took %.2fs.',
//          [Membuffer.memory,Integer(MemBuffer.Memory) + Membuffer.position,
          [DebugBox.Memory.Buffer.Memory,Integer(DebugBox.Memory.Buffer.Memory) + DebugBox.Memory.Buffer.Position,
          (Windows.GetTickCount - Time) / 1000]));

        PostMessage(frmMain.Handle,WM_NEWDUMP,0,0);
        Read :='';
      end;
    end
    else if Read = '202- multiline response follows' then
    begin
      if (ProgStatus = stGetXBEInfo) then
      begin
        {202- multiline response follows
        timestamp=0x40d52299 checksum=0x00000000
        name="E:\UnleashX\default.xbe"
        .}
        log.addln('r: ' + Read);
        Read := XClient.IOHandler.ReadLn;
        log.addln('r: ' + Read);
        Read := XClient.IOHandler.ReadLn;
        DebugBox.XBE.Name := AnsiMidStr(Read,7,Length(Read)-7);
        progStatus := stNorm;
      end
      else if(ProgStatus = stGetContext) then
      begin
        while Read <> '.' do
        begin
          Read := XClient.IOHandler.ReadLn;
          log.AddLn(read);
        end;

        progStatus := stNorm;
      end;
    end
    else if Read = '203- binary response follows' then
    begin
      Log.AddLn(Read);
      repeat
        Read := XClient.IOHandler.ReadString(XClient.IOHandler.InputBuffer.Size);
        if (Length(Read) > 0) then
        begin
        Buffer := StrAlloc(Length(Read) * 2 + 1);
        BinToHex(PAnsiChar(Read),Buffer,Length(Read));
        Log.AddLn(String(Buffer));
        StrDispose(Buffer);
        end;
      until XClient.IOHandler.InputBuffer.Size = 0;
      Read := '';
    end;
    if Read <> '' then
    begin
      Log.AddLn('r: ' + Read);
    end;
  end;
end;

procedure TfrmMain.Modules1Click(Sender: TObject);
begin
  SendData('MODULES');
end;

procedure TfrmMain.Threads1Click(Sender: TObject);
begin
  SendData('THREADS');
end;

procedure TfrmMain.WarmReboot1Click(Sender: TObject);
begin
//  SendData('REBOOT WAIT WARM');
  if(DebugBox.Reboot(DebugBox.rbWait and DebugBox.rbWarm and DebugBox.rbNoDebug,'')) then
  DebugBox.Disconnect;
//  if XClient.Connected then
//    XClient.Disconnect;
end;

procedure TfrmMain.GetProcessID1Click(Sender: TObject);
begin
  SendData('GETPID');
end;

procedure TfrmMain.XBEInfo1Click(Sender: TObject);
begin
  if DebugBox.IsConnected then
  begin
    progStatus := stGetXBEInfo;
    DebugBox.SendCmd('XBEINFO RUNNING');
  end;
end;

procedure TfrmMain.RebootCold1Click(Sender: TObject);
begin
//  SendData('REBOOT STOP NODEBUG');
  if(DebugBox.Reboot(DebugBox.rbStop and DebugBox.rbNoDebug,'')) then
//  if XClient.Connected then
  DebugBox.Disconnect;
//    XClient.Disconnect;
end;

procedure TfrmMain.Stop1Click(Sender: TObject);
begin
  DebugBox.SendCmd('STOP');
end;

procedure TfrmMain.Go1Click(Sender: TObject);
begin
  DebugBox.SendCmd('GO');
end;

procedure TfrmMain.lvBreakKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_INSERT then
  begin
  end
  else if key = VK_DELETE then
  begin
    if (lvBreak.ItemIndex >= 0) then
    begin

      with lvBreak.Selected do
      begin
        if(Checked = true) then
          SendData(Format('BREAK %s=%s SIZE=%s CLEAR',
           [SubItems.Strings[0],Caption,SubItems.Strings[1]]));
        {TODO: Delete from BP list in memory}
        Delete;
      end;
    end;
  end;
end;

procedure TfrmMain.bpSetClick(Sender: TObject);
var
NewItem:TListItem;
NewBP:TBreakpoint;
begin
  if edBPOffset.Text = '' then Exit;

  if not AnsiStartsStr('0x',edBPOffset.Text) then
    edBPOffset.Text := '0x' + edBPOffset.Text;

  if (edBPSize.Text = '') or (StrToInt(edBPSize.Text) <= 0) then edBPSize.Text := '1';

//  SendData(Format('BREAK %s=%s SIZE=%s',[cmbBPType.Text,edBPOffset.Text,edBPSize.Text]));

  NewBP.Size := StrToInt(edBPSize.Text);
  NewBp.Offset := StrToInt64(edBPOffset.Text);
  NewBP.Desc := edBPDesc.Text;
  NewBP.BPType := TBPTypes(GetEnumValue(TypeInfo(TBPTypes),cmbBPType.Text));

  SetLength(Breakpoints,Length(Breakpoints)+1);
  Breakpoints[High(Breakpoints)] := NewBP;
  NewItem := lvBreak.Items.Add;
  lvBreak.Items.BeginUpdate;
  NewItem.Caption := edBPOffset.Text;
  NewItem.SubItems.Add(cmbBPType.Text);
  NewItem.SubItems.Add(edBPSize.Text);
  NewItem.SubItems.Add('Never');
  NewItem.SubItems.Add(edBPDesc.Text);
  NewItem.Data := Pointer(NewItem.Checked);
  NewItem.Checked := true;
  lvBreak.Items.EndUpdate;


end;

procedure TfrmMain.bpUnsetClick(Sender: TObject);
var
Counter:Integer;
begin
  if edBPOffset.Text = '' then Exit;

  if not AnsiStartsStr('0x',edBPOffset.Text) then
    edBPOffset.Text := '0x' + edBPOffset.Text;

  if edBPSize.Text = '' then edBPSize.Text := '1';

  Counter := 0;
repeat
  if lvBreak.Items.Count = 0 then Break;
  with lvBreak.Items[Counter] do
  begin
    if Caption = edBPOffset.Text then
    begin
      if ( (SubItems.IndexOf(edBPSize.Text) >= 0) and
        (SubItems.IndexOf(cmbBPType.Text) >= 0) ) then
        Checked := false;

    end;
  end;
  Inc(Counter);
until Counter = lvBreak.Items.Count;
end;

procedure TfrmMain.ContinueThread1Click(Sender: TObject);
begin
  SendData('CONTINUE THREAD=' + InputBox('Which thread?','Which thread do you wish to continue?','28'));
end;

procedure TfrmMain.ServerExecute(AContext: TIdContext);
var
buf:String;
Index:Integer;
Pos:Integer;
Pos2:Integer;
Off:Cardinal;
HitOff:Cardinal;
BPType:String;
begin
  with AContext do
  begin
    buf := Connection.IOHandler.ReadLn;
    if ((AnsiStartsText('data',buf)) or (AnsiStartsText('break',buf))) then
    begin
      //data write=0x02414d80 addr=0x0007fc5d thread=28 stop
      if (AnsiStartsText('data',buf)) then
      begin
        Pos := AnsiPos('addr=',buf) + 5;
        HitOff := StrToInt64Def(AnsiMidStr(buf,Pos,10),0);

        Pos := AnsiPos('data ',buf) + 5;
        Pos2 := AnsiPos('=0x',buf);
        BPType := AnsiMidStr(buf,Pos,Pos2-Pos);

        Pos := AnsiPos(BPType + '=',buf) + Length(BPType) + 1;
        Off := StrToInt64Def(AnsiMidStr(buf,Pos,10),0);
      end
      else
      begin
        //break addr=0x0007fc5d thread=28 stop
        BPType := 'addr';

        Pos := AnsiPos('addr=',buf) + 5;
        HitOff := StrToInt64Def(AnsiMidStr(buf,Pos,10),0);

        Off := HitOff
      end;
{r: .
s: getcontext thread=28 int control
r: 202- multiline response follows
r: Ebp=0xd0059b6c
r: Esp=0xd0059b30
r: Eip=0x0007fc5d
r: EFlags=0x00000206
r: Eax=0x00000000
r: Ebx=0x024148f0
r: Ecx=0x0134fb20
r: Edx=0x004b2a60
r: Edi=0xd0059b14
r: Esi=0xd0059b48}

{TODO: Get registers}
      Log.AddLn(Format('Breakpoint detected (%s,0x%.80x,0x%.80x).',[BPType,Off,HitOff]));

      for index := 0 to High(Breakpoints) do
      begin
        if ((Breakpoints[Index].Offset = Off) and
            (Breakpoints[Index].BPType = TBPTypes(GetEnumValue(TypeInfo(TBPTypes),BPType)))) then
        begin
          lvBreak.Items.Item[Index].SubItems.Strings[2] := '0x' + IntToHex(HitOff,8);
        end;
      end;
      ProgStatus := stGetContext;
      SendData('GETCONTEXT thread=28 int control');

    end
    else
    begin
      Log.AddLn('n: ' + buf);
    end;
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
iniSet:TINIFile;
Counter:Integer;
begin
  iniSet := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'xdkassist.ini');
  iniSet.WriteString('Connection','Host',XClient.Host);
  iniSet.WriteInteger('Connection','Port',Server.defaultport);
  iniSet.WriteBool('Dumping','AutoStop',chkDumpAutoStop.Checked);
  iniSet.WriteBool('Dumping','AutoCopy',chkCopyOffToClip.Checked);
  iniSet.WriteBool('Dumping','Highlight',chkHighlightDumpChanges.Checked);
  iniSet.WriteBool('Logging','Verbose',chkVerboseLog.Checked);
  iniSet.WriteString('Breakpoints','Type',cmbBPType.Text);
  iniSet.WriteInteger('Window','State',Integer(frmMain.WindowState));
  if(frmMain.WindowState = wsMaximized) then
    frmMain.WindowState := wsNormal;
  iniSet.WriteInteger('Window','Width',frmMain.Width);
  iniSet.WriteInteger('Window','Height',frmMain.Height);
  iniSet.WriteInteger('Window','LastTab',pgControl.ActivePageIndex);
  iniSet.WriteInteger('Window','State',Integer(frmMain.WindowState));

  iniSet.WriteBool('Misc','WarnConClose',chkWarnConnected.Checked);
  iniSet.WriteBool('Layout','ShowMainLog',chkShowMainLog.Checked);


  iniSet.WriteBool('Range','Enabled',chkUseSearchRange.Checked);
  iniSet.WriteString('Range','Start',edSearcherStart.Text);
  iniSet.WriteString('Range','End',edSearcherEnd.Text);
  iniSet.WriteString('Range','Caption',edSearcherCaption.Text);
  iniSet.WriteString('Range','Class',edSearcherClass.Text);
  iniSet.WriteString('Range','State',edSearcherState.Text);

  for Counter:=0 to High(Tools) do
  begin
    With Tools[Counter] do
    begin
      iniSet.WriteString('Tool' + IntToStr(Counter),'Name',Name);
      iniSet.WriteString('Tool' + IntToStr(Counter),'Class',WinClass);
      iniSet.WriteString('Tool' + IntToStr(Counter),'Caption',WinText);
      iniSet.WriteBool('Tool' + IntToStr(Counter),'Load',Load);
    end;
  end;

  FreeAndNil(iniSet);

  while not ClientThread.Terminated do
  begin
    ClientThread.Terminate;
    if not ClientThread.Terminated then
    begin
      ShowMessage('Internet thread not terminated. Waiting, and then will try again.'
      + 'If you continue to get this message I am afraid you must end the task manually.');
      Sleep(2000);
    end;

  end;
  if Assigned(SavedDump) then FreeAndNil(SavedDump);
end;

procedure FillDumpPages(hDump:HWND);
var
Read:String;
begin
with DebugBox.Memory do
begin
  SetLength(Sections,0);
  SetLength(DebugBox.Memory.Sections,0);
  Read := '';
  while (Read <> '.') and
    Assigned(frmMain.XClient) and
    (not frmMain.ClientThread.Terminated) and
    (frmMain.XClient.Connected = true) do
  begin
    try
      Read := frmMain.XClient.IOHandler.ReadLn;
    except
      on E: Exception do
      begin
        if (E is EIdReadTimeout) or (E is EIdNoDataToRead) then Continue
        else if E is EIdConnClosedGracefully then
        begin
          SetLength(Sections,0);
          Exit;
        end
        else
          Log.AddLn(E.Message);
      end;
    end;

    if (Read = '') or (Read = '.') then Continue;
    SetLength(Sections,Length(Sections)+1);
    with Sections[High(Sections)] do
    begin
      Offset := StrToInt( AnsiMidStr(Read,AnsiPos('base=',Read) + Length('base='),10));
      Size := StrToInt( AnsiMidStr(Read,AnsiPos('size=',Read) + Length('size='),10));
      Flags := StrToInt( AnsiMidStr(Read,AnsiPos('protect=',Read) + Length('protect='),10));
      Loc := 0;
    end;
  end;
end;
end;

procedure GetDumpData(hProgress:HWND;hWin:HWND;Verbose:Boolean);
var
Counter:Cardinal;
NewSize:Cardinal;
Time:Cardinal;
MemStream:TMemoryStream;
begin
//  MemBuffer.Clear;
  DebugBox.Memory.Buffer.Clear;
  if(frmMain.hxMemView.DataSize > 0) then
  begin
    frmMain.hxMemView.CreateEmptyFile('');
  end;
with DebugBox.Memory do
begin
  NewSize := 0;
  for Counter := Low(Sections) to High(Sections) do
    NewSize := NewSize + Sections[Counter].Size;

  PostMessage(hProgress,PBM_SETRANGE32,0,High(Sections));

  //MemBuffer.SetSize(NewSize);
  DebugBox.Memory.Buffer.SetSize(NewSize);
try
begin
  MemStream := TMemoryStream.Create;
  if (not Assigned(MemStream)) then
  begin
    log.addln('Failed to create memory stream for dumping.');
    Exit;
  end;

  for Counter := 0 to High(Sections) do
  begin
  with Sections[Counter] do
  begin
    Time := GetTickCount;
    MemStream.Clear;
    MemStream.SetSize(Size);

    frmMain.XClient.IOHandler.WriteLn(Format('GETMEM2 ADDR=0x%.8x LENGTH=0x%.8x',[Offset,Size]));
    while (frmMain.XClient.IOHandler.ReadLn <> '203- binary response follows') and (frmMain.XClient.Connected) do;
    while (Cardinal(frmMain.XClient.IOHandler.InputBuffer.Size) < Size) and (frmMain.XClient.Connected) do;

    frmMain.XClient.IOHandler.ReadStream(MemStream,Size);
    PostMessage(hProgress,PBM_SETPOS,Counter,0);

    try
    begin
//      MemBuffer.CopyFrom(MemStream,0);
      DebugBox.Memory.Buffer.CopyFrom(MemStream,0);
//      Loc := Membuffer.Position;
      Loc := DebugBox.Memory.Buffer.Position;
      if Verbose then
        Log.AddLn(Format('Dumped %d bytes in %.2f seconds from 0x%.8x (0x%.8x)',
        [Size,(GetTickCount-Time)/1000,Offset,
        //Cardinal(MemBuffer.Memory)
        Cardinal(DebugBox.Memory.Buffer.Memory)
         + Loc-Size]));
    end
    except
      on E: Exception do
        log.AddLn('Dump (MemStream): ' + E.Message);
    end;

    if (not frmMain.XClient.IOHandler.InputBufferIsEmpty) and
     (frmMain.XClient.Connected = true) then
    begin
      Log.AddLn(IntToStr(frmMain.XClient.IOHandler.InputBuffer.size) + ' bytes still on input buffer.');
      frmMain.XClient.IOHandler.ReadStream(MemStream,frmMain.XClient.IOHandler.InputBuffer.Size);
    end;
  end;
  end;
  FreeAndNil(MemStream);
end
except
  on E: Exception do
    Log.AddLn('Dump: ' + E.Message);
end;
end;
end;

procedure TfrmMain.edBPOffsetKeyPress(Sender: TObject; var Key: Char);
begin
  if (not IsValidHexBoxInput(Key)) and (not (Key in ['x','X'])) then
  Key := #0;
end;

procedure TfrmMain.edBPSizeKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',Char(VK_BACK),Char(VK_DELETE)]) then Key := #0;
end;
{
function LaunchAsChild(EXEName:String;EXEClass:PAnsiChar;EXECaption:PAnsiChar;Parent:HWND):HWND;
var
Win:HWND;
r:TRect;
GWL:LongInt;
begin
  Result := 0;
  if (not FileExists(EXEName)) then Exit;

  Win := FindWindow(EXEClass,EXECaption);

  if Win = 0 then
  begin
    ShellExecute(Parent,'open',PAnsiChar(EXEName),#0,#0,SW_HIDE);
    Sleep(150);
    Win := FindWindow(EXEClass,EXECaption);
    if Win = 0 then Exit;
  end;
  ShowWindow(Win,SW_HIDE);
  SetParent(Win,Parent);

  ShowWindow(Win,SW_HIDE);
  SetParent(Win,Parent);

  GWL := GetWindowLong(Win,GWL_STYLE);

{  if (GWL and WS_BORDER) = WS_BORDER then
    GWL := GWL and (not WS_BORDER);
  if (GWL and WS_OVERLAPPEDWINDOW) = WS_OVERLAPPEDWINDOW then
    GWL := GWL and (not WS_OVERLAPPEDWINDOW);
  if (GWL and WS_DLGFRAME) = WS_DLGFRAME then
    GWL := GWL and (not WS_DLGFRAME);
} { if (GWL and WS_THICKFRAME) = WS_THICKFRAME then
    GWL := GWL and (not WS_THICKFRAME);
  if (GWL and WS_POPUP) = WS_POPUP then
    GWL := GWL and (not WS_POPUP); }
{  if (GWL and WS_MINIMIZEBOX) = WS_MINIMIZEBOX then
    GWL := GWL and (not WS_MINIMIZEBOX);
} { if (GWL and WS_MAXIMIZEBOX) = WS_MAXIMIZEBOX then
    GWL := GWL and (not WS_MAXIMIZEBOX);  }
{  if (GWL and WS_SYSMENU) = WS_SYSMENU then
    GWL := GWL and (not WS_SYSMENU);
}{  if (GWL and WS_OVERLAPPED) = WS_OVERLAPPED then
    GWL := GWL and (not WS_OVERLAPPED); }
{  if (GWL and WS_CAPTION) = WS_CAPTION then
    GWL := GWL and (not WS_CAPTION);      }
//  GWL := GWL or WS_CHILD;
 { SetWindowLong(Win,GWL_STYLE,GWL);

  GWL := GetWindowLong(Win,GWL_EXSTYLE);
  if (GWL and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE then
    GWL := GWL and (not WS_EX_CLIENTEDGE);
  if (GWL and WS_EX_DLGMODALFRAME) = WS_EX_DLGMODALFRAME then
    GWL := GWL and (not WS_EX_DLGMODALFRAME);
  if (GWL and WS_EX_APPWINDOW) = WS_EX_APPWINDOW then
    GWL := GWL and (not WS_EX_APPWINDOW); }

//  GWL := GWL or WS_EX_TOOLWINDOW;
{  GWL := GWL or WS_EX_STATICEDGE;
  GWL := GWL or WS_EX_CONTROLPARENT;
  SetWindowLong(Win,GWL_EXSTYLE,GWL);

  GetWindowRect(Win,r);
  ShowWindow(Win,SW_SHOW);
  MoveWindow(Win,0,0,r.Right-r.Left+1,r.Bottom-r.Top,true);

  Result := Win;
end;
          }
procedure TfrmMain.FormDestroy(Sender: TObject);
var
Counter:Integer;
begin
  for Counter := 0 to Length(Tools)-1 do
    if Tools[Counter].Handle <> 0 then PostMessage(Tools[Counter].Handle, WM_QUIT,0,0);

  if (moNotes.Lines.Count > 0) then
    moNotes.Lines.SaveToFile('xdkassist.notes')
  else
    if FileExists('xdkassist.notes') then DeleteFile('xdkassist.notes');
end;

procedure TfrmMain.ConnectToggle(Tog:Boolean);
begin
  ProgStatus := stNorm;

  try
    if Server.DefaultPort <> -1 then
      Server.Active := tog;
  except
    on E: Exception do Log.AddLn('Server Toggle: ' + E.Message);
  end;

  hxMemView.Enabled := Tog;
  edInput.Enabled := Tog;
  lvBreak.Enabled := Tog;
  lvDump.Enabled := Tog;
  edBPOffset.Enabled := Tog;
  edBPDesc.Enabled := Tog;
  edBPSize.Enabled := Tog;
  cmbBPType.Enabled := Tog;
  bpSet.Enabled := Tog;
  bpUnset.Enabled := Tog;
  grpConvOffset.Enabled := Tog;
  grpMemEdit.Enabled := Tog;
  pbDump.Enabled := Tog;
  lbBPType.Enabled := Tog;
  edViewoffset.Enabled := Tog;
  edByteSearch.Enabled := Tog;
  btMemSrchReset.Enabled := Tog;
  lvRegisters.Enabled := Tog;
  btGetRegisters.Enabled := Tog;

  if Tog then
  begin
    try
      ClientThread.Start;
    except
      on E: Exception do Log.AddLn('Recv Startup: ' + E.Message);
    end;
    frmmain.Connect1.Caption := 'Disconnect';
    frmMain.Connect1.ImageIndex := 6;
  end
  else
  begin
    ClientThread.Stop;
    frmmain.Connect1.Caption := 'Connect';
    frmMain.Connect1.ImageIndex := 7;

    lvBreak.Items.Clear;
    lvDump.Items.Clear;
    pbDump.Position := 0;
//    MemBuffer.Clear;
    DebugBox.Memory.Buffer.Clear;
    SavedDump.Clear;
//    if hxMemView.DataSize > 0 then
//      hxMemView.LoadFromStream(SavedDump);
//      hxMemView.CreateEmptyFile('Empty');

  end;
end;

procedure TfrmMain.OnNewText(var Msg: TMessage);
var
Change:String;
begin
  try
  begin
    if (Msg.WParam < 0) then Exit;
    Log.Seek(Msg.WParam,soFromBeginning);
    Change := Log.ReadString(Msg.Lparam);
    richlog.SelStart := richlog.GetTextLen;
    richLog.SelText := Change;
  end
  except
    on E: Exception do ShowMessage('Logging update: ' + E.Message);
  end;
end;

procedure TfrmMain.edViewOffsetKeyPress(Sender: TObject; var Key: Char);
begin
  if (not IsValidHexBoxInput(Key)) and (not (Key in ['x','X'])) then Key := #0;
end;

procedure TfrmMain.edViewOffsetKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
Off:Cardinal;
Sect:Integer;
ret:Integer;
begin
  if Key <> VK_RETURN then Exit;

  if AnsiPos('0X',edViewOffset.Text) <= 0 then
    edViewOffset.Text := Format('0x%.8x',[StrToInt64Def('0x' + edViewOffset.Text,0)]);

  //if (MemBuffer.Size <= 0) or
  //    (Length(Sections) <= 0) then
  if (DebugBox.Memory.Buffer.Size <= 0) or
    (Length(DebugBox.Memory.Sections) <= 0) then
  begin
    log.AddLn('There is no dump.');
    Exit;
  end;

  ret := ConvXBOX2PC(StrToInt64Def(edViewOffset.Text,0),@Sect,@Off);
  if ret <> EConvOkay then
    log.AddLn(ConvError(ret));

  if (Sect >= 0) then
    hxMemView.SetTopLeftPosition(Off -
      //Cardinal(Membuffer.Memory)
      Cardinal(DebugBox.Memory.Buffer.Memory)
      ,false);

end;

procedure TfrmMain.edByteSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if not IsValidHexBoxInput(Key) then Key := #0;
end;

procedure TfrmMain.edByteSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
BinBuf:PAnsiChar;
BinLen:Integer;
begin
  if Key <> VK_RETURN then Exit;

  BinLen := Length(edByteSearch.Text) div 2 + Length(edByteSearch.Text) mod 2;

  if (BinLen <= 0) or
    //(MemBuffer.Size <= 0)
    (DebugBox.Memory.Buffer.Size <= 0)
    then Exit;

  BinBuf := StrAlloc(BinLen);

  HexToBin(PAnsiChar(edByteSearch.Text),BinBuf,BinLen);

  BinBuf := PansiChar(hxMemView.PrepareFindReplaceData(String(BinBuf),false,false));

  MemSrchPos := hxMemView.Find(BinBuf,BinLen,MemSrchPos,hxMemView.DataSize,false);

  if MemSrchPos > -1 then
  begin
    hxMemView.Seek(MemSrchPos,0);
    hxMemView.SelStart := MemSrchPos;
    hxMemView.SelEnd := MemSrchPos + BinLen - 1;
    Inc(MemSrchPos);
  end
  else
    log.AddLn('Pattern not found.');

end;

procedure TfrmMain.OnNewDump(var Msg:TMessage);
var
Count:Integer;
ti:TListItem;
Searcher:THandle;
pid:Cardinal;
phandle:THandle;
data:Cardinal;
bytes:Cardinal;
off:Cardinal;
state:WORD;
begin
  try
  begin
    hxMemView.OffsetFormat := '1%1!10:0x|';
//    hxMemView.LoadFromStream(MemBuffer);
    hxMemView.LoadFromStream(DebugBox.Memory.Buffer);

    PostMessage(ProgressBar,PBM_SETPOS,
      SendMessage(ProgressBar,PBM_GETRANGE,wparam(false),lparam(nil)),0);

    if chkDumpAutoStop.Checked then SendData('GO');

//    for Count := 0 to High(Sections) do
    for Count := 0 to High(DebugBox.Memory.Sections) do
    begin
      with DebugBox.Memory.Sections[Count] do
//      with Sections[Count] do
      begin
        ti := lvDump.Items.Add;
        ti.Caption := IntToStr(ti.Index+1);
        ti.SubItems.Add('0x' + IntToHex(Offset,8));//Offset
        ti.SubItems.Add('0x' + IntToHex(Size,8));//Size
        ti.SubItems.Add('0x' + IntToHex(Flags,8));//Flags
//        ti.SubItems.Add('0x' + IntToHex(Cardinal(MemBuffer.Memory) + Loc-Size,8));//Start
//        ti.SubItems.Add('0x' + IntToHex(Cardinal(MemBuffer.Memory) +Loc,8));//End
        ti.SubItems.Add('0x' + IntToHex(Cardinal(DebugBox.Memory.Buffer.Memory) + Loc - Size, 8));
        ti.SubItems.Add('0x' + IntToHex(Cardinal(DebugBox.Memory.Buffer.Memory) + Loc, 8));
      end;
    end;

  end
  except
    on E: Exception do log.Addln(E.Message);
  end;

  ProgStatus := stNorm;

  if(chkUseSearchRange.Checked) then
  begin
    Searcher := FindWindow(PAnsiChar(edSearcherClass.Text+#0),PAnsiChar(edSearcherCaption.Text+#0));
    if(Searcher <> 0) then
    begin
      GetWindowThreadProcessId(Searcher,@pid);
      phandle := OpenProcess(PROCESS_ALL_ACCESS,false,pid);
      if phandle <> 0 then
      begin
        off := StrToInt64(MakeOffset(edSearcherStart.Text));
        if (off <> 0) then
        begin
//          data := Cardinal(MemBuffer.Memory);
          data := Cardinal(DebugBox.Memory.Buffer.Memory);
          WriteProcessMemory(phandle,Pointer(off),@data,4,bytes);
        end;

        off := StrToInt64(MakeOffset(edSearcherEnd.Text));
        if (off <> 0) then
        begin
//          data := Cardinal(MemBuffer.Memory) + Cardinal(MemBuffer.Size);
          Data := Cardinal(DebugBox.Memory.Buffer.Memory) + Cardinal(DebugBox.Memory.Buffer.Size);
          WriteProcessMemory(phandle,Pointer(off),@data,4,bytes);
        end;

        off := StrToInt64(MakeOffset(edSearcherState.Text));
        if (off <> 0) then
        begin
          state := 1;
          WriteProcessMemory(phandle,Pointer(off),@state,2,bytes);
        end;

        log.AddLn(Format('Patched %s (%s) at %s and %s',[edSearcherCaption.Text,edSearcherClass.Text,edSearcherStart.Text,edSearcherEnd.Text]));
        CloseHandle(phandle);
      end
      else
        log.addln('Couldn''t set range in your search application. Is it running?')
    end
    else
      log.addln('Couldn''t set range in your search application. Is it running?')
  end;
end;

procedure TfrmMain.btMemSrchResetClick(Sender: TObject);
begin
  MemSrchPos := 0;
end;

function IsValidHexBoxInput(var Key: Char):Boolean;
begin
  Result := false;

  if (Key in ['A'..'F','a'..'f','0'..'9',Char(VK_BACK),Char(VK_DELETE)]) or
      (Key in ['V','v','X','x'{,#22,#3,#24}]) or
      (Key < ' ') then Result := true;

end;

function IsValidIP(const AAddr : String): Boolean;
var LIP :  TIdIPAddress;
begin
  LIP :=  TIdIPAddress.MakeAddressObject(AAddr);
  Result := Assigned(LIP);
  if Result then
  begin
    FreeAndNil(LIP);
  end;
end;

procedure TfrmMain.SetXBOXAddress1Click(Sender: TObject);
var
NewIP:String;
begin
  NewIP := InputBox('Enter a new IP','Enter in the new address for your XBOX.',XClient.Host);

  while (not IsValidIP(NewIP)) do
  begin
    if InputQuery('Enter a new, valid, IP.',
      'The IP that was entered into the box was invalid. Please enter a new one.',
      NewIP) = false then Exit;
  end;

  XClient.Host := NewIP;
end;

procedure TfrmMain.SetListenPort1Click(Sender: TObject);
var
NewPort:String;
begin
  NewPort := InputBox('Enter a new port.','Type in the port you would like the XBOX to connect to your machine on.' + #13#10 +
    'Enter -1 if you want to disable this feature, however this is not recommended because you will miss out in nice information, and ' +
    'some features will not work properly.',IntToStr(Server.DefaultPort));

  while not IsNumeric(NewPort) do
  begin
    if InputQuery('Enter a new, valid, port',
        'The port that was entered into the box was invalid. Please enter a new one.',
        NewPort) = false then Exit;
  end;

  Server.DefaultPort := StrToInt(NewPort);
end;

procedure TfrmMain.JumpbyXBOXAddress1Click(Sender: TObject);
var
Offset:String;
begin
  if InputQuery('Jump by XBOX addy.','This will let you jump around the dump using an xbox address.',Offset) = false then Exit;

end;

procedure TfrmMain.JumpbyPCAddress1Click(Sender: TObject);
var
Offset:String;
begin
  if InputQuery('Jump by PC addy.','This will let you jump around the dump using a PC address.',Offset) = false then Exit;

end;

procedure TfrmMain.SavetoFile1Click(Sender: TObject);
var
CurDir:String;
begin
  CurDir := GetCurrentDir;
  SaveDialog.InitialDir := GetCurrentDir;

  if SaveDialog.Execute then
  begin
    hxMemView.SaveToFile(SaveDialog.FileName);
    log.addln('Saved the dump to ' + SaveDialog.filename);
    SetCurrentDir(CurDir);
  end;
  
end;

procedure TfrmMain.hxMemViewChange(Sender: TObject);
var
Pos:Integer;
Mem:Char;
XBOX:Cardinal;
begin
  if(not XClient.Connected) then Exit;
  if(ProgStatus = stDump) then Exit;
  Pos := hxMemView.GetCursorPos;
  Mem := hxMemView.GetMemory(Pos);
//  Pos := ConvPC2XBOX(Cardinal(MemBuffer.Memory) + Cardinal(Pos),@xbox);
  Pos := ConvPC2XBOX(Cardinal(DebugBox.Memory.Buffer.Memory) + Cardinal(Pos),@XBOX);
  if (Pos <> EConvOkay) then
    Log.AddLn(ConvError(Pos))
  else
    SendData(Format('SETMEM ADDR=0x%.80x DATA=%s',[xbox,IntToHex(Integer(Mem),2)]));
end;

procedure TfrmMain.cbMemEditChange(Sender: TObject);
begin
  if (cbMemEdit.Text = 'GETMEM') then
    edMemEditParam.EditLabel.Caption := 'Length:'
  else
    edMemEditParam.EditLabel.Caption := 'Data:';

end;

procedure TfrmMain.btMemEditClick(Sender: TObject);
begin
  if(cbMemEdit.Text = 'GETMEM') then
    SendData(Format('GETMEM ADDR=0x%s LENGTH=%s',[edMemEditOffset.Text,edMemEditParam.Text]))
  else  //Setmem
    SendData(Format('SETMEM ADDR=0x%s DATA=%s',[edMemEditOffset.Text,edMemEditParam.Text]));
end;

procedure TfrmMain.edConvOffsetFromKeyPress(Sender: TObject; var Key: Char);
begin
  if (not IsValidHexBoxInput(Key)) and (not (Key in ['x','X'])) then Key := #0;
end;

procedure TfrmMain.edConvOffsetFromKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
ConvOffset:Cardinal;
Original:Cardinal;
Ret:Integer;
begin
  if Key <> VK_RETURN then Exit;

  if (not IsHexidecimal(edConvOffsetFrom.Text) and
      (not IsNumeric(edConvOffsetFrom.Text))) then
  begin
    lbConvOffStat.Caption := 'Bad input';
    Log.AddLn('An invalid input string was specified. Please make sure that the string was a hexidecimal string. The 0x is optional.');
    Exit;
  end;

  if (not AnsiStartsStr('0X',Uppercase(edConvOffsetFrom.Text))) then
    edConvOffsetFrom.Text := '0x' + edConvOffsetFrom.Text;

  Original := StrToInt(edConvOffsetFrom.Text);

  if(cbOffsetConvert.Text = 'PC') then  begin
    Ret := ConvPC2XBOX(Original,@ConvOffset);
  end else begin  //XBOX
    Ret := ConvXBOX2PC(Original,nil,@ConvOffset);
  end;

  case Ret of
    EConvOkay:      lbConvOffStat.Caption := 'Converted.';
    EConvNotFound:  lbConvOffStat.Caption := 'Not found.';
    EConvBadPointer: lbConvOffStat.Caption := 'Bad pointer.';
    EConvOutOfRange: lbConvOffStat.Caption := 'Out of range.';
    EConvNoSections: lbConvOffStat.Caption := 'Missing sections.';
  end;

  if (Ret <> EConvOkay) then
  begin
    Log.AddLn(ConvError(ret));
  end
  else
  begin
    Log.AddLn(edConvOffsetFrom.Text + ' converted to 0x' + IntTohex(ConvOffset,8));
    edConvOffsetTo.Text := '0x' + IntTohex(ConvOffset,8);
    if (chkCopyOffToClip.Checked) then
      TextToClip(IntToHex(ConvOffset,8));
  end;

end;

procedure TfrmMain.edMemEditParamKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then Exit;

  btMemEditClick(Sender);

end;

procedure TfrmMain.GenericMenuItemClick(Sender: TObject);
begin

  if ((TMenu(Sender).Tag < Low(Tools)) or (TMenu(Sender).Tag > High(Tools))) then
  begin
    Log.AddLn('Tool index was out of valid range.');
    Exit;
  end;

  with Tools[TMenu(Sender).Tag] do
  begin
{    if( Load ) then
      LaunchAsChild(Name,PAnsiChar(WinClass+#0),PAnsiChar(WinText+#0),frmMain.Handle)
    else}
      ShellExecute(0{frmMain.Handle},'open',PAnsiChar(Name),#0,#0,SW_NORMAL);
  end;
end;

procedure TfrmMain.lvBreakChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
buf:String;
begin
  if ( Change <> ctState) then Exit;

  if (Boolean(Item.Data) <> Item.Checked) then
  begin
    buf := Format('BREAK %s=%s SIZE=%s',
      [Item.SubItems.Strings[0],
        Item.Caption,
        Item.SubItems.Strings[1]]);

    if (not Item.Checked) then
      buf := buf + ' CLEAR';
    SendData(buf);
    Item.Data := Pointer(Item.Checked);
  end;
end;

procedure TfrmMain.lvDumpSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
Flags:Cardinal;
begin
  if not Selected then Exit;

  for Flags := 0 to lbSectFlags.Items.Count-1 do
    lbSectFlags.Checked[Flags] := false;

  Flags := StrToInt64Def(Item.SubItems.Strings[2],0);

  if (Flags and PAGE_NOACCESS) = PAGE_NOACCESS then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_NOACCESS')] := true;


  if (Flags and PAGE_READONLY) = PAGE_READONLY then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_READONLY')] := true;

  if (Flags and PAGE_READWRITE) = PAGE_READWRITE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_READWRITE')] := true;

  if (Flags and PAGE_EXECUTE) = PAGE_EXECUTE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_EXECUTE')] := true;

  if (Flags and PAGE_EXECUTE_READ) = PAGE_EXECUTE_READ then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_EXECUTE_READ')] := true;

  if (Flags and PAGE_EXECUTE_READWRITE) = PAGE_EXECUTE_READWRITE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_EXECUTE_READWRITE')] := true;

  if (Flags and PAGE_GUARD) = PAGE_GUARD then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_GUARD')] := true;

  if (Flags and PAGE_NOCACHE) = PAGE_NOCACHE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_NOCACHE')] := true;

  if (Flags and PAGE_WRITECOMBINE) = PAGE_WRITECOMBINE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('PAGE_WRITECOMBINE')] := true;

  if (Flags and MEM_COMMIT) = MEM_COMMIT then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_COMMIT')] := true;

  if (Flags and MEM_DECOMMIT) = MEM_DECOMMIT then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_DECOMMIT')] := true;

  if (Flags and MEM_RELEASE) = MEM_RELEASE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_RELEASE')] := true;

  if (Flags and MEM_RESERVE) = MEM_RESERVE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_RESERVE')] := true;

  if (Flags and MEM_FREE) = MEM_FREE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_FREE')] := true;

  if (Flags and MEM_PRIVATE) = MEM_PRIVATE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_PRIVATE')] := true;

  if (Flags and MEM_MAPPED) = MEM_MAPPED then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_MAPPED')] := true;

  if (Flags and MEM_RESET) = MEM_RESET then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_RESET')] := true;

  if (Flags and MEM_TOP_DOWN) = MEM_TOP_DOWN then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_TOP_DOWN')] := true;

  if (Flags and MEM_LARGE_PAGES) = MEM_LARGE_PAGES then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_LARGE_PAGES')] := true;

  if (Flags and MEM_4MB_PAGES) = MEM_4MB_PAGES then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('MEM_4MB_PAGES')] := true;

  if (Flags and SEC_RESERVE) = SEC_RESERVE then
    lbSectFlags.Checked[lbSectFlags.Items.IndexOf('SEC_RESERVE')] := true;

end;
procedure TfrmMain.btDumpClick(Sender: TObject);
begin
  DumpMemory1Click(Sender);
end;

procedure TfrmMain.RestartTitle1Click(Sender: TObject);
begin
  if (DebugBox.XBE.Name <> '') then
    DebugBox.Reboot(0,DebugBox.XBE.Name)
//  if (XBEName <> '') then
//    SendData('magicboot title="'+XBEName+'" debug')
  else
    Log.AddLn('Please run the XBE Info command from the menu first.');

end;

procedure TfrmMain.lvBreakSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  edBPOffset.Text := Item.Caption;
  edBPSize.Text := Item.SubItems.Strings[1];
  edBPDesc.Text := Item.SubItems.Strings[3];
  cmbBPType.ItemIndex := cmbBPType.Items.IndexOf(Item.SubItems.Strings[2]);

end;

procedure TfrmMain.SaveLog1Click(Sender: TObject);
begin
  Log.SaveToFile('xdkassist.log');
end;

procedure TfrmMain.hxMemViewTopLeftChanged(Sender: TObject);
var
i:Integer;
DStart,DEnd:Integer;
begin
  if (not chkHighlightDumpChanges.Checked) or
    (SavedDump.Size <= 0) or
    (hxMemView.DataSize <= 0) then Exit;


  DStart := hxMemView.DisplayStart;
  DEnd := hxMemView.DisplayEnd;

  if ((DStart > SavedDump.Size) or (DEnd > SavedDump.Size)) then
  begin
    //New dump is larger than old dump
    for i := DStart to DEnd do
    begin
      if (i > hxMemView.DataSize-1) then break;
      hxMemView.ByteChanged[i] := true;
    end;
    Exit;
  end;

  for i := DStart to DEnd do
  begin
    if (i > hxMemView.DataSize-1) then break;

    if ((PByteArray(SavedDump.Memory)[i]) <> hxMemView.Data[i]) then
      hxMemView.ByteChanged[i] := true;
  end;
end;

procedure TfrmMain.btGetRegistersClick(Sender: TObject);
begin
  if(not XClient.Connected) then Exit
  else if (ProgStatus <> stNorm) then
  begin
    log.AddLn('Busy with another action.');
    Exit;
  end;

  ProgStatus := stGetContext;

  SendData('HALT');
  SendData('GETCONTEXT THREAD=28 CONTROL INT FP');
  SendData('CONTINUE THREAD=28');
  SendData('GO');
end;

procedure TfrmMain.chkShowMainLogClick(Sender: TObject);
begin
  if chkShowMainLog.Checked then
  begin
    pgControl.Top := grpConsole.Top + grpConsole.Height + pgControl.Left;
    pgControl.Height := frmMain.ClientHeight - (pgControl.Left * 4) - grpConsole.height;
    grpConsole.Visible := true;
  end
  else
  begin
    grpConsole.Visible := false;
    pgControl.Top := grpConsole.Top;
    pgControl.Height := frmMain.ClientHeight - (pgControl.left*3);
  end;


end;

procedure TfrmMain.btnToolSelectClick(Sender: TObject);
begin
  odToolSelect.FileName := '';
  if not odToolSelect.Execute() then Exit;
  edToolPath.Text := odToolSelect.FileName;
end;

end.
