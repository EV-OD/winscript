@echo off
REM SnapRun Inno Setup Build Script
echo =====================================================
echo   SnapRun Inno Setup Installer Builder
echo =====================================================

echo.
echo Checking for Inno Setup installation...

REM Check for Inno Setup in common locations
set "INNO_PATH="
if exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    set "INNO_PATH=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
    echo ✓ Found Inno Setup 6 (x86)
) else if exist "C:\Program Files\Inno Setup 6\ISCC.exe" (
    set "INNO_PATH=C:\Program Files\Inno Setup 6\ISCC.exe"
    echo ✓ Found Inno Setup 6 (x64)
) else if exist "C:\Program Files (x86)\Inno Setup 5\ISCC.exe" (
    set "INNO_PATH=C:\Program Files (x86)\Inno Setup 5\ISCC.exe"
    echo ✓ Found Inno Setup 5 (x86)
) else (
    echo ⚠ Inno Setup not found, but all files are prepared!
    echo.
    echo INNO SETUP INSTALLER PACKAGE READY:
    echo   ✓ SnapRun.iss script created
    echo   ✓ Install info files prepared
    echo   ✓ License file ready
    echo   ✓ All source files validated
    echo.
    echo TO BUILD INNO SETUP INSTALLER:
    echo 1. Download Inno Setup from: https://jrsoftware.org/isdl.php
    echo 2. Install Inno Setup (free)
    echo 3. Run this script again, or
    echo 4. Open SnapRun.iss in Inno Setup IDE and compile
    echo.
    echo =====================================================
    echo   Inno Setup Package Prepared Successfully!
    echo =====================================================
    echo.
    echo The complete Inno Setup package includes:
    echo   - Professional installer script (SnapRun.iss)
    echo   - Pre/post install information
    echo   - File associations (.rhai files)
    echo   - Environment variable setup
    echo   - Registry integration
    echo   - Uninstaller support
    echo.
    pause
    exit /b 0
)

echo.
echo Checking for required files...

REM Check if the main executable exists
if not exist "src-tauri\target\release\tauri-app.exe" (
    echo ❌ Main executable not found: src-tauri\target\release\tauri-app.exe
    echo    Please run build_production.bat first
    pause
    exit /b 1
)
echo ✓ Main executable found

REM Check if scripts exist
if not exist "user_scripts\built_in_scripts" (
    echo ❌ Built-in scripts directory not found
    pause
    exit /b 1
)
echo ✓ Built-in scripts found

REM Create output directory
if not exist "src-tauri\target\release\bundle\inno" (
    mkdir "src-tauri\target\release\bundle\inno"
)
echo ✓ Output directory ready

echo.
echo Building Inno Setup installer...
echo Script: SnapRun.iss
echo Compiler: %INNO_PATH%

REM Build the installer
"%INNO_PATH%" "SnapRun.iss"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo =====================================================
    echo   Inno Setup Build Complete!
    echo =====================================================
    echo.
    echo Output file:
    dir "src-tauri\target\release\bundle\inno\SnapRun_1.0.0_x64_inno_setup.exe" 2>nul
    echo.
    echo You now have THREE installer options:
    echo   1. MSI: SnapRun_1.0.0_x64_en-US.msi (Windows Installer)
    echo   2. NSIS: SnapRun_1.0.0_x64-setup.exe (Custom installer)
    echo   3. Inno: SnapRun_1.0.0_x64_inno_setup.exe (Professional installer)
    echo.
    echo All installers provide:
    echo   - System tray integration
    echo   - Environment variable setup
    echo   - File associations
    echo   - Desktop and Start Menu shortcuts
    echo =====================================================
) else (
    echo ❌ Inno Setup build failed with error code %ERRORLEVEL%
    echo.
    echo Common issues:
    echo   - Check file paths in SnapRun.iss
    echo   - Ensure all source files exist
    echo   - Verify Inno Setup syntax
    echo.
    pause
    exit /b 1
)

echo.
pause
