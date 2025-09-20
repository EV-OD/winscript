# write_file Function

## Description
Writes string content to a file, creating the file if it doesn't exist and overwriting if it does.

## Syntax
```rhai
write_file(file_path, content)
```

## Parameters
- `file_path` (string): Path where the file should be written
- `content` (string): Content to write to the file

## Return Value
- Returns `bool` indicating success (true) or failure (false)
- May throw an error if writing fails

## Examples

### Basic File Writing
```rhai
let content = "Hello, World!\nThis is a test file.";
try {
    write_file("test.txt", content);
    info("File written successfully");
} catch (error) {
    info("Error writing file: " + error);
}
```

### Save Configuration
```rhai
let config = #{
    theme: "dark",
    auto_save: true,
    timeout: 5000
};
let config_json = to_json(config);
write_file("config/settings.json", config_json);
info("Configuration saved");
```

### Generate Script File
```rhai
let script_name = ask_input("Enter script name:");
let description = ask_input("Enter description:");

let script_content = `// ${script_name}
// Description: ${description}
// Generated on: ${timestamp()}

info("Starting ${script_name}...");

// Add your code here

info("${script_name} completed!");
`;

write_file("generated/" + script_name + ".rhai", script_content);
render_html("Success", "<p>Script created: " + script_name + ".rhai</p>");
```

### Log Writing
```rhai
let log_entry = timestamp() + " - Script executed successfully\n";
let log_file = get_home_dir() + "/Documents/SnapRun/logs/script.log";

// Append to existing log (read, modify, write)
let existing_log = "";
if file_exists(log_file) {
    existing_log = read_file(log_file);
}
write_file(log_file, existing_log + log_entry);
```

### Data Persistence
```rhai
let user_data = #{
    name: "John Doe",
    preferences: #{
        theme: "dark",
        language: "en"
    },
    last_login: timestamp()
};

let data_json = to_json(user_data);
write_file("data/user_profile.json", data_json);
```

## Common Patterns

### Backup Before Writing
```rhai
let file_path = "important_data.json";
if file_exists(file_path) {
    let backup_content = read_file(file_path);
    write_file(file_path + ".backup", backup_content);
}
write_file(file_path, new_content);
```

### Template-based Generation
```rhai
let template = read_file("templates/html_template.html");
let title = ask_input("Page title:");
let content = ask_input("Page content:");

let final_html = template
    .replace("{{TITLE}}", title)
    .replace("{{CONTENT}}", content);

write_file("output/" + title.to_lower() + ".html", final_html);
```

### CSV Data Export
```rhai
let data = [
    ["Name", "Age", "City"],
    ["Alice", "25", "New York"],
    ["Bob", "30", "Los Angeles"]
];

let csv_content = "";
for row in data {
    csv_content += row.join(",") + "\n";
}

write_file("exports/data.csv", csv_content);
```

## Error Handling
```rhai
try {
    write_file("protected/data.txt", sensitive_data);
    render_html("Success", "<p style='color: green;'>File saved successfully!</p>");
} catch (error) {
    render_html("Error", `
        <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
            <strong>Write Error:</strong> ${error}<br>
            <small>Check permissions and disk space</small>
        </div>
    `);
}
```

## Notes
- Creates parent directories automatically if they don't exist
- Overwrites existing files completely (no append mode)
- File paths can be relative or absolute
- Content is written as UTF-8 text
- Always use error handling for file operations
- Consider backing up important files before overwriting

## Related Functions
- `read_file()` - Read file contents
- `file_exists()` - Check if file exists
- `create_dir()` - Create directories
- `to_json()` - Convert data to JSON string
