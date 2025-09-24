---
title: "parse_json"
description: "Parse JSON strings and convert them to Rhai data structures for processing"
---

# parse_json Function

Convert JSON strings into Rhai data structures for easy manipulation and processing. Essential for working with configuration files, API responses, and data exchange.

## Syntax

```rust
parse_json(json_string)
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `json_string` | `string` | Valid JSON string to parse into Rhai data |

## Return Value

- **Type**: Rhai data structure (object map, array, or primitive)
- **Objects**: Become Rhai object maps (`#{}`)
- **Arrays**: Become Rhai arrays (`[]`)
- **Error**: Throws runtime error for invalid JSON

## Basic Examples

### Simple Object Parsing
```rust
let json_str = `{"name": "Alice", "age": 25, "active": true}`;
let user = parse_json(json_str);

info("Name: " + user.name);       // "Alice"
info("Age: " + user.age);         // 25
info("Active: " + user.active);   // true
```

### Array Processing
```rust
let json_array = `["apple", "banana", "cherry", "date"]`;
let fruits = parse_json(json_array);

info("Total fruits: " + fruits.len());
for fruit in fruits {
    info("🍎 " + fruit);
}
```

### Complex Data Structures
```rust
let complex_json = `{
    "project": {
        "name": "SnapRun Documentation",
        "version": "2.1.0",
        "contributors": ["Alice", "Bob", "Charlie"]
    },
    "settings": {
        "theme": "dark",
        "auto_save": true,
        "backup_interval": 3600
    },
    "recent_files": [
        {"name": "script1.rhai", "modified": "2024-01-15"},
        {"name": "config.json", "modified": "2024-01-14"}
    ]
}`;

let data = parse_json(complex_json);
info("Project: " + data.project.name + " v" + data.project.version);
info("Contributors: " + data.project.contributors.len());
info("Theme: " + data.settings.theme);
info("Recent files: " + data.recent_files.len());
```

## Practical Use Cases

### Configuration File Loading

Load and process application settings:

```rust
let config_file = get_home_dir() + "/SnapRun/config.json";
let default_config = #{
    theme: "light",
    auto_save: true,
    timeout: 5000,
    recent_files: [],
    window: #{
        width: 1200,
        height: 800,
        maximized: false
    }
};

let config = default_config;  // Start with defaults

if file_exists(config_file) {
    try {
        let config_json = read_file(config_file);
        let loaded_config = parse_json(config_json);
        
        // Merge with loaded settings
        config.theme = loaded_config.contains("theme") ? 
                      loaded_config.theme : config.theme;
        config.auto_save = loaded_config.contains("auto_save") ? 
                          loaded_config.auto_save : config.auto_save;
        config.timeout = loaded_config.contains("timeout") ? 
                        loaded_config.timeout : config.timeout;
        
        info("✅ Configuration loaded successfully");
    } catch (error) {
        info("⚠️ Using default configuration - " + error);
    }
}

info("Current theme: " + config.theme);
info("Auto-save: " + config.auto_save);
```

### Task Management System

Load and process todo items:

```rust
fn load_tasks() {
    let tasks_file = get_home_dir() + "/Documents/SnapRun/tasks.json";
    let tasks = [];
    
    if file_exists(tasks_file) {
        try {
            let tasks_json = read_file(tasks_file);
            if tasks_json.trim() != "" {
                tasks = parse_json(tasks_json);
            }
            
            info("📋 Loaded " + tasks.len() + " tasks");
            
            // Process tasks
            let completed = 0;
            let pending = 0;
            
            for task in tasks {
                if task.completed {
                    completed += 1;
                } else {
                    pending += 1;
                }
            }
            
            render_html("Task Summary", `
                <div class="task-summary">
                    <h3>📊 Task Overview</h3>
                    <div class="stats">
                        <div class="stat">
                            <span class="number">${tasks.len()}</span>
                            <span class="label">Total Tasks</span>
                        </div>
                        <div class="stat completed">
                            <span class="number">${completed}</span>
                            <span class="label">Completed</span>
                        </div>
                        <div class="stat pending">
                            <span class="number">${pending}</span>
                            <span class="label">Pending</span>
                        </div>
                    </div>
                </div>
            `);
            
            return tasks;
        } catch (error) {
            info("❌ Error loading tasks: " + error);
        }
    } else {
        info("📝 No tasks file found - starting fresh");
    }
    
    return tasks;
}

let my_tasks = load_tasks();
```

