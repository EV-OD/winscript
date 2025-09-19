mod ui_controller;
mod kits;
mod scripts;
mod rhai_engine;
mod script_manager;
mod fs_kit;
mod process_kit;

use ui_controller::{ui_response, demo_ui_controller};
use kits::{demo_kit_usage, ui_kit::Kit};
use scripts::{greeting_script, html_demo_script};
use rhai_engine::RhaiScriptRunner;
use script_manager::{ScriptManager, ScriptInfo};
use tauri::Manager;
use tauri::{
    menu::{Menu, MenuItem},
    tray::{TrayIcon, TrayIconBuilder, TrayIconEvent},
    Runtime, Emitter, image::Image,
};
use tauri_plugin_global_shortcut::{GlobalShortcutExt};

// Import platform-specific blur functions (currently using CSS-only approach)
// #[cfg(target_os = "windows")]
// use window_vibrancy::{apply_blur};

#[cfg(target_os = "macos")]
use window_vibrancy::{apply_vibrancy, NSVisualEffectMaterial, NSVisualEffectState};

#[cfg(target_os = "linux")]
use window_vibrancy::apply_blur;

// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

// Platform detection command
#[tauri::command]
fn get_platform() -> String {
    #[cfg(target_os = "windows")]
    return "windows".to_string();
    
    #[cfg(target_os = "macos")]
    return "macos".to_string();
    
    #[cfg(target_os = "linux")]
    return "linux".to_string();
    
    #[cfg(not(any(target_os = "windows", target_os = "macos", target_os = "linux")))]
    return "unknown".to_string();
}

// Reset UI state to script search page
#[tauri::command]
async fn reset_ui_state(window: tauri::WebviewWindow) {
    println!("🔄 Resetting UI state to script search page");
    
    // Emit an event to the frontend to reset to script search page
    if let Err(e) = window.emit("reset-to-script-search", ()) {
        eprintln!("Failed to emit reset-to-script-search event: {}", e);
    }
}

// Cross-platform blur setup function
fn setup_window_blur(_window: &tauri::WebviewWindow) -> Result<(), Box<dyn std::error::Error>> {
    #[cfg(target_os = "windows")]
    {
        // Disable native Windows blur to use CSS-only glass effects
        println!("🪟 Using CSS-only glass effects on Windows");
    }

    #[cfg(target_os = "macos")]
    {
        // macOS: Use vibrancy with dark appearance
        apply_vibrancy(
            window, 
            NSVisualEffectMaterial::Sidebar,
            Some(NSVisualEffectState::Active), 
            Some(10.0)
        )?;
        println!("🍎 macOS vibrancy applied");
    }

    #[cfg(target_os = "linux")]
    {
        // Linux: Basic blur (depends on compositor support)
        if let Err(e) = apply_blur(window, Some((18, 18, 18, 125))) {
            println!("🐧 Linux blur failed (compositor may not support it): {}", e);
        } else {
            println!("🐧 Linux blur applied");
        }
    }

    Ok(())
}

