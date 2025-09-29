---
title: "log"
description: "Alias of print that logs a message and returns it"
---

# log

Alias of print that logs a message and returns the same text.

## Syntax

```rust
log(message)
```

## Example

```rust
let msg = "Hello from log()";
let returned = log(msg);

print("[log] sent=" + msg);
print("[log] returned=" + returned);

render_html("<h3>log Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
```
