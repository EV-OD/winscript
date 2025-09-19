# SnapRun User Guide

Complete guide to using SnapRun effectively. Learn how to create, manage, and deploy powerful Windows automation scripts using the Rhai scripting language.

## 🎯 Overview

SnapRun transforms Windows automation from complex batch files and PowerShell scripts into simple, readable Rhai scripts. This guide covers everything from basic usage to advanced automation techniques.

## 🖥️ User Interface

### Main Application Window

The SnapRun interface is designed for simplicity and efficiency:

#### **Script Search Panel**
- **Search Box**: Type to filter scripts by name or description
- **Clear Button**: Reset search and show all scripts
- **Filter Options**: Show only built-in scripts, custom scripts, or all

#### **Script List**
- **Script Names**: Descriptive names for easy identification
- **Categories**: Built-in, Custom, or Legacy scripts
- **Quick Icons**: Visual indicators for different script types
- **Double-click**: Run selected script immediately

#### **Action Buttons**
- **Run Script**: Execute the currently selected script
- **Refresh**: Reload script list (auto-refreshes every 30 seconds)
- **Settings**: Access application preferences

#### **Output Panel**
- **Real-time Output**: Live display of script execution
- **Error Messages**: Clear error reporting with line numbers
- **Progress Indicators**: Visual progress for long-running operations
- **Copy Output**: Copy results to clipboard for sharing

### System Tray Integration

SnapRun operates seamlessly in the background:

#### **Tray Icon Features**
- **Single Click**: Show/hide main window
- **Right-click Menu**:
  - **Show SnapRun**: Bring application to foreground
  - **Run Quick Script**: Access frequently used scripts
  - **Settings**: Open preferences
  - **Quit**: Close application completely

#### **Background Operation**
- **Minimal Resource Usage**: Runs efficiently in background
- **Global Shortcuts**: Access from anywhere with keyboard shortcuts
- **Auto-start**: Optional automatic startup with Windows
- **Smart Notifications**: Non-intrusive status updates

## ⌨️ Keyboard Shortcuts

### Global Shortcuts (Work Anywhere)
- `Ctrl+Shift+J` - **Show/Hide Application**: Toggle SnapRun visibility
- `Ctrl+Alt+W` - **Quick Script Menu**: Access favorite scripts without opening main window

### Application Shortcuts (When Focused)
- `Ctrl+W` - **Hide to Tray**: Minimize application to system tray
- `Enter` - **Run Script**: Execute the currently selected script
- `F5` - **Refresh**: Reload script list manually
- `Ctrl+F` - **Focus Search**: Jump to search box
- `Escape` - **Clear/Cancel**: Clear search or cancel current operation
- `Up/Down Arrows` - **Navigate Scripts**: Move through script list
- `Ctrl+C` - **Copy Output**: Copy script output to clipboard

## 📁 Script Management

### Script Locations

#### **User Scripts Directory**
**Location**: `C:\Users\{YourUsername}\Documents\SnapRun\Scripts\`
- ✅ **Your custom scripts go here**
- ✅ **Full read/write access**
- ✅ **Survives application updates**
- ✅ **Easy to backup and share**
- ✅ **No administrator rights required**

#### **Built-in Scripts Directory**
**Location**: `C:\Program Files\SnapRun\Scripts\built_in_scripts\`
- ℹ️ **System-provided examples**
- ❌ **Read-only** (modifications will be overwritten)
- ✅ **Updated with application updates**
- ✅ **Safe to use as templates**

### Creating New Scripts

#### **Method 1: File Explorer**
1. Open File Explorer
2. Navigate to `Documents\SnapRun\Scripts\`
3. Right-click → New → Text Document
4. Rename to `your_script_name.rhai`
5. Edit with your preferred text editor
6. SnapRun automatically discovers new scripts

#### **Method 2: Copy and Modify**
1. Find a similar built-in script
2. Copy it to your scripts directory
3. Rename and modify as needed
4. Test and refine

#### **Method 3: Template Creation**
Create a template file for new scripts:

```rhai
// Script Name: [Your Script Name]
// Author: [Your Name]
// Description: [What this script does]
// Created: [Date]

