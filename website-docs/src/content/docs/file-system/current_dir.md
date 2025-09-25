---
title: "current_dir"
description: "Get the current working directory path"
---

# current_dir Function

Return the current working directory.

## Syntax

```rust
current_dir()
```

## Example

```rust
// Demo: current_dir()
// What this script should do:
// 1) Print the current working directory to the console.
// 2) Render a minimal HTML summary.
print(current_dir());

let cwd = current_dir();
render_html("<p><strong>Current directory:</strong> " + cwd + "</p>");
```
