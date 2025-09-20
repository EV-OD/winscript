# timestamp Function

## Description
Returns the current system timestamp in milliseconds since the Unix epoch (January 1, 1970, 00:00:00 UTC). This function is useful for timing operations, creating unique identifiers, and timestamping data.

## Syntax
```rhai
timestamp()
```

## Parameters
- None

## Return Value
- Returns an integer representing milliseconds since Unix epoch
- The value increases with time and can be used for ordering and timing

## Examples

### Basic Timestamp Usage
```rhai
let current_time = timestamp();
info("Current timestamp: " + current_time);

// Use timestamp as unique ID
let unique_id = "task_" + timestamp();
info("Generated ID: " + unique_id);
```

### Timing Operations
```rhai
info("Starting performance measurement...");
let start_time = timestamp();

// Simulate some work
let data = [];
for i in 0..1000 {
    data.push("item_" + i);
}

let end_time = timestamp();
let duration = end_time - start_time;

info("Operation completed in: " + duration + " milliseconds");
info("Processed " + data.len() + " items");
info("Average time per item: " + (duration / data.len()) + " ms");
```

### Creating Timestamped Files
```rhai
let file_timestamp = timestamp();
let backup_filename = "backup_" + file_timestamp + ".json";

let data_to_backup = #{
    user_settings: #{
        theme: "dark",
        language: "en"
    },
    backup_info: #{
        created_at: file_timestamp,
        version: "1.0"
    }
};

write_file(backup_filename, to_json(data_to_backup));
info("Backup created: " + backup_filename);
```

### Todo List with Timestamps
```rhai
fn create_todo(title, description) {
    let todo_id = timestamp();
    
    let new_todo = #{
        id: todo_id,
        title: title,
        description: description,
        created_at: todo_id,
        completed: false,
        completed_at: ()
    };
    
    return new_todo;
}

fn complete_todo(todo) {
    todo.completed = true;
    todo.completed_at = timestamp();
    return todo;
}

// Usage
let todo1 = create_todo("Write documentation", "Create comprehensive docs for all functions");
info("Created todo: " + todo1.title + " (ID: " + todo1.id + ")");

// Simulate completing the todo later
let completed_todo = complete_todo(todo1);
let completion_time = completed_todo.completed_at - completed_todo.created_at;
info("Todo completed in: " + completion_time + " milliseconds");
```

### Data Versioning
```rhai
fn save_versioned_data(data, filename) {
    let version_timestamp = timestamp();
    
    let versioned_data = #{
        version: version_timestamp,
        created_at: version_timestamp,
        data: data
    };
    
    let versioned_filename = filename + "_v" + version_timestamp + ".json";
    write_file(versioned_filename, to_json(versioned_data));
    
    info("Saved versioned data: " + versioned_filename);
    return versioned_filename;
}

// Usage
let user_data = #{
    name: "Alice",
    preferences: #{
        theme: "dark",
        notifications: true
    }
};

let saved_file = save_versioned_data(user_data, "user_profile");
```

### Session Management
```rhai
let session_start = timestamp();
info("Session started at: " + session_start);

let session_data = #{
    session_id: session_start,
    user_actions: [],
    start_time: session_start
};

// Simulate user actions during session
let actions = ["login", "view_dashboard", "edit_profile", "save_changes"];

for action in actions {
    let action_time = timestamp();
    let action_record = #{
        action: action,
        timestamp: action_time,
        elapsed: action_time - session_start
    };
    
    session_data.user_actions.push(action_record);
    info("Action: " + action + " at +" + action_record.elapsed + "ms");
}

// End session
let session_end = timestamp();
session_data.end_time = session_end;
session_data.total_duration = session_end - session_start;

render_html("Session Summary", `
    <div style="font-family: Arial; padding: 1rem;">
        <h3>Session Summary</h3>
        <p><strong>Session ID:</strong> ${session_data.session_id}</p>
        <p><strong>Duration:</strong> ${session_data.total_duration} milliseconds</p>
        <p><strong>Actions Performed:</strong> ${session_data.user_actions.len()}</p>
        
        <h4>Action Timeline:</h4>
        <ul>
            ${session_data.user_actions.map(|action| 
                `<li>${action.action} (+${action.elapsed}ms)</li>`
            ).join("")}
        </ul>
    </div>
