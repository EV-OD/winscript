---
title: "remove_dir_all"
description: "Recursively remove a directory and all its contents"
---

# remove_dir_all Function

Recursively delete a directory and all of its contents.

## Syntax

```rust
remove_dir_all(path)
```

## Return Value

- Type: `bool` — `true` if removed, `false` on error

## Example

```rust
let base = path_join(temp_dir(), "fs_kit_demo_remove_dir_all/child/grand");
create_dir_all(base);
let root = path_parent(base);
let ok = remove_dir_all(root);
render_html("<p>Removed directory tree: <code>" + root + "</code> — " + (if ok { "OK" } else { "Failed" }) + "</p>");
```
