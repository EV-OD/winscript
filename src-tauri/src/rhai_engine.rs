use rhai::{Engine, Scope, EvalAltResult, Array};
use std::path::PathBuf;
use crate::kits::ui_kit::Kit;
use crate::fs_kit::FileSystemKit;
use crate::process_kit::ProcessKit;
use crate::logging::{LogSource, get_logger};
use std::sync::{Arc, Mutex};

/// Rhai script runner that handles script execution and Kit integration
pub struct RhaiScriptRunner {
    engine: Engine,
    current_script_name: Arc<Mutex<String>>,
}

impl RhaiScriptRunner {
    /// Create a new Rhai script runner with Kit integration
    pub fn new(kit: Kit) -> Self {
        let mut engine = Engine::new();
        
        // Basic engine configuration
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        // Wrap Kit in Arc<Mutex<>> for thread safety
        let kit_shared = Arc::new(Mutex::new(kit));
        
        // Register Kit functions with Rhai engine
        Self::register_kit_functions(&mut engine, kit_shared.clone());
        
        // Register file system functions
        FileSystemKit::register_functions(&mut engine);
        
        // Register process execution functions
        ProcessKit::register_functions(&mut engine);
        
        // Register advanced mathematical functions
        Self::register_math_functions(&mut engine);
        
        // Register logging and console functions
        let script_name_shared = Arc::new(Mutex::new("unknown_script".to_string()));
        Self::register_logging_functions(&mut engine, script_name_shared.clone());
        
        println!("🟣 RhaiScriptRunner: Engine initialized with Kit integration, FileSystem, Process execution, and Advanced Mathematics");
        
        Self { 
            engine,
            current_script_name: script_name_shared,
        }
    }
    
    /// Create a basic Rhai runner without Kit integration (for testing)
    pub fn new_basic() -> Self {
        let mut engine = Engine::new();
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        // Register file system functions even in basic mode
        FileSystemKit::register_functions(&mut engine);
        
        // Register process execution functions even in basic mode
        ProcessKit::register_functions(&mut engine);
        
        // Register advanced mathematical functions even in basic mode
        Self::register_math_functions(&mut engine);
        
        // Register logging and console functions
        let script_name_shared = Arc::new(Mutex::new("unknown_script".to_string()));
        Self::register_logging_functions(&mut engine, script_name_shared.clone());
        
        println!("🟣 RhaiScriptRunner: Basic engine initialized with FileSystem, Process execution, and Advanced Mathematics (no Kit)");
        
        Self { 
            engine,
            current_script_name: script_name_shared,
        }
    }
    
