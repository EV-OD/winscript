# SnapRun FAQ

Frequently asked questions about SnapRun. Find quick answers to common questions about installation, usage, scripting, and troubleshooting.

## 🚀 General Questions

### What is SnapRun?

SnapRun is a modern Windows automation platform that uses the Rhai scripting language to create powerful automation scripts. It combines the simplicity of Rhai with comprehensive system integration for file operations, process management, and user interfaces.

### Why choose SnapRun over PowerShell or batch files?

| Feature | SnapRun | PowerShell | Batch Files |
|---------|------------|------------|-------------|
| **Ease of Learning** | ✅ Simple Rust-like syntax | ⚠️ Complex cmdlet system | ✅ Simple but limited |
| **Safety** | ✅ Sandboxed execution | ❌ Full system access | ❌ Full system access |
| **Modern UI** | ✅ Glass effects, dark theme | ❌ Command line only | ❌ Command line only |
| **Cross-platform** | ⚠️ Windows focus | ✅ Multi-platform | ❌ Windows only |
| **Performance** | ✅ Native Rust backend | ⚠️ .NET overhead | ✅ Fast but limited |
| **User-friendly** | ✅ GUI with tray integration | ❌ CLI focused | ❌ CLI only |

### Is SnapRun free?

Yes! SnapRun is completely free and open-source under the MIT License. You can use it for personal, commercial, or educational purposes without any restrictions.

### What Windows versions are supported?

- **Minimum**: Windows 10 version 1809 (build 17763)
- **Recommended**: Windows 11 or Windows 10 21H2+
- **Architecture**: x64 (64-bit) only

## 📦 Installation Questions

### Which installer should I choose?

- **Inno Setup** (5.7 MB): Recommended for most users, full-featured
- **MSI** (4.6 MB): Best for enterprise/corporate environments
- **NSIS** (3.0 MB): Smallest size, quick installation

### Do I need administrator rights to install SnapRun?

- **Installation**: Administrator rights recommended but may not be required
- **Usage**: Regular user privileges sufficient for most operations
- **System tray**: Works without admin rights
- **File operations**: Limited to user-accessible locations without admin rights

### Can I install SnapRun without internet connection?

Yes! All installers are self-contained and don't require internet connectivity during installation. SnapRun also runs completely offline.

### How much disk space does SnapRun need?

- **Installation**: ~50 MB for program files
- **Scripts**: Minimal (a few KB per script)
- **Recommended**: 100 MB free space for comfortable operation

### Can I install multiple versions of SnapRun?

Not recommended. Installing a newer version will upgrade the existing installation. If you need multiple versions, use portable mode or different virtual machines.

## 🖥️ Usage Questions

### How do I create my first script?

1. Navigate to `Documents\SnapRun\Scripts\`
2. Create a file called `my_script.rhai`
3. Add this content:
```rhai
print("Hello, World!");
let user = env("USERNAME");
print("Welcome, " + user + "!");
```
4. Open SnapRun and your script will appear automatically

### Where should I put my scripts?

**User scripts**: `Documents\SnapRun\Scripts\` (recommended)
- ✅ No admin rights needed
- ✅ Easy to backup
- ✅ Survives updates

**Built-in scripts**: `C:\Program Files\SnapRun\Scripts\built_in_scripts\`
- ❌ Read-only
- ❌ Overwritten by updates
- ✅ Good as examples/templates

### How do I run a script?

**Method 1**: From SnapRun interface
- Open SnapRun
- Select your script
- Click "Run Script"

**Method 2**: Double-click (if file associations are set up)
- Navigate to your `.rhai` file in File Explorer
- Double-click to run

**Method 3**: System tray
- Right-click SnapRun tray icon
- Select "Quick Scripts" (if available)

### Can I schedule scripts to run automatically?

SnapRun doesn't include a built-in scheduler, but you can use:

**Windows Task Scheduler**:
1. Open Task Scheduler
2. Create new task
3. Set trigger (daily, weekly, etc.)
4. Set action to run: `"C:\Program Files\SnapRun\SnapRun.exe" "path\to\your\script.rhai"`

**PowerShell scheduled jobs**:
```powershell
Register-ScheduledJob -Name "MyScript" -ScriptBlock {
    & "C:\Program Files\SnapRun\SnapRun.exe" "C:\Users\YourName\Documents\SnapRun\Scripts\my_script.rhai"
} -Trigger (New-JobTrigger -Daily -At "9:00 AM")
```

## 🔧 Scripting Questions

### What programming language does SnapRun use?

SnapRun uses **Rhai**, a lightweight scripting language embedded in Rust applications. Rhai has Rust-like syntax but is designed to be simple and safe.

**Key features**:
- Familiar syntax (similar to Rust/JavaScript)
- Dynamic typing
- Safe execution (sandboxed)
- Excellent performance
- Easy to learn

### How is Rhai different from other scripting languages?

| Aspect | Rhai | Python | JavaScript |
|--------|------|--------|------------|
| **Syntax** | Rust-like | Python-like | C-like |
| **Typing** | Dynamic | Dynamic | Dynamic |
| **Safety** | Sandboxed | Full access | Browser-sandboxed |
| **Performance** | Very fast | Medium | Fast |
| **Learning curve** | Easy | Easy | Medium |

### What functions are available in scripts?

SnapRun provides over 20 built-in functions organized in categories:

**File Operations**: `read_file()`, `write_file()`, `copy_file()`, `delete_file()`, `file_exists()`
**Directory Operations**: `md()`, `cd()`, `pwd()`, `list_dir()`, `dir_exists()`
**Process Management**: `exec()`, `exec_capture()`, `start_process()`
**User Interface**: `print()`, `show_message()`, `confirm()`, `input()`, `render_markdown()`
**Environment**: `env()`
**Utilities**: `len()`, `path_filename()`, `path_directory()`, `path_extension()`

See [API Reference](API_REFERENCE.md) for complete details.

### Can I use loops and conditions in scripts?

Yes! Rhai supports all standard programming constructs:

**Loops**:
```rhai
// For loop
for i in range(1, 11) {
    print("Number: " + i);
}

