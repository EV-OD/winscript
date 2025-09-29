// math_power_root.rhai
// Power and root examples (pow, sqrt, cbrt)
let p1 = pow(2.0, 8.0);
let p2 = pow(9.0, 0.5); // should equal 3.0
let r = sqrt(16.0);
let c = cbrt(27.0);

let md = "# math_power_root.rhai\n\n"
    + "- pow(2,8) = `" + p1 + "`\n"
    + "- pow(9,0.5) = `" + p2 + "`\n"
    + "- sqrt(16) = `" + r + "`\n"
    + "- cbrt(27) = `" + c + "`\n";

md(md)
