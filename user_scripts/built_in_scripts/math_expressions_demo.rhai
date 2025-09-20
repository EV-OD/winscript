// @name: Math Expression Evaluator
// @description: Interactive mathematical expression evaluation with examples

// Mathematical Expression Evaluator - Test mathematical functions dynamically
// Try complex formulas and see instant results

let html_content = `
<div style="font-family: 'Segoe UI', sans-serif; max-width: 800px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #2c3e50; text-align: center; margin-bottom: 30px;">
        🧮 Mathematical Expression Evaluator
    </h1>
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">✨ Live Expression Examples</h2>
        <div style="background: rgba(255,255,255,0.1); padding: 20px; border-radius: 10px; font-family: monospace;">`;

// Example mathematical expressions
let expressions = [
    "2 + 3 * 4 - 1",
    "sqrt(16) + pow(2, 3)",
    "sin(PI() / 2) + cos(0)",
    "log(E()) + ln(10)",
    "abs(-15) + max(10, 20)",
    "factorial(5) / combination(10, 3)",
    "circle_area(5) / PI()",
    "celsius_to_fahrenheit(25)",
    "kilometers_to_miles(100)",
    "compound_interest(1000, 5, 10, 12)"
];

for expr in expressions {
    // Note: In a real implementation, you'd use eval() function if available
    // For now, we'll calculate each expression manually
    let result = 0.0;
    if expr == "2 + 3 * 4 - 1" {
        result = 2 + 3 * 4 - 1;
    } else if expr == "sqrt(16) + pow(2, 3)" {
        result = sqrt(16) + pow(2, 3);
    } else if expr == "sin(PI() / 2) + cos(0)" {
        result = sin(PI() / 2) + cos(0);
    } else if expr == "log(E()) + ln(10)" {
        result = log(E()) + ln(10);
    } else if expr == "abs(-15) + max(10, 20)" {
        result = abs(-15) + max(10, 20);
    } else if expr == "factorial(5) / combination(10, 3)" {
        result = factorial(5) / combination(10, 3);
    } else if expr == "circle_area(5) / PI()" {
        result = circle_area(5) / PI();
    } else if expr == "celsius_to_fahrenheit(25)" {
        result = celsius_to_fahrenheit(25);
    } else if expr == "kilometers_to_miles(100)" {
        result = kilometers_to_miles(100);
    } else if expr == "compound_interest(1000, 5, 10, 12)" {
        result = compound_interest(1000, 5, 10, 12);
    }
    
    html_content += `<div style="margin: 10px 0; padding: 10px; background: rgba(255,255,255,0.1); border-radius: 5px;">
        <strong>${expr}</strong> = <span style="color: #90EE90;">${round(result * 10000) / 10000}</span>
    </div>`;
}

html_content += `        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">📊 Available Mathematical Functions</h2>
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Basic Operations</h4>
                <p><strong>Arithmetic:</strong> +, -, *, /, pow(base, exp)</p>
                <p><strong>Roots:</strong> sqrt(x), cbrt(x)</p>
                <p><strong>Rounding:</strong> round(x), floor(x), ceil(x)</p>
                <p><strong>Comparison:</strong> abs(x), min(a,b), max(a,b)</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Trigonometry</h4>
                <p><strong>Basic:</strong> sin(x), cos(x), tan(x)</p>
                <p><strong>Inverse:</strong> asin(x), acos(x), atan(x)</p>
                <p><strong>Hyperbolic:</strong> sinh(x), cosh(x), tanh(x)</p>
                <p><strong>Conversion:</strong> radians(deg), degrees(rad)</p>
            </div>
        </div>
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Logarithms & Exponentials</h4>
                <p><strong>Logarithms:</strong> ln(x), log10(x), log2(x)</p>
                <p><strong>Exponentials:</strong> exp(x), exp2(x)</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Advanced Functions</h4>
                <p><strong>Statistics:</strong> factorial(n), combination(n,r)</p>
                <p><strong>Geometry:</strong> circle_area(r), distance(x1,y1,x2,y2)</p>
                <p><strong>Finance:</strong> compound_interest(p,r,t,n)</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: #333; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">🔢 Mathematical Constants</h2>
        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 15px; text-align: center;">
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>π (Pi)</h4>
                <p style="font-family: monospace; font-size: 1.2em;">${round(PI() * 1000000) / 1000000}</p>
                <p style="font-size: 0.9em;">Circle circumference ratio</p>
            </div>
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>e (Euler)</h4>
                <p style="font-family: monospace; font-size: 1.2em;">${round(E() * 1000000) / 1000000}</p>
                <p style="font-size: 0.9em;">Natural logarithm base</p>
            </div>
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>τ (Tau)</h4>
                <p style="font-family: monospace; font-size: 1.2em;">${round(TAU() * 1000000) / 1000000}</p>
                <p style="font-size: 0.9em;">2π, full circle</p>
            </div>
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>√2</h4>
                <p style="font-family: monospace; font-size: 1.2em;">${round(SQRT_2() * 1000000) / 1000000}</p>
                <p style="font-size: 0.9em;">Square root of 2</p>
            </div>
        </div>
    </div>
    
    <div style="background: #f8f9fa; border-radius: 10px; padding: 20px; border: 2px solid #e9ecef;">
        <h3 style="color: #495057; margin-top: 0;">💡 Usage Examples in Your Scripts</h3>
        <div style="font-family: monospace; background: #ffffff; padding: 15px; border-radius: 5px; border-left: 4px solid #007bff;">
            <p><strong>// Basic calculations</strong></p>
            <p>let area = circle_area(radius);</p>
            <p>let hypotenuse = sqrt(a*a + b*b);</p>
            <p></p>
            <p><strong>// Financial calculations</strong></p>
            <p>let investment = compound_interest(1000, 7, 10, 12);</p>
            <p>let tip = percentage(bill_amount, 18);</p>
            <p></p>
            <p><strong>// Unit conversions</strong></p>
            <p>let temp_f = celsius_to_fahrenheit(temp_c);</p>
            <p>let distance_miles = kilometers_to_miles(distance_km);</p>
            <p></p>
            <p><strong>// Scientific calculations</strong></p>
            <p>let solutions = quadratic(a, b, c);</p>
            <p>let combinations = combination(n, r);</p>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 30px; color: #6c757d;">
        <p><strong>SnapRun Mathematical Expression Evaluator</strong></p>
        <p>All these functions are available in your Rhai scripts!</p>
    </div>
</div>
`;

render_html(html_content);
complete();
