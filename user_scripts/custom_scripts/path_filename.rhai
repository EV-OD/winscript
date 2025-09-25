// Demo: path_filename(path)
// What this script should do:
// 1) Extract and print the filename from a sample path.
// 2) Render the result as HTML.
let name = path_filename("C:/tmp/folder/file.txt");
print(name);

render_html("<p><strong>Filename:</strong> " + name + "</p>");
