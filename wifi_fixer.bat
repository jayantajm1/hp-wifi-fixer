@echo off
title HP Pavilion WiFi Driver Reset - OFFLINE
setlocal enabledelayedexpansion

echo ============================================
echo  WiFi Driver Reset - Using Windows Built-in
echo ============================================
echo.

:: Check admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Run as Administrator!
    pause
    exit /b 1
)

echo [1/4] Removing current WiFi drivers...
set device_count=0
for /f "tokens=1,2*" %%i in ('pnputil /enum-devices /class Net 2^>nul ^| findstr /i "Wi-Fi"') do (
    if not "%%i"=="" (
        echo Removing WiFi device: %%i
        pnputil /remove-device "%%i" >nul 2>&1
        set /a device_count+=1
    )
)

echo [2/4] Resetting network stack...
netsh winsock reset >nul
netsh int ip reset >nul
ipconfig /flushdns >nul

echo [3/4] Forcing Windows to use built-in drivers...
set devmgmt_started=0
for /f "tokens=*" %%i in ('devcon status *wireless* *wifi* *wlan*') do (
    echo %%i | findstr "No drivers" >nul
    if not errorlevel 1 (
        if !devmgmt_started! equ 0 (
            start devmgmt.msc
            set devmgmt_started=1
        )
    )
)

echo [4/4] Scanning for hardware changes...
pnputil /scan-devices >nul

echo.
echo ============================================
echo COMPLETED!
echo.
if !device_count! gtr 0 (
    echo Removed !device_count! WiFi devices
) else (
    echo No WiFi devices found to remove
)
echo.
echo If WiFi still doesn't work:
echo 1. Check Device Manager for unknown devices
echo 2. Install driver manually from HP website
echo 3. Restart computer
echo ============================================
echo.

set /p restart="Restart now? (Y/N): "
if /i "!restaint!"=="Y" shutdown /r /t 5

pause