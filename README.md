# WorkstationSupportTools

Operational scripts and utilities for administering Windows workstations (Windows 7–11) on tightly controlled production networks where remote assistance must be available but strictly managed.

## What this repository is for

- Provide pre-vetted, low-friction tools that help service desks safely assist end users.
- Keep remote-access pathways (RDP, VNC, etc.) enabled only as long as required and then returned to a secure baseline.
- Serve as a monorepo foundation for additional workstation-support utilities, including future automation like shutting down licensed applications to reclaim seats.

## Current tools

- **RDP Manager** (`RDP Manager/RDPManager.bat`): Disables Remote Desktop by setting `fDenyTSConnections=1` and turning off the Remote Desktop firewall rule group.
- **UltraVNC Manager** (`UltraVNC Manager/UltraVNCManager.bat`): Stops and disables the `uvnc_service` service and terminates any running `winvnc` processes.

## Intended environment and practices

- Built for production networks where outbound access is limited or audited; scripts do not depend on internet connectivity.
- Run interactively or via managed tooling (SCCM/Intune/RMM) with administrative privileges.
- Idempotent operations: safe to run multiple times; each tool aims to leave the machine in a predictable, locked-down state.
- Minimal logging to stdout to avoid sensitive data exposure; integrate with your fleet logging if required.

## Usage (general)

1. Copy the relevant tool folder to the workstation (e.g., `RDP Manager`).
2. Open an elevated Command Prompt (Run as Administrator).
3. Execute the `.bat` file in that folder.
4. Confirm the on-screen status messages; non-zero exit indicates the action should be retried or investigated.
5. (Optional) Use the provided installer (`Output\*.exe`) to deploy and register the scheduled task automatically.

## Building installers

- Each tool folder includes an Inno Setup definition (`*.iss`) and a `Build.ps1` that locates `ISCC.exe` (from PATH or common install locations) and builds a standalone installer into `Output/`.
- Installers create a folder on the system drive matching the script name (e.g., `{sd}\RDPManager`) and place the batch file inside it, then register a daily Task Scheduler job at midnight running under `SYSTEM` with highest privileges.
- Building requires Inno Setup 6; the build script searches PATH, then common install directories (e.g., `C:\Program Files (x86)\Inno Setup 6\ISCC.exe`).

## Repository layout

- `RDP Manager/` - RDP hardening helper (`RDPManager.bat`).
- `UltraVNC Manager/` - UltraVNC shutdown/disable helper (`UltraVNCManager.bat`).
- `LICENSE` - MIT license for this repository.

## Extending the toolkit

- Add each new utility in its own folder with a clear name, a README describing purpose/usage, and a single-entry script or installer.
- Prefer self-contained scripts that do not require package installs; if dependencies are unavoidable, document and vendor them.
- Plan for future additions such as license-retention automations that cleanly close specific applications and verify success before exit.

## Support and maintenance

- Test scripts on a non-production image that mirrors production policies (UAC, firewall profiles, AV).
- Keep admin checks and guardrails in place; avoid weakening security baselines.
- Update the tool READMEs when behavior changes so operators know exactly what will happen when they run them.
