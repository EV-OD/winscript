// Demo: append_file(path, content)
// Test Worked
// What this script should do:
// 1) Create a temporary demo directory and a file inside it.
// 2) Write initial content, then append more content to the same file.
// 3) Read the file and print the result to the console.
// Note: print(...) shows messages in the console. An HTML summary is rendered at the end.
let base = path_join(temp_dir(), "fs_kit_demo_append_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "a");
append_file(file, "b");
print(read_file(file));

// Render an HTML summary at the end
let final_content = read_file(file);
let html =
	"<h2>Append File Demo</h2>" +
	"<ul>" +
		"<li><strong>File:</strong> " + file + "</li>" +
		"<li><strong>Final content:</strong> " + final_content + "</li>" +
	"</ul>";
render_html(html);
