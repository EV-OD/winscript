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
// Read configuration file
if file_exists("config.json") {
    let config_text = read_file("config.json");
    let config = parse_json(config_text);
    info("Loaded config: " + config.app_name);
} else {
    info("Config file not found");
}

// Read script template
let template = read_file("templates/basic_script.rhai");
let custom_script = template.replace("{{PROJECT_NAME}}", "MyProject");
write_file("generated_script.rhai", custom_script);
```


