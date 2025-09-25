// Demo: read_file(path)
// What this script should do:
// 1) Create a file with content, then read and print it.
// 2) Render the content as HTML at the end.
let base = path_join(temp_dir(), "fs_kit_demo_read_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "hello");
print(read_file(file));

let content = read_file(file);
render_html("<p><strong>Read content:</strong> " + content + "</p>");
