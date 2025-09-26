---
title: "exec_command"
description: "Execute a command and get stdout, stderr, exit_code, success"
---

# exec_command

Execute a command and get a map with stdout, stderr, exit_code, success.

## Syntax

```rust
exec_command(command)
```

## Example

```rust
let info = exec_command("ping -n 1 127.0.0.1");
render_html(
  "<ul>" +
  "<li><strong>Exit:</strong> " + info.exit_code + "</li>" +
  "<li><strong>Success:</strong> " + (if info.success { "true" } else { "false" }) + "</li>" +
  "</ul><pre>" + info.stdout + "</pre>"
);
```
