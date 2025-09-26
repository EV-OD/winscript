// Demo: path_extension(path)
// What this script should do:
// 1) Extract and print the file extension from a sample path.
// 2) Render the result as HTML.
let ext = path_extension("C:/tmp/folder/file.txt");
print(ext);

render_html("<p><strong>Extension:</strong> " + ext + "</p>");
