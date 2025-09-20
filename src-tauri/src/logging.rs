use std::fs::{self, OpenOptions};
use std::io::Write;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};
use chrono::{DateTime, Local};
use std::collections::HashMap;

#[derive(Debug, Clone)]
pub enum LogLevel {
    Info,
    Warn,
    Error,
    Debug,
    Trace,
}

impl LogLevel {
    pub fn as_str(&self) -> &'static str {
        match self {
            LogLevel::Info => "INFO",
            LogLevel::Warn => "WARN", 
            LogLevel::Error => "ERROR",
            LogLevel::Debug => "DEBUG",
            LogLevel::Trace => "TRACE",
        }
    }

    pub fn emoji(&self) -> &'static str {
        match self {
            LogLevel::Info => "ℹ️",
            LogLevel::Warn => "⚠️",
            LogLevel::Error => "❌",
            LogLevel::Debug => "🔍",
            LogLevel::Trace => "🔬",
        }
    }
}

#[derive(Debug, Clone)]
pub enum LogSource {
    Rust(String),    // Module name
    Frontend(String), // Component name
    Rhai(String),    // Script name
    System,
}

impl LogSource {
    pub fn prefix(&self) -> String {
        match self {
            LogSource::Rust(module) => format!("🦀 {}", module),
            LogSource::Frontend(component) => format!("⚛️ {}", component),
            LogSource::Rhai(script) => format!("📜 {}", script),
            LogSource::System => "⚙️ System".to_string(),
        }
    }
}

pub struct LogEntry {
    pub timestamp: DateTime<Local>,
    pub level: LogLevel,
    pub source: LogSource,
    pub message: String,
    pub script_context: Option<String>,
}

impl LogEntry {
    pub fn format(&self) -> String {
        let timestamp = self.timestamp.format("%Y-%m-%d %H:%M:%S%.3f");
        let level_str = format!("{} {}", self.level.emoji(), self.level.as_str());
        let source_str = self.source.prefix();
        
        format!(
            "[{}] {} {} - {}",
            timestamp,
            level_str,
            source_str,
            self.message
        )
    }
}

pub struct SnapRunLogger {
    logs_dir: PathBuf,
    file_handles: Arc<Mutex<HashMap<String, std::fs::File>>>,
    console_enabled: bool,
}

impl SnapRunLogger {
    pub fn new() -> Result<Self, Box<dyn std::error::Error>> {
        let logs_dir = Self::get_logs_directory()?;
        
        // Create logs directory if it doesn't exist
        if !logs_dir.exists() {
            fs::create_dir_all(&logs_dir)?;
        }

        println!("📋 SnapRunLogger: Initialized with logs directory: {}", logs_dir.display());

        Ok(SnapRunLogger {
            logs_dir,
            file_handles: Arc::new(Mutex::new(HashMap::new())),
            console_enabled: true,
        })
    }

    fn get_logs_directory() -> Result<PathBuf, Box<dyn std::error::Error>> {
        let documents_dir = dirs::document_dir()
            .ok_or("Could not find Documents directory")?;
        
        Ok(documents_dir.join("SnapRun").join("logs"))
    }

    pub fn log(&self, level: LogLevel, source: LogSource, message: &str, script_context: Option<String>) {
        let entry = LogEntry {
            timestamp: Local::now(),
            level: level.clone(),
            source: source.clone(),
            message: message.to_string(),
            script_context: script_context.clone(),
        };

        // Always log to console if enabled
        if self.console_enabled {
            println!("{}", entry.format());
        }

        // Determine the log file based on context
        let log_file_name = self.get_log_file_name(&source, &script_context);
        
        // Write to file
        if let Err(e) = self.write_to_file(&log_file_name, &entry) {
            eprintln!("❌ Failed to write to log file {}: {}", log_file_name, e);
        }

        // Also write to main log file
        if let Err(e) = self.write_to_file("main.log", &entry) {
            eprintln!("❌ Failed to write to main log file: {}", e);
        }
    }

    fn get_log_file_name(&self, source: &LogSource, script_context: &Option<String>) -> String {
        match (source, script_context) {
            (LogSource::Rhai(script_name), _) => {
                format!("script_{}.log", Self::sanitize_filename(script_name))
            },
            (_, Some(script_name)) => {
                format!("script_{}.log", Self::sanitize_filename(script_name))
            },
            (LogSource::Rust(module), _) => {
                format!("rust_{}.log", Self::sanitize_filename(module))
            },
            (LogSource::Frontend(component), _) => {
                format!("frontend_{}.log", Self::sanitize_filename(component))
            },
            (LogSource::System, _) => "system.log".to_string(),
        }
    }

