unit Breakpoint;

interface

uses SysUtils;

type TBPTypes = (Read,Write,Addr,Execute);

type
  TBreakpoint = record
  Enabled:Boolean;
  Offset: Cardinal;
  Size: Cardinal;
  BPType:TBPTypes;
  Desc: String;
end;

function LocateBreakpoint(fBreak:TBreakpoint):Integer;

var
  Breakpoints: array of TBreakpoint;

implementation

function LocateBreakpoint(fBreak:TBreakpoint):Integer;
var
Counter:Integer;
begin
  Result := -1;
  if Length(Breakpoints) <= 0 then
  begin
    Result := -1;
    Exit;
  end;

  for Counter := Low(Breakpoints) to High(Breakpoints) do
  begin
    if CompareMem(@fBreak,@Breakpoints[Counter],SizeOf(TBreakpoint)) then
    begin
      Result := Counter;
      Break;
    end;
  end;

end;

end.
