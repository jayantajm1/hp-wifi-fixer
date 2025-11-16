@echo off
title Create HP WiFi Fixer Pro EXE
echo Creating HP_WiFi_Fixer_Pro.exe for GitHub release...

:: Create IExpress SED file
set SEDFILE=%temp%\wifi_fixer_release.sed

(
echo [Version]
echo Class=IEXPRESS
echo SEDVersion=3
echo [Options]
echo PackagePurpose=InstallApp
echo ShowInstallProgramWindow=1
echo HideExtractAnimation=1
echo UseLongFileName=1
echo InsideCompressed=0
echo CAB_FixedSize=0
echo CAB_ResvCodeSigning=0
echo RebootMode=N
echo InstallPrompt=Do you want to run HP WiFi Fixer Pro?
echo DisplayLicense=
echo FinishMessage=HP WiFi Fixer Pro has been installed successfully. Please run the tool as Administrator.
echo TargetName=HP_WiFi_Fixer_Pro.exe
echo FriendlyName=HP WiFi Fixer Pro v1.0
echo AppLaunched=cmd /c "echo Please download the WiFi driver from HP Support website && echo Rename it to 'wifi-driver.exe' && echo Place in same folder as this EXE && echo Then run 'wif_fixer_pro.bat' as Administrator && pause"
echo PostInstallCmd=
echo AdminQuietInstCmd=
echo UserQuietInstCmd=
echo SourceFiles=SourceFiles
echo [SourceFiles]
echo SourceFiles0=%~dp0
echo [SourceFiles0]
echo %%FILE0%%=wif_fixer_pro.bat
echo [Strings]
echo InstallPrompt=Do you want to run HP WiFi Fixer Pro?
echo DisplayLicense=
echo FinishMessage=HP WiFi Fixer Pro has been installed successfully.^&^&Please run the tool as Administrator.
echo TargetName=HP_WiFi_Fixer_Pro.exe
echo FriendlyName=HP WiFi Fixer Pro v1.0
echo AppLaunched=cmd /c "echo Please download the WiFi driver from HP Support website && echo Rename it to 'wifi-driver.exe' && echo Place in same folder as this EXE && echo Then run 'wif_fixer_pro.bat' as Administrator && pause"
echo PostInstallCmd=
echo AdminQuietInstCmd=
echo UserQuietInstCmd=
) > "%SEDFILE%"

echo Building HP_WiFi_Fixer_Pro.exe...
iexpress /n /q /m "%SEDFILE%"

if exist "HP_WiFi_Fixer_Pro.exe" (
    echo SUCCESS: HP_WiFi_Fixer_Pro.exe created!
    echo File size: 
    for %%F in (HP_WiFi_Fixer_Pro.exe) do echo   %%~zF bytes
    del "%SEDFILE%"
) else (
    echo ERROR: Failed to create EXE file
    pause
)
