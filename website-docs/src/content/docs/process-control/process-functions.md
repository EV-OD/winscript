---
title: "Process Functions"
description: "Execute system commands and manage external processes"
---

# Process Control Functions

Execute system commands and manage external processes from SnapRun scripts.

## Available Functions

### run_command / run_cmd

Execute a simple command and return output as string.

#### Syntax

```rust
run_command(command)
run_cmd(command)  // Short alias
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `command` | `string` | Yes | The system command to execute |

#### Return Value

- **Type**: `string`
- **Success**: Standard output from the command
- **Failure**: Error message with exit code and stderr

### run_command_with_args / run_cmd_args

Execute a command with arguments and return output as string.

#### Syntax

```rust
run_command_with_args(command, args)
run_cmd_args(command, args)  // Short alias
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `command` | `string` | Yes | The system command to execute |
| `args` | `array` | Yes | Array of string arguments |

#### Return Value

- **Type**: `string`
- **Success**: Standard output from the command
- **Failure**: Error message with details

### exec_command / exec

Execute command and return detailed result information.

#### Syntax

```rust
exec_command(command)
exec(command)  // Short alias
```

#### Return Value

- **Type**: `object` (Map)
- **Properties**:
  - `stdout` (string): Standard output
  - `stderr` (string): Error output  
  - `exit_code` (int): Exit status (0 = success)
  - `success` (bool): Whether command succeeded

### shell_command / sh

Execute shell commands (cross-platform).

#### Syntax

```rust
shell_command(command)
sh(command)  // Short alias
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `command` | `string` | Yes | Shell command string |

#### Return Value

- **Type**: `string`
- **Windows**: Uses `cmd /C`
- **Unix**: Uses `sh -c`

### spawn_process / start_process

Start a process without waiting for completion (non-blocking).

#### Syntax

```rust
spawn_process(command)
start_process(command)  // Safe alias
```

### Utility Functions

#### which_command / which

Find the path to an executable.

#### command_exists

Check if a command is available in the system PATH.

## Special Considerations

- Commands execute in system shell environment
- Blocking operation (script waits for completion)
- Security: Only run trusted commands
- Cross-platform command differences
- Long-running commands may timeout

## Example

```rust
// Simple command execution
let output = run_command("echo Hello, World!");
render_html("<h4>Command Output:</h4><pre>" + output + "</pre>");

// Command with arguments
let result = run_cmd_args("git", ["status", "--porcelain"]);
render_html("<h4>Git Status:</h4><pre>" + result + "</pre>");

// Detailed execution info
let info = exec_command("ping -n 1 google.com");
let status_html = "<h4>Command Execution Result:</h4>" +
    "<p>Exit code: " + info.exit_code + "</p>" +
    "<p>Success: " + info.success + "</p>" +
    "<pre>" + info.stdout + "</pre>";
render_html(status_html);

// Cross-platform shell command
let shell_result = sh("dir");  // Windows: dir, Unix: ls
render_html("<h4>Directory Listing:</h4><pre>" + shell_result + "</pre>");

// Non-blocking process
spawn_process("notepad.exe");  // Starts notepad without waiting
render_html("<p>✅ Notepad started in background</p>");
info("Exit code: " + result.exit_code);

// Directory listing (Windows)
let dir_result = run_command("dir", ["C:\\Users"]);
if dir_result.exit_code == 0 {
    render_html("Directory Listing", `<pre>${dir_result.stdout}</pre>`);
} else {
    info("Error: " + dir_result.stderr);
}

// Cross-platform file listing
let list_cmd = if system_platform() == "windows" { "dir" } else { "ls" };
let file_result = run_command(list_cmd, ["."]);
info("Files in current directory:");
info(file_result.stdout);
```


