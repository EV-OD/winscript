---
title: "info"
description: "Log an informational message"
---

# info

Log an informational message to the console.

## Syntax

```rust
info(message)
```

## Example

```rust
let msg = "Informational message from info()";
info(msg);

print("[info] sent=" + msg);

render_html("<h3>info Demo</h3><pre>info: " + msg + "</pre>");
```
- **Logging Level**: Uses `LogLevel::Info` in the logging system
- **Format**: `ℹ️ 📜 {script_name}: {message}` (when no logger available)

## Special Considerations

- **Log File Only**: Messages are written to log files, **NOT displayed in SnapRun UI**
- **INFO Level**: Uses INFO logging level with timestamp
- **Script Context**: Automatically includes script name in log entries
- **Debugging Purpose**: For development and troubleshooting
- **User Feedback**: Use `render_html()` or UI functions for user-visible messages
- Does not pause script execution

## Example

```rust
info("Script execution started");

let count = 0;
for i in 1..10 {
    count += i;
    info("Processing item " + i + ", total: " + count);
}

if file_exists("data.json") {
    info("Configuration file found");
} else {
    info("No configuration file, using defaults");
}

info("Script completed successfully");
```