    fn sanitize_filename(name: &str) -> String {
        name.chars()
            .map(|c| match c {
                'a'..='z' | 'A'..='Z' | '0'..='9' | '_' | '-' => c,
                ' ' => '_',
                _ => '_',
            })
            .collect()
    }

    fn write_to_file(&self, filename: &str, entry: &LogEntry) -> Result<(), Box<dyn std::error::Error>> {
        let mut handles = self.file_handles.lock().unwrap();
        
        // Get or create file handle
        if !handles.contains_key(filename) {
            let file_path = self.logs_dir.join(filename);
            let file = OpenOptions::new()
                .create(true)
                .append(true)
                .open(file_path)?;
            handles.insert(filename.to_string(), file);
        }

        if let Some(file) = handles.get_mut(filename) {
            writeln!(file, "{}", entry.format())?;
            file.flush()?;
        }

        Ok(())
    }

    // Convenience methods
    pub fn info(&self, source: LogSource, message: &str) {
        self.log(LogLevel::Info, source, message, None);
    }

    pub fn info_script(&self, source: LogSource, message: &str, script_name: &str) {
        self.log(LogLevel::Info, source, message, Some(script_name.to_string()));
    }

    pub fn warn(&self, source: LogSource, message: &str) {
        self.log(LogLevel::Warn, source, message, None);
    }

    pub fn warn_script(&self, source: LogSource, message: &str, script_name: &str) {
        self.log(LogLevel::Warn, source, message, Some(script_name.to_string()));
    }

    pub fn error(&self, source: LogSource, message: &str) {
        self.log(LogLevel::Error, source, message, None);
    }

    pub fn error_script(&self, source: LogSource, message: &str, script_name: &str) {
        self.log(LogLevel::Error, source, message, Some(script_name.to_string()));
    }

    pub fn debug(&self, source: LogSource, message: &str) {
        self.log(LogLevel::Debug, source, message, None);
    }

    pub fn debug_script(&self, source: LogSource, message: &str, script_name: &str) {
        self.log(LogLevel::Debug, source, message, Some(script_name.to_string()));
    }

    pub fn set_console_enabled(&mut self, enabled: bool) {
        self.console_enabled = enabled;
    }

    pub fn get_logs_directory_path(&self) -> &Path {
        &self.logs_dir
    }
}

// Global logger instance
static mut GLOBAL_LOGGER: Option<SnapRunLogger> = None;
static INIT_ONCE: std::sync::Once = std::sync::Once::new();

pub fn init_logger() -> Result<(), Box<dyn std::error::Error>> {
    INIT_ONCE.call_once(|| {
        unsafe {
            match SnapRunLogger::new() {
                Ok(logger) => {
                    GLOBAL_LOGGER = Some(logger);
                    println!("📋 Global SnapRun logger initialized successfully");
                },
                Err(e) => {
                    eprintln!("❌ Failed to initialize SnapRun logger: {}", e);
                }
            }
        }
    });
    Ok(())
}

pub fn get_logger() -> Option<&'static SnapRunLogger> {
    unsafe { GLOBAL_LOGGER.as_ref() }
}

// Convenient logging macros
#[macro_export]
macro_rules! log_info {
    ($source:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.info($source, &format!($($arg)*));
        }
    };
}

#[macro_export]
macro_rules! log_info_script {
    ($source:expr, $script:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.info_script($source, &format!($($arg)*), $script);
        }
    };
}

#[macro_export]
macro_rules! log_warn {
    ($source:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.warn($source, &format!($($arg)*));
        }
    };
}

#[macro_export]
macro_rules! log_warn_script {
    ($source:expr, $script:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.warn_script($source, &format!($($arg)*), $script);
        }
    };
}

#[macro_export]
macro_rules! log_error {
    ($source:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.error($source, &format!($($arg)*));
        }
    };
}

#[macro_export]
macro_rules! log_error_script {
    ($source:expr, $script:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.error_script($source, &format!($($arg)*), $script);
        }
    };
}

#[macro_export]
macro_rules! log_debug {
    ($source:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.debug($source, &format!($($arg)*));
        }
    };
}

#[macro_export]
macro_rules! log_debug_script {
    ($source:expr, $script:expr, $($arg:tt)*) => {
        if let Some(logger) = crate::logging::get_logger() {
            logger.debug_script($source, &format!($($arg)*), $script);
        }
    };
}
