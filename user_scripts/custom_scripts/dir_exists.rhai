// Demo: dir_exists(path)
// What this script should do:
// 1) Check existence before and after creating/removing a directory.
// 2) Print boolean results to the console.
let base = path_join(temp_dir(), "fs_kit_demo_dir_exists");
print(dir_exists(base));
create_dir_all(base);
print(dir_exists(base));
remove_dir_all(base);
print(dir_exists(base));

// Render HTML summary at the end
render_html("<p>Checked existence for: <code>" + base + "</code></p>");
