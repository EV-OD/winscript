// @name: Unit Converter Suite
// @description: Comprehensive unit conversion calculator for length, weight, temperature, volume, and more

// Unit Converter Suite - SnapRun Mathematical Tools
// Convert between different units of measurement with precision

let html_content = `
<div style="font-family: 'Segoe UI', sans-serif; max-width: 1000px; margin: 0 auto; padding: 20px;">
    <h1 style="color: #2c3e50; text-align: center; margin-bottom: 30px;">
        🔄 Universal Unit Converter
    </h1>
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">📏 Length & Distance</h2>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Metric ↔ Imperial</h4>
                <p><strong>1 meter</strong> = ${round(meters_to_feet(1) * 100) / 100} feet</p>
                <p><strong>1 foot</strong> = ${round(feet_to_meters(1) * 1000) / 1000} meters</p>
                <p><strong>5 meters</strong> = ${round(meters_to_inches(5) * 100) / 100} inches</p>
                <p><strong>12 inches</strong> = ${round(inches_to_meters(12) * 1000) / 1000} meters</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Distance Conversions</h4>
                <p><strong>10 km</strong> = ${round(kilometers_to_miles(10) * 100) / 100} miles</p>
                <p><strong>5 miles</strong> = ${round(miles_to_kilometers(5) * 100) / 100} km</p>
                <p><strong>100 km</strong> = ${round(kilometers_to_miles(100) * 100) / 100} miles</p>
                <p><strong>26.2 miles</strong> = ${round(miles_to_kilometers(26.2) * 100) / 100} km</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Small Measurements</h4>
                <p><strong>10 cm</strong> = ${round(centimeters_to_inches(10) * 100) / 100} inches</p>
                <p><strong>6 inches</strong> = ${round(inches_to_centimeters(6) * 100) / 100} cm</p>
                <p><strong>2.54 cm</strong> = ${round(centimeters_to_inches(2.54) * 100) / 100} inch</p>
                <p><strong>1 inch</strong> = ${inches_to_centimeters(1)} cm</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">⚖️ Weight & Mass</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Heavy Measurements</h4>
                <p><strong>1 kg</strong> = ${round(kilograms_to_pounds(1) * 100) / 100} pounds</p>
                <p><strong>10 lbs</strong> = ${round(pounds_to_kilograms(10) * 100) / 100} kg</p>
                <p><strong>70 kg</strong> = ${round(kilograms_to_pounds(70) * 100) / 100} lbs</p>
                <p><strong>150 lbs</strong> = ${round(pounds_to_kilograms(150) * 100) / 100} kg</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Light Measurements</h4>
                <p><strong>100 grams</strong> = ${round(grams_to_ounces(100) * 100) / 100} ounces</p>
                <p><strong>8 ounces</strong> = ${round(ounces_to_grams(8) * 100) / 100} grams</p>
                <p><strong>500 grams</strong> = ${round(grams_to_ounces(500) * 100) / 100} ounces</p>
                <p><strong>16 ounces</strong> = ${round(ounces_to_grams(16) * 100) / 100} grams</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); color: white; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">🌡️ Temperature</h2>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Common Temperatures</h4>
                <p><strong>0°C</strong> = ${celsius_to_fahrenheit(0)}°F</p>
                <p><strong>100°C</strong> = ${celsius_to_fahrenheit(100)}°F</p>
                <p><strong>25°C</strong> = ${round(celsius_to_fahrenheit(25) * 10) / 10}°F</p>
                <p><strong>37°C</strong> = ${round(celsius_to_fahrenheit(37) * 10) / 10}°F</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Fahrenheit to Celsius</h4>
                <p><strong>32°F</strong> = ${fahrenheit_to_celsius(32)}°C</p>
                <p><strong>212°F</strong> = ${fahrenheit_to_celsius(212)}°C</p>
                <p><strong>70°F</strong> = ${round(fahrenheit_to_celsius(70) * 10) / 10}°C</p>
                <p><strong>98.6°F</strong> = ${round(fahrenheit_to_celsius(98.6) * 10) / 10}°C</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px; text-align: center;">
                <h4>Kelvin Scale</h4>
                <p><strong>0°C</strong> = ${celsius_to_kelvin(0)}K</p>
                <p><strong>-273.15°C</strong> = ${celsius_to_kelvin(-273.15)}K</p>
                <p><strong>300K</strong> = ${round(kelvin_to_celsius(300) * 10) / 10}°C</p>
                <p><strong>273K</strong> = ${kelvin_to_celsius(273)}°C</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); color: #333; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">🥤 Volume & Capacity</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>Large Volume</h4>
                <p><strong>1 liter</strong> = ${round(liters_to_gallons(1) * 1000) / 1000} gallons</p>
                <p><strong>5 gallons</strong> = ${round(gallons_to_liters(5) * 100) / 100} liters</p>
                <p><strong>10 liters</strong> = ${round(liters_to_gallons(10) * 100) / 100} gallons</p>
                <p><strong>20 gallons</strong> = ${round(gallons_to_liters(20) * 100) / 100} liters</p>
            </div>
            <div style="background: rgba(255,255,255,0.3); padding: 15px; border-radius: 10px;">
                <h4>Small Volume</h4>
                <p><strong>250 ml</strong> = ${round(milliliters_to_fluid_ounces(250) * 100) / 100} fl oz</p>
                <p><strong>8 fl oz</strong> = ${round(fluid_ounces_to_milliliters(8) * 100) / 100} ml</p>
                <p><strong>500 ml</strong> = ${round(milliliters_to_fluid_ounces(500) * 100) / 100} fl oz</p>
                <p><strong>16 fl oz</strong> = ${round(fluid_ounces_to_milliliters(16) * 100) / 100} ml</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); color: #333; border-radius: 15px; padding: 25px; margin-bottom: 25px;">
        <h2 style="margin-top: 0; text-align: center;">📐 Area & Speed</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.5); padding: 15px; border-radius: 10px;">
                <h4>Area Conversions</h4>
                <p><strong>1 sq meter</strong> = ${round(square_meters_to_square_feet(1) * 100) / 100} sq ft</p>
                <p><strong>100 sq ft</strong> = ${round(square_feet_to_square_meters(100) * 100) / 100} sq m</p>
                <p><strong>1 hectare</strong> = ${round(hectares_to_acres(1) * 100) / 100} acres</p>
                <p><strong>5 acres</strong> = ${round(acres_to_hectares(5) * 100) / 100} hectares</p>
            </div>
            <div style="background: rgba(255,255,255,0.5); padding: 15px; border-radius: 10px;">
                <h4>Speed Conversions</h4>
                <p><strong>60 km/h</strong> = ${round(kmh_to_mph(60) * 100) / 100} mph</p>
                <p><strong>65 mph</strong> = ${round(mph_to_kmh(65) * 100) / 100} km/h</p>
                <p><strong>25 m/s</strong> = ${round(ms_to_kmh(25) * 100) / 100} km/h</p>
                <p><strong>120 km/h</strong> = ${round(kmh_to_ms(120) * 100) / 100} m/s</p>
            </div>
        </div>
    </div>
    
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 15px; padding: 25px;">
        <h2 style="margin-top: 0; text-align: center;">⚡ Energy & Pressure</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Energy Conversions</h4>
                <p><strong>1000 joules</strong> = ${round(joules_to_calories(1000) * 100) / 100} calories</p>
                <p><strong>500 calories</strong> = ${round(calories_to_joules(500) * 100) / 100} joules</p>
                <p><strong>1 kWh</strong> = ${kwh_to_joules(1)} joules</p>
                <p><strong>3,600,000 J</strong> = ${joules_to_kwh(3600000)} kWh</p>
            </div>
            <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 10px;">
                <h4>Pressure Conversions</h4>
                <p><strong>100,000 Pa</strong> = ${round(pascal_to_psi(100000) * 100) / 100} PSI</p>
                <p><strong>14.7 PSI</strong> = ${round(psi_to_pascal(14.7) * 100) / 100} Pa</p>
                <p><strong>2 bar</strong> = ${round(bar_to_psi(2) * 100) / 100} PSI</p>
                <p><strong>30 PSI</strong> = ${round(psi_to_bar(30) * 100) / 100} bar</p>
            </div>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 30px; color: #6c757d;">
        <p><strong>SnapRun Universal Unit Converter</strong></p>
        <p>Precise conversions for engineering, cooking, travel, and everyday use</p>
        <p style="font-size: 0.9em; margin-top: 15px;">
            <strong>Available Functions:</strong> Length • Weight • Temperature • Volume • Area • Speed • Energy • Pressure
        </p>
    </div>
</div>
`;

render_html(html_content);
complete();
