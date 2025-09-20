// Eval Script - Execute Rhai expressions dynamically
// Description: Simple Rhai expression evaluator

let expr = ask_input("Rhai expression ('exit' to quit):");

if expr == "exit" || expr == "quit" || expr == "q" {
    exit();
}

if expr.trim() == "" {
    md("### Empty Expression\n\n");
}

try {
    let result = eval(expr);
    render_html("✅", "<div style='font-size:2em;'>" + result + "</div>");
} catch (error) {
    render_html("❌ Error", "<div><b>Expression:</b> <code>" + expr + "</code><br><b>Error:</b> <code>" + error + "</code></div>");
}
