// Demo: clear all .log files under the SnapRun logs directory
// Test Worked
// What this script should do:
// 1) Locate the logs directory in Documents/SnapRun/logs.
// 2) If it exists, overwrite each .log file with empty content.
// 3) Print progress to the console; render an HTML notice if directory is missing.
let logs_dir = path_join(home_dir(), "Documents\\SnapRun\\logs");

if !dir_exists(logs_dir) {
    console_warn("Logs directory does not exist: " + logs_dir);
    render_html("<div style='text-align: center; padding: 2rem;'><h3>No Logs Directory</h3><p>The logs directory does not exist yet. Run some scripts first to generate logs.</p></div>");
    return;
}

print("📁 Clearing all log files in directory: " + logs_dir);


let log_files = list_dir(logs_dir);
let log_options = [];

for file_info in log_files {
    if file_info.is_file && file_info.name.ends_with(".log") {
        write_file(path_join(logs_dir, file_info.name), "");
    }
}

// Ensure a final HTML render exists at the end
render_html("<div style='padding:1rem'><strong>Logs cleared (if any existed).</strong></div>");
exit_and_hide()
