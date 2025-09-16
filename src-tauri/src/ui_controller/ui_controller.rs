use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use tauri::{Manager, Emitter};
use tokio::sync::oneshot;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UIRequest {
    pub id: String,
    pub r#type: String,
    pub message: String,
    pub options: Option<Vec<String>>,
    pub html_content: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UIResponse {
    pub id: String,
    pub value: String,
}

type PendingRequests = Arc<Mutex<HashMap<String, oneshot::Sender<String>>>>;

#[tauri::command]
pub async fn ui_response(
    id: String,
    value: String,
    state: tauri::State<'_, PendingRequests>,
) -> Result<(), String> {
    println!("🟣 ui_response: Called with id: {}, value: {}", id, value);
    let mut pending = state.lock().map_err(|e| e.to_string())?;
    if let Some(sender) = pending.remove(&id) {
        println!("🟣 ui_response: Found sender for ID, sending response");
        let _ = sender.send(value);
    } else {
        println!("🔴 ui_response: No sender found for ID: {}", id);
    }
    Ok(())
}

pub struct UIController {
    app_handle: tauri::AppHandle,
    pending_requests: PendingRequests,
}

impl UIController {
    pub fn new(app_handle: tauri::AppHandle) -> Self {
        let pending_requests = Arc::new(Mutex::new(HashMap::new()));
        
        // Store pending_requests in app state
        app_handle.manage(pending_requests.clone());
        
        Self {
            app_handle,
            pending_requests,
        }
    }

    pub async fn ask_input(&self, message: &str) -> Result<String, String> {
        println!("🟣 UIController: ask_input called with message: {}", message);
        let id = Uuid::new_v4().to_string();
        println!("🟣 UIController: Generated request ID: {}", id);
        let (sender, receiver) = oneshot::channel();

        // Store the sender for this request
        {
            let mut pending = self.pending_requests.lock().map_err(|e| e.to_string())?;
            pending.insert(id.clone(), sender);
        }

        let request = UIRequest {
            id: id.clone(),
            r#type: "input".to_string(),
            message: message.to_string(),
            options: None,
            html_content: None,
        };

        // Emit to frontend
        println!("🟣 UIController: Emitting ui_request event");
        self.app_handle
            .emit("ui_request", &request)
            .map_err(|e| e.to_string())?;

        // Wait for response
        println!("🟣 UIController: Waiting for response");
        let result = receiver.await.map_err(|_| "Request cancelled".to_string());
        println!("🟣 UIController: Received response: {:?}", result);
        result
    }

    /// Emit a custom event to the frontend
    pub fn emit_event<T: serde::Serialize>(&self, event: &str, payload: &T) -> Result<(), String> {
        self.app_handle
            .emit(event, payload)
            .map_err(|e| e.to_string())
    }

    pub async fn ask_select(&self, message: &str, options: Vec<String>) -> Result<String, String> {
        let id = Uuid::new_v4().to_string();
        let (sender, receiver) = oneshot::channel();

        // Store the sender for this request
        {
            let mut pending = self.pending_requests.lock().map_err(|e| e.to_string())?;
            pending.insert(id.clone(), sender);
        }

        let request = UIRequest {
            id: id.clone(),
            r#type: "select".to_string(),
            message: message.to_string(),
            options: Some(options),
            html_content: None,
        };

        // Emit to frontend
        self.app_handle
            .emit("ui_request", &request)
            .map_err(|e| e.to_string())?;

        // Wait for response
        receiver.await.map_err(|_| "Request cancelled".to_string())
    }

    pub async fn show_html(&self, message: &str, html_content: &str) -> Result<(), String> {
        let id = Uuid::new_v4().to_string();

        let request = UIRequest {
            id,
            r#type: "html".to_string(),
            message: message.to_string(),
            options: None,
            html_content: Some(html_content.to_string()),
        };

        // Emit to frontend
        self.app_handle
            .emit("ui_request", &request)
            .map_err(|e| e.to_string())?;

        Ok(())
    }

    /// Show HTML content synchronously (fire and forget)
    pub fn show_html_sync(&self, message: &str, html_content: &str) -> Result<(), String> {
        let id = Uuid::new_v4().to_string();

        let request = UIRequest {
            id,
            r#type: "html".to_string(),
            message: message.to_string(),
            options: None,
            html_content: Some(html_content.to_string()),
        };

        // Emit to frontend
        self.app_handle
            .emit("ui_request", &request)
            .map_err(|e| e.to_string())?;

        Ok(())
    }
}

// Example usage function
#[tauri::command]
pub async fn demo_ui_controller(
    app_handle: tauri::AppHandle,
) -> Result<String, String> {
    let ui_controller = UIController::new(app_handle);

    let name = ui_controller.ask_input("Enter your name:").await?;
    let favorite_color = ui_controller.ask_select(
        "Choose your favorite color:",
        vec!["Red".to_string(), "Blue".to_string(), "Green".to_string(), "Purple".to_string()]
    ).await?;

    let result = format!("Hello {}! Your favorite color is {}.", name, favorite_color);
    
    ui_controller.show_html(
        "Result:",
        &format!("<h2>Welcome!</h2><p>{}</p>", result)
    ).await?;

    Ok(result)
}
