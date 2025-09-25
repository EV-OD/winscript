---
title: "file_size"
description: "Get the size of a file in bytes"
---

# file_size Function

Get the file size in bytes.

## Syntax

```rust
file_size(path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | `string` | Yes | File path |

## Return Value

- Type: `int`
- File size in bytes, or `-1` on error

## Example

```rust
let base = path_join(temp_dir(), "fs_kit_demo_file_size");
create_dir_all(base);
let file = path_join(base, "a.txt");
write_file(file, "xyz");
let size = file_size(file);
render_html("<p><strong>File:</strong> " + file + "<br><strong>Size:</strong> " + size + " bytes</p>");
```
