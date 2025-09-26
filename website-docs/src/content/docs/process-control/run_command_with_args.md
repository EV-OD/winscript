---
title: "run_command_with_args"
description: "Run a command with arguments and return output"
---

# run_command_with_args

Run a command with an arguments array; returns stdout as a string.

## Syntax

```rust
run_command_with_args(command, args)
```

## Example

```rust
let out = run_command_with_args("ping", ["-n", "1", "127.0.0.1"]);
render_html("<pre>" + out + "</pre>");
```
