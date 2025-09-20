// Test script for logging functionality

print("Hello from print function!");
println("Hello from println function!");

log("This is a log message");

console_log("This is console.log");
console_warn("This is a warning message");
console_debug("This is debug information");

// Test some math that should work
print("Testing math: 2 + 2 = " + (2 + 2));

// Test print with variables
let name = "SnapRun";
let version = 1.0;
print("Welcome to " + name + " version " + version);

// Test error logging by causing an intentional error at the end
// Uncomment this line to test error logging:
// this_will_cause_an_error();

print("Script execution completed successfully!");
