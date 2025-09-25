// Demo: temp_dir()
// What this script should do:
// 1) Print the temporary directory path to the console.
// 2) Render the same info as HTML.
print(temp_dir());

let td = temp_dir();
render_html("<p><strong>Temp directory:</strong> " + td + "</p>");
