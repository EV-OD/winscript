---
title: "println"
description: "Alias of print that logs a message and returns it"
---

# println

Alias of print that logs a message and returns the same text.

## Syntax

```rust
println(message)
```

## Example

```rust
let msg = "Hello from println()";
let returned = println(msg);

print("[println] sent=" + msg);
print("[println] returned=" + returned);

render_html("<h3>println Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
```
