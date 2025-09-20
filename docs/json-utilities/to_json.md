# to_json Function

## Description
Converts a Rhai data structure (object map, array, or primitive) to a JSON string.

## Syntax
```rhai
to_json(data)
```

## Parameters
- `data` (any): Rhai data structure to convert to JSON

## Return Value
- Returns a `string` containing the JSON representation
- Throws an error if the data cannot be serialized to JSON

## Examples

### Basic Object Serialization
```rhai
let user = #{
    name: "Alice",
    age: 25,
    active: true
};

let json_str = to_json(user);
info("JSON: " + json_str);
// Output: {"name":"Alice","age":25,"active":true}
```

### Array Serialization
```rhai
let fruits = ["apple", "banana", "cherry"];
let json_array = to_json(fruits);
info("Array JSON: " + json_array);
// Output: ["apple","banana","cherry"]
```

### Complex Nested Structure
```rhai
let complex_data = #{
    user: #{
        id: 123,
        profile: #{
            name: "John Doe", 
            email: "john@example.com"
        }
    },
    preferences: ["dark_theme", "auto_save"],
    settings: #{
        notifications: true,
        language: "en"
    }
};

let json_str = to_json(complex_data);
write_file("user_data.json", json_str);
```

### Save Configuration
```rhai
let config = #{
    theme: "dark",
    auto_save: true,
    timeout: 5000,
    recent_files: [
        "script1.rhai",
        "script2.rhai"
    ]
};

let config_json = to_json(config);
write_file("config/settings.json", config_json);
info("Configuration saved");
```

### Todo Data Persistence
```rhai
let new_todo = #{
    id: timestamp(),
    title: "Complete documentation",
    description: "Write docs for all functions",
    priority: "High",
    completed: false,
    created_at: timestamp()
};

// Load existing todos
let todos = [];
let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";

if file_exists(todos_file) {
    let existing_json = read_file(todos_file);
    if existing_json.trim() != "" {
        todos = parse_json(existing_json);
    }
}

// Add new todo
todos.push(new_todo);

// Save back to file
write_file(todos_file, to_json(todos));
info("Todo saved. Total todos: " + todos.len());
```

## Common Patterns

### Data Export
```rhai
let export_data = #{
    export_date: timestamp(),
    version: "1.0",
    data: #{
        users: [
            #{name: "Alice", role: "admin"},
            #{name: "Bob", role: "user"}
        ],
        settings: #{
            theme: "dark",
            language: "en"
        }
    }
};

let export_json = to_json(export_data);
write_file("exports/data_export.json", export_json);

render_html("Export Complete", `
    <div style="background: #e8f5e8; padding: 1rem; border-radius: 4px; border-left: 4px solid green;">
        <strong>Success!</strong> Data exported to JSON format.
    </div>
`);
```

### API Payload Preparation
```rhai
let api_payload = #{
    action: "create_user",
    data: #{
        username: ask_input("Enter username:"),
        email: ask_input("Enter email:"),
        role: ask_select("Select role:", ["admin", "user", "viewer"])
    },
    timestamp: timestamp()
};

let payload_json = to_json(api_payload);
info("API Payload ready: " + payload_json);
```

### Backup System
```rhai
let backup_data = #{
    backup_id: timestamp(),
    source: "SnapRun Scripts",
    files: [],
    metadata: #{
        created_by: "Backup Script",
        total_files: 0
    }
};

// Collect files to backup (pseudo-code)
let files_to_backup = ["config.json", "todos.json", "settings.json"];
for file_name in files_to_backup {
    if file_exists(file_name) {
        let file_content = read_file(file_name);
        backup_data.files.push(#{
            name: file_name,
            content: file_content,
            size: file_content.len()
        });
    }
}

backup_data.metadata.total_files = backup_data.files.len();

let backup_json = to_json(backup_data);
write_file("backups/backup_" + backup_data.backup_id + ".json", backup_json);
```

### Pretty Printing for Debugging
```rhai
let debug_data = #{
    script: "test_script",
    variables: #{
        count: 42,
        items: ["a", "b", "c"]
    },
    status: "running"
};

let debug_json = to_json(debug_data);
render_html("Debug Info", `
    <div style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
        <strong>Debug Data:</strong>
        <pre style="background: #fff; padding: 0.5rem; border-radius: 2px; overflow-x: auto;">${debug_json}</pre>
    </div>
`);
```

## Data Type Mapping

### Rhai to JSON Types
```rhai
let sample_data = #{
    string_field: "Hello World",      // -> JSON string
    int_field: 42,                    // -> JSON number
    float_field: 3.14,                // -> JSON number  
    bool_field: true,                 // -> JSON boolean
    null_field: (),                   // -> JSON null
    array_field: [1, 2, 3],           // -> JSON array
    object_field: #{nested: "value"}  // -> JSON object
};

let json_result = to_json(sample_data);
```

## Error Handling
```rhai
let problematic_data = #{
    // Some data that might not serialize well
};

try {
    let json_str = to_json(problematic_data);
    write_file("output.json", json_str);
    info("JSON serialization successful");
} catch (error) {
    render_html("Serialization Error", `
        <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
            <strong>JSON Error:</strong> ${error}<br>
            <small>Check your data structure for unsupported types</small>
        </div>
    `);
}
```

## Formatting Notes
- The output is compact (no extra whitespace)
- Keys in object maps are always quoted
- Strings are properly escaped
- Numbers are formatted appropriately
- Boolean values become `true`/`false`
- Rhai's unit type `()` becomes JSON `null`

## Notes
- All standard Rhai types are supported (strings, numbers, booleans, arrays, object maps)
- Object map keys are automatically converted to strings
- Circular references will cause errors
- Large data structures are handled efficiently
- The output is valid JSON that can be parsed by any JSON parser

## Related Functions
- `parse_json()` - Parse JSON strings back to Rhai data
- `write_file()` - Save JSON to files
- `read_file()` - Load JSON from files
