use crate::ui_controller::UIController;
use tauri::AppHandle;

/// Simple kit for easy user interaction in Rust scripts
pub struct Kit {
    ui_controller: UIController,
    has_awaiting_components: bool,
}

impl Kit {
    /// Create a new Kit instance
    pub fn new(app_handle: AppHandle) -> Self {
        Self {
            ui_controller: UIController::new(app_handle),
            has_awaiting_components: false,
        }
    }

    /// Ask user for text input
    pub async fn ask_input(&mut self, message: &str) -> Result<String, String> {
        self.has_awaiting_components = true;
        self.ui_controller.ask_input(message).await
    }

    /// Ask user to select from a list of options
    pub async fn ask_select(&mut self, message: &str, options: Vec<&str>) -> Result<String, String> {
        self.has_awaiting_components = true;
        let string_options: Vec<String> = options.iter().map(|s| s.to_string()).collect();
        self.ui_controller.ask_select(message, string_options).await
    }

    /// Render HTML content to the user
    pub fn render_html(&self, title: &str, html_content: &str) -> Result<(), String> {
        self.ui_controller.show_html_sync(title, html_content)
    }

    /// Reset awaiting components flag - use this before render_html if you want the UI to stay visible
    pub fn reset_awaiting_flag(&mut self) {
        println!("🟣 Kit: Resetting awaiting components flag - UI will stay visible on completion");
        self.has_awaiting_components = false;
    }

    /// Show a simple message to the user
    pub fn show_message(&self, title: &str, message: &str) -> Result<(), String> {
        let html = format!("<div style='text-align: center; padding: 2rem;'><h3>{}</h3><p>{}</p></div>", title, message);
        self.render_html(title, &html)
    }

    /// Signal that the script is complete (smart auto-close based on component usage)
    pub async fn script_complete(&self) -> Result<(), String> {
        // Send completion signal with smart close information
        let completion_request = crate::ui_controller::UIRequest {
            id: "script_complete".to_string(),
            r#type: "complete".to_string(),
            message: if self.has_awaiting_components {
                "Script Complete - Auto Close".to_string()
            } else {
                "Script Complete - Stay Visible".to_string()
            },
            options: Some(vec![self.has_awaiting_components.to_string()]),
            html_content: None,
        };
        
        self.ui_controller
            .emit_event("ui_request", &completion_request)?;
        
        Ok(())
    }

    /// Explicitly exit/close the UI window
    pub async fn exit(&self) -> Result<(), String> {
        let exit_request = crate::ui_controller::UIRequest {
            id: "script_exit".to_string(),
            r#type: "complete".to_string(),
            message: "Script Exit - Force Close".to_string(),
            options: Some(vec!["true".to_string()]), // Always close
            html_content: None,
        };
        
        self.ui_controller
            .emit_event("ui_request", &exit_request)?;
        
        Ok(())
    }

    /// Ask user for confirmation (Yes/No)
    pub async fn confirm(&self, message: &str) -> Result<bool, String> {
        let response = self.ui_controller.ask_select(
            message,
            vec!["Yes".to_string(), "No".to_string()]
        ).await?;
        Ok(response.to_lowercase() == "yes")
    }

    /// Ask user for a number input
    pub async fn ask_number(&mut self, message: &str) -> Result<f64, String> {
        self.has_awaiting_components = true;
        println!("🟣 Kit: ask_number called with message: {}", message);
        loop {
            let input = self.ui_controller.ask_input(message).await?;
            println!("🟣 Kit: ask_number received input: '{}'", input);
            match input.trim().parse::<f64>() {
                Ok(num) => {
                    println!("🟣 Kit: ask_number parsed successfully: {}", num);
                    return Ok(num);
                },
                Err(e) => {
                    println!("🟣 Kit: ask_number parse failed: {}", e);
                    self.show_message("Invalid Input", "Please enter a valid number.")?;
                }
            }
        }
    }
}

/// Convenience function to create a new Kit instance
pub fn create_kit(app_handle: AppHandle) -> Kit {
    Kit::new(app_handle)
}

// Example usage function for demonstration
#[tauri::command]
pub async fn demo_kit_usage(app_handle: tauri::AppHandle) -> Result<String, String> {
    let mut kit = Kit::new(app_handle);

    // Ask for name
    let name = kit.ask_input("Enter your first name:").await?;
    
    // Ask for last name  
    let last_name = kit.ask_input("Enter your last name:").await?;
    
    // Ask for age
    let age = kit.ask_number("Enter your age:").await?;
    
    // Ask for favorite color
    let color = kit.ask_select(
        "Choose your favorite color:",
        vec!["Red", "Blue", "Green", "Purple", "Orange"]
    ).await?;

    // Show confirmation HTML first
    let confirmation_html = format!(
        r#"
        <div style="text-align: center; padding: 2rem;">
            <h2>Please confirm your information:</h2>
            <div style="background: #1a1a2e; padding: 1rem; border-radius: 8px; margin: 1rem 0;">
                <p><strong>Name:</strong> {} {}</p>
                <p><strong>Age:</strong> {}</p>
                <p><strong>Favorite Color:</strong> {}</p>
            </div>
        </div>
        "#,
        name, last_name, age as i32, color
    );

    kit.render_html("Confirm Information", &confirmation_html)?;
    let confirmed = kit.confirm("Is this information correct?").await?;

    if confirmed {
        // Show final result
        let result_html = format!(
            r#"
            <div style="text-align: center; padding: 2rem;">
                <h1 style="color: {};">Welcome, {} {}! 🎉</h1>
                <p>You are {} years old and your favorite color is {}.</p>
                <p style="color: #4CAF50;">✅ Profile created successfully!</p>
            </div>
            "#,
            color.to_lowercase(), name, last_name, age as i32, color
        );
        
        kit.render_html("Profile Created", &result_html)?;
        Ok(format!("Profile created for {} {} (age: {}, color: {})", name, last_name, age as i32, color))
    } else {
        kit.show_message("Cancelled", "Profile creation was cancelled.")?;
        Ok("Profile creation cancelled".to_string())
    }
}
