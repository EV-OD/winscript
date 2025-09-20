// Exit Functions Demo
// This script demonstrates the exit_and_hide function

print("🚪 Exit Functions Demo");
print("=====================");

print("Available exit option:");
print("exit_and_hide() - Exit script and hide app window (keeps in tray)");

let choice = ask_input("Press Enter to test exit_and_hide, or type 'skip' to cancel:");

if choice != "skip" {
    print("🫥 Testing exit_and_hide()...");
    print("This will exit the script and hide the app window");
    print("The app will remain in the system tray");
    print("Use Ctrl+Shift+J to show it again");
    
    let result = exit_and_hide();
    print("Result: " + result);
    
} else {
    print("❌ Test cancelled.");
    
    print("");
    print("💡 Tip: You can use exit_and_hide() in other scripts:");
    print("• At the end of automation scripts to hide the app");  
    print("• In monitoring scripts that should run in background");
    print("• For clean script termination with app staying in tray");
    
    print("");
    print("🔧 Example usage:");
    print("print(\"Task completed!\");");
    print("exit_and_hide(); // Hides app, keeps running in tray");
}

print("🚪 Exit demo completed!");
