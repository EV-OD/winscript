---
title: "print"
description: "Log a message and return the same string"
---

# print

Log a message to console and return the same string.

## Syntax

```rust
print(message)
```

## Example

```rust
let msg = "Hello from print()";
let returned = print(msg);

print("[print] sent=" + msg);
print("[print] returned=" + returned);

render_html("<h3>print Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
```

- **Internal Function**: Registered via Rhai engine with script name context
- **Logging Integration**: Uses Logger service if available, falls back to println!
- **Script Context**: Automatically includes script name in output
- **UI Visibility**: Messages are **NOT** displayed in the SnapRun UI, only in log files

## Special Considerations

- **Log File Only**: Messages are written to log files, **NOT displayed in SnapRun UI**
- **Debugging Purpose**: Primarily for debugging and development logging
- **Script Context**: Automatically includes script name in log entries
- **No UI Feedback**: Users won't see these messages during script execution
- **Alternative**: Use `render_html()` or UI functions for user-visible output

## Example

```rust
print("=== Script Starting ===");

let name = ask_input("Your name:");
print("Hello, " + name + "!");

for i in 1..5 {
    print("Count: " + i);
}

print("=== Script Complete ===");
```


