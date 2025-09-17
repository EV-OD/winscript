// @name: System Info
// @description: Displays system information and user preferences

// Welcome message
render_html("<div style='text-align: center; padding: 1rem;'><h2>System Information Collector</h2></div>");

// Ask for user's name
let name = ask_input("What's your name?");

// Ask for favorite programming language
let languages = ["Rust", "JavaScript", "Python", "TypeScript", "Java", "C#", "Go", "Other"];
let favorite_lang = ask_select("What's your favorite programming language?", languages);

// Ask for experience level
let levels = ["Beginner", "Intermediate", "Advanced", "Expert"];
let experience = ask_select("What's your programming experience level?", levels);

// Ask for preferred OS
let systems = ["Windows", "macOS", "Linux", "Other"];
let preferred_os = ask_select("What's your preferred operating system?", systems);

// Create summary
let summary_html = `<div style="background: #1e1e1e; padding: 2rem; border-radius: 8px; max-width: 600px; margin: 0 auto;">
    <h1 style="color: #4CAF50; text-align: center; margin-bottom: 2rem;">User Profile Summary</h1>
    
    <div style="display: grid; gap: 1rem;">
        <div style="background: #2d2d2d; padding: 1rem; border-radius: 4px;">
            <strong style="color: #87CEEB;">Name:</strong>
            <span style="color: #cccccc; margin-left: 1rem;">${name}</span>
        </div>
        
        <div style="background: #2d2d2d; padding: 1rem; border-radius: 4px;">
            <strong style="color: #87CEEB;">Favorite Language:</strong>
            <span style="color: #cccccc; margin-left: 1rem;">${favorite_lang}</span>
        </div>
        
        <div style="background: #2d2d2d; padding: 1rem; border-radius: 4px;">
            <strong style="color: #87CEEB;">Experience Level:</strong>
            <span style="color: #cccccc; margin-left: 1rem;">${experience}</span>
        </div>
        
        <div style="background: #2d2d2d; padding: 1rem; border-radius: 4px;">
            <strong style="color: #87CEEB;">Preferred OS:</strong>
            <span style="color: #cccccc; margin-left: 1rem;">${preferred_os}</span>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 2rem; padding-top: 1rem; border-top: 1px solid #3c3c3c;">
        <p style="color: #888; font-style: italic;">Profile created with Rhai scripting</p>
    </div>
</div>`;

render_html(summary_html);

// Complete the script
complete();
