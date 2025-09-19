# WinScript2 - Production Deployment Guide

## Overview
WinScript2 is a Windows automation platform built with Tauri, featuring a Rhai scripting engine and modern React UI with glass effects.

## Features ✨
- **System Tray Integration** - Runs in background with tray icon
- **Glass UI Effects** - Modern Windows glass effect styling
- **Rhai Scripting Engine** - Powerful embedded scripting
- **File System Operations** - Complete file/directory management
- **Process Execution** - Command spawning and shell integration
- **Markdown Rendering** - Live markdown preview
- **Environment Variables** - Configurable script locations

## Installation 📦

### Method 1: Using Installer (Recommended)
1. Download the installer:
   - **MSI Installer**: `WinScript2-1.0.0.msi` (Windows Installer)
   - **NSIS Installer**: `WinScript2-1.0.0.exe` (Custom installer)

2. Run the installer and follow the setup wizard

3. Run the setup script:
   ```cmd
   setup_winscript2.bat
   ```

### Method 2: Portable Installation
1. Download `winscript2.exe` from the release
2. Create a folder for WinScript2
3. Run `setup_winscript2.bat` for configuration

## Configuration 🔧

### Environment Variables
WinScript2 supports the following environment variables:

- **WINSCRIPT2_HOME**: Main application directory
  ```
  Default: %USERPROFILE%\Documents\WinScript2
  ```

- **WINSCRIPT2_SCRIPTS**: Scripts directory
  ```
  Default: %WINSCRIPT2_HOME%\Scripts
  ```

### Directory Structure
```
WinScript2/
├── Scripts/
│   ├── built_in_scripts/     # System-provided scripts
│   │   ├── calculator.rhai
│   │   ├── file_organizer.rhai
│   │   ├── system_info.rhai
│   │   └── ...
│   └── custom_scripts/       # User-created scripts
│       └── welcome.rhai
```

## Usage 🚀

### Starting WinScript2
- **Desktop Shortcut**: Double-click WinScript2 icon
- **Start Menu**: Search for "WinScript2"
- **Command Line**: Run `winscript2.exe`
- **System Tray**: Look for WinScript2 icon in system tray

### System Tray Features
- **Left Click**: Show/Hide main window
- **Right Click**: Context menu
  - Show Window
  - Hide Window  
  - Quit

### Global Shortcuts
- **Ctrl+Shift+J**: Show WinScript2 window from system tray
- **Ctrl+W**: Hide WinScript2 window to system tray

## Script Development 📝

### Built-in Functions
WinScript2 provides extensive APIs for script development:

#### File System Operations
```javascript
// File operations
let content = read_file("path/to/file.txt");
write_file("path/to/file.txt", "content");
copy_file("source.txt", "destination.txt");
delete_file("path/to/file.txt");

// Directory operations
create_dir("path/to/directory");
list_dir("path/to/directory");
delete_dir("path/to/directory");

// Path operations
let absolute = get_absolute_path("relative/path");
let exists = file_exists("path/to/file");
```

#### Process Execution
```javascript
// Run commands
let result = run_command("dir", "C:\\");
let output = run_shell_command("echo Hello World");
let process = start_process("notepad.exe");
```

#### Markdown Rendering
```javascript
// Display markdown in UI
md("# Hello World\nThis is **bold** text.");
render_markdown("path/to/file.md");
```

### Creating Custom Scripts
1. Create a `.rhai` file in `%WINSCRIPT2_SCRIPTS%\custom_scripts\`
2. Use WinScript2 APIs and standard Rhai syntax
3. Scripts will automatically appear in the UI

### Example Script
```javascript
// Welcome script example
print("Welcome to WinScript2!");

// Get system information
let home = get_home_dir();
let scripts_dir = get_script_dir();

// Display information
print("Home directory: " + home);
print("Scripts directory: " + scripts_dir);

// Create a demo file
let demo_file = scripts_dir + "/demo.txt";
write_file(demo_file, "This is a demo file created by WinScript2!");
print("Created demo file: " + demo_file);
```

## Building from Source 🔨

### Prerequisites
- **Node.js 18+** with pnpm
- **Rust 1.70+** with Cargo
- **Windows 10+** with Visual Studio Build Tools

### Build Steps
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd tauri-app
   ```

2. Install dependencies:
   ```bash
   pnpm install
   ```

3. Run development build:
   ```bash
   pnpm tauri dev
   ```

4. Create production build:
   ```bash
   ./build_production.bat
   ```

### Build Output
- **Executable**: `src-tauri/target/release/winscript2.exe`
- **MSI Installer**: `src-tauri/target/release/bundle/msi/`
- **NSIS Installer**: `src-tauri/target/release/bundle/nsis/`

## Troubleshooting 🔧

### Common Issues

1. **Scripts not loading**
   - Check environment variables are set correctly
   - Verify script directory exists and has proper permissions
   - Check script syntax with Rhai validator

2. **System tray not visible**
   - Check Windows notification area settings
   - Ensure application has proper permissions
   - Try restarting the application

3. **Glass effects not working**
   - Requires Windows 10+ with DWM enabled
   - Check Windows transparency settings
   - May not work in virtual machines

### Log Files
WinScript2 logs are available in:
- **Console Output**: When running from command line
- **Debug Mode**: Use `pnpm tauri dev` for detailed logs

### Support
For issues and feature requests:
1. Check existing issues in the repository
2. Create a new issue with detailed information
3. Include system information and error messages

## License 📄
This project is licensed under the MIT License - see the LICENSE file for details.

## Version History 📅
- **v1.0.0** - Initial production release
  - System tray integration
  - Glass UI effects
  - Complete Rhai scripting engine
  - File system and process APIs
  - Markdown rendering
  - Environment variable support
  - MSI/NSIS installers
