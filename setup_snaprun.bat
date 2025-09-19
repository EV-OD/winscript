@echo off
REM SnapRun Post-Installation Setup Script
echo =====================================================
echo   SnapRun Setup Wizard
echo =====================================================

echo.
echo This script will help you configure SnapRun for optimal use.
echo.

REM Check if SnapRun is in PATH
SnapRun --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✓ SnapRun is installed and in PATH
) else (
    echo ⚠ SnapRun not found in PATH. You may need to run from installation directory.
)

echo.
echo Choose setup option:
echo [1] Standard Setup (Documents/SnapRun)
echo [2] Custom Setup (specify your own paths)
echo [3] Portable Setup (current directory)
echo.
set /p "choice=Enter your choice (1-3): "

if "%choice%"=="1" goto standard_setup
if "%choice%"=="2" goto custom_setup  
if "%choice%"=="3" goto portable_setup
echo Invalid choice. Defaulting to standard setup.

:standard_setup
echo.
echo Setting up SnapRun in Documents folder...
set "SnapRun_HOME=%USERPROFILE%\Documents\SnapRun"
set "SnapRun_SCRIPTS=%SnapRun_HOME%\Scripts"
goto create_directories

:custom_setup
echo.
set /p "SnapRun_HOME=Enter SnapRun home directory: "
set "SnapRun_SCRIPTS=%SnapRun_HOME%\Scripts"
goto create_directories

:portable_setup
echo.
echo Setting up portable installation...
set "SnapRun_HOME=%CD%\SnapRun"
set "SnapRun_SCRIPTS=%SnapRun_HOME%\Scripts"
goto create_directories

:create_directories
echo.
echo Creating directories...
if not exist "%SnapRun_HOME%" mkdir "%SnapRun_HOME%"
if not exist "%SnapRun_SCRIPTS%" mkdir "%SnapRun_SCRIPTS%"
if not exist "%SnapRun_SCRIPTS%\built_in_scripts" mkdir "%SnapRun_SCRIPTS%\built_in_scripts"
if not exist "%SnapRun_SCRIPTS%\custom_scripts" mkdir "%SnapRun_SCRIPTS%\custom_scripts"

echo ✓ Created directory structure:
echo   - Home: %SnapRun_HOME%
echo   - Scripts: %SnapRun_SCRIPTS%

echo.
echo Setting environment variables...
REM Set user environment variables
setx SnapRun_HOME "%SnapRun_HOME%"
setx SnapRun_SCRIPTS "%SnapRun_SCRIPTS%"

echo ✓ Environment variables set:
echo   SnapRun_HOME=%SnapRun_HOME%
echo   SnapRun_SCRIPTS=%SnapRun_SCRIPTS%

echo.
echo Copying sample scripts...
REM Copy built-in scripts if they exist in installation directory
if exist "user_scripts\built_in_scripts" (
    xcopy "user_scripts\built_in_scripts\*" "%SnapRun_SCRIPTS%\built_in_scripts\" /y /q
    echo ✓ Copied built-in scripts
)

REM Create a sample custom script
echo // SnapRun Sample Custom Script > "%SnapRun_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("Welcome to SnapRun!"); >> "%SnapRun_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("This is a custom script in: " + get_script_dir()); >> "%SnapRun_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("You can edit this file to create your own scripts."); >> "%SnapRun_SCRIPTS%\custom_scripts\welcome.rhai"

echo.
echo =====================================================
echo   SnapRun Setup Complete!
echo   
echo   Configuration:
echo   - Home Directory: %SnapRun_HOME%
echo   - Scripts Directory: %SnapRun_SCRIPTS%
echo   
echo   How to use:
echo   1. Start SnapRun from Start Menu or Desktop
echo   2. Press Ctrl+Shift+W to toggle window (once implemented)
echo   3. System tray icon provides quick access
echo   4. Place custom scripts in: %SnapRun_SCRIPTS%\custom_scripts
echo   
echo   Note: Restart your command prompt or log off/on 
echo         for environment variables to take effect.
echo =====================================================
echo.
pause
