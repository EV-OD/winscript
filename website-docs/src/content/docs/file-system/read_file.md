---
title: "read_file"
description: "Read the complete contents of a file as a string"
---

# read_file Function

Read the entire contents of a file as a string.

## Syntax

```rust
read_file(file_path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_path` | `string` | Yes | Full path to the file to read |

## Return Value

- **Type**: `string`
- **Content**: Complete file contents as text
- **Error**: Throws error if file cannot be read

## Special Considerations

- Reads entire file into memory at once
- Supports text files with any encoding
- Binary files may not display correctly
- File must exist and be readable
- Large files may impact performance

## Example

```rust
// Demo: read_file(path)
// What this script should do:
// 1) Create a file with content, then read and print it.
// 2) Render the content as HTML at the end.
let base = path_join(temp_dir(), "fs_kit_demo_read_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "hello");
print(read_file(file));

let content = read_file(file);
render_html("<p><strong>Read content:</strong> " + content + "</p>");
```


