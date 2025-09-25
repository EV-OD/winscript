// Demo: file_size(path)
// What this script should do:
// 1) Create a file with content and print its size in bytes.
// 2) Render an HTML summary at the end.
let base = path_join(temp_dir(), "fs_kit_demo_file_size");
create_dir_all(base);
let file = path_join(base, "a.txt");
write_file(file, "xyz");
print(file_size(file));

let size = file_size(file);
render_html("<p><strong>File:</strong> " + file + "<br><strong>Size:</strong> " + size + " bytes</p>");
