---
title: "render_html"
description: "Display formatted HTML content in SnapRun's UI with custom styling"
---

# render_html Function

Display formatted HTML content in SnapRun's UI with optional title.

## Syntax

```rust
render_html(html_content)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `html_content` | `string` | Yes | HTML content to render |

**Note**: In the Rhai implementation, `render_html()` takes only one parameter - the HTML content. The title is fixed as "Rhai Script Output".

## Return Value

- **Type**: `bool`
- **Success**: `true` if content rendered successfully
- **Failure**: `false` if rendering failed

## Implementation Details

- **Internal Function**: `render_html_sync()` in UIKit
- **Fixed Title**: Always uses "Rhai Script Output" as the title
- **UI Behavior**: Resets `has_awaiting_components` flag so UI stays visible after completion
- **Error Handling**: Returns false on error, with error logged to console

## Special Considerations

- Supports full HTML and CSS
- JavaScript is disabled for security
- Content displays in SnapRun's UI panel
- Supports responsive design

## Example

```rust
let status_html = `
<div style="background: #e8f5e8; padding: 1rem; border-radius: 8px; 
            border-left: 4px solid #4caf50;">
    <h3 style="color: #2e7d32; margin: 0;">✅ Success</h3>
    <p style="margin: 0.5rem 0 0 0;">Operation completed successfully!</p>
</div>
`;

render_html(status_html);

// Dynamic content
let name = ask_input("Enter name:");
render_html(`<h2>Hello, ${name}!</h2><p>Welcome to SnapRun.</p>`);
```