    /// Register logging and console functions with the Rhai engine
    fn register_logging_functions(engine: &mut Engine, script_name: Arc<Mutex<String>>) {
        // Register print function that logs to our logging system
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("print", move |message: &str| -> String {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), message, &script_name);
                } else {
                    println!("📜 {}: {}", script_name, message);
                }
                message.to_string() // Return the message
            });
        }

        // Register println function (alias for print with newline)
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("println", move |message: &str| -> String {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), message, &script_name);
                } else {
                    println!("📜 {}: {}", script_name, message);
                }
                message.to_string() // Return the message
            });
        }

        // Register console.log
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("console_log", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), &format!("[console.log] {}", message), &script_name);
                } else {
                    println!("📜 {} [console.log]: {}", script_name, message);
                }
            });
        }

        // Register console.warn
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("console_warn", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.warn_script(LogSource::Rhai(script_name.clone()), &format!("[console.warn] {}", message), &script_name);
                } else {
                    println!("⚠️ 📜 {} [console.warn]: {}", script_name, message);
                }
            });
        }

        // Register console.error
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("console_error", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.error_script(LogSource::Rhai(script_name.clone()), &format!("[console.error] {}", message), &script_name);
                } else {
                    eprintln!("❌ 📜 {} [console.error]: {}", script_name, message);
                }
            });
        }

        // Register console.debug
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("console_debug", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.debug_script(LogSource::Rhai(script_name.clone()), &format!("[console.debug] {}", message), &script_name);
                } else {
                    println!("🔍 📜 {} [console.debug]: {}", script_name, message);
                }
            });
        }

        // Register info function for logging/debugging
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("info", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), message, &script_name);
                } else {
                    println!("ℹ️ 📜 {}: {}", script_name, message);
                }
            });
        }

        // Register log function (alias for print)
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("log", move |message: &str| -> String {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), message, &script_name);
                } else {
                    println!("📜 {}: {}", script_name, message);
                }
                message.to_string() // Return the message
            });
        }

        // Register void versions of print functions (when return value is not used)
        {
            let script_name_clone = script_name.clone();
            engine.register_fn("print_void", move |message: &str| {
                let script_name = script_name_clone.lock().unwrap().clone();
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.clone()), message, &script_name);
                } else {
                    println!("📜 {}: {}", script_name, message);
                }
            });
        }
        
        // Register format function for string formatting
        engine.register_fn("format", |template: &str, value: i64| -> String {
            template.replace("{}", &value.to_string())
        });
        
        engine.register_fn("format", |template: &str, value: f64| -> String {
            template.replace("{}", &value.to_string())
        });
        
        engine.register_fn("format", |template: &str, value: &str| -> String {
            template.replace("{}", value)
        });
        
        engine.register_fn("format", |template: &str, value: bool| -> String {
            template.replace("{}", &value.to_string())
        });
    }

    /// Register advanced mathematical functions with the Rhai engine
    fn register_math_functions(engine: &mut Engine) {
        println!("🟣 RhaiScriptRunner: Registering advanced mathematical functions");
        
        // Basic mathematical functions (some may already be available in Rhai)
        
        // Trigonometric functions - support both int and float
        engine.register_fn("sin", |x: f64| x.sin());
        engine.register_fn("sin", |x: i64| (x as f64).sin());
        engine.register_fn("cos", |x: f64| x.cos());
        engine.register_fn("cos", |x: i64| (x as f64).cos());
        engine.register_fn("tan", |x: f64| x.tan());
        engine.register_fn("tan", |x: i64| (x as f64).tan());
        engine.register_fn("asin", |x: f64| x.asin());
        engine.register_fn("asin", |x: i64| (x as f64).asin());
        engine.register_fn("acos", |x: f64| x.acos());
        engine.register_fn("acos", |x: i64| (x as f64).acos());
        engine.register_fn("atan", |x: f64| x.atan());
        engine.register_fn("atan", |x: i64| (x as f64).atan());
        engine.register_fn("atan2", |y: f64, x: f64| y.atan2(x));
        engine.register_fn("atan2", |y: i64, x: i64| (y as f64).atan2(x as f64));
        engine.register_fn("atan2", |y: f64, x: i64| y.atan2(x as f64));
        engine.register_fn("atan2", |y: i64, x: f64| (y as f64).atan2(x));
        
        // Hyperbolic functions - support both int and float
        engine.register_fn("sinh", |x: f64| x.sinh());
        engine.register_fn("sinh", |x: i64| (x as f64).sinh());
        engine.register_fn("cosh", |x: f64| x.cosh());
        engine.register_fn("cosh", |x: i64| (x as f64).cosh());
        engine.register_fn("tanh", |x: f64| x.tanh());
        engine.register_fn("tanh", |x: i64| (x as f64).tanh());
        
        // Logarithmic and exponential functions - support both int and float
        engine.register_fn("log", |x: f64| x.ln());      // Natural logarithm
        engine.register_fn("log", |x: i64| (x as f64).ln());
        engine.register_fn("ln", |x: f64| x.ln());       // Natural logarithm alias
        engine.register_fn("ln", |x: i64| (x as f64).ln());
        engine.register_fn("log10", |x: f64| x.log10());  // Base 10 logarithm
        engine.register_fn("log10", |x: i64| (x as f64).log10());
        engine.register_fn("log2", |x: f64| x.log2());    // Base 2 logarithm
        engine.register_fn("log2", |x: i64| (x as f64).log2());
        engine.register_fn("exp", |x: f64| x.exp());      // e^x
        engine.register_fn("exp", |x: i64| (x as f64).exp());
        engine.register_fn("exp2", |x: f64| x.exp2());    // 2^x
        engine.register_fn("exp2", |x: i64| (x as f64).exp2());
        
        // Power and root functions - support both int and float
        engine.register_fn("pow", |base: f64, exp: f64| base.powf(exp));
        engine.register_fn("pow", |base: i64, exp: i64| (base as f64).powf(exp as f64));
        engine.register_fn("pow", |base: f64, exp: i64| base.powf(exp as f64));
        engine.register_fn("pow", |base: i64, exp: f64| (base as f64).powf(exp));
        engine.register_fn("sqrt", |x: f64| x.sqrt());
        engine.register_fn("sqrt", |x: i64| (x as f64).sqrt());
        engine.register_fn("cbrt", |x: f64| x.cbrt());    // Cube root
        engine.register_fn("cbrt", |x: i64| (x as f64).cbrt());
        
        // Rounding and comparison functions - support both int and float
        engine.register_fn("abs", |x: f64| x.abs());
        engine.register_fn("abs", |x: i64| x.abs());
        engine.register_fn("floor", |x: f64| x.floor());
        engine.register_fn("floor", |x: i64| (x as f64).floor());
        engine.register_fn("ceil", |x: f64| x.ceil());
        engine.register_fn("ceil", |x: i64| (x as f64).ceil());
        engine.register_fn("round", |x: f64| x.round());
        engine.register_fn("round", |x: i64| (x as f64).round());
        engine.register_fn("trunc", |x: f64| x.trunc());
        engine.register_fn("trunc", |x: i64| (x as f64).trunc());
        engine.register_fn("fract", |x: f64| x.fract());  // Fractional part
        engine.register_fn("fract", |x: i64| (x as f64).fract());
        engine.register_fn("sign", |x: f64| if x > 0.0 { 1.0 } else if x < 0.0 { -1.0 } else { 0.0 });
        engine.register_fn("sign", |x: i64| if x > 0 { 1 } else if x < 0 { -1 } else { 0 });
        
        // Min/Max functions - support both int and float
        engine.register_fn("min", |a: f64, b: f64| a.min(b));
        engine.register_fn("min", |a: i64, b: i64| a.min(b));
        engine.register_fn("min", |a: f64, b: i64| a.min(b as f64));
        engine.register_fn("min", |a: i64, b: f64| (a as f64).min(b));
        engine.register_fn("max", |a: f64, b: f64| a.max(b));
        engine.register_fn("max", |a: i64, b: i64| a.max(b));
        engine.register_fn("max", |a: f64, b: i64| a.max(b as f64));
        engine.register_fn("max", |a: i64, b: f64| (a as f64).max(b));
        
        // Advanced mathematical functions - support both int and float
        engine.register_fn("degrees", |x: f64| x.to_degrees());
        engine.register_fn("degrees", |x: i64| (x as f64).to_degrees());
        engine.register_fn("radians", |x: f64| x.to_radians());
        engine.register_fn("radians", |x: i64| (x as f64).to_radians());
        
        // Mathematical constants as functions (since register_global might not be available)
        engine.register_fn("PI", || std::f64::consts::PI);
        engine.register_fn("E", || std::f64::consts::E);
        engine.register_fn("TAU", || std::f64::consts::TAU);
        engine.register_fn("LN_2", || std::f64::consts::LN_2);
        engine.register_fn("LN_10", || std::f64::consts::LN_10);
        engine.register_fn("LOG2_E", || std::f64::consts::LOG2_E);
        engine.register_fn("LOG10_E", || std::f64::consts::LOG10_E);
        engine.register_fn("SQRT_2", || std::f64::consts::SQRT_2);
        
        // Statistical functions
        engine.register_fn("factorial", |n: i64| -> f64 {
            if n < 0 { return f64::NAN; }
            let mut result = 1f64;
            for i in 2..=n {
                result *= i as f64;
            }
            result
        });
        
        // Combination and permutation
        engine.register_fn("combination", |n: i64, r: i64| -> f64 {
            if r > n || r < 0 || n < 0 { return f64::NAN; }
            let n_fact = (1..=n).fold(1f64, |acc, x| acc * x as f64);
            let r_fact = (1..=r).fold(1f64, |acc, x| acc * x as f64);
            let nr_fact = (1..=(n-r)).fold(1f64, |acc, x| acc * x as f64);
            n_fact / (r_fact * nr_fact)
        });
        
        engine.register_fn("permutation", |n: i64, r: i64| -> f64 {
            if r > n || r < 0 || n < 0 { return f64::NAN; }
            let mut result = 1f64;
            for i in (n-r+1)..=n {
                result *= i as f64;
            }
            result
        });
        
        // Advanced calculator functions
        engine.register_fn("percentage", |value: f64, percent: f64| value * percent / 100.0);
        engine.register_fn("percentage", |value: i64, percent: i64| (value as f64) * (percent as f64) / 100.0);
        engine.register_fn("percentage", |value: f64, percent: i64| value * (percent as f64) / 100.0);
        engine.register_fn("percentage", |value: i64, percent: f64| (value as f64) * percent / 100.0);
        engine.register_fn("compound_interest", |principal: f64, rate: f64, time: f64, n: f64| {
            principal * (1.0 + rate / (100.0 * n)).powf(n * time)
        });
        engine.register_fn("compound_interest", |principal: i64, rate: i64, time: i64, n: i64| {
            let p = principal as f64;
            let r = rate as f64;
            let t = time as f64;
            let n_val = n as f64;
            p * (1.0 + r / (100.0 * n_val)).powf(n_val * t)
        });
        engine.register_fn("compound_interest", |principal: f64, rate: i64, time: i64, n: i64| {
            let r = rate as f64;
            let t = time as f64;
            let n_val = n as f64;
            principal * (1.0 + r / (100.0 * n_val)).powf(n_val * t)
        });
        engine.register_fn("compound_interest", |principal: i64, rate: f64, time: f64, n: f64| {
            (principal as f64) * (1.0 + rate / (100.0 * n)).powf(n * time)
        });
        
        // Quadratic formula solver
        engine.register_fn("quadratic", |a: f64, b: f64, c: f64| -> Array {
            let discriminant = b * b - 4.0 * a * c;
            if discriminant < 0.0 {
                vec![rhai::Dynamic::from("No real solutions")].into()
            } else if discriminant == 0.0 {
                let x = -b / (2.0 * a);
                vec![rhai::Dynamic::from(x)].into()
            } else {
                let sqrt_d = discriminant.sqrt();
                let x1 = (-b + sqrt_d) / (2.0 * a);
                let x2 = (-b - sqrt_d) / (2.0 * a);
                vec![rhai::Dynamic::from(x1), rhai::Dynamic::from(x2)].into()
            }
        });
        engine.register_fn("quadratic", |a: i64, b: i64, c: i64| -> Array {
            let a_f = a as f64;
            let b_f = b as f64;
            let c_f = c as f64;
            let discriminant = b_f * b_f - 4.0 * a_f * c_f;
            if discriminant < 0.0 {
                vec![rhai::Dynamic::from("No real solutions")].into()
            } else if discriminant == 0.0 {
                let x = -b_f / (2.0 * a_f);
                vec![rhai::Dynamic::from(x)].into()
            } else {
                let sqrt_d = discriminant.sqrt();
                let x1 = (-b_f + sqrt_d) / (2.0 * a_f);
                let x2 = (-b_f - sqrt_d) / (2.0 * a_f);
                vec![rhai::Dynamic::from(x1), rhai::Dynamic::from(x2)].into()
            }
        });
        
        // Distance and geometry
        engine.register_fn("distance", |x1: f64, y1: f64, x2: f64, y2: f64| {
            ((x2 - x1).powi(2) + (y2 - y1).powi(2)).sqrt()
        });
        engine.register_fn("distance", |x1: i64, y1: i64, x2: i64, y2: i64| {
            (((x2 - x1) as f64).powi(2) + ((y2 - y1) as f64).powi(2)).sqrt()
        });
        engine.register_fn("distance", |x1: f64, y1: f64, x2: i64, y2: i64| {
            ((x2 as f64 - x1).powi(2) + (y2 as f64 - y1).powi(2)).sqrt()
        });
        engine.register_fn("distance", |x1: i64, y1: i64, x2: f64, y2: f64| {
            ((x2 - x1 as f64).powi(2) + (y2 - y1 as f64).powi(2)).sqrt()
        });
        
        engine.register_fn("circle_area", |radius: f64| std::f64::consts::PI * radius * radius);
        engine.register_fn("circle_area", |radius: i64| std::f64::consts::PI * (radius as f64) * (radius as f64));
        engine.register_fn("circle_circumference", |radius: f64| 2.0 * std::f64::consts::PI * radius);
        engine.register_fn("circle_circumference", |radius: i64| 2.0 * std::f64::consts::PI * (radius as f64));
        
        // Length conversions
        engine.register_fn("meters_to_feet", |m: f64| m * 3.28084);
        engine.register_fn("feet_to_meters", |ft: f64| ft / 3.28084);
        engine.register_fn("meters_to_inches", |m: f64| m * 39.3701);
        engine.register_fn("inches_to_meters", |inches: f64| inches / 39.3701);
        engine.register_fn("kilometers_to_miles", |km: f64| km * 0.621371);
        engine.register_fn("miles_to_kilometers", |miles: f64| miles / 0.621371);
        engine.register_fn("centimeters_to_inches", |cm: f64| cm / 2.54);
        engine.register_fn("inches_to_centimeters", |inches: f64| inches * 2.54);
        
        // Weight conversions
        engine.register_fn("kilograms_to_pounds", |kg: f64| kg * 2.20462);
        engine.register_fn("pounds_to_kilograms", |lbs: f64| lbs / 2.20462);
        engine.register_fn("grams_to_ounces", |g: f64| g / 28.3495);
        engine.register_fn("ounces_to_grams", |oz: f64| oz * 28.3495);
        
        // Volume conversions
        engine.register_fn("liters_to_gallons", |l: f64| l / 3.78541);
        engine.register_fn("gallons_to_liters", |gal: f64| gal * 3.78541);
        engine.register_fn("milliliters_to_fluid_ounces", |ml: f64| ml / 29.5735);
        engine.register_fn("fluid_ounces_to_milliliters", |fl_oz: f64| fl_oz * 29.5735);
        
        // Area conversions
        engine.register_fn("square_meters_to_square_feet", |sq_m: f64| sq_m * 10.7639);
        engine.register_fn("square_feet_to_square_meters", |sq_ft: f64| sq_ft / 10.7639);
        engine.register_fn("hectares_to_acres", |ha: f64| ha * 2.47105);
        engine.register_fn("acres_to_hectares", |acres: f64| acres / 2.47105);
        
        // Speed conversions
        engine.register_fn("kmh_to_mph", |kmh: f64| kmh / 1.60934);
        engine.register_fn("mph_to_kmh", |mph: f64| mph * 1.60934);
        engine.register_fn("ms_to_kmh", |ms: f64| ms * 3.6);
        engine.register_fn("kmh_to_ms", |kmh: f64| kmh / 3.6);
        
        // Energy conversions
        engine.register_fn("joules_to_calories", |j: f64| j / 4.184);
        engine.register_fn("calories_to_joules", |cal: f64| cal * 4.184);
        engine.register_fn("kwh_to_joules", |kwh: f64| kwh * 3600000.0);
        engine.register_fn("joules_to_kwh", |j: f64| j / 3600000.0);
        
        // Pressure conversions
        engine.register_fn("pascal_to_psi", |pa: f64| pa / 6895.0);
        engine.register_fn("psi_to_pascal", |psi: f64| psi * 6895.0);
        engine.register_fn("bar_to_psi", |bar: f64| bar * 14.5038);
        engine.register_fn("psi_to_bar", |psi: f64| psi / 14.5038);
        
        // Temperature conversions
        engine.register_fn("celsius_to_fahrenheit", |c: f64| c * 9.0 / 5.0 + 32.0);
        engine.register_fn("fahrenheit_to_celsius", |f: f64| (f - 32.0) * 5.0 / 9.0);
        engine.register_fn("celsius_to_kelvin", |c: f64| c + 273.15);
        engine.register_fn("kelvin_to_celsius", |k: f64| k - 273.15);
        engine.register_fn("fahrenheit_to_kelvin", |f: f64| (f - 32.0) * 5.0 / 9.0 + 273.15);
        engine.register_fn("kelvin_to_fahrenheit", |k: f64| (k - 273.15) * 9.0 / 5.0 + 32.0);
        
        // Integer overloads for all conversion functions
        // Length conversions - integer overloads
        engine.register_fn("meters_to_feet", |m: i64| (m as f64) * 3.28084);
        engine.register_fn("feet_to_meters", |ft: i64| (ft as f64) / 3.28084);
        engine.register_fn("meters_to_inches", |m: i64| (m as f64) * 39.3701);
        engine.register_fn("inches_to_meters", |inches: i64| (inches as f64) / 39.3701);
        engine.register_fn("kilometers_to_miles", |km: i64| (km as f64) * 0.621371);
        engine.register_fn("miles_to_kilometers", |miles: i64| (miles as f64) / 0.621371);
        engine.register_fn("centimeters_to_inches", |cm: i64| (cm as f64) / 2.54);
        engine.register_fn("inches_to_centimeters", |inches: i64| (inches as f64) * 2.54);
        
        // Weight conversions - integer overloads
        engine.register_fn("kilograms_to_pounds", |kg: i64| (kg as f64) * 2.20462);
        engine.register_fn("pounds_to_kilograms", |lbs: i64| (lbs as f64) / 2.20462);
        engine.register_fn("grams_to_ounces", |g: i64| (g as f64) / 28.3495);
        engine.register_fn("ounces_to_grams", |oz: i64| (oz as f64) * 28.3495);
        
        // Volume conversions - integer overloads
        engine.register_fn("liters_to_gallons", |l: i64| (l as f64) / 3.78541);
        engine.register_fn("gallons_to_liters", |gal: i64| (gal as f64) * 3.78541);
        engine.register_fn("milliliters_to_fluid_ounces", |ml: i64| (ml as f64) / 29.5735);
        engine.register_fn("fluid_ounces_to_milliliters", |fl_oz: i64| (fl_oz as f64) * 29.5735);
        
        // Area conversions - integer overloads
        engine.register_fn("square_meters_to_square_feet", |sq_m: i64| (sq_m as f64) * 10.7639);
        engine.register_fn("square_feet_to_square_meters", |sq_ft: i64| (sq_ft as f64) / 10.7639);
        engine.register_fn("hectares_to_acres", |ha: i64| (ha as f64) * 2.47105);
        engine.register_fn("acres_to_hectares", |acres: i64| (acres as f64) / 2.47105);
        
        // Speed conversions - integer overloads
        engine.register_fn("kmh_to_mph", |kmh: i64| (kmh as f64) / 1.60934);
        engine.register_fn("mph_to_kmh", |mph: i64| (mph as f64) * 1.60934);
        engine.register_fn("ms_to_kmh", |ms: i64| (ms as f64) * 3.6);
        engine.register_fn("kmh_to_ms", |kmh: i64| (kmh as f64) / 3.6);
        
        // Energy conversions - integer overloads
        engine.register_fn("joules_to_calories", |j: i64| (j as f64) / 4.184);
        engine.register_fn("calories_to_joules", |cal: i64| (cal as f64) * 4.184);
        engine.register_fn("kwh_to_joules", |kwh: i64| (kwh as f64) * 3600000.0);
        engine.register_fn("joules_to_kwh", |j: i64| (j as f64) / 3600000.0);
        
        // Pressure conversions - integer overloads
        engine.register_fn("pascal_to_psi", |pa: i64| (pa as f64) / 6895.0);
        engine.register_fn("psi_to_pascal", |psi: i64| (psi as f64) * 6895.0);
        engine.register_fn("bar_to_psi", |bar: i64| (bar as f64) * 14.5038);
        engine.register_fn("psi_to_bar", |psi: i64| (psi as f64) / 14.5038);
        
        // Temperature conversions - integer overloads
        engine.register_fn("celsius_to_fahrenheit", |c: i64| (c as f64) * 9.0 / 5.0 + 32.0);
        engine.register_fn("fahrenheit_to_celsius", |f: i64| ((f as f64) - 32.0) * 5.0 / 9.0);
        engine.register_fn("celsius_to_kelvin", |c: i64| (c as f64) + 273.15);
        engine.register_fn("kelvin_to_celsius", |k: i64| (k as f64) - 273.15);
        engine.register_fn("fahrenheit_to_kelvin", |f: i64| ((f as f64) - 32.0) * 5.0 / 9.0 + 273.15);
        engine.register_fn("kelvin_to_fahrenheit", |k: i64| ((k as f64) - 273.15) * 9.0 / 5.0 + 32.0);
        
        println!("🟣 RhaiScriptRunner: Advanced mathematical functions registered successfully");
    }
    
    /// Register Kit functions with the Rhai engine
    fn register_kit_functions(engine: &mut Engine, kit: Arc<Mutex<Kit>>) {
        println!("🟣 RhaiScriptRunner: Registering Kit functions");
        
        // Register ask_input function
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_input", move |message: &str| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.ask_input_sync(message)
            });
        }
        
        // Register ask_select function - handle Rhai array conversion
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_select", move |message: &str, options: Array| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                
                // Convert Rhai Array to Vec<String>
                let string_options: Vec<String> = options
                    .iter()
                    .filter_map(|item| item.clone().try_cast::<String>())
                    .collect();
                    
                kit_guard.ask_select_sync(message, string_options)
            });
        }
        
        // Register ask_number function
        {
            let kit_clone = kit.clone();
            engine.register_fn("ask_number", move |message: &str| -> f64 {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.ask_number_sync(message)
            });
        }
        
        // Register render_html function
        {
            let kit_clone = kit.clone();
            engine.register_fn("render_html", move |html_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_html_sync(html_content)
            });
        }

        // Register render_html function with title parameter
        {
            let kit_clone = kit.clone();
            engine.register_fn("render_html", move |title: &str, html_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                // Use the Kit's render_html method directly with title
                match kit_guard.render_html(title, html_content) {
                    Ok(_) => true,
                    Err(e) => {
                        eprintln!("Error in render_html: {}", e);
                        false
                    }
                }
            });
        }

        // Register render_markdown function
        {
            let kit_clone = kit.clone();
            engine.register_fn("render_markdown", move |markdown_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_markdown_sync(markdown_content)
            });
        }

        // Register md function as a short alias for render_markdown
        {
            let kit_clone = kit.clone();
            engine.register_fn("md", move |markdown_content: &str| -> bool {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.render_markdown_sync(markdown_content)
            });
        }
        
        // Register show_message function
        {
            let kit_clone = kit.clone();
            engine.register_fn("show_message", move |title: &str, message: &str| -> bool {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.show_message_sync(title, message)
            });
        }
        
        // Register confirm function
        {
            let kit_clone = kit.clone();
            engine.register_fn("confirm", move |message: &str| -> bool {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.confirm_sync(message)
            });
        }
        
        // Register complete function
        {
            let kit_clone = kit.clone();
            engine.register_fn("complete", move || -> () {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.complete_sync()
            });
        }
        
        // Register reset_awaiting function  
        {
            let kit_clone = kit.clone();
            engine.register_fn("reset_awaiting", move || {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.reset_awaiting_sync();
            });
        }
        
        // =============================================================================
        // EXIT/APP CONTROL FUNCTIONS
        // =============================================================================
        
        // Register exit_and_hide function
        {
            let kit_clone = kit.clone();
            engine.register_fn("exit_and_hide", move || -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.exit_and_hide_sync()
            });
        }
        
        // =============================================================================
        // MONACO EDITOR FUNCTIONS
        // =============================================================================
        
        // Register editor function
        {
            let kit_clone = kit.clone();
            engine.register_fn("editor", move |file_path: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.editor_sync(Some(file_path))
            });
        }
        
        // Register editor function without file path (new file)
        {
            let kit_clone = kit.clone();
            engine.register_fn("editor", move || -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.editor_sync(None)
            });
        }
        
        // Register save_file function
        {
            let kit_clone = kit.clone();
            engine.register_fn("save_file", move |file_path: &str, content: &str| -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.save_file_sync(file_path, content)
            });
        }
        
        // Register create_temp_file function
        {
            let kit_clone = kit.clone();
            engine.register_fn("create_temp_file", move |extension: String| -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.create_temp_file_sync(Some(extension))
            });
        }
        
        // Register create_temp_file function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("create_temp_file", move || -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.create_temp_file_sync(None)
            });
        }
        
        // Register create_temp_file_with_content function  
        {
            let kit_clone = kit.clone();
            engine.register_fn("create_temp_file_with_content", move |content: &str, extension: String| -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.create_temp_file_with_content_sync(content, Some(extension))
            });
        }
        
        // Register create_temp_file_with_content function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("create_temp_file_with_content", move |content: &str| -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.create_temp_file_with_content_sync(content, None)
            });
        }
        
        // Register open_temp_file function
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file", move |extension: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_sync(Some(extension))
            });
        }
        
        // Register open_temp_file function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file", move || -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_sync(None)
            });
        }
        
        // Register open_temp_file_with_content function
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_with_content", move |content: &str, extension: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_with_content_sync(content, Some(extension))
            });
        }
        
        // Register open_temp_file_with_content function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_with_content", move |content: &str| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_with_content_sync(content, None)
            });
        }
        
        // =============================================================================
        // PERSISTENT MONACO EDITOR FUNCTIONS (NO RETURN VALUE, EDITOR STAYS OPEN)
        // =============================================================================
        
        // Register editor_persistent function
        {
            let kit_clone = kit.clone();
            engine.register_fn("editor_persistent", move |file_path: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.editor_persistent_sync(Some(file_path))
            });
        }
        
        // Register editor_persistent function without file path (new file)
        {
            let kit_clone = kit.clone();
            engine.register_fn("editor_persistent", move || -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.editor_persistent_sync(None)
            });
        }
        
        // Register open_temp_file_persistent function
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_persistent", move |extension: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_persistent_sync(Some(extension))
            });
        }
        
        // Register open_temp_file_persistent function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_persistent", move || -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_persistent_sync(None)
            });
        }
        
        // Register open_temp_file_with_content_persistent function
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_with_content_persistent", move |content: &str, extension: String| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_with_content_persistent_sync(content, Some(extension))
            });
        }
        
        // Register open_temp_file_with_content_persistent function without extension
        {
            let kit_clone = kit.clone();
            engine.register_fn("open_temp_file_with_content_persistent", move |content: &str| -> String {
                let mut kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.open_temp_file_with_content_persistent_sync(content, None)
            });
        }

        // Register JSON functions
        {
            let kit_clone = kit.clone();
            engine.register_fn("parse_json", move |json_str: &str| -> rhai::Dynamic {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                match kit_guard.parse_json(json_str) {
                    Ok(data) => data,
                    Err(e) => {
                        eprintln!("JSON parse error: {}", e);
                        rhai::Dynamic::UNIT
                    }
                }
            });
        }

        {
            let kit_clone = kit.clone();
            engine.register_fn("to_json", move |data: rhai::Dynamic| -> String {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                match kit_guard.to_json(data) {
                    Ok(json_str) => json_str,
                    Err(e) => {
                        eprintln!("JSON serialization error: {}", e);
                        "{}".to_string()
                    }
                }
            });
        }

        // Register timestamp function
        {
            let kit_clone = kit.clone();
            engine.register_fn("timestamp", move || -> i64 {
                let kit_guard = kit_clone.lock().expect("Failed to lock Kit");
                kit_guard.timestamp()
            });
        }
        
        println!("🟣 RhaiScriptRunner: All Kit functions registered");
    }
    
    /// Execute a Rhai script from string content
    pub fn run_script(&self, script_content: &str) -> Result<(), Box<EvalAltResult>> {
        self.run_script_with_name(script_content, "unknown_script")
    }

    /// Execute a Rhai script with logging context
    pub fn run_script_with_name(&self, script_content: &str, script_name: &str) -> Result<(), Box<EvalAltResult>> {
        // Set the current script name for logging functions
        {
            let mut current_name = self.current_script_name.lock().unwrap();
            *current_name = script_name.to_string();
        }
        
        let mut scope = Scope::new();
        
        // Log script start
        if let Some(logger) = get_logger() {
            logger.info_script(LogSource::Rhai(script_name.to_string()), "Starting script execution", script_name);
        } else {
            println!("🟣 RhaiScriptRunner: Executing script: {}", script_name);
        }

        // Execute the script
        match self.engine.eval_with_scope::<()>(&mut scope, script_content) {
            Ok(_) => {
                if let Some(logger) = get_logger() {
                    logger.info_script(LogSource::Rhai(script_name.to_string()), "Script execution completed successfully", script_name);
                } else {
                    println!("🟣 RhaiScriptRunner: Script execution completed: {}", script_name);
                }
                Ok(())
            },
            Err(e) => {
                // Enhanced error logging with more details
                let error_msg = format!("Script execution failed: {} | Error details: line {}, position {}", 
                    e, 
                    e.position().line().unwrap_or(0), 
                    e.position().position().unwrap_or(0)
                );
                
                if let Some(logger) = get_logger() {
                    logger.error_script(LogSource::Rhai(script_name.to_string()), &error_msg, script_name);
                } else {
                    eprintln!("❌ RhaiScriptRunner: {}: {}", script_name, error_msg);
                }
                Err(e)
            }
        }
    }
    
    /// Load and execute a script from file
    pub fn run_script_file(&self, file_path: PathBuf) -> Result<(), String> {
        let script_name = file_path.file_stem()
            .and_then(|s| s.to_str())
            .unwrap_or("unknown_script");
            
        let script_content = std::fs::read_to_string(&file_path)
            .map_err(|e| format!("Failed to read script file: {}", e))?;
            
        self.run_script_with_name(&script_content, script_name)
            .map_err(|e| format!("Script execution error: {}", e))
    }
    
    /// Test all built-in scripts for function availability and basic syntax
    pub fn test_all_scripts(&self) -> Vec<(String, Result<(), String>)> {
        let mut results = Vec::new();
        
        // Define scripts to test (relative to user_scripts/built_in_scripts/)
        let test_scripts = vec![
            "welcome.rhai",
            "eval.rhai", 
            "showlog.rhai",
            "create-script.rhai",
            "addTodo.rhai",
            "showTodo.rhai",
            "removeTodo.rhai"
        ];
        
        for script_name in test_scripts {
            let script_path = PathBuf::from("user_scripts/built_in_scripts").join(script_name);
            
            // Check if file exists
            if !script_path.exists() {
                results.push((script_name.to_string(), Err("Script file not found".to_string())));
                continue;
            }
            
            // Read script content
            let script_content = match std::fs::read_to_string(&script_path) {
                Ok(content) => content,
                Err(e) => {
                    results.push((script_name.to_string(), Err(format!("Failed to read file: {}", e))));
                    continue;
                }
            };
            
            // Test script compilation and basic function availability
            let test_result = self.test_script_functions(&script_content, script_name);
            results.push((script_name.to_string(), test_result));
        }
        
        results
    }
    
    /// Test a single script for function availability without executing interactive parts
    fn test_script_functions(&self, script_content: &str, script_name: &str) -> Result<(), String> {
        // Create a test scope
        let mut scope = Scope::new();
        
        // First, try to compile the script to check syntax
        match self.engine.compile(script_content) {
            Ok(_) => {
                println!("✅ {}: Compilation successful", script_name);
            }
            Err(e) => {
                return Err(format!("Compilation failed: {} at line {}, position {}", 
                    e, 
                    e.position().line().unwrap_or(0),
                    e.position().position().unwrap_or(0)
                ));
            }
        }
        
        // Test individual functions by creating a minimal test script
        let test_functions = vec![
            "info", "render_html", "ask_input", "ask_select", 
            "read_file", "write_file", "file_exists", "create_directory",
            "get_home_dir", "parse_json", "to_json", "timestamp",
            "editor", "exit_and_hide"
        ];
        
        for func_name in test_functions {
            let test_script = match func_name {
                "info" => "info(\"test\");",
                "render_html" => "render_html(\"Test\", \"<div>Test</div>\");", 
                "ask_input" => "// ask_input(\"test\");", // Comment out interactive functions
                "ask_select" => "// ask_select(\"test\", [\"option1\"]);", // Comment out interactive functions
                "read_file" => "// read_file(\"test.txt\");", // Comment out file operations that might fail
                "write_file" => "// write_file(\"test.txt\", \"content\");", // Comment out file operations
                "file_exists" => "file_exists(\"test.txt\");",
                "create_directory" => "// create_directory(\"test_dir\");", // Comment out directory creation
                "get_home_dir" => "get_home_dir();",
                "parse_json" => "parse_json(\"{}\");",
                "to_json" => "to_json(#{});",
                "timestamp" => "timestamp();",
                "editor" => "// editor(\"test.txt\", \"content\");", // Comment out editor calls
                "exit_and_hide" => "// exit_and_hide();", // Comment out exit calls
                _ => continue,
            };
            
            // Skip commented functions (they're interactive or potentially disruptive)
            if test_script.starts_with("//") {
                continue;
            }
            
            match self.engine.eval_with_scope::<()>(&mut scope, test_script) {
                Ok(_) => {
                    println!("✅ {}: Function '{}' available", script_name, func_name);
                }
                Err(e) => {
                    if e.to_string().contains("Function not found") {
                        return Err(format!("Missing function: {}", func_name));
                    }
                    // Other errors might be OK (like file not found, etc.)
                    println!("⚠️ {}: Function '{}' exists but test failed: {}", script_name, func_name, e);
                }
            }
        }
        
        Ok(())
    }
    
    /// Print a comprehensive test report
    pub fn print_test_report(&self) {
        println!("\n🧪 SnapRun Script Test Report");
        println!("================================");
        
        let results = self.test_all_scripts();
        let mut passed = 0;
        let mut failed = 0;
        
        for (script_name, result) in results {
            match result {
                Ok(_) => {
                    println!("✅ {} - PASSED", script_name);
                    passed += 1;
                }
                Err(error) => {
                    println!("❌ {} - FAILED: {}", script_name, error);
                    failed += 1;
                }
            }
        }
        
        println!("\n📊 Test Summary:");
        println!("   Passed: {}", passed);
        println!("   Failed: {}", failed);
        println!("   Total:  {}", passed + failed);
        
        if failed == 0 {
            println!("🎉 All tests passed!");
        } else {
            println!("⚠️ {} test(s) failed. Check the errors above.", failed);
        }
        println!("================================\n");
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_basic_rhai_execution() {
        // Create a basic engine without Kit for testing
        let mut engine = Engine::new();
        engine.set_optimization_level(rhai::OptimizationLevel::Simple);
        
        let script = r#"
            let x = 1 + 2;
            print("Hello from Rhai! x = " + x);
        "#;
        
        let mut scope = Scope::new();
        assert!(engine.eval_with_scope::<()>(&mut scope, script).is_ok());
    }
}
