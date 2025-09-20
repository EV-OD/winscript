# Math Functions

## Overview
Rhai provides comprehensive mathematical operations and functions for numerical computations in SnapRun scripts.

## Basic Arithmetic Operations

### Addition (`+`)
```rhai
let sum = 5 + 3;        // 8
let concat = "Hello " + "World";  // String concatenation
```

### Subtraction (`-`)
```rhai
let diff = 10 - 4;      // 6
let negative = -5;      // Unary minus
```

### Multiplication (`*`)
```rhai
let product = 6 * 7;    // 42
let repeated = "Hi" * 3; // String repetition: "HiHiHi"
```

### Division (`/`)
```rhai
let quotient = 15 / 3;  // 5
let decimal = 7 / 2;    // 3.5 (float division)
```

### Modulo (`%`)
```rhai
let remainder = 17 % 5; // 2
let even_check = num % 2 == 0; // Check if even
```

### Exponentiation (`**` or `pow()`)
```rhai
let power = 2 ** 3;     // 8
let power2 = pow(2, 3); // 8 (alternative syntax)
```

## Mathematical Functions

### abs(n)
Returns absolute value
```rhai
let positive = abs(-5);    // 5
let distance = abs(x - y); // Distance between two points
```

### min(a, b)
Returns the smaller value
```rhai
let smaller = min(10, 5);  // 5
let min_age = min(user1.age, user2.age);
```

### max(a, b)
Returns the larger value
```rhai
let larger = max(10, 5);   // 10
let max_score = max(score1, score2);
```

### sqrt(n)
Returns square root
```rhai
let root = sqrt(16);       // 4.0
let hypotenuse = sqrt(a*a + b*b); // Pythagorean theorem
```

### floor(n)
Returns largest integer less than or equal to n
```rhai
let down = floor(3.7);     // 3
let rounded_down = floor(price);
```

### ceil(n)
Returns smallest integer greater than or equal to n
```rhai
let up = ceil(3.2);        // 4
let pages_needed = ceil(items / items_per_page);
```

### round(n)
Returns nearest integer
```rhai
let nearest = round(3.6);  // 4
let rounded_price = round(price * 100) / 100; // Round to 2 decimals
```

## Advanced Mathematical Examples

### Distance Calculation
```rhai
fn calculate_distance(x1, y1, x2, y2) {
    let dx = x2 - x1;
    let dy = y2 - y1;
    return sqrt(dx*dx + dy*dy);
}

let distance = calculate_distance(0, 0, 3, 4); // 5.0
info("Distance: " + distance);
```

### Statistical Functions
```rhai
fn average(numbers) {
    let sum = 0;
    for num in numbers {
        sum += num;
    }
    return sum / numbers.len();
}

fn find_max(numbers) {
    let maximum = numbers[0];
    for num in numbers {
        maximum = max(maximum, num);
    }
    return maximum;
}

let scores = [85, 92, 78, 96, 88];
let avg_score = average(scores);
let high_score = find_max(scores);

info("Average score: " + avg_score);
info("High score: " + high_score);
```

### Financial Calculations
```rhai
// Simple interest calculator
fn calculate_interest(principal, rate, time) {
    return principal * rate * time / 100;
}

// Compound interest calculator
fn compound_interest(principal, rate, time, compounds_per_year) {
    let r = rate / 100;
    let n = compounds_per_year;
    let amount = principal * pow(1 + r/n, n * time);
    return amount - principal;
}

let principal = 1000;
let rate = 5; // 5%
let years = 2;

let simple = calculate_interest(principal, rate, years);
let compound = compound_interest(principal, rate, years, 12);

render_html("Interest Calculator", `
    <div style="font-family: Arial; padding: 1rem;">
        <h3>Investment Results</h3>
        <p><strong>Principal:</strong> $${principal}</p>
        <p><strong>Rate:</strong> ${rate}%</p>
        <p><strong>Time:</strong> ${years} years</p>
        <hr>
        <p><strong>Simple Interest:</strong> $${simple}</p>
        <p><strong>Compound Interest:</strong> $${compound}</p>
        <p><strong>Difference:</strong> $${compound - simple}</p>
    </div>
`);
```

### Geometry Calculations
```rhai
// Circle calculations
fn circle_area(radius) {
    let pi = 3.14159265359;
    return pi * radius * radius;
}

fn circle_circumference(radius) {
    let pi = 3.14159265359;
    return 2 * pi * radius;
}

// Rectangle calculations
fn rectangle_area(width, height) {
    return width * height;
}

fn rectangle_perimeter(width, height) {
    return 2 * (width + height);
}

let radius = 5;
let width = 10;
let height = 6;

info("Circle (radius=" + radius + "):");
info("  Area: " + circle_area(radius));
info("  Circumference: " + circle_circumference(radius));

info("Rectangle (" + width + "x" + height + "):");
info("  Area: " + rectangle_area(width, height));
info("  Perimeter: " + rectangle_perimeter(width, height));
```

