# SnapRun API Reference

Complete reference for all functions available in SnapRun Rhai scripts. Each function includes syntax, parameters, return values, and practical examples.

## 📁 File System Functions

### File Operations

#### `read_file(path: string) -> string`
Read the contents of a text file.

**Parameters:**
- `path`: Path to the file to read

**Returns:** File contents as string

**Example:**
```rhai
let content = read_file("C:\\temp\\notes.txt");
print("File content: " + content);
```

---

#### `write_file(path: string, content: string) -> bool`
Write content to a file (creates or overwrites).

**Parameters:**
- `path`: Path to the file to write
- `content`: Content to write to the file

**Returns:** `true` on success, throws error on failure

**Example:**
```rhai
let success = write_file("C:\\temp\\output.txt", "Hello, World!");
if success {
    print("File written successfully");
}
```

---

#### `file_exists(path: string) -> bool`
Check if a file exists.

**Parameters:**
- `path`: Path to check

**Returns:** `true` if file exists, `false` otherwise

**Example:**
```rhai
if file_exists("important.txt") {
    print("File found!");
} else {
    print("File not found!");
}
```

---

#### `copy_file(src: string, dest: string) -> bool`
Copy a file from source to destination.

**Parameters:**
- `src`: Source file path
- `dest`: Destination file path

**Returns:** `true` on success, throws error on failure

**Example:**
```rhai
copy_file("original.txt", "backup.txt");
print("File copied successfully");
```

---

#### `move_file(src: string, dest: string) -> bool`
Move/rename a file.

**Parameters:**
- `src`: Source file path
- `dest`: Destination file path

**Returns:** `true` on success, throws error on failure

**Example:**
```rhai
move_file("old_name.txt", "new_name.txt");
print("File moved successfully");
```

---

#### `delete_file(path: string) -> bool`
Delete a file.

**Parameters:**
- `path`: Path to the file to delete

**Returns:** `true` on success, throws error on failure

**Example:**
```rhai
if file_exists("temporary.txt") {
    delete_file("temporary.txt");
    print("File deleted");
}
```

### Directory Operations

#### `md(path: string) -> bool`
Create a directory (including parent directories).

**Parameters:**
- `path`: Directory path to create

**Returns:** `true` on success, throws error on failure

**Aliases:** `mkdir`, `create_dir`

**Example:**
```rhai
md("C:\\temp\\new_folder");
md("C:\\projects\\deep\\nested\\folders");  // Creates all parents
```

---

#### `cd(path: string) -> bool`
Change current working directory.

**Parameters:**
- `path`: Directory to change to

**Returns:** `true` on success, throws error on failure

**Example:**
```rhai
cd("C:\\Users\\Username\\Documents");
print("Changed to: " + pwd());
```

---

#### `pwd() -> string`
Get current working directory.

**Returns:** Current directory path

**Example:**
```rhai
let current = pwd();
print("Current directory: " + current);
```

---

#### `list_dir(pattern: string) -> array`
List files matching a pattern.

**Parameters:**
- `pattern`: File pattern (supports wildcards `*` and `?`)

**Returns:** Array of file paths

**Example:**
```rhai
// List all files in current directory
let all_files = list_dir("*");

// List only text files
let text_files = list_dir("*.txt");

// List files in specific directory
let docs = list_dir("C:\\Documents\\*.pdf");

for file in text_files {
    print("Found: " + file);
}
```

---

#### `dir_exists(path: string) -> bool`
Check if a directory exists.

**Parameters:**
- `path`: Directory path to check

**Returns:** `true` if directory exists, `false` otherwise

**Example:**
```rhai
if dir_exists("C:\\Important") {
    print("Directory found");
} else {
    md("C:\\Important");
    print("Directory created");
}
```

### Path Utilities

#### `path_filename(path: string) -> string`
Extract filename from a full path.

**Parameters:**
- `path`: Full file path

**Returns:** Filename with extension

**Example:**
```rhai
let filename = path_filename("C:\\Users\\John\\document.txt");
print(filename);  // Outputs: "document.txt"
```

---

#### `path_directory(path: string) -> string`
Extract directory from a full path.

**Parameters:**
- `path`: Full file path

**Returns:** Directory path

**Example:**
```rhai
let dir = path_directory("C:\\Users\\John\\document.txt");
print(dir);  // Outputs: "C:\\Users\\John"
```

---

#### `path_extension(path: string) -> string`
Extract file extension from a path.

**Parameters:**
- `path`: File path

**Returns:** File extension (including the dot)

**Example:**
```rhai
let ext = path_extension("document.txt");
print(ext);  // Outputs: ".txt"

// Check file type
if ext == ".pdf" {
    print("PDF document detected");
}
```

## ⚙️ Process Management Functions

### Command Execution

#### `exec(command: string) -> string`
Execute a command and return its output.

**Parameters:**
- `command`: Command to execute

