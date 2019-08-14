program XDKAssist;

{%ToDo 'XDKAssist.todo'}

uses
  Forms,
  Dialogs,
  SysUtils,
  MainForm in 'src\MainForm.pas' {frmMain},
  CXboxManager in 'src\CXboxManager.pas',
  CXMemoryManager in 'src\CXMemoryManager.pas',
  CXBreakpointManager in 'src\CXBreakpointManager.pas',
  Global in 'src\Global.pas',
  Log in 'src\Log.pas',
  AppStrings in 'src\AppStrings.pas';

{$E exe}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'XDK Assist v2';
  try
    Application.CreateForm(TfrmMain, frmMain);
    Application.Run;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end.
