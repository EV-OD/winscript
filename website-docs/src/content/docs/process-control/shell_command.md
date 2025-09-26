---
title: "shell_command"
description: "Run a shell command (Windows: cmd /C) and return output"
---

# shell_command

Run a shell command and return stdout as a string.

## Syntax

```rust
shell_command(command)
```

## Example

```rust
let out = shell_command("dir");
render_html("<pre>" + out + "</pre>");
```
