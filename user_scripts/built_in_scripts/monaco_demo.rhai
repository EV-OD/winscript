// Simple Monaco Editor Demo
// This script tests basic editor functionality

print("🖥️ Monaco Editor Demo Starting!");

// Test opening an empty editor
print("Opening Monaco Editor...");
let edited_content = editor();

if edited_content.len() > 0 {
    print("You entered: " + edited_content);
    
    // Ask if user wants to save this content
    let should_save = ask_input("Enter filename to save (or press Enter to skip):");
    
    if should_save.len() > 0 {
        let save_result = save_file(should_save, edited_content);
        print("Save result: " + save_result);
    } else {
        print("Content not saved.");
    }
} else {
    print("No content entered in the editor.");
}

print("✅ Monaco Editor demo completed!");
