// Demo: file_exists(path)
// What this script should do:
// 1) Create and delete a file, printing existence before and after.
// 2) Preserve console prints and add an HTML summary at the end.
let base = path_join(temp_dir(), "fs_kit_demo_file_exists");
create_dir_all(base);
let file = path_join(base, "note.txt");
write_file(file, "x");
print(file_exists(file));
remove_file(file);
print(file_exists(file));

render_html("<p>File existence toggled for: <code>" + file + "</code></p>");
