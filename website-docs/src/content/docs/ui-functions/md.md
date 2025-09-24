---
title: ""md"
"
description: "Render Markdown content with automatic formatting and styling"
---

# md Function

Render Markdown content in SnapRun's UI with automatic styling.

## Syntax

```rust
md(markdown_content)
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `markdown_content` | `string` | Yes | Markdown text to render |

## Return Value

- **Type**: `bool`
- **Success**: `true` if content rendered successfully
- **Failure**: `false` if rendering failed

## Special Considerations

- Supports full Markdown syntax (headers, lists, code blocks, etc.)
- Syntax highlighting for code blocks
- Links and images are supported
- Content displays in SnapRun's UI panel

## Example

```rust
let content = `
# Task Report

## Summary
- **Completed**: 15 tasks
- **Pending**: 3 tasks

## Code Example
\`\`\`rhai
let total = completed + pending;
info("Total tasks: " + total);
\`\`\`

> **Note**: All tasks are on schedule.
`;

md(content);
```


