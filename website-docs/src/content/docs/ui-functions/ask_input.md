---
title: "ask_input"
description: "Collect text input from users through interactive dialog boxes"
---

# ask_input Function

Display an input dialog to collect text from users interactively. Perfect for gathering user preferences, file names, configuration values, and any other text-based input.

## Syntax

```rust
ask_input(message)
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `message` | `string` | The question or instruction to display to the user |

**Note**: If you press enter without typing anything(Space is also treated as empty), the dialog will stay open and not continue. You must enter some text to proceed.


## Return Value

- **Type**: `string`
- **Content**: The text entered by the user

## Basic Examples

### Simple Text Input
```rust
let name = ask_input("What's your name?");
render_html("<h3>Hello, " + name + "!</h3><p>Welcome to SnapRun.</p>");
```


### Input Validation
```rust
let email = ask_input("Enter your email address:");

while !email.contains("@") {
    email = ask_input("Please enter a valid email address (must contain @):");
}

render_html("<p>✅ Email registered: <strong>" + email + "</strong></p>");
```

## Practical Use Cases

### Configuration Setup

Collect application settings from the user:

```rust
fn setup_application_config() {
    render_html("<h3>🔧 Setting up SnapRun configuration...</h3>");
    
    // Collect basic settings
    let app_name = ask_input("Application name:");
    if app_name == "" { app_name = "My SnapRun App"; }
    
    let theme = ask_input("Preferred theme (light/dark):");
    if theme == "" { theme = "dark"; }
    
    let auto_save = ask_input("Enable auto-save? (yes/no):");
    if auto_save == "" { auto_save = "yes"; }
    
    let backup_dir = ask_input("Backup directory:");
    if backup_dir == "" { backup_dir = get_home_dir() + "/SnapRun/Backups"; }
    
    // Create configuration object
    let config = #{
        app_name: app_name,
        theme: theme.to_lower() == "light" ? "light" : "dark",
        auto_save: auto_save.to_lower() == "yes",
        backup_directory: backup_dir,
        created_at: timestamp()
    };
    
    // Save configuration
    let config_file = get_home_dir() + "/SnapRun/config.json";
    write_file(config_file, to_json(config));
    
    render_html("Configuration Complete", `
        <div class="success-panel">
            <h3>✅ Configuration Saved</h3>
            <div class="config-summary">
                <p><strong>App Name:</strong> ${config.app_name}</p>
                <p><strong>Theme:</strong> ${config.theme}</p>
                <p><strong>Auto-save:</strong> ${config.auto_save ? "Enabled" : "Disabled"}</p>
                <p><strong>Backup Directory:</strong> ${config.backup_directory}</p>
            </div>
        </div>
    `);
    
    return config;
}

let config = setup_application_config();
```

### File Operations Helper

Interactive file management:

```rust
fn interactive_file_manager() {
    info("📁 Interactive File Manager");
    
    loop {
        let action = ask_input("What would you like to do? (create/read/copy/move/exit):");
        
        if action.to_lower() == "exit" {
            info("👋 Goodbye!");
            break;
        }
        
        if action.to_lower() == "create" {
            let filename = ask_input("Enter filename to create:");
            let content = ask_input("Enter file content (or leave empty for blank file):");
            
            if filename.trim() != "" {
                write_file(filename, content);
                info("✅ Created: " + filename);
            } else {
                info("❌ Filename cannot be empty");
            }
        }
        else if action.to_lower() == "read" {
            let filename = ask_input("Enter filename to read:");
            
            if file_exists(filename) {
                let content = read_file(filename);
                render_html("File Content", `
                    <div class="file-viewer">
                        <h3>📄 ${filename}</h3>
                        <div class="content">
                            <pre>${content}</pre>
                        </div>
                    </div>
                `);
            } else {
                info("❌ File not found: " + filename);
            }
        }
        else if action.to_lower() == "copy" {
            let source = ask_input("Source file:");
            let destination = ask_input("Destination file:");
            
            if file_exists(source) {
                let content = read_file(source);
                write_file(destination, content);
                info("✅ Copied " + source + " to " + destination);
            } else {
                info("❌ Source file not found: " + source);
            }
        }
        else {
            info("❓ Unknown action: " + action);
            info("Available actions: create, read, copy, move, exit");
        }
    }
}

