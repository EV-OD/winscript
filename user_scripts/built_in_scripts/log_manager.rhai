// Log File Manager Script - practical file system usage

// Configuration
let log_dir = path_join(temp_dir(), "app_logs");
let log_file = path_join(log_dir, "application.log");
let backup_dir = path_join(log_dir, "backups");

print("📝 Log File Manager");
print("Log directory: " + log_dir);

// Ensure log directory exists
if !dir_exists(log_dir) {
    if create_dir_all(log_dir) {
        print("✅ Created log directory");
    } else {
        print("❌ Failed to create log directory");
        return;
    }
}

// Function to add a log entry
fn add_log_entry(log_file_path, message) {
    let timestamp = current_dir(); // Using current_dir as placeholder for timestamp
    let log_entry = "[" + timestamp + "] " + message + "\n";
    
    if append_file(log_file_path, log_entry) {
        print("✅ Added log entry: " + message);
    } else {
        print("❌ Failed to add log entry");
    }
}

// Add some sample log entries
add_log_entry(log_file, "Application started");
add_log_entry(log_file, "User logged in");
add_log_entry(log_file, "Processing data...");
add_log_entry(log_file, "Data processing completed");

// Check log file size and rotate if needed
if file_exists(log_file) {
    let size = file_size(log_file);
    print("📊 Current log file size: " + size + " bytes");
    
    // If file is getting large (simulate with > 50 bytes for demo)
    if size > 50 {
        print("🔄 Log file is getting large, creating backup...");
        
        // Create backup directory
        if !dir_exists(backup_dir) {
            create_dir_all(backup_dir);
        }
        
        // Create backup filename with timestamp
        let backup_file = path_join(backup_dir, "application_backup.log");
        
        // Copy current log to backup
        if copy_file(log_file, backup_file) {
            print("✅ Created backup: " + backup_file);
            
            // Start fresh log file
            let fresh_start = "=== Log file rotated ===\n";
            if write_file(log_file, fresh_start) {
                print("✅ Started fresh log file");
            }
        }
    }
}

// Display current log contents
if file_exists(log_file) {
    print("\n📖 Current log contents:");
    let content = read_file(log_file);
    print(content);
}

// List all files in log directory
print("\n📂 Log directory contents:");
let entries = list_dir(log_dir);
for entry in entries {
    let name = entry.name;
    let is_dir = entry.is_dir;
    let type_info = if is_dir { "[DIR]" } else { "[FILE " + entry.size + "B]" };
    print("  " + type_info + " " + name);
}

// If backup directory exists, show backup files
if dir_exists(backup_dir) {
    print("\n💾 Backup files:");
    let backup_entries = list_dir(backup_dir);
    for entry in backup_entries {
        if !entry.is_dir {
            print("  📄 " + entry.name + " (" + entry.size + " bytes)");
        }
    }
}

print("\n✨ Log management completed!");
