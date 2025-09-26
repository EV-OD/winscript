// Demo: command_exists(command)
// What this function does:
// - Returns true if a command exists in PATH.
// How this script should behave:
// - Checks for cmd (should be true on Windows).
// Expected output:
// - Prints true and renders a short HTML summary.

let cmd_name = "cmd";
let exists = command_exists(cmd_name);

// Debugging prints
print("[command_exists] command=" + cmd_name);
print("[command_exists] exists=" + exists);

render_html("<h3>command_exists Demo</h3><pre>cmd -> " + exists + "</pre>");