interactive_file_manager();
```

### Data Collection and Processing

Gather and process user information:

```rust
fn collect_user_profile() {
    info("👤 User Profile Creation");
    
    let profile = #{};
    
    // Basic information
    profile.first_name = ask_input("First Name:");
    profile.last_name = ask_input("Last Name:");
    profile.email = ask_input("Email Address:");
    
    // Professional information
    profile.job_title = ask_input("Job Title:", "Software Developer");
    profile.company = ask_input("Company:");
    profile.department = ask_input("Department:", "Engineering");
    
    // Preferences
    profile.preferred_language = ask_input("Preferred Programming Language:", "JavaScript");
    profile.experience_level = ask_input("Experience Level (Beginner/Intermediate/Advanced):", "Intermediate");
    
    // Contact preferences
    profile.phone = ask_input("Phone Number (optional):");
    profile.linkedin = ask_input("LinkedIn Profile (optional):");
    
    // Validation and defaults
    if profile.first_name.trim() == "" {
        profile.first_name = "Unknown";
    }
    if profile.last_name.trim() == "" {
        profile.last_name = "User";
    }
    
    // Generate username
    let username_suggestion = (profile.first_name + "." + profile.last_name).to_lower();
    profile.username = ask_input("Username:", username_suggestion);
    
    // Add metadata
    profile.created_at = timestamp();
    profile.profile_version = "1.0";
    
    // Save profile
    let profile_file = get_home_dir() + "/SnapRun/Profiles/" + profile.username + ".json";
    create_dir(get_home_dir() + "/SnapRun/Profiles");
    write_file(profile_file, to_json(profile));
    
    // Display summary
    render_html("Profile Created", `
        <div class="profile-summary">
            <h2>🎉 Profile Created Successfully!</h2>
            <div class="profile-card">
                <h3>${profile.first_name} ${profile.last_name}</h3>
                <p><strong>Username:</strong> ${profile.username}</p>
                <p><strong>Email:</strong> ${profile.email}</p>
                <p><strong>Title:</strong> ${profile.job_title}</p>
                <p><strong>Company:</strong> ${profile.company}</p>
                <p><strong>Experience:</strong> ${profile.experience_level}</p>
                <p><strong>Preferred Language:</strong> ${profile.preferred_language}</p>
            </div>
            <p class="save-location">💾 Saved to: ${profile_file}</p>
        </div>
    `);
    
    return profile;
}

let user_profile = collect_user_profile();
```

### Project Generator

Interactive project setup:

```rust
fn create_new_project() {
    info("🚀 SnapRun Project Generator");
    
    // Project basics
    let project_name = ask_input("Project name:");
    let project_description = ask_input("Project description:");
    let author_name = ask_input("Author name:");
    
    // Project type
    let project_types = ["automation", "data-processing", "file-management", "utilities", "other"];
    let project_type = ask_input("Project type (" + project_types.join("/") + "):", "automation");
    
    // Advanced settings
    let create_docs = ask_input("Create documentation? (yes/no):", "yes");
    let create_examples = ask_input("Include example scripts? (yes/no):", "yes");
    let git_init = ask_input("Initialize Git repository? (yes/no):", "no");
    
    // Create project structure
    let project_dir = get_home_dir() + "/SnapRun/Projects/" + project_name;
    create_dir(project_dir);
    create_dir(project_dir + "/scripts");
    
    if create_docs.to_lower() == "yes" {
        create_dir(project_dir + "/docs");
        write_file(project_dir + "/docs/README.md", `# ${project_name}\n\n${project_description}\n\nAuthor: ${author_name}`);
    }
    
    if create_examples.to_lower() == "yes" {
        create_dir(project_dir + "/examples");
        write_file(project_dir + "/examples/hello.rhai", `// Hello World Example\nprint("Hello from ${project_name}!");`);
    }
    
    // Create project manifest
    let manifest = #{
        name: project_name,
        description: project_description,
        author: author_name,
        type: project_type,
        version: "1.0.0",
        created_at: timestamp(),
        structure: #{
            has_docs: create_docs.to_lower() == "yes",
            has_examples: create_examples.to_lower() == "yes",
            has_git: git_init.to_lower() == "yes"
        }
    };
    
    write_file(project_dir + "/project.json", to_json(manifest));
    
    // Create main script
    let main_script_content = `// ${project_name} - Main Script
// ${project_description}
// Author: ${author_name}
// Created: ${timestamp()}

print("Welcome to ${project_name}!");
print("Project type: ${project_type}");

// Your automation code goes here
info("Project initialized successfully!");
`;
    
    write_file(project_dir + "/scripts/main.rhai", main_script_content);
    
    info("✅ Project created successfully!");
    info("📁 Location: " + project_dir);
    info("📝 Main script: " + project_dir + "/scripts/main.rhai");
    
    return project_dir;
}

