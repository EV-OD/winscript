// Markdown Demo Script - showcases markdown rendering capability

print("📄 Markdown Demo Starting...");

// Create a comprehensive markdown example
let markdown_content = "# Markdown Rendering Demo\n\nWelcome to the **Rhai Markdown Rendering** demonstration! This script shows how you can render rich markdown content directly in the UI.\n\n## Features Supported\n\n### Text Formatting\n- **Bold text** and *italic text*\n- ~~Strikethrough text~~\n- `Inline code` and regular text\n- [Links to external sites](https://www.rust-lang.org)\n\n### Lists\n\n#### Unordered Lists\n- File system operations\n- Markdown rendering\n- UI interactions\n- Script automation\n\n#### Ordered Lists\n1. Read markdown content\n2. Parse with pulldown-cmark\n3. Convert to styled HTML\n4. Display in UI\n\n### Code Blocks\n\n```\n// Example Rust code\nfn hello_world() {\n    println!(\\\"Hello from Rhai Markdown!\\\");\n}\n```\n\n```\n// Example JavaScript code\nfunction greet(name) {\n    console.log(\\`Hello, \\${name}!\\`);\n}\n```\n\n### Tables\n\n| Feature | Status | Description |\n|---------|--------|-------------|\n| File System | ✅ Complete | Read, write, create, delete files |\n| Markdown | ✅ Complete | Render markdown as styled HTML |\n| UI Components | ✅ Complete | Show messages, inputs, selections |\n| Path Operations | ✅ Complete | Join, normalize, get components |\n\n### Blockquotes\n\n> \\\"The best way to predict the future is to invent it.\\\"\n> \n> — Alan Kay\n\n### Task Lists\n\n- [x] Implement file system operations\n- [x] Add markdown rendering\n- [x] Create demo scripts\n- [ ] Add more advanced features\n- [ ] Improve error handling\n\n## Technical Details\n\nThis markdown is being processed by:\n1. **pulldown-cmark** - A fast, CommonMark-compliant markdown parser\n2. **Custom CSS styling** - For better visual presentation\n3. **Rhai integration** - Seamless scripting interface\n\n## Conclusion\n\nThis demonstrates the power of combining:\n- 🦀 **Rust** for performance and safety\n- 📝 **Markdown** for rich content formatting  \n- 🎨 **HTML/CSS** for beautiful presentation\n- ⚡ **Rhai** for easy scripting\n\nThank you for trying the markdown demo! 🎉";

// Render the markdown content
if render_markdown(markdown_content) {
    print("✅ Markdown rendered successfully!");
} else {
    print("❌ Failed to render markdown");
}

print("📄 Markdown demo completed!");
