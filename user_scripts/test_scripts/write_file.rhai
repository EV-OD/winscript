// Demo: write_file(path, content)
// What this script should do:
// 1) Create a file and write content, then read and print it.
// 2) Append an HTML summary at the end.
let base = path_join(temp_dir(), "fs_kit_demo_write_file");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "hello");
print(read_file(file));

render_html("<p><strong>Wrote file:</strong> " + file + "</p>");
