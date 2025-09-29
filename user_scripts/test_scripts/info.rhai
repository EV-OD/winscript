// Demo: info(message)
// What this function does:
// - Logs an informational message.
// How this script should behave:
// - Prints an info line to the console.
// Expected output:
// - Console shows an info-style line; HTML summary shown.

let msg = "Informational message from info()";
info(msg);

// Debugging prints
print("[info] sent=" + msg);

render_html("<h3>info Demo</h3><pre>info: " + msg + "</pre>");
