@echo off
REM WinScript2 Post-Installation Setup Script
echo =====================================================
echo   WinScript2 Setup Wizard
echo =====================================================

echo.
echo This script will help you configure WinScript2 for optimal use.
echo.

REM Check if WinScript2 is in PATH
winscript2 --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo ✓ WinScript2 is installed and in PATH
) else (
    echo ⚠ WinScript2 not found in PATH. You may need to run from installation directory.
)

echo.
echo Choose setup option:
echo [1] Standard Setup (Documents/WinScript2)
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
echo Setting up WinScript2 in Documents folder...
set "WINSCRIPT2_HOME=%USERPROFILE%\Documents\WinScript2"
set "WINSCRIPT2_SCRIPTS=%WINSCRIPT2_HOME%\Scripts"
goto create_directories

:custom_setup
echo.
set /p "WINSCRIPT2_HOME=Enter WinScript2 home directory: "
set "WINSCRIPT2_SCRIPTS=%WINSCRIPT2_HOME%\Scripts"
goto create_directories

:portable_setup
echo.
echo Setting up portable installation...
set "WINSCRIPT2_HOME=%CD%\WinScript2"
set "WINSCRIPT2_SCRIPTS=%WINSCRIPT2_HOME%\Scripts"
goto create_directories

:create_directories
echo.
echo Creating directories...
if not exist "%WINSCRIPT2_HOME%" mkdir "%WINSCRIPT2_HOME%"
if not exist "%WINSCRIPT2_SCRIPTS%" mkdir "%WINSCRIPT2_SCRIPTS%"
if not exist "%WINSCRIPT2_SCRIPTS%\built_in_scripts" mkdir "%WINSCRIPT2_SCRIPTS%\built_in_scripts"
if not exist "%WINSCRIPT2_SCRIPTS%\custom_scripts" mkdir "%WINSCRIPT2_SCRIPTS%\custom_scripts"

echo ✓ Created directory structure:
echo   - Home: %WINSCRIPT2_HOME%
echo   - Scripts: %WINSCRIPT2_SCRIPTS%

echo.
echo Setting environment variables...
REM Set user environment variables
setx WINSCRIPT2_HOME "%WINSCRIPT2_HOME%"
setx WINSCRIPT2_SCRIPTS "%WINSCRIPT2_SCRIPTS%"

echo ✓ Environment variables set:
echo   WINSCRIPT2_HOME=%WINSCRIPT2_HOME%
echo   WINSCRIPT2_SCRIPTS=%WINSCRIPT2_SCRIPTS%

echo.
echo Copying sample scripts...
REM Copy built-in scripts if they exist in installation directory
if exist "user_scripts\built_in_scripts" (
    xcopy "user_scripts\built_in_scripts\*" "%WINSCRIPT2_SCRIPTS%\built_in_scripts\" /y /q
    echo ✓ Copied built-in scripts
)

REM Create a sample custom script
echo // WinScript2 Sample Custom Script > "%WINSCRIPT2_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("Welcome to WinScript2!"); >> "%WINSCRIPT2_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("This is a custom script in: " + get_script_dir()); >> "%WINSCRIPT2_SCRIPTS%\custom_scripts\welcome.rhai"
echo print("You can edit this file to create your own scripts."); >> "%WINSCRIPT2_SCRIPTS%\custom_scripts\welcome.rhai"

echo.
echo =====================================================
echo   WinScript2 Setup Complete!
echo   
echo   Configuration:
echo   - Home Directory: %WINSCRIPT2_HOME%
echo   - Scripts Directory: %WINSCRIPT2_SCRIPTS%
echo   
echo   How to use:
echo   1. Start WinScript2 from Start Menu or Desktop
echo   2. Press Ctrl+Shift+W to toggle window (once implemented)
echo   3. System tray icon provides quick access
echo   4. Place custom scripts in: %WINSCRIPT2_SCRIPTS%\custom_scripts
echo   
echo   Note: Restart your command prompt or log off/on 
echo         for environment variables to take effect.
echo =====================================================
echo.
pause
