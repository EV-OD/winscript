# Process Control Functions

## Overview
Functions for managing external processes, system commands, and process execution within SnapRun scripts.

## Process Execution Functions

### run_command(command, args)
Executes a system command with arguments and returns the result.

#### Syntax
```rhai
run_command(command, args)
```

#### Parameters
- `command` (string): The command to execute
- `args` (array): Array of arguments to pass to the command

#### Return Value
- Returns an object with execution results including stdout, stderr, and exit code
- May throw an error if the command cannot be executed

#### Examples

##### Basic Command Execution
```rhai
// Run simple commands
let result = run_command("echo", ["Hello World"]);
info("Command output: " + result.stdout);
info("Exit code: " + result.exit_code);
```

##### Directory Listing
```rhai
// List directory contents
let result = run_command("dir", ["C:\\"]);
if result.exit_code == 0 {
    render_html("Directory Listing", `
        <pre style="background: #f5f5f5; padding: 1rem; border-radius: 4px;">
${result.stdout}
        </pre>
    `);
} else {
    info("Command failed: " + result.stderr);
}
```

##### System Information
```rhai
// Get system information
let hostname_result = run_command("hostname", []);
let date_result = run_command("date", ["/t"]);

info("Computer name: " + hostname_result.stdout.trim());
info("Current date: " + date_result.stdout.trim());
```

##### File Operations
```rhai
// Create directory via command
let mkdir_result = run_command("mkdir", ["C:\\temp\\new_folder"]);
if mkdir_result.exit_code == 0 {
    info("Directory created successfully");
} else {
    info("Failed to create directory: " + mkdir_result.stderr);
}

// Copy files
let copy_result = run_command("copy", ["source.txt", "destination.txt"]);
if copy_result.exit_code == 0 {
    info("File copied successfully");
}
```

##### PowerShell Commands
```rhai
// Run PowerShell commands
let ps_result = run_command("powershell", ["-Command", "Get-Process | Select-Object -First 5"]);
if ps_result.exit_code == 0 {
    render_html("Running Processes", `
        <div style="font-family: monospace;">
            <h3>Top 5 Processes</h3>
            <pre>${ps_result.stdout}</pre>
        </div>
    `);
}
```

### start_process(command, args)
Starts a process in the background without waiting for completion.

#### Syntax
```rhai
start_process(command, args)
```

#### Parameters
- `command` (string): The command to execute
- `args` (array): Array of arguments

#### Return Value
- Returns a process handle or ID for the started process
- Does not wait for process completion

#### Examples

##### Launch Applications
```rhai
// Launch notepad
let notepad_handle = start_process("notepad", []);
info("Notepad launched with handle: " + notepad_handle);

// Open file with default application
let file_handle = start_process("start", ["document.pdf"]);
info("PDF opened");
```

##### Background Tasks
```rhai
// Start a background task
let backup_handle = start_process("robocopy", [
    "C:\\Users\\Documents",
    "C:\\Backup\\Documents",
    "/MIR"
]);
info("Backup process started with handle: " + backup_handle);
```

### kill_process(handle)
Terminates a running process.

#### Syntax
```rhai
kill_process(handle)
```

#### Parameters
- `handle`: Process handle or ID returned from `start_process()`

#### Return Value
- Returns success/failure status
- May throw an error if process cannot be terminated

#### Examples

##### Process Management
```rhai
// Start a process
let calc_handle = start_process("calc", []);
info("Calculator started");

// Wait for user input
ask_input("Press Enter to close calculator...");

// Terminate the process
let kill_result = kill_process(calc_handle);
if kill_result {
    info("Calculator closed successfully");
} else {
    info("Failed to close calculator");
}
```

### wait_for_process(handle, timeout)
Waits for a process to complete within a specified timeout.

#### Syntax
```rhai
wait_for_process(handle, timeout)
```

#### Parameters
- `handle`: Process handle from `start_process()`
- `timeout` (optional): Maximum time to wait in milliseconds

#### Return Value
- Returns true if process completed, false if timeout occurred
- May include exit code information

#### Examples

##### Process Synchronization
```rhai
// Start a batch file
let batch_handle = start_process("cmd", ["/c", "backup_script.bat"]);
info("Backup script started...");

// Wait up to 60 seconds
let completed = wait_for_process(batch_handle, 60000);
if completed {
    info("Backup script completed successfully");
} else {
    info("Backup script timed out");
    kill_process(batch_handle);
}
```

## Advanced Process Management

### Process Monitoring
```rhai
fn monitor_process(process_name) {
    let ps_result = run_command("tasklist", ["/FI", "IMAGENAME eq " + process_name]);
    
    if ps_result.stdout.contains(process_name) {
        info("Process " + process_name + " is running");
        return true;
    } else {
        info("Process " + process_name + " is not running");
        return false;
    }
}

// Monitor specific processes
let chrome_running = monitor_process("chrome.exe");
let notepad_running = monitor_process("notepad.exe");

render_html("Process Status", `
    <div style="padding: 1rem;">
        <h3>Process Monitoring</h3>
        <p>Chrome: ${chrome_running ? "Running" : "Not Running"}</p>
        <p>Notepad: ${notepad_running ? "Running" : "Not Running"}</p>
    </div>
`);
```

### Batch File Execution
```rhai
fn run_batch_script(script_path) {
    info("Executing batch script: " + script_path);
    
    let result = run_command("cmd", ["/c", script_path]);
    
    info("Batch script output:");
    info(result.stdout);
    
    if result.stderr.trim() != "" {
        info("Batch script errors:");
        info(result.stderr);
    }
    
    return result.exit_code == 0;
}

// Usage
let success = run_batch_script("C:\\Scripts\\maintenance.bat");
if success {
    info("Maintenance script completed successfully");
} else {
    info("Maintenance script failed");
}
```

