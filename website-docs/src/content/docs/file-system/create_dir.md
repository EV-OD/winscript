---
title: "create_dir"
description: "Create directories including nested directory structures"
---

# create_dir Function

Create directories at specified paths, including parent directories.

## Syntax

```rust
create_dir(directory_path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `directory_path` | `string` | Yes | Full path of directory to create |

## Return Value

- **Type**: `bool`
- **Success**: `true` if directory created successfully
- **Failure**: `false` if creation failed

## Special Considerations

- Creates parent directories automatically (recursive)
- Succeeds if directory already exists
- Requires appropriate file system permissions
- Path separators: use `/` or `\\` (Windows)

## Example

```rust
// Simple directory
create_dir("output");

// Nested structure
create_dir("projects/myapp/src/components");

// With home directory
let project_dir = get_home_dir() + "/SnapRun/Projects/MyProject";
if create_dir(project_dir) {
    info("Project directory created: " + project_dir);
} else {
    info("Failed to create directory");
}
```


