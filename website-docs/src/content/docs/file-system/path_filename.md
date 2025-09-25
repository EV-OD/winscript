---
title: "path_filename"
description: "Extract the filename from a path"
---

# path_filename Function

Return just the filename component of a path.

## Syntax

```rust
path_filename(path)
```

## Example

```rust
// Demo: path_filename(path)
// What this script should do:
// 1) Extract and print the filename from a sample path.
// 2) Render the result as HTML.
let name = path_filename("C:/tmp/folder/file.txt");
print(name);

render_html("<p><strong>Filename:</strong> " + name + "</p>");
```
