---
title: "list_dir"
description: "List directory contents with file metadata"
---

# list_dir Function

List the contents of a directory. Each entry contains name, path, flags, and size for files.

## Syntax

```rust
list_dir(path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | `string` | Yes | Directory path to list |

## Return Value

- Type: `array<object>`
- Each item includes: `name` (string), `path` (string), `is_dir` (bool), `is_file` (bool), `size` (int for files)

## Example

```rust
let base = path_join(temp_dir(), "fs_kit_demo_list_dir");
create_dir_all(base);
write_file(path_join(base, "a.txt"), "a");
create_dir_all(path_join(base, "sub"));
let items = list_dir(base);

let html = "<h3>Directory listing for: " + base + "</h3><ul>";
for item in items {
  html += "<li>" + item.name + (if item.is_dir { " (dir)" } else { " (file)" }) + "</li>";
}
html += "</ul>";
render_html(html);
```
