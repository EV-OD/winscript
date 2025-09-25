---
title: "path_extension"
description: "Get the file extension from a path"
---

# path_extension Function

Return the extension of the filename in a path (without the leading dot). Returns an empty string if there’s no extension.

## Syntax

```rust
path_extension(path)
```

## Example

```rust
// Demo: path_extension(path)
// What this script should do:
// 1) Extract and print the file extension from a sample path.
// 2) Render the result as HTML.
let ext = path_extension("C:/tmp/folder/file.txt");
print(ext);

render_html("<p><strong>Extension:</strong> " + ext + "</p>");
```
