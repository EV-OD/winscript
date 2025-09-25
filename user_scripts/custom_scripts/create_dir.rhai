// Demo: create_dir(path)
// Test Worked
// What this script should do:
// 1) Create a base directory, then attempt to create a child directory.
// 2) Print whether the base exists and whether the child creation succeeded.
// Renders a small HTML summary at the end.
let base = path_join(temp_dir(), "fs_kit_demo_create_dir");
let nested = path_join(base, "child");
create_dir(base);
print(dir_exists(base));
print(create_dir(nested)); // likely false unless base exists already

// Render HTML summary
let html = "<h2>Create Dir Demo</h2>" +
	"<ul>" +
	"<li><strong>Base:</strong> " + base + " (exists: " + (if dir_exists(base) { "true" } else { "false" }) + ")</li>" +
	"<li><strong>Child:</strong> " + nested + "</li>" +
	"</ul>";
render_html(html);
