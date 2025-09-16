use crate::kits::Kit;
use tauri::AppHandle;
use std::sync::{Arc, Mutex};
use std::sync::OnceLock;

// Global flag to prevent multiple script instances
static SCRIPT_RUNNING: OnceLock<Arc<Mutex<bool>>> = OnceLock::new();

fn get_script_lock() -> &'static Arc<Mutex<bool>> {
    SCRIPT_RUNNING.get_or_init(|| Arc::new(Mutex::new(false)))
}

/// Simple greeting script that takes user input and shows personalized output
#[tauri::command]
pub async fn greeting_script(app_handle: AppHandle) -> Result<String, String> {
    println!("🟣 greeting_script: Function called");
    
    // Check if script is already running
    {
        let lock = get_script_lock();
        let mut running = lock.lock().map_err(|e| e.to_string())?;
        if *running {
            println!("🟣 greeting_script: Script already running, returning early");
            return Err("Script is already running".to_string());
        }
        *running = true;
        println!("🟣 greeting_script: Set running flag to true");
    }
    
    let result = run_greeting_script_impl(app_handle).await;
    
    // Clear the running flag
    {
        let lock = get_script_lock();
        if let Ok(mut running) = lock.lock() {
            *running = false;
            println!("🟣 greeting_script: Script finished, cleared running flag");
        }
    }
    
    result
}

async fn run_greeting_script_impl(app_handle: AppHandle) -> Result<String, String> {
    let kit = Kit::new(app_handle);

    // Welcome message
    println!("🟣 greeting_script: Showing welcome message");
    kit.show_message("Welcome", "Welcome to the Greeting Script!").await?;

    // Get user's name
    println!("🟣 greeting_script: Asking for name");
    let name = kit.ask_input("What's your name?").await?;
    println!("🟣 greeting_script: Received name: {}", name);
    
    // Get user's age
    println!("🟣 greeting_script: Asking for age");
    let age = kit.ask_number("How old are you?").await?;
    println!("🟣 greeting_script: Received age: {}", age);
    
    // Ask for favorite hobby
    println!("🟣 greeting_script: Asking for hobby");
    let hobby = kit.ask_select(
        "What's your favorite hobby?",
        vec!["Reading", "Gaming", "Sports", "Music", "Cooking", "Travel"]
    ).await?;
    println!("🟣 greeting_script: Received hobby: {}", hobby);

    // Ask for favorite time of day
    let time_of_day = kit.ask_select(
        "When do you feel most productive?",
        vec!["Morning", "Afternoon", "Evening", "Night"]
    ).await?;

    // Generate personalized message based on inputs
    let age_group = if age < 18.0 {
        "young explorer"
    } else if age < 30.0 {
        "energetic individual"
    } else if age < 50.0 {
        "experienced person"
    } else {
        "wise soul"
    };

    let hobby_message = match hobby.as_str() {
        "Reading" => "Books open up new worlds! 📚",
        "Gaming" => "Games are a great way to unwind! 🎮",
        "Sports" => "Staying active keeps the mind sharp! ⚽",
        "Music" => "Music is the language of the soul! 🎵",
        "Cooking" => "Creating delicious meals is an art! 👨‍🍳",
        "Travel" => "Exploring new places broadens horizons! ✈️",
        _ => "That's an interesting hobby! 🌟"
    };

    let time_message = match time_of_day.as_str() {
        "Morning" => "Early birds catch the worm! 🌅",
        "Afternoon" => "Midday energy is powerful! ☀️",
        "Evening" => "Sunset vibes are peaceful! 🌆",
        "Night" => "Night owls have their own magic! 🌙",
        _ => "Every time has its charm! ⏰"
    };

    // Create personalized HTML output
    let output_html = format!(
        r#"
        <div style="text-align: center; padding: 2rem; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 15px; color: white;">
            <h1>🎉 Hello, {}! 🎉</h1>
            <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 10px; margin: 1rem 0;">
                <h2>Your Personal Profile</h2>
                <p style="font-size: 1.2rem;"><strong>Name:</strong> {}</p>
                <p style="font-size: 1.2rem;"><strong>Age:</strong> {} years old ({} ✨)</p>
                <p style="font-size: 1.2rem;"><strong>Favorite Hobby:</strong> {}</p>
                <p style="font-size: 1.2rem;"><strong>Most Productive Time:</strong> {}</p>
            </div>
            
            <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: 10px; margin: 1rem 0;">
                <h3>🌟 Personalized Messages 🌟</h3>
                <p style="font-size: 1.1rem; margin: 0.5rem 0;">{}</p>
                <p style="font-size: 1.1rem; margin: 0.5rem 0;">{}</p>
            </div>

            <div style="margin-top: 2rem; font-size: 1.1rem;">
                <p>🎯 <strong>Remember:</strong> You're amazing just the way you are!</p>
                <p>💫 Keep pursuing your passions and have a wonderful day!</p>
            </div>
        </div>
        "#,
        name, name, age as i32, age_group, hobby, time_of_day, hobby_message, time_message
    );

    // Show the personalized output
    kit.render_html("Your Personalized Greeting", &output_html).await?;

    // Ask if they want to save this information
    let save_info = kit.confirm("Would you like to save this greeting for later?").await?;
    
    if save_info {
        kit.show_message("Saved!", "Your personalized greeting has been saved! 💾").await?;
        Ok(format!("Greeting created and saved for {} (age: {}, hobby: {})", name, age as i32, hobby))
    } else {
        kit.show_message("Thanks!", "Thanks for using the Greeting Script! 👋").await?;
        Ok(format!("Greeting created for {} (age: {}, hobby: {})", name, age as i32, hobby))
    }
}
