---
title: "file_exists"
description: "Check if files or directories exist at specified paths"
---

# file_exists Function

Check if a file (not directory) exists at the specified path.

## Syntax

```rust
file_exists(path)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `path` | `string` | Yes | Full path to file to check |

## Return Value

- **Type**: `bool`
- **Exists**: `true` if file exists
- **Missing**: `false` if path does not exist or is a directory

## Implementation Details

- **File Check**: Uses `Path::new(path).exists() && Path::new(path).is_file()`
- **Directory Behavior**: Returns `false` for directories (use separate directory check functions)
- **Symlinks**: Follows symbolic links to check final target

## Special Considerations

- **Files Only**: Only returns `true` for files, not directories
- Case-sensitive on Unix systems  
- Checks actual file system (not cached)
- Requires read permissions on parent directory

## Example

```rust
// Check config file
if file_exists("config.json") {
    let config = read_file("config.json");
} else {
    info("Config file missing, creating default...");
    write_file("config.json", "{}");
}

// Check directory
let backup_dir = get_home_dir() + "/Backups";
if !file_exists(backup_dir) {
    create_dir(backup_dir);
    info("Backup directory created");
}
```


