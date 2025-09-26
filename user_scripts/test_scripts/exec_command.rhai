// Demo: exec_command(command) [alias: exec]
// What this function does:
// - Executes a command and returns a map with stdout, stderr, exit_code, success.
// How this script should behave:
// - Runs `whoami`, prints detailed fields, and shows an HTML summary.
// Expected output:
// - stdout contains the current user; success is true; stderr empty; exit_code 0.

let result = exec_command("whoami");

// Extract fields
let stdout = result["stdout"];   // string
let stderr = result["stderr"];   // string
let code   = result["exit_code"]; // number
let ok     = result["success"];   // bool

// Debugging prints
print("[exec_command] stdout=\n" + stdout);
print("[exec_command] stderr=\n" + stderr);
print("[exec_command] exit_code=" + code);
print("[exec_command] success=" + ok);

let html = "<h3>exec_command Demo</h3>" +
    "<pre>stdout:\n" + stdout + "\n\nstderr:\n" + stderr +
    "\n\nexit_code: " + code + "\nsuccess: " + ok + "</pre>";
render_html(html);
