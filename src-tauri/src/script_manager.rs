use serde::{Deserialize, Serialize};
use std::fs;
use std::path::{Path, PathBuf};
use std::env;

/// Information about a Rhai script
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ScriptInfo {
    pub id: String,
    pub name: String,
    pub description: String,
    pub file_path: PathBuf,
    pub category: String,
    pub script_type: ScriptType,
}

/// Type of script - Rust (built-in) or Rhai (user)
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum ScriptType {
    Rust,
    Rhai,
}

/// Script manager for discovering and managing Rhai scripts
pub struct ScriptManager {
    pub scripts: Vec<ScriptInfo>,
    project_root: PathBuf,
}

impl ScriptManager {
    /// Get the user scripts directory path with environment variable support
    pub fn get_user_scripts_path() -> PathBuf {
        // Try SNAPRUN_SCRIPTS environment variable first
        if let Ok(scripts_path) = env::var("SNAPRUN_SCRIPTS") {
            println!("🟣 Using SNAPRUN_SCRIPTS: {}", scripts_path);
            return PathBuf::from(scripts_path);
        }
        
        // Default to Documents/SnapRun/Scripts (user-friendly location)
        if let Some(docs_dir) = dirs::document_dir() {
            let scripts_path = docs_dir.join("SnapRun").join("Scripts");
            println!("🟣 Using Documents folder: {}", scripts_path.display());
            return scripts_path;
        }
        
        // Try SNAPRUN_HOME environment variable as fallback
        if let Ok(home_path) = env::var("SNAPRUN_HOME") {
            let scripts_path = PathBuf::from(home_path).join("Scripts");
            println!("🟣 Using SNAPRUN_HOME: {}", scripts_path.display());
            return scripts_path;
        }
        
        // Final fallback to project directory
        let fallback_path = PathBuf::from("./user_scripts");
        println!("🟣 Using project fallback: {}", fallback_path.display());
        fallback_path
    }

    /// Create a new script manager
    pub fn new(project_root: PathBuf) -> Self {
        Self {
            scripts: Vec::new(),
            project_root,
        }
    }

    /// Load all scripts from the user_scripts directory
    pub fn load_scripts(&mut self) -> Result<(), String> {
        println!("🟣 ScriptManager: Loading scripts from {:?}", self.project_root);
        
        self.scripts.clear();
        
        // Get user scripts path (with environment variable support)
        let user_scripts_path = Self::get_user_scripts_path();
        
        // Load built-in Rhai scripts from app installation
        let app_scripts_dir = self.project_root.join("user_scripts").join("built_in_scripts");
        if app_scripts_dir.exists() {
            self.load_scripts_from_directory(&app_scripts_dir, "Built-in", ScriptType::Rhai)?;
        }
        
        // Load user custom scripts directly from Documents folder
        if user_scripts_path.exists() {
            self.load_scripts_from_directory(&user_scripts_path, "Custom", ScriptType::Rhai)?;
        } else {
            // Create the directory if it doesn't exist
            if let Err(e) = fs::create_dir_all(&user_scripts_path) {
                println!("⚠️ Could not create user scripts directory: {}", e);
            }
        }
        
        // Also check legacy custom_scripts folder for backward compatibility
        let legacy_custom_dir = if user_scripts_path.parent().is_some() {
            user_scripts_path.parent().unwrap().join("custom_scripts")
        } else {
            self.project_root.join("user_scripts").join("custom_scripts")
        };
        
        if legacy_custom_dir.exists() && legacy_custom_dir != user_scripts_path {
            self.load_scripts_from_directory(&legacy_custom_dir, "Legacy", ScriptType::Rhai)?;
        }
        
        println!("🟣 ScriptManager: Loaded {} scripts total from {:?}", self.scripts.len(), user_scripts_path);
        Ok(())
    }
    
    /// Load scripts from a specific directory
    fn load_scripts_from_directory(
        &mut self,
        dir: &Path,
        category: &str,
        script_type: ScriptType,
    ) -> Result<(), String> {
        let entries = fs::read_dir(dir)
            .map_err(|e| format!("Failed to read directory {:?}: {}", dir, e))?;

        for entry in entries {
            let entry = entry.map_err(|e| format!("Failed to read directory entry: {}", e))?;
            let path = entry.path();

            // Only process .rhai files
            if let Some(extension) = path.extension() {
                if extension == "rhai" {
                    match self.create_script_info(&path, category, script_type.clone()) {
                        Ok(script_info) => {
                            println!("🟣 ScriptManager: Found script: {}", script_info.name);
                            self.scripts.push(script_info);
                        }
                        Err(e) => {
                            eprintln!("Warning: Failed to process script {:?}: {}", path, e);
                        }
                    }
                }
            }
        }

        Ok(())
    }

