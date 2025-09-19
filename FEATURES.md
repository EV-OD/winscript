# SnapRun Features

SnapRun provides a comprehensive set of features designed to make Windows automation simple, powerful, and accessible. Here's everything you can do with SnapRun.

## 🎯 Core Features

### 📝 Rhai Scripting Engine
- **Modern Syntax**: Rust-like syntax that's easy to learn and read
- **Type Safety**: Dynamic typing with runtime type checking
- **Error Handling**: Comprehensive error reporting and debugging
- **Performance**: Native execution speed with Rust backend
- **Sandboxed**: Secure execution environment with controlled system access

### 🎨 Modern User Interface
- **Glass Effects**: Windows 10+ transparency with blur effects
- **Dark Theme**: Eye-friendly dark interface with accent colors
- **Responsive Design**: Adaptive layout that works on any screen size
- **Live Updates**: Real-time script output and progress feedback
- **Intuitive Controls**: Clean, modern interface inspired by Windows 11

### 🔧 System Integration
- **System Tray**: Runs in background with quick access from tray
- **Global Shortcuts**: 
  - `Ctrl+Shift+J` - Show/Hide application
  - `Ctrl+W` - Hide application (doesn't close)
- **Auto-Start**: Optional automatic startup with Windows
- **File Associations**: Double-click `.rhai` files to run them

## 📁 File System Operations

### File Management
```rhai
// Read file contents
let content = read_file("path/to/file.txt");

// Write file contents
write_file("output.txt", "Hello, World!");

// Check if file exists
if file_exists("important.txt") {
    print("File found!");
}

// Copy files
copy_file("source.txt", "destination.txt");

// Move files
move_file("old_location.txt", "new_location.txt");

// Delete files
delete_file("temporary.txt");
```

### Directory Operations
```rhai
// Create directories
md("new_folder");
md("path/to/nested/folders");

// List directory contents
let files = list_dir("C:/Users/Username/Documents");
for file in files {
    print(file);
}

// Change directory
cd("C:/Projects");

// Get current directory
let current = pwd();
print("Current directory: " + current);

// Check if directory exists
if dir_exists("important_folder") {
    print("Directory found!");
}
```

### Advanced File Operations
```rhai
// Get file information
let info = file_info("document.pdf");
print("Size: " + info.size + " bytes");
print("Modified: " + info.modified);

// Search for files
let results = find_files("*.txt", "C:/Documents");
for file in results {
    print("Found: " + file);
}

// Batch operations
let txt_files = list_dir("*.txt");
for file in txt_files {
    let backup_name = file + ".backup";
    copy_file(file, backup_name);
}
```

## ⚙️ Process Management

### Command Execution
```rhai
// Execute commands silently (no console window)
let result = exec("dir C:\\");
print(result);

// Run applications
exec("notepad.exe");
exec("calc.exe");

// Execute with arguments
exec("powershell.exe -Command Get-Date");
```

### Process Control
```rhai
// Start processes in background
start_process("important_service.exe");

// Execute and capture output
let output = exec_capture("systeminfo");
print("System Information:");
print(output);

// Run elevated commands (if needed)
exec_admin("net user newuser password /add");
```

### Batch Operations
```rhai
// Process multiple files
let files = list_dir("*.log");
for file in files {
    // Compress each log file
    exec("powershell.exe Compress-Archive -Path " + file + " -DestinationPath " + file + ".zip");
}
```

## 🎨 User Interface Functions

### Dialog Boxes
```rhai
// Show information messages
show_message("Task completed successfully!");

// Ask for confirmation
let confirmed = confirm("Do you want to proceed?");
if confirmed {
    print("User confirmed!");
}

// Get user input
let name = input("Enter your name:");
print("Hello, " + name + "!");

// Show warnings and errors
show_warning("This action cannot be undone!");
show_error("Failed to save file!");
```

### Markdown Rendering
```rhai
// Display formatted content
let markdown_content = `
# Task Report
- **Status**: Complete
- **Files Processed**: 150
- **Time Taken**: 2.5 minutes

## Summary
All files have been successfully organized.
`;

render_markdown(markdown_content);
```

### Progress Feedback
```rhai
// Show progress to user
print("Starting file organization...");

let files = list_dir("Downloads/*");
let total = len(files);

for i in range(0, total) {
    let file = files[i];
    let percent = (i * 100) / total;
    print("Progress: " + percent + "% - Processing " + file);
    
    // Your processing logic here
    process_file(file);
}

print("✅ Organization complete!");
```

## 🌐 Environment and System

### Environment Variables
```rhai
// Get environment variables
let home = env("USERPROFILE");
let path = env("PATH");

// Get SnapRun specific variables
let winscript_home = env("SnapRun_HOME");
let scripts_path = env("SnapRun_SCRIPTS");

// Use environment variables in paths
let documents = env("USERPROFILE") + "\\Documents";
```

### System Information
```rhai
// Get system details
let computer_name = env("COMPUTERNAME");
let username = env("USERNAME");
let os_version = exec_capture("ver");

print("System: " + computer_name);
print("User: " + username);
print("OS: " + os_version);
```

### Path Manipulation
```rhai
// Work with file paths
let full_path = "C:\\Users\\John\\Documents\\report.txt";
let filename = path_filename(full_path);      // "report.txt"
let directory = path_directory(full_path);    // "C:\\Users\\John\\Documents"
let extension = path_extension(full_path);    // ".txt"

// Build paths safely
let user_docs = env("USERPROFILE") + "\\Documents";
let target_file = user_docs + "\\output.txt";
```

## 🔄 Script Management

### Built-in Scripts
SnapRun includes 12 professional built-in scripts:

1. **Calculator** - Interactive calculator with basic operations
2. **File Organizer** - Organize files by extension
3. **File System Demo** - Demonstrate file operations
4. **Hello World Test** - Simple greeting and system info
5. **Log Manager** - Rotate and compress log files
6. **Markdown Demo** - Show markdown rendering capabilities
7. **Process Demo** - Demonstrate process execution
8. **Quick Md Test** - Quick markdown formatting test
9. **Simple Greeting** - Basic user interaction
10. **System Diagnostics** - System health and performance checks
11. **System Info** - Detailed system information display
12. **Test Home Dir** - Test environment variable access

### Custom Scripts
- **Location**: `Documents\SnapRun\Scripts\`
- **Format**: `.rhai` files with standard Rhai syntax
- **Auto-Discovery**: Scripts appear automatically when added
- **No Compilation**: Run directly from source code
- **Debugging**: Clear error messages and stack traces

### Script Organization
```rhai
// Use comments for documentation
// Script: File Backup Utility
// Author: Your Name
// Description: Backs up important files to external drive

// Configuration section
let source_folder = "C:\\Important\\Documents";
let backup_drive = "E:\\Backups";
let timestamp = exec_capture("powershell.exe Get-Date -Format 'yyyy-MM-dd'");

// Main script logic
print("Starting backup process...");
// ... your backup logic
```

## 🎛️ Advanced Features

### Error Handling
```rhai
// Try-catch style error handling
if file_exists("important.txt") {
    try {
        let content = read_file("important.txt");
        print("File content: " + content);
    } catch (error) {
        show_error("Failed to read file: " + error);
    }
} else {
    show_warning("File not found!");
}
```

### Loops and Iteration
```rhai
// Process multiple items
let extensions = ["*.txt", "*.doc", "*.pdf"];
for ext in extensions {
    let files = list_dir(ext);
    print("Found " + len(files) + " " + ext + " files");
}

// Numeric loops
for i in range(1, 11) {
    print("Processing item " + i + " of 10");
    // Your processing logic
}
```

### String Processing
```rhai
// String manipulation
let filename = "Document_2024_Final.txt";
let clean_name = filename.replace("_", " ");
let upper_name = clean_name.to_upper();
let parts = filename.split("_");

print("Original: " + filename);
print("Cleaned: " + clean_name);
print("Parts: " + parts);
```

### Conditional Logic
```rhai
// File type processing
let file = "document.pdf";
let ext = path_extension(file);

switch ext {
    ".txt" => print("Text file detected"),
    ".pdf" => print("PDF document detected"),
    ".jpg", ".png" => print("Image file detected"),
    _ => print("Unknown file type")
}
```

## 🔒 Security Features

### Sandboxed Execution
- **Limited System Access**: Scripts can only access approved functions
- **No Direct Win32 API**: Prevents dangerous system calls
- **Controlled File Access**: File operations are monitored and logged
- **Process Restrictions**: Only approved processes can be executed

### Safe Defaults
- **Silent Execution**: Processes run without visible console windows
- **Error Isolation**: Script errors don't crash the application
- **Resource Limits**: Memory and execution time limits prevent runaway scripts
- **Permission Checks**: File operations respect Windows permissions

### Audit Trail
- **Execution Logging**: All script executions are logged
- **Error Reporting**: Detailed error messages for debugging
- **Performance Monitoring**: Track script execution time and resource usage

## ⚡ Performance Features

### Native Speed
- **Rust Backend**: Native execution performance
- **Compiled Engine**: Rhai scripts are compiled to bytecode
- **Minimal Overhead**: Direct system integration without interpreters
- **Efficient Memory**: Automatic memory management with Rust

### Scalability
- **Large File Handling**: Process files of any size efficiently
- **Batch Operations**: Handle thousands of files without performance issues
- **Background Execution**: Run in system tray without impacting performance
- **Resource Management**: Automatic cleanup of temporary resources

## 🎨 Customization Options

### Interface Themes
- **Glass Effects**: Configurable transparency levels
- **Color Schemes**: Multiple accent color options
- **Font Settings**: Adjustable text size and font family
- **Layout Options**: Compact or expanded interface modes

### Keyboard Shortcuts
- **Global Shortcuts**: System-wide keyboard shortcuts
- **Customizable**: Modify shortcuts to match your workflow
- **Conflict Detection**: Automatic detection of shortcut conflicts
- **Context Sensitive**: Different shortcuts for different application states

### Configuration
- **Environment Variables**: Customize paths and settings
- **Script Directories**: Add multiple script locations
- **Startup Options**: Configure application behavior
- **Integration Settings**: Control Windows integration features

---

**Next**: [Getting Started](GETTING_STARTED.md) | [User Guide](USER_GUIDE.md)
