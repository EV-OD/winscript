// Demo: alias functions in action
// Test Worked
// What this script should do:
// 1) Create a temporary demo directory.
// 2) Create a text file, write "hello" into it, then read it back and print the contents.
// 3) Create nested directories using the create_directory alias and verify they exist.
// 4) Print the user's home directory using the get_home_dir alias.
// Note: All print(...) calls show messages in the console.
//       At the end, an HTML summary is rendered with render_html(...).
//
// read_text_file/write_text_file
let base = path_join(temp_dir(), "fs_kit_demo_aliases");
// Create the base directory for this demo
create_dir_all(base);
let file = path_join(base, "a.txt");
write_text_file(file, "hello");
// Print the file contents to the console
print(read_text_file(file));

// create_directory (alias of create_dir_all)
let nested = path_join(base, "x\\y\\z");
// Create nested directories and print the result to the console
print(create_directory(nested));
// Verify the directory exists and print the boolean result to the console
print(dir_exists(nested));

// get_home_dir (alias of home_dir)
print(get_home_dir());

// Render an HTML summary (for UI) without removing any console prints
let nested_exists = dir_exists(nested);
let content = read_text_file(file);
let html =
	"<h2>Alias Functions Demo</h2>" +
	"<ul>" +
		"<li><strong>Base directory:</strong> " + base + "</li>" +
		"<li><strong>File created:</strong> " + file + "</li>" +
		"<li><strong>File content:</strong> " + content + "</li>" +
		"<li><strong>Nested directory:</strong> " + nested + "</li>" +
		"<li><strong>Nested exists:</strong> " + (if nested_exists { "true" } else { "false" }) + "</li>" +
		"<li><strong>Home directory (printed to console):</strong> shown via print(get_home_dir())</li>" +
	"</ul>";
render_html(html);