### API Response Processing

Handle and process API responses:

```rust
// Simulate API response data
let api_response = `{
    "status": "success",
    "message": "User data retrieved successfully",
    "data": {
        "users": [
            {
                "id": 1,
                "name": "Alice Johnson",
                "email": "alice@example.com",
                "role": "admin",
                "last_login": "2024-01-15T10:30:00Z"
            },
            {
                "id": 2,
                "name": "Bob Smith", 
                "email": "bob@example.com",
                "role": "user",
                "last_login": "2024-01-14T15:45:00Z"
            }
        ],
        "pagination": {
            "current_page": 1,
            "total_pages": 3,
            "per_page": 10,
            "total_records": 25
        }
    }
}`;

try {
    let response = parse_json(api_response);
    
    if response.status == "success" {
        let users = response.data.users;
        let pagination = response.data.pagination;
        
        info("✅ API Success: " + response.message);
        info("👥 Found " + users.len() + " users (Page " + 
             pagination.current_page + " of " + pagination.total_pages + ")");
        
        // Process user data
        for user in users {
            let role_icon = user.role == "admin" ? "👑" : "👤";
            info(role_icon + " " + user.name + " (" + user.email + ")");
        }
        
        // Generate user report
        render_html("User Report", `
            <div class="user-report">
                <h2>📊 User Data Report</h2>
                <div class="summary">
                    <p><strong>Total Records:</strong> ${pagination.total_records}</p>
                    <p><strong>Current Page:</strong> ${pagination.current_page} of ${pagination.total_pages}</p>
                </div>
                <div class="users">
                    ${users.map(u => `
                        <div class="user-card">
                            <h3>${u.name}</h3>
                            <p>Email: ${u.email}</p>
                            <p>Role: ${u.role}</p>
                            <p>Last Login: ${u.last_login}</p>
                        </div>
                    `).join('')}
                </div>
            </div>
        `);
    } else {
        info("❌ API Error: " + response.message);
    }
} catch (error) {
    info("🔥 JSON Parsing Error: " + error);
}
```

### Data Migration and Transformation

Convert between different data formats:

```rust
fn migrate_user_data() {
    let old_data_file = "legacy/users_v1.json";
    let new_data_file = "data/users_v2.json";
    
    if !file_exists(old_data_file) {
        info("❌ Legacy data file not found: " + old_data_file);
        return;
    }
    
    try {
        let old_json = read_file(old_data_file);
        let old_data = parse_json(old_json);
        
        info("🔄 Starting migration from v1 to v2 format");
        info("📊 Found " + old_data.users.len() + " users to migrate");
        
        // Create new format structure
        let new_data = #{
            format_version: "2.0",
            migrated_at: timestamp(),
            migration_info: #{
                source_version: "1.0",
                records_processed: 0,
                errors: []
            },
            users: []
        };
        
        // Migrate each user
        for old_user in old_data.users {
            try {
                let new_user = #{
                    id: old_user.user_id,           // Renamed field
                    username: old_user.login_name,   // Renamed field
                    email: old_user.email_address,   // Renamed field
                    profile: #{
                        full_name: old_user.display_name,
                        created_at: old_user.created_date,
                        last_active: old_user.last_seen
                    },
                    permissions: #{
                        is_admin: old_user.admin_role == 1,
                        can_edit: old_user.edit_rights == true,
                        can_delete: old_user.delete_rights == true
                    },
                    preferences: #{
                        theme: old_user.ui_theme != null ? old_user.ui_theme : "light",
                        language: old_user.locale != null ? old_user.locale : "en"
                    }
                };
                
                new_data.users.push(new_user);
                new_data.migration_info.records_processed += 1;
            } catch (user_error) {
                let error_info = "User ID " + old_user.user_id + ": " + user_error;
                new_data.migration_info.errors.push(error_info);
                info("⚠️ Migration error: " + error_info);
            }
        }
        
        // Save migrated data
        let new_json = to_json(new_data);
        write_file(new_data_file, new_json);
        
        info("✅ Migration completed!");
        info("📈 Successfully migrated: " + new_data.migration_info.records_processed);
        info("❌ Errors encountered: " + new_data.migration_info.errors.len());
        
        if new_data.migration_info.errors.len() > 0 {
            info("Error details:");
            for error in new_data.migration_info.errors {
                info("  - " + error);
            }
        }
        
    } catch (error) {
        info("💥 Migration failed: " + error);
    }
}

migrate_user_data();
```

