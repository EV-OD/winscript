// math_quadratic_distance.rhai
// Quadratic solver and distance examples
let roots = quadratic(1.0, -3.0, 2.0); // x^2 -3x +2 -> roots 1 and 2
let dist = distance(0.0, 0.0, 3.0, 4.0); // 3-4-5 triangle -> 5

let md = "# math_quadratic_distance.rhai\n\n"
    + "- quadratic(1,-3,2) = `" + roots + "`\n"
    + "- distance((0,0),(3,4)) = `" + dist + "`\n";

md(md)
