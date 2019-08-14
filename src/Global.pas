unit Global;

interface

uses IdIPAddress, SysUtils, Log;

function IsValidIP(const Addr : String): Boolean;

var
  AppLog:TLog;

implementation

function IsValidIP(const Addr : String): Boolean;
var LIP :  TIdIPAddress;
begin
  if (Length(Addr) = 0) then
  begin
    Result := false;
    Exit;
  end;

  LIP :=  TIdIPAddress.MakeAddressObject(Addr);
  Result := Assigned(LIP);
  if Result then
  begin
    FreeAndNil(LIP);
  end;
end;

end.
