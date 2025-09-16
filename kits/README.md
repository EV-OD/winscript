# UI Kit Documentation

This kit provides easy-to-use functions for user interaction in Rust scripts.

## Available Functions

### Input Functions
- `ask_input(message)` - Ask user for text input
- `ask_number(message)` - Ask user for numeric input (with validation)
- `ask_select(message, options)` - Ask user to select from options

### Display Functions
- `render_html(title, html_content)` - Display custom HTML
- `show_message(title, message)` - Show simple text message

### Utility Functions
- `confirm(message)` - Ask yes/no confirmation
- `create_kit(app_handle)` - Create kit instance

## Example Usage

```rust
#[tauri::command]
pub async fn my_script(app_handle: tauri::AppHandle) -> Result<String, String> {
    let kit = Kit::new(app_handle);

    // Ask for input
    let name = kit.ask_input("Enter your first name:").await?;
    let last_name = kit.ask_input("Enter your last name:").await?;
    
    // Ask for number
    let age = kit.ask_number("Enter your age:").await?;
    
    // Ask for selection
    let color = kit.ask_select("Choose color:", vec!["Red", "Blue", "Green"]).await?;
    
    // Show confirmation
    let confirmed = kit.confirm("Is this correct?").await?;
    
    if confirmed {
        // Render HTML result
        let html = format!(
            "<h2>Welcome {}!</h2><p>Age: {}, Color: {}</p>", 
            name, age as i32, color
        );
        kit.render_html("Profile", &html).await?;
    }
    
    Ok("Done".to_string())
}
```

## Implementation

The actual Rust implementation is located in `src-tauri/src/kits/ui_kit.rs`.
This directory serves as documentation and configuration for the kits system.
