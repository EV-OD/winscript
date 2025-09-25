// Demo: move_file(src, dst)
// What this script should do:
// 1) Create a source file, move it to a new name, and print existence checks.
// 2) Render a small HTML summary.
let base = path_join(temp_dir(), "fs_kit_demo_move_file");
create_dir_all(base);
let src = path_join(base, "a.txt");
let dst = path_join(base, "b.txt");
write_file(src, "x");
move_file(src, dst);
print(file_exists(src));
print(file_exists(dst));

let html = "<h2>Move File Demo</h2>" +
	"<ul>" +
	"<li><strong>From:</strong> " + src + "</li>" +
	"<li><strong>To:</strong> " + dst + "</li>" +
	"<li><strong>Source exists:</strong> " + (if file_exists(src) { "true" } else { "false" }) + "</li>" +
	"<li><strong>Destination exists:</strong> " + (if file_exists(dst) { "true" } else { "false" }) + "</li>" +
	"</ul>";
render_html(html);
