// Demo: ask_select interaction
// Test Worked
// What this script should do:
// 1) Present a menu of actions to the user.
// 2) If "Exit" is chosen, close the script; otherwise render a status message.
// Note: print shows messages in the console. This script uses HTML rendering as well.
let actions = ["Create File", "Read File", "Delete File", "Exit"];
let choice = ask_select("Choose action:", actions);

if choice == "Exit" {
// Add a final HTML render at the end (non-exit path will reach here)
    // Render a final message, then exit and hide
    render_html("<p><strong>Goodbye!</strong> You chose to exit.</p>");
    exit_and_hide();
} else {
    // Show activity and a final completion message
    render_html("<p>🔄 Performing: <strong>" + choice + "</strong></p>");
    render_html("<p><em>Action completed:</em> " + choice + "</p>");
}