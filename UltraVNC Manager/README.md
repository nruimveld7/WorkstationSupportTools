# UltraVNC Manager
Stop and disable UltraVNC services after a support session so unattended VNC access is no longer available.

## What it does
- Verifies administrative privileges are present.
- Confirms the `uvnc_service` service exists; if missing, exits with a warning.
- Stops the service and waits briefly for it to report `STOPPED`.
- Sets the service start type to `disabled`.
- Terminates any running UltraVNC processes (`winvnc.exe`/`winvnc64.exe`).
- Exits with `0` on success; prints status messages to the console.

## Usage
1. Copy `UltraVNC Manager` to the workstation.
2. Open Command Prompt as Administrator.
3. Run `UltraVNCManager.bat`.
4. Review the status output; warnings are shown if the service is absent.

## Operational notes
- Intended for production networks where VNC is allowed only during tightly bounded support windows.
- Safe to run multiple times; if the service is already stopped/disabled, the script leaves it unchanged.
- Pair with scheduling or RMM automation that runs after an authorized session ends to ensure UltraVNC remains off.

## Installer build
- Run `Build.ps1` in this folder to generate an installer (`Output\UltraVNCManagerInstaller.exe`) using Inno Setup.
- The installer creates `{sd}\UltraVNCManager\UltraVNCManager.bat` and registers a nightly Task Scheduler entry at midnight under `SYSTEM` with highest privileges.
