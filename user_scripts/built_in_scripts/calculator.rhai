// @name: Calculator
// @description: Simple calculator with input validation

// Ask for first number
let first = ask_input("Enter first number:");

// Ask for operation
let operations = ["Add (+)", "Subtract (-)", "Multiply (*)", "Divide (/)"];
let operation = ask_select("Choose operation:", operations);

// Ask for second number
let second = ask_input("Enter second number:");

// Convert to numbers (Rhai handles this automatically for arithmetic)
let num1 = parse_float(first);
let num2 = parse_float(second);

// Perform calculation
let result = if operation == "Add (+)" {
    num1 + num2
} else if operation == "Subtract (-)" {
    num1 - num2
} else if operation == "Multiply (*)" {
    num1 * num2
} else if operation == "Divide (/)" {
    if num2 == 0.0 {
        render_html("<div style='color: red; text-align: center;'><h2>Error: Division by zero!</h2></div>");
        complete();
        return;
    }
    num1 / num2
} else {
    render_html("<div style='color: red; text-align: center;'><h2>Unknown operation</h2></div>");
    complete();
    return;
};

// Display result
let result_html = `<div style="text-align: center; padding: 2rem;">
    <h1>Calculator Result</h1>
    <div style="font-size: 1.5rem; margin: 1rem 0;">
        <strong>${first} ${operation.split(" ")[0]} ${second} = ${result}</strong>
    </div>
    <p style="color: #888;">Calculation completed successfully!</p>
</div>`;

render_html(result_html);

// Complete the script
complete();
