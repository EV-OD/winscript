// Demo: path_parent(path)
// What this script should do:
// 1) Get and print the parent directory of a sample path.
// 2) Render the result as HTML.
let p = path_parent("C:/tmp/folder/file.txt");
print(p);

render_html("<p><strong>Parent path:</strong> " + p + "</p>");
