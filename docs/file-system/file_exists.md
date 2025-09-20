# file_exists Function

## Description
Checks if a file or directory exists at the specified path.

## Syntax
```rhai
file_exists(path)
```

## Parameters
- `path` (string): Path to the file or directory to check

## Return Value
- Returns `bool` - `true` if the file/directory exists, `false` otherwise

## Examples

### Basic File Check
```rhai
if file_exists("config.json") {
    info("Configuration file found");
    let config = read_file("config.json");
} else {
    info("No configuration file, using defaults");
}
```

### Check Before Writing
```rhai
let data_file = "user_data.json";
if file_exists(data_file) {
    let confirm = ask_select(
        "File exists. Overwrite?", 
        ["Yes", "No"]
    );
    if confirm == "No" {
        info("Operation cancelled");
        return;
    }
}
write_file(data_file, new_data);
```

### Directory Existence
```rhai
let backup_dir = "backups";
if !file_exists(backup_dir) {
    create_dir(backup_dir);
    info("Created backup directory");
}
```

### Multiple File Check
```rhai
let required_files = ["config.json", "data.json", "templates/main.html"];
let missing_files = [];

for file_path in required_files {
    if !file_exists(file_path) {
        missing_files.push(file_path);
    }
}

if missing_files.len() > 0 {
    render_html("Missing Files", `
        <div style="color: orange; padding: 1rem; border: 1px solid orange; border-radius: 4px;">
            <strong>Warning:</strong> Missing required files:<br>
            <ul>
                ${missing_files.map(|f| "<li>" + f + "</li>").join("")}
            </ul>
        </div>
    `);
}
```

### Safe File Operations
```rhai
let file_path = "important_data.txt";

// Always check existence before reading
if file_exists(file_path) {
    let content = read_file(file_path);
    info("File content: " + content);
} else {
    render_html("File Not Found", `
        <p>The file <code>${file_path}</code> does not exist.</p>
        <p>Please check the path and try again.</p>
    `);
}
```

## Common Patterns

### Initialize Default Files
```rhai
let config_file = "app_config.json";
if !file_exists(config_file) {
    let default_config = `{
        "theme": "dark",
        "language": "en",
        "auto_save": true
    }`;
    write_file(config_file, default_config);
    info("Created default configuration");
}
```

### Backup System
```rhai
let data_file = "important_data.json";
if file_exists(data_file) {
    let timestamp_str = timestamp();
    let backup_name = "backup_" + timestamp_str + "_data.json";
    
    let original_content = read_file(data_file);
    write_file("backups/" + backup_name, original_content);
    info("Backup created: " + backup_name);
}
```

### Conditional Processing
```rhai
let files_to_process = ["file1.txt", "file2.txt", "file3.txt"];

for file_name in files_to_process {
    if file_exists(file_name) {
        let content = read_file(file_name);
        // Process the file
        info("Processed: " + file_name);
    } else {
        info("Skipped missing file: " + file_name);
    }
}
```

### Log File Management
```rhai
let log_dir = get_home_dir() + "/Documents/SnapRun/logs";
let log_file = log_dir + "/app.log";

if !file_exists(log_dir) {
    create_dir(log_dir);
}

if file_exists(log_file) {
    let log_content = read_file(log_file);
    if log_content.len() > 10000 {  // Rotate if too large
        write_file(log_file + ".old", log_content);
        write_file(log_file, "");
        info("Log rotated");
    }
}
```

## Notes
- Works for both files and directories
- Returns `false` for broken symlinks or inaccessible paths
- Path can be relative to script location or absolute
- Does not distinguish between files and directories (both return `true` if they exist)
- Use before any file operation to prevent errors

## Related Functions
- `read_file()` - Read file contents
- `write_file()` - Write content to file
- `create_dir()` - Create directories
- `get_home_dir()` - Get user's home directory
