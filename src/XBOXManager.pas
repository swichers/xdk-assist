unit XBOXManager;

interface

uses Classes,SysUtils,IdTCPClient;

type TRegisters = record
  EBP,ESP,EIP,EAX,EBX,ECX,EDX,EDI,ESI,EFlags,Cr0NpxState:Cardinal;
end;

type TMemSection = record
  Offset,Size,Flags,Loc:Cardinal;
end;

//type TBPTypes = (Read,Write,Addr,Execute);
              {
type
  TBreakpoint = record
  Enabled:Boolean;
  Offset: Cardinal;
  Size: Cardinal;
  BPType:TBPTypes;
  Desc: String;
end;         }

type TXBOXMemManage = class
  Sections: array of TMemSection;
  Buffer:TMemoryStream;
  constructor Create();
  destructor Free();
end;

type TXBOXBreakpointManage = class
//  Item: array of TBreakpoint;
//  function Add();
//  function Delete();
//  function IndexOf();
end;

type TXBE = record
  Name:String;
  TimeStamp:Cardinal;
end;

type PIdTCPClient = ^TIdTCPClient;

type TXBOX = class
  Registers:TRegisters;
  Memory:TXBOXMemManage;
  XBE:TXBE;
  Link:PIdTCPClient;
  NotifyPort:Cardinal;

  function Reboot(Flags:Cardinal;Title:String):Boolean;
  function SendCmd(Cmd:String):Boolean;
  function IsConnected():Boolean;
  function Disconnect():Boolean;
  function Connect(Port:Cardinal):Boolean;
  function Notify(Port:Cardinal;Drop:Boolean):Boolean;
  constructor Create(TCPCon:PIdTCPClient);
  destructor Free();

const
  rbWait    = $00000001;
  rbStop    = $00000002;
  rbWarm    = $00000004;
  rbNoDebug = $00000008;
end;

implementation

constructor TXBOXMemManage.Create;
begin
  Buffer := TMemoryStream.Create;
end;

destructor TXBOXMemManage.Free;
begin
  Buffer.Free;
  Buffer := nil;
end;



function TXBOX.IsConnected():Boolean;
begin
  Result := Link.Connected;
end;

function TXBOX.Connect(Port:Cardinal):Boolean;
begin
  if not IsConnected then
  begin
    Result := false;
    Exit;
  end;

  Result := true;

  SendCmd('DEBUGGER CONNECT');
  if(Port > 0) then Notify(Port,false);
end;

function TXBOX.Disconnect():Boolean;
begin
  if not IsConnected then
  begin
    Result := false;
    Exit;
  end;

  if NotifyPort > 0 then Notify(NotifyPort,true);

  SendCmd('DEBUGGER DISCONNECT');
  Result := SendCmd('BYE');
end;

function TXBOX.Notify(Port:Cardinal;Drop:Boolean):Boolean;
var
Send:String;
begin
  if (Port = 0) or (not IsConnected) then
  begin
    Result := false;
    Exit;
  end;

  Send := 'NOTIFYAT PORT=' + IntToStr(Port);

  if Drop then
  begin
    Send := Send + ' DROP';
    NotifyPort := 0;
  end
  else
  begin
    NotifyPort := Port;
  end;

  Result := SendCmd(Send);
end;

function TXBOX.Reboot(Flags:Cardinal;Title:String):Boolean;
var
Style,Send:String;
begin
  if ((Flags and rbWarm) = rbWarm) then
    Style := ' WARM';

  if ((Flags and rbWait) = rbWait) then
    Style := Style + ' WAIT'
  else if ((Flags and rbStop) = rbStop) then
    Style := Style + ' STOP';

  if(Title = '') then
  begin
    if ((Flags and rbNoDebug) = rbNoDebug) then
      Style := Style + ' NODEBUG';
    Send := Format('REBOOT%s',[Style]);
  end
  else
  begin
    if ((Flags and rbNoDebug) <> rbNoDebug) then
      Style := Style + ' DEBUG';
    Send := Format('magicboot title=%s%s',[Title,Style]);
  end;
  Result := SendCmd(Send);
end;

function TXBOX.SendCmd(Cmd:String):Boolean;
begin
  if(not Link.Connected) then
  begin
    Result := false;
    Exit;
  end;

  Link.IOHandler.WriteLn(Cmd);
  Result := true;
end;

constructor TXBOX.Create(TCPCon:PIdTCPClient);
begin
  Memory := TXBOXMemManage.Create;
  Link := TCPCon;
end;

destructor TXBOX.Free;
begin
  Memory.Free;
  Memory := nil;
end;

end.