**Returns:** Command output as string

**Example:**
```rhai
// Get current date
let date = exec("powershell.exe Get-Date");
print("Current date: " + date);

// List directory
let files = exec("dir C:\\temp");
print(files);

// Start an application
exec("notepad.exe");
```

---

#### `exec_capture(command: string) -> string`
Execute a command and capture all output.

**Parameters:**
- `command`: Command to execute

**Returns:** Complete command output

**Example:**
```rhai
let system_info = exec_capture("systeminfo");
print("System Information:");
print(system_info);

// Get disk usage
let disk_usage = exec_capture("powershell.exe Get-WmiObject -Class Win32_LogicalDisk");
print(disk_usage);
```

---

#### `start_process(executable: string) -> bool`
Start a process in the background.

**Parameters:**
- `executable`: Path to executable or command

**Returns:** `true` if process started successfully

**Example:**
```rhai
// Start applications
start_process("calc.exe");
start_process("C:\\Program Files\\Application\\app.exe");

// Start with arguments (use exec for this)
exec("powershell.exe -Command Get-Process");
```

## 🎨 User Interface Functions

### Dialog Functions

#### `show_message(message: string)`
Display an information message box.

**Parameters:**
- `message`: Message to display

**Example:**
```rhai
show_message("Task completed successfully!");
show_message("Processed 150 files in 2.5 minutes");
```

---

#### `show_warning(message: string)`
Display a warning message box.

**Parameters:**
- `message`: Warning message to display

**Example:**
```rhai
show_warning("This operation cannot be undone!");
show_warning("Low disk space detected");
```

---

#### `show_error(message: string)`
Display an error message box.

**Parameters:**
- `message`: Error message to display

**Example:**
```rhai
show_error("Failed to save configuration file");
show_error("Network connection timeout");
```

---

#### `confirm(message: string) -> bool`
Display a confirmation dialog.

**Parameters:**
- `message`: Question to ask the user

**Returns:** `true` if user clicked Yes/OK, `false` if No/Cancel

**Example:**
```rhai
let proceed = confirm("Delete all temporary files?");
if proceed {
    // Delete files
    print("Files deleted");
} else {
    print("Operation cancelled");
}
```

---

#### `input(prompt: string) -> string`
Display an input dialog to get text from user.

**Parameters:**
- `prompt`: Prompt message to display

**Returns:** Text entered by user, or empty string if cancelled

**Example:**
```rhai
let name = input("Enter your name:");
if name != "" {
    print("Hello, " + name + "!");
} else {
    print("No name entered");
}

let filename = input("Enter output filename:");
write_file(filename, "Generated content");
```

### Output Functions

#### `print(message: string)`
Print a message to the output panel.

**Parameters:**
- `message`: Message to print

**Example:**
```rhai
print("Script started");
print("Processing file: " + filename);
print("✅ Task completed");

// Print variables
let count = 42;
print("Processed " + count + " items");
```

---

#### `render_markdown(content: string)`
Display markdown content in a formatted view.

**Parameters:**
- `content`: Markdown content to render

**Example:**
```rhai
let report = `
# Daily Report
Date: 2024-01-15

## Summary
- **Files Processed**: 1,250
- **Errors**: 0
- **Time Taken**: 5.2 minutes

## Status
✅ **SUCCESS** - All operations completed successfully.

### Next Steps
1. Review processed files
2. Update configuration
3. Schedule next run
`;

render_markdown(report);
```

## 🌐 Environment Functions

### Environment Variables

#### `env(variable_name: string) -> string`
Get an environment variable value.

**Parameters:**
- `variable_name`: Name of environment variable

**Returns:** Environment variable value, or empty string if not found

**Common Variables:**
- `USERNAME` - Current user name
- `USERPROFILE` - User's profile directory
- `COMPUTERNAME` - Computer name
- `TEMP` - Temporary files directory
- `PATH` - System PATH variable
- `SnapRun_HOME` - SnapRun installation directory
- `SnapRun_SCRIPTS` - User scripts directory

**Example:**
```rhai
let username = env("USERNAME");
let home_dir = env("USERPROFILE");
let computer = env("COMPUTERNAME");

print("User: " + username);
print("Home: " + home_dir);
print("Computer: " + computer);

// Use in file paths
let documents = env("USERPROFILE") + "\\Documents";
let temp_file = env("TEMP") + "\\working.txt";
```

## 🔧 Utility Functions

### String Functions

#### `len(value) -> int`
Get the length of a string or array.

**Parameters:**
- `value`: String or array to measure

**Returns:** Length as integer

**Example:**
```rhai
let text = "Hello, World!";
let length = len(text);  // 13

let files = list_dir("*.txt");
let count = len(files);
print("Found " + count + " text files");
```

---

#### String Methods
Rhai provides built-in string methods:

