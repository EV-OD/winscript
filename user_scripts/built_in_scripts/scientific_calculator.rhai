// @name: Scientific Calculator
// @description: Advanced scientific and financial calculations with interactive solving

// Scientific Calculator - Specialized Mathematical Tools
// Compound interest, quadratic equations, statistics, and more

let html_content = `
<div style="font-family: 'Segoe UI', sans-serif; max-width: 900px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #2c3e50; text-align: center; margin-bottom: 30px;">
        🔬 Scientific Calculator Suite
    </h1>
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">💰 Financial Mathematics</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Simple Interest</h4>
                <p><strong>Principal:</strong> $1,000</p>
                <p><strong>Rate:</strong> 5% annually</p>
                <p><strong>Time:</strong> 3 years</p>
                <p><strong>Interest:</strong> $${1000 * 0.05 * 3}</p>
                <p><strong>Total:</strong> $${1000 + (1000 * 0.05 * 3)}</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Compound Interest</h4>
                <p><strong>Principal:</strong> $1,000</p>
                <p><strong>Rate:</strong> 5% annually</p>
                <p><strong>Time:</strong> 3 years</p>
                <p><strong>Compounded:</strong> Monthly</p>
                <p><strong>Amount:</strong> $${round(compound_interest(1000, 5, 3, 12) * 100) / 100}</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">📐 Equation Solving</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Quadratic: x² - 5x + 6 = 0</h4>
                <p><strong>Coefficients:</strong> a=1, b=-5, c=6</p>`;

// Calculate quadratic solutions for x² - 5x + 6 = 0
let solutions = quadratic(1, -5, 6);
html_content += `<p><strong>Solutions:</strong> x₁=${solutions[0]}, x₂=${solutions[1]}</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Quadratic: 2x² + 3x - 2 = 0</h4>
                <p><strong>Coefficients:</strong> a=2, b=3, c=-2</p>`;

let solutions2 = quadratic(2, 3, -2);
html_content += `<p><strong>Solutions:</strong> x₁=${round(solutions2[0] * 1000) / 1000}, x₂=${round(solutions2[1] * 1000) / 1000}</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">📊 Statistics & Combinatorics</h2>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Factorials</h4>
                <p>5! = ${factorial(5)}</p>
                <p>8! = ${factorial(8)}</p>
                <p>10! = ${factorial(10)}</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Combinations</h4>
                <p>C(10,3) = ${combination(10, 3)}</p>
                <p>C(15,5) = ${combination(15, 5)}</p>
                <p>C(20,2) = ${combination(20, 2)}</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Permutations</h4>
                <p>P(10,3) = ${permutation(10, 3)}</p>
                <p>P(15,5) = ${permutation(15, 5)}</p>
                <p>P(8,4) = ${permutation(8, 4)}</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: #333; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">🌍 Geometry & Physics</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>Circle Calculations</h4>
                <p><strong>Radius:</strong> 7 units</p>
                <p><strong>Area:</strong> ${round(circle_area(7) * 100) / 100} units²</p>
                <p><strong>Circumference:</strong> ${round(circle_circumference(7) * 100) / 100} units</p>
                
                <h4 style="margin-top: 15px;">Distance Formula</h4>
                <p><strong>Point A:</strong> (1, 2)</p>
                <p><strong>Point B:</strong> (4, 6)</p>
                <p><strong>Distance:</strong> ${round(distance(1, 2, 4, 6) * 1000) / 1000} units</p>
            </div>
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>Advanced Trigonometry</h4>
                <p><strong>sin(π/3):</strong> ${round(sin(PI()/3) * 10000) / 10000}</p>
                <p><strong>cos(π/4):</strong> ${round(cos(PI()/4) * 10000) / 10000}</p>
                <p><strong>tan(π/6):</strong> ${round(tan(PI()/6) * 10000) / 10000}</p>
                
                <h4 style="margin-top: 15px;">Hyperbolic Functions</h4>
                <p><strong>sinh(1):</strong> ${round(sinh(1) * 10000) / 10000}</p>
                <p><strong>cosh(0):</strong> ${cosh(0)}</p>
                <p><strong>tanh(2):</strong> ${round(tanh(2) * 10000) / 10000}</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); color: #333; border-radius: 15px; padding: 25px;">
        <h2 style="margin-top: 0; text-align: center;">🧮 Practical Examples</h2>
        <div style="background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <h4>Investment Growth Calculation</h4>
            <p><strong>Scenario:</strong> Investing $5,000 at 7% interest, compounded quarterly for 10 years</p>
            <p><strong>Result:</strong> $${round(compound_interest(5000, 7, 10, 4) * 100) / 100}</p>
            <p><strong>Profit:</strong> $${round((compound_interest(5000, 7, 10, 4) - 5000) * 100) / 100}</p>
            
            <h4 style="margin-top: 20px;">Loan Payment Calculation</h4>
            <p><strong>Scenario:</strong> What percentage is $350 of a $2,800 salary?</p>
            <p><strong>Result:</strong> ${round((350 / 2800) * 100 * 100) / 100}%</p>
            
            <h4 style="margin-top: 20px;">Engineering Calculation</h4>
            <p><strong>Scenario:</strong> Force calculation using F = ma (mass=15kg, acceleration=9.8m/s²)</p>
            <p><strong>Result:</strong> ${15 * 9.8}N (Newtons)</p>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 30px; color: #6c757d;">
        <p><strong>SnapRun Scientific Calculator</strong></p>
        <p>Professional mathematical tools for research, education, and engineering</p>
    </div>
</div>
`;

render_html(html_content);
complete();