// While loop
let count = 0;
while count < 5 {
    print("Count: " + count);
    count = count + 1;
}

// For each
let files = list_dir("*.txt");
for file in files {
    print("Processing: " + file);
}
```

**Conditions**:
```rhai
let file = "document.pdf";
if file_exists(file) {
    print("File found!");
} else {
    print("File not found!");
}

// Switch-like matching
let ext = path_extension(file);
switch ext {
    ".txt" => print("Text file"),
    ".pdf" => print("PDF document"),
    ".jpg", ".png" => print("Image file"),
    _ => print("Unknown type")
}
```

### How do I handle errors in scripts?

**Method 1**: Check before operating
```rhai
if file_exists("important.txt") {
    let content = read_file("important.txt");
    print(content);
} else {
    show_error("File not found!");
}
```

**Method 2**: Try-catch pattern
```rhai
try {
    let content = read_file("might_not_exist.txt");
    print("File content: " + content);
} catch (error) {
    show_error("Failed to read file: " + error);
}
```

**Method 3**: Validate inputs
```rhai
fn safe_delete(file_path) {
    if file_path == "" {
        show_error("File path cannot be empty");
        return false;
    }
    
    if !file_exists(file_path) {
        show_warning("File doesn't exist: " + file_path);
        return false;
    }
    
    let confirmed = confirm("Delete " + path_filename(file_path) + "?");
    if confirmed {
        delete_file(file_path);
        return true;
    }
    
    return false;
}
```

### Can I create functions in scripts?

Yes! Rhai supports custom functions:

```rhai
// Simple function
fn greet(name) {
    return "Hello, " + name + "!";
}

// Function with multiple parameters
fn calculate_area(width, height) {
    return width * height;
}

// Function with default behavior
fn safe_read_file(path, default_content) {
    if file_exists(path) {
        return read_file(path);
    } else {
        return default_content;
    }
}

// Usage
print(greet("Alice"));
let area = calculate_area(10, 5);
let config = safe_read_file("config.txt", "default_config");
```

### How do I work with text and strings?

Rhai provides rich string manipulation:

```rhai
let text = "Hello, World!";

// String methods
print(text.to_upper());           // "HELLO, WORLD!"
print(text.to_lower());           // "hello, world!"
print(text.len());                // 13
print(text.replace("World", "Rhai")); // "Hello, Rhai!"

// String splitting
let csv_line = "apple,banana,orange";
let fruits = csv_line.split(",");
for fruit in fruits {
    print("Fruit: " + fruit);
}

// String trimming
let input = "  spaces everywhere  ";
print(input.trim());              // "spaces everywhere"

// String checking
if text.contains("World") {
    print("Found 'World' in text");
}

