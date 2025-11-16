# HP WiFi Fixer Tool Guide

Summary
- This file provides a short guide for using the HP WiFi Fixer tools in this repository.

Usage
- `wif_fixer_pro.bat`: Primary script that performs fix operations. Run from an elevated PowerShell or CMD if required.
- `create_exe.bat`: Generates a self-contained `wif_fixer_pro.exe` using IExpress. Run on Windows with `iexpress` available.
- `HP_WiFi_Fixer_Pro.exe`: Placeholder for the packaged executable (replace with actual build output for releases).

Creating the EXE
1. Ensure `wif_fixer_pro.bat` is present and tested.
2. Run `create_exe.bat` from an elevated Command Prompt. This script builds a temporary SED and calls `iexpress` to produce `wif_fixer_pro.exe`.

Notes
- `create_exe.bat` uses IExpress which is available on many Windows installations. If missing, install or run on a machine with Windows components enabled.
- Replace the placeholder `HP_WiFi_Fixer_Pro.exe` with an actual built executable before publishing releases.

Support
- For bug reports, use the issue template in `.github/ISSUE_TEMPLATE/bug_report.md`.
