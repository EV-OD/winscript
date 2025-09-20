# parse_json Function

## Description
Parses a JSON string and converts it to a Rhai data structure (object map or array).

## Syntax
```rhai
parse_json(json_string)
```

## Parameters
- `json_string` (string): Valid JSON string to parse

## Return Value
- Returns a Rhai data structure corresponding to the JSON
- Objects become Rhai object maps (`#{}`)
- Arrays become Rhai arrays (`[]`)
- Throws an error if the JSON is invalid

## Examples

### Basic JSON Parsing
```rhai
let json_str = `{"name": "Alice", "age": 25, "active": true}`;
let data = parse_json(json_str);

info("Name: " + data.name);
info("Age: " + data.age);
info("Active: " + data.active);
```

### Array Parsing
```rhai
let json_array = `["apple", "banana", "cherry"]`;
let fruits = parse_json(json_array);

for fruit in fruits {
    info("Fruit: " + fruit);
}
```

### Complex Nested Structure
```rhai
let complex_json = `{
    "user": {
        "id": 123,
        "profile": {
            "name": "John Doe",
            "email": "john@example.com"
        }
    },
    "preferences": ["dark_theme", "auto_save"],
    "settings": {
        "notifications": true,
        "language": "en"
    }
}`;

let data = parse_json(complex_json);
info("User name: " + data.user.profile.name);
info("First preference: " + data.preferences[0]);
info("Notifications: " + data.settings.notifications);
```

### Configuration File Loading
```rhai
let config_file = "config/app_settings.json";
if file_exists(config_file) {
    let config_json = read_file(config_file);
    let config = parse_json(config_json);
    
    info("Theme: " + config.theme);
    info("Auto-save: " + config.auto_save);
    info("Timeout: " + config.timeout);
} else {
    info("Config file not found");
}
```

### Todo Data Loading
```rhai
let todos_file = get_home_dir() + "/Documents/SnapRun/Todos/todos.json";
let todos = [];

if file_exists(todos_file) {
    try {
        let todos_json = read_file(todos_file);
        if todos_json.trim() != "" {
            todos = parse_json(todos_json);
        }
        info("Loaded " + todos.len() + " todos");
    } catch (error) {
        info("Error parsing todos: " + error);
        todos = [];
    }
}
```

## Error Handling
Always use try-catch when parsing JSON to handle invalid data:

```rhai
let suspicious_json = read_file("user_data.json");

try {
    let data = parse_json(suspicious_json);
    info("Valid JSON loaded");
    // Process data
} catch (error) {
    render_html("JSON Error", `
        <div style="color: red; padding: 1rem; border: 1px solid red; border-radius: 4px;">
            <strong>Invalid JSON:</strong> ${error}<br>
            <small>Please check the file format</small>
        </div>
    `);
}
```

## Common Patterns

### Default Values for Missing Keys
```rhai
let config_json = read_file("config.json");
let config = parse_json(config_json);

// Provide defaults for missing values
let theme = config.contains("theme") ? config.theme : "light";
let auto_save = config.contains("auto_save") ? config.auto_save : false;
let timeout = config.contains("timeout") ? config.timeout : 5000;
```

### API Response Processing
```rhai
// Simulating API response
let api_response = `{
    "status": "success",
    "data": {
        "users": [
            {"id": 1, "name": "Alice"},
            {"id": 2, "name": "Bob"}
        ]
    },
    "total": 2
}`;

let response = parse_json(api_response);

if response.status == "success" {
    info("Found " + response.total + " users:");
    for user in response.data.users {
        info("  - " + user.name + " (ID: " + user.id + ")");
    }
}
```

### Data Migration
```rhai
let old_format_json = read_file("old_data.json");
let old_data = parse_json(old_format_json);

// Convert to new format
let new_data = #{
    version: "2.0",
    migrated_at: timestamp(),
    users: []
};

// Migrate old user data
for old_user in old_data.users {
    let new_user = #{
        id: old_user.user_id,  // Field name changed
        name: old_user.username,  // Field name changed
        active: old_user.is_active != null ? old_user.is_active : true
    };
    new_data.users.push(new_user);
}

write_file("new_data.json", to_json(new_data));
```

## Data Type Mapping

### JSON to Rhai Types
```rhai
let sample_json = `{
    "string_field": "Hello World",
    "number_field": 42,
    "float_field": 3.14,
    "boolean_field": true,
    "null_field": null,
    "array_field": [1, 2, 3],
    "object_field": {"nested": "value"}
}`;

let data = parse_json(sample_json);

// All types are automatically converted:
// string -> Rhai string
// number -> Rhai integer or float
// boolean -> Rhai boolean  
// null -> Rhai unit type ()
// array -> Rhai array
// object -> Rhai object map
```

## Notes
- Supports full JSON specification including nested objects and arrays
- Null values in JSON become Rhai's unit type `()`
- Numbers are automatically converted to appropriate Rhai numeric types
- Object keys become accessible as Rhai object map properties
- Use `.contains(key)` to check if an object has a specific key
- Invalid JSON will throw a runtime error - always use try-catch

## Related Functions
- `to_json()` - Convert Rhai data to JSON string
- `read_file()` - Read JSON from files
- `write_file()` - Save JSON to files
