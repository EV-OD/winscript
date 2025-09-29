// Demo: print(message) -> String
// What this function does:
// - Logs a message and returns the same string.
// How this script should behave:
// - Prints one line to the console and stores/returns the same text.
// Expected output:
// - Console shows the message; HTML shows a summary box.

let msg = "Hello from print()";
let returned = print(msg);

// Debugging prints
print("[print] sent=" + msg);
print("[print] returned=" + returned);

render_html("<h3>print Demo</h3><pre>sent: " + msg + "\nreturned: " + returned + "</pre>");
