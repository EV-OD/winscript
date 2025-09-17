mod ui_controller;
mod kits;
mod scripts;
mod rhai_engine;
mod script_manager;

use ui_controller::{ui_response, demo_ui_controller};
use kits::{demo_kit_usage, ui_kit::Kit};
use scripts::{greeting_script, html_demo_script};
use rhai_engine::RhaiScriptRunner;
use script_manager::{ScriptManager, ScriptInfo};

// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

// List all available Rhai scripts
#[tauri::command]
async fn list_rhai_scripts() -> Result<Vec<ScriptInfo>, String> {
    // Try to get WIN_SCRIPT2_PATH environment variable first
    let user_scripts_path = match std::env::var("WIN_SCRIPT2_PATH") {
        Ok(path) => {
            println!("🟣 Using WIN_SCRIPT2_PATH: {}", path);
            std::path::PathBuf::from(path)
        },
        Err(_) => {
            // Fallback to current directory logic for development
            let current_dir = std::env::current_dir()
                .map_err(|e| format!("Failed to get current directory: {}", e))?;
            
            let fallback_path = if current_dir.file_name().and_then(|n| n.to_str()) == Some("src-tauri") {
                current_dir.parent().unwrap().join("user_scripts")
            } else {
                current_dir.join("user_scripts")
            };
            
            println!("🟣 WIN_SCRIPT2_PATH not found, using fallback: {:?}", fallback_path);
            fallback_path
        }
    };
    
    // ScriptManager expects project root, so get parent of user_scripts
    let project_root = user_scripts_path.parent()
        .ok_or_else(|| "Failed to get parent directory of user_scripts".to_string())?
        .to_path_buf();
    
    let mut script_manager = ScriptManager::new(project_root);
    script_manager.load_scripts().map_err(|e| format!("Failed to load scripts: {}", e))?;
    
    Ok(script_manager.scripts)
}

// Execute a Rhai script by its ID
#[tauri::command]
async fn run_rhai_script(scriptId: String, app_handle: tauri::AppHandle) -> Result<String, String> {
    // Create Kit instance using the app handle
    let kit = Kit::new(app_handle);
    
    // Try to get WIN_SCRIPT2_PATH environment variable first
    let user_scripts_path = match std::env::var("WIN_SCRIPT2_PATH") {
        Ok(path) => {
            println!("🟣 Using WIN_SCRIPT2_PATH: {}", path);
            std::path::PathBuf::from(path)
        },
        Err(_) => {
            // Fallback to current directory logic for development
            let current_dir = std::env::current_dir()
                .map_err(|e| format!("Failed to get current directory: {}", e))?;
            
            let fallback_path = if current_dir.file_name().and_then(|n| n.to_str()) == Some("src-tauri") {
                current_dir.parent().unwrap().join("user_scripts")
            } else {
                current_dir.join("user_scripts")
            };
            
            println!("🟣 WIN_SCRIPT2_PATH not found, using fallback: {:?}", fallback_path);
            fallback_path
        }
    };
    
    // ScriptManager expects project root, so get parent of user_scripts
    let project_root = user_scripts_path.parent()
        .ok_or_else(|| "Failed to get parent directory of user_scripts".to_string())?
        .to_path_buf();
    
    // Load scripts to find the requested one
    let mut script_manager = ScriptManager::new(project_root);
    script_manager.load_scripts().map_err(|e| format!("Failed to load scripts: {}", e))?;
    
    let script_info = script_manager.scripts.iter()
        .find(|s| s.id == scriptId)
        .ok_or_else(|| format!("Script '{}' not found", scriptId))?;
    
    // Read script content
    let script_content = std::fs::read_to_string(&script_info.file_path)
        .map_err(|e| format!("Failed to read script '{}': {}", scriptId, e))?;
    
    // Create Rhai runner and execute
    let runner = RhaiScriptRunner::new(kit);
    match runner.run_script(&script_content) {
        Ok(_) => Ok(format!("Script '{}' executed successfully", script_info.name)),
        Err(e) => Err(format!("Script execution failed: {}", e))
    }
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![greet, ui_response, demo_ui_controller, demo_kit_usage, greeting_script, html_demo_script, list_rhai_scripts, run_rhai_script])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
