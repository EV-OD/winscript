---
title: "append_file"
description: "Append text to the end of a file, creating it if it doesn't exist"
---

# append_file Function

Append content to an existing file. If the file doesn't exist, it will be created.

## Syntax

```rust
append_file(path, content)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | `string` | Yes | Full path to the file |
| `content` | `string` | Yes | Text to append to the file |

## Return Value

- Type: `bool`
- `true` on success, `false` if append fails

## Example

```rust
// Create then append, show the final content in UI
let base = path_join(temp_dir(), "fs_kit_demo_append_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "a");
append_file(file, "b");

let final_content = read_file(file);
let html = "<h2>Append File Demo</h2>" +
    "<ul>" +
    "<li><strong>File:</strong> " + file + "</li>" +
    "<li><strong>Final content:</strong> " + final_content + "</li>" +
    "</ul>";
render_html(html);
```

## Notes

- Uses append mode; does not overwrite existing content
- Creates the file if it doesn't exist