if text.starts_with("Hello") {
    print("Text starts with 'Hello'");
}
```

## 🛠️ Technical Questions

### How much system resources does SnapRun use?

SnapRun is designed to be lightweight:
- **Memory**: ~10-20 MB when idle, ~50-100 MB when running scripts
- **CPU**: Minimal when idle, varies with script complexity
- **Disk**: ~50 MB installation, minimal ongoing disk usage
- **Network**: None (SnapRun works completely offline)

### Is SnapRun safe to run on my computer?

Yes! SnapRun is designed with security in mind:

**Sandboxed execution**: Scripts run in a controlled environment
**Limited system access**: Scripts can only use approved functions
**No network access**: Scripts cannot make network connections
**User permission model**: Respects Windows file permissions
**Code review**: SnapRun is open-source for transparency

**However**, like any automation tool, scripts can still:
- Modify files you have access to
- Execute approved system commands
- Show UI dialogs

Always review scripts before running them, especially from unknown sources.

### Can SnapRun damage my computer?

SnapRun itself is safe, but scripts can potentially:

**✅ Safe operations**:
- Read/write files in your user directories
- Execute standard Windows commands
- Show dialogs and messages
- Process text and data

**⚠️ Potentially risky operations**:
- Delete important files (if you have permission)
- Modify system files (if running as administrator)
- Execute external programs
- Bulk file operations

**🛡️ Safety measures**:
- Always backup important data
- Test scripts on sample data first
- Review scripts before running
- Don't run scripts from untrusted sources
- Use confirmation dialogs for destructive operations

### Does SnapRun collect any data or telemetry?

**No!** SnapRun does not collect, store, or transmit any user data, telemetry, analytics, or usage statistics. Everything runs locally on your computer.

### Can I use SnapRun on a company computer?

**Technical**: Yes, SnapRun should work on corporate computers
**Policy**: Check with your IT department first

**Considerations**:
- Some corporate antivirus may flag new executables
- Group Policy might restrict software installation
- Corporate firewalls won't affect SnapRun (no network usage)
- Scripts respect existing Windows permissions

### How do I update SnapRun?

SnapRun doesn't include automatic updates. To update:

1. Check [GitHub Releases](https://github.com/EV-OD/winscript/releases) for new versions
2. Download the latest installer
3. Run the installer (it will upgrade the existing installation)
4. Your custom scripts will be preserved

**Backup recommendation**: Before updating, backup your `Documents\SnapRun\Scripts\` folder.

## 🔍 Troubleshooting Questions

### Why don't I see my scripts in SnapRun?

**Check these common issues**:

1. **File extension**: Must be `.rhai`, not `.txt` or `.rhai.txt`
2. **Location**: Must be in `Documents\SnapRun\Scripts\`
3. **Permissions**: Ensure you can read the file
4. **Refresh**: Press F5 or restart SnapRun
5. **Hidden files**: Check if file is hidden in File Explorer

### Why do I get "File not found" errors?

**Common causes and solutions**:

1. **Incorrect path**: Use full paths or environment variables
   ```rhai
   // Wrong
   let content = read_file("myfile.txt");
   
   // Right
   let content = read_file(env("USERPROFILE") + "\\Documents\\myfile.txt");
   ```

2. **Backslash escaping**: Use double backslashes or forward slashes
   ```rhai
   // Wrong
   let path = "C:\Users\Name\file.txt";
   
   // Right
   let path = "C:\\Users\\Name\\file.txt";
   // or
   let path = "C:/Users/Name/file.txt";
   ```

3. **Permissions**: Ensure you have access to the file/folder
4. **File existence**: Check if file actually exists at that location

### Why don't global shortcuts work?

**Possible causes**:

1. **Conflict**: Another application is using `Ctrl+Shift+J`
2. **Admin rights**: Try running SnapRun as administrator once
3. **Windows version**: Some older Windows versions may have issues
4. **Restart**: Restart SnapRun to re-register shortcuts

**Alternative**: Use system tray right-click menu instead

### Why do I see "Permission denied" errors?

**Solutions by scenario**:

1. **System files**: Don't try to modify files in `C:\Windows\` or `C:\Program Files\`
2. **Other users' files**: You can only access your own user directory
3. **Administrator needed**: Some operations require running as administrator
4. **Files in use**: Close applications that might be using the files

### How do I report bugs or request features?

**For bugs**:
1. Visit [GitHub Issues](https://github.com/EV-OD/winscript/issues)
2. Search existing issues first
3. Create new issue with:
   - Clear description of the problem
   - Steps to reproduce
   - Your Windows version
   - SnapRun version
   - Script code (if applicable)

**For feature requests**:
1. Check [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) first
2. Create detailed feature request
3. Explain use case and benefits

### Can I contribute to SnapRun?

Yes! SnapRun is open-source and welcomes contributions:

**Ways to contribute**:
- Report bugs and issues
- Suggest features and improvements
- Create example scripts
- Improve documentation
- Submit code contributions
- Help other users in discussions

**Getting started**:
1. Fork the repository on GitHub
2. Read the [Contributing Guide](CONTRIBUTING.md)
3. Make your improvements
4. Submit a pull request

### Where can I find more help?

**Documentation**:
- [User Guide](USER_GUIDE.md) - Complete usage instructions
- [API Reference](API_REFERENCE.md) - All available functions
- [Getting Started](GETTING_STARTED.md) - Quick start guide

**Community**:
- [GitHub Issues](https://github.com/EV-OD/winscript/issues) - Bug reports and questions
- [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) - General discussions
- Built-in scripts - Great examples of what's possible

**Learning Rhai**:
- [Official Rhai Book](https://rhai.rs/book/) - Comprehensive Rhai documentation
- Built-in scripts in SnapRun - Practical examples
- [Rhai Playground](https://rhai.rs/playground/) - Online Rhai testing

---

**Still have questions?** Check out our [GitHub Discussions](https://github.com/EV-OD/winscript/discussions) or create an [issue](https://github.com/EV-OD/winscript/issues) for bug reports.
