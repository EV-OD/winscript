// Monaco Editor Test Script
// This script demonstrates the new editor functionality

print("🖥️ Monaco Editor Test - Starting!");

// Test 1: Open empty editor
print("Test 1: Opening empty editor...");
let content = editor();
print("Editor returned content: " + content);

// Test 2: Create a temp file and edit it
print("Test 2: Creating temp file and opening in editor...");
let temp_file = create_temp_file("txt");
print("Created temp file: " + temp_file);

let temp_content = open_temp_file("rhai");
print("Temp file editor returned: " + temp_content);

// Test 3: Create temp file with initial content
print("Test 3: Creating temp file with initial content...");
let initial_code = `// Hello World Rhai Script
print("Hello from Monaco Editor!");

let name = "SnapRun User";
let message = "Welcome to Monaco Editor integration!";

print(name + " says: " + message);
`;

let edited_content = open_temp_file_with_content(initial_code, "rhai");
print("Edited content length: " + edited_content.len());

// Test 4: Save content to a specific file
print("Test 4: Saving content to file...");
let save_path = "C:\\temp\\monaco_test_output.txt";
let result = save_file(save_path, edited_content);
print("Save result: " + result);

print("✅ Monaco Editor test completed!");
