# print Function

## Description
Alternative output function that sends messages to the console. Similar to `info()` but may have slightly different formatting or handling in the SnapRun environment.

## Syntax
```rhai
print(message)
```

## Parameters
- `message` (string): The message to output

## Return Value
- Returns nothing (unit type `()`)
- Message appears in SnapRun's console output

## Examples

### Basic Output
```rhai
print("Hello from SnapRun!");
print("Current timestamp: " + timestamp());
```

### Simple Debug Output
```rhai
let user_input = ask_input("Enter a value:");
print("You entered: " + user_input);

let squared = user_input * user_input;
print("Squared result: " + squared);
```

### Quick Variable Display
```rhai
let config = #{
    version: "1.0",
    debug: true
};

print("Version: " + config.version);
print("Debug mode: " + config.debug);
```

### Loop Output
```rhai
let numbers = [1, 2, 3, 4, 5];

print("Processing numbers:");
for num in numbers {
    print("Number: " + num);
}
```

### File Processing Output
```rhai
let file_path = "test.txt";

if file_exists(file_path) {
    let content = read_file(file_path);
    print("File content length: " + content.len());
} else {
    print("File not found: " + file_path);
}
```

### Function Results
```rhai
fn calculate_area(width, height) {
    let area = width * height;
    print("Calculated area: " + area);
    return area;
}

let result = calculate_area(10, 20);
print("Final result: " + result);
```

### Error Reporting
```rhai
try {
    let data = parse_json("invalid json");
} catch (error) {
    print("JSON parsing failed: " + error);
}
```

### Conditional Output
```rhai
let verbose = true;

if verbose {
    print("Verbose mode enabled");
    print("Starting detailed processing...");
}

let result = 42;
print("Result: " + result);

if verbose {
    print("Processing completed");
}
```

### Array Information
```rhai
let items = ["apple", "banana", "cherry"];

print("Array contents:");
for i in 0..items.len() {
    print("  [" + i + "] = " + items[i]);
}
print("Total items: " + items.len());
```

### Object Map Display
```rhai
let person = #{
    name: "Alice",
    age: 30,
    city: "New York"
};

print("Person information:");
print("  Name: " + person.name);
print("  Age: " + person.age);
print("  City: " + person.city);
```

## Common Patterns

### Quick Debugging
```rhai
fn debug_var(name, value) {
    print(name + " = " + value);
}

let x = 42;
let y = "hello";
debug_var("x", x);
debug_var("y", y);
```

### Simple Progress
```rhai
let tasks = ["init", "process", "save"];

for i in 0..tasks.len() {
    print("Step " + (i + 1) + ": " + tasks[i]);
    // ... perform task ...
}
print("All tasks completed");
```

### Value Checking
```rhai
let config = parse_json(read_file("config.json"));

print("Config loaded:");
print("Theme: " + (config.theme ?? "default"));
print("Auto-save: " + (config.auto_save ?? false));
```

### Simple Logging
```rhai
fn log(message) {
    print("[" + timestamp() + "] " + message);
}

log("Script started");
log("Processing data...");
log("Script finished");
```

## Comparison with info()

### Similarities
- Both output text to console
- Both accept string parameters
- Both execute immediately
- Both support all string formatting

### Potential Differences
- May have different formatting in console
- Could have different log levels or categories
- Might be handled differently by SnapRun's logging system
- May appear in different console sections

### Usage Recommendations
```rhai
// Use info() for:
info("Script status: Initializing...");
info("User action: File saved");
info("Error: Could not access file");

// Use print() for:
print("Quick value: " + some_value);
print("Debug output");
print("Simple messages");
```

## Best Practices
- Use for simple, quick output
- Good for debugging during development
- Use `info()` for more formal logging
- Keep messages concise
- Include relevant context when needed

## Notes
- Simpler alternative to `info()` function
- May be more familiar to developers from other languages
- Behavior may vary slightly depending on SnapRun configuration
- Both `print()` and `info()` are available in SnapRun scripts
- Messages appear immediately in the console

## Related Functions
- `info()` - Primary logging function with potentially richer formatting
- `render_html()` - For formatted output to UI
- `ask_input()` - For getting user input
- `ask_select()` - For user selection dialogs
