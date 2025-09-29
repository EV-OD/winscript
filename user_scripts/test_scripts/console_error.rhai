// Demo: console_error(message)
// What this function does:
// - Logs an error with [console.error] label.
// How this script should behave:
// - Prints an error-styled line.
// Expected output:
// - Console shows [console.error] prefix; HTML summary shown.

let msg = "Something went wrong";
console_error(msg);

// Debugging prints
print("[console_error] sent=" + msg);

render_html("<h3>console_error Demo</h3><pre>console.error: " + msg + "</pre>");
