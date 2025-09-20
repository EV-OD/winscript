# SnapRun Rhai Functions Documentation

Welcome to the comprehensive documentation for all Rhai functions available in SnapRun. This documentation is organized by function categories to help you quickly find the functions you need for your scripts.

## 📁 Documentation Structure

The documentation is organized into the following categories:

### 🖥️ [UI Functions](./ui-functions/)
Interactive user interface and input/output functions
- `ask_input()` - Get text input from users
- `ask_select()` - Present selection dialogs
- `render_html()` - Display HTML content in the UI
- `md()` - Render Markdown content
- `editor()` - Open code/text editor interface

### 📁 [File System](./file-system/)
File and directory operations
- `read_file()` - Read file contents
- `write_file()` - Write content to files
- `file_exists()` - Check if files exist
- `create_dir()` - Create directories
- `get_home_dir()` - Get user home directory path

### 🔧 [JSON Utilities](./json-utilities/)
JSON parsing and serialization functions
- `parse_json()` - Parse JSON strings to Rhai data structures
- `to_json()` - Convert Rhai data to JSON strings

### 📝 [Logging](./logging/)
Output and logging functions
- `info()` - Primary logging function for script feedback
- `print()` - Alternative console output function

### 🧮 [Math Functions](./math-functions/)
Mathematical operations and utilities
- `abs()`, `min()`, `max()` - Basic math operations
- `sqrt()`, `pow()` - Advanced mathematical functions
- `floor()`, `ceil()`, `round()` - Number rounding functions
- Plus comprehensive examples for calculations, statistics, and data analysis

### ⚙️ [Process Control](./process-control/)
External process execution and management
- `run_command()` - Execute system commands
- `start_process()` - Launch background processes
- `kill_process()` - Terminate running processes
- `wait_for_process()` - Wait for process completion

### 🎛️ [App Control](./app-control/)
SnapRun application control functions
- `exit_and_hide()` - Exit script and hide SnapRun window
- `timestamp()` - Get current system timestamp

## 🚀 Quick Start Guide

### Basic Script Structure
```rhai
// Log script start
info("Script starting...");

// Get user input
let user_name = ask_input("Enter your name:");

// Process data
let greeting = "Hello, " + user_name + "!";

// Display result
render_html("Greeting", `
    <div style="text-align: center; padding: 2rem;">
        <h2>${greeting}</h2>
        <p>Welcome to SnapRun!</p>
    </div>
`);

// Log completion
info("Script completed successfully");
```

### Common Patterns

#### File-Based Configuration
```rhai
let config_file = "config.json";
let config = #{
    theme: "dark",
    auto_save: true
};

if file_exists(config_file) {
    config = parse_json(read_file(config_file));
}

// Use configuration
info("Using theme: " + config.theme);
```

#### User Data Management
```rhai
let data_file = get_home_dir() + "/Documents/SnapRun/user_data.json";
let user_data = [];

if file_exists(data_file) {
    user_data = parse_json(read_file(data_file));
}

// Add new data
let new_item = #{
    id: timestamp(),
    content: ask_input("Enter content:"),
    created: timestamp()
};

user_data.push(new_item);

// Save back to file
write_file(data_file, to_json(user_data));
info("Data saved. Total items: " + user_data.len());
```

#### Error Handling Pattern
```rhai
try {
    let data = parse_json(read_file("data.json"));
    info("Data loaded successfully");
    // Process data...
} catch (error) {
    info("Error loading data: " + error);
    render_html("Error", `
        <div style="color: red; padding: 1rem; border: 1px solid red;">
            <strong>Error:</strong> ${error}
        </div>
    `);
}
```

## 📖 Function Categories Overview

### Interactive Functions
Functions that interact with users:
- **Input**: `ask_input()`, `ask_select()`
- **Output**: `render_html()`, `md()`, `editor()`
- **Logging**: `info()`, `print()`

### Data Functions
Functions for data manipulation:
- **Files**: `read_file()`, `write_file()`, `file_exists()`
- **JSON**: `parse_json()`, `to_json()`
- **Math**: All mathematical operations and utilities

### System Functions
Functions for system interaction:
- **Processes**: `run_command()`, `start_process()`, `kill_process()`
- **Directories**: `create_dir()`, `get_home_dir()`
- **Time**: `timestamp()`
- **App Control**: `exit_and_hide()`

## 🛠️ Advanced Examples

