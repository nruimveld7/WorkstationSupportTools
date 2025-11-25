@echo off
setlocal ENABLEEXTENSIONS

:: --------------------------------------------------------------
:: Admin check (required to change registry + firewall)
:: --------------------------------------------------------------
>nul 2>&1 net session
if not %errorlevel%==0 (
    echo [ERROR] Administrative privileges are required.
    echo Run this script as Administrator.
    pause
    goto :EOF
)

:: --------------------------------------------------------------
:: Disable RDP registry flag
:: --------------------------------------------------------------
echo [INFO] Disabling Remote Desktop in registry...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" ^
    /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul 2>&1

if not %errorlevel%==0 (
    echo [ERROR] Failed to modify registry.
    pause
    goto :EOF
)

:: --------------------------------------------------------------
:: Disable RDP firewall rule group
:: --------------------------------------------------------------
echo [INFO] Disabling Remote Desktop firewall rules...
netsh advfirewall firewall set rule group="remote desktop" new enable=no >nul 2>&1

if not %errorlevel%==0 (
    echo [WARN] Firewall rule group not found or could not be modified.
)

:: --------------------------------------------------------------
:: Done — clean exit for Task Scheduler
:: --------------------------------------------------------------
endlocal
exit /b 0
