// Demo: console_log(message)
// What this function does:
// - Logs a message with [console.log] label.
// How this script should behave:
// - Prints a labeled line to console.
// Expected output:
// - Console shows [console.log] prefix; HTML summary shown.

let msg = "Console log message";
console_log(msg);

// Debugging prints
print("[console_log] sent=" + msg);

render_html("<h3>console_log Demo</h3><pre>console.log: " + msg + "</pre>");
