// File System Demo Script - showcases filesystem operations with markdown output

print("🗂️ File System Demo Starting...");

// Build markdown report
let report = "# 🗂️ File System Operations Demo\n\n";

// Get current working directory
let current = current_dir();
report += "## 📍 Current Environment\n\n";
report += "- **Current Directory**: `" + current + "`\n";

// Get special directories  
let home = home_dir();
let temp = temp_dir();
report += "- **Home Directory**: `" + home + "`\n";
report += "- **Temp Directory**: `" + temp + "`\n\n";

// Create test setup
let test_path = path_join(temp, "rhai_test");
let file_path = path_join(test_path, "test.txt");

report += "## 🧪 Test Setup\n\n";
report += "- **Test Directory**: `" + test_path + "`\n";
report += "- **Test File**: `" + file_path + "`\n\n";

report += "## 📁 Directory Operations\n\n";

// Create test directory
if !dir_exists(test_path) {
    if create_dir_all(test_path) {
        report += "✅ **Created test directory** - `create_dir_all()` succeeded\n";
    } else {
        report += "❌ **Failed to create test directory**\n";
    }
} else {
    report += "📁 **Test directory already exists** - `dir_exists()` returned true\n";
}

report += "\n## 📄 File Operations\n\n";

// Write a test file
let content = "Hello from Rhai!\nThis is a test file created by the file system demo.\nTimestamp: " + current_dir();
if write_file(file_path, content) {
    report += "✅ **File created successfully** - `write_file()` operation completed\n\n";
    
    // Check if file exists and read it back
    if file_exists(file_path) {
        report += "### 📖 File Content Verification\n\n";
        report += "- **File exists**: ✅ `file_exists()` confirmed\n";
        let read_content = read_file(file_path);
        report += "- **Content read**: ✅ `read_file()` successful\n\n";
        report += "**File Contents:**\n```\n" + read_content + "\n```\n\n";
    } else {
        report += "❌ **File verification failed** - `file_exists()` returned false\n\n";
    }
} else {
    report += "❌ **Failed to create file** - `write_file()` operation failed\n\n";
}

// List directory contents
report += "## 📂 Directory Listing\n\n";
report += "Contents of test directory:\n\n";

let entries = list_dir(test_path);
if entries.len() > 0 {
    report += "| Name | Type | Size |\n";
    report += "|------|------|------|\n";
    
    for entry in entries {
        let name = entry.name;
        let type_icon = if entry.is_dir { "📁 Directory" } else { "📄 File" };
        let size_info = if entry.is_dir { "-" } else { entry.size + " bytes" };
        report += "| `" + name + "` | " + type_icon + " | " + size_info + " |\n";
    }
} else {
    report += "*(Directory is empty)*\n";
}

report += "\n## 🧹 Cleanup Operations\n\n";

// Clean up
if file_exists(file_path) {
    if remove_file(file_path) {
        report += "✅ **Test file removed** - `remove_file()` successful\n";
    } else {
        report += "❌ **Failed to remove test file**\n";
    }
} else {
    report += "ℹ️ **No cleanup needed** - Test file doesn't exist\n";
}

if dir_exists(test_path) {
    // Try to remove directory if empty
    report += "📁 **Test directory cleanup** - Directory still exists\n";
}

report += "\n## ✅ Demo Summary\n\n";
report += "**Functions Demonstrated:**\n";
report += "- `current_dir()` - Get current working directory\n";
report += "- `home_dir()` - Get user home directory\n";
report += "- `temp_dir()` - Get system temp directory\n";
report += "- `path_join()` - Join path components\n";
report += "- `dir_exists()` - Check if directory exists\n";
report += "- `create_dir_all()` - Create directory and parents\n";
report += "- `write_file()` - Write content to file\n";
report += "- `file_exists()` - Check if file exists\n";
report += "- `read_file()` - Read file content\n";
report += "- `list_dir()` - List directory contents\n";
report += "- `remove_file()` - Delete file\n\n";

report += "🎉 **File system demo completed successfully!**\n";

// Render the markdown report
md(report);
