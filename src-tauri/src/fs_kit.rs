use std::path::Path;
use std::fs;
use std::io::Write;
use rhai::{Engine, Array, Map, Dynamic};
use dirs;

/// File system operations for Rhai scripts
pub struct FileSystemKit;

impl FileSystemKit {
    /// Register all file system functions with the Rhai engine
    pub fn register_functions(engine: &mut Engine) {
        println!("🟣 FileSystemKit: Registering file system functions");

        // File reading functions
        engine.register_fn("read_file", Self::read_file);
        engine.register_fn("file_exists", Self::file_exists);

        // File writing functions
        engine.register_fn("write_file", Self::write_file);
        engine.register_fn("append_file", Self::append_file);

        // File operations
        engine.register_fn("copy_file", Self::copy_file);
        engine.register_fn("move_file", Self::move_file);
        engine.register_fn("remove_file", Self::remove_file);
        engine.register_fn("file_size", Self::file_size);

        // Directory operations
        engine.register_fn("create_dir", Self::create_dir);
        engine.register_fn("create_dir_all", Self::create_dir_all);
        engine.register_fn("remove_dir", Self::remove_dir);
        engine.register_fn("remove_dir_all", Self::remove_dir_all);
        engine.register_fn("list_dir", Self::list_dir);
        engine.register_fn("dir_exists", Self::dir_exists);

        // Path helpers
        engine.register_fn("path_join", Self::path_join);
        engine.register_fn("path_parent", Self::path_parent);
        engine.register_fn("path_filename", Self::path_filename);
        engine.register_fn("path_extension", Self::path_extension);

        // Special directories
        engine.register_fn("home_dir", Self::home_dir);
        engine.register_fn("temp_dir", Self::temp_dir);
        engine.register_fn("current_dir", Self::current_dir);

        // Aliases for compatibility with existing scripts
        engine.register_fn("read_text_file", Self::read_file);  // Alias for read_file
        engine.register_fn("write_text_file", Self::write_file); // Alias for write_file
        engine.register_fn("create_directory", Self::create_dir_all); // Alias for create_dir_all
        engine.register_fn("get_home_dir", Self::home_dir); // Alias for home_dir

        println!("🟣 FileSystemKit: All file system functions registered");
    }

    // File reading functions
    fn read_file(path: &str) -> String {
        match fs::read_to_string(path) {
            Ok(content) => content,
            Err(e) => {
                println!("❌ Failed to read file '{}': {}", path, e);
                String::new()
            }
        }
    }

    fn file_exists(path: &str) -> bool {
        Path::new(path).exists() && Path::new(path).is_file()
    }

