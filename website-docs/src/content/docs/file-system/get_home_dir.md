---
title: "get_home_dir"
description: "Get the current user's home directory path"
---

# get_home_dir Function

Get the absolute path to the current user's home directory.

## Syntax

```rust
get_home_dir()
```

## Parameters

No parameters required.

## Return Value

- **Type**: `string`
- **Content**: Absolute path to user's home directory
- **Format**: Platform-specific path format

## Special Considerations

- Returns platform-appropriate home directory
- **Windows**: `C:\Users\{username}` (via `%USERPROFILE%`)
- **macOS/Linux**: `/home/{username}` or `/Users/{username}` (via `$HOME`)
- Always returns absolute path
- Path uses system path separators

## Implementation Details

- **Function Alias**: Also available as `home_dir()`
- **Fallback Logic**: Uses `dirs::home_dir()`, with fallback to environment variables
- **Environment Variables**: `$HOME` or `%USERPROFILE%` as backup
- **Error Handling**: Returns empty string if home directory cannot be determined

## Example

```rust
let home = get_home_dir();
render_html("<p>📁 Home directory: <code>" + home + "</code></p>");

// Create SnapRun data directory
let snaprun_dir = home + "/SnapRun";
if !file_exists(snaprun_dir) {
    create_dir(snaprun_dir);
    render_html("<p>✅ Created directory: " + snaprun_dir + "</p>");
}

// Platform-specific file path
let config_file = home + "/SnapRun/config.json";
write_file(config_file, "{}");
render_html("<p>✅ Configuration file created</p>");
```


