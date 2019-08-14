unit CXMemoryManager;

interface

uses Classes, SysUtils, StrUtils, AppStrings;

type TMemSection = record
  Offset,Size,Flags,Loc:Cardinal;
end;


type TXBOXMemory = class
  Sections: array of TMemSection;
  Buffer:TMemoryStream;

  function fillPages(strlist:TStringList):Boolean;

  constructor Create();
  destructor Free();
end;

implementation

function TXBOXMemory.fillPages(strlist:TStringList):Boolean;
var
idx:Integer;
str:String;
begin
{TODO : Better result checking}
  result := true;
  SetLength(Sections,strlist.Count);  //Size array to match number of strings
  idx := 0;

  while (idx < (strList.Count - 1))  do
  begin
    if strlist.Count <= 0 then
    begin
      Result := false;
      Break;
    end;

    if idx < 0 then Continue;
    if idx > strlist.Count-1 then Break;

    str := strlist[idx]; {TODO: Does this actually speed up the process?}

    if ( not AnsiContainsStr(LowerCase(str),VIRTUAL_ADDRESS_BASE) or
        not AnsiContainsStr(LowerCase(str),VIRTUAL_ADDRESS_SIZE) or
        not AnsiContainsStr(LowerCase(str),VIRTUAL_ADDRESS_PROTECT) ) then
    begin
      //str did not contain base, size, and protect
      strlist.Delete(idx);
      Dec(idx);
      Continue;
    end;

    //base=0xd08b2000 size=0x00540000 protect=0x00020002
    Sections[idx].Offset := StrToInt64( AnsiMidStr(str,AnsiPos(VIRTUAL_ADDRESS_BASE,str) + Length(VIRTUAL_ADDRESS_BASE),10));
    Sections[idx].Size   := StrToInt64( AnsiMidStr(str,AnsiPos(VIRTUAL_ADDRESS_SIZE,str) + Length(VIRTUAL_ADDRESS_SIZE),10));
    Sections[idx].Flags  := StrToInt64( AnsiMidStr(str,AnsiPos(VIRTUAL_ADDRESS_PROTECT,str) + Length(VIRTUAL_ADDRESS_PROTECT),10));
    Sections[idx].Loc    := 0;

    Inc(idx);
  end;

  if Length(Sections) > strlist.Count then    //Had some badly formated strings, remove empty sections
    SetLength(Sections,strlist.Count);
end;

constructor TXBOXMemory.Create;
begin
  {TODO -cBugs:Make sure creation went okay}
  Buffer := TMemoryStream.Create;
end;

destructor TXBOXMemory.Free;
begin
  FreeAndNil(Buffer);
end;

end.
