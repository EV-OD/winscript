// File Organizer Script - organize files by extension

// Ask user for the directory to organize
let source_dir = ask_input("Enter the directory path to organize (or press Enter for temp directory):");
if source_dir == "" {
    source_dir = temp_dir();
}

print("🗂️  File Organizer");
print("Organizing files in: " + source_dir);

// Check if directory exists
if !dir_exists(source_dir) {
    show_message("Error", "Directory does not exist: " + source_dir);
    return;
}

// Create organized folder
let organized_dir = path_join(source_dir, "organized");
if !dir_exists(organized_dir) {
    if create_dir_all(organized_dir) {
        print("✅ Created organized directory");
    } else {
        print("❌ Failed to create organized directory");
        return;
    }
}

// Get list of files to organize
let entries = list_dir(source_dir);
let files_to_organize = [];

for entry in entries {
    if !entry.is_dir && entry.name != "organized" {
        files_to_organize.push(entry);
    }
}

print("📁 Found " + files_to_organize.len() + " files to organize");

// Group files by extension
let extension_groups = #{};

for file in files_to_organize {
    let file_path = path_join(source_dir, file.name);
    let ext = path_extension(file_path);
    
    // Use "no_extension" for files without extension
    if ext == "" {
        ext = "no_extension";
    }
    
    // Convert extension to lowercase
    ext = ext.to_lower();
    
    // Initialize array if doesn't exist
    if !extension_groups.contains(ext) {
        extension_groups[ext] = [];
    }
    
    extension_groups[ext].push(file);
}

print("📊 File extensions found:");
for ext in extension_groups.keys() {
    let count = extension_groups[ext].len();
    print("  ." + ext + ": " + count + " files");
}

// Ask user if they want to proceed
let proceed = confirm("Do you want to organize these files into folders by extension?");
if !proceed {
    print("❌ Organization cancelled by user");
    return;
}

// Create folders and move files
let moved_count = 0;
for ext in extension_groups.keys() {
    let ext_dir = path_join(organized_dir, ext + "_files");
    
    // Create extension directory
    if !dir_exists(ext_dir) {
        if create_dir_all(ext_dir) {
            print("✅ Created directory: " + ext + "_files");
        } else {
            print("❌ Failed to create directory for ." + ext);
            continue;
        }
    }
    
    // Move files of this extension
    let files = extension_groups[ext];
    for file in files {
        let src_path = path_join(source_dir, file.name);
        let dst_path = path_join(ext_dir, file.name);
        
        // Check if destination file already exists
        if file_exists(dst_path) {
            print("⚠️  File already exists, skipping: " + file.name);
            continue;
        }
        
        if move_file(src_path, dst_path) {
            moved_count += 1;
            print("📦 Moved: " + file.name + " -> " + ext + "_files/");
        } else {
            print("❌ Failed to move: " + file.name);
        }
    }
}

// Create a summary report
let report_content = "File Organization Report\n";
report_content += "========================\n";
report_content += "Source Directory: " + source_dir + "\n";
report_content += "Organized Directory: " + organized_dir + "\n";
report_content += "Files Moved: " + moved_count + "\n\n";

report_content += "Organization by Extension:\n";
for ext in extension_groups.keys() {
    let count = extension_groups[ext].len();
    report_content += "  ." + ext + ": " + count + " files\n";
}

let report_path = path_join(organized_dir, "organization_report.txt");
if write_file(report_path, report_content) {
    print("✅ Created organization report: " + report_path);
}

// Show final summary
print("\n🎉 File organization completed!");
print("📊 Summary:");
print("  Total files moved: " + moved_count);
print("  Report saved to: " + report_path);

// Offer to open the organized directory
let open_dir = confirm("Would you like to see the organized directory contents?");
if open_dir {
    print("\n📂 Organized directory structure:");
    let org_entries = list_dir(organized_dir);
    for entry in org_entries {
        let name = entry.name;
        if entry.is_dir {
            print("  📁 " + name + "/");
            // Show contents of subdirectory
            let sub_entries = list_dir(path_join(organized_dir, name));
            for sub_entry in sub_entries {
                if !sub_entry.is_dir {
                    print("    📄 " + sub_entry.name);
                }
            }
        } else {
            print("  📄 " + name);
        }
    }
}

show_message("Success", "Files have been organized successfully! " + moved_count + " files moved.");
