@echo off
setlocal enabledelayedexpansion

echo ========================================
echo WinScript2 User Scripts Environment Setup
echo ========================================
echo.

REM Get the current directory (where this batch file is located)
set "SCRIPT_DIR=%~dp0"
REM Remove trailing backslash
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM Set the user_scripts directory path
set "USER_SCRIPTS_DIR=%SCRIPT_DIR%\user_scripts"

echo Project directory: %SCRIPT_DIR%
echo User scripts directory: %USER_SCRIPTS_DIR%
echo.

REM Check if user_scripts directory exists
if not exist "%USER_SCRIPTS_DIR%" (
    echo ❌ ERROR: user_scripts directory not found at: %USER_SCRIPTS_DIR%
    echo Please make sure you're running this script from the WinScript2 project root
    goto :error
)

REM Set the user environment variable WIN_SCRIPT2_PATH to point to user_scripts
echo Setting user environment variable WIN_SCRIPT2_PATH to user_scripts directory...
setx WIN_SCRIPT2_PATH "%USER_SCRIPTS_DIR%" >nul 2>&1

if %errorlevel% equ 0 (
    echo ✅ SUCCESS: WIN_SCRIPT2_PATH has been set to: %USER_SCRIPTS_DIR%
) else (
    echo ❌ ERROR: Failed to set WIN_SCRIPT2_PATH environment variable
    echo Please run this script as Administrator if the error persists
    goto :error
)

echo.
echo ========================================
echo Environment Variable Details
echo ========================================
echo Variable Name: WIN_SCRIPT2_PATH
echo Variable Value: %USER_SCRIPTS_DIR%
echo Variable Scope: User (Current User Only)
echo Points to: User Scripts Directory
echo.

echo ========================================
echo Usage After Compilation
echo ========================================
echo After compiling your WinScript2 app:
echo 1. The compiled app will look for WIN_SCRIPT2_PATH environment variable
echo 2. You can move the user_scripts folder anywhere on your system
echo 3. Update WIN_SCRIPT2_PATH to point to the new location
echo 4. The app will find your scripts using this environment variable
echo.

echo ========================================
echo Directory Structure
echo ========================================
echo WIN_SCRIPT2_PATH should contain:
echo   ├── built_in_scripts/
echo   │   ├── simple_greeting.rhai
echo   │   ├── calculator.rhai
echo   │   └── ... (other built-in scripts)
echo   └── custom_scripts/
echo       └── ... (your custom scripts)
echo.

echo ========================================
echo Next Steps
echo ========================================
echo 1. Close and reopen any Command Prompt/PowerShell windows
echo 2. Close and reopen any IDEs (VS Code, etc.)
echo 3. The variable will be available in new processes
echo.
echo To verify the variable is set, open a new Command Prompt and run:
echo   echo %%WIN_SCRIPT2_PATH%%
echo.
echo To use in PowerShell:
echo   $env:WIN_SCRIPT2_PATH
echo.
echo To list your scripts:
echo   dir "%%WIN_SCRIPT2_PATH%%\built_in_scripts"
echo   dir "%%WIN_SCRIPT2_PATH%%\custom_scripts"
echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo WIN_SCRIPT2_PATH now points to your user_scripts directory.
echo After compiling, you can move user_scripts anywhere and update this variable.
echo.
pause
exit /b 0

:error
echo.
echo Setup failed. Please check the error messages above.
pause
exit /b 1
