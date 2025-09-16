mod ui_controller;

use ui_controller::{ui_response, demo_ui_controller};

// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![greet, ui_response, demo_ui_controller])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
