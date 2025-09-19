@echo off
REM SnapRun Test Installation Script
echo =====================================================
echo   SnapRun Installation Test
echo =====================================================

echo.
echo Testing SnapRun installation...

REM Check if executable exists
if exist "src-tauri\target\release\tauri-app.exe" (
    echo ✓ Release executable found
    set "WINSCRIPT_EXE=src-tauri\target\release\tauri-app.exe"
) else if exist "tauri-app.exe" (
    echo ✓ Executable found in current directory
    set "WINSCRIPT_EXE=tauri-app.exe"
) else (
    echo ❌ SnapRun executable not found
    echo    Please run build_production.bat first or check if tauri-app.exe exists
    pause
    exit /b 1
)

REM Check installer files
echo.
echo Checking installer packages...
if exist "src-tauri\target\release\bundle\msi\*.msi" (
    echo ✓ MSI installer found
    dir "src-tauri\target\release\bundle\msi\*.msi" /b
) else (
    echo ⚠ MSI installer not found
)

if exist "src-tauri\target\release\bundle\nsis\*.exe" (
    echo ✓ NSIS installer found  
    dir "src-tauri\target\release\bundle\nsis\*.exe" /b
) else (
    echo ⚠ NSIS installer not found
)

if exist "src-tauri\target\release\bundle\inno\*.exe" (
    echo ✓ Inno Setup installer found
    dir "src-tauri\target\release\bundle\inno\*.exe" /b
) else (
    if exist "SnapRun.iss" (
        echo ✓ Inno Setup package ready ^(run build_inno_setup.bat^)
    ) else (
        echo ⚠ Inno Setup package not found
    )
)

REM Test environment variables
echo.
echo Testing environment variables...
if defined SnapRun_HOME (
    echo ✓ SnapRun_HOME is set: %SnapRun_HOME%
) else (
    echo ⚠ SnapRun_HOME not set (optional)
)

if defined SnapRun_SCRIPTS (
    echo ✓ SnapRun_SCRIPTS is set: %SnapRun_SCRIPTS%
) else (
    echo ⚠ SnapRun_SCRIPTS not set (optional)  
)

REM Test script directory
echo.
echo Testing script directories...
if exist "user_scripts\built_in_scripts" (
    echo ✓ Built-in scripts directory exists
    for /f %%i in ('dir "user_scripts\built_in_scripts\*.rhai" /b 2^>nul ^| find /c /v ""') do (
        echo   - Found %%i built-in scripts
    )
) else (
    echo ❌ Built-in scripts directory missing
)

if exist "user_scripts\custom_scripts" (
    echo ✓ Custom scripts directory exists
    for /f %%i in ('dir "user_scripts\custom_scripts\*.rhai" /b 2^>nul ^| find /c /v ""') do (
        echo   - Found %%i custom scripts
    )
) else (
    echo ❌ Custom scripts directory missing
)

echo.
echo =====================================================
echo   Installation Test Complete
echo   
echo   Quick Start:
echo   1. Run setup_SnapRun.bat for full setup
echo   2. Or run %WINSCRIPT_EXE% directly
echo   3. Look for system tray icon
echo   
echo   Available Installers:
echo   - MSI: Enterprise deployment ready
echo   - NSIS: User-friendly installer ready
echo   - Inno: Professional package ready (needs Inno Setup)
echo   
echo   Files ready for distribution:
echo   - Executable: %WINSCRIPT_EXE%
echo   - Setup script: setup_SnapRun.bat
echo   - Documentation: PRODUCTION_README.md
echo   - Installer summary: INSTALLER_SUMMARY.md
echo =====================================================
echo.
pause
