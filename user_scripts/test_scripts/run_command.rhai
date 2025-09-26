// Demo: run_command(command)
// What this function does:
// - Executes a single command (no shell), returns stdout if success, or an error text if it fails.
// How this script should behave:
// - Runs a simple command and prints its output for debugging.
// Expected output:
// - On Windows, `whoami` prints the current user (e.g., DOMAIN\\user). Also renders a short HTML summary.

// Debug: run a simple command that exists on Windows
let output = run_command("whoami");

// Debugging prints
print("[run_command] command=whoami");
print("[run_command] stdout=\n" + output);

// Simple HTML summary
render_html("<h3>run_command Demo</h3><pre>whoami ->\n" + output + "</pre>");
