// Process & Commands Demo - showcases process execution and command running

print("⚡ Process & Commands Demo Starting...");

// Build markdown report
let report = "# ⚡ Process & Commands Demo\n\n";

report += "This demo showcases the process execution capabilities available in Rhai scripts.\n\n";

report += "## 🔍 Command Availability Check\n\n";

// Check which commands are available
let commands_to_check = ["dir", "ls", "echo", "ping", "whoami", "pwd", "date"];
report += "| Command | Available | Path |\n";
report += "|---------|-----------|------|\n";

for cmd in commands_to_check {
    let available = command_exists(cmd);
    let path = if available { which(cmd) } else { "Not found" };
    let status = if available { "✅ Yes" } else { "❌ No" };
    report += "| `" + cmd + "` | " + status + " | `" + path + "` |\n";
}

report += "\n## 💻 Basic Command Execution\n\n";

// Test basic command execution (cross-platform)
report += "### Echo Command Test\n\n";
let echo_result = sh("echo Hello from Rhai!");
report += "**Command**: `echo Hello from Rhai!` (via shell)\n\n";
report += "**Output**:\n```\n" + echo_result + "\n```\n\n";

// Test shell commands
report += "### Shell Command Test\n\n";
let shell_result = if command_exists("whoami") {
    sh("whoami")
} else {
    "whoami command not available"
};
report += "**Command**: `whoami` (via shell)\n\n";
report += "**Output**:\n```\n" + shell_result + "\n```\n\n";

// Test directory listing (platform-specific)
report += "### Directory Listing\n\n";
let dir_result = sh("dir /b");
if dir_result.len() > 5 && !dir_result.contains("not recognized") {
    // Windows dir command worked
    dir_result
} else {
    // Try Unix ls if dir failed
    let ls_result = sh("ls -la");
    if ls_result.len() > 5 && !ls_result.contains("not found") {
        ls_result
    } else {
        "Directory listing not available"
    }
};

report += "**Directory Contents**:\n```\n" + dir_result.sub_string(0, 500);
if dir_result.len() > 500 {
    report += "\n... (truncated)";
}
report += "\n```\n\n";

report += "## 🔧 Advanced Command Execution\n\n";

// Test command with arguments
report += "### Command with Arguments\n\n";
let args_result = if command_exists("echo") {
    run_cmd_args("echo", ["Hello", "World", "from", "Rhai!"])
} else {
    "echo command not available"
};
report += "**Command**: `echo` with arguments `[\"Hello\", \"World\", \"from\", \"Rhai!\"]`\n\n";
report += "**Output**:\n```\n" + args_result + "\n```\n\n";

report += "### Detailed Command Execution\n\n";
// Test detailed command execution that returns all info
let detailed_result = if command_exists("echo") {
    exec("echo Detailed execution test")
} else {
    #{stdout: "echo not available", stderr: "", exit_code: -1, success: false}
};

report += "**Command**: `echo Detailed execution test`\n\n";
report += "**Detailed Results**:\n";
report += "- **Exit Code**: `" + detailed_result.exit_code + "`\n";
report += "- **Success**: `" + detailed_result.success + "`\n";
report += "- **STDOUT**: `" + detailed_result.stdout + "`\n";
report += "- **STDERR**: `" + detailed_result.stderr + "`\n\n";

report += "## 🚀 Process Spawning\n\n";

// Test process spawning (non-blocking)
report += "### Spawn Background Process\n\n";
let spawn_result = if command_exists("ping") {
    start_process("ping 127.0.0.1")
} else if command_exists("sleep") {
    start_process("sleep 5")
} else {
    "No suitable command for spawning test"
};
report += "**Spawned Process**: Background ping/sleep\n\n";
report += "**Result**: " + spawn_result + "\n\n";

report += "## 🛠️ System Information Commands\n\n";

// Try to get some system information
report += "### System Info Gathering\n\n";

let system_info = [];

// Try various system info commands
if command_exists("hostname") {
    let hostname = run_cmd("hostname");
    system_info.push("**Hostname**: `" + hostname + "`");
}

if command_exists("date") {
    let date_info = run_cmd("date");
    system_info.push("**Date**: `" + date_info + "`");
}

if command_exists("whoami") {
    let user_info = run_cmd("whoami");
    system_info.push("**Current User**: `" + user_info + "`");
}

if command_exists("pwd") {
    let pwd_info = run_cmd("pwd");
    system_info.push("**Working Directory**: `" + pwd_info + "`");
} else if command_exists("cd") {
    let cd_info = sh("cd");
    system_info.push("**Working Directory**: `" + cd_info + "`");
}

if system_info.len() > 0 {
    for info in system_info {
        report += info + "\n";
    }
} else {
    report += "No system information commands available\n";
}

report += "\n## 📋 Available Process Functions\n\n";

report += "**Basic Functions**:\n";
report += "- `run_command(cmd)` / `run_cmd(cmd)` - Execute command and return output\n";
report += "- `run_command_with_args(cmd, args)` / `run_cmd_args(cmd, args)` - Execute with arguments\n";
report += "- `shell_command(cmd)` / `sh(cmd)` - Execute via shell\n\n";

report += "**Advanced Functions**:\n";
report += "- `exec_command(cmd)` / `exec(cmd)` - Detailed execution with exit codes\n";
report += "- `spawn_process(cmd)` / `start_process(cmd)` - Non-blocking process spawn\n\n";

report += "**Utility Functions**:\n";
report += "- `command_exists(cmd)` - Check if command is available\n";
report += "- `which_command(cmd)` / `which(cmd)` - Find command path\n\n";

report += "## ✅ Demo Summary\n\n";

report += "This demo showcased:\n";
report += "- ✅ Command availability checking\n";
report += "- ✅ Basic command execution with output capture\n";
report += "- ✅ Shell command execution (cross-platform)\n";
report += "- ✅ Commands with arguments\n";
report += "- ✅ Detailed execution with exit codes and error streams\n";
report += "- ✅ Background process spawning\n";
report += "- ✅ System information gathering\n\n";

report += "🎉 **Process execution capabilities are fully functional!**\n";

// Render the markdown report
md(report);
