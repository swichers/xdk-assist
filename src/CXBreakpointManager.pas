unit CXBreakpointManager;

interface

type TRegisters = record
  EBP,ESP,EIP,EAX,EBX,ECX,EDX,EDI,ESI,EFlags,Cr0NpxState:Cardinal;
end;

type TBPTypes = (Read,Write,Addr,Execute);

type TBreakpoint = record
  Enabled:Boolean;                        //If the breakpoint is enabled or not
  Offset: Cardinal;                       //What location the breakpoint is set on
  TimesHit: Integer;                      //Number of times the breakpoint has been triggered
  LastTriggeredBy: Cardinal;              //Address that last triggered the breakpoint
  TriggeredBy: Cardinal;                  //Address that currently triggered the breakpoint
  Size: Cardinal;                         //Size of the breakpoint's covereage
  BPType:TBPTypes;                        //Type of the breakpoint
  Desc: String;                           //Description of the breakpoint
  PreviousRegisters: TRegisters;          //Register information at previous break
  Registers:TRegisters;                   //Current register information
end;

type TXBOXBreakpointManage = class
  Item: array of TBreakpoint;

  {TODO 1 -cBreakpoints: Implement functions to add, remove, locate, modify breakpoints}
//  function Add();
//  function Delete();
//  function IndexOf();
end;

implementation

end.
