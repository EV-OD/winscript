---
title: "Quick Start Guide"
description: "Write your first automation script with SnapRun in minutes"
---

# Quick Start Guide

Get up and running with SnapRun in just a few minutes! This guide will walk you through creating your first automation script and introduce you to the core concepts.

## Your First Script

Let's start with a simple "Hello World" script that demonstrates basic SnapRun functionality.

### Step 1: Create a New Script

1. **Launch SnapRun**
2. **Click** "New Script" or press `Ctrl+N` (Windows/Linux) or `Cmd+N` (macOS)
3. **Choose** "Blank Script" from the template options

### Step 2: Write Your First Script

Copy and paste this code into the editor:

```rust
// Your first SnapRun script
print("🚀 Welcome to SnapRun!");

// Get user's name
let name = ask_input("What's your name?", "Enter your name here");

if name != "" {
    print("Hello, " + name + "! Nice to meet you.");
    
    // Show current timestamp
    let now = timestamp();
    print("Current time: " + now);
    
    // Demonstrate JSON functionality
    let user_data = #{
        name: name,
        timestamp: now,
        greeting: "Welcome to SnapRun!"
    };
    
    let json_string = to_json(user_data);
    print("User data as JSON: " + json_string);
} else {
    print("No name provided. Hello, Anonymous!");
}

print("✅ Script completed successfully!");
```

### Step 3: Save and Run

1. **Save** your script: `Ctrl+S` (Windows/Linux) or `Cmd+S` (macOS)
2. **Name it**: `my-first-script.rhai`
3. **Run the script**: Click the "Run" button or press `F5`

### Step 4: Interact with Your Script

1. A dialog will appear asking for your name
2. Enter your name and click "OK"
3. Watch the output in the console panel

**Congratulations!** 🎉 You've just created and run your first SnapRun automation script!

## Understanding the Code

Let's break down what happened in your first script:

### Basic Output
```rust
print("🚀 Welcome to SnapRun!");
```
- `print()` displays messages in the output console
- Great for debugging and showing script progress

### User Input
```rust
let name = ask_input("What's your name?", "Enter your name here");
```
- `ask_input()` creates a dialog box to collect user input
- Returns the text the user enters
- Perfect for interactive scripts

### Variables and Conditionals
```rust
if name != "" {
    // Do something with the name
}
```
- Variables are declared with `let`
- Standard conditional logic with `if/else`
- String comparison and manipulation

### Timestamps
```rust
let now = timestamp();
```
- `timestamp()` returns the current date and time
- Useful for logging and timestamping operations

### JSON Operations
```rust
let user_data = #{
    name: name,
    timestamp: now,
    greeting: "Welcome to SnapRun!"
};
let json_string = to_json(user_data);
```
- Create objects using `#{}` syntax
- Convert objects to JSON strings with `to_json()`
- Essential for data exchange and storage

## Common Patterns

Here are some common patterns you'll use in SnapRun scripts:

### File Operations
```rust
// Check if a file exists
if file_exists("C:/path/to/file.txt") {
    // Read the file
    let content = read_file("C:/path/to/file.txt");
    print("File content: " + content);
}

// Write to a file
write_file("C:/path/to/output.txt", "Hello from SnapRun!");
```

### User Selection
```rust
let options = ["Option 1", "Option 2", "Option 3"];
let choice = ask_select("Choose an option:", options);
print("You selected: " + choice);
```

### Directory Operations
```rust
// Create a directory
create_dir("C:/MyScripts/Output");

// Get home directory
let home = get_home_dir();
print("Your home directory: " + home);
```

## Script Organization

As you create more scripts, here are some organization tips:

### Folder Structure
```
~/SnapRun/Scripts/
├── personal/           # Personal automation scripts
├── work/              # Work-related scripts
├── utilities/         # General utility scripts
└── examples/          # Learning examples
```

### Naming Convention
- Use descriptive names: `backup-photos.rhai`
- Include dates for versions: `report-generator-v2.rhai`
- Group related scripts: `email-parser.rhai`, `email-sender.rhai`

### Comments and Documentation
```rust
// File: daily-backup.rhai
// Purpose: Backup important files daily
// Author: Your Name
// Version: 1.0
// Last Updated: 2024-01-15

// Configuration
let backup_source = "C:/Important";
let backup_dest = "D:/Backups";

// Main backup logic
// ... rest of script
```

## Next Steps

Now that you've created your first script, here's what to explore next:

### 1. **Explore Function Categories**
- **[UI Functions](/ui-functions/ask_input)** - Interactive dialogs and forms
- **[File System](/file-system/read_file)** - File and directory operations
- **[JSON Utilities](/json-utilities/to_json)** - Data processing and exchange

### 2. **Try More Examples**
```rust
// System information script
print("System Info:");
print("Home directory: " + get_home_dir());
print("Current time: " + timestamp());

// File management example
let files_to_check = ["config.json", "data.txt", "backup.zip"];
for file in files_to_check {
    if file_exists(file) {
        print("✅ Found: " + file);
    } else {
        print("❌ Missing: " + file);
    }
}
```

### 3. **Build Real Automations**
Start with simple tasks you do regularly:
- File organization and cleanup
- Data processing and reporting
- System monitoring and alerts
- Workflow automation

### 4. **Learn Advanced Features**
- Error handling with try/catch blocks
- Function definitions and reusable code
- Working with external APIs
- Complex data structures and algorithms

## Getting Help

As you continue learning:

- **Function Reference**: Each function has detailed documentation with examples
- **Built-in Help**: Press `F1` in the editor for context-sensitive help
- **Community**: Join our community for tips, tricks, and script sharing
- **Examples**: Explore the built-in example scripts for inspiration

## Troubleshooting

### Common Beginner Issues

**"Function not found" error**
- Check function spelling and capitalization
- Refer to the function reference for exact syntax

**"File not found" error**
- Use absolute paths: `C:/full/path/to/file.txt`
- Check file permissions and existence

**Dialog doesn't appear**
- Ensure SnapRun has focus and isn't running in background
- Check if modal dialogs are blocked by your system

---

**You're now ready to automate!** Start with simple scripts and gradually build more complex automations as you become comfortable with SnapRun's capabilities.

*Happy scripting! 🚀*


