# ask_input Function

## Description
Prompts the user to enter text input through a dialog box in the SnapRun UI.

## Syntax
```rhai
ask_input(prompt_text)
```

## Parameters
- `prompt_text` (string): The text to display as the input prompt

## Return Value
- Returns a `string` containing the user's input text

## Examples

### Basic Usage
```rhai
let name = ask_input("Enter your name:");
info("Hello, " + name + "!");
```

### Input Validation
```rhai
let age = ask_input("Enter your age:");
if age.trim() == "" {
    info("No age provided");
} else {
    info("You are " + age + " years old");
}
```

### Using in Loops
```rhai
loop {
    let command = ask_input("Enter command (or 'exit'):");
    if command == "exit" {
        break;
    }
    info("You entered: " + command);
}
```

## Notes
- The function blocks script execution until the user provides input
- Returns an empty string if the user cancels the dialog
- The input is returned as-is without automatic trimming
- Use `.trim()` to remove leading/trailing whitespace if needed

## Related Functions
- `ask_select()` - For selecting from predefined options
- `render_html()` - For displaying formatted output
