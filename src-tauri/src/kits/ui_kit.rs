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

    // =============================================================================
    // SYNC WRAPPERS FOR RHAI INTEGRATION
    // =============================================================================

    /// Sync wrapper for ask_input - for use in Rhai scripts
    pub fn ask_input_sync(&mut self, message: &str) -> String {
        // Handle async in sync context using block_in_place
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                match self.ask_input(message).await {
                    Ok(result) => result,
                    Err(e) => {
                        eprintln!("Error in ask_input_sync: {}", e);
                        String::new() // Return empty string on error
                    }
                }
            })
        })
    }

    /// Sync wrapper for ask_select - for use in Rhai scripts  
    pub fn ask_select_sync(&mut self, message: &str, options: Vec<String>) -> String {
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                let str_options: Vec<&str> = options.iter().map(|s| s.as_str()).collect();
                match self.ask_select(message, str_options).await {
                    Ok(result) => result,
                    Err(e) => {
                        eprintln!("Error in ask_select_sync: {}", e);
                        String::new() // Return empty string on error
                    }
                }
            })
        })
    }

    /// Sync wrapper for ask_number - for use in Rhai scripts
    pub fn ask_number_sync(&mut self, message: &str) -> f64 {
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                match self.ask_number(message).await {
                    Ok(result) => result,
                    Err(e) => {
                        eprintln!("Error in ask_number_sync: {}", e);
                        0.0 // Return 0.0 on error
                    }
                }
            })
        })
    }

    /// Sync wrapper for render_html - for use in Rhai scripts (already sync!)
    pub fn render_html_sync(&mut self, html_content: &str) -> bool {
        // Reset the awaiting flag before rendering HTML so UI stays visible after completion
        println!("🟣 Kit: render_html_sync called - resetting awaiting components flag");
        self.has_awaiting_components = false;
        
        match self.render_html("Rhai Script Output", html_content) {
            Ok(_) => {
                println!("🟣 Kit: HTML rendered successfully, UI will stay visible");
                true
            },
            Err(e) => {
                eprintln!("Error in render_html_sync: {}", e);
                false
            }
        }
    }

    /// Sync wrapper for render_markdown - converts markdown to HTML and renders it
    pub fn render_markdown_sync(&mut self, markdown_content: &str) -> bool {
        use pulldown_cmark::{Parser, Options, html};
        
        // Reset the awaiting flag before rendering so UI stays visible after completion
        println!("🟣 Kit: render_markdown_sync called - converting markdown to HTML");
        self.has_awaiting_components = false;
        
        // Configure markdown parser with common extensions
        let mut options = Options::empty();
        options.insert(Options::ENABLE_STRIKETHROUGH);
        options.insert(Options::ENABLE_TABLES);
        options.insert(Options::ENABLE_FOOTNOTES);
        options.insert(Options::ENABLE_TASKLISTS);
        options.insert(Options::ENABLE_SMART_PUNCTUATION);
        
        // Parse markdown and convert to HTML
        let parser = Parser::new_ext(markdown_content, options);
        let mut html_output = String::new();
        html::push_html(&mut html_output, parser);
        
        // Simple styling that works with existing glass container - no extra background layers
        let styled_html = format!(
            r#"
            <style>
                /* Simple dark theme styling - no glass backgrounds */
                body, * {{
                    color: #ffffff !important;
                    background: none !important;
                }}
                
                /* Headers */
                h1, h2, h3, h4, h5, h6 {{ 
                    margin-top: 1.5em; 
                    margin-bottom: 0.5em; 
                    color: #ffffff !important; 
                    font-weight: 600;
                }}
                
                h1 {{ 
                    border-bottom: 2px solid rgba(255, 255, 255, 0.3); 
                    padding-bottom: 0.3em; 
                }}
                
                h2 {{ 
                    border-bottom: 1px solid rgba(255, 255, 255, 0.2); 
                    padding-bottom: 0.2em; 
                }}
                
                /* Code styling - minimal dark background */
                code {{ 
                    background: rgba(0, 0, 0, 0.3) !important; 
                    color: #e1e5e9 !important;
                    padding: 3px 6px; 
                    border-radius: 4px; 
                    font-family: 'Consolas', 'Monaco', 'Courier New', monospace; 
                }}
                
                pre {{ 
                    background: rgba(0, 0, 0, 0.3) !important; 
                    color: #e1e5e9 !important;
                    padding: 16px; 
                    border-radius: 8px; 
                    overflow-x: auto; 
                    margin: 16px 0;
                }}
                
                pre code {{ 
                    background: none !important; 
                    padding: 0; 
                }}
                
                /* Blockquotes */
                blockquote {{ 
                    border-left: 4px solid rgba(255, 255, 255, 0.4); 
                    margin: 16px 0; 
                    padding: 16px; 
                    color: rgba(255, 255, 255, 0.8) !important; 
                    font-style: italic;
                    background: rgba(0, 0, 0, 0.15) !important;
                    border-radius: 6px;
                }}
                
                /* Tables */
                table {{ 
                    border-collapse: collapse; 
                    width: 100%; 
                    margin: 16px 0; 
                }}
                
                th, td {{ 
                    border: 1px solid rgba(255, 255, 255, 0.15); 
                    padding: 8px 12px; 
                    text-align: left; 
                    color: #ffffff !important;
                }}
                
                th {{ 
                    background: rgba(0, 0, 0, 0.2) !important; 
                    font-weight: 600; 
                }}
                
                /* Lists */
                ul, ol {{ 
                    color: #ffffff !important;
                }}
                
                li {{ 
                    color: #ffffff !important;
                }}
                
                /* Links */
                a {{ 
                    color: #64b5f6 !important; 
                    text-decoration: none; 
                }}
                
                a:hover {{ 
                    color: #90caf9 !important;
                }}
                
                /* Paragraphs */
                p {{
                    color: rgba(255, 255, 255, 0.9) !important;
                }}
                
                /* Emphasis */
                strong {{
                    color: #ffffff !important;
                    font-weight: 600;
                }}
                
                em {{
                    color: rgba(255, 255, 255, 0.9) !important;
                }}
            </style>
            {}
            "#,
            html_output
        );
        
        match self.render_html("Markdown Content", &styled_html) {
            Ok(_) => {
                println!("🟣 Kit: Markdown rendered successfully as HTML, UI will stay visible");
                true
            },
            Err(e) => {
                eprintln!("Error in render_markdown_sync: {}", e);
                false
            }
        }
    }

    /// Sync wrapper for show_message - for use in Rhai scripts (already sync!)
    pub fn show_message_sync(&self, title: &str, message: &str) -> bool {
        match self.show_message(title, message) {
            Ok(_) => true,
            Err(e) => {
                eprintln!("Error in show_message_sync: {}", e);
                false
            }
        }
    }

    /// Sync wrapper for confirm - for use in Rhai scripts
    pub fn confirm_sync(&self, message: &str) -> bool {
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                match self.confirm(message).await {
                    Ok(result) => result,
                    Err(e) => {
                        eprintln!("Error in confirm_sync: {}", e);
                        false // Return false on error
                    }
                }
            })
        })
    }

    /// Sync wrapper for script completion - for use in Rhai scripts
    pub fn complete_sync(&self) -> () {
        tokio::task::block_in_place(|| {
            tokio::runtime::Handle::current().block_on(async {
                match self.script_complete().await {
                    Ok(_) => (),
                    Err(e) => {
                        eprintln!("Error in complete_sync: {}", e);
                        ()
                    }
                }
            })
        })
    }

    /// Reset awaiting flag (already sync!)
    pub fn reset_awaiting_sync(&mut self) {
        self.reset_awaiting_flag();
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
