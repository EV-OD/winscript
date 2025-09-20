// Monaco Editor Modes Demo
// This script demonstrates two types of editors

print("🎭 Monaco Editor Modes Demo");
print("================================");

print("Choose editor mode:");
print("1. One-time Editor (blocks script, returns content)");
print("2. Persistent Editor (script ends, editor stays open)");

let choice = ask_input("Enter 1 or 2:");

if choice == "1" {
    print("🔄 Opening ONE-TIME editor...");
    print("- Script will wait for you to save/close");
    print("- Content will be returned to script");
    
    let content = editor();
    
    if content.len() > 0 {
        print("✅ You entered " + content.len() + " characters:");
        print(content);
        
        let save_choice = ask_input("Save to file? (y/n):");
        if save_choice.to_lower() == "y" {
            let filename = ask_input("Enter filename:");
            let result = save_file(filename, content);
            print(result);
        }
    } else {
        print("❌ No content entered");
    }
    
    print("✅ One-time editor demo completed!");
    
} else if choice == "2" {
    print("♾️ Opening PERSISTENT editor...");
    print("- Script will complete immediately");
    print("- Editor stays open for continuous use");
    print("- Save as many times as you want");
    print("- Perfect for editing config files, scripts, etc.");
    
    // Add some sample content
    let sample_content = `// Sample Rhai Script
// Edit this content and save multiple times!

print("Hello from persistent editor!");

let name = ask_input("Enter your name:");
print("Hello, " + name + "!");

// You can save this file multiple times
// The editor will stay open even after script completes
`;
    
    let result = open_temp_file_with_content_persistent(sample_content, "rhai");
    print("✅ " + result);
    print("✅ Script completed - editor remains open!");
    
} else {
    print("❌ Invalid choice. Please run script again and enter 1 or 2.");
}

print("🎭 Editor modes demo finished!");
