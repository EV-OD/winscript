---
title: "ask_input"
description: "Collect text input from users through interactive dialog boxes"
---

# ask_input Function

Display an input dialog to collect text from users interactively. Perfect for gathering user preferences, file names, configuration values, and any other text-based input.

## Syntax

```rust
ask_input(message)
```

## Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `message` | `string` | The question or instruction to display to the user |

**Note**: If you press enter without typing anything(Space is also treated as empty), the dialog will stay open and not continue. You must enter some text to proceed.


## Return Value

- **Type**: `string`
- **Content**: The text entered by the user

## Basic Examples

### Simple Text Input
```rust
let name = ask_input("What's your name?");
render_html("<h3>Hello, " + name + "!</h3><p>Welcome to SnapRun.</p>");
```


### Input Validation
```rust
let email = ask_input("Enter your email address:");

while !email.contains("@") {
    email = ask_input("Please enter a valid email address (must contain @):");
}

render_html("<p>✅ Email registered: <strong>" + email + "</strong></p>");
```

## Tips and Best Practices

:::note[Validation]
Always validate user input, especially for:
- File paths and names
- Numeric values
- Email addresses
- No need to check for empty input or only spaces
:::

## Related Functions

- **[`ask_select()`](ask_select.md)** - Present multiple choice options
- **[`render_html()`](render_html.md)** - Display formatted results
- **[`info()`](/logging/info)** - Show information messages