let new_project = create_new_project();
```

## Advanced Patterns

### Input Validation with Retry Logic

```rust
fn get_validated_input(prompt, validator_fn, error_message) {
    loop {
        let input = ask_input(prompt);
        if validator_fn(input) {
            return input;
        }
        info(error_message);
    }
}

// Usage with custom validators
let email = get_validated_input(
    "Enter email:", 
    |input| input.contains("@") && input.contains("."),
    "❌ Please enter a valid email address"
);

let port = get_validated_input(
    "Enter port number (1024-65535):",
    |input| {
        let num = parse_int(input);
        num >= 1024 && num <= 65535
    },
    "❌ Port must be between 1024 and 65535"
);
```

### Multi-Step Data Collection

```rust
fn guided_setup_wizard() {
    info("🧙‍♂️ SnapRun Setup Wizard");
    let setup_data = #{};
    
    // Step 1: Personal Information
    render_html("Setup Step 1", "<h3>📝 Step 1: Personal Information</h3>");
    setup_data.name = ask_input("Your name:");
    setup_data.email = ask_input("Email address:");
    
    // Step 2: Preferences
    render_html("Setup Step 2", "<h3>🎨 Step 2: Preferences</h3>");
    setup_data.theme = ask_input("Theme preference (light/dark/auto):", "auto");
    setup_data.language = ask_input("Language (en/es/fr/de):", "en");
    
    // Step 3: Directory Setup
    render_html("Setup Step 3", "<h3>📁 Step 3: Directory Setup</h3>");
    setup_data.workspace = ask_input("Workspace directory:", get_home_dir() + "/SnapRun");
    setup_data.scripts_dir = ask_input("Scripts directory:", setup_data.workspace + "/Scripts");
    
    // Step 4: Confirmation
    render_html("Setup Complete", `
        <div class="wizard-complete">
            <h2>🎉 Setup Complete!</h2>
            <div class="summary">
                <h3>Summary:</h3>
                <ul>
                    <li><strong>Name:</strong> ${setup_data.name}</li>
                    <li><strong>Email:</strong> ${setup_data.email}</li>
                    <li><strong>Theme:</strong> ${setup_data.theme}</li>
                    <li><strong>Language:</strong> ${setup_data.language}</li>
                    <li><strong>Workspace:</strong> ${setup_data.workspace}</li>
                </ul>
            </div>
        </div>
    `);
    
    return setup_data;
}
```

## Tips and Best Practices

:::tip[User Experience]
- Keep prompts clear and concise
- Provide helpful placeholder text
- Always handle empty input gracefully
- Give users a way to cancel operations
:::

:::note[Validation]
Always validate user input, especially for:
- File paths and names
- Numeric values
- Email addresses
- Required fields
:::

## Related Functions

- **[`ask_select()`](ask_select.md)** - Present multiple choice options
- **[`render_html()`](render_html.md)** - Display formatted results
- **[`info()`](/logging/info)** - Show information messages

## Technical Notes

- **Blocking Operation**: Script execution pauses until user responds
- **String Return**: Always returns string type, convert as needed
- **Cancel Handling**: Returns empty string if dialog is cancelled
- **Whitespace**: Input is not automatically trimmed
- **Unicode Support**: Supports international characters and emojis


