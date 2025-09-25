---
title: "temp_dir"
description: "Get the temporary directory path"
---

# temp_dir Function

Return the system temporary directory path.

## Syntax

```rust
temp_dir()
```

## Example

```rust
// Demo: temp_dir()
// What this script should do:
// 1) Print the temporary directory path to the console.
// 2) Render the same info as HTML.
print(temp_dir());

let td = temp_dir();
render_html("<p><strong>Temp directory:</strong> " + td + "</p>");
```
