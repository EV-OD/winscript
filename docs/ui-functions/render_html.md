# render_html Function

## Description
Displays formatted HTML content in the SnapRun UI with an optional title.

## Syntax
```rhai
render_html(title, html_content)
render_html(html_content)  // Single parameter version
```

## Parameters
- `title` (string, optional): The title to display above the HTML content
- `html_content` (string): The HTML content to render

## Return Value
- Returns a `bool` indicating success (true) or failure (false)

## Examples

### Basic HTML Rendering
```rhai
render_html("Welcome", "<h1>Hello World!</h1><p>This is HTML content.</p>");
```

### Styled Content
```rhai
let styled_html = `
    <div style="background: linear-gradient(135deg, #667eea, #764ba2); 
                color: white; padding: 2rem; border-radius: 12px;">
        <h2>Success!</h2>
        <p>Operation completed successfully.</p>
    </div>
`;
render_html("Operation Status", styled_html);
```

### Dynamic Content
```rhai
let name = ask_input("Enter your name:");
let greeting_html = "<div style='background: #e3f2fd; padding: 20px; border-radius: 8px;'>" +
                   "<h3>Hello, " + name + "!</h3>" +
                   "<p>Welcome to SnapRun!</p></div>";
render_html("Personal Greeting", greeting_html);
```

### Single Parameter Version
```rhai
render_html("<p><strong>Quick message:</strong> Task completed!</p>");
```

### Complex Layouts
```rhai
let report_html = `
    <div style="font-family: 'Segoe UI', Arial, sans-serif;">
        <h2 style="color: #2196F3;">System Report</h2>
        <div style="display: grid; gap: 1rem;">
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 6px;">
                <strong>Status:</strong> Online
            </div>
            <div style="background: #f5f5f5; padding: 1rem; border-radius: 6px;">
                <strong>Memory:</strong> 8.2 GB / 16 GB
            </div>
        </div>
    </div>
`;
render_html("System Status", report_html);
```

## HTML Styling Tips

### Gradients
```html
<div style="background: linear-gradient(135deg, #ff6b6b, #ee5a24);">
    <!-- Content -->
</div>
```

### Grid Layouts
```html
<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
    <div>Column 1</div>
    <div>Column 2</div>
</div>
```

### Cards
```html
<div style="background: white; padding: 1.5rem; border-radius: 8px; 
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <!-- Card content -->
</div>
```

## Notes
- HTML content is rendered in a styled container within the SnapRun UI
- Supports full CSS styling including gradients, flexbox, and grid
- The return value can be ignored if you don't need to check success
- Use template literals (backticks) for multi-line HTML strings
- The UI automatically applies the SnapRun theme styling around your content

## Related Functions
- `md()` / `render_markdown()` - For rendering Markdown content
- `ask_input()` - For getting user input
- `ask_select()` - For selection dialogs
