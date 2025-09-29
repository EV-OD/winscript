// Demo: log(message) -> String
// What this function does:
// - Alias of print that logs a message and returns it.
// How this script should behave:
// - Prints one line and returns the same text.
// Expected output:
// - Console shows the message; HTML shows a summary.

let msg = "Hello from log()";
let returned = log(msg);

// Debugging prints
print("[log] sent=" + msg);
print("[log] returned=" + returned);

render_html("<h3>log Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
