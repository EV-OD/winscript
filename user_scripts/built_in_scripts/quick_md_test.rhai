// Quick Markdown Test - using the short md() function

print("📝 Quick Markdown Test");

// Test the short md() function
let simple_markdown = "# Quick Test\n\
\n\
This is a **quick test** of the `md()` function!\n\
\n\
## Features:\n\
- Short and sweet\n\
- Easy to use\n\
- Powerful markdown rendering\n\
\n\
> Quick demo of the markdown functionality\n\
\n\
## Code Example:\n\
md(\"# Hello World\\nThis is **bold** text!\");\n\
\n\
**Success!** ✅";


// Use the short md() function
if md(simple_markdown) {
    print("✅ md() function works perfectly!");
} else {
    print("❌ md() function failed");
}

print("📝 Quick test completed!");
