// Demo: copy_file(src, dst)
// Test Worked
// What this script should do:
// 1) Create a temp directory and a source file inside it.
// 2) Copy the source file to a destination path.
// 3) Print whether the destination file exists.
// An HTML summary is rendered at the end.
let base = path_join(temp_dir(), "fs_kit_demo_copy_file");
create_dir_all(base);
let src = path_join(base, "a.txt");
let dst = path_join(base, "b.txt");
write_file(src, "x");
copy_file(src, dst);
print(file_exists(dst));

// Render HTML summary
let html = "<h2>Copy File Demo</h2>" +
	"<ul>" +
	"<li><strong>Source:</strong> " + src + "</li>" +
	"<li><strong>Destination:</strong> " + dst + "</li>" +
	"<li><strong>Copied OK:</strong> " + (if file_exists(dst) { "true" } else { "false" }) + "</li>" +
	"</ul>";
render_html(html);