**`.to_upper()` / `.to_lower()`**
```rhai
let text = "Hello World";
print(text.to_upper());  // "HELLO WORLD"
print(text.to_lower());  // "hello world"
```

**`.replace(old, new)`**
```rhai
let filename = "document_2024_01.txt";
let clean = filename.replace("_", "-");  // "document-2024-01.txt"
```

**`.split(delimiter)`**
```rhai
let csv_line = "John,Doe,25,Engineer";
let parts = csv_line.split(",");
for part in parts {
    print(part);  // John, Doe, 25, Engineer
}
```

**`.trim()`**
```rhai
let input = "  hello world  ";
let clean = input.trim();  // "hello world"
```

### Control Flow

#### `range(start: int, end: int) -> array`
Create a range of numbers.

**Parameters:**
- `start`: Starting number (inclusive)
- `end`: Ending number (exclusive)

**Returns:** Array of integers

**Example:**
```rhai
// Process items 1 through 10
for i in range(1, 11) {
    print("Processing item " + i);
}

// Create numbered files
for num in range(1, 6) {
    let filename = "file_" + num + ".txt";
    write_file(filename, "Content for file " + num);
}
```

### Type Checking

#### `type_of(value) -> string`
Get the type of a value.

**Parameters:**
- `value`: Value to check

**Returns:** Type name as string

**Example:**
```rhai
let text = "hello";
let number = 42;
let files = list_dir("*");

print(type_of(text));    // "string"
print(type_of(number));  // "i64"
print(type_of(files));   // "array"
```

## 🎯 Advanced Examples

### File Processing Pipeline
```rhai
// Process all log files in a directory
let log_dir = "C:\\Logs";
let processed_dir = log_dir + "\\Processed";
let archive_dir = log_dir + "\\Archive";

// Create processing directories
md(processed_dir);
md(archive_dir);

// Get all log files
let log_files = list_dir(log_dir + "\\*.log");
print("Found " + len(log_files) + " log files to process");

for log_file in log_files {
    let filename = path_filename(log_file);
    print("Processing: " + filename);
    
    // Read and analyze log
    let content = read_file(log_file);
    let lines = content.split("\n");
    let error_count = 0;
    
    for line in lines {
        if line.to_lower().contains("error") {
            error_count = error_count + 1;
        }
    }
    
    // Generate report
    let report = "Log Analysis Report\n";
    report = report + "File: " + filename + "\n";
    report = report + "Total Lines: " + len(lines) + "\n";
    report = report + "Errors Found: " + error_count + "\n";
    
    // Save report
    let report_file = processed_dir + "\\" + filename + ".report";
    write_file(report_file, report);
    
    // Archive original
    let archive_file = archive_dir + "\\" + filename;
    move_file(log_file, archive_file);
    
    print("✅ " + filename + " processed (" + error_count + " errors)");
}

print("🎉 All logs processed successfully!");
```

### System Maintenance Script
```rhai
// Comprehensive system maintenance
print("🔧 Starting system maintenance...");

// 1. Disk space check
let disk_info = exec_capture("powershell.exe Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID,Size,FreeSpace");
print("💾 Disk Space Status:");
print(disk_info);

// 2. Clean temporary files
let temp_dir = env("TEMP");
let temp_files = list_dir(temp_dir + "\\*");
let cleaned = 0;

for temp_file in temp_files {
    try {
        delete_file(temp_file);
        cleaned = cleaned + 1;
    } catch (error) {
        // Skip files in use
    }
}
print("🗑️ Cleaned " + cleaned + " temporary files");

// 3. Check system services
let services = exec_capture("powershell.exe Get-Service | Where-Object {$_.Status -eq 'Stopped' -and $_.StartType -eq 'Automatic'}");
if services != "" {
    show_warning("Some automatic services are stopped:\n" + services);
} else {
    print("✅ All automatic services are running");
}

// 4. Memory usage
let memory_info = exec_capture("powershell.exe Get-WmiObject -Class Win32_OperatingSystem | Select-Object TotalVisibleMemorySize,FreePhysicalMemory");
print("🧠 Memory Status:");
print(memory_info);

// 5. Generate maintenance report
let timestamp = exec_capture("powershell.exe Get-Date -Format 'yyyy-MM-dd HH:mm:ss'");
let report = "# System Maintenance Report\n";
report = report + "**Date**: " + timestamp + "\n\n";
report = report + "## Summary\n";
report = report + "- Temporary files cleaned: " + cleaned + "\n";
report = report + "- System services: Normal\n";
report = report + "- Disk space: See details above\n\n";
report = report + "## Recommendations\n";
report = report + "- Regular maintenance completed successfully\n";
report = report + "- Monitor disk space regularly\n";

render_markdown(report);
print("📊 Maintenance report generated");
print("✅ System maintenance completed!");
```

---

**Next**: [User Guide](USER_GUIDE.md) | [Examples](EXAMPLES.md)
