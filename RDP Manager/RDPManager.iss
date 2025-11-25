[Setup]
AppName=RDP Manager
AppVersion=1.0.0
DefaultDirName={sd}\RDPManager
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=RDPManagerInstaller
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
Source: "RDPManager.bat"; DestDir: "{sd}\RDPManager"; Flags: ignoreversion

[Run]
Filename: "schtasks.exe"; Parameters: "/Create /TN ""RDP Manager"" /SC DAILY /ST 00:00 /RU SYSTEM /RL HIGHEST /F /TR ""\""{sd}\RDPManager\RDPManager.bat\"" "" "; Flags: runhidden

[UninstallRun]
Filename: "schtasks.exe"; Parameters: "/Delete /TN ""RDP Manager"" /F"; Flags: runhidden; RunOnceId: "RemoveRdpManagerTask"