`);
```

### Rate Limiting
```rhai
let last_action_time = 0;
let min_interval = 1000; // Minimum 1 second between actions

fn rate_limited_action(action_name) {
    let current_time = timestamp();
    
    if current_time - last_action_time < min_interval {
        let wait_time = min_interval - (current_time - last_action_time);
        info("Rate limited. Please wait " + wait_time + "ms before next action.");
        return false;
    }
    
    last_action_time = current_time;
    info("Executing action: " + action_name + " at " + current_time);
    return true;
}

// Usage
if rate_limited_action("save_data") {
    info("Data saved successfully");
}

if rate_limited_action("send_email") {
    info("Email sent successfully");
} else {
    info("Action blocked by rate limiting");
}
```

### Log Rotation Based on Time
```rhai
fn should_rotate_log(last_rotation) {
    let current_time = timestamp();
    let rotation_interval = 24 * 60 * 60 * 1000; // 24 hours in milliseconds
    
    return (current_time - last_rotation) > rotation_interval;
}

fn rotate_log_if_needed() {
    let log_status_file = "log_status.json";
    let last_rotation = 0;
    
    if file_exists(log_status_file) {
        let status_data = parse_json(read_file(log_status_file));
        last_rotation = status_data.last_rotation ?? 0;
    }
    
    if should_rotate_log(last_rotation) {
        let rotation_time = timestamp();
        info("Rotating logs at: " + rotation_time);
        
        // Create new log status
        let new_status = #{
            last_rotation: rotation_time,
            rotation_count: (status_data.rotation_count ?? 0) + 1
        };
        
        write_file(log_status_file, to_json(new_status));
        info("Log rotation completed");
        return true;
    }
    
    info("Log rotation not needed");
    return false;
}

// Usage
rotate_log_if_needed();
```

### Performance Benchmarking
```rhai
fn benchmark_function(func_name, operation) {
    info("Benchmarking: " + func_name);
    
    let iterations = 100;
    let total_time = 0;
    let times = [];
    
    for i in 0..iterations {
        let start = timestamp();
        
        // Execute the operation (passed as closure would be ideal, but this is simulation)
        // operation(); // In real scenario, you'd execute the function here
        
        let end = timestamp();
        let duration = end - start;
        times.push(duration);
        total_time += duration;
    }
    
    let average_time = total_time / iterations;
    let min_time = times[0];
    let max_time = times[0];
    
    for time in times {
        if time < min_time { min_time = time; }
        if time > max_time { max_time = time; }
    }
    
    render_html("Benchmark Results", `
        <div style="font-family: monospace; padding: 1rem; background: #f5f5f5;">
            <h3>Benchmark: ${func_name}</h3>
            <p><strong>Iterations:</strong> ${iterations}</p>
            <p><strong>Total Time:</strong> ${total_time}ms</p>
            <p><strong>Average Time:</strong> ${average_time}ms</p>
            <p><strong>Min Time:</strong> ${min_time}ms</p>
            <p><strong>Max Time:</strong> ${max_time}ms</p>
        </div>
    `);
}

// Usage
benchmark_function("Array Creation", "create_array");
```