### System Utility Functions
```rhai
fn get_system_info() {
    let info_commands = #{
        "os": ["ver"],
        "memory": ["wmic", "computersystem", "get", "TotalPhysicalMemory"],
        "disk": ["dir", "C:\\", "/-c"],
        "network": ["ipconfig", "/all"]
    };
    
    let system_info = #{};
    
    for key in info_commands.keys() {
        let cmd_array = info_commands[key];
        let command = cmd_array[0];
        let args = [];
        
        for i in 1..cmd_array.len() {
            args.push(cmd_array[i]);
        }
        
        let result = run_command(command, args);
        if result.exit_code == 0 {
            system_info[key] = result.stdout.trim();
        } else {
            system_info[key] = "Failed to retrieve";
        }
    }
    
    return system_info;
}

// Get and display system information
let sys_info = get_system_info();

render_html("System Information", `
    <div style="font-family: Arial; padding: 1rem;">
        <h2>System Information</h2>
        <h3>Operating System</h3>
        <pre style="background: #f5f5f5; padding: 0.5rem;">${sys_info.os}</pre>
        
        <h3>Memory Information</h3>
        <pre style="background: #f5f5f5; padding: 0.5rem;">${sys_info.memory}</pre>
        
        <h3>Network Configuration</h3>
        <pre style="background: #f5f5f5; padding: 0.5rem; max-height: 300px; overflow-y: auto;">${sys_info.network}</pre>
    </div>
`);
```

### Service Management
```rhai
fn manage_service(service_name, action) {
    info("Managing service: " + service_name + " (" + action + ")");
    
    let result = run_command("sc", [action, service_name]);
    
    if result.exit_code == 0 {
        info("Service " + action + " successful: " + service_name);
        return true;
    } else {
        info("Service " + action + " failed: " + result.stderr);
        return false;
    }
}

fn get_service_status(service_name) {
    let result = run_command("sc", ["query", service_name]);
    
    if result.stdout.contains("RUNNING") {
        return "Running";
    } else if result.stdout.contains("STOPPED") {
        return "Stopped";
    } else {
        return "Unknown";
    }
}

// Service management example
let service_name = "Spooler"; // Print Spooler service
let status = get_service_status(service_name);
info("Current status of " + service_name + ": " + status);

// Uncomment to actually manage services (requires admin privileges)
// manage_service(service_name, "stop");
// manage_service(service_name, "start");
```

### File Association and Default Apps
```rhai
fn open_with_default_app(file_path) {
    let result = run_command("cmd", ["/c", "start", "", file_path]);
    
    if result.exit_code == 0 {
        info("File opened with default application: " + file_path);
        return true;
    } else {
        info("Failed to open file: " + result.stderr);
        return false;
    }
}

// Usage
let document_path = get_home_dir() + "\\Documents\\report.pdf";
if file_exists(document_path) {
    open_with_default_app(document_path);
} else {
    info("File not found: " + document_path);
}
```

## Error Handling

### Command Error Management
```rhai
fn safe_command(command, args, description) {
    info("Executing: " + description);
    
    try {
        let result = run_command(command, args);
        
        if result.exit_code == 0 {
            info("✓ Success: " + description);
            return #{success: true, output: result.stdout, error: ""};
        } else {
            info("✗ Failed: " + description);
            info("Error: " + result.stderr);
            return #{success: false, output: "", error: result.stderr};
        }
    } catch (error) {
        info("✗ Exception during: " + description);
        info("Exception: " + error);
        return #{success: false, output: "", error: error};
    }
}

// Usage with error handling
let commands = [
    #{cmd: "dir", args: ["C:\\"], desc: "List C: drive contents"},
    #{cmd: "hostname", args: [], desc: "Get computer name"},
    #{cmd: "invalidcmd", args: [], desc: "This will fail"}
];

for cmd_info in commands {
    let result = safe_command(cmd_info.cmd, cmd_info.args, cmd_info.desc);
    if !result.success {
        info("Command failed, continuing with next command...");
    }
}
```

## Security Considerations

### Input Validation
```rhai
fn validate_command_input(command, args) {
    // Basic validation - customize based on security requirements
    let dangerous_commands = ["del", "rmdir", "format", "fdisk"];
    
    for dangerous in dangerous_commands {
        if command.contains(dangerous) {
            return false;
        }
    }
    
    // Check arguments for dangerous patterns
    for arg in args {
        if arg.contains("..") || arg.contains("*.*") {
            return false;
        }
    }
    
    return true;
}

fn safe_execute(command, args) {
    if !validate_command_input(command, args) {
        info("Command rejected for security reasons: " + command);
        return #{success: false, error: "Security validation failed"};
    }
    
    return run_command(command, args);
}

// Usage
let user_command = ask_input("Enter command:");
let user_args = ask_input("Enter arguments (space-separated):").split(" ");

let result = safe_execute(user_command, user_args);
if result.success {
    info("Command output: " + result.stdout);
} else {
    info("Command failed or rejected");
}
```

## Notes
- Process control functions require appropriate system permissions
- Some operations may require administrator privileges
- Process handles must be properly managed to avoid resource leaks
- Command execution should be validated for security
- Different operating systems may have different command syntax

## Related Functions
- `ask_input()` - Get user input for command parameters
- `file_exists()` - Check if files exist before processing
- `write_file()` - Save command output to files
- `info()` - Log process execution status
- `render_html()` - Display formatted command results
