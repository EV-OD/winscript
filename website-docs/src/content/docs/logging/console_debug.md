---
title: "console_debug"
description: "Log a debug message with console.debug label"
---

# console_debug

Log a debug message with [console.debug] label to console.

## Syntax

```rust
console_debug(message)
```

## Example

```rust
let msg = "Debug details";
console_debug(msg);

print("[console_debug] sent=" + msg);

render_html("<h3>console_debug Demo</h3><pre>console.debug: " + msg + "</pre>");
```
