---
title: "console_warn"
description: "Log a warning with console.warn label"
---

# console_warn

Log a warning message with [console.warn] label to console.

## Syntax

```rust
console_warn(message)
```

## Example

```rust
let msg = "This is a warning";
console_warn(msg);

print("[console_warn] sent=" + msg);

render_html("<h3>console_warn Demo</h3><pre>console.warn: " + msg + "</pre>");
```
