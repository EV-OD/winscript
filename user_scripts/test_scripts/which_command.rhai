// Demo: which_command(command) [alias: which]
// What this function does:
// - Returns the full path to a command found in PATH or "Command not found".
// How this script should behave:
// - Looks up cmd and prints the path.
// Expected output:
// - A path like C:\\Windows\\System32\\cmd.exe, plus an HTML summary.

let cmd_name = "cmd";
let path = which_command(cmd_name);

// Debugging prints
print("[which_command] command=" + cmd_name);
print("[which_command] path=" + path);

render_html("<h3>which_command Demo</h3><pre>cmd ->\n" + path + "</pre>");