### Number Utilities
```rhai
// Check if number is even
fn is_even(n) {
    return n % 2 == 0;
}

// Check if number is prime
fn is_prime(n) {
    if n < 2 {
        return false;
    }
    for i in 2..sqrt(n) + 1 {
        if n % i == 0 {
            return false;
        }
    }
    return true;
}

// Generate Fibonacci sequence
fn fibonacci(n) {
    if n <= 1 {
        return n;
    }
    
    let a = 0;
    let b = 1;
    let result = [];
    
    result.push(a);
    result.push(b);
    
    for i in 2..n {
        let next = a + b;
        result.push(next);
        a = b;
        b = next;
    }
    
    return result;
}

let number = 17;
info(number + " is even: " + is_even(number));
info(number + " is prime: " + is_prime(number));

let fib_sequence = fibonacci(10);
info("First 10 Fibonacci numbers: " + fib_sequence);
```

### Random Number Generation
```rhai
// Note: Using timestamp for pseudo-random
fn pseudo_random(min_val, max_val) {
    let seed = timestamp() % 1000;
    let range = max_val - min_val + 1;
    return min_val + (seed % range);
}

fn random_choice(array) {
    let index = pseudo_random(0, array.len() - 1);
    return array[index];
}

let random_num = pseudo_random(1, 100);
let colors = ["red", "blue", "green", "yellow"];
let random_color = random_choice(colors);

info("Random number (1-100): " + random_num);
info("Random color: " + random_color);
```

### Data Analysis
```rhai
fn analyze_numbers(data) {
    if data.len() == 0 {
        return #{};
    }
    
    let sum = 0;
    let min_val = data[0];
    let max_val = data[0];
    
    for num in data {
        sum += num;
        min_val = min(min_val, num);
        max_val = max(max_val, num);
    }
    
    let avg = sum / data.len();
    let range = max_val - min_val;
    
    return #{
        count: data.len(),
        sum: sum,
        average: avg,
        minimum: min_val,
        maximum: max_val,
        range: range
    };
}

let test_scores = [78, 85, 92, 88, 76, 94, 82, 89, 91, 87];
let analysis = analyze_numbers(test_scores);

render_html("Score Analysis", `
    <div style="font-family: Arial; padding: 1rem;">
        <h3>Test Score Analysis</h3>
        <table style="border-collapse: collapse; width: 100%;">
            <tr><td style="border: 1px solid #ddd; padding: 8px;"><strong>Count:</strong></td>
                <td style="border: 1px solid #ddd; padding: 8px;">${analysis.count}</td></tr>
            <tr><td style="border: 1px solid #ddd; padding: 8px;"><strong>Average:</strong></td>
                <td style="border: 1px solid #ddd; padding: 8px;">${analysis.average}</td></tr>
            <tr><td style="border: 1px solid #ddd; padding: 8px;"><strong>Minimum:</strong></td>
                <td style="border: 1px solid #ddd; padding: 8px;">${analysis.minimum}</td></tr>
            <tr><td style="border: 1px solid #ddd; padding: 8px;"><strong>Maximum:</strong></td>
                <td style="border: 1px solid #ddd; padding: 8px;">${analysis.maximum}</td></tr>
            <tr><td style="border: 1px solid #ddd; padding: 8px;"><strong>Range:</strong></td>
                <td style="border: 1px solid #ddd; padding: 8px;">${analysis.range}</td></tr>
        </table>
    </div>
`);
```

## Number Formatting

### Precision Control
```rhai
// Round to specific decimal places
fn round_to_places(number, places) {
    let multiplier = pow(10, places);
    return round(number * multiplier) / multiplier;
}

let pi_approx = 3.14159265359;
info("Pi to 2 places: " + round_to_places(pi_approx, 2)); // 3.14
info("Pi to 4 places: " + round_to_places(pi_approx, 4)); // 3.1416
```

### Number Validation
```rhai
fn is_number(value) {
    try {
        let num = value + 0; // Try arithmetic operation
        return true;
    } catch {
        return false;
    }
}

fn is_integer(value) {
    return is_number(value) && value == floor(value);
}

let test1 = "42";
let test2 = "3.14";
let test3 = "hello";

info(test1 + " is number: " + is_number(test1));
info(test2 + " is integer: " + is_integer(test2));
info(test3 + " is number: " + is_number(test3));
```

## Notes
- All mathematical operations follow standard mathematical rules
- Division by zero will cause runtime errors
- Rhai supports both integer and floating-point arithmetic
- Large numbers may lose precision due to floating-point limitations
- String concatenation and numeric addition both use the `+` operator

## Related Functions
- `timestamp()` - Get current timestamp (useful for seeds)
- `parse_json()` - Parse numeric data from JSON
- `to_json()` - Serialize numeric results
- `ask_input()` - Get numeric input from users
