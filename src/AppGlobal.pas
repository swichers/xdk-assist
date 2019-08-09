unit AppGlobal;

interface

uses Tool, LogStream, Classes, Clipbrd, SysUtils, StrUtils, IdGlobal, XBOXManager;

{  type TMemSect = record
    Offset,Size,Flags,Loc:Cardinal;
  end;        }

  type TParsedParams = record
    Key:TStringList;
    Value:TStringList;
  end;

  type TStatus = (stNorm,stDump,stBreak,stGetXBEInfo,stGetContext);

  function ConvPC2XBOX(PCOffset:Cardinal;XBOXOffset:PCardinal):Integer;
  function ConvXBOX2PC(XBOXOffset:Cardinal;Section:PInteger;PCOffset:PCardinal):Integer;
  function ConvError(Err:Integer):String;
  function TextToClip(Text:String):Boolean;
  function MakeOffset(const AString:String):String;
  function ParseParams(const AInput:String):TParsedParams;

const
  EConvOkay       = 0;
  EConvNotFound   = -1;
  EConvBadPointer = -2;
  EConvOutOfRange = -3;
  EConvNoSections = -4;

var
  Tools: array of TTool;
//  Sections: array of TMemSect;
//  MemBuffer:TMemoryStream;
  Log:TLogStream;
  ProgStatus:TStatus;
  DebugBox:TXBOX;

implementation

function ParseParams(const AInput:String):TParsedParams;
begin
        {202- multiline response follows
        timestamp=0x40d52299 checksum=0x00000000
        name="E:\UnleashX\default.xbe"
        .}

end;

function MakeOffset(const AString:String):String;
var
XPos:Integer;
NewString:String;
PadStr:String;
begin
  Result := '0x00000000';
  NewString := Uppercase(AString);
  NewString := AnsiReplaceText(NewString,' ','');

  XPos := AnsiPos('0X',NewString);

  if (XPos < 0) then
    NewString := '0x' + NewString
  else if (XPos > 1) then
    NewString := AnsiRightStr(NewString,Length(NewString) - XPos+1);

  if (Length(NewString) > 10) then
    SetLength(NewString,10)
  else if Length(NewString) < 10 then
  begin
    for XPos := 0 to (10 - Length(NewString) - 2) do
      PadStr := PadStr + '0';
    NewString := StuffString(NewString,3,0,PadStr);
  end;

//  if(IsHexidecimal(NewString)) then
{TODO: Fix this so it will check for valid hex}
     Result := NewString

end;

function ConvXBOX2PC(XBOXOffset:Cardinal;Section:PInteger;PCOffset:PCardinal):Integer;
var
Count:Integer;
begin
  if not Assigned(PCOffset) then
  begin
    Result := EConvBadPointer;
    Exit;
  end;

with DebugBox.Memory do
begin
  if(Length(Sections) <= 0) then
  begin
    Result := EConvNoSections;
    Exit;
  end;

  if(XBOXOffset < Sections[Low(Sections)].Offset) or
    (XBOXOffset > (Sections[High(Sections)].Offset + Sections[High(Sections)].Size)) then
  begin
    Result := EConvOutOfRange;
    Exit;
  end;

  for Count := Low(Sections) to High(Sections) do
  begin
    with Sections[Count] do
    begin
      if (XBOXOffset < Offset) or (XBOXOffset > (Offset+Size)) then Continue;

      if Assigned(Section) then Section^ := Count;

      if Assigned(PCOffset) then
        PCOffset^ := Cardinal(DebugBox.Memory.Buffer.Memory) + Loc - Size + XBOXOffset - Offset;
//        PCOffset^ := Cardinal(MemBuffer.Memory) + Loc - Size + (XBOXOffset - Offset);
      Result := EConvOkay;
      Exit;
    end;
  end;
  Result := EConvNotFound;
end;
end;

function ConvPC2XBOX(PCOffset:Cardinal;XBOXOffset:PCardinal):Integer;
var
Pos:Integer;
Base:Cardinal;
begin
  if not Assigned(XBOXOffset) then
  begin
    Result := EConvBadPointer;
    Exit;
  end;

//  if (PCOffset < Cardinal(MemBuffer.Memory)) or
//      (PCOffset > (Cardinal(MemBuffer.Memory) + MemBuffer.Size)) then
  if (PCOffset < Cardinal(DebugBox.Memory.Buffer.Memory)) or
      (PCOffset > (Cardinal(DebugBox.Memory.Buffer.Memory) + DebugBox.Memory.Buffer.Size)) then
  begin
    Result := EConvOutOfRange;
    Exit;
  end;

with DebugBox.Memory do
begin
  for Pos := High(Sections) downto Low(Sections) do
  begin
//    Base := Cardinal(MemBuffer.Memory) + Sections[Pos].Loc;
    Base := Cardinal(DebugBox.Memory.Buffer.Memory) + Sections[Pos].Loc;
    if ( (PCOffset >= (Base - Sections[Pos].Size)) and (PCOffset < Base) ) then
    begin
      Result := EConvOkay;
      if Assigned(XBOXOffset) then
        XBOXOffset^ := Sections[Pos].Offset +
                (PCOffset -
//                Cardinal(MemBuffer.Memory) -
                Cardinal(DebugBox.Memory.Buffer.Memory) -
                (Sections[Pos].Loc -
                Sections[Pos].Size));
      Exit;
    end;
  end;
end;
  Result := EConvNotFound;
end;

function ConvError(Err:Integer):String;
begin
  case Err of
    EConvOutOfRange: Result := 'Offset was not found in the buffer range. Check the log to see if the buffer has jumped around. If it hasn''t check and make sure you are putting the correct address. Also, make sure you are searching the correct memory ranges with your search application.';
    EConvNotFound: Result := 'The offset was found in the buffer range, but it was not found inside of any of the memory sections that are saved. This could be a mathematical mistake, or some other coding problem. It shouldn''t be caused by anything you did.';
    EConvBadPointer: Result := 'The pointer supplied for returning the offset in was empty. No offset was returned.';
    EConvNoSections: Result := 'There are no saved memory sections. Are you connected?';
    EConvOkay: Result := 'Everything went okay.';
  else
    Result := 'An unknown error occured while trying to convert the offset.';
  end;


end;

function TextToClip(Text:String):Boolean;
var
  Clipboard:TClipboard;
begin
  Result := false;
  try
    Clipboard := TClipboard.Create;
    if Assigned(Clipboard) then
    begin
      Clipboard.AsText := Text;
      FreeAndNil(Clipboard);
      Result := true;
    end;
  except
    on E: Exception do Result := false;
  end;
end;

end.
