// Demo: println(message) -> String
// What this function does:
// - Alias of print that logs a message and returns it.
// How this script should behave:
// - Prints one line to the console and returns the same text.
// Expected output:
// - Console shows the message; HTML shows a summary.

let msg = "Hello from println()";
let returned = println(msg);

// Debugging prints
print("[println] sent=" + msg);
print("[println] returned=" + returned);

render_html("<h3>println Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
