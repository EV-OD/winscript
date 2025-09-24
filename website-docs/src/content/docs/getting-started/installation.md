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
- **.NET**: Framework 4.7.2 or later (usually pre-installed)

### Recommended Requirements
- **RAM**: 8GB or more for optimal performance
- **Storage**: 1GB for application and script storage

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

## First Launch Setup

When you first launch SnapRun, you'll be guided through a quick setup:

### 1. Welcome Screen
- Overview of SnapRun features
- Link to documentation

### 2. Script Directory Setup
- Choose where to store your scripts
- Option to import existing scripts
- Default location: `%USERPROFILE%\SnapRun\Scripts`

### 3. Environment Configuration
- Configure default settings
- Choose theme (Light/Dark/Auto)
- Set up keyboard shortcuts

### 4. Sample Scripts
- Option to install sample scripts
- Includes examples for each function category

## Verification

To verify your installation is working correctly:

1. **Open SnapRun**
2. **Create a new script**
3. **Enter this test code**:
   ```rust
   print("Hello, SnapRun!");
   let result = 2 + 3;
   print("2 + 3 = " + result);
   ```
4. **Run the script**
5. **Check the output** - you should see the printed messages

## Updating SnapRun

SnapRun includes automatic update checking:

- **Automatic**: Updates are checked on startup
- **Manual**: Help → Check for Updates
- **Settings**: Configure update preferences in Settings → General

## Troubleshooting

### Common Issues

#### **Windows: "Windows protected your PC" warning**
This is normal for new applications. Click "More info" → "Run anyway"

#### **macOS: "App can't be opened because it is from an unidentified developer"**
Go to System Preferences → Security & Privacy → Allow the app

#### **Linux: Permission denied**
Make sure the AppImage is executable: `chmod +x SnapRun.AppImage`

#### **Script directory not accessible**
Check folder permissions and ensure the directory exists

### Getting Help

If you encounter issues:

1. **Check** the [FAQ section](/getting-started/faq)
2. **Review** system requirements
3. **Update** to the latest version
4. **Report** bugs on our GitHub issues page

## What's Next?

Now that SnapRun is installed, you're ready to:

1. **[Quick Start Guide](/getting-started/quick-start)** - Write your first script
2. **[Function Reference](/ui-functions/ask_input)** - Explore available functions
3. **[Example Scripts]** - Learn from practical examples

---

*Ready to automate? Let's get scripting!*


