program XDKAssist;

uses
  Forms,
  Dialogs,
  SysUtils,
  Main in 'src\Main.pas' {frmMain},
  Breakpoint in 'src\Breakpoint.pas',
  LogStream in 'src\LogStream.pas',
  Tool in 'src\Tool.pas',
  Settings in 'src\Settings.pas',
  AppGlobal in 'src\AppGlobal.pas',
  XBOXManager in 'src\XBOXManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'XDK Assist';
  try
    Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end.
