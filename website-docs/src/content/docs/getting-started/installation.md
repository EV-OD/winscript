---
title: "Installation Guide"
description: "Step-by-step guide to install SnapRun on your Windows system"
---

# Installing SnapRun

Get SnapRun up and running on your Windows system in just a few minutes.

## System Requirements

### Minimum Requirements
- **Windows**: Windows 10 version 1809 or later (64-bit)
- **RAM**: 4GB minimum, 8GB recommended
- **Storage**: 500MB free disk space


## Download SnapRun

Download the latest version from the [GitHub Releases page](https://github.com/EV-OD/winscript/releases).

SnapRun provides **three installer options**:

### 1. **MSI Installer** (Recommended for Enterprise)
- **File**: `SnapRun_1.0.0_x64_en-US.msi` 
- **Best for**: Enterprise deployment, Group Policy, System Center
- **Features**: Windows Installer technology, rollback support

### 2. **NSIS Installer** (Recommended for End Users)
- **File**: `SnapRun_1.0.0_x64-setup.exe`
- **Best for**: Individual users, custom installation experience
- **Features**: Compact size, modern UI, flexible options

### 3. **Inno Setup Installer**
- **File**: `SnapRun_1.0.0_x64_inno_setup.exe`
- **Best for**: Alternative installer option
- **Features**: Traditional Windows installer experience

## Installation Steps

1. **Choose your installer** based on your needs:
   - **MSI**: For enterprise or managed environments
   - **NSIS**: For personal use (recommended for most users)  
   - **Inno Setup**: Alternative option

2. **Download** your chosen installer from the releases page

3. **Run the installer**:
   - Right-click and select "Run as administrator" (recommended)
   - Or double-click to run with standard permissions

4. **Follow the installation wizard**:
   - Accept the license agreement
   - Choose installation directory (default: `C:\Program Files\SnapRun`)
   - Select additional options:
     - Create desktop shortcut
     - Add to system PATH
     - Create Start Menu entries

5. **Complete installation**:
   - Click "Install" to begin the installation
   - Wait for the process to complete
   - Click "Finish" to exit the installer

6. **Launch SnapRun**:
   - From the desktop shortcut (if created)
   - From Start Menu → SnapRun
   - Or run `snaprun` from command line (if added to PATH)

## Build from Source (Advanced)

For developers who want to build SnapRun from source:

1. **Prerequisites**:
   - Install Rust (latest stable version)
   - Install Node.js and pnpm
   - Install Tauri CLI: `cargo install tauri-cli`

2. **Clone and build**:
   ```powershell
   git clone https://github.com/EV-OD/winscript.git
   cd winscript/tauri-app
   pnpm install
   pnpm tauri build
   ```

3. **Run build script** (optional):
   ```powershell
   .\build_production.bat
   ```

## Verification

To verify your installation is working correctly:

1. **Open SnapRun**
2. **Create a new script**
3. **Enter this test code**:
   ```rust
   let result = 2 + 3;
   md("2 + 3 = " + result);
   ```
4. **Run the script**
5. **Check the output** - you should see the printed messages

## What's Next?

Now that SnapRun is installed, you're ready to:

1. **[Quick Start Guide](/getting-started/quick-start)** - Write your first script
2. **[Function Reference](/ui-functions/ask_input)** - Explore available functions
---

*Ready to automate? Let's get scripting!*