// Configuration section
let config_param1 = "default_value";
let config_param2 = true;

// Main script logic
print("Starting [Script Name]...");

try {
    // Your automation code here
    
    print("✅ [Script Name] completed successfully!");
} catch (error) {
    show_error("Script failed: " + error);
}
```

### Script Organization

#### **Naming Conventions**
- Use descriptive names: `backup_documents.rhai` instead of `script1.rhai`
- Use underscores for spaces: `system_cleanup.rhai`
- Include version numbers for major changes: `backup_v2.rhai`
- Group related scripts: `maintenance_disk.rhai`, `maintenance_registry.rhai`

#### **Directory Structure**
You can create subdirectories in your scripts folder:

```
Documents\SnapRun\Scripts\
├── daily_tasks\
│   ├── backup_files.rhai
│   └── system_check.rhai
├── file_management\
│   ├── organize_downloads.rhai
│   └── cleanup_temp.rhai
└── utilities\
    ├── convert_images.rhai
    └── generate_report.rhai
```

#### **Script Documentation**
Always include header comments:

```rhai
/*
 * Script: File Organization Utility
 * Author: John Doe
 * Version: 1.2
 * Created: 2024-01-15
 * Updated: 2024-01-20
 * 
 * Description:
 *   Organizes files in the Downloads folder by moving them into
 *   categorized subfolders based on file extensions.
 * 
 * Requirements:
 *   - Read/write access to Downloads folder
 *   - At least 100MB free disk space
 * 
 * Usage:
 *   Run without parameters. Will prompt for confirmation before
 *   making changes to file system.
 */

// Configuration
let downloads_path = env("USERPROFILE") + "\\Downloads";
let create_date_folders = true;
let backup_moved_files = false;

// Script implementation...
```

## 🛠️ Writing Effective Scripts

### Best Practices

#### **1. Error Handling**
Always handle potential errors gracefully:

```rhai
// Good: Check before operating
if file_exists("important.txt") {
    try {
        let content = read_file("important.txt");
        // Process content
    } catch (error) {
        show_error("Failed to read file: " + error);
        return;
    }
} else {
    show_warning("File 'important.txt' not found!");
    return;
}
```

#### **2. User Feedback**
Provide clear progress updates:

```rhai
let files = list_dir("*.log");
let total = len(files);
print("Processing " + total + " log files...");

for i in range(0, total) {
    let file = files[i];
    let progress = ((i + 1) * 100) / total;
    print("Progress: " + progress + "% - Processing " + path_filename(file));
    
    // Process file
    process_log_file(file);
}

print("✅ All files processed successfully!");
```

#### **3. Configuration at Top**
Keep configurable values at the script beginning:

```rhai
// Configuration - Modify these values as needed
let source_folder = "C:\\Important\\Documents";
let backup_folder = "D:\\Backups\\Documents";
let include_subdirs = true;
let compress_backups = false;
let max_file_age_days = 30;

// Script implementation (don't modify below this line)
print("Starting backup process...");
// ... rest of script
```

#### **4. Validation and Safety**
Validate inputs and provide safety checks:

```rhai
// Validate paths exist
if !dir_exists(source_folder) {
    show_error("Source folder not found: " + source_folder);
    return;
}

if !dir_exists(backup_folder) {
    let create = confirm("Backup folder doesn't exist. Create it?");
    if create {
        md(backup_folder);
    } else {
        return;
    }
}

// Safety check for destructive operations
if delete_originals {
    let confirmed = confirm("WARNING: This will delete original files. Continue?");
    if !confirmed {
        print("Operation cancelled by user");
        return;
    }
}
```

### Common Patterns

#### **File Processing Pipeline**
```rhai
// 1. Discovery
let files = list_dir("*.txt");
print("Found " + len(files) + " files to process");

