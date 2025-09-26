---
title: "which_command"
description: "Find the full path of a command in PATH"
---

# which_command

Return the full path of a command if found, otherwise "Command not found".

## Syntax

```rust
which_command(command)
```

## Example

```rust
let path = which_command("notepad");
render_html("<pre>" + path + "</pre>");
```
