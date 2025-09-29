// Demo: console_debug(message)
// What this function does:
// - Logs a debug message with [console.debug] label.
// How this script should behave:
// - Prints a debug-styled line.
// Expected output:
// - Console shows [console.debug] prefix; HTML summary shown.

let msg = "Debug details";
console_debug(msg);

// Debugging prints
print("[console_debug] sent=" + msg);

render_html("<h3>console_debug Demo</h3><pre>console.debug: " + msg + "</pre>");
