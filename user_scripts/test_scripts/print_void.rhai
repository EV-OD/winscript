// Demo: print_void(message) -> ()
// What this function does:
// - Logs a message and returns nothing.
// How this script should behave:
// - Prints one line to the console; return value is unit/void.
// Expected output:
// - Console shows the message; HTML shows a summary.

let msg = "Hello from print_void()";
print_void(msg);

// Debugging prints
print("[print_void] sent=" + msg);

render_html("<h3>print_void Demo</h3><pre>sent: " + msg + "\nreturned: (void)</pre>");
