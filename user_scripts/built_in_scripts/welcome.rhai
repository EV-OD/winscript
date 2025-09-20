// Welcome Script - Introduction to SnapRun
// Description: Welcome new users and provide an overview of SnapRun features

info("Welcome Script: Displaying welcome message");

render_html("🎉 Welcome to SnapRun", `
    <div style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 2rem; border-radius: 12px; font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6;">
        <div style="text-align: center; margin-bottom: 2rem;">
            <h1 style="margin: 0; font-size: 2.5rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">🎉 Welcome to SnapRun</h1>
            <p style="font-size: 1.3rem; margin: 0.5rem 0; opacity: 0.9;">Instant Windows Automation Platform</p>
        </div>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1.5rem; margin: 2rem 0;">
            <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 8px;">
                <h3 style="margin-top: 0; color: #74b9ff;">🚀 Built With</h3>
                <ul style="margin: 0; padding-left: 1.5rem;">
                    <li>Rust + Tauri for performance and security</li>
                    <li>Rhai scripting engine for easy automation</li>
                    <li>Monaco Editor for advanced editing</li>
                    <li>Glass UI effects for modern appearance</li>
                </ul>
            </div>
            
            <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 8px;">
                <h3 style="margin-top: 0; color: #55a3ff;">⌨️ Getting Started</h3>
                <ul style="margin: 0; padding-left: 1.5rem;">
                    <li><code style="background: rgba(0,0,0,0.3); padding: 0.2rem 0.5rem; border-radius: 4px;">Ctrl+Shift+J</code> to show/hide SnapRun</li>
                    <li>Type to search and filter scripts</li>
                    <li>Press Enter to run selected scripts</li>
                    <li>Drag the grip area to move window</li>
                </ul>
            </div>
        </div>
        
        <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 8px; margin: 1.5rem 0;">
            <h3 style="margin-top: 0; color: #fd79a8;">📋 Core Features</h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                <div>• File system operations</div>
                <div>• Process management</div>
                <div>• HTML rendering capabilities</div>
                <div>• Logging and debugging tools</div>
                <div>• Todo management system</div>
                <div>• Advanced calculations</div>
            </div>
        </div>
        
        <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 8px; margin: 1.5rem 0;">
            <h3 style="margin-top: 0; color: #fdcb6e;">🔧 Available Scripts</h3>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem;">
                <div><strong>eval</strong> - Execute Rhai expressions</div>
                <div><strong>showlog</strong> - View application logs</div>
                <div><strong>create-script</strong> - Create new scripts</div>
                <div><strong>addTodo/showTodo/removeTodo</strong> - Task management</div>
            </div>
        </div>
        
        <div style="background: rgba(255,255,255,0.15); padding: 1.5rem; border-radius: 8px; border-left: 4px solid #00b894;">
            <h3 style="margin-top: 0; color: #00b894;">💡 Pro Tips</h3>
            <ul style="margin: 0; padding-left: 1.5rem;">
                <li>Scripts run in isolated contexts for safety</li>
                <li>Use <code style="background: rgba(0,0,0,0.3); padding: 0.2rem 0.5rem; border-radius: 4px;">exit_and_hide()</code> to close and minimize</li>
                <li>Check logs for debugging information</li>
                <li>Create custom scripts for your workflows</li>
            </ul>
        </div>
        
        <div style="text-align: center; margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid rgba(255,255,255,0.2);">
            <p style="font-size: 1.1rem; margin: 0; opacity: 0.8;">Made with ❤️ by Rabin</p>
            <p style="font-size: 1.2rem; margin: 0.5rem 0 0 0; font-weight: bold;">Happy scripting! 🎯</p>
        </div>
    </div>
`);
