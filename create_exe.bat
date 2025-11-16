@echo off
title Create WiFi Fixer EXE
set SEDFILE=%temp%\wifi_fixer.sed

echo [Version] > "%SEDFILE%"
echo Class=IEXPRESS >> "%SEDFILE%"
echo SEDVersion=3 >> "%SEDFILE%"
echo [Options] >> "%SEDFILE%"
echo PackagePurpose=InstallApp >> "%SEDFILE%"
echo ShowInstallProgramWindow=1 >> "%SEDFILE%"
echo HideExtractAnimation=1 >> "%SEDFILE%"
echo UseLongFileName=1 >> "%SEDFILE%"
echo InsideCompressed=0 >> "%SEDFILE%"
echo CAB_FixedSize=0 >> "%SEDFILE%"
echo CAB_ResvCodeSigning=0 >> "%SEDFILE%"
echo RebootMode=N >> "%SEDFILE%"
echo InstallPrompt=%InstallPrompt% >> "%SEDFILE%"
echo DisplayLicense=%DisplayLicense% >> "%SEDFILE%"
echo FinishMessage=%FinishMessage% >> "%SEDFILE%"
echo TargetName=%TargetName% >> "%SEDFILE%"
echo FriendlyName=%FriendlyName% >> "%SEDFILE%"
echo AppLaunched=%AppLaunched% >> "%SEDFILE%"
echo PostInstallCmd=%PostInstallCmd% >> "%SEDFILE%"
echo AdminQuietInstCmd=%AdminQuietInstCmd% >> "%SEDFILE%"
echo UserQuietInstCmd=%UserQuietInstCmd% >> "%SEDFILE%"
echo SourceFiles=SourceFiles >> "%SEDFILE%"

echo [SourceFiles] >> "%SEDFILE%"
echo SourceFiles0=%~dp0 >> "%SEDFILE%"
echo [SourceFiles0] >> "%SEDFILE%"
echo %%FILE0%%=wif_fixer_pro.bat >> "%SEDFILE%"

echo [Strings] >> "%SEDFILE%"
echo InstallPrompt= >> "%SEDFILE%"
echo DisplayLicense= >> "%SEDFILE%"
echo FinishMessage=WiFi Fixer has been installed successfully. >> "%SEDFILE%"
echo TargetName=wif_fixer_pro.exe >> "%SEDFILE%"
echo FriendlyName=HP WiFi Fixer Pro >> "%SEDFILE%"
echo AppLaunched=wif_fixer_pro.bat >> "%SEDFILE%"
echo PostInstallCmd= >> "%SEDFILE%"
echo AdminQuietInstCmd= >> "%SEDFILE%"
echo UserQuietInstCmd= >> "%SEDFILE%"

echo Creating WiFi_Fixer_Pro.exe...
iexpress /n /q /m %SEDFILE%

if exist "wif_fixer_pro.exe" (
    echo SUCCESS: wif_fixer_pro.exe created!
    del "%SEDFILE%"
) else (
    echo ERROR: Failed to create EXE file
    pause
)
