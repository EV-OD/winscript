# SnapRun Installation Guide

Complete installation instructions for all SnapRun installer packages. Choose the installation method that best fits your environment and requirements.

## 🎯 Quick Installation

### For Most Users (Recommended)

1. **Download** the Inno Setup installer: `SnapRun_1.0.1_x64_inno_setup.exe`
2. **Right-click** the installer and select "Run as administrator"
3. **Follow** the installation wizard
4. **Launch** SnapRun from Start Menu or Desktop
5. **Test** with a built-in script like "Hello World Test"

**That's it!** SnapRun is ready to use with all features enabled.

## 📦 Installation Options

SnapRun provides three professional installer packages:

| Installer | Size | Best For | Features |
|-----------|------|----------|----------|
| **Inno Setup** | 5.7 MB | Most users | Full-featured, advanced options |
| **MSI** | 4.6 MB | Enterprise | Group Policy, silent install |
| **NSIS** | 3.0 MB | Quick setup | Compact, fast installation |

### 🎯 Inno Setup Installer (Recommended)

**Filename**: `SnapRun_1.0.1_x64_inno_setup.exe`

**Best for**: Individual users, developers, power users

**Features**:
- ✅ Advanced installation options
- ✅ Custom directory selection
- ✅ Component selection
- ✅ File association configuration
- ✅ Environment variable setup
- ✅ Desktop and Start Menu shortcuts
- ✅ Comprehensive uninstaller

#### Installation Steps

