# exit_and_hide Function

## Description
Exits the current script and hides the SnapRun application window. This function provides a way to gracefully terminate script execution and minimize the application to the system tray or hide it from view.

## Syntax
```rhai
exit_and_hide()
```

## Parameters
- None

## Return Value
- Does not return (terminates script execution)
- Hides the SnapRun application window

## Examples

### Basic Script Exit
```rhai
info("Script starting...");

// Perform some operations
let user_name = ask_input("Enter your name:");
info("Hello, " + user_name + "!");

// Exit and hide the application
info("Script completed. Hiding application...");
exit_and_hide();
```

### Conditional Exit
```rhai
let user_choice = ask_select(
    "What would you like to do?",
    ["Continue working", "Exit and hide", "Just exit"]
);

if user_choice == "Exit and hide" {
    info("Exiting and hiding SnapRun...");
    exit_and_hide();
} else if user_choice == "Just exit" {
    info("Exiting script...");
    return; // Normal script exit
} else {
    info("Continuing with script...");
    // Continue script execution
}
```

### Task Completion Exit
```rhai
info("Starting automated backup task...");

// Simulate backup process
let files_to_backup = ["config.json", "data.json", "settings.json"];
let backup_dir = get_home_dir() + "/Documents/SnapRun/Backups/";

create_dir(backup_dir);

for file in files_to_backup {
    if file_exists(file) {
        let content = read_file(file);
        let backup_path = backup_dir + file + ".backup";
        write_file(backup_path, content);
        info("Backed up: " + file);
    }
}

info("Backup completed successfully!");
info("Application will now hide to system tray...");

// Exit and hide after task completion
exit_and_hide();
```

### User Preference Based Exit
```rhai
// Load user preferences
let config_file = "user_preferences.json";
let preferences = #{
    auto_hide: true,
    show_completion_dialog: true
};

if file_exists(config_file) {
    let config_json = read_file(config_file);
    preferences = parse_json(config_json);
}

// Perform main task
info("Processing user data...");

let todos = [];
let todo_title = ask_input("Enter a new todo:");
if todo_title.trim() != "" {
    let new_todo = #{
        id: timestamp(),
        title: todo_title,
        completed: false,
        created_at: timestamp()
    };
    
    todos.push(new_todo);
    
    let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";
    write_file(todos_file, to_json(todos));
    
    info("Todo saved: " + todo_title);
}

// Handle exit based on user preferences
if preferences.show_completion_dialog {
    render_html("Task Complete", `
        <div style="text-align: center; padding: 2rem; font-family: Arial;">
            <h2 style="color: green;">✓ Task Completed</h2>
            <p>Your todo has been saved successfully.</p>
            <p>The application will now hide to the system tray.</p>
        </div>
    `);
    
    // Give user time to read the message
    ask_input("Press Enter to continue...");
}

if preferences.auto_hide {
    exit_and_hide();
} else {
    info("Script completed. Application remains visible.");
}
```

### Timed Auto-Hide
```rhai
info("Starting timed task...");

let start_time = timestamp();

// Simulate some work
let data_to_process = [1, 2, 3, 4, 5];
for item in data_to_process {
    info("Processing item: " + item);
    // Simulate processing time (not actual delay, just for demonstration)
}

let end_time = timestamp();
let duration = end_time - start_time;

info("Task completed in " + duration + "ms");

// Auto-hide after short tasks
if duration < 5000 { // Less than 5 seconds
    info("Quick task completed. Auto-hiding application...");
    exit_and_hide();
} else {
    info("Long task completed. Keeping application visible.");
}
```

### Error Handling with Exit
```rhai
try {
    info("Attempting critical operation...");
    
    // Simulate a critical file operation
    let critical_file = "critical_data.json";
    
    if !file_exists(critical_file) {
        throw "Critical file not found: " + critical_file;
    }
    
    let data = parse_json(read_file(critical_file));
    info("Critical operation successful");
    
    // Normal completion
    info("All operations completed successfully. Hiding application...");
    exit_and_hide();
    
} catch (error) {
    info("Critical error occurred: " + error);
    
    let user_choice = ask_select(
        "An error occurred. What would you like to do?",
        ["View error details", "Exit and hide anyway", "Keep app open"]
    );
    
    if user_choice == "View error details" {
        render_html("Error Details", `
            <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
                <h3>Error Information</h3>
                <p><strong>Error:</strong> ${error}</p>
                <p><strong>Time:</strong> ${timestamp()}</p>
                <p><strong>Script:</strong> Error Handling Demo</p>
            </div>
        `);
        ask_input("Press Enter to exit and hide...");
        exit_and_hide();
    } else if user_choice == "Exit and hide anyway" {
        exit_and_hide();
    } else {
        info("Application will remain open for debugging.");
    }
}
```

