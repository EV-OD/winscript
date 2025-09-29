---
title: "print_void"
description: "Log a message and return nothing"
---

# print_void

Log a message to console and return nothing (void).

## Syntax

```rust
print_void(message)
```

## Example

```rust
let msg = "Hello from print_void()";
print_void(msg);

print("[print_void] sent=" + msg);

render_html("<h3>print_void Demo</h3><pre>sent: " + msg + "\nreturned: (void)</pre>");
```
