---
title: "info"
description: "Output informational messages to SnapRun's console and log system"
---

# info Function

Output informational messages to SnapRun's console and log system.

## Syntax

```rust
info(message)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `message` | `string` | Yes | The informational message to log |

## Return Value

- **Type**: `()` (unit/void)
- **Output**: Message written to log file only (not visible in UI)
- **Logging**: Message saved to application logs with INFO level

## Implementation Details

- **Internal Function**: Registered via Rhai engine with script name context
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


