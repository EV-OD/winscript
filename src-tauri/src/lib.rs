mod ui_controller;
mod kits;
mod scripts;

use ui_controller::{ui_response, demo_ui_controller};
use kits::{demo_kit_usage};
use scripts::{greeting_script, html_demo_script};

// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![greet, ui_response, demo_ui_controller, demo_kit_usage, greeting_script, html_demo_script])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
