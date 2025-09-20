# get_home_dir Function

## Description
Returns the path to the current user's home directory.

## Syntax
```rhai
get_home_dir()
```

## Parameters
- None

## Return Value
- Returns a `string` containing the absolute path to the user's home directory

## Examples

### Basic Usage
```rhai
let home_path = get_home_dir();
info("Your home directory: " + home_path);
```

### SnapRun Data Directory
```rhai
let snaprun_dir = get_home_dir() + "/Documents/SnapRun";
if !file_exists(snaprun_dir) {
    create_dir(snaprun_dir);
    info("Created SnapRun data directory");
}
```

### User-specific Configuration
```rhai
let config_dir = get_home_dir() + "/Documents/SnapRun/Config";
let config_file = config_dir + "/user_settings.json";

create_dir(config_dir);

if !file_exists(config_file) {
    let default_config = `{
        "theme": "dark",
        "auto_save": true,
        "default_script_dir": "${get_home_dir()}/Documents/SnapRun/Scripts"
    }`;
    write_file(config_file, default_config);
}
```

### Desktop File Creation
```rhai
let desktop_path = get_home_dir() + "/Desktop";
let shortcut_file = desktop_path + "/my_script.txt";

write_file(shortcut_file, "This file was created by SnapRun!");
info("File created on desktop: " + shortcut_file);
```

### Personal Scripts Directory
```rhai
let scripts_dir = get_home_dir() + "/Documents/SnapRun/Scripts";
create_dir(scripts_dir);

let script_name = ask_input("Enter script name:");
let script_path = scripts_dir + "/" + script_name + ".rhai";

let template = `// Personal script: ${script_name}
// Created in: ${scripts_dir}

info("Running ${script_name}...");

// Add your code here
`;

write_file(script_path, template);
editor(script_path);
```

## Common Patterns

### Cross-Platform Path Building
```rhai
// This works on Windows, macOS, and Linux
let data_path = get_home_dir() + "/Documents/MyApp/data.json";
let logs_path = get_home_dir() + "/Documents/MyApp/logs";
```

### User-specific Todos
```rhai
let todos_dir = get_home_dir() + "/Documents/SnapRun/Todos";
let todos_file = todos_dir + "/todos.json";

create_dir(todos_dir);

if !file_exists(todos_file) {
    write_file(todos_file, "[]");  // Empty JSON array
    info("Created new todos file at: " + todos_file);
}
```

### Backup to User Directory
```rhai
let backup_dir = get_home_dir() + "/Documents/SnapRun/Backups";
let timestamp_str = timestamp();
let backup_file = backup_dir + "/backup_" + timestamp_str + ".json";

create_dir(backup_dir);

let data_to_backup = #{
    created: timestamp_str,
    user_home: get_home_dir(),
    data: "Important information"
};

write_file(backup_file, to_json(data_to_backup));
info("Backup created: " + backup_file);
```

### Environment Information
```rhai
let system_info = #{
    home_directory: get_home_dir(),
    timestamp: timestamp(),
    script_location: "SnapRun Scripts"
};

render_html("System Information", `
    <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px; font-family: monospace;">
        <strong>Home Directory:</strong> ${system_info.home_directory}<br>
        <strong>Timestamp:</strong> ${system_info.timestamp}<br>
        <strong>Script Location:</strong> ${system_info.script_location}
    </div>
`);
```

## Platform Behavior

### Windows
```rhai
// Returns something like: C:\Users\YourUsername
let home = get_home_dir();
// Common paths:
// Documents: home + "/Documents" 
// Desktop: home + "/Desktop"
// AppData: home + "/AppData/Roaming"
```

### macOS
```rhai
// Returns something like: /Users/YourUsername  
let home = get_home_dir();
// Common paths:
// Documents: home + "/Documents"
// Desktop: home + "/Desktop" 
// Library: home + "/Library"
```

### Linux
```rhai
// Returns something like: /home/yourusername
let home = get_home_dir();
// Common paths:
// Documents: home + "/Documents"
// Desktop: home + "/Desktop"
// Config: home + "/.config"
```

## Standard SnapRun Directory Structure
```rhai
let base = get_home_dir() + "/Documents/SnapRun";
let directories = #{
    base: base,
    scripts: base + "/Scripts",
    todos: base + "/Todos", 
    configs: base + "/Config",
    logs: base + "/Logs",
    backups: base + "/Backups"
};

// Create all standard directories
for dir_name in directories.keys() {
    let dir_path = directories[dir_name];
    if !file_exists(dir_path) {
        create_dir(dir_path);
        info("Created: " + dir_name + " -> " + dir_path);
    }
}
```

## Notes
- Returns an absolute path that's guaranteed to exist
- Path separators are automatically normalized for the current OS
- The returned path never ends with a trailing slash/backslash
- Useful for creating portable scripts that work across different systems
- Always combine with other path components using `+` operator

## Related Functions
- `create_dir()` - Create directories under home
- `file_exists()` - Check if paths under home exist  
- `write_file()` / `read_file()` - Work with files under home
