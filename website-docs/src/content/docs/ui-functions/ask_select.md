---
title: "ask_select"
description: "Present multiple choice options to users through selection dialogs"
---

# ask_select Function

Display a selection dialog with predefined options for user to choose from.

## Syntax

```rust
ask_select(message, options)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `message` | `string` | Yes | The question or instruction to display |
| `options` | `array` | Yes | Array of strings with available choices |

## Implementation Details

- **Internal Function**: `ask_select_sync()` in UIKit
- **Parameter Conversion**: Converts `Vec<String>` to `Vec<&str>` internally
- **Async Handling**: Uses `tokio::task::block_in_place()` for sync context
- **Error Handling**: Returns empty string on error

## Return Value

- **Type**: `string`
- **Content**: The exact text of the selected option
- **Empty**: Returns empty string if user cancels

## Special Considerations

- Options are displayed in array order
- User must select from provided options only
- Case-sensitive return values
- Dialog blocks script execution until selection

## Example

```rust
let actions = ["Create File", "Read File", "Delete File", "Exit"];
let choice = ask_select("Choose action:", actions);

if choice == "Exit" {
    exit_and_hide();
} else {
    render_html("<p>🔄 Performing: <strong>" + choice + "</strong></p>");
}
```


