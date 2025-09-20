# read_file Function

## Description
Reads the entire contents of a file as a string.

## Syntax
```rhai
read_file(file_path)
```

## Parameters
- `file_path` (string): Path to the file to read

## Return Value
- Returns a `string` containing the file contents
- Throws an error if the file doesn't exist or can't be read

## Examples

### Basic File Reading
```rhai
try {
    let content = read_file("data.txt");
    info("File content: " + content);
} catch (error) {
    info("Error reading file: " + error);
}
```

### Reading Configuration
```rhai
let config_path = "config/settings.json";
if file_exists(config_path) {
    let config_json = read_file(config_path);
    let config = parse_json(config_json);
    info("Loaded configuration");
} else {
    info("Configuration file not found");
}
```

### Reading Log Files
```rhai
let log_path = get_home_dir() + "/Documents/SnapRun/logs/app.log";
try {
    let log_content = read_file(log_path);
    editor("Current Log", log_content);
} catch (error) {
    render_html("Error", "<p>Could not read log file: " + error + "</p>");
}
```

### Template Loading
```rhai
let template = read_file("templates/script_template.rhai");
let script_name = ask_input("Enter script name:");
let customized = template.replace("SCRIPT_NAME", script_name);
write_file("scripts/" + script_name + ".rhai", customized);
```

## Error Handling
Always use try-catch when reading files to handle potential errors:

```rhai
try {
    let content = read_file("important_data.json");
    // Process content
    info("Successfully read file");
} catch (error) {
    render_html("File Error", `
        <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
            <strong>Error:</strong> ${error}
        </div>
    `);
}
```

## Common Patterns

### Check Before Reading
```rhai
let file_path = "data/users.json";
if file_exists(file_path) {
    let data = read_file(file_path);
    // Process data
} else {
    info("File doesn't exist, creating default...");
    write_file(file_path, "[]");
}
```

### Reading Multiple Files
```rhai
let files = ["config.json", "data.json", "cache.json"];
for file_name in files {
    if file_exists(file_name) {
        let content = read_file(file_name);
        info("Read " + file_name + ": " + content.len() + " characters");
    }
}
```

## Notes
- Reads the entire file into memory as a string
- Supports text files with any encoding (UTF-8 recommended)
- File paths can be relative to the script location or absolute
- Large files may consume significant memory
- Always use error handling for file operations

## Related Functions
- `write_file()` - Write content to a file
- `file_exists()` - Check if a file exists
- `get_home_dir()` - Get user's home directory
- `create_dir()` - Create directories
