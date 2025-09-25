// Demo: home_dir()
// What this script should do:
// 1) Print the user's home directory in the console.
// 2) Render the same information as HTML.
print(home_dir());

let h = home_dir();
render_html("<p><strong>Home directory:</strong> " + h + "</p>");
