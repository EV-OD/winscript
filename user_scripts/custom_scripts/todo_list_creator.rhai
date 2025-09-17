// @name: Todo List Creator
// @description: Create and display a simple todo list

// Welcome message
render_html("<div style='text-align: center; padding: 1rem;'><h2>📝 Todo List Creator</h2></div>");

// Ask for list title
let list_title = ask_input("What's the title of your todo list?");

// Collect todo items
let todos = [];
let continue_adding = true;

while continue_adding {
    let item = ask_input("Enter a todo item (or leave empty to finish):");
    
    if item.len() == 0 {
        continue_adding = false;
    } else {
        todos.push(item);
        
        // Ask if they want to add more
        let add_more_options = ["Yes, add another", "No, I'm done"];
        let add_more = ask_select("Add another item?", add_more_options);
        
        if add_more == "No, I'm done" {
            continue_adding = false;
        }
    }
}

// Generate the todo list HTML
let todo_items_html = "";
for i in range(0, todos.len()) {
    todo_items_html += `<li style="margin: 0.5rem 0; padding: 0.5rem; background: #2d2d2d; border-radius: 4px;">
        <input type="checkbox" style="margin-right: 0.5rem;"> ${todos[i]}
    </li>`;
}

let final_html = `<div style="background: #1e1e1e; padding: 2rem; border-radius: 8px; max-width: 600px; margin: 0 auto;">
    <h1 style="color: #4CAF50; text-align: center; margin-bottom: 1.5rem;">${list_title}</h1>
    
    <div style="background: #0d1117; padding: 1.5rem; border-radius: 6px; border: 1px solid #3c3c3c;">
        <ul style="list-style: none; padding: 0; margin: 0;">
            ${todo_items_html}
        </ul>
    </div>
    
    <div style="text-align: center; margin-top: 1.5rem;">
        <p style="color: #888; font-size: 0.9rem;">✅ Total items: ${todos.len()}</p>
        <p style="color: #666; font-size: 0.8rem; font-style: italic;">Created with custom Rhai script</p>
    </div>
</div>`;

render_html(final_html);

// Complete the script
complete();
