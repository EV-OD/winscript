# md / render_markdown Functions

## Description
Renders Markdown content in the SnapRun UI with automatic styling and formatting.

## Syntax
```rhai
md(markdown_content)
render_markdown(markdown_content)
```

## Parameters
- `markdown_content` (string): The Markdown text to render

## Return Value
- Returns a `bool` indicating success (true) or failure (false)

## Examples

### Basic Markdown
```rhai
md("# Hello World\n\nThis is **bold** and *italic* text.");
```

### Code Blocks
```rhai
let markdown = `
# Code Example

Here's some Rhai code:

\`\`\`rhai
let x = 10;
let y = x * 2;
info("Result: " + y);
\`\`\`

And some inline code: \`let result = 42;\`
`;
md(markdown);
```

### Lists and Tables
```rhai
let content = `
# Task List

## Todo Items
- [x] Complete documentation
- [ ] Test all functions
- [ ] Deploy application

## Features
| Feature | Status | Priority |
|---------|--------|----------|
| UI      | Done   | High     |
| Backend | WIP    | High     |
| Docs    | Done   | Medium   |
`;
md(content);
```

### Dynamic Content
```rhai
let name = ask_input("Enter project name:");
let status = ask_select("Select status:", ["Active", "Paused", "Complete"]);

let report = `
# Project: ${name}

**Status:** ${status}

## Details
- Created: Today
- Last updated: Now
- Progress: In development

> This project is currently **${status.to_lower()}**.
`;
md(report);
```

### Expression Results (Common in eval scripts)
```rhai
let expression = "2 + 3 * 4";
let result = eval(expression);

md("**Expression:** `" + expression + "`\n\n**Result:** `" + result + "`");
```

## Supported Markdown Features

### Headers
```markdown
# H1 Header
## H2 Header  
### H3 Header
#### H4 Header
##### H5 Header
###### H6 Header
```

### Text Formatting
```markdown
**Bold text**
*Italic text*
~~Strikethrough~~
`Inline code`
```

### Lists
```markdown
- Unordered list item
- Another item
  - Nested item

1. Ordered list item
2. Another item
   1. Nested item
```

### Links and Images
```markdown
[Link text](https://example.com)
![Alt text](image-url)
```

### Code Blocks
```markdown
```language
code here
```
```

### Blockquotes
```markdown
> This is a blockquote
> 
> Multiple lines supported
```

### Tables
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
```

## Notes
- Both `md()` and `render_markdown()` are equivalent - use whichever you prefer
- Content is automatically styled to match the SnapRun theme
- Supports most standard Markdown features
- Code blocks support syntax highlighting
- The return value can usually be ignored unless you need error checking
- Use template literals (backticks) for multi-line markdown strings

## Related Functions
- `render_html()` - For custom HTML rendering
- `ask_input()` - For getting user input
- `ask_select()` - For selection dialogs
