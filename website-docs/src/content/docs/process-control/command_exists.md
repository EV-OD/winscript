---
title: "command_exists"
description: "Check if a command exists in PATH"
---

# command_exists

Return true if a command exists in PATH.

## Syntax

```rust
command_exists(command)
```

## Example

```rust
let ok = command_exists("notepad");
render_html("<p><strong>Exists:</strong> " + (if ok { "true" } else { "false" }) + "</p>");
```
