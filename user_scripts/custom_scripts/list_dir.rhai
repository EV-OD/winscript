// Demo: list_dir(path)
// What this script should do:
// 1) Create a directory tree and list its contents.
// 2) Print each item to the console, then render an HTML list.
let base = path_join(temp_dir(), "fs_kit_demo_list_dir");
create_dir_all(base);
write_file(path_join(base, "a.txt"), "a");
create_dir_all(path_join(base, "sub"));
let items = list_dir(base);
for item in items { print(item); }

let html = "<h3>Directory listing for: " + base + "</h3><ul>";
for item in items {
	html += "<li>" + item.name + (if item.is_dir { " (dir)" } else { " (file)" }) + "</li>";
}
html += "</ul>";
render_html(html);
