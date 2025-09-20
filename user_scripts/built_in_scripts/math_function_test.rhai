// @name: Math Function Test
// @description: Test integer and float math functions

// Test basic integer and float operations
let html_content = `
<div style="font-family: 'Segoe UI', sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #2c3e50; text-align: center;">🧪 Math Function Test</h1>
    
    <div style="background: #f8f9fa; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3>🔢 Integer Operations Test</h3>
        <div style="font-family: monospace;">
            <p><strong>pow(2, 3):</strong> ${pow(2, 3)}</p>
            <p><strong>pow(5, 2):</strong> ${pow(5, 2)}</p>
            <p><strong>sqrt(16):</strong> ${sqrt(16)}</p>
            <p><strong>sqrt(25):</strong> ${sqrt(25)}</p>
            <p><strong>abs(-10):</strong> ${abs(-10)}</p>
            <p><strong>max(5, 8):</strong> ${max(5, 8)}</p>
            <p><strong>min(3, 7):</strong> ${min(3, 7)}</p>
            <p><strong>radians(30):</strong> ${round(radians(30) * 10000) / 10000}</p>
            <p><strong>degrees(1):</strong> ${round(degrees(1) * 100) / 100}</p>
            <p><strong>sin(0):</strong> ${sin(0)}</p>
            <p><strong>cos(0):</strong> ${cos(0)}</p>
        </div>
    </div>
    
    <div style="background: #e8f5e8; border-radius: 10px; padding: 20px; margin-bottom: 20px;">
        <h3>🔢 Float Operations Test</h3>
        <div style="font-family: monospace;">
            <p><strong>pow(2.5, 2.0):</strong> ${pow(2.5, 2.0)}</p>
            <p><strong>sqrt(9.0):</strong> ${sqrt(9.0)}</p>
            <p><strong>sin(0):</strong> ${sin(0)}</p>
            <p><strong>cos(0):</strong> ${cos(0)}</p>
            <p><strong>ln(1):</strong> ${ln(1)}</p>
        </div>
    </div>
    
    <div style="background: #fff3cd; border-radius: 10px; padding: 20px;">
        <h3>🎯 Mixed Operations Test</h3>
        <div style="font-family: monospace;">
            <p><strong>pow(2, 3.5):</strong> ${pow(2, 3.5)}</p>
            <p><strong>pow(2.0, 3):</strong> ${pow(2.0, 3)}</p>
            <p><strong>max(5, 8.5):</strong> ${max(5, 8.5)}</p>
            <p><strong>max(5.2, 8):</strong> ${max(5.2, 8)}</p>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 20px; color: #6c757d;">
        <p><strong>✅ If you see this, integer math functions are working!</strong></p>
    </div>
</div>
`;

render_html(html_content);
complete();
