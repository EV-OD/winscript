// @name: Simple Greeting
// @description: A simple Rhai script that greets the user

// Ask for the user's name
let name = ask_input("What's your name?");

// Show a greeting message
let greeting = `<div style="text-align: center; padding: 2rem;">
    <h1>Hello, ${name}!</h1>
    <p>Welcome to the Rhai scripting system!</p>
    <p>This script was written in Rhai and executed by the Rust backend.</p>
</div>`;

render_html(greeting);

// Complete the script
complete();
