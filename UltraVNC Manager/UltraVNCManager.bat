@echo off
setlocal ENABLEEXTENSIONS

set "SERVICE_NAME=uvnc_service"

:: ------------------------------------------------------------------
:: Privilege Check
:: ------------------------------------------------------------------
>nul 2>&1 net session
if not %errorlevel%==0 (
    echo [ERROR] Administrative privileges are required.
    echo Run this script as Administrator.
    pause
    goto :EOF
)

:: ------------------------------------------------------------------
:: Service Existence Check
:: ------------------------------------------------------------------
sc query "%SERVICE_NAME%" >nul 2>&1
if errorlevel 1060 (
    echo [WARN] Service "%SERVICE_NAME%" does not exist.
    pause
    goto :EOF
)

:: ------------------------------------------------------------------
:: Stop Service
:: ------------------------------------------------------------------
sc stop "%SERVICE_NAME%" >nul 2>&1

set /a WAIT_COUNT=0
:WAIT_LOOP
sc query "%SERVICE_NAME%" | find /I "STATE" | find /I "STOPPED" >nul 2>&1
if not errorlevel 1 goto disable_service

set /a WAIT_COUNT+=1
if %WAIT_COUNT% GEQ 30 goto disable_service

ping -n 2 127.0.0.1 >nul
goto WAIT_LOOP

:: ------------------------------------------------------------------
:: Disable Startup Type
:: ------------------------------------------------------------------
:disable_service
sc config "%SERVICE_NAME%" start= disabled >nul 2>&1
if not %errorlevel%==0 (
    echo [ERROR] Failed to set startup type to DISABLED.
    pause
    goto :EOF
)


:: ------------------------------------------------------------------
:: Kill running UltraVNC processes (winvnc*)
:: ------------------------------------------------------------------
tasklist | find /I "winvnc" >nul 2>&1
if not errorlevel 1 goto kill_vnc

echo [INFO] No UltraVNC processes found.
goto :EOF

:kill_vnc
echo [INFO] Terminating running UltraVNC process(es)...
taskkill /IM winvnc.exe /F >nul 2>&1
taskkill /IM winvnc64.exe /F >nul 2>&1

endlocal
exit /b 0
