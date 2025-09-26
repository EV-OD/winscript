// Demo: spawn_process(command) [alias: start_process]
// What this function does:
// - Spawns a process without waiting (non-blocking). Returns a message with PID or an error.
// How this script should behave:
// - Starts "notepad" (Windows) in the background. Prints the returned message.
// Expected output:
// - A line like: "Process spawned with PID: <number>" and a short HTML confirmation.

let message = spawn_process("notepad"); // Windows built-in app

// Debugging prints
print("[spawn_process] command=notepad");
print("[spawn_process] message=" + message);

render_html("<h3>spawn_process Demo</h3><pre>notepad ->\n" + message + "</pre>");