### Background Task with Auto-Hide
```rhai
info("Starting background maintenance task...");

// Cleanup old temporary files
let temp_patterns = ["*.tmp", "*.bak", "*.old"];
let files_cleaned = 0;

// Note: This is a simplified example
// In real implementation, you'd use proper file enumeration
let temp_dir = get_home_dir() + "/AppData/Local/Temp/SnapRun/";

if file_exists(temp_dir) {
    info("Cleaning temporary files in: " + temp_dir);
    // Simulate cleanup
    files_cleaned = 5; // Placeholder
    info("Cleaned " + files_cleaned + " temporary files");
} else {
    info("No temporary directory found");
}

// Update system status
let status = #{
    last_cleanup: timestamp(),
    files_removed: files_cleaned,
    next_cleanup: timestamp() + (24 * 60 * 60 * 1000) // 24 hours from now
};

write_file("maintenance_status.json", to_json(status));

info("Maintenance task completed");
info("Status saved for next run");
info("Application hiding...");

exit_and_hide();
```

### Interactive Tutorial with Exit
```rhai
render_html("Welcome to SnapRun", `
    <div style="font-family: Arial; padding: 2rem; text-align: center;">
        <h1>Welcome to SnapRun!</h1>
        <p>This tutorial will show you the basic features.</p>
    </div>
`);

ask_input("Press Enter to continue...");

// Tutorial steps
let tutorial_steps = [
    "SnapRun allows you to create powerful automation scripts",
    "You can interact with files, display HTML content, and more",
    "Scripts can ask for user input and make decisions",
    "This tutorial is complete!"
];

for i in 0..tutorial_steps.len() {
    render_html("Tutorial - Step " + (i + 1), `
        <div style="font-family: Arial; padding: 2rem;">
            <h2>Step ${i + 1} of ${tutorial_steps.len()}</h2>
            <p>${tutorial_steps[i]}</p>
            <div style="background: #f0f0f0; padding: 1rem; border-radius: 4px; margin-top: 1rem;">
                Progress: ${((i + 1) * 100) / tutorial_steps.len()}%
            </div>
        </div>
    `);
    
    if i < tutorial_steps.len() - 1 {
        ask_input("Press Enter for next step...");
    }
}

let final_choice = ask_select(
    "Tutorial completed! What would you like to do?",
    ["Hide SnapRun", "Keep it open", "Run another script"]
);

if final_choice == "Hide SnapRun" {
    render_html("Goodbye!", `
        <div style="text-align: center; padding: 2rem;">
            <h2>Thanks for trying SnapRun!</h2>
            <p>The application will now hide to your system tray.</p>
        </div>
    `);
    ask_input("Press Enter to hide...");
    exit_and_hide();
} else if final_choice == "Run another script" {
    info("You can now run another script from the main menu.");
} else {
    info("SnapRun will remain open and ready for your next task.");
}
```

## Common Patterns

### Clean Exit After Task
```rhai
// Standard pattern for task completion
fn complete_task_and_exit(task_name) {
    info("Completing task: " + task_name);
    info("Task finished successfully");
    info("Hiding application...");
    exit_and_hide();
}

// Usage
let task_result = perform_some_task();
if task_result {
    complete_task_and_exit("Data Processing");
}
```

### User-Controlled Exit
```rhai
fn ask_user_exit() {
    let choice = ask_select(
        "Script completed. What next?",
        ["Hide application", "Keep open", "Run again"]
    );
    
    if choice == "Hide application" {
        exit_and_hide();
    } else if choice == "Run again" {
        return "restart";
    } else {
        return "stay_open";
    }
}

// Usage
let user_decision = ask_user_exit();
if user_decision == "restart" {
    // Restart script logic
}
```

### Scheduled Task Pattern
```rhai
// Pattern for scheduled/automated tasks
fn run_scheduled_task() {
    info("Running scheduled task at: " + timestamp());
    
    // Perform automated task
    let success = perform_automation();
    
    if success {
        info("Scheduled task completed successfully");
        exit_and_hide(); // Hide after automation
    } else {
        info("Scheduled task failed - keeping app visible for debugging");
    }
}

run_scheduled_task();
```

## Behavior Notes
- The function immediately terminates script execution
- No code after `exit_and_hide()` will be executed  
- The SnapRun window is minimized or hidden from the taskbar
- The application may still be accessible from the system tray (if implemented)
- Any unsaved data should be saved before calling this function
- The function is useful for scripts that run automatically or periodically

## Best Practices
- Save all important data before calling `exit_and_hide()`
- Provide user feedback about what's happening before hiding
- Use for automation scripts that don't require continued user interaction
- Consider user preferences for auto-hide behavior
- Include error handling in case the hide operation fails
- Give users a final confirmation for important operations

## Notes
- This function is specific to SnapRun application control
- The exact hiding behavior depends on SnapRun's implementation
- Scripts using this function should handle cleanup operations beforehand
- Useful for creating polished, user-friendly automation scripts
- Should not be called in interactive scripts where continued user engagement is expected

## Related Functions
- `info()` - Provide user feedback before exiting
- `ask_input()` - Get final user confirmation
- `ask_select()` - Let users choose exit behavior
- `write_file()` - Save data before exiting
- `render_html()` - Show completion messages