// 2. Validation
let valid_files = [];
for file in files {
    if file_exists(file) {
        valid_files.push(file);
    } else {
        print("Skipping invalid file: " + file);
    }
}

// 3. Processing
for file in valid_files {
    try {
        process_file(file);
        print("✅ Processed: " + path_filename(file));
    } catch (error) {
        print("❌ Failed: " + path_filename(file) + " - " + error);
    }
}

// 4. Summary
print("Processing complete. " + len(valid_files) + " files processed.");
```

#### **User Input and Validation**
```rhai
// Get user input with validation
let output_dir = "";
while output_dir == "" {
    output_dir = input("Enter output directory:");
    if output_dir == "" {
        show_warning("Output directory cannot be empty!");
        continue;
    }
    if !dir_exists(output_dir) {
        let create = confirm("Directory doesn't exist. Create '" + output_dir + "'?");
        if create {
            md(output_dir);
            break;
        } else {
            output_dir = "";  // Ask again
        }
    }
}

print("Using output directory: " + output_dir);
```

#### **Batch Operations with Progress**
```rhai
fn process_batch(files, operation_name) {
    let total = len(files);
    let processed = 0;
    let failed = 0;
    
    for i in range(0, total) {
        let file = files[i];
        let percent = (i * 100) / total;
        print("Progress: " + percent + "% - " + operation_name + ": " + path_filename(file));
        
        try {
            // Your processing logic here
            process_single_file(file);
            processed = processed + 1;
        } catch (error) {
            print("⚠️ Failed: " + path_filename(file) + " - " + error);
            failed = failed + 1;
        }
    }
    
    // Summary
    print("\n" + operation_name + " Summary:");
    print("✅ Processed: " + processed);
    print("❌ Failed: " + failed);
    print("📊 Total: " + total);
}

// Usage
let documents = list_dir("*.doc");
process_batch(documents, "Document Conversion");
```

## 🔧 Advanced Features

### Environment Integration

#### **Using Environment Variables**
```rhai
// Common Windows environment variables
let username = env("USERNAME");
let computer_name = env("COMPUTERNAME");
let user_profile = env("USERPROFILE");
let temp_dir = env("TEMP");
let windows_dir = env("WINDIR");

// SnapRun specific variables
let winscript_home = env("SnapRun_HOME");
let scripts_dir = env("SnapRun_SCRIPTS");

// Build paths safely
let documents = user_profile + "\\Documents";
let desktop = user_profile + "\\Desktop";
let downloads = user_profile + "\\Downloads";

print("Working as: " + username + " on " + computer_name);
```

#### **System Information Gathering**
```rhai
// Get detailed system information
let system_info = exec_capture("systeminfo");
let memory_info = exec_capture("powershell.exe Get-WmiObject -Class Win32_ComputerSystem | Select-Object TotalPhysicalMemory");
let disk_info = exec_capture("powershell.exe Get-WmiObject -Class Win32_LogicalDisk | Select-Object Size,FreeSpace,DeviceID");

// Create system report
let report = "# System Report\n";
report = report + "**User**: " + env("USERNAME") + "\n";
report = report + "**Computer**: " + env("COMPUTERNAME") + "\n";
report = report + "**Date**: " + exec_capture("date /t") + "\n\n";
report = report + "## Memory Information\n" + memory_info + "\n\n";
report = report + "## Disk Information\n" + disk_info + "\n";

render_markdown(report);
```

### Integration with Other Tools

#### **PowerShell Integration**
```rhai
// Execute PowerShell scripts
let ps_result = exec_capture("powershell.exe -Command \"Get-Process | Sort-Object CPU -Descending | Select-Object -First 10\"");
print("Top 10 CPU consuming processes:");
print(ps_result);

// Use PowerShell for advanced operations
let file_hash = exec_capture("powershell.exe Get-FileHash -Path '" + file_path + "' -Algorithm SHA256");
print("File hash: " + file_hash);