## Data Type Conversion

Understanding JSON to Rhai type mapping:

```rust
let type_demo_json = `{
    "text_value": "Hello, World!",
    "integer_value": 42,
    "float_value": 3.14159,
    "boolean_true": true,
    "boolean_false": false,
    "null_value": null,
    "array_value": [1, "two", true, null],
    "nested_object": {
        "inner_text": "nested",
        "inner_number": 100
    }
}`;

let data = parse_json(type_demo_json);

// Demonstrate type conversions
info("String: '" + data.text_value + "' (type: " + type_of(data.text_value) + ")");
info("Integer: " + data.integer_value + " (type: " + type_of(data.integer_value) + ")");
info("Float: " + data.float_value + " (type: " + type_of(data.float_value) + ")");
info("Boolean (true): " + data.boolean_true + " (type: " + type_of(data.boolean_true) + ")");
info("Boolean (false): " + data.boolean_false + " (type: " + type_of(data.boolean_false) + ")");
info("Null value: " + data.null_value + " (type: " + type_of(data.null_value) + ")");
info("Array length: " + data.array_value.len());
info("Nested object access: " + data.nested_object.inner_text);
```

## Advanced Error Handling

Robust JSON parsing with comprehensive error handling:

```rust
fn safe_json_parse(json_string, context_name) {
    if json_string == null || json_string.trim() == "" {
        info("⚠️ Empty JSON data for " + context_name);
        return null;
    }
    
    try {
        let parsed_data = parse_json(json_string);
        info("✅ Successfully parsed JSON for " + context_name);
        return parsed_data;
    } catch (error) {
        let error_msg = "JSON parsing failed for " + context_name + ": " + error;
        info("❌ " + error_msg);
        
        render_html("JSON Parse Error", `
            <div class="error-panel">
                <h3>🔥 JSON Parsing Error</h3>
                <div class="error-details">
                    <p><strong>Context:</strong> ${context_name}</p>
                    <p><strong>Error:</strong> ${error}</p>
                </div>
                <div class="suggestions">
                    <h4>💡 Suggestions:</h4>
                    <ul>
                        <li>Check for proper JSON syntax (quotes, commas, brackets)</li>
                        <li>Validate JSON using an online JSON validator</li>
                        <li>Ensure file encoding is UTF-8</li>
                        <li>Check for trailing commas or missing brackets</li>
                    </ul>
                </div>
            </div>
        `);
        
        return null;
    }
}

// Usage examples
let config_data = safe_json_parse(read_file("config.json"), "Application Config");
let user_data = safe_json_parse(read_file("users.json"), "User Data");
let api_response = safe_json_parse(api_call_result, "API Response");
```

## Performance Considerations

:::tip[Large JSON Files]
For very large JSON files:
- Consider processing in chunks
- Monitor memory usage
- Use streaming approaches for massive datasets
:::

:::note[Validation]
Always validate JSON structure before accessing nested properties:
```rust
if data.contains("user") && data.user.contains("profile") {
    let name = data.user.profile.name;
}
```
:::

## Related Functions

- **[`to_json()`](to_json.md)** - Convert Rhai data structures to JSON strings
- **[`read_file()`](/file-system/read_file)** - Read JSON files from disk
- **[`write_file()`](/file-system/write_file)** - Save processed data to files

## Technical Notes

- **JSON Compliance**: Supports full JSON specification including nested structures
- **Type Mapping**: Automatic conversion to appropriate Rhai types
- **Null Handling**: JSON `null` becomes Rhai unit type `()`
- **Key Access**: Object keys become accessible as Rhai object map properties
- **Error Safety**: Invalid JSON throws runtime errors - always use try-catch
- **Memory Efficient**: Handles large JSON structures efficiently


