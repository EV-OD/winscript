// Show Logs Script - Browse and view SnapRun log files
// Uses filesystem kit and UI kit for interactive log viewing

let logs_dir = path_join(home_dir(), "Documents\\SnapRun\\logs");

print("📋 SnapRun Log Viewer");
print("Logs directory: " + logs_dir);

// Check if logs directory exists
if !dir_exists(logs_dir) {
    console_warn("Logs directory does not exist: " + logs_dir);
    render_html("<div style='text-align: center; padding: 2rem;'><h3>No Logs Directory</h3><p>The logs directory does not exist yet. Run some scripts first to generate logs.</p></div>");
    return;
}

// Get list of log files
let log_files = list_dir(logs_dir);
let log_options = [];

print("📁 Scanning for log files...");

// Filter for .log files and prepare display options
for file_info in log_files {
    if file_info.is_file && file_info.name.ends_with(".log") {
        let size_kb = (file_info.size / 1024.0).round();
        let display_name = file_info.name + " (" + size_kb + " KB)";
        log_options.push(display_name);
    }
}

if log_options.is_empty() {
    console_warn("No log files found in directory");
    render_html("<div style='text-align: center; padding: 2rem;'><h3>No Log Files</h3><p>No .log files found in the logs directory.</p></div>");
    return "No log files found";
}

print("📋 Found " + log_options.len() + " log files");

// Sort log options alphabetically
log_options.sort();

// Let user select a log file
let selection = ask_select("Select a log file to view:", log_options);

if selection == "" {
    print("❌ No selection made");
    return "No selection made";
}

// Extract the actual filename from the selection (remove size info)
let log_filename = "";
for i in range(0, selection.len()) {
    if selection[i] == '(' {
        log_filename = selection.sub_string(0, i - 1);
        break;
    }
}

if log_filename == "" {
    log_filename = selection;
}

print("📖 Selected log file: " + log_filename);

// Build full path to the log file
let log_file_path = path_join(logs_dir, log_filename);

// Check if file exists
if !file_exists(log_file_path) {
    console_error("Selected log file does not exist: " + log_file_path);
    render_html("<div style='text-align: center; padding: 2rem;'><h3>File Not Found</h3><p>The selected log file could not be found.</p></div>");
    return "Log file not found: " + log_file_path;
}

// Read the log file content
print("📄 Reading log file...");
let log_content = read_file(log_file_path);

if log_content == "" {
    console_warn("Log file is empty or could not be read");
    render_html("<div style='text-align: center; padding: 2rem;'><h3>Empty File</h3><p>The selected log file is empty or could not be read.</p></div>");
    return "Log file is empty or unreadable";
}

// Count lines in log
let lines = log_content.split('\n');
let line_count = lines.len();

print("📊 Log file contains " + line_count + " lines");

// Prepare HTML display with syntax highlighting and formatting
let html_content = "<div style=\"font-family: 'Courier New', monospace; background: #1e1e1e; color: #d4d4d4; padding: 20px; border-radius: 8px; max-height: 80vh; overflow-y: auto;\">";
html_content += "<h2 style=\"color: #569cd6; margin-top: 0;\">📋 " + log_filename + "</h2>";
html_content += "<p style=\"color: #9cdcfe; margin-bottom: 20px;\">";
html_content += "<strong>File:</strong> " + log_file_path + "<br>";
html_content += "<strong>Lines:</strong> " + line_count + "<br>";
html_content += "<strong>Size:</strong> " + (file_size(log_file_path) / 1024.0).round() + " KB";
html_content += "</p>";
html_content += "<hr style=\"border: 1px solid #404040; margin: 20px 0;\">";
html_content += "<pre style=\"white-space: pre-wrap; margin: 0; font-size: 12px; line-height: 1.4;\">";

// Process each line with basic syntax highlighting
for line in lines {
    let styled_line = line;
    
    // Color coding based on log level
    if line.contains("❌ ERROR") {
        styled_line = "<span style=\"color: #f44747; background: rgba(244, 71, 71, 0.1); padding: 2px 4px; border-radius: 3px;\">" + line + "</span>";
    } else if line.contains("⚠️ WARN") {
        styled_line = "<span style=\"color: #ffcc02; background: rgba(255, 204, 2, 0.1); padding: 2px 4px; border-radius: 3px;\">" + line + "</span>";
    } else if line.contains("ℹ️ INFO") {
        styled_line = "<span style=\"color: #00d4aa;\">" + line + "</span>";
    } else if line.contains("🔍 DEBUG") {
        styled_line = "<span style=\"color: #9cdcfe;\">" + line + "</span>";
    } else if line.contains("📜") {
        styled_line = "<span style=\"color: #dcdcaa;\">" + line + "</span>";
    } else if line.contains("⚛️") {
        styled_line = "<span style=\"color: #61dafb;\">" + line + "</span>";
    }
    
    html_content += styled_line + "\n";
}

html_content += "</pre>";
html_content += "<div style=\"margin-top: 20px; padding: 15px; background: rgba(0, 212, 170, 0.1); border-radius: 5px; border-left: 4px solid #00d4aa;\">";
html_content += "<strong style=\"color: #00d4aa;\">💡 Log Reading Tips:</strong><br>";
html_content += "<span style=\"color: #d4d4d4; font-size: 11px;\">";
html_content += "• Use Ctrl+F to search within the log<br>";
html_content += "• Timestamps are in format: [YYYY-MM-DD HH:MM:SS.mmm]<br>";
html_content += "• Error logs include line numbers and context<br>";
html_content += "• Each script gets its own log file for easy debugging";
html_content += "</span>";
html_content += "</div>";
html_content += "</div>";

// Display the formatted log content
render_html(html_content);

print("✅ Log file displayed successfully");
console_log("Successfully displayed log file: " + log_filename + " (" + line_count + " lines)");
