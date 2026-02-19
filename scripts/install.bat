@echo off
setlocal EnableDelayedExpansion

echo ==========================================
echo  Installing Huffman Compressor (Windows)
echo ==========================================

:: 1. Configuration
:: Assuming script is in /scripts, we look one level up for the bin folder
set "SOURCE_DIR=%~dp0"
set "INSTALL_DIR=%USERPROFILE%\.huff_toolchain"

:: 2. Create Destination Folders
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%\bin" mkdir "%INSTALL_DIR%\bin"

:: 3. Install Executable
:: We rename 'huff_win.exe' to 'huff.exe' so the command is just 'huff'
if exist "%SOURCE_DIR%bin\huff_win.exe" (
    copy /Y "%SOURCE_DIR%bin\huff_win.exe" "%INSTALL_DIR%\bin\huff.exe" >nul
    echo [OK] Installed huff.exe
) else (
    echo [ERROR] Could not find bin\huff_win.exe
    echo         Please ensure you have built the project with CMake first.
    exit /b 1
)

:: =========================================================
::  MAKING IT "WORK LIKE GIT" (Permanent Access)
:: =========================================================
echo.
echo [SETUP] Configuring terminal commands...

:: STRATEGY 1: The "System-Wide" Install (Requires Admin)
:: We create a small .cmd file in the SystemRoot so it's instantly available everywhere
(
    echo @echo off
    echo "%INSTALL_DIR%\bin\huff.exe" %%*
) > "%SystemRoot%\huff.cmd" 2>nul

if exist "%SystemRoot%\huff.cmd" (
    echo    [SUCCESS] INSTALLED AS ADMINISTRATOR
    echo    -------------------------------------
    echo    You can now open ANY terminal window and type 'huff'.
    echo.
    goto :FINISH
)

:: STRATEGY 2: The "User-Only" Install (Fallback)
echo    [NOTE] Admin rights not detected. Using User Profile method.

:: Check if the path is already in the USER PATH to avoid duplicates
echo %PATH% | findstr /C:"%INSTALL_DIR%\bin" >nul
if %errorlevel% neq 0 (
    setx PATH "%INSTALL_DIR%\bin;%PATH%" >nul
)

echo    [SUCCESS] INSTALLED FOR USER
echo    -----------------------------
echo    The 'huff' command has been added to your settings.
echo    IMPORTANT: You must CLOSE ALL TERMINAL WINDOWS and open
echo               a new one for this change to take effect.

:FINISH
echo.
echo ==========================================
echo  Done.
echo ==========================================

:: SMART PAUSE:
:: Skips pause on GitHub Actions/CI, but keeps it for the user.
if "%GITHUB_ACTIONS%" == "" (
    pause
)