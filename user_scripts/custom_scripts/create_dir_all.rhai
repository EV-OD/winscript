// Demo: create_dir_all(path)
// Test Worked
// What this script should do:
// 1) Create a nested directory path, ensuring all components are created.
// 2) Print whether the creation succeeded and whether the path exists.
// Renders an HTML summary at the end for UI.
let base = path_join(temp_dir(), "fs_kit_demo_create_dir_all/child/grand");
print(create_dir_all(base));
print(dir_exists(base));

// Render HTML summary
let html = "<h2>Create Dir All Demo</h2>" +
	"<p><strong>Path:</strong> " + base + "</p>" +
	"<p><strong>Exists:</strong> " + (if dir_exists(base) { "true" } else { "false" }) + "</p>";
render_html(html);