### Todo List Manager
```rhai
let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";
let todos = [];

// Load existing todos
if file_exists(todos_file) {
    todos = parse_json(read_file(todos_file));
}

// Interactive menu
let action = ask_select(
    "Todo Manager - Choose action:",
    ["Add Todo", "List Todos", "Complete Todo", "Exit"]
);

if action == "Add Todo" {
    let title = ask_input("Enter todo title:");
    let priority = ask_select("Select priority:", ["Low", "Medium", "High"]);
    
    let new_todo = #{
        id: timestamp(),
        title: title,
        priority: priority,
        completed: false,
        created_at: timestamp()
    };
    
    todos.push(new_todo);
    write_file(todos_file, to_json(todos));
    info("Todo added: " + title);
    
} else if action == "List Todos" {
    let html_content = "<h2>Your Todos</h2>";
    
    for todo in todos {
        let status = todo.completed ? "✅" : "⏳";
        html_content += `
            <div style="padding: 0.5rem; border: 1px solid #ddd; margin: 0.25rem;">
                ${status} <strong>${todo.title}</strong> 
                <span style="color: gray;">(${todo.priority})</span>
            </div>
        `;
    }
    
    render_html("Todo List", html_content);
}

// Save any changes
write_file(todos_file, to_json(todos));
```

### System Information Dashboard
```rhai
let system_info = #{
    timestamp: timestamp(),
    user_home: get_home_dir()
};

// Get system information (Windows example)
let hostname_result = run_command("hostname", []);
let date_result = run_command("date", ["/t"]);

if hostname_result.exit_code == 0 {
    system_info.hostname = hostname_result.stdout.trim();
}

if date_result.exit_code == 0 {
    system_info.current_date = date_result.stdout.trim();
}

render_html("System Dashboard", `
    <div style="font-family: Arial; padding: 2rem;">
        <h1>System Information Dashboard</h1>
        
        <div style="display: grid; gap: 1rem;">
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
                <strong>Computer Name:</strong> ${system_info.hostname ?? "Unknown"}
            </div>
            
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
                <strong>Current Date:</strong> ${system_info.current_date ?? "Unknown"}
            </div>
            
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
                <strong>User Home:</strong> ${system_info.user_home}
            </div>
            
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
                <strong>Report Generated:</strong> ${system_info.timestamp}
            </div>
        </div>
    </div>
`);
```

## 💡 Tips and Best Practices

### 1. Error Handling
Always wrap potentially failing operations in try-catch blocks:
```rhai
try {
    let data = parse_json(read_file("config.json"));
} catch (error) {
    info("Using default configuration due to error: " + error);
    let data = #{default: true};
}
```

### 2. User Feedback
Provide clear feedback about what your script is doing:
```rhai
info("Loading user preferences...");
info("Processing " + items.len() + " items...");
info("Save completed successfully");
```

### 3. Data Persistence
Use consistent file paths and JSON format for data storage:
```rhai
let data_dir = get_home_dir() + "/Documents/SnapRun/";
create_dir(data_dir);
let data_file = data_dir + "app_data.json";
```

### 4. Input Validation
Validate user input before processing:
```rhai
let user_input = ask_input("Enter a number:");
if user_input.trim() == "" {
    info("No input provided");
    return;
}

try {
    let number = user_input + 0; // Convert to number
    info("You entered: " + number);
} catch {
    info("Invalid number format");
}
```

### 5. Graceful Exit
Always provide a way for users to exit gracefully:
```rhai
let continue_script = ask_select(
    "Continue with operation?",
    ["Yes", "No"]
);

if continue_script == "No" {
    info("Operation cancelled by user");
    exit_and_hide();
}
```

## 🔍 Function Reference Quick Links

| Category | Functions | Description |
|----------|-----------|-------------|
| **UI** | `ask_input`, `ask_select`, `render_html`, `md`, `editor` | User interface and interaction |
| **File System** | `read_file`, `write_file`, `file_exists`, `create_dir`, `get_home_dir` | File and directory operations |
| **JSON** | `parse_json`, `to_json` | JSON data handling |
| **Logging** | `info`, `print` | Output and debugging |
| **Math** | `abs`, `min`, `max`, `sqrt`, `pow`, `floor`, `ceil`, `round` | Mathematical operations |
| **Process** | `run_command`, `start_process`, `kill_process`, `wait_for_process` | System process control |
| **App Control** | `exit_and_hide`, `timestamp` | Application and timing control |

## 📚 Additional Resources

- Each function documentation includes comprehensive examples
- Error handling patterns are provided throughout
- Common use cases and patterns are demonstrated
- Cross-references between related functions are included

## 🤝 Contributing

This documentation is designed to be comprehensive and practical. Each function page includes:
- Complete syntax and parameter information
- Multiple practical examples
- Common usage patterns
- Error handling strategies
- Cross-references to related functions

Happy scripting with SnapRun! 🚀
