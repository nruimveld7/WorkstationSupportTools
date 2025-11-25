# Contributing
Thanks for helping extend WorkstationSupportTools. This toolkit is aimed at production workstations where remote assistance must stay tightly controlled. Please keep changes minimal, predictable, and well-documented.

## Principles
- **Least access**: Default to disabling or constraining remote-access paths once support ends.
- **Offline-friendly**: Avoid external dependencies and internet fetches.
- **Idempotent**: Scripts should be safe to run multiple times and leave the machine in a known state.
- **Transparent**: Emit clear, minimal console output; avoid verbose logs unless necessary for operators.

## Adding a new tool
1. Create a new folder at the repo root with a concise name.
2. Place the primary entry point script in that folder (Batch or PowerShell preferred for ubiquity).
3. Add a `README.md` in the folder describing purpose, usage, prerequisites, and expected behavior.
4. Keep any binaries or installers vendorized inside the folder; document their source and version.
5. Include privilege checks (e.g., admin) and defensive guards before making system changes.
6. If adding an installer, mirror the pattern used here: one `.iss` file, a `Build.ps1` that finds `ISCC.exe`, install to a dedicated `{sd}\ToolName\` folder, and keep `schtasks` arguments simple and well-quoted.

## Testing
- Validate on a non-production build that mirrors production policies (UAC, firewall, AV, limited outbound).
- Re-run scripts to confirm idempotency and stable exit codes.
- Document any known environmental requirements in the tool README.
- If you add an installer, test that the scheduled task is created, points to the installed path, and runs under the intended account.

## Documentation updates
- Reflect behavioral changes in both the tool README and the root `README.md` tool list.
- Note if scripts are intended for scheduled/RMM execution so operators know how to deploy safely.
