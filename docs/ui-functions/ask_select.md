# ask_select Function

## Description
Displays a selection dialog with predefined options for the user to choose from.

## Syntax
```rhai
ask_select(prompt_text, options_array)
```

## Parameters
- `prompt_text` (string): The text to display as the selection prompt
- `options_array` (array): Array of strings representing the available options

## Return Value
- Returns a `string` containing the selected option text

## Examples

### Basic Selection
```rhai
let priority = ask_select("Select priority:", ["High", "Medium", "Low"]);
info("Selected priority: " + priority);
```

### Complex Options
```rhai
let actions = [
    "Create new file",
    "Open existing file", 
    "Delete file",
    "Cancel"
];
let choice = ask_select("What would you like to do?", actions);

if choice == "Cancel" {
    info("Operation cancelled");
} else {
    info("You chose: " + choice);
}
```

### Using with Conditionals
```rhai
let format = ask_select("Choose export format:", ["JSON", "CSV", "XML"]);

if format == "JSON" {
    info("Exporting as JSON...");
} else if format == "CSV" {
    info("Exporting as CSV...");
} else if format == "XML" {
    info("Exporting as XML...");
}
```

### Dynamic Options
```rhai
let files = ["document1.txt", "document2.txt", "document3.txt"];
let selected = ask_select("Choose a file:", files);
info("Opening: " + selected);
```

## Notes
- The function blocks script execution until the user makes a selection
- Options are displayed in the order provided in the array
- Returns the exact string from the options array that was selected
- If the user cancels, returns an empty string or the first option (implementation dependent)

## Related Functions
- `ask_input()` - For free-form text input
- `render_html()` - For displaying formatted output