// PowerShell one-liners
let last_boot = exec_capture("powershell.exe (Get-CimInstance -ClassName win32_operatingsystem).lastbootuptime");
print("Last boot time: " + last_boot);
```

#### **Command Line Tools**
```rhai
// Use Windows built-in tools
let network_info = exec_capture("ipconfig /all");
let running_tasks = exec_capture("tasklist");
let disk_check = exec_capture("chkdsk C: /f /r");

// Third-party tools (if installed)
if file_exists("C:\\Program Files\\7-Zip\\7z.exe") {
    exec("\"C:\\Program Files\\7-Zip\\7z.exe\" a backup.zip *.txt");
    print("Files compressed using 7-Zip");
}
```

## 🎨 User Interface Customization

### Glass Effects and Themes

SnapRun automatically detects your Windows version and applies appropriate visual effects:

- **Windows 11**: Full glass effects with backdrop blur
- **Windows 10**: Transparency with accent colors
- **Older versions**: Fallback to solid colors

### Window Behavior

#### **Startup Modes**
- **Normal**: Opens main window on startup
- **Minimized**: Starts in system tray
- **Hidden**: Runs completely in background

#### **Always on Top**
Toggle always-on-top mode for the main window when you need SnapRun to stay visible while working with other applications.

### Script Output Customization

#### **Rich Text Output**
Use markdown for formatted output:

```rhai
let report = `
# File Processing Report

## Summary
- **Files Processed**: ${processed_count}
- **Total Size**: ${total_size} MB
- **Time Taken**: ${elapsed_time} seconds

## Status
${status_icon} **${status_text}**

### Details
${detail_list}
`;

render_markdown(report);
```

#### **Progress Visualization**
Create visual progress indicators:

```rhai
fn show_progress_bar(percent) {
    let bar_length = 20;
    let filled = (percent * bar_length) / 100;
    let bar = "";
    
    for i in range(0, bar_length) {
        if i < filled {
            bar = bar + "█";
        } else {
            bar = bar + "░";
        }
    }
    
    print("[" + bar + "] " + percent + "%");
}

// Usage
for i in range(0, 101, 5) {
    show_progress_bar(i);
    // Do some work...
}
```

## 🔒 Security and Safety

### Safe Scripting Practices

#### **Path Validation**
```rhai
fn safe_path(path) {
    // Ensure path is within safe boundaries
    let safe_dirs = [
        env("USERPROFILE"),
        env("TEMP"),
        env("SnapRun_SCRIPTS")
    ];
    
    for safe_dir in safe_dirs {
        if path.starts_with(safe_dir) {
            return true;
        }
    }
    
    show_warning("Path not in safe directory: " + path);
    return false;
}

// Use before file operations
if safe_path(target_file) {
    write_file(target_file, content);
} else {
    show_error("Operation blocked for security");
}
```

#### **Confirmation for Destructive Operations**
```rhai
fn safe_delete(files) {
    if len(files) == 0 {
        print("No files to delete");
        return;
    }
    
    let file_list = "";
    for file in files {
        file_list = file_list + "- " + path_filename(file) + "\n";
    }
    
    let message = "Delete " + len(files) + " files?\n\n" + file_list + "\nThis cannot be undone!";
    let confirmed = confirm(message);
    
    if confirmed {
        let deleted = 0;
        for file in files {
            try {
                delete_file(file);
                deleted = deleted + 1;
            } catch (error) {
                print("Failed to delete: " + path_filename(file));
            }
        }
        print("Deleted " + deleted + " of " + len(files) + " files");
    } else {
        print("Deletion cancelled");
    }
}
```

### Backup Strategies

#### **Create Backups Before Modifications**
```rhai
fn backup_before_modify(file_path) {
    if file_exists(file_path) {
        let timestamp = exec_capture("powershell.exe Get-Date -Format 'yyyyMMdd_HHmmss'");
        let backup_path = file_path + ".backup." + timestamp;
        copy_file(file_path, backup_path);
        print("Backup created: " + path_filename(backup_path));
        return backup_path;
    }
    return "";
}

