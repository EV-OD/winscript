use std::process::{Command, Stdio};
use std::io::{BufRead, BufReader};
use std::thread;
use std::sync::mpsc;
use rhai::{Engine, Dynamic, Map};

/// Process execution kit for Rhai scripting
pub struct ProcessKit;

#[derive(Debug, Clone)]
pub struct ProcessResult {
    pub stdout: String,
    pub stderr: String,
    pub exit_code: i32,
    pub success: bool,
}

impl ProcessKit {
    /// Register all process-related functions with the Rhai engine
    pub fn register_functions(engine: &mut Engine) {
        // Basic command execution
        engine.register_fn("run_command", Self::run_command_sync);
        engine.register_fn("run_cmd", Self::run_command_sync); // Short alias
        
        // Command with arguments
        engine.register_fn("run_command_with_args", Self::run_command_with_args_sync);
        engine.register_fn("run_cmd_args", Self::run_command_with_args_sync); // Short alias
        
        // Advanced command execution with full control
        engine.register_fn("exec_command", Self::exec_command_sync);
        engine.register_fn("exec", Self::exec_command_sync); // Short alias
        
        // Shell-specific commands (cross-platform)
        engine.register_fn("shell_command", Self::shell_command_sync);
        engine.register_fn("sh", Self::shell_command_sync); // Short alias
        
        // Process spawning (non-blocking)
        engine.register_fn("spawn_process", Self::spawn_process_sync);
        engine.register_fn("start_process", Self::spawn_process_sync); // Safe alias
        
        // Utility functions
        engine.register_fn("which_command", Self::which_command_sync);
        engine.register_fn("which", Self::which_command_sync); // Short alias
        engine.register_fn("command_exists", Self::command_exists_sync);
    }
    
    /// Run a simple command and return the output as a string
    pub fn run_command_sync(command: &str) -> String {
        match Self::execute_command_internal(command, &[]) {
            Ok(result) => {
                if result.success {
                    result.stdout
                } else {
                    format!("Command failed (exit code: {})\nSTDOUT: {}\nSTDERR: {}", 
                            result.exit_code, result.stdout, result.stderr)
                }
            }
            Err(e) => format!("Failed to execute command: {}", e)
        }
    }
    
    /// Run a command with arguments and return the output
    pub fn run_command_with_args_sync(command: &str, args: rhai::Array) -> String {
        let string_args: Vec<String> = args.into_iter()
            .map(|arg| arg.to_string())
            .collect();
        let str_args: Vec<&str> = string_args.iter().map(|s| s.as_str()).collect();
        
        match Self::execute_command_internal(command, &str_args) {
            Ok(result) => {
                if result.success {
                    result.stdout
                } else {
                    format!("Command failed (exit code: {})\nSTDOUT: {}\nSTDERR: {}", 
                            result.exit_code, result.stdout, result.stderr)
                }
            }
            Err(e) => format!("Failed to execute command: {}", e)
        }
    }
    
    /// Execute a command and return detailed result information
    pub fn exec_command_sync(command: &str) -> Map {
        let result = Self::execute_command_internal(command, &[])
            .unwrap_or_else(|e| ProcessResult {
                stdout: String::new(),
                stderr: e.to_string(),
                exit_code: -1,
                success: false,
            });
        
        let mut map = Map::new();
        map.insert("stdout".into(), Dynamic::from(result.stdout));
        map.insert("stderr".into(), Dynamic::from(result.stderr));
        map.insert("exit_code".into(), Dynamic::from(result.exit_code));
        map.insert("success".into(), Dynamic::from(result.success));
        map
    }
    
    /// Run a shell command (cross-platform)
    pub fn shell_command_sync(command: &str) -> String {
        let (shell, flag) = if cfg!(target_os = "windows") {
            ("cmd", "/C")
        } else {
            ("sh", "-c")
        };
        
        match Self::execute_command_internal(shell, &[flag, command]) {
            Ok(result) => {
                if result.success {
                    result.stdout
                } else {
                    format!("Shell command failed (exit code: {})\nSTDOUT: {}\nSTDERR: {}", 
                            result.exit_code, result.stdout, result.stderr)
                }
            }
            Err(e) => format!("Failed to execute shell command: {}", e)
        }
    }
    
    /// Spawn a process without waiting for it to complete
    pub fn spawn_process_sync(command: &str) -> String {
        let parts: Vec<&str> = command.split_whitespace().collect();
        if parts.is_empty() {
            return "Error: Empty command".to_string();
        }
        
        let (cmd, args) = parts.split_first().unwrap();
        
        match Command::new(cmd)
            .args(args)
            .stdin(Stdio::null())
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .spawn()
        {
            Ok(child) => format!("Process spawned with PID: {}", child.id()),
            Err(e) => format!("Failed to spawn process: {}", e)
        }
    }
    
    /// Check if a command exists in PATH
    pub fn command_exists_sync(command: &str) -> bool {
        Self::which_command_internal(command).is_some()
    }
    
    /// Find the full path of a command
    pub fn which_command_sync(command: &str) -> String {
        Self::which_command_internal(command)
            .unwrap_or_else(|| "Command not found".to_string())
    }
    
    /// Internal function to execute commands
    fn execute_command_internal(command: &str, args: &[&str]) -> Result<ProcessResult, Box<dyn std::error::Error>> {
        let mut cmd = Command::new(command);
        cmd.args(args);
        cmd.stdout(Stdio::piped());
        cmd.stderr(Stdio::piped());
        
        let mut child = cmd.spawn()?;
        
        // Capture stdout
        let stdout_handle = child.stdout.take().unwrap();
        let (stdout_tx, stdout_rx) = mpsc::channel();
        thread::spawn(move || {
            let reader = BufReader::new(stdout_handle);
            let mut output = String::new();
            for line in reader.lines() {
                if let Ok(line) = line {
                    output.push_str(&line);
                    output.push('\n');
                }
            }
            stdout_tx.send(output).unwrap();
        });
        
        // Capture stderr
        let stderr_handle = child.stderr.take().unwrap();
        let (stderr_tx, stderr_rx) = mpsc::channel();
        thread::spawn(move || {
            let reader = BufReader::new(stderr_handle);
            let mut output = String::new();
            for line in reader.lines() {
                if let Ok(line) = line {
                    output.push_str(&line);
                    output.push('\n');
                }
            }
            stderr_tx.send(output).unwrap();
        });
        
        // Wait for process to complete
        let status = child.wait()?;
        let exit_code = status.code().unwrap_or(-1);
        
        // Collect output
        let stdout = stdout_rx.recv().unwrap_or_default();
        let stderr = stderr_rx.recv().unwrap_or_default();
        
        Ok(ProcessResult {
            stdout: stdout.trim_end().to_string(),
            stderr: stderr.trim_end().to_string(),
            exit_code,
            success: status.success(),
        })
    }
    
    /// Internal function to find command path
    fn which_command_internal(command: &str) -> Option<String> {
        if let Ok(path) = std::env::var("PATH") {
            let separator = if cfg!(target_os = "windows") { ";" } else { ":" };
            let extensions = if cfg!(target_os = "windows") {
                vec!["", ".exe", ".cmd", ".bat"]
            } else {
                vec![""]
            };
            
            for dir in path.split(separator) {
                for ext in &extensions {
                    let full_path = std::path::Path::new(dir).join(format!("{}{}", command, ext));
                    if full_path.exists() && full_path.is_file() {
                        return Some(full_path.to_string_lossy().to_string());
                    }
                }
            }
        }
        None
    }
}
