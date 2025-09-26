// Demo: run_command_with_args(command, args) [alias: run_cmd_args]
// What this function does:
// - Executes a command with explicit argument array (no shell). Returns stdout or error text.
// How this script should behave:
// - Uses cmd with /C to run echo via arguments and prints the result.
// Expected output:
// - Prints "Hello Args" (from echo) and renders a short HTML summary.

let cmd = "cmd";
let args = ["/C", "echo", "Hello Args"]; // becomes: cmd /C echo "Hello Args"
let output = run_command_with_args(cmd, args);

// Debugging prints
print("[run_command_with_args] command=" + cmd);
print("[run_command_with_args] args=" + args.to_string());
print("[run_command_with_args] stdout=\n" + output);

render_html("<h3>run_command_with_args Demo</h3><pre>cmd /C echo Hello Args ->\n" + output + "</pre>");