1. **Download** the Inno Setup installer from [Releases](https://github.com/EV-OD/winscript/releases)

2. **Run as Administrator** (recommended):
   - Right-click `SnapRun_1.0.1_x64_inno_setup.exe`
   - Select "Run as administrator"
   - Click "Yes" if prompted by UAC

3. **Welcome Screen**:
   - Read the welcome message
   - Click "Next" to continue

4. **License Agreement**:
   - Review the MIT License
   - Click "I accept the agreement"
   - Click "Next"

5. **Installation Directory**:
   - Default: `C:\Program Files\SnapRun`
   - Change if desired (not recommended)
   - Ensure sufficient disk space (100MB+)
   - Click "Next"

6. **Select Components**:
   - ✅ **Main Application** (required)
   - ✅ **Built-in Scripts** (recommended)
   - ✅ **Documentation** (recommended)
   - ✅ **Desktop Icon** (optional)
   - Click "Next"

7. **Additional Tasks**:
   - ✅ **Create desktop icon** - For quick access
   - ✅ **Associate .rhai files** - Double-click to run scripts
   - ✅ **Set up environment variables** - Enable advanced features
   - ✅ **Create Start Menu shortcuts** - Access from Start Menu
   - Click "Next"

8. **Ready to Install**:
   - Review selected options
   - Click "Install" to begin installation

9. **Installation Progress**:
   - Wait for files to be copied and configured
   - May take 1-2 minutes depending on system speed

10. **Completion**:
    - ✅ **Launch SnapRun** - Start immediately
    - Click "Finish"

#### Post-Installation Verification

After installation, verify everything is working:

1. **Launch SnapRun**:
   - From Start Menu: Search "SnapRun"
   - From Desktop: Double-click SnapRun icon
   - From Run dialog: `Win+R`, type `SnapRun`

2. **Check Script Discovery**:
   - You should see 13 scripts (12 built-in + 1 sample)
   - Scripts should appear in the main interface

3. **Test Built-in Script**:
   - Select "Hello World Test"
   - Click "Run Script"
   - Verify output appears in the panel

4. **Test Global Shortcut**:
   - Press `Ctrl+Shift+J`
   - Application should show/hide

5. **Verify User Scripts Folder**:
   - Check `Documents\SnapRun\Scripts\` exists
   - Should contain `todo_list_creator.rhai`

### 🏢 MSI Installer (Enterprise)

**Filename**: `SnapRun_1.0.1_x64_en-US.msi`

**Best for**: Corporate environments, IT administrators, automated deployment

**Features**:
- ✅ Windows Installer technology
- ✅ Group Policy deployment
- ✅ Silent installation support
- ✅ MSI logging and rollback
- ✅ Corporate software management

#### Standard Installation

1. **Download** the MSI installer
2. **Double-click** `SnapRun_1.0.1_x64_en-US.msi`
3. **Follow** the Windows Installer wizard
4. **Complete** installation

#### Silent Installation

For automated deployment:

```cmd
# Basic silent installation
msiexec /i SnapRun_1.0.1_x64_en-US.msi /quiet

# Silent with installation log
msiexec /i SnapRun_1.0.1_x64_en-US.msi /quiet /l*v install.log

# Silent with custom installation directory
msiexec /i SnapRun_1.0.1_x64_en-US.msi /quiet INSTALLDIR="D:\Applications\SnapRun"

# Silent installation for all users
msiexec /i SnapRun_1.0.1_x64_en-US.msi /quiet ALLUSERS=1
```

#### Group Policy Deployment

1. **Copy MSI** to a network share accessible by all target computers
2. **Open Group Policy Management Console**
3. **Create or edit** a Group Policy Object (GPO)
4. **Navigate** to:
   - Computer Configuration → Policies → Software Settings → Software Installation
   - Or User Configuration → Policies → Software Settings → Software Installation
5. **Right-click** → New → Package
6. **Browse** to the MSI file location
7. **Select** deployment method:
   - **Assigned**: Installs automatically
   - **Published**: Available in Add/Remove Programs
8. **Configure** deployment options as needed
9. **Link** the GPO to appropriate organizational units

### 📦 NSIS Installer (Compact)

**Filename**: `SnapRun_1.0.1_x64-setup.exe`

**Best for**: Quick installations, minimal download size, testing

**Features**:
- ✅ Smallest download size (3.0 MB)
- ✅ Fast installation
- ✅ Standard Windows installer experience
- ✅ Essential features included

#### Installation Steps

1. **Download** `SnapRun_1.0.1_x64-setup.exe`
2. **Run** the installer (may require administrator rights)
3. **Follow** the simple installation wizard
4. **Complete** installation in under 30 seconds

## 🔧 Advanced Installation Options

### Custom Installation Directory

If you need to install SnapRun in a custom location:

#### Inno Setup
- Select custom directory during installation wizard
- Ensure you have write permissions to the target folder

#### MSI
```cmd
msiexec /i SnapRun_1.0.1_x64_en-US.msi INSTALLDIR="D:\CustomPath\SnapRun"
```

#### NSIS
- Directory selection available during installation

### Portable Installation

For portable use without installation:

1. **Extract** files from any installer using tools like:
   - Universal Extractor
   - 7-Zip (for some installers)
   - Inno Setup Unpacker

2. **Manual Setup**:
   - Copy `tauri-app.exe` to your desired location
   - Create `Scripts` folder in the same directory
   - Copy built-in scripts to `Scripts\built_in_scripts\`
   - Set environment variables manually if needed

3. **Limitations**:
   - No file associations
   - No Start Menu shortcuts
   - Manual environment variable setup
   - No automatic updates

### Network Installation

For installation over network or from shared drives:

1. **Copy installer** to network share
2. **Map network drive** or use UNC path
3. **Install** using standard methods:

```cmd
# From mapped drive
Z:\Software\SnapRun_1.0.1_x64_inno_setup.exe

# From UNC path
\\server\software\SnapRun_1.0.1_x64_inno_setup.exe

# Silent MSI over network
msiexec /i \\server\software\SnapRun_1.0.1_x64_en-US.msi /quiet
```

## 🌐 Environment Configuration

### Environment Variables

SnapRun uses these environment variables (set automatically during installation):

#### `SnapRun_HOME`
- **Purpose**: Points to SnapRun installation directory
- **Default**: `C:\Program Files\SnapRun`
- **Used by**: Built-in scripts, system integration

#### `SnapRun_SCRIPTS`
- **Purpose**: Points to user scripts directory
- **Default**: `C:\Users\{Username}\Documents\SnapRun\Scripts`
- **Used by**: Script discovery, custom script management

#### Manual Configuration

If environment variables aren't set automatically:

**Windows 10/11**:
1. Right-click "This PC" → Properties
2. Click "Advanced system settings"
3. Click "Environment Variables"
4. Under "User variables", click "New"
5. Add:
   - Variable name: `SnapRun_HOME`
   - Variable value: `C:\Program Files\SnapRun`
6. Repeat for `SnapRun_SCRIPTS`

**PowerShell**:
```powershell
# Set for current user
[Environment]::SetEnvironmentVariable("SnapRun_HOME", "C:\Program Files\SnapRun", "User")
[Environment]::SetEnvironmentVariable("SnapRun_SCRIPTS", "$env:USERPROFILE\Documents\SnapRun\Scripts", "User")

# Verify
$env:SnapRun_HOME
$env:SnapRun_SCRIPTS
```

**Command Prompt**:
```cmd
# Set for current session
set SnapRun_HOME=C:\Program Files\SnapRun
set SnapRun_SCRIPTS=%USERPROFILE%\Documents\SnapRun\Scripts

# Set permanently
setx SnapRun_HOME "C:\Program Files\SnapRun"
setx SnapRun_SCRIPTS "%USERPROFILE%\Documents\SnapRun\Scripts"
```

### File Associations

To associate `.rhai` files with SnapRun (if not done during installation):

**Registry Method** (as Administrator):
```reg
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\.rhai]
@="SnapRun.RhaiScript"

