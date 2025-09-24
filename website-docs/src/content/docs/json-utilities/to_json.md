---
title: "to_json"
description: "Convert Rhai data structures to JSON strings for data exchange and storage"
---

# to_json Function

Convert any Rhai data structure (objects, arrays, primitives) to a properly formatted JSON string. Essential for data exchange, configuration files, and API integrations.

## Syntax

```rust
to_json(data)
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `data` | `any` | The Rhai data structure to convert to JSON |

## Return Value

- **Type**: `string`
- **Content**: JSON-formatted string representation of the input data
- **Error**: Throws an error if data cannot be serialized

## Basic Examples

### Simple Object Conversion
```rust
let user = #{
    name: "Alice",
    age: 25,
    active: true
};

let json_str = to_json(user);
info("User JSON: " + json_str);
// Output: {"name":"Alice","age":25,"active":true}
```

### Array Serialization
```rust
let fruits = ["apple", "banana", "cherry"];
let json_array = to_json(fruits);
info("Fruits: " + json_array);
// Output: ["apple","banana","cherry"]
```

### Mixed Data Types
```rust
let sample_data = #{
    text: "Hello World",
    number: 42,
    decimal: 3.14,
    enabled: true,
    items: [1, 2, 3],
    config: #{
        theme: "dark",
        auto_save: true
    }
};

let json_result = to_json(sample_data);
```

## Practical Use Cases

### Configuration Management

Save application settings to JSON files:

```rust
let app_config = #{
    theme: "dark",
    auto_save: true,
    timeout: 5000,
    recent_files: [
        "script1.rhai",
        "script2.rhai",
        "config.rhai"
    ],
    window: #{
        width: 1200,
        height: 800,
        maximized: false
    }
};

let config_json = to_json(app_config);
write_file("config/settings.json", config_json);
info("Configuration saved successfully");
```

### Data Export System

Export application data for backup or transfer:

```rust
let export_data = #{
    export_info: #{
        date: timestamp(),
        version: "2.1.0",
        exported_by: "SnapRun Export Tool"
    },
    user_data: #{
        preferences: #{
            theme: "dark",
            language: "en-US",
            notifications: true
        },
        recent_activity: [
            "Opened script: hello.rhai",
            "Saved configuration",
            "Exported data"
        ]
    },
    statistics: #{
        scripts_created: 15,
        total_runtime: "2.5 hours",
        last_active: timestamp()
    }
};

let export_json = to_json(export_data);
write_file("exports/user_data_export.json", export_json);

render_html("Export Complete", `
    <div class="success-message">
        <h3>✅ Export Successful</h3>
        <p>Your data has been exported to JSON format.</p>
        <p><strong>File:</strong> exports/user_data_export.json</p>
    </div>
`);
```

### Task Management System

Create and persist todo items:

```rust
let new_task = #{
    id: timestamp(),
    title: ask_input("Task Title:", "Enter task description"),
    priority: ask_select("Priority Level:", ["High", "Medium", "Low"]),
    category: ask_select("Category:", ["Work", "Personal", "Project"]),
    created_at: timestamp(),
    completed: false,
    subtasks: []
};

// Load existing tasks
let tasks = [];
let tasks_file = get_home_dir() + "/Documents/SnapRun/tasks.json";

if file_exists(tasks_file) {
    let existing_json = read_file(tasks_file);
    if existing_json.trim() != "" {
        tasks = parse_json(existing_json);
    }
}

// Add new task
tasks.push(new_task);

// Save updated task list
write_file(tasks_file, to_json(tasks));
info("Task added! Total tasks: " + tasks.len());
```

### API Payload Preparation

Prepare data for web API calls:

```rust
let api_request = #{
    endpoint: "/api/users",
    method: "POST",
    headers: #{
        "Content-Type": "application/json",
        "Authorization": "Bearer token123"
    },
    payload: #{
        user: #{
            username: ask_input("Username:", ""),
            email: ask_input("Email:", ""),
            role: ask_select("Role:", ["admin", "user", "viewer"]),
            profile: #{
                first_name: ask_input("First Name:", ""),
                last_name: ask_input("Last Name:", ""),
                department: ask_input("Department:", "")
            }
        },
        metadata: #{
            created_by: "SnapRun User Manager",
            timestamp: timestamp()
        }
    }
};

