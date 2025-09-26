// Demo: shell_command(command) [alias: sh]
// What this function does:
// - Runs a command through the system shell (cmd /C on Windows), returning stdout or error text.
// How this script should behave:
// - Executes a shell built-in (echo) and prints the output.
// Expected output:
// - Prints "Hello from shell" and renders a short HTML summary.

let output = shell_command("echo Hello from shell");

// Debugging prints
print("[shell_command] command=echo Hello from shell");
print("[shell_command] stdout=\n" + output);

render_html("<h3>shell_command Demo</h3><pre>echo Hello from shell ->\n" + output + "</pre>");
