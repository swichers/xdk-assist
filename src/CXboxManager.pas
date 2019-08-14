unit CXboxManager;

interface

uses SysUtils,IdTCPClient,IdIPAddress,IdIOHandler,CXMemoryManager,CXBreakpointManager,
    Global,IdGlobal,Classes,AppStrings,Log;

type PIdTCPClient = ^TIdTCPClient;
type PIdIOHandler = ^TIdIOHandler;
type PTStringList = ^TSTringList;

type TRegisters = record
  EBP,ESP,EIP,EAX,EBX,ECX,EDX,EDI,ESI,EFlags,Cr0NpxState:Cardinal;
end;

type TXBE = record
  Name:String;
  TimeStamp:Cardinal;
  PID:Cardinal;
end;

type TXBOX = class
     IP:TIdIPAddress;             //IP of the Xbox
     XDKPort:Cardinal;            //XDK Port
     EventPort:Cardinal;          //Port that the XDK sends events to
     Registers:TRegisters;        //XDK Register information
     Memory:TXBOXMemory;          //Dumped memory
     XBE:TXBE;                    //XBE information
     IsNotify:Boolean;            //If Notify is currently enabled
     EnableNotify:Boolean;        //Notification feature is turned on

     Link:PIdTCPClient;           //Pointer to the connection

  function Reboot(Flags:Cardinal;Title:String):Boolean;
  function SendCmd(Cmd:String):Boolean;
  function Notify(Enable:Boolean):Boolean;
  function setIP(newIP:String):Boolean;overload;
  function setIP(newIP:Cardinal):Boolean;overload;

  function Disconnect():Boolean;
  function Connect():Boolean;
  function IsConnected():Boolean;

  function getLines(strlist:PTStringList):Boolean;
  procedure dumpMem();

  constructor Create(TCPCon:PIdTCPClient);
  destructor Free();
  const
       _XDKPort   = 731;         //Default XDK port
       _NotifyPort= 1500;
       _rbWait    = $00000001;
       _rbStop    = $00000002;
       _rbWarm    = $00000004;
       _rbNoDebug = $00000008;
end;

implementation

procedure TXBOX.dumpMem();
var
stream:TMemoryStream;
idx:Integer;
buf:String;
begin
  stream := TMemoryStream.Create;

  Memory.Buffer.Clear;

  if Length(Memory.Sections) <= 0 then Exit;


  for idx := 0 to High(Memory.Sections) do
  begin
    stream.Clear;
    stream.SetSize(Memory.Sections[idx].Size);

    Link.IOHandler.WriteLn(Format(GETMEM2_FULL,
                  [Memory.Sections[idx].Offset, Memory.Sections[idx].Size]));

    buf := '';

    repeat
      if buf <> '' then
        AppLog.addItem('Input still on buffer - ' + buf,ltWarning);
      buf := Link.IOHandler.ReadLn;
    until (buf = PROT_BINARY) and (IsConnected());

    while (Cardinal(Link.IOHandler.InputBuffer.Size) < Memory.Sections[idx].Size) and
       (IsConnected()) do;

    Link.IOHandler.ReadStream(stream,Memory.Sections[idx].Size);

    Memory.Buffer.CopyFrom(stream,0);
    Memory.Sections[idx].Loc := Memory.Buffer.Position;

  end;

  AppLog.addItem( Format('Buffer location: 0x%.8p - 0x%.8x', [Memory.Buffer.Memory,
                  Cardinal(Memory.Buffer.Memory) + Memory.Buffer.Size] ),
                ltNormal);

  FreeAndNil(stream);

end;

function TXBOX.getLines(strlist:PTStringList):Boolean;
var
buf:String;
begin
{TODO: Check to make sure connected / link is valid / strlist is valid}
  Result := true;

  repeat
    buf := Link.IOHandler.ReadLn;
    if (buf <> '.') then
      strlist.Add(buf);
  until buf = '.';
end;

function TXBOX.setIP(newIP:String):Boolean;
begin
  Result := false;

  if (isValidIP(newip)) then
  begin
    if (Self.IP <> nil) then FreeAndNil(Self.IP);
    Self.IP := TIdIPAddress.MakeAddressObject(newip);
    Result := true;
  end;
end;

function TXBOX.setIP(newIP:Cardinal):Boolean;
begin

  if (Self.IP = nil) then
  begin
    Self.IP := TIdIPAddress.MakeAddressObject(DEFAULT_IP);
  end;

  Self.IP.IPv4 := newIP;
  Result := true;
end;

function TXBOX.Reboot(Flags:Cardinal;Title:String):Boolean;
var
Style,Send:String;
begin
  if ((Flags and _rbWarm) = _rbWarm) then
    Style := ' ' + REBOOT_WARM_TAG;

  if ((Flags and _rbWait) = _rbWait) then
    Style := Style + ' ' + REBOOT_WAIT_TAG
  else if ((Flags and _rbStop) = _rbStop) then
    Style := Style + ' ' + REBOOT_STOP_TAG;

  if(Title = '') then
  begin
    if ((Flags and _rbNoDebug) = _rbNoDebug) then
      Style := Style + ' ' + REBOOT_NODEBUG_TAG;
    Send := Format(REBOOT_HEADER,[Style]);
  end
  else
  begin
    if ((Flags and _rbNoDebug) <> _rbNoDebug) then
      Style := Style + ' ' + REBOOT_DEBUG_TAG;
    Send := Format(REBOOT_MAGICBOOT,[Title,Style]);
  end;
  Result := SendCmd(Send);
end;

function TXBOX.SendCmd(Cmd:String):Boolean;
begin
  Result := false;
  if (Link = nil) then Exit;

  if(not Link.Connected) then Exit;

  Link.IOHandler.WriteLn(Cmd);
  Result := true;
end;

function TXBOX.Connect():Boolean;
begin
  Result := false;
  if (Link = nil) then Exit;

  if (Link.Connected) then
    Disconnect();

{TODO -cFunctionality : Link connection thread to this instead }
  Link.Connect(IP.IPv4AsString,XDKPort);

//  SendCmd('DEBUGGER CONNECT');        {TODO : DEBUGGER LINE}

//  if (IsNotify) then Notify(true);

  Result := Link.Connected;
end;

function TXBOX.IsConnected():Boolean;
begin
  Result := false;
  if (Link <> nil) then Result := Link.Connected;
end;

function TXBOX.Disconnect():Boolean;
begin
  Result := false;
  if (IsNotify) then
    Result := Result AND Notify(false);
//  Result := Result AND SendCmd('DEBUGGER DISCONNECT');  {TODO : DEBUGGER LINE}
  Result := Result AND SendCmd(BYE);

  if (Link <> nil) then
    if (Link.Connected) then
      Link.Disconnect;
end;

function TXBOX.Notify(Enable:Boolean):Boolean;
begin

  if (Enable) then
  begin
    Result := SendCmd(NOTIFYAT + IntToStr(EventPort));
  end
  else
  begin
    Result := SendCmd(NOTIFYAT + IntToStr(EventPort) + ' ' + NOTIFYAT_DROP);
  end;

  IsNotify := Result;
end;

constructor TXBOX.Create(TCPCon:PIdTCPClient);
begin
  Memory := TXBOXMemory.Create;
  Link := TCPCon;
  IP   := TIdIPAddress.MakeAddressObject(DEFAULT_IP);
  XDKPort   := _XDKPort;
  EventPort := _NotifyPort;
end;

destructor TXBOX.Free;
begin
  FreeAndNil(Memory);
  FreeAndNil(IP);
end;
end.
