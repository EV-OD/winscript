---
title: "remove_dir"
description: "Remove an empty directory"
---

# remove_dir Function

Remove an empty directory. For non-empty directories, use `remove_dir_all`.

## Syntax

```rust
remove_dir(path)
```
// Demo: remove_dir(path)
// What this script should do:
// 1) Create a directory, print existence, remove it, and print existence again.
// 2) Render a short HTML summary.
let base = path_join(temp_dir(), "fs_kit_demo_remove_dir");
create_dir_all(base);
print(dir_exists(base));
remove_dir(base);
print(dir_exists(base));

render_html("<p>Removed directory: <code>" + base + "</code></p>");
render_html("<p>Removed directory: <code>" + base + "</code> — " + (if ok { "OK" } else { "Failed" }) + "</p>");
```
