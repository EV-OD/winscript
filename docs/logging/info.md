# info Function

## Description
Outputs an informational message to the SnapRun console/log system. This is the primary logging function for script feedback and debugging.

## Syntax
```rhai
info(message)
```

## Parameters
- `message` (string): The message to log

## Return Value
- Returns nothing (unit type `()`)
- Message appears in SnapRun's console/log output

## Examples

### Basic Information Logging
```rhai
info("Script execution started");

let user_name = ask_input("Enter your name:");
info("User entered name: " + user_name);

info("Script completed successfully");
```

### Progress Updates
```rhai
info("Initializing todo list manager...");

let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";
info("Using todos file: " + todos_file);

if file_exists(todos_file) {
    let todos = parse_json(read_file(todos_file));
    info("Loaded " + todos.len() + " existing todos");
} else {
    info("No existing todos found, creating new list");
}

info("Todo list manager ready");
```

### Debug Information
```rhai
let config = #{
    theme: "dark",
    auto_save: true,
    timeout: 5000
};

info("Current configuration:");
info("- Theme: " + config.theme);
info("- Auto-save: " + config.auto_save);
info("- Timeout: " + config.timeout + "ms");
```

### Error Context
```rhai
let file_path = "important_data.json";

try {
    let content = read_file(file_path);
    info("Successfully loaded file: " + file_path);
} catch (error) {
    info("Failed to load file: " + file_path);
    info("Error details: " + error);
}
```

### Loop Progress
```rhai
let files = ["config.json", "todos.json", "settings.json"];
info("Processing " + files.len() + " files...");

for i in 0..files.len() {
    let file_name = files[i];
    info("Processing file " + (i + 1) + "/" + files.len() + ": " + file_name);
    
    if file_exists(file_name) {
        info("✓ File exists: " + file_name);
    } else {
        info("✗ File not found: " + file_name);
    }
}

info("File processing completed");
```

### User Action Logging
```rhai
info("Starting interactive todo creator");

let title = ask_input("Enter todo title:");
info("User entered title: '" + title + "'");

let priority = ask_select("Select priority:", ["Low", "Medium", "High"]);
info("User selected priority: " + priority);

let new_todo = #{
    id: timestamp(),
    title: title,
    priority: priority,
    completed: false
};

info("Created new todo with ID: " + new_todo.id);
```

### Conditional Logging
```rhai
let debug_mode = true; // Could come from config

if debug_mode {
    info("[DEBUG] Debug mode is enabled");
    info("[DEBUG] Current timestamp: " + timestamp());
    info("[DEBUG] Home directory: " + get_home_dir());
}

info("Normal execution continues...");
```

### Function Entry/Exit Logging
```rhai
fn save_todo(todo) {
    info("Entering save_todo function");
    info("Todo title: " + todo.title);
    
    let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";
    
    try {
        let todos = [];
        if file_exists(todos_file) {
            todos = parse_json(read_file(todos_file));
        }
        
        todos.push(todo);
        write_file(todos_file, to_json(todos));
        
        info("Todo saved successfully. Total todos: " + todos.len());
        return true;
    } catch (error) {
        info("Error saving todo: " + error);
        return false;
    }
}

// Usage
let new_todo = #{title: "Test Todo", completed: false};
if save_todo(new_todo) {
    info("Save operation completed successfully");
} else {
    info("Save operation failed");
}
```

### Performance Timing
```rhai
let start_time = timestamp();
info("Starting data processing at: " + start_time);

// Simulate some work
let data = [];
for i in 0..1000 {
    data.push("item_" + i);
}

let end_time = timestamp();
let duration = end_time - start_time;
info("Data processing completed in: " + duration + "ms");
info("Processed " + data.len() + " items");
```

### Multi-line Status Updates
```rhai
info("=== SnapRun Script Status ===");
info("Script: Todo List Manager");
info("Version: 1.0");
info("Author: User");
info("Started: " + timestamp());
info("=============================");

// ... script logic ...

info("=== Script Completed ===");
info("Status: Success");
info("Items processed: 15");
info("Errors: 0");
info("=======================");
```

## Common Patterns

### Structured Logging
```rhai
fn log_info(category, message) {
    info("[" + category + "] " + message);
}

fn log_error(category, message) {
    info("[ERROR][" + category + "] " + message);
}

// Usage
log_info("FILE_IO", "Reading configuration file");
log_error("VALIDATION", "Invalid user input detected");
```

### Conditional Debug Logging
```rhai
let LOG_LEVEL = "INFO"; // Could be "DEBUG", "INFO", "ERROR"

fn debug_log(message) {
    if LOG_LEVEL == "DEBUG" {
        info("[DEBUG] " + message);
    }
}

fn info_log(message) {
    if LOG_LEVEL == "DEBUG" || LOG_LEVEL == "INFO" {
        info("[INFO] " + message);
    }
}

// Usage
debug_log("Variable x = " + x);
info_log("User action completed");
```

### Progress Tracking
```rhai
fn log_progress(current, total, task) {
    let percentage = (current * 100) / total;
    info("Progress: " + current + "/" + total + " (" + percentage + "%) - " + task);
}

// Usage in loop
let tasks = ["load_config", "process_data", "save_results"];
for i in 0..tasks.len() {
    log_progress(i + 1, tasks.len(), tasks[i]);
    // ... perform task ...
}
```

## Output Characteristics
- Messages appear immediately in SnapRun's console
- Messages include timestamp information (added by SnapRun)
- Messages are persistent until console is cleared
- Long messages are displayed in full
- Special characters and Unicode are supported

## Best Practices
- Use descriptive, clear messages
- Include relevant context (file names, values, etc.)
- Use consistent formatting for similar types of messages
- Add progress indicators for long-running operations
- Include error details when logging failures
- Use structured prefixes for better organization (`[DEBUG]`, `[ERROR]`, etc.)

## Notes
- This is the primary output mechanism for Rhai scripts in SnapRun
- Messages are visible to users in the console
- Can be used for debugging, user feedback, and progress tracking
- Does not block script execution
- Messages are logged in the order they are called

## Related Functions
- `print()` - Alternative logging function (if available)
- `render_html()` - For rich user feedback
- `ask_input()` - For user interaction
- `ask_select()` - For user choices
