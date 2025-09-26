---
title: "spawn_process"
description: "Start a process without waiting for it to finish"
---

# spawn_process

Spawn a process (non-blocking) and return a status string.

## Syntax

```rust
spawn_process(command)
```

## Example

```rust
let msg = spawn_process("notepad.exe");
render_html("<p>" + msg + "</p>");
```