[HKEY_CLASSES_ROOT\SnapRun.RhaiScript]
@="Rhai Script"

[HKEY_CLASSES_ROOT\SnapRun.RhaiScript\DefaultIcon]
@="C:\\Program Files\\SnapRun\\SnapRun.exe,0"

[HKEY_CLASSES_ROOT\SnapRun.RhaiScript\shell\open\command]
@="\"C:\\Program Files\\SnapRun\\SnapRun.exe\" \"%1\""
```

**PowerShell Method**:
```powershell
# Associate .rhai files
$exePath = "C:\Program Files\SnapRun\SnapRun.exe"
cmd /c assoc .rhai=SnapRun.RhaiScript
cmd /c ftype SnapRun.RhaiScript="`"$exePath`" `"%1`""
```

## 🔄 Updates and Maintenance

### Checking for Updates

SnapRun doesn't include automatic updates. To update:

1. **Check** [GitHub Releases](https://github.com/EV-OD/winscript/releases) for newer versions
2. **Download** the latest installer
3. **Run** the new installer (will upgrade existing installation)
4. **Verify** scripts still work after update

### Backup Before Updates

Before updating, backup your custom scripts:

1. **Copy** your scripts folder:
   ```
   Documents\SnapRun\Scripts\ → Backup\SnapRun_Scripts_YYYY-MM-DD\
   ```

2. **Export** any custom environment settings

3. **Note** any custom configurations

### Maintenance Tasks

#### Clean Script Cache
If scripts aren't refreshing properly:
```cmd
# Clear temporary files
del /q "%TEMP%\SnapRun\*"

# Restart SnapRun
taskkill /f /im SnapRun.exe
start "" "C:\Program Files\SnapRun\SnapRun.exe"
```

#### Reset Configuration
To reset SnapRun to default settings:
1. Close SnapRun completely
2. Delete configuration files in `%APPDATA%\SnapRun\`
3. Restart SnapRun

## 🗑️ Uninstallation

### Standard Uninstall

#### Windows 10/11 Settings
1. Open **Settings** → **Apps**
2. Search for "SnapRun"
3. Click **SnapRun** → **Uninstall**
4. Confirm removal

#### Control Panel
1. Open **Control Panel** → **Programs and Features**
2. Find **SnapRun** in the list
3. Click **Uninstall**
4. Follow the uninstall wizard

#### MSI Uninstall
```cmd
# Find product code
wmic product where "Name='SnapRun'" get IdentifyingNumber

