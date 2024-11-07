﻿; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "FlashGBX"
#define MyAppVersion "<APP_VERSION>"
#define MyAppPublisher "Lesserkuma"
#define MyAppURL "https://github.com/lesserkuma/FlashGBX"
#define MyAppExeName "FlashGBX-app.exe"
#define MyFilesDir "<FILES_DIR>"
#define MyCH341Dir "<CH341_DIR>"
#define MyOutputDir "<OUTPUT_DIR>"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{060FD4CF-E72F-497D-812E-EB5599D59A0A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} v{#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
;PrivilegesRequiredOverridesAllowed=dialog
OutputDir={#MyOutputDir}
OutputBaseFilename=Setup_FlashGBX
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\FlashGBX-app.exe
UninstallDisplayName={#MyAppName} v{#MyAppVersion}
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "full"; Description: "Install Application and Drivers"
Name: "custom"; Description: "Custom Installation"; Flags: iscustom

[Components]
Name: "program"; Description: "FlashGBX application"; Types: full custom; Flags: fixed
Name: "driver_ch341"; Description: "CH340/CH341 driver v3.8.2023.02 for GBxCart RW and GBFlash (install/re-install)"; Types: full

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#MyFilesDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: program
Source: "{#MyCH341Dir}\*.*"; DestDir: "{app}\Drivers\CH341"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: driver_ch341
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}";
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\Drivers\CH341\CH341SER.EXE"; Description: "Install CH340/CH341 driver"; Flags: waituntilterminated; Components: driver_ch341
Filename: "{app}\Python_3.10.11\python.exe"; Parameters: "-m pip install PySide6==6.5.0 --no-warn-script-location --isolated --cache-dir {app}\Python_3.10.11\cache"; StatusMsg: "Setting up prerequisites in embedded Python runtime (only used for FlashGBX)..."; Flags: waituntilterminated runminimized; Components: program
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[InstallDelete]
Type: filesandordirs; Name: "{app}\Python";
Type: filesandordirs; Name: "{app}\Python_3.10.11";
Type: filesandordirs; Name: "{app}\*.pyd";

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    DelTree(ExpandConstant('{app}'), True, True, True);
    if MsgBox('Delete all config files of FlashGBX as well?', mbConfirmation, MB_YESNO or MB_DEFBUTTON2) = IDYES then
    begin
        DelTree(ExpandConstant('{localappdata}\{#MyAppName}'), True, True, True);
    end;
  end;
end;