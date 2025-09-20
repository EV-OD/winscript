// @name: Advanced Calculator
// @description: Comprehensive mathematical calculator with scientific functions and expression evaluation

// Advanced Calculator - SnapRun Mathematical Suite
// Supports complex expressions, scientific functions, and mathematical constants

let html_content = `
<div style="font-family: 'Segoe UI', sans-serif; max-width: 800px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #2c3e50; text-align: center; margin-bottom: 30px;">
        🧮 Advanced Mathematical Calculator
    </h1>
    
    <div style="background: #f8f9fa; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #495057; margin-top: 0;">🔢 Basic Operations</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-family: monospace;">
            <div><strong>Addition:</strong> 125 + 376 = ${125 + 376}</div>
            <div><strong>Subtraction:</strong> 1000 - 234 = ${1000 - 234}</div>
            <div><strong>Multiplication:</strong> 15 × 23 = ${15 * 23}</div>
            <div><strong>Division:</strong> 144 ÷ 12 = ${144 / 12}</div>
            <div><strong>Exponentiation:</strong> 2³ = ${pow(2, 3)}</div>
            <div><strong>Square Root:</strong> √64 = ${sqrt(64)}</div>
        </div>
    </div>
    
    <div style="background: #e8f5e8; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #155724; margin-top: 0;">📐 Trigonometric Functions</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-family: monospace;">
            <div><strong>sin(π/2):</strong> ${round(sin(PI()/2) * 1000) / 1000}</div>
            <div><strong>cos(0):</strong> ${cos(0)}</div>
            <div><strong>tan(π/4):</strong> ${round(tan(PI()/4) * 1000) / 1000}</div>
            <div><strong>sin(30°):</strong> ${round(sin(radians(30)) * 1000) / 1000}</div>
            <div><strong>cos(60°):</strong> ${round(cos(radians(60)) * 1000) / 1000}</div>
            <div><strong>tan(45°):</strong> ${round(tan(radians(45)) * 1000) / 1000}</div>
        </div>
    </div>
    
    <div style="background: #fff3cd; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #856404; margin-top: 0;">📊 Logarithmic & Exponential</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-family: monospace;">
            <div><strong>ln(e):</strong> ${round(ln(E()) * 1000) / 1000}</div>
            <div><strong>log₁₀(100):</strong> ${log10(100)}</div>
            <div><strong>log₂(8):</strong> ${log2(8)}</div>
            <div><strong>e²:</strong> ${round(exp(2) * 1000) / 1000}</div>
            <div><strong>2⁵:</strong> ${exp2(5)}</div>
            <div><strong>√27 (cube):</strong> ${round(cbrt(27) * 1000) / 1000}</div>
        </div>
    </div>
    
    <div style="background: #d1ecf1; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #0c5460; margin-top: 0;">🔄 Mathematical Constants</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-family: monospace;">
            <div><strong>π (Pi):</strong> ${round(PI() * 1000000) / 1000000}</div>
            <div><strong>e (Euler):</strong> ${round(E() * 1000000) / 1000000}</div>
            <div><strong>τ (Tau):</strong> ${round(TAU() * 1000000) / 1000000}</div>
            <div><strong>√2:</strong> ${round(SQRT_2() * 1000000) / 1000000}</div>
            <div><strong>ln(2):</strong> ${round(LN_2() * 1000000) / 1000000}</div>
            <div><strong>ln(10):</strong> ${round(LN_10() * 1000000) / 1000000}</div>
        </div>
    </div>
    
    <div style="background: #f8d7da; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3 style="color: #721c24; margin-top: 0;">🎯 Complex Calculations</h3>
        <div style="font-family: monospace; line-height: 1.8;">
            <div><strong>Circle Area (r=5):</strong> ${round(circle_area(5) * 100) / 100} units²</div>
            <div><strong>Distance (0,0) to (3,4):</strong> ${distance(0, 0, 3, 4)} units</div>
            <div><strong>5! (factorial):</strong> ${factorial(5)}</div>
            <div><strong>C(10,3) combinations:</strong> ${combination(10, 3)}</div>
            <div><strong>P(10,3) permutations:</strong> ${permutation(10, 3)}</div>
            <div><strong>15% of 200:</strong> ${percentage(200, 15)}</div>
        </div>
    </div>
    
    <div style="background: #e2e3e5; border-radius: 10px; padding: 20px;">
        <h3 style="color: #383d41; margin-top: 0;">🌡️ Unit Conversions</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-family: monospace;">
            <div><strong>25°C to °F:</strong> ${celsius_to_fahrenheit(25)}°F</div>
            <div><strong>77°F to °C:</strong> ${round(fahrenheit_to_celsius(77) * 10) / 10}°C</div>
            <div><strong>0°C to K:</strong> ${celsius_to_kelvin(0)}K</div>
            <div><strong>300K to °C:</strong> ${kelvin_to_celsius(300)}°C</div>
            <div><strong>45° to radians:</strong> ${round(radians(45) * 1000) / 1000}</div>
            <div><strong>π/3 to degrees:</strong> ${round(degrees(PI()/3) * 10) / 10}°</div>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 30px; color: #6c757d;">
        <p><strong>SnapRun Advanced Calculator</strong></p>
        <p>All mathematical functions available for your scripts!</p>
    </div>
</div>
`;

render_html(html_content);
complete();
