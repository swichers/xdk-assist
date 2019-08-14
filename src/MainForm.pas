unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Tabs, DockTabSet, ExtCtrls, ComCtrls, IdCustomTCPServer,
  IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdThreadComponent, CommCtrl, Buttons, CXboxManager, Global, IdIPAddress, Log,
  ImgList, IdGlobal, AppStrings, Grids, ValEdit;

  const
       WM_NEWLOG = WM_USER+1;
       WM_NEWDUMP = WM_NEWLOG+1;

type
  TfrmMain = class(TForm)
    tsTabs: TTabSet;
    nbMaintabs: TNotebook;
    edInput: TEdit;
    memoLog: TMemo;
    pbDumpStatus: TProgressBar;
    tcpClient: TIdTCPClient;
    tcpServer: TIdTCPServer;
    sBar: TStatusBar;
    thrdClient: TIdThreadComponent;
    btnDump: TBitBtn;
    lbDumpProg: TLabel;
    grpDumpInfo: TGroupBox;
    grpOffset: TGroupBox;
    thrdConnect: TIdThreadComponent;
    imgList: TImageList;
    btConnect: TBitBtn;
    vlSettings: TValueListEditor;
    lvDumpInfo: TListView;
    procedure vlSettingsStringsChange(Sender: TObject);
    procedure lvDumpInfoResize(Sender: TObject);
    procedure thrdClientStopped(Sender: TIdThreadComponent);
    procedure edInputKeyPress(Sender: TObject; var Key: Char);
    procedure thrdConnectStopped(Sender: TIdThreadComponent);
    procedure thrdConnectRun(Sender: TIdThreadComponent);
    procedure tcpClientStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure tcpClientConnected(Sender: TObject);
    procedure nbMaintabsPageChanged(Sender: TObject);
    procedure btConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sBarResize(Sender: TObject);
    procedure thrdClientRun(Sender: TIdThreadComponent);
    procedure tsTabsChange(Sender: TObject; NewTab: Integer;
          var AllowChange: Boolean);
    procedure OnNewLog(var msg:TMessage);message WM_NEWLOG;
    procedure ConnectButtonUpdate();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Xbox:TXBOX;
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btConnectClick(Sender: TObject);
var
sTemp:String;
ret:Boolean;
begin
  tcpClient.Port := Xbox._XDKPort;

  if (not IsValidIP(tcpClient.Host)) then     //IP Address assigned to host is invalid
  begin

    if (Length(tcpClient.Host) <= 0) then     //If host is empty
      sTemp := '<blank>'
    else
      sTemp := tcpClient.Host;

    AppLog.addItem('IP Address ( ' + sTemp + ' ) input in settings is invalid.',ltError);

    while( not IsValidIP(tcpClient.Host) )
    do begin
      ret := InputQuery('Error: Bad IP Address','The IP Address entered on the settings page is invalid. Please enter a correct value.' +
                                               #13#10 + #13#10 +  'Current value is: ' + sTemp, sTemp);

      if (ret = false) then Exit;         //Exit out if user cancels input request

      if (IsValidIP(sTemp)) then          //Entered IP was valid this time?
        tcpClient.Host := sTemp;          //Set host to entered value
        Xbox.setIP(tcpClient.Host);
    end;
  end;

  if (thrdClient.Stopped AND thrdConnect.Stopped) then begin
     thrdConnect.Start;
     AppLog.addItem('Starting connection thread.',ltQuick);
     AppLog.addItem('Initializing connection thread.',ltStatus);
  end else if (not thrdConnect.Stopped) then begin                          //Connection thread running
    thrdConnect.Stop;
    AppLog.addItem('Stopping connection thread.', ltQuick);
    AppLog.addItem('Closing connection thread.',ltStatus);
  end else if (not thrdClient.Stopped) then begin                 //Processing thread running
    Xbox.Disconnect();
    thrdClient.Stop;
    AppLog.addItem('Stopping processing thread.', ltQuick);
    AppLog.addItem('Closing processing thread.',ltStatus);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
     AppLog := TLog.Create(frmMain.Handle,WM_NEWLOG);
     AppLog.addItem('Application started.',ltStatus);
     AppLog.addItem('Started.',ltQuick);

     btConnect.Parent := sBar;
     tcpClient := TIdTCPClient.Create();
     Xbox := TXBOX.Create(@tcpClient);
     tcpClient.Host := Xbox.IP.IPv4AsString;
     tcpClient.Port := Xbox.XDKPort;

     ConnectButtonUpdate();

     tsTabs.TabIndex := nbMaintabs.PageIndex;
//     tsTabs.DitherBackground := false;
//     tsTAbs.UnselectedColor := clBlack;
//     tsTabs.BackgroundColor := clBlack;

end;

procedure TfrmMain.lvDumpInfoResize(Sender: TObject);
begin
  lvDumpInfo.Columns.Items[0].Width := (lvDumpInfo.ClientWidth div lvDumpInfo.Columns.Count);
  lvDumpInfo.Columns.Items[0].Width := (lvDumpInfo.ClientWidth div lvDumpInfo.Columns.Count);
end;

procedure TfrmMain.nbMaintabsPageChanged(Sender: TObject);
var
row_idx:Integer;
begin
  if (nbMaintabs.PageIndex = nbMaintabs.Pages.IndexOf('Settings')) then  //Checks to see if Settings tab was selected
  begin
    if vlSettings.FindRow('Notify Port',row_idx) then
      vlSettings.Keys[row_idx] := IntToStr(Xbox.EventPort);

    if vlSettings.FindRow('IP Address',row_idx) then
      vlSettings.Keys[row_idx] := Xbox.IP.IPv4AsString;
//    leIP.Text := Xbox.IP.IPv4AsString;
//    lePort.Text := IntToStr(Xbox.EventPort);
  end;
end;

procedure TfrmMain.sBarResize(Sender: TObject);
var
sbar_rect:TRect;
begin
     sBar.Panels.Items[0].Width := sBar.Width - 19;//sBar.Height;

     SendMessage(sBar.Handle,SB_GETRECT,1,Integer(@sbar_rect));
     btConnect.Top := sbar_rect.Top;
     btConnect.Left := sbar_rect.Left;
     btConnect.width := 19;//sBar.Panels.Items[1].Width;
     btConnect.height := sBar.Height;
end;

procedure TfrmMain.tsTabsChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
     nbMaintabs.PageIndex := NewTab;
end;

procedure TfrmMain.vlSettingsStringsChange(Sender: TObject);
var
row_idx:Integer;
begin
  if (not vlSettings.FindRow('Notify Port',row_idx)) then Exit;

  Xbox.EventPort := StrToIntDef(vlSettings.Keys[row_idx],Xbox._NotifyPort);

  if (not vlSettings.FindRow('IP Address',row_idx)) then Exit;

  if (not Xbox.setIP(vlSettings.Keys[row_idx])) then
  begin
    ShowMessage('Invalid ip address');
    Exit;
  end;

  if (not vlSettings.FindRow('Notification Enabled',row_idx)) then Exit;

//  Xbox.EnableNotify := vlSettings.Keys[row_idx];

  tcpClient.Host := Xbox.IP.IPv4AsString;
  tcpServer.DefaultPort := Xbox.EventPort;

end;

procedure TfrmMain.tcpClientConnected(Sender: TObject);
begin
  AppLog.addItem('tcpConnected.',ltStatus);
end;

procedure TfrmMain.tcpClientStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
AppLog.addItem(Astatustext,ltNormal);
  case AStatus of
    hsResolving: ;    //Hostname being resolved to an IP address
    hsConnecting: AppLog.addItem(AStatusText,ltNormal);   //Connection being opened
    hsConnected: AppLog.addItem(AStatusText,ltNormal);    //Connection made
    hsDisconnecting: ;  //Connection being closed
    hsDisconnected: ;   //Connection closed
    hsStatusText: ;   //Connection generating information message
    else AppLog.addItem('Unhandled client state.',ltWarning);
  end;

end;

procedure TfrmMain.thrdClientRun(Sender: TIdThreadComponent);
var
stream:TMemoryStream;
buf:String;
ret:Boolean;
strlist:TStringList;
pbuf:PAnsiChar;
idx:Integer;
begin
  {TODO Read data, parse, and act appropriately}

  stream := TMemoryStream.Create;
  strlist := TSTringList.Create;
  Xbox.Memory.Buffer.SetSize(64 * 1024 * 1024);

  while (Xbox.IsConnected() and (not thrdClient.Stopped)) do
  begin

    buf := Xbox.Link.IOHandler.ReadLn(IdGlobal.EOL,300);

    if (buf = '') then Continue;
    strlist.Clear;

    AppLog.addItem('buf_r: ' + buf,ltNormal);

    if (buf = PROT_CONNECTED) then
    begin
      Xbox.SendCmd(DEBUGGER + ' ' + DEBUGGER_CONNECT);
      if (Xbox.IsNotify) then Xbox.Notify(true);
    end
    else if (buf = PROT_BYE) then
    begin
      ret := Xbox.Disconnect();
      thrdClient.Stop;
    end
    else if (buf = PROT_MULTILINE) then
    begin
      //Reads until there is no more data and adds info to string list
      ret := Xbox.getLines(@strlist);

      for idx := 0 to strlist.count - 1 do
        AppLog.addItem('r: ' + strlist[idx],ltNormal);

    end
    else if (buf = PROT_VIRTUAL) then
    begin
      ret := Xbox.getLines(@strlist);
      ret := Xbox.Memory.fillPages(strlist);
      Xbox.dumpMem();

      if (not Xbox.Link.IOHandler.InputBufferIsEmpty) and (XBox.IsConnected()) then
      begin
        AppLog.addItem(IntToStr(Xbox.Link.IOHandler.InputBuffer.Size) + ' ' + NON_EMPTY_INPUT,ltWarning);
        Xbox.Link.IOHandler.ReadStream(stream);
      end;

    end
    else if (buf = PROT_BINARY) then
    begin
      //Reads until there is no more data and adds info to string list
//      ret := Xbox.getLines(@strlist);
      {while (not Xbox.Link.IOHandler.InputBufferIsEmpty) do
      begin
        Xbox.Link.IOHandler.ReadStream(tmpstream,-1,false);

        if (tmpstream.Size = 0) then Continue;

        strlist.Add('');
        pbuf := StrAlloc(tmpstream.Size + 1);
        tmpstream.Read(pbuf,tmpstream.Size);

        pbuf2 := StrAlloc(tmpstream.size * 2 + 1);
        BinToHex(pbuf2,pbuf,tmpstream.size);
        strlist.Strings[strlist.Count-1] := pbuf2;
        StrDispose(pbuf);
        StrDispose(pbuf2);
      end;}

      //Takes data from above and puts it into a single string
      if (strlist.Count > 0) then begin
        strlist.Add('');
        idx := 0;
        strlist.Exchange(0,strlist.Count - 1);

        while idx < strlist.Count do begin
          strlist[0] := strlist[0] + strlist[idx];
          Inc(idx);
        end;

        pbuf := StrAlloc(Length(strlist[0]) * 2 + 1);
        BinToHex(pbuf,PAnsiCHar(strlist[0]),Length(strlist[0]));
        {TODO -cBugs: Is this an issue? pbuf to string}
        AppLog.addItem(pbuf,ltNormal);
        FreeAndNil(pbuf);
        strlist.Clear;
      end;
    end;

    {TODO -cReading: Try to eliminate double stream }
{    while (0 < Xbox.Link.IOHandler.InputBuffer.Size) do
    begin
      Xbox.Link.IOHandler.ReadStream(tmpstream,
            Xbox.Link.IOHandler.InputBuffer.Size,false);

      stream.CopyFrom(tmpstream,0);
    end;
}

  end;

//  FreeAndNil(tmpstream);
  FreeAndNil(stream);
  FreeAndNil(strlist);
end;

procedure TfrmMain.thrdClientStopped(Sender: TIdThreadComponent);
begin
  if (Xbox.IsConnected()) then
    Xbox.Disconnect();
end;

procedure TfrmMain.thrdConnectRun(Sender: TIdThreadComponent);
var
iConnectAttempt:Integer;
begin
  {Needs to attempt to connect until it reaches X tries (defined in settings), or
   it encounters a serious error that requires stopping. If it is connected, them it needs
   to break out of the loop and then continue the thread processing. Otherwise, stop the
   thread.}


  if (tcpClient.Connected) then   //This should never be true, because this thread shouldnt
  begin                          //be able to be run while connected
    AppLog.addItem('Already connected - Logic error in program.', ltWarning);
    AppLog.addItem('Already connected',ltQuick);
    thrdConnect.Stop;
    Exit;
  end
  else
  begin
    {TODO -cCandy: Replace 4 with setting}
    for iConnectAttempt := 1 to 4 do
    begin
      if (tcpClient.Connected or thrdConnect.Stopped) then break;

      AppLog.AddItem('Trying to connect. Attempt ' + IntToStr(iConnectAttempt) + ' of 4.', ltStatus);
      AppLog.addItem('Connecting ' + IntToStr(iConnectAttempt) + '/4', ltQuick);

      try
        tcpClient.Connect;
      except
        on E : Exception do
        begin
          AppLog.addItem('Error: ' + e.Message, ltError);
          AppLog.addItem('Connect error.', ltQuick);
        end;
      end;
    end;
  end;

  if (not tcpClient.Connected) then
  begin
    AppLog.addItem('Could not connect. Abandoning thread.',ltError);
    AppLog.addItem('Thread abandoned.',ltQuick);
  end
  else                                       //Connected
  begin
    thrdClient.Start;
    AppLog.addItem('Connected, starting processing thread.',ltStatus);
    AppLog.addItem('Connected.', ltQuick);
  end;

  thrdConnect.Stop;                 //Regardless of failing or succeeding to connect we need to quit trying
end;

procedure TfrmMain.thrdConnectStopped(Sender: TIdThreadComponent);
begin
  ConnectButtonUpdate();
end;

procedure TfrmMain.ConnectButtonUpdate();
begin
{TODO -cBugs: Button does not update graphic properly }
  if (Xbox.IsConnected()) then imgList.GetBitmap(0,btConnect.Glyph)
  else imgList.GetBitmap(1,btConnect.Glyph);

  if (not btConnect.Enabled) then btConnect.Enabled := true;
end;

procedure TfrmMain.edInputKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_RETURN)) then
  begin
    if (Xbox.SendCmd(edInput.Text)) then
    begin
      AppLog.addItem('s: ' + edInput.Text,ltNormal);
      edInput.Text := '';
    end;
  end;
end;

procedure TfrmMain.OnNewLog(var msg:TMessage);
var
logmsg:^TLogMessage;
begin
     logmsg := Pointer(msg.wparam);

     case TLogType(msg.LParam) of
          Log.ltQuick:
          begin
               sBar.Panels[0].Text := logmsg.sMessage;
          end;

          Log.ltError, Log.ltWarning, Log.ltStatus, log.ltNormal, Log.ltSystem:
          begin
               {TODO 1 -cLogging: Normal logging}
               {TODO 5 -cLogging: Color/icon coded logging}
               memoLog.Lines.Add(logmsg.sMessage);
          end
     else
          begin
               memoLog.Lines.Add(INVALID_LOG_TYPE);
               {TODO 3 -cError checking: Logging for undefined types}
          end;
     end;
end;

end.
