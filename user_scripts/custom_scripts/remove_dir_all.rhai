// Demo: remove_dir_all(path)
// What this script should do:
// 1) Create nested directories, remove the root, and print existence after.
// 2) Render a short HTML summary.
let base = path_join(temp_dir(), "fs_kit_demo_remove_dir_all/child/grand");
create_dir_all(base);
let root = path_parent(base);
remove_dir_all(root);
print(dir_exists(root));

render_html("<p>Removed directory tree: <code>" + root + "</code></p>");
