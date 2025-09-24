---
title: "exit_and_hide"
description: "Terminate script execution and hide the SnapRun application window"
---

# exit_and_hide Function

Terminate current script execution and hide SnapRun application window.

## Syntax

```rust
exit_and_hide()
```

## Parameters

No parameters required.

## Return Value

- **Type**: Does not return (terminates execution)
- **Action**: Hides SnapRun window to system tray
- **Effect**: Script execution stops immediately

## Special Considerations

- Terminates script execution immediately
- Hides application window (minimizes to tray)
- Does not save unsaved work automatically
- Cannot be undone once called
- Use for clean script completion

## Example

```rust
info("Processing data...");

let user_choice = ask_select("Continue?", ["Yes", "No"]);

if user_choice == "No" {
    info("Operation cancelled by user");
    exit_and_hide();
}

info("Continuing with operation...");
// ... rest of script

info("Script completed successfully");
exit_and_hide();
```


