[Setup]
; Basic Information
AppId={{B8F7A2C4-9E3F-4D1A-8C5B-7F6E2A1D9C8E}
AppName=WinScript2
AppVersion=1.0.1
AppVerName=WinScript2 1.0.1
AppPublisher=WinScript2 Team
AppPublisherURL=https://github.com/EV-OD/winscript
AppSupportURL=https://github.com/EV-OD/winscript/issues
AppUpdatesURL=https://github.com/EV-OD/winscript/releases
AppCopyright=Copyright (C) 2025 WinScript2 Team
AppComments=Windows Automation Platform with Rhai Scripting

; Installation Settings
DefaultDirName={autopf}\WinScript2
DefaultGroupName=WinScript2
AllowNoIcons=yes
PrivilegesRequired=admin
OutputDir=src-tauri\target\release\bundle\inno
OutputBaseFilename=WinScript2_1.0.1_x64_inno_setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
SetupIconFile=src-tauri\icons\icon.ico
UninstallDisplayIcon={app}\tauri-app.exe

; Platform Support
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
MinVersion=10.0.17763

; License and Information
LicenseFile=LICENSE
InfoBeforeFile=installer\INSTALL_INFO.txt
InfoAfterFile=installer\POST_INSTALL_INFO.txt

; Visual Settings
WizardImageFile=installer\WizardImage.bmp
WizardSmallImageFile=installer\WizardSmallImage.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1
Name: "associate"; Description: "Associate .rhai files with WinScript2"; GroupDescription: "File associations:"
Name: "envvars"; Description: "Set up environment variables (WINSCRIPT2_HOME)"; GroupDescription: "Configuration:"
Name: "startmenu"; Description: "Create Start Menu shortcuts"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkedonce

[Files]
; Main Application
Source: "src-tauri\target\release\tauri-app.exe"; DestDir: "{app}"; DestName: "WinScript2.exe"; Flags: ignoreversion
Source: "src-tauri\target\release\tauri_app.pdb"; DestDir: "{app}"; Flags: ignoreversion; Check: IsDebugVersion

; Built-in Scripts (to Program Files)
Source: "user_scripts\built_in_scripts\*"; DestDir: "{app}\Scripts\built_in_scripts"; Flags: ignoreversion recursesubdirs createallsubdirs
; User Scripts (to Documents folder)
Source: "user_scripts\custom_scripts\*"; DestDir: "{userdocs}\WinScript2\Scripts"; Flags: ignoreversion recursesubdirs createallsubdirs onlyifdoesntexist

; Documentation
Source: "PRODUCTION_README.md"; DestDir: "{app}"; DestName: "README.md"; Flags: ignoreversion
Source: "FINAL_SUMMARY.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "DEPLOYMENT_SUMMARY.md"; DestDir: "{app}"; Flags: ignoreversion

; Setup Scripts
Source: "setup_winscript2.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "test_installation.bat"; DestDir: "{app}"; Flags: ignoreversion

; Icons and Resources
Source: "src-tauri\icons\*"; DestDir: "{app}\icons"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; Desktop and Start Menu Icons
Name: "{group}\WinScript2"; Filename: "{app}\WinScript2.exe"; Comment: "Windows Automation Platform"; IconFilename: "{app}\icons\icon.ico"
Name: "{group}\WinScript2 Setup"; Filename: "{app}\setup_winscript2.bat"; Comment: "Configure WinScript2 Environment"; IconFilename: "{app}\icons\icon.ico"
Name: "{group}\{cm:ProgramOnTheWeb,WinScript2}"; Filename: "https://github.com/EV-OD/winscript"
Name: "{group}\{cm:UninstallProgram,WinScript2}"; Filename: "{uninstallexe}"

; Desktop Icon
Name: "{autodesktop}\WinScript2"; Filename: "{app}\WinScript2.exe"; Comment: "Windows Automation Platform"; IconFilename: "{app}\icons\icon.ico"; Tasks: desktopicon

; Quick Launch Icon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\WinScript2"; Filename: "{app}\WinScript2.exe"; Comment: "Windows Automation Platform"; Tasks: quicklaunchicon; IconFilename: "{app}\icons\icon.ico"

[Registry]
; File Association for .rhai files
Root: HKCR; Subkey: ".rhai"; ValueType: string; ValueName: ""; ValueData: "WinScript2.RhaiScript"; Flags: uninsdeletevalue; Tasks: associate
Root: HKCR; Subkey: "WinScript2.RhaiScript"; ValueType: string; ValueName: ""; ValueData: "Rhai Script"; Flags: uninsdeletekey; Tasks: associate
Root: HKCR; Subkey: "WinScript2.RhaiScript\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\WinScript2.exe,0"; Tasks: associate
Root: HKCR; Subkey: "WinScript2.RhaiScript\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\WinScript2.exe"" ""%1"""; Tasks: associate

; Environment Variables
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "WINSCRIPT2_HOME"; ValueData: "{app}"; Flags: preservestringtype; Tasks: envvars
Root: HKCU; Subkey: "Environment"; ValueType: string; ValueName: "WINSCRIPT2_SCRIPTS"; ValueData: "{userdocs}\WinScript2\Scripts"; Flags: preservestringtype; Tasks: envvars

; Application Settings
Root: HKCU; Subkey: "Software\WinScript2"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\WinScript2"; ValueType: string; ValueName: "Version"; ValueData: "1.0.1"
Root: HKCU; Subkey: "Software\WinScript2"; ValueType: string; ValueName: "ScriptsPath"; ValueData: "{userdocs}\WinScript2\Scripts"

[Dirs]
; Create necessary directories
Name: "{app}\Scripts\built_in_scripts"; Permissions: users-full
Name: "{app}\Scripts\custom_scripts"; Permissions: users-full
Name: "{app}\logs"; Permissions: users-full

; User profile directories
Name: "{userdocs}\WinScript2"; Permissions: users-full; Tasks: envvars
Name: "{userdocs}\WinScript2\Scripts"; Permissions: users-full; Tasks: envvars
Name: "{userdocs}\WinScript2\Scripts\custom_scripts"; Permissions: users-full; Tasks: envvars

[Run]
; Post-installation setup
Filename: "{app}\setup_winscript2.bat"; Description: "Configure WinScript2 environment"; Flags: postinstall shellexec skipifsilent
Filename: "{app}\WinScript2.exe"; Description: "Launch WinScript2"; Flags: postinstall nowait skipifsilent

[UninstallRun]
; Cleanup on uninstall
Filename: "taskkill"; Parameters: "/f /im WinScript2.exe"; Flags: runhidden; RunOnceId: "KillWinScript2"

[UninstallDelete]
; Remove user data (optional)
Type: filesandordirs; Name: "{app}\logs"

[Code]
function IsDebugVersion: Boolean;
begin
  Result := FileExists(ExpandConstant('{app}\tauri_app.pdb'));
end;

function InitializeSetup(): Boolean;
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  Result := True;
  
  // Check Windows version (Windows 10 1809+ required)
  if (Version.Major < 10) or ((Version.Major = 10) and (Version.Build < 17763)) then
  begin
    MsgBox('WinScript2 requires Windows 10 version 1809 (build 17763) or later.', mbError, MB_OK);
    Result := False;
  end;
end;

procedure InitializeWizard;
begin
  WizardForm.LicenseAcceptedRadio.Checked := True;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  
  if CurPageID = wpSelectTasks then
  begin
    if WizardIsTaskSelected('envvars') then
    begin
      MsgBox('Environment variables will be set up. You may need to restart your command prompt or log off/on for changes to take effect.', mbInformation, MB_OK);
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
  UserScriptsDir: String;
begin
  if CurStep = ssPostInstall then
  begin
    // Create user scripts directory in Documents
    UserScriptsDir := ExpandConstant('{userdocs}\WinScript2\Scripts');
    if not DirExists(UserScriptsDir) then
      CreateDir(UserScriptsDir);
    
    // Kill any running instances
    Exec('taskkill', '/f /im tauri-app.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    Exec('taskkill', '/f /im WinScript2.exe', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
  end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  
  // Skip license page if LICENSE file doesn't exist
  if (PageID = wpLicense) and not FileExists(ExpandConstant('{src}\LICENSE')) then
    Result := True;
end;
