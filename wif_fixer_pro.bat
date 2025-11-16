@echo off
title HP Pavilion WiFi Driver Fix - OFFLINE
setlocal enabledelayedexpansion

echo ============================================
echo    HP Pavilion WiFi Driver Reinstallation
echo    Automatic Driver Detection - OFFLINE
echo ============================================
echo.

:: Check administrator rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Please run as Administrator!
    echo Right-click -> "Run as administrator"
    pause
    exit /b 1
)

echo Checking for WiFi drivers in current directory...
echo Current directory: %~dp0
echo.

:: STEP 1: Search for driver files with known names
set driver_found=0
set driver_file=

echo Searching for driver files...
echo.

:: List of known driver file names to try (in order of priority)
if exist "%~dp0wifi-driver.exe" (
    set "driver_file=wifi-driver.exe"
    set driver_found=1
    goto :found_driver
)

if exist "%~dp0MediaTek_WiFi_Driver.exe" (
    set "driver_file=MediaTek_WiFi_Driver.exe"
    set driver_found=1
    goto :found_driver
)

if exist "%~dp0Realtek_WiFi_Driver.exe" (
    set "driver_file=Realtek_WiFi_Driver.exe"
    set driver_found=1
    goto :found_driver
)

if exist "%~dp0Wireless_Driver.exe" (
    set "driver_file=Wireless_Driver.exe"
    set driver_found=1
    goto :found_driver
)

if exist "%~dp0Network_Driver.exe" (
    set "driver_file=Network_Driver.exe"
    set driver_found=1
    goto :found_driver
)

:: Search for any EXE files that might be drivers
echo Available executable files in directory:
for %%f in ("%~dp0*.exe") do (
    echo   - %%~nxf
)
echo.

:: Try to find EXE files with WiFi-related names
for %%f in ("%~dp0*WiFi*.exe") do (
    if not defined driver_file (
        set "driver_file=%%~nxf"
        set driver_found=1
    )
)

for %%f in ("%~dp0*Wireless*.exe") do (
    if not defined driver_file (
        set "driver_file=%%~nxf"
        set driver_found=1
    )
)

for %%f in ("%~dp0*WLAN*.exe") do (
    if not defined driver_file (
        set "driver_file=%%~nxf"
        set driver_found=1
    )
)

:found_driver

if !driver_found! equ 0 (
    echo ERROR: No WiFi driver found in current directory!
    echo.
    echo Please download the WiFi driver from HP website and save it here as:
    echo   wifi-driver.exe
    echo.
    echo Current directory: %~dp0
    echo.
    echo Available files:
    dir "%~dp0*.*" /b
    echo.
    pause
    exit /b 1
)

echo SUCCESS: Found driver file: %driver_file%
echo.

:: STEP 2: Remove existing WiFi drivers
echo [1/4] Removing existing WiFi drivers...
set removed_count=0
for /f "tokens=1,2*" %%i in ('pnputil /enum-devices /class Net 2^>nul ^| findstr /i "Wi-Fi"') do (
    if not "%%i"=="" (
        echo Removing WiFi device: %%i
        pnputil /remove-device "%%i" >nul 2>&1
        set /a removed_count+=1
    )
)
echo Removed !removed_count! WiFi devices
echo.

:: STEP 3: Clean driver store
echo [2/4] Cleaning WiFi driver packages...
set deleted_count=0
for /f "tokens=1,*" %%i in ('pnputil /enum-drivers 2^>nul ^| findstr /i "oem.*inf.*wireless"') do (
    echo Deleting driver package: %%i
    pnputil /delete-driver "%%i" /uninstall /force >nul 2>&1
    set /a deleted_count+=1
)
echo Deleted !deleted_count! driver packages
echo.

:: STEP 4: Reset network stack
echo [3/4] Resetting network configuration...
netsh winsock reset >nul
netsh int ip reset >nul
ipconfig /flushdns >nul
echo Network reset completed
echo.

:: STEP 5: Install new driver
echo [4/4] Installing driver: %driver_file%
echo Please wait, this may take a few minutes...
"%~dp0%driver_file%" /quiet /norestart

:: Final hardware scan
echo Performing final hardware scan...
pnputil /scan-devices >nul 2>&1

echo.
echo ============================================
echo INSTALLATION COMPLETED!
echo.
echo Driver used: %driver_file%
echo Removed !removed_count! WiFi devices
echo Deleted !deleted_count! driver packages
echo.
echo Please restart your computer to finish installation.
echo ============================================
echo.

set /p restart="Restart now? (Y/N): "
if /i "!restart!"=="Y" (
    echo Restarting in 10 seconds... Press Ctrl+C to cancel.
    shutdown /r /t 10
) else (
    echo Please restart manually when ready.
    pause
)

exit