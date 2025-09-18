// File System Demo Script - showcases basic filesystem operations

print("🗂️ File System Demo Starting...");

// Get current working directory
let current = current_dir();
print("Current directory: " + current);

// Get special directories  
let home = home_dir();
let temp = temp_dir();
print("Home directory: " + home);
print("Temp directory: " + temp);

// Create a simple test
let test_path = path_join(temp, "rhai_test");
let file_path = path_join(test_path, "test.txt");

print("Test directory: " + test_path);
print("Test file: " + file_path);

// Create test directory
if !dir_exists(test_path) {
    if create_dir_all(test_path) {
        print("✅ Created test directory");
    } else {
        print("❌ Failed to create test directory");
    }
} else {
    print("📁 Test directory already exists");
}

// Write a simple test file
let content = "Hello from Rhai!\nThis is a test file.";
if write_file(file_path, content) {
    print("✅ Created test file");
} else {
    print("❌ Failed to create test file");
}

// Check if file exists and read it back
if file_exists(file_path) {
    print("📄 File exists!");
    let read_content = read_file(file_path);
    print("📖 File content:");
    print(read_content);
} else {
    print("❌ File was not created");
}

// List directory contents
print("📂 Directory contents:");
let entries = list_dir(test_path);
for entry in entries {
    let name = entry.name;
    let size_info = if entry.is_dir { "(directory)" } else { "(" + entry.size + " bytes)" };
    print("  📄 " + name + " " + size_info);
}

// Clean up
if file_exists(file_path) {
    if remove_file(file_path) {
        print("✅ Cleaned up test file");
    }
}

print("🎉 File system demo completed!");
