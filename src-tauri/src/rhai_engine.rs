use rhai::{Engine, Scope, EvalAltResult, Array};
use std::path::PathBuf;
use crate::kits::ui_kit::Kit;
use crate::fs_kit::FileSystemKit;
use crate::process_kit::ProcessKit;
use std::sync::{Arc, Mutex};

/// Rhai script runner that handles script execution and Kit integration
pub struct RhaiScriptRunner {
    engine: Engine,
}

impl RhaiScriptRunner {
    /// Create a new Rhai script runner with Kit integration
    pub fn new(kit: Kit) -> Self {
        let mut engine = Engine::new();
        
        // Basic engine configuration
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        // Wrap Kit in Arc<Mutex<>> for thread safety
        let kit_shared = Arc::new(Mutex::new(kit));
        
        // Register Kit functions with Rhai engine
        Self::register_kit_functions(&mut engine, kit_shared.clone());
        
        // Register file system functions
        FileSystemKit::register_functions(&mut engine);
        
        // Register process execution functions
        ProcessKit::register_functions(&mut engine);
        
        println!("🟣 RhaiScriptRunner: Engine initialized with Kit integration, FileSystem, and Process execution");
        
        Self { engine }
    }
    
    /// Create a basic Rhai runner without Kit integration (for testing)
    pub fn new_basic() -> Self {
        let mut engine = Engine::new();
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        // Register file system functions even in basic mode
        FileSystemKit::register_functions(&mut engine);
        
        // Register process execution functions even in basic mode
        ProcessKit::register_functions(&mut engine);
        
        println!("🟣 RhaiScriptRunner: Basic engine initialized with FileSystem and Process execution (no Kit)");
        
        Self { engine }
    }
    
    /// Register Kit functions with the Rhai engine
    fn register_kit_functions(engine: &mut Engine, kit: Arc<Mutex<Kit>>) {
        println!("🟣 RhaiScriptRunner: Registering Kit functions");
        
        // Register ask_input function
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_input", move |message: &str| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.ask_input_sync(message)
            });
        }
        
        // Register ask_select function - handle Rhai array conversion
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_select", move |message: &str, options: Array| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                
                // Convert Rhai Array to Vec<String>
                let string_options: Vec<String> = options
                    .iter()
                    .filter_map(|item| item.clone().try_cast::<String>())
                    .collect();
                    
                kit_guard.ask_select_sync(message, string_options)
            });
        }
        
        // Register ask_number function
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_number", move |message: &str| -> f64 {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.ask_number_sync(message)
            });
        }
        
        // Register render_html function
        {
            let kit_clone = kit.clone();
            engine.register_fn("render_html", move |html_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_html_sync(html_content)
            });
        }

        // Register render_markdown function
        {
            let kit_clone = kit.clone();
            engine.register_fn("render_markdown", move |markdown_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_markdown_sync(markdown_content)
            });
        }

        // Register md function as a short alias for render_markdown
        {
            let kit_clone = kit.clone();
            engine.register_fn("md", move |markdown_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_markdown_sync(markdown_content)
            });
        }
        
        // Register show_message function
        {
            let kit_clone = kit.clone();
            engine.register_fn("show_message", move |title: &str, message: &str| -> bool {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.show_message_sync(title, message)
            });
        }
        
        // Register confirm function
        {
            let kit_clone = kit.clone();
            engine.register_fn("confirm", move |message: &str| -> bool {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.confirm_sync(message)
            });
        }
        
        // Register complete function
        {
            let kit_clone = kit.clone();
            engine.register_fn("complete", move || -> () {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.complete_sync()
            });
        }
        
        // Register reset_awaiting function  
        {
            let kit_clone = kit.clone();
            engine.register_fn("reset_awaiting", move || {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.reset_awaiting_sync();
            });
        }
        
        println!("🟣 RhaiScriptRunner: All Kit functions registered");
    }
    
    /// Execute a Rhai script from string content
    pub fn run_script(&self, script_content: &str) -> Result<(), Box<EvalAltResult>> {
        let mut scope = Scope::new();
        println!("🟣 RhaiScriptRunner: Executing script");
        
        // For now, just parse and run basic script
        self.engine.eval_with_scope::<()>(&mut scope, script_content)?;
        
        println!("🟣 RhaiScriptRunner: Script execution completed");
        Ok(())
    }
    
    /// Load and execute a script from file
    pub fn run_script_file(&self, file_path: PathBuf) -> Result<(), String> {
        let script_content = std::fs::read_to_string(&file_path)
            .map_err(|e| format!("Failed to read script file: {}", e))?;
            
        self.run_script(&script_content)
            .map_err(|e| format!("Script execution error: {}", e))
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_basic_rhai_execution() {
        // Create a basic engine without Kit for testing
        let mut engine = Engine::new();
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        let script = r#"
            let x = 1 + 2;
            print("Hello from Rhai! x = " + x);
        "#;
        
        let mut scope = Scope::new();
        assert!(engine.eval_with_scope::<()>(&mut scope, script).is_ok());
    }
}
