[Setup]
AppName=UltraVNC Manager
AppVersion=1.0.0
DefaultDirName={sd}\UltraVNCManager
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=UltraVNCManagerInstaller
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
Source: "UltraVNCManager.bat"; DestDir: "{sd}\UltraVNCManager"; Flags: ignoreversion

[Run]
Filename: "schtasks.exe"; Parameters: "/Create /TN ""UltraVNC Manager"" /SC DAILY /ST 00:00 /RU SYSTEM /RL HIGHEST /F /TR ""\""{sd}\UltraVNCManager\UltraVNCManager.bat\"" "" "; Flags: runhidden

[UninstallRun]
Filename: "schtasks.exe"; Parameters: "/Delete /TN ""UltraVNC Manager"" /F"; Flags: runhidden; RunOnceId: "RemoveUltraVNCTask"
