---
title: "Math Operations"
description: "Mathematical functions and arithmetic operations for numerical computations"
---

# Math Functions

Mathematical operations and functions available in SnapRun for numerical computations.

## Basic Arithmetic

### Operators

| Operator | Description | Example | Result |
|----------|-------------|---------|---------|
| `+` | Addition / String concatenation | `5 + 3` | `8` |
| `-` | Subtraction / Unary minus | `10 - 4` | `6` |
| `*` | Multiplication / String repeat | `6 * 7` | `42` |
| `/` | Division | `15 / 3` | `5` |
| `%` | Modulo (remainder) | `17 % 5` | `2` |
| `**` | Exponentiation | `2 ** 3` | `8` |

## Mathematical Functions

### Basic Functions

| Function | Description | Return Type |
|----------|-------------|-------------|
| `abs(n)` | Absolute value | `int/float` |
| `pow(base, exp)` | base raised to power exp | `float` |
| `sqrt(n)` | Square root | `float` |
| `cbrt(n)` | Cube root | `float` |
| `floor(n)` | Round down to integer | `float` |
| `ceil(n)` | Round up to integer | `float` |
| `round(n)` | Round to nearest integer | `float` |
| `trunc(n)` | Truncate decimal part | `float` |
| `fract(n)` | Fractional part only | `float` |
| `sign(n)` | Sign of number (-1, 0, 1) | `int/float` |

### Min/Max Functions

| Function | Description | Return Type |
|----------|-------------|-------------|
| `min(a, b)` | Minimum of two values | `int/float` |
| `max(a, b)` | Maximum of two values | `int/float` |

### Trigonometric Functions

| Function | Description | Return Type |
|----------|-------------|-------------|
| `sin(x)` | Sine (radians) | `float` |
| `cos(x)` | Cosine (radians) | `float` |
| `tan(x)` | Tangent (radians) | `float` |
| `asin(x)` | Arc sine | `float` |
| `acos(x)` | Arc cosine | `float` |
| `atan(x)` | Arc tangent | `float` |
| `atan2(y, x)` | Arc tangent of y/x | `float` |

### Hyperbolic Functions

| Function | Description | Return Type |
|----------|-------------|-------------|
| `sinh(x)` | Hyperbolic sine | `float` |
| `cosh(x)` | Hyperbolic cosine | `float` |
| `tanh(x)` | Hyperbolic tangent | `float` |

### Logarithmic & Exponential

| Function | Description | Return Type |
|----------|-------------|-------------|
| `ln(x)` / `log(x)` | Natural logarithm | `float` |
| `log10(x)` | Base 10 logarithm | `float` |
| `log2(x)` | Base 2 logarithm | `float` |
| `exp(x)` | e^x | `float` |
| `exp2(x)` | 2^x | `float` |

### Angle Conversion

| Function | Description | Return Type |
|----------|-------------|-------------|
| `degrees(x)` | Radians to degrees | `float` |
| `radians(x)` | Degrees to radians | `float` |

### Mathematical Constants

| Function | Description | Value |
|----------|-------------|-------|
| `PI()` | Pi constant | 3.14159... |
| `E()` | Euler's number | 2.71828... |
| `TAU()` | 2 * Pi | 6.28318... |
| `LN_2()` | Natural log of 2 | 0.69314... |
| `LN_10()` | Natural log of 10 | 2.30258... |
| `LOG2_E()` | Log base 2 of e | 1.44269... |
| `LOG10_E()` | Log base 10 of e | 0.43429... |
| `SQRT_2()` | Square root of 2 | 1.41421... |

### Advanced Functions

| Function | Description | Return Type |
|----------|-------------|-------------|
| `factorial(n)` | n! (factorial) | `float` |

## Special Considerations

- Integer division returns float if not evenly divisible
- Modulo works with both integers and floats
- Math functions handle type conversion automatically
- Division by zero throws runtime error
- Square root of negative numbers may cause errors

## Example

```rust
// Basic calculations
let radius = 5.0;
let area = PI() * pow(radius, 2);

// Pythagorean theorem
let a = 3.0;
let b = 4.0;
let hypotenuse = sqrt(pow(a, 2) + pow(b, 2));

// Trigonometry (convert degrees to radians)
let angle_deg = 45.0;
let angle_rad = radians(angle_deg);
let sin_result = sin(angle_rad);

// Logarithms and exponentials
let x = 10.0;
let ln_result = ln(x);
let log10_result = log10(x);
let exp_result = exp(2.0);

// Statistical calculations
let values = [1.5, 2.3, 4.7, 3.1, 2.9];
let sum = values[0] + values[1] + values[2] + values[3] + values[4];
let average = sum / 5.0;

// Rounding operations
let pi = PI();

// Display results in UI
let results_html = "<h3>📊 Mathematical Calculations</h3>" +
    "<p><strong>Circle Area (r=5):</strong> " + area + "</p>" +
    "<p><strong>Hypotenuse (3,4):</strong> " + hypotenuse + "</p>" +
    "<p><strong>sin(45°):</strong> " + sin_result + "</p>" +
    "<p><strong>ln(10):</strong> " + ln_result + "</p>" +
    "<p><strong>log₁₀(10):</strong> " + log10_result + "</p>" +
    "<p><strong>e²:</strong> " + exp_result + "</p>" +
    "<p><strong>Average:</strong> " + average + "</p>" +
    "<hr>" +
    "<h4>🔢 Constants & Rounding</h4>" +
    "<p><strong>π:</strong> " + pi + "</p>" +
    "<p><strong>floor(π):</strong> " + floor(pi) + "</p>" +
    "<p><strong>ceil(π):</strong> " + ceil(pi) + "</p>" +
    "<p><strong>round(π):</strong> " + round(pi) + "</p>" +
    "<p><strong>e:</strong> " + E() + "</p>" +
    "<p><strong>√2:</strong> " + SQRT_2() + "</p>";

render_html(results_html);

// Rounding operations
let rounded_price = round(19.99 * 1.08);  // Tax calculation
let pages = ceil(total_items / items_per_page);

// Validation
if abs(difference) < tolerance {
    info("Values are approximately equal");
}

// Random-like operations using timestamp
let pseudo_random = timestamp() % 100;  // 0-99
```


