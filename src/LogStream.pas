unit LogStream;

interface

uses Classes,Windows;

type TLogStream = class(TStringStream)
  UpdateMsg:Cardinal;
  UpdateWindow:THandle;
  procedure AddLn(const AString:String);
  procedure SaveToFile(const FileName:String);
  constructor Create(const AString:String;Msg:Cardinal;Handle:THandle);
  procedure Clear;
end;

implementation

constructor TLogStream.Create(const AString:String;Msg:Cardinal;Handle:THandle);
begin
  inherited Create(AString);
  UpdateMsg := Msg;
  UpdateWindow := Handle;
//  SendMessage(UpdateWindow,UpdateMsg,0,Self.Size);
end;

procedure TLogStream.Clear;
begin
  SetSize(0);
end;

procedure TLogStream.AddLn(const AString:String);
begin
  WriteString(AString + #13#10);
  SendMessage(UpdateWindow,UpdateMsg,Self.Size-(Length(AString)+2),Length(AString)+2);
end;

procedure TLogStream.SaveToFile(const FileName:String);
var
logfile:TextFile;
begin
  AssignFile(logfile,FileName);
  ReWrite(logfile);
  WriteLn(logfile,Self.DataString);
  CloseFile(logfile);
  AddLn('Log saved to ' + FileName + '.');
end;
end.
