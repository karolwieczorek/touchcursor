; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=TouchCursor
AppVerName=TouchCursor 1.7.0
VersionInfoVersion=1.7.0.5
AppPublisher=Martin Stone
AppPublisherURL=http://touchcursor.sourceforge.net/
AppSupportURL=http://sourceforge.net/projects/touchcursor/support
AppUpdatesURL=http://touchcursor.sourceforge.net/
AppCopyright=Copyright � 2006-2010 Martin Stone.
DefaultDirName={pf}\TouchCursor
DefaultGroupName=TouchCursor
AlwaysUsePersonalGroup=yes
OutputBaseFilename=TouchCursorSetup
OutputDir=..
Compression=lzma
SolidCompression=yes
; 5.0 is win 2k
MinVersion=5.0,5.0
PrivilegesRequired=poweruser

WizardImageFile=wizard_panel.bmp
WizardSmallImageFile=wizard_icon.bmp

;SignedUninstaller=yes
;SignedUninstallerDir=.

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
; Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Built by makedist.bat:
Source: ".\TouchCursor\*.*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Registry]
Root: HKCU; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueName: "TouchCursor"; ValueType: string; ValueData: "{app}\touchcursor.exe"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "Software\Microsoft\Windows\CurrentVersion\App Paths\TouchCursor.exe"; ValueType: string; ValueData: "{app}\touchcursor.exe"; Flags: uninsdeletekey
; Remove obsolete registry entry from pre 1.1 versions:
Root: HKCU; Subkey: "Software\TouchCursor"; Flags: dontcreatekey uninsdeletekey

[Icons]
Name: "{group}\TouchCursor Configuration"; Filename: "{app}\tcconfig.exe"; WorkingDir: "{app}"
Name: "{group}\TouchCursor"; Filename: "{app}\touchcursor.exe"; WorkingDir: "{app}"
Name: "{group}\Help"; Filename: "{app}\docs\help.html"
Name: "{group}\{cm:ProgramOnTheWeb,TouchCursor}"; Filename: "http://touchcursor.sourceforge.net/"
Name: "{group}\{cm:UninstallProgram,TouchCursor}"; Filename: "{uninstallexe}"
; Name: "{userdesktop}\TouchCursor Configuration"; Filename: "{app}\tcconfig.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\touchcursor.exe"; Flags: nowait
Filename: "{app}\docs\help.html"; Description: "{cm:LaunchProgram,Help}"; Flags: shellexec waituntilidle postinstall skipifsilent
Filename: "{app}\tcconfig.exe"; Description: "{cm:LaunchProgram,TouchCursor configuration}"; Flags: waituntilidle postinstall skipifsilent

[UninstallRun]
Filename: "{app}\tcconfig.exe"; Parameters: "quit"
Filename: "{app}\touchcursor.exe"; Parameters: "quit"


[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssInstall then begin
    {Quit touchcursor if it's currently running.  Ignore errors}
    Exec(ExpandConstant('{app}\tcconfig.exe'), 'quit', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec(ExpandConstant('{app}\touchcursor.exe'), 'quit', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    {Backup old settings file, if any, and if backup doesn't exist already}
    FileCopy(ExpandConstant('{userappdata}\TouchCursor\settings.cfg'), ExpandConstant('{userappdata}\TouchCursor\pre-1.7.0-settings.cfg'), True);
  end;
end;

{ Feedback form was dropped when transitioning to SF.
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  if CurUninstallStep = usDone then
  begin
    if MsgBox('Would you like to provide feedback to the developer of TouchCursor?  All comments are welcome!', mbConfirmation, MB_YESNO) = IDYES then
      ShellExec('open', 'http://touchcursor.sourceforge.net/feedback.html', '', '', SW_SHOW, ewNoWait, ErrorCode);
  end;
end;
}
