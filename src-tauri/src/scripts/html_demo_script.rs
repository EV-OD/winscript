use crate::kits::Kit;
use tauri::AppHandle;

/// Demo script that only shows HTML content (should stay visible until manually closed)
#[tauri::command]
pub async fn html_demo_script(app_handle: AppHandle) -> Result<String, String> {
    println!("🟣 html_demo_script: Starting HTML-only demo");
    
    let kit = Kit::new(app_handle);

    // Show HTML content that should persist
    kit.render_html(
        "HTML Demo", 
        r#"
        <div style='padding: 2rem; text-align: center; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 12px; margin: 1rem;'>
            <h1>🎨 Persistent HTML Demo</h1>
            <p style='font-size: 1.2em; margin: 1rem 0;'>This HTML content should stay visible because this script doesn't use any awaiting components.</p>
            
            <div style='background: rgba(255,255,255,0.1); padding: 1rem; border-radius: 8px; margin: 2rem 0;'>
                <h3>Features:</h3>
                <ul style='text-align: left; list-style: none; padding: 0;'>
                    <li>✅ render_html() - Non-awaiting, fire-and-forget</li>
                    <li>❌ ask_input() - Would make script auto-close when complete</li>
                    <li>❌ ask_select() - Would make script auto-close when complete</li>
                </ul>
            </div>
            
            <div style='background: rgba(255,255,255,0.1); padding: 1rem; border-radius: 8px; margin: 2rem 0;'>
                <h3>How to close:</h3>
                <p>• Press <kbd style='background: rgba(0,0,0,0.3); padding: 0.2rem 0.4rem; border-radius: 4px;'>Ctrl+W</kbd> to go back</p>
                <p>• Press <kbd style='background: rgba(0,0,0,0.3); padding: 0.2rem 0.4rem; border-radius: 4px;'>Q</kbd> to go back</p>
                <p>• Click the <strong>Back</strong> button</p>
            </div>
            
            <p style='font-size: 0.9em; opacity: 0.8; margin-top: 2rem;'>
                This content will remain visible until you manually close it!
            </p>
        </div>
        "#
    )?;

    // Complete the script - but since it has no awaiting components, it should stay visible
    kit.script_complete().await?;

    println!("🟣 html_demo_script: Script completed, HTML should remain visible");
    Ok("HTML Demo completed - content should remain visible".to_string())
}