// Create system tray
fn create_tray<R: Runtime>(app: &tauri::AppHandle<R>) -> tauri::Result<TrayIcon<R>> {
    let show_i = MenuItem::with_id(app, "show", "Show WinScript2", true, None::<&str>)?;
    let hide_i = MenuItem::with_id(app, "hide", "Hide to Tray", true, None::<&str>)?;
    let quit_i = MenuItem::with_id(app, "quit", "Quit", true, None::<&str>)?;
    let menu = Menu::with_items(app, &[&show_i, &hide_i, &quit_i])?;

    TrayIconBuilder::with_id("main-tray")
        .icon(
            // Try to load specific icon file, fallback to default
            Image::from_path("icons/icon.ico")
                .or_else(|_| Image::from_path("icons/32x32.png"))
                .unwrap_or_else(|_| app.default_window_icon().unwrap().clone())
        )
        .tooltip("WinScript2 - Ctrl+Shift+J to open")
        .menu(&menu)
        .show_menu_on_left_click(false)
        .on_tray_icon_event(|tray, event| match event {
            TrayIconEvent::Click { button: tauri::tray::MouseButton::Left, .. } => {
                let app = tray.app_handle();
                if let Some(window) = app.get_webview_window("main") {
                    let _ = window.show();
                    let _ = window.set_focus();
                    
                    // Reset UI to script search page
                    if let Err(e) = window.emit("reset-to-script-search", ()) {
                        eprintln!("Failed to emit reset-to-script-search event: {}", e);
                    }
                }
            }
            _ => {}
        })
        .on_menu_event(|app, event| match event.id.as_ref() {
            "show" => {
                if let Some(window) = app.get_webview_window("main") {
                    let _ = window.show();
                    let _ = window.set_focus();
                    
                    // Reset UI to script search page
                    if let Err(e) = window.emit("reset-to-script-search", ()) {
                        eprintln!("Failed to emit reset-to-script-search event: {}", e);
                    }
                }
            }
            "hide" => {
                if let Some(window) = app.get_webview_window("main") {
                    let _ = window.hide();
                }
            }
            "quit" => {
                std::process::exit(0);
            }
            _ => {}
        })
        .build(app)
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
async fn run_rhai_script(script_id: String, app_handle: tauri::AppHandle) -> Result<String, String> {
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
        .find(|s| s.id == script_id)
        .ok_or_else(|| format!("Script '{}' not found", script_id))?;
    
    // Read script content
    let script_content = std::fs::read_to_string(&script_info.file_path)
        .map_err(|e| format!("Failed to read script '{}': {}", script_id, e))?;
    
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
        .plugin(tauri_plugin_global_shortcut::Builder::new().build())
        .setup(|app| {
            let window = app.get_webview_window("main").unwrap();
            
            // Apply blur effects
            if let Err(e) = setup_window_blur(&window) {
                eprintln!("❌ Failed to apply window blur: {}", e);
            }

            // Create system tray
            let _tray = create_tray(&app.handle())
                .expect("Failed to create system tray");

            // Register global shortcuts with error handling
            let app_handle = app.handle().clone();
            
            // Try to unregister the shortcut first in case it's already registered
            let _ = app.global_shortcut().unregister("CmdOrCtrl+Shift+J");
            
            // Ctrl+Shift+J to show the window from tray
            let shortcut_handle = app_handle.clone();
            let _ = app.global_shortcut().on_shortcut("CmdOrCtrl+Shift+J", move |_app, _shortcut, _event| {
                if let Some(window) = shortcut_handle.get_webview_window("main") {
                    let _ = window.show();
                    let _ = window.set_focus();
                    
                    // Reset UI to script search page
                    if let Err(e) = window.emit("reset-to-script-search", ()) {
                        eprintln!("Failed to emit reset-to-script-search event: {}", e);
                    }
                }
            });
            
            // Register the shortcut with error handling
            match app.global_shortcut().register("CmdOrCtrl+Shift+J") {
                Ok(_) => println!("✅ Global shortcut Ctrl+Shift+J registered successfully"),
                Err(e) => eprintln!("⚠️  Failed to register global shortcut Ctrl+Shift+J: {}", e),
            }

            // Show window on first launch
            window.show().unwrap();
            
            println!("🚀 WinScript2 initialized with system tray and global shortcut (Ctrl+Shift+J)");

            Ok(())
        })
        .on_window_event(|window, event| {
            match event {
                tauri::WindowEvent::CloseRequested { api, .. } => {
                    // Prevent the window from closing and hide it instead
                    window.hide().unwrap();
                    api.prevent_close();
                }
                _ => {}
            }
        })
        .invoke_handler(tauri::generate_handler![greet, ui_response, demo_ui_controller, demo_kit_usage, greeting_script, html_demo_script, list_rhai_scripts, run_rhai_script, get_platform, reset_ui_state])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