// Usage
let backup = backup_before_modify("important.txt");
if backup != "" {
    // Proceed with modifications
    modify_file("important.txt");
    print("Original backed up to: " + backup);
}
```

## 🚀 Performance Optimization

### Efficient File Operations

#### **Batch Processing**
```rhai
// Instead of processing files one by one
// Bad:
for file in files {
    let content = read_file(file);
    let processed = process_content(content);
    write_file(file + ".processed", processed);
}

// Good: Batch similar operations
let all_content = [];
for file in files {
    all_content.push(read_file(file));
}

let processed_content = [];
for content in all_content {
    processed_content.push(process_content(content));
}

for i in range(0, len(files)) {
    write_file(files[i] + ".processed", processed_content[i]);
}
```

#### **Memory Management**
```rhai
// Process large files in chunks for memory efficiency
fn process_large_file(file_path) {
    if !file_exists(file_path) {
        return false;
    }
    
    let file_size = get_file_size(file_path);  // Hypothetical function
    if file_size > 100_000_000 {  // 100MB
        show_warning("Large file detected. Processing may take time.");
    }
    
    // For very large files, consider line-by-line processing
    // or external tool integration
    if file_size > 500_000_000 {  // 500MB
        return exec("powershell.exe Process-LargeFile -Path '" + file_path + "'");
    }
    
    return process_normally(file_path);
}
```

## 🛠️ Troubleshooting

### Common Issues and Solutions

#### **Scripts Not Appearing**
1. **Check file extension**: Must be `.rhai`
2. **Check location**: Must be in `Documents\SnapRun\Scripts\`
3. **Check permissions**: Ensure you can read the file
4. **Refresh**: Press F5 or restart SnapRun

#### **Permission Errors**
```rhai
// Test file permissions before operations
fn test_file_access(file_path) {
    try {
        if file_exists(file_path) {
            let test_content = read_file(file_path);
            print("✅ Read access: OK");
        }
        
        write_file(file_path + ".test", "test");
        delete_file(file_path + ".test");
        print("✅ Write access: OK");
        
        return true;
    } catch (error) {
        show_error("File access test failed: " + error);
        return false;
    }
}
```

#### **Long Running Scripts**
```rhai
// Provide feedback for long operations
fn long_operation() {
    print("Starting long operation... This may take several minutes.");
    
    let start_time = exec_capture("powershell.exe Get-Date");
    print("Started at: " + start_time);
    
    // Your long-running code here
    for i in range(1, 1000) {
        if i % 100 == 0 {
            print("Progress: " + (i / 10) + "% complete");
        }
        // Do work...
    }
    
    let end_time = exec_capture("powershell.exe Get-Date");
    print("Completed at: " + end_time);
    print("✅ Long operation finished!");
}
```

### Debug Techniques

#### **Adding Debug Output**
```rhai
let DEBUG = true;

fn debug_print(message) {
    if DEBUG {
        print("[DEBUG] " + message);
    }
}

// Usage throughout script
debug_print("Starting file processing");
debug_print("Found " + len(files) + " files");
debug_print("Processing file: " + current_file);
```

#### **Error Logging**
```rhai
let error_log = env("TEMP") + "\\winscript_errors.log";

fn log_error(operation, error_message) {
    let timestamp = exec_capture("powershell.exe Get-Date -Format 'yyyy-MM-dd HH:mm:ss'");
    let log_entry = timestamp + " - " + operation + ": " + error_message + "\n";
    
    // Append to log file
    let existing_log = "";
    if file_exists(error_log) {
        existing_log = read_file(error_log);
    }
    write_file(error_log, existing_log + log_entry);
    
    print("Error logged to: " + error_log);
}

// Usage
try {
    risky_operation();
} catch (error) {
    log_error("risky_operation", error);
    show_error("Operation failed. Check error log for details.");
}
```

---

**Next**: [API Reference](API_REFERENCE.md) | [Examples](EXAMPLES.md)
