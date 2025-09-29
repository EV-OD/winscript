// Demo: console_warn(message)
// What this function does:
// - Logs a warning with [console.warn] label.
// How this script should behave:
// - Prints a warning-styled line.
// Expected output:
// - Console shows [console.warn] prefix; HTML summary shown.

let msg = "This is a warning";
console_warn(msg);

// Debugging prints
print("[console_warn] sent=" + msg);

render_html("<h3>console_warn Demo</h3><pre>console.warn: " + msg + "</pre>");
