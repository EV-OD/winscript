// Demo: path_join(a, b)
// What this script should do:
// 1) Join two path segments and print the result.
// 2) Render the result as HTML.
let p = path_join("C:/tmp", "folder/file.txt");
print(p);

render_html("<p><strong>Joined path:</strong> " + p + "</p>");
