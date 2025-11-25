# RDP Manager
Disable Remote Desktop on a workstation after a support session so the device returns to a secure baseline.

## What it does
- Verifies administrative privileges are present.
- Sets `HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\fDenyTSConnections` to `1` (RDP connections denied).
- Disables the "Remote Desktop" Windows Firewall rule group.
- Exits with `0` on success; writes concise status messages to the console.

## Usage
1. Copy `RDP Manager` to the workstation.
2. Open Command Prompt as Administrator.
3. Run `RDPManager.bat`.
4. Confirm the info/error output before closing the window.

## Operational notes
- Designed for production networks where remote access is temporarily enabled for assistance and must be disabled immediately afterward.
- Safe to run repeatedly; no changes are made if RDP is already blocked.
- Suitable for wrapping in a scheduled task or RMM action that triggers after a support window closes.

## Installer build
- Requires Inno Setup 6 (`ISCC.exe`) on PATH; `Build.ps1` will stop with an error if it cannot find it.
- Run `Build.ps1` in this folder to generate an installer (`Output\RDPManagerInstaller.exe`) using Inno Setup.
- The installer creates `{sd}\RDPManager\RDPManager.bat`, registers a nightly Task Scheduler entry at midnight under `SYSTEM` with highest privileges, and the uninstaller removes that task.
