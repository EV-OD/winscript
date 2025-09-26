---
title: "run_command"
description: "Run a command and return its output as a string"
---

# run_command

Run a command and return its stdout as a string.

## Syntax

```rust
run_command(command)
```

## Example

```rust
let out = run_command("echo Hello, SnapRun");
render_html("<pre>" + out + "</pre>");
```
