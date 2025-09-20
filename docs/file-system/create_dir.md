# create_dir Function

## Description
Creates a directory at the specified path, including any necessary parent directories.

## Syntax
```rhai
create_dir(directory_path)
```

## Parameters
- `directory_path` (string): Path of the directory to create

## Return Value
- Returns `bool` indicating success (true) or failure (false)
- May throw an error if creation fails

## Examples

### Basic Directory Creation
```rhai
try {
    create_dir("data");
    info("Directory created successfully");
} catch (error) {
    info("Error creating directory: " + error);
}
```

### Nested Directory Creation
```rhai
// Creates all parent directories if they don't exist
create_dir("projects/my_app/src/components");
info("Nested directory structure created");
```

### Project Structure Setup
```rhai
let project_name = ask_input("Enter project name:");
let base_dir = "projects/" + project_name;

let directories = [
    base_dir,
    base_dir + "/src", 
    base_dir + "/docs",
    base_dir + "/tests",
    base_dir + "/config"
];

for dir in directories {
    create_dir(dir);
    info("Created: " + dir);
}

render_html("Project Created", `
    <div style="background: #e8f5e8; padding: 1rem; border-radius: 4px; border-left: 4px solid green;">
        <strong>Success!</strong> Project structure created for <code>${project_name}</code>
    </div>
`);
```

### Backup Directory Setup
```rhai
let backup_base = get_home_dir() + "/Documents/SnapRun/backups";
let today = timestamp();
let backup_dir = backup_base + "/" + today;

if !file_exists(backup_base) {
    create_dir(backup_base);
}

create_dir(backup_dir);
info("Backup directory ready: " + backup_dir);
```

### Log Directory Initialization
```rhai
let log_dir = "logs/" + timestamp();
create_dir(log_dir);

// Create log file
write_file(log_dir + "/app.log", "Application started at " + timestamp() + "\n");
info("Logging initialized in: " + log_dir);
```

## Common Patterns

### Safe Directory Creation
```rhai
let target_dir = "output/reports";

if !file_exists(target_dir) {
    try {
        create_dir(target_dir);
        info("Directory created: " + target_dir);
    } catch (error) {
        render_html("Directory Error", `
            <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
                <strong>Error:</strong> Could not create directory<br>
                <strong>Path:</strong> ${target_dir}<br>
                <strong>Reason:</strong> ${error}
            </div>
        `);
        return;
    }
} else {
    info("Directory already exists: " + target_dir);
}
```

### Organized File Storage
```rhai
let base_path = get_home_dir() + "/Documents/SnapRun";
let subdirs = [
    "Scripts",
    "Todos", 
    "Configs",
    "Backups",
    "Logs"
];

for subdir in subdirs {
    let full_path = base_path + "/" + subdir;
    if !file_exists(full_path) {
        create_dir(full_path);
        info("Created: " + subdir);
    }
}
```

### Temporary Directory Setup
```rhai
let temp_id = timestamp();
let temp_dir = "temp/session_" + temp_id;

create_dir(temp_dir);

// Use temporary directory
write_file(temp_dir + "/data.json", some_data);
write_file(temp_dir + "/config.ini", some_config);

info("Temporary workspace: " + temp_dir);
```

### Date-based Organization
```rhai
let current_date = timestamp();  // You might want to format this
let archive_dir = "archives/" + current_date;

create_dir(archive_dir);

// Move or copy files to archive
let files_to_archive = ["old_data.json", "completed_tasks.json"];
for file_name in files_to_archive {
    if file_exists(file_name) {
        let content = read_file(file_name);
        write_file(archive_dir + "/" + file_name, content);
        info("Archived: " + file_name);
    }
}
```

## Error Handling
```rhai
let new_dir = "protected/sensitive_data";

try {
    create_dir(new_dir);
    render_html("Success", "<p style='color: green;'>Directory created successfully!</p>");
} catch (error) {
    render_html("Directory Creation Failed", `
        <div style="background: #ffebee; padding: 1rem; border-radius: 4px; border-left: 4px solid red;">
            <strong>Error:</strong> ${error}<br>
            <strong>Possible causes:</strong>
            <ul>
                <li>Insufficient permissions</li>
                <li>Path contains invalid characters</li>
                <li>Disk space full</li>
                <li>Path too long</li>
            </ul>
        </div>
    `);
}
```

## Notes
- Creates parent directories automatically (like `mkdir -p` in Unix)
- Does nothing if the directory already exists (no error)
- Works with both relative and absolute paths
- Directory separators are automatically normalized for the OS
- Permissions depend on the system and user running SnapRun

## Related Functions
- `file_exists()` - Check if directory exists
- `write_file()` - Create files in the directory
- `get_home_dir()` - Get user's home directory path
