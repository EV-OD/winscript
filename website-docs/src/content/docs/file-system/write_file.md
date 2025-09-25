---
title: "write_file"
description: "Write string content to files, creating or overwriting as needed"
---

# write_file Function

Write string content to a file, creating or overwriting existing files.

## Syntax

```rust
write_file(file_path, content)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_path` | `string` | Yes | Full path where file should be written |
| `content` | `string` | Yes | Text content to write to the file |

## Return Value

- **Type**: `bool`
- **Success**: `true` if file written successfully
- **Failure**: `false` if write operation failed

## Special Considerations

- Creates parent directories if they don't exist
- Overwrites existing files completely
- Creates new file if it doesn't exist
- Requires write permissions to target directory
- Content is written as UTF-8 text

## Example

```rust
// Demo: write_file(path, content)
// What this script should do:
// 1) Create a file and write content, then read and print it.
// 2) Append an HTML summary at the end.
let base = path_join(temp_dir(), "fs_kit_demo_write_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "hello");
print(read_file(file));

render_html("<p><strong>Wrote file:</strong> " + file + "</p>");
```