    // File writing functions
    fn write_file(path: &str, content: &str) -> bool {
        match fs::write(path, content) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to write file '{}': {}", path, e);
                false
            }
        }
    }

    fn append_file(path: &str, content: &str) -> bool {
        use std::fs::OpenOptions;
        
        let mut file = match OpenOptions::new()
            .create(true)
            .append(true)
            .open(path) {
            Ok(file) => file,
            Err(e) => {
                println!("❌ Failed to open file for appending '{}': {}", path, e);
                return false;
            }
        };

        match file.write_all(content.as_bytes()) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to append to file '{}': {}", path, e);
                false
            }
        }
    }

    // File operations
    fn copy_file(src: &str, dst: &str) -> bool {
        match fs::copy(src, dst) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to copy file from '{}' to '{}': {}", src, dst, e);
                false
            }
        }
    }

    fn move_file(src: &str, dst: &str) -> bool {
        match fs::rename(src, dst) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to move file from '{}' to '{}': {}", src, dst, e);
                false
            }
        }
    }

    fn remove_file(path: &str) -> bool {
        match fs::remove_file(path) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to remove file '{}': {}", path, e);
                false
            }
        }
    }

    fn file_size(path: &str) -> i64 {
        match fs::metadata(path) {
            Ok(metadata) => metadata.len() as i64,
            Err(e) => {
                println!("❌ Failed to get file metadata '{}': {}", path, e);
                -1
            }
        }
    }

    // Directory operations
    fn create_dir(path: &str) -> bool {
        match fs::create_dir(path) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to create directory '{}': {}", path, e);
                false
            }
        }
    }

    fn create_dir_all(path: &str) -> bool {
        match fs::create_dir_all(path) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to create directory tree '{}': {}", path, e);
                false
            }
        }
    }

    fn remove_dir(path: &str) -> bool {
        match fs::remove_dir(path) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to remove directory '{}': {}", path, e);
                false
            }
        }
    }

    fn remove_dir_all(path: &str) -> bool {
        match fs::remove_dir_all(path) {
            Ok(_) => true,
            Err(e) => {
                println!("❌ Failed to remove directory tree '{}': {}", path, e);
                false
            }
        }
    }

    fn list_dir(path: &str) -> Array {
        let entries = match fs::read_dir(path) {
            Ok(entries) => entries,
            Err(e) => {
                println!("❌ Failed to read directory '{}': {}", path, e);
                return Array::new();
            }
        };

        let mut result = Array::new();
        
        for entry in entries {
            let entry = match entry {
                Ok(entry) => entry,
                Err(e) => {
                    println!("❌ Failed to read directory entry: {}", e);
                    continue;
                }
            };
            
            let path = entry.path();
            let mut item_map = Map::new();
            
            item_map.insert("name".into(), Dynamic::from(
                path.file_name()
                    .and_then(|s| s.to_str())
                    .unwrap_or("")
                    .to_string()
            ));
            
            item_map.insert("path".into(), Dynamic::from(
                path.to_string_lossy().to_string()
            ));
            
            item_map.insert("is_dir".into(), Dynamic::from(path.is_dir()));
            item_map.insert("is_file".into(), Dynamic::from(path.is_file()));
            
            // Get file size if it's a file
            if path.is_file() {
                if let Ok(metadata) = fs::metadata(&path) {
                    item_map.insert("size".into(), Dynamic::from(metadata.len() as i64));
                } else {
                    item_map.insert("size".into(), Dynamic::from(0i64));
                }
            } else {
                item_map.insert("size".into(), Dynamic::from(0i64));
            }
            
            result.push(Dynamic::from(item_map));
        }

        result
    }

    fn dir_exists(path: &str) -> bool {
        Path::new(path).exists() && Path::new(path).is_dir()
    }

    // Path helpers
    fn path_join(path1: &str, path2: &str) -> String {
        Path::new(path1).join(path2).to_string_lossy().to_string()
    }

    fn path_parent(path: &str) -> String {
        Path::new(path)
            .parent()
            .map(|p| p.to_string_lossy().to_string())
            .unwrap_or_default()
    }

    fn path_filename(path: &str) -> String {
        Path::new(path)
            .file_name()
            .and_then(|s| s.to_str())
            .unwrap_or("")
            .to_string()
    }

    fn path_extension(path: &str) -> String {
        Path::new(path)
            .extension()
            .and_then(|s| s.to_str())
            .unwrap_or("")
            .to_string()
    }

    // Special directories
    fn home_dir() -> String {
        dirs::home_dir()
            .map(|p| p.to_string_lossy().to_string())
            .unwrap_or_else(|| {
                std::env::var("HOME")
                    .or_else(|_| std::env::var("USERPROFILE"))
                    .unwrap_or_else(|_| "".to_string())
            })
    }

    fn temp_dir() -> String {
        std::env::temp_dir().to_string_lossy().to_string()
    }

    fn current_dir() -> String {
        match std::env::current_dir() {
            Ok(path) => path.to_string_lossy().to_string(),
            Err(e) => {
                println!("❌ Failed to get current directory: {}", e);
                String::new()
            }
        }
    }
}
