---
title: "console_error"
description: "Log an error with console.error label"
---

# console_error

Log an error message with [console.error] label to console.

## Syntax

```rust
console_error(message)
```

## Example

```rust
let msg = "Something went wrong";
console_error(msg);

print("[console_error] sent=" + msg);

render_html("<h3>console_error Demo</h3><pre>console.error: " + msg + "</pre>");
```
