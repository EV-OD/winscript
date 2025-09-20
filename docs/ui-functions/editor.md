# editor Function

## Description
Opens a file in the built-in Monaco Editor within SnapRun for viewing or editing.

## Syntax
```rhai
editor(file_path, initial_content)
editor(file_path)  // Opens existing file or empty editor
```

## Parameters
- `file_path` (string): Path to the file to open or create
- `initial_content` (string, optional): Initial content for new files

## Return Value
- Returns a `bool` indicating success (true) or failure (false)

## Examples

### Open Existing File
```rhai
editor("my_script.rhai");
```

### Create New File with Content
```rhai
let template = `// New Rhai Script
// Description: 

info("Hello from new script!");
`;
editor("new_script.rhai", template);
```

### Open Configuration File
```rhai
let config_path = get_home_dir() + "/Documents/SnapRun/config.json";
editor(config_path);
```

### View Log File
```rhai
let log_file = "logs/application.log";
if file_exists(log_file) {
    editor(log_file);
} else {
    render_html("Error", "<p>Log file not found!</p>");
}
```

### Create Script from Template
```rhai
let script_name = ask_input("Enter script name:");
let description = ask_input("Enter description:");

let template = `// ${script_name}
// Description: ${description}

info("Starting ${script_name}...");

// Your code here

info("${script_name} completed!");
`;

editor(script_name + ".rhai", template);
```

## Use Cases

### Script Development
```rhai
// Create a new script file
let name = ask_input("Script name:");
let content = `// ${name}
// Auto-generated script template

info("${name} is running...");

// Add your functionality here

`;
editor("scripts/" + name + ".rhai", content);
```

### Configuration Editing
```rhai
let config_file = "config/settings.json";
let default_config = `{
    "theme": "dark",
    "auto_save": true,
    "timeout": 5000
}`;

if !file_exists(config_file) {
    editor(config_file, default_config);
} else {
    editor(config_file);
}
```

### Log Viewing (Common Pattern)
```rhai
// This is commonly used in showlog script
let logs = list_files("logs/");
let selected_log = ask_select("Choose log file:", logs);
editor("logs/" + selected_log);
```

## Editor Features
- **Syntax Highlighting**: Supports Rhai, JSON, Markdown, and other common formats
- **Auto-completion**: Smart suggestions for Rhai functions and keywords  
- **Error Detection**: Shows syntax errors and warnings
- **Theme Integration**: Matches SnapRun's dark theme
- **Persistent**: Content remains available during the session

## Notes
- The editor opens in the same UI as other SnapRun content
- Files are saved automatically when you close the editor
- Supports both absolute and relative file paths
- Creates directories automatically if they don't exist
- Works great for viewing logs, editing configs, and developing scripts
- The editor persists during the script session - great for long-running operations

## Related Functions
- `read_file()` - Read file contents into a string
- `write_file()` - Write string content to a file
- `file_exists()` - Check if a file exists
- `get_home_dir()` - Get the user's home directory path
