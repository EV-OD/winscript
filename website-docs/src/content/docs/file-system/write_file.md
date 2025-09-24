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
// Save configuration
let config = #{theme: "dark", auto_save: true};
write_file("config.json", to_json(config));

// Create log entry
let log_entry = timestamp() + " - Script executed successfully\n";
write_file("logs/script.log", log_entry);

// Generate report
let report = `# Daily Report
Generated: ${timestamp()}
Status: Complete
`;
write_file("reports/daily.md", report);
```


