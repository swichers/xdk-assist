unit Settings;

interface

uses INIFiles, Forms, SysUtils;

type TConnection = record
  Host:String;
  Port:Integer;
end;

type TDumping = record
  AutoStop:Boolean;
  AutoCopy:Boolean;
  Verbose:Boolean;
end;

type TBP = record
  LastType:String;
end;

type TWindow = record
  Width,Height,LastTab:Integer;
  State:TWindowState;
end;

type TSettings = class
  Connection:TConnection;
  Dumping:TDumping;
  Breakpoint:TBP;
  Window:TWindow;

  function Save(FileName:String):Boolean;
  function Load(FileName:String):Boolean;
end;

implementation

function TSettings.Load(FileName:String):Boolean;
var
iniSet:TINIFile;
begin
  Result:= false;

  try
    iniSet := TINIFile.Create(FileName);
  except
    on E: Exception do
    begin
      Exit;
    end;
  end;

  Connection.Host := iniSet.ReadString('Connection','Host','192.168.1.153');
  Connection.Port := iniSet.ReadInteger('Connection','Port',2000);
  Breakpoint.LastType := iniSet.ReadString('Breakpoints','Type','Read');
  Window.Width := iniSet.ReadInteger('Window','Width',614);
  Window.Height := iniSet.ReadInteger('Window','Height',713);
  Window.State := TWindowState(iniSet.ReadInteger('Window','State',Integer(wsNormal)));
  Window.LastTab := iniSet.ReadInteger('Window','LastTab',0);
  Dumping.AutoStop :=iniSet.ReadBool('Dumping','AutoStop',true);
  Dumping.AutoCopy :=  iniSet.ReadBool('Dumping','AutoCopy',true);
  Dumping.Verbose :=  iniSet.ReadBool('Dumping','Verbose',true);

  FreeAndNil(iniSet);

  Result := true;
end;

function TSettings.Save(FileName:String):Boolean;
var
iniSet:TINIFile;
begin
  Result := false;

  try
    iniSet := TINIFile.Create(FileName);
  except
    on E: Exception do
    begin
      Exit;
    end;
  end;

  iniSet.WriteString('Connection','Host',Connection.Host);
  iniSet.WriteInteger('Connection','Port',Connection.Port);
  iniSet.WriteBool('Dumping','AutoStop',Dumping.AutoStop);
  iniSet.WriteBool('Dumping','AutoCopy',Dumping.AutoCopy);
  iniSet.WriteBool('Dumping','Verbose',Dumping.Verbose);
  iniSet.WriteString('Breakpoints','Type',Breakpoint.LastType);
  iniSet.WriteInteger('Window','Width',Window.Width);
  iniSet.WriteInteger('Window','Height',Window.Height);
  iniSet.WriteInteger('Window','LastTab',Window.LastTab);
  iniSet.WriteInteger('Window','State',Integer(Window.State));

  FreeAndNil(iniSet);

  Result := true;
end;

end.
