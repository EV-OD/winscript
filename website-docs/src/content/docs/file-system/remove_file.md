---
title: "remove_file"
description: "Delete a file at the specified path"
---

# remove_file Function

Remove (delete) a file from the file system.

## Syntax

```rust
remove_file(path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | `string` | Yes | Path to the file to delete |

## Return Value

- Type: `bool`
- `true` if removed, `false` on error

## Example

```rust
// Demo: remove_file(path)
// What this script should do:
// 1) Create a file, print existence, delete it, then print existence again.
// 2) Render a short HTML summary.
let base = path_join(temp_dir(), "fs_kit_demo_remove_file");
create_dir_all(base);
let file = path_join(base, "a.txt");
write_file(file, "x");
print(file_exists(file));
remove_file(file);
print(file_exists(file));

render_html("<p>Removed file: <code>" + file + "</code></p>");
```
