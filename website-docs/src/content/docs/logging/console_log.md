---
title: "console_log"
description: "Log a message with console.log label"
---

# console_log

Log a message with [console.log] label to console.

## Syntax

```rust
console_log(message)
```

## Example

```rust
let msg = "Console log message";
console_log(msg);

print("[console_log] sent=" + msg);

render_html("<h3>console_log Demo</h3><pre>console.log: " + msg + "</pre>");
```
