@echo off
REM WinScript2 Production Build Script
echo =====================================================
echo   WinScript2 Production Build
echo =====================================================

echo.
echo [1/5] Cleaning previous builds...
cd /d "%~dp0"
if exist "dist" rmdir /s /q "dist"
if exist "src-tauri\target\release" rmdir /s /q "src-tauri\target\release"

echo.
echo [2/5] Installing frontend dependencies...
call pnpm install
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to install frontend dependencies
    pause
    exit /b 1
)

echo.
echo [3/5] Building frontend...
call pnpm build
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Frontend build failed
    pause
    exit /b 1
)

echo.
echo [4/5] Building Tauri application...
call pnpm tauri build
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Tauri build failed
    pause
    exit /b 1
)

echo.
echo [5/5] Build complete!
echo.
echo Output files:
dir "src-tauri\target\release\bundle\msi\*.msi" 2>nul && echo   - MSI installer found
dir "src-tauri\target\release\bundle\nsis\*.exe" 2>nul && echo   - NSIS installer found
echo   - Executable: src-tauri\target\release\tauri-app.exe

echo.
echo =====================================================
echo   Build completed successfully!
echo   
echo   Available Installers:
echo   1. Run the MSI installer (Enterprise deployment)
echo   2. Run the NSIS .exe installer (User-friendly)
echo   3. Run build_inno_setup.bat for Inno Setup installer
echo   4. Copy the executable manually (Portable)
echo   
echo   Environment Variables (optional):
echo   WINSCRIPT2_SCRIPTS - Custom scripts directory
echo   WINSCRIPT2_HOME - WinScript2 home directory
echo =====================================================
echo.
pause
