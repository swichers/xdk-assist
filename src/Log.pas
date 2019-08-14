unit Log;

interface

uses Classes, SysUtils, Windows;

type TLogType = (ltError, ltWarning, ltStatus, ltNormal, ltSystem, ltQuick );

type TLogMessage = record
  dTimeStamp:TDateTime;
  sMessage:String;
  eType:TLogType;
end;

type TLogMessageArray = array of TLogMessage;

type TLog = class
  private
        msgID: Cardinal;
  protected
        History: TLogMessageArray;
        msgWnd: HWND;

        function newItem(sMessage:String;eType:TLogType):TLogMessage;
        function inBounds(iIndex:Integer):Boolean;

  public
        constructor Create(msgWnd:HWND;msgID:Cardinal);overload;
        procedure addItem(sMessage:String;eType:TLogType);
        function getItem(iIndex:Integer):TLogMessage;
        function getItems(iStart:Integer;iEnd:Integer):TLogMessageArray;overload;
        function getItems(iStart:Integer;iEnd:Integer;eExclude:TLogType):TLogMessageArray;overload;
        function getLastOfType(eType:TLogType):TLogMessage;
        function getLast():TLogMessage;
        function getCount():Integer;
end;

implementation

constructor TLog.Create(msgWnd:HWND;msgID:Cardinal);
begin
     Self.msgWnd := msgWnd;
     Self.msgID := msgID;
     Self.Create();
end;

function TLog.newItem(sMessage: string; eType: TLogType):TLogMessage;
var
newMsg:TLogMessage;
begin
     newMsg.sMessage := sMessage;
     newMsg.eType := eType;
     newMsg.dTimeStamp := Now();

     Result := newMsg;
end;

procedure TLog.addItem(sMessage: string; eType: TLogType);
var
newMsg:TLogMessage;
begin
     newMsg := newItem(sMessage,eType);

     SetLength(History,Length(History)+1);
     History[High(History)] := newMsg;
     SendMessage(msgWnd,msgID, Integer(@History[High(History)]), Integer(eType));
end;

function TLog.getItem(iIndex: Integer):TLogMessage;
var
errMsg:TLogMessage;
begin
     if(Low(History) > iIndex) then
     begin
          errMsg := newItem('Message index too low',ltError);
     end
     else if(High(History) < iIndex) then
     begin
          errMsg := newItem('Message index too high',ltError);
     end
     else
     begin
       errMsg := History[iIndex];
     end;

     Result := errMsg;
end;

function TLog.inBounds(iIndex: Integer):Boolean;
begin
     if ( (Low(History) > iIndex) or (High(History) < iIndex) )then
     begin
          Result := false;
     end
     else
     begin
          Result := true;
     end;
end;

function TLog.getItems(iStart: Integer; iEnd: Integer):TLogMessageArray;
var
iLoop:Integer;
begin
     if (iEnd <= iStart) then iEnd := iStart+1;
     if (iStart >= iEnd) then iStart := iEnd-1;

     if not inBounds(iStart) then iStart := Low(History);
     if not inBounds(iEnd) then iEnd := High(History);

     SetLength(Result,iEnd-iStart);

     for iLoop := 0 to (iEnd - iStart) do
     begin
          if ( (iEnd-iLoop < iStart) or (iEnd-iLoop < Low(History)) ) then break;

          Result[iLoop] := History[iEnd-iLoop];
     end;
end;

function TLog.getItems(iStart: Integer; iEnd: Integer; eExclude: TLogType):TLogMessageArray;
begin
     Result := getItems(iStart,iEnd);
end;

function TLog.getLast():TLogMessage;
begin
     Result := History[High(History)];
end;

function TLog.getLastOfType(eType:TLogType):TLogMessage;
var
iIndex:Integer;
begin
     for iIndex := High(History) downto Low(History)  do
     begin
          if History[iIndex].eType = eType then break;
     end;

     Result := History[iIndex];
end;

function TLog.getCount():Integer;
begin
     Result := Length(History);
end;

end.
