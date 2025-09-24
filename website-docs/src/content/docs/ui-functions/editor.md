---
title: "editor"
description: "Open files in the built-in Monaco code editor for viewing and editing"
---

# editor Function

Open files in SnapRun's built-in Monaco code editor.

## Syntax

```rust
editor(file_path)
editor(file_path, initial_content)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_path` | `string` | Yes | Path to file to open or create |
| `initial_content` | `string` | No | Initial content for new files |

## Return Value

- **Type**: `bool`
- **Success**: `true` if editor opened successfully
- **Failure**: `false` if file cannot be accessed

## Special Considerations

- Creates parent directories if they don't exist
- Supports syntax highlighting for common file types
- Changes are saved when user saves in editor
- Non-blocking operation (script continues)

## Example

```rust
// Open existing file
editor("my_script.rhai");

// Create new file with template
let template = `// New Rhai Script
info("Hello, World!");
`;
editor("new_script.rhai", template);

// Open config file
editor(get_home_dir() + "/SnapRun/config.json");
```