let request_json = to_json(api_request);
info("API Request ready:");
info(request_json);
```

## Advanced Patterns

### Backup System with Compression Info

```rust
let backup_manifest = #{
    backup_id: "backup_" + timestamp(),
    created_at: timestamp(),
    source_info: #{
        total_files: 0,
        total_size: 0,
        directories_scanned: []
    },
    files: [],
    settings: #{
        compression: "gzip",
        encryption: false,
        verify_integrity: true
    }
};

// Process backup files (simplified)
let backup_files = ["important.txt", "config.json", "data.csv"];
for file_name in backup_files {
    if file_exists(file_name) {
        let content = read_file(file_name);
        backup_manifest.files.push(#{
            name: file_name,
            size: content.len(),
            checksum: "sha256hash", // Placeholder
            backed_up_at: timestamp()
        });
        backup_manifest.source_info.total_files += 1;
        backup_manifest.source_info.total_size += content.len();
    }
}

let manifest_json = to_json(backup_manifest);
write_file("backups/manifest.json", manifest_json);
info("Backup manifest created with " + backup_manifest.source_info.total_files + " files");
```

### Debug Information System

```rust
let debug_session = #{
    session_id: timestamp(),
    script_name: "data_processor.rhai",
    execution_info: #{
        start_time: timestamp(),
        variables: #{
            input_file: "data.csv",
            output_file: "processed.json",
            record_count: 150
        },
        checkpoints: [
            #{step: "File validation", status: "success", time: timestamp()},
            #{step: "Data parsing", status: "success", time: timestamp()},
            #{step: "Processing", status: "in_progress", time: timestamp()}
        ]
    },
    system_info: #{
        memory_usage: "45MB",
        cpu_usage: "12%",
        disk_space: "2.3GB available"
    }
};

let debug_json = to_json(debug_session);
render_html("Debug Dashboard", `
    <div class="debug-panel">
        <h2>🔍 Debug Session</h2>
        <div class="debug-data">
            <pre>${debug_json}</pre>
        </div>
        <button onclick="copyToClipboard()">Copy Debug Info</button>
    </div>
`);
```

## Data Type Conversion

Understanding how Rhai types map to JSON:

```rust
let type_examples = #{
    // Text → JSON String
    text_field: "Hello, World!",
    
    // Numbers → JSON Number
    integer_field: 42,
    float_field: 3.14159,
    
    // Boolean → JSON Boolean
    flag_field: true,
    enabled_field: false,
    
    // Unit Type → JSON null
    empty_field: (),
    
    // Array → JSON Array
    list_field: ["item1", "item2", "item3"],
    
    // Object Map → JSON Object
    nested_object: #{
        sub_field: "nested value",
        sub_number: 100
    }
};

let json_output = to_json(type_examples);
info("Type conversion result:");
info(json_output);
```

## Error Handling

Robust error handling for JSON conversion:

```rust
fn safe_json_export(data, filename) {
    try {
        let json_str = to_json(data);
        write_file(filename, json_str);
        
        render_html("Success", `
            <div class="success">
                ✅ JSON export successful<br>
                📁 Saved to: ${filename}
            </div>
        `);
        
        return true;
    } catch (error) {
        render_html("Export Error", `
            <div class="error">
                ❌ JSON conversion failed<br>
                🔍 Error: ${error}<br>
                💡 Check your data structure for unsupported types
            </div>
        `);
        
        return false;
    }
}

// Usage
let my_data = #{name: "test", value: 123};
safe_json_export(my_data, "output.json");
```

## Performance Tips

:::tip[Large Data Sets]
When working with large data structures:
- Process data in chunks if possible
- Consider memory usage for very large objects
- Use file streaming for massive datasets
:::

:::note[JSON Format]
The generated JSON is compact (no extra whitespace). For human-readable JSON, you may want to use external formatting tools.
:::

## Related Functions

- **[`parse_json()`](parse_json.md)** - Convert JSON strings back to Rhai data
- **[`write_file()`](/file-system/write_file)** - Save JSON data to files
- **[`read_file()`](/file-system/read_file)** - Load JSON data from files

## Technical Notes

- **Output Format**: Compact JSON without extra whitespace
- **Key Quoting**: Object map keys are automatically quoted
- **Escaping**: String values are properly escaped
- **Circular References**: Not supported - will cause errors
- **Memory Efficient**: Handles large data structures efficiently
- **Standards Compliant**: Generates valid JSON compatible with all parsers