# Uninstall using product code
msiexec /x {PRODUCT-CODE} /quiet

# Or uninstall using MSI file
msiexec /x SnapRun_1.0.1_x64_en-US.msi /quiet
```

### Complete Removal

To completely remove all traces of SnapRun:

1. **Standard uninstall** (see above)

2. **Remove user data**:
   ```
   Documents\SnapRun\          (Your scripts - backup first!)
   %APPDATA%\SnapRun\          (Configuration files)
   %TEMP%\SnapRun\             (Temporary files)
   ```

3. **Remove environment variables**:
   ```cmd
   reg delete "HKCU\Environment" /v SnapRun_HOME /f
   reg delete "HKCU\Environment" /v SnapRun_SCRIPTS /f
   ```

4. **Remove file associations**:
   ```cmd
   reg delete "HKCR\.rhai" /f
   reg delete "HKCR\SnapRun.RhaiScript" /f
   ```

5. **Remove shortcuts**:
   - Desktop shortcuts
   - Start Menu shortcuts
   - Quick Launch shortcuts

## 🛠️ Troubleshooting Installation

### Common Installation Issues

#### "Administrator rights required"
- Right-click installer → "Run as administrator"
- Ensure you have local admin privileges
- Contact IT administrator if in corporate environment

#### "Windows protected your PC" warning
- Click "More info"
- Click "Run anyway"
- This is normal for new software without extensive digital signatures

#### Installation fails with error codes
- **Error 1603**: Generic installer failure
  - Check available disk space (need 100MB+)
  - Close running applications
  - Run as administrator
  - Try different installer type

- **Error 1618**: Another installation in progress
  - Wait for other installations to complete
  - Restart computer if necessary

#### "File in use" errors during installation
- Close all applications
- End SnapRun processes in Task Manager
- Restart computer and try again

#### Global shortcuts not working after installation
- Check for conflicts with other applications
- Try running as administrator once
- Restart SnapRun service

### Installation Verification

#### Quick Test Script
Create this test script to verify installation:

```rhai
// Installation Verification Test
print("=== SnapRun Installation Test ===");

// Test environment variables
let home = env("SnapRun_HOME");
let scripts = env("SnapRun_SCRIPTS");

print("Installation directory: " + home);
print("Scripts directory: " + scripts);

// Test file operations
if dir_exists(scripts) {
    print("✅ Scripts directory exists");
} else {
    print("❌ Scripts directory missing");
}

// Test system integration
let username = env("USERNAME");
let computer = env("COMPUTERNAME");
print("User: " + username + " on " + computer);

// Test process execution
let date = exec("powershell.exe Get-Date -Format 'yyyy-MM-dd HH:mm:ss'");
print("Current time: " + date);

print("✅ Installation verification complete!");
```

### Getting Help

If installation issues persist:

1. **Check system requirements**:
   - Windows 10 1809+ or Windows 11
   - x64 architecture
   - 100MB free disk space
   - Administrator privileges for installation

2. **Review installation logs**:
   - MSI logs: Use `/l*v install.log` parameter
   - Windows Event Viewer for system events

3. **Try alternative installer**:
   - If Inno Setup fails, try MSI
   - If MSI fails, try NSIS

4. **Report issues**:
   - GitHub Issues: [Report installation problems](https://github.com/EV-OD/winscript/issues)
   - Include Windows version, installer type, and error messages

---

**Next**: [User Guide](USER_GUIDE.md) | [Getting Started](GETTING_STARTED.md)
