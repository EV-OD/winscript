# Getting Started with SnapRun

Welcome to SnapRun! This guide will help you install, configure, and start using SnapRun for Windows automation. Within minutes, you'll be running your first automation scripts.

## 🚀 Quick Start

### Step 1: Download and Install
1. **Download** your preferred installer from the [Releases](https://github.com/EV-OD/winscript/releases) page
2. **Run** the installer as administrator (if required)
3. **Follow** the installation wizard
4. **Launch** SnapRun from Start Menu or Desktop

### Step 2: First Run
1. **Open SnapRun** - You'll see the script search interface
2. **Try a built-in script** - Click "Hello World Test" to see it in action
3. **Check your system tray** - SnapRun is now running in the background
4. **Use the shortcut** - Press `Ctrl+Shift+J` to show/hide the application

### Step 3: Create Your First Script
1. **Navigate** to `Documents\SnapRun\Scripts\`
2. **Create** a new file called `my_first_script.rhai`
3. **Add** this content:
```rhai
print("Hello from my first script!");
let username = env("USERNAME");
print("Welcome, " + username + "!");
```
4. **Refresh** SnapRun - Your script appears automatically!
5. **Run** your script and see the output

## 📦 Installation Options

SnapRun provides multiple installation methods to suit your needs:

### 🎯 Recommended: Inno Setup Installer
**File**: `SnapRun_1.0.1_x64_inno_setup.exe` (~5.7 MB)
- ✅ **Feature-rich** installer with advanced options
- ✅ **Complete setup** including environment variables
- ✅ **File associations** for `.rhai` files
- ✅ **Uninstaller** support
- ✅ **Best for most users**

**Installation Steps**:
1. Download the Inno Setup installer
2. Right-click and "Run as administrator" (recommended)
3. Follow the installation wizard
4. Choose installation options:
   - ✅ **Desktop Icon** - For easy access
   - ✅ **Environment Variables** - For advanced features
   - ✅ **File Associations** - To open `.rhai` files directly
   - ✅ **Start Menu Shortcuts** - For convenient access

### 🏢 Enterprise: MSI Installer
**File**: `SnapRun_1.0.1_x64_en-US.msi` (~4.6 MB)
- ✅ **Windows Installer** technology
- ✅ **Group Policy** deployment support
- ✅ **Corporate environments**
- ✅ **Silent installation** support

**Installation Steps**:
```cmd
# Standard installation
msiexec /i SnapRun_1.0.1_x64_en-US.msi

# Silent installation
msiexec /i SnapRun_1.0.1_x64_en-US.msi /quiet
```

### 📦 Compact: NSIS Installer
**File**: `SnapRun_1.0.1_x64-setup.exe` (~3.0 MB)
- ✅ **Smallest installer** size
- ✅ **Quick installation**
- ✅ **Standard Windows installer** experience

**Installation Steps**:
1. Download the NSIS installer
2. Double-click to run
3. Follow the simple installation wizard

### 💼 Portable: Standalone Executable
**File**: `tauri-app.exe` (Requires full build)
- ✅ **No installation** required
- ✅ **Portable** - run from any location
- ✅ **Testing and development**
- ❌ **Manual setup** of environment variables
- ❌ **No file associations**

## 🔧 Initial Configuration

### After Installation

1. **Launch SnapRun**
   - From Start Menu: `SnapRun`
   - From Desktop: Double-click the SnapRun icon
   - From System Tray: Right-click tray icon → "Show SnapRun"

2. **Verify Installation**
   - You should see 13 scripts available (12 built-in + 1 sample)
   - Try running "System Info" to verify system access
   - Check that your custom scripts folder exists: `Documents\SnapRun\Scripts\`

3. **Test Global Shortcuts**
   - Press `Ctrl+Shift+J` - Application should show/hide
   - Press `Ctrl+W` while app is focused - Application should hide to tray
   - If shortcuts don't work, check for conflicts with other applications

### Environment Variables (Set Automatically)

After installation, these environment variables are configured:

```env
SnapRun_HOME=C:\Program Files\SnapRun
SnapRun_SCRIPTS=C:\Users\{YourUsername}\Documents\SnapRun\Scripts
```

**To verify**: Open Command Prompt and type:
```cmd
echo %SnapRun_HOME%
echo %SnapRun_SCRIPTS%
```

## 📝 Your First Scripts

### Example 1: System Information
Create `Documents\SnapRun\Scripts\system_check.rhai`:

```rhai
// System Information Script
print("=== System Information ===");

let computer = env("COMPUTERNAME");
let username = env("USERNAME");
let userprofile = env("USERPROFILE");

print("Computer: " + computer);
print("User: " + username);
print("Profile: " + userprofile);

print("\n=== Disk Space ===");
let disk_info = exec_capture("powershell.exe Get-WmiObject -Class Win32_LogicalDisk | Select-Object Size,FreeSpace,DeviceID");
print(disk_info);

print("\n=== Current Time ===");
let current_time = exec_capture("powershell.exe Get-Date");
print(current_time);
```

### Example 2: File Organization
Create `Documents\SnapRun\Scripts\organize_downloads.rhai`:

```rhai
// Organize Downloads Folder
let downloads = env("USERPROFILE") + "\\Downloads";
print("Organizing: " + downloads);

// Create organization folders
md(downloads + "\\Images");
md(downloads + "\\Documents");
md(downloads + "\\Archives");

// Move files by extension
let files = list_dir(downloads + "\\*.*");
for file in files {
    if file_exists(file) {
        let ext = path_extension(file).to_lower();
        let filename = path_filename(file);
        
        if ext == ".jpg" || ext == ".png" || ext == ".gif" {
            let dest = downloads + "\\Images\\" + filename;
            move_file(file, dest);
            print("Moved image: " + filename);
        } else if ext == ".pdf" || ext == ".doc" || ext == ".txt" {
            let dest = downloads + "\\Documents\\" + filename;
            move_file(file, dest);
            print("Moved document: " + filename);
        } else if ext == ".zip" || ext == ".rar" || ext == ".7z" {
            let dest = downloads + "\\Archives\\" + filename;
            move_file(file, dest);
            print("Moved archive: " + filename);
        }
    }
}

print("✅ Downloads organized!");
```

### Example 3: System Maintenance
Create `Documents\SnapRun\Scripts\system_cleanup.rhai`:

```rhai
// System Cleanup Script
print("🧹 Starting system cleanup...");

let temp_folder = env("TEMP");
print("Cleaning temporary files from: " + temp_folder);

// Get temp files
let temp_files = list_dir(temp_folder + "\\*.*");
let cleaned_count = 0;

for file in temp_files {
    try {
        if file_exists(file) {
            delete_file(file);
            cleaned_count = cleaned_count + 1;
        }
    } catch (error) {
        // Skip files that can't be deleted (in use)
    }
}

print("🗑️ Cleaned " + cleaned_count + " temporary files");

// Clear recycle bin (optional)
let confirm_recycle = confirm("Clear Recycle Bin?");
if confirm_recycle {
    exec("powershell.exe Clear-RecycleBin -Force");
    print("🗑️ Recycle Bin cleared");
}

print("✅ System cleanup complete!");
```

## 🎮 User Interface Overview

### Main Interface
- **Script Search**: Find and filter your scripts
- **Script List**: All available scripts (built-in and custom)
- **Run Button**: Execute the selected script
- **Output Panel**: View script results and messages

### System Tray Integration
- **Tray Icon**: SnapRun runs quietly in your system tray
- **Right-click Menu**:
  - **Show SnapRun**: Bring application to foreground
  - **Hide SnapRun**: Send application to background
  - **Quit**: Close application completely

### Keyboard Shortcuts
- `Ctrl+Shift+J`: Show/Hide application (global shortcut)
- `Ctrl+W`: Hide application to tray (when focused)
- `Enter`: Run selected script
- `Escape`: Clear search or hide application

## 🔧 Customization

### Script Folders
You can add additional script directories by setting the `SnapRun_SCRIPTS` environment variable:

```cmd
# Add multiple script locations (separated by semicolon)
set SnapRun_SCRIPTS=C:\Users\YourName\Documents\SnapRun\Scripts;D:\MyScripts;E:\SharedScripts
```

### File Associations
After installation, `.rhai` files are associated with SnapRun:
- **Double-click** any `.rhai` file to run it
- **Right-click** → "Edit" to open in your default text editor
- **Right-click** → "Open with" → "SnapRun" to run

### Startup Options
To run SnapRun automatically at Windows startup:
1. Press `Win+R`, type `shell:startup`
2. Copy the SnapRun shortcut to this folder
3. SnapRun will start with Windows and minimize to tray

## 🛠️ Troubleshooting

### Common Issues

#### Scripts Not Appearing
- **Check location**: Scripts must be in `Documents\SnapRun\Scripts\`
- **Check extension**: Files must have `.rhai` extension
- **Refresh**: Restart SnapRun or wait a few seconds for auto-refresh

#### Global Shortcuts Not Working
- **Conflict check**: Another application may be using `Ctrl+Shift+J`
- **Admin rights**: Try running as administrator once
- **Restart**: Restart SnapRun to re-register shortcuts

#### Permission Errors
- **File access**: Ensure you have read/write permissions for target files
- **System operations**: Some operations may require administrator privileges
- **Antivirus**: Check if antivirus is blocking script execution

#### Glass Effects Not Showing
- **Windows version**: Requires Windows 10 version 1809 or later
- **DWM service**: Ensure Desktop Window Manager service is running
- **Hardware**: Some virtual machines may not support transparency

### Getting Help

1. **Check Documentation**: Review the [User Guide](USER_GUIDE.md) and [FAQ](FAQ.md)
2. **Example Scripts**: Study the built-in scripts for patterns and techniques
3. **Error Messages**: Read error messages carefully - they usually explain the issue
4. **GitHub Issues**: Report bugs at [GitHub Issues](https://github.com/EV-OD/winscript/issues)

## 📚 What's Next?

Now that SnapRun is installed and configured:

1. **Explore Built-in Scripts**: Try all 12 built-in scripts to see what's possible
2. **Read the User Guide**: Learn advanced features and techniques
3. **Check API Reference**: Discover all available functions
4. **Join the Community**: Share your scripts and get help from other users
5. **Build Complex Automations**: Combine functions to create powerful workflows

## 🎯 Quick Tips

- **Start Simple**: Begin with basic file operations and work up to complex automation
- **Use Comments**: Document your scripts for future reference
- **Test Safely**: Always test scripts on sample data first
- **Backup Important Files**: Create backups before running destructive operations
- **Share Scripts**: Help others by sharing useful automation scripts

---

**Next**: [User Guide](USER_GUIDE.md) | [Script Reference](SCRIPT_REFERENCE.md)