    /// Create script info from file path
    fn create_script_info(
        &self,
        file_path: &Path,
        category: &str,
        script_type: ScriptType,
    ) -> Result<ScriptInfo, String> {
        let file_name = file_path
            .file_stem()
            .and_then(|s| s.to_str())
            .ok_or("Invalid file name")?;

        // Generate a unique ID from the file path
        let id = format!("rhai_{}_{}",
            category.to_lowercase().replace(" ", "_"),
            file_name.replace(" ", "_")
        );

        // Try to extract metadata from the script file
        let (name, description) = self.extract_script_metadata(file_path)?;

        Ok(ScriptInfo {
            id,
            name: name.unwrap_or_else(|| self.format_script_name(file_name)),
            description: description.unwrap_or_else(|| format!("Rhai script: {}", file_name)),
            file_path: file_path.to_path_buf(),
            category: category.to_string(),
            script_type,
        })
    }

    /// Extract metadata from script file comments
    fn extract_script_metadata(&self, file_path: &Path) -> Result<(Option<String>, Option<String>), String> {
        let content = fs::read_to_string(file_path)
            .map_err(|e| format!("Failed to read script file: {}", e))?;

        let mut name = None;
        let mut description = None;

        // Look for metadata in comments at the top of the file
        for line in content.lines().take(10) { // Only check first 10 lines
            let line = line.trim();
            
            if line.starts_with("// @name:") {
                name = Some(line.strip_prefix("// @name:").unwrap().trim().to_string());
            } else if line.starts_with("// @description:") {
                description = Some(line.strip_prefix("// @description:").unwrap().trim().to_string());
            } else if !line.starts_with("//") && !line.is_empty() {
                // Stop reading metadata when we hit actual code
                break;
            }
        }

        Ok((name, description))
    }

    /// Format script name from file name
    fn format_script_name(&self, file_name: &str) -> String {
        file_name
            .replace("_", " ")
            .replace("-", " ")
            .split_whitespace()
            .map(|word| {
                let mut chars = word.chars();
                match chars.next() {
                    None => String::new(),
                    Some(first) => first.to_uppercase().collect::<String>() + chars.as_str(),
                }
            })
            .collect::<Vec<String>>()
            .join(" ")
    }

    /// Get script by ID
    pub fn get_script_by_id(&self, id: &str) -> Option<&ScriptInfo> {
        self.scripts.iter().find(|script| script.id == id)
    }

    /// Get all scripts of a specific type
    pub fn get_scripts_by_type(&self, script_type: ScriptType) -> Vec<&ScriptInfo> {
        self.scripts.iter()
            .filter(|script| script.script_type == script_type)
            .collect()
    }

    /// Get all scripts in a category
    pub fn get_scripts_by_category(&self, category: &str) -> Vec<&ScriptInfo> {
        self.scripts.iter()
            .filter(|script| script.category == category)
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;

    #[test]
    fn test_script_name_formatting() {
        let manager = ScriptManager::new(PathBuf::new());
        
        assert_eq!(manager.format_script_name("hello_world"), "Hello World");
        assert_eq!(manager.format_script_name("my-awesome-script"), "My Awesome Script");
        assert_eq!(manager.format_script_name("simple"), "Simple");
    }

    #[test] 
    fn test_script_id_generation() {
        // Create a temporary file for testing
        use std::fs;
        use std::io::Write;
        
        let temp_dir = std::env::temp_dir();
        let test_file = temp_dir.join("test_script.rhai");
        
        // Write a simple test script
        let mut file = fs::File::create(&test_file).unwrap();
        writeln!(file, "// @name: Test Script").unwrap();
        writeln!(file, "// @description: A test script").unwrap();
        writeln!(file, "print(\"Hello, World!\");").unwrap();
        
        let manager = ScriptManager::new(PathBuf::new());
        let script_info = manager.create_script_info(&test_file, "Built-in", ScriptType::Rhai).unwrap();
        
        assert_eq!(script_info.id, "rhai_built-in_test_script");
        assert_eq!(script_info.name, "Test Script");
        assert_eq!(script_info.description, "A test script");
        
        // Clean up
        let _ = fs::remove_file(&test_file);
    }
}