### Cache Expiration
```rhai
let cache = #{};
let cache_ttl = 5 * 60 * 1000; // 5 minutes in milliseconds

fn get_cached_value(key) {
    if cache.contains(key) {
        let cached_item = cache[key];
        let current_time = timestamp();
        
        if (current_time - cached_item.timestamp) < cache_ttl {
            info("Cache hit for key: " + key);
            return cached_item.value;
        } else {
            info("Cache expired for key: " + key);
            cache.remove(key);
            return ();
        }
    }
    
    info("Cache miss for key: " + key);
    return ();
}

fn set_cached_value(key, value) {
    cache[key] = #{
        value: value,
        timestamp: timestamp()
    };
    info("Cached value for key: " + key);
}

// Usage
let cached_data = get_cached_value("user_profile");
if cached_data == () {
    // Load from source
    let fresh_data = #{name: "Alice", age: 30};
    set_cached_value("user_profile", fresh_data);
    cached_data = fresh_data;
}

info("Using data: " + cached_data.name);
```

### Activity Tracking
```rhai
let activity_log = [];

fn log_activity(activity_type, details) {
    let activity = #{
        type: activity_type,
        details: details,
        timestamp: timestamp()
    };
    
    activity_log.push(activity);
    info("Activity logged: " + activity_type + " at " + activity.timestamp);
}

fn get_recent_activities(minutes) {
    let cutoff_time = timestamp() - (minutes * 60 * 1000);
    let recent_activities = [];
    
    for activity in activity_log {
        if activity.timestamp > cutoff_time {
            recent_activities.push(activity);
        }
    }
    
    return recent_activities;
}

// Usage
log_activity("user_login", "User Alice logged in");
log_activity("file_access", "Accessed config.json");
log_activity("data_export", "Exported user data to JSON");

let recent = get_recent_activities(10); // Last 10 minutes
info("Recent activities (last 10 min): " + recent.len() + " items");
```

## Time Utilities

### Human-Readable Time
```rhai
fn format_duration(milliseconds) {
    let seconds = milliseconds / 1000;
    let minutes = seconds / 60;
    let hours = minutes / 60;
    let days = hours / 24;
    
    if days >= 1 {
        return days + " days";
    } else if hours >= 1 {
        return hours + " hours";
    } else if minutes >= 1 {
        return minutes + " minutes";
    } else {
        return seconds + " seconds";
    }
}

let start = timestamp();
// ... do some work ...
let end = timestamp();
let duration = end - start;

info("Operation took: " + format_duration(duration));
```

### Timestamp Comparison
```rhai
fn is_timestamp_recent(ts, max_age_minutes) {
    let current = timestamp();
    let max_age_ms = max_age_minutes * 60 * 1000;
    
    return (current - ts) <= max_age_ms;
}

let file_timestamp = 1640995200000; // Example timestamp
let is_recent = is_timestamp_recent(file_timestamp, 60); // Within last hour?

info("File is recent: " + is_recent);
```

## Common Patterns

### Unique ID Generation
```rhai
fn generate_unique_id(prefix) {
    return prefix + "_" + timestamp();
}

let task_id = generate_unique_id("task");
let user_id = generate_unique_id("user");
```

### Retry with Timeout
```rhai
fn retry_with_timeout(operation_name, timeout_ms) {
    let start_time = timestamp();
    let attempts = 0;
    
    while (timestamp() - start_time) < timeout_ms {
        attempts += 1;
        info("Attempt " + attempts + " for: " + operation_name);
        
        // Try operation (simplified)
        let success = (attempts >= 3); // Simulate success after 3 attempts
        
        if success {
            info("Operation succeeded after " + attempts + " attempts");
            return true;
        }
    }
    
    info("Operation timed out after " + (timestamp() - start_time) + "ms");
    return false;
}
```

## Notes
- Returns milliseconds since Unix epoch (January 1, 1970, 00:00:00 UTC)
- The value is always increasing (unless system clock is adjusted)
- Precision depends on the system clock resolution
- Useful for creating unique identifiers when combined with other data
- Can be used for simple timing and performance measurements
- Values can be very large numbers (13+ digits for current timestamps)

## Related Functions
- `info()` - Log timestamp information
- `to_json()` - Serialize timestamp data
- `parse_json()` - Deserialize timestamp data
- `write_file()` - Save timestamped data
- `read_file()` - Load timestamped data
