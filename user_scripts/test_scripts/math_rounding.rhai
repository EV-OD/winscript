// math_rounding.rhai
// Rounding and comparison utilities (abs, floor, ceil, round, trunc, fract, sign, min, max)
let v1 = -3.7;
let v2 = 3.2;
let a = abs(v1);
let f = floor(v1);
let c = ceil(v1);
let r = round(v1);
let t = trunc(v1);
let fr = fract(3.75);
let s = sign(-5);
let mn = min(2.5, 4.1);
let mx = max(2.5, 4.1);

let md = "# math_rounding.rhai\n\n"
    + "- abs(-3.7) = `" + a + "`\n"
    + "- floor(-3.7) = `" + f + "`\n"
    + "- ceil(-3.7) = `" + c + "`\n"
    + "- round(-3.7) = `" + r + "`\n"
    + "- trunc(-3.7) = `" + t + "`\n"
    + "- fract(3.75) = `" + fr + "`\n"
    + "- sign(-5) = `" + s + "`\n"
    + "- min(2.5,4.1) = `" + mn + "`\n"
    + "- max(2.5,4.1) = `" + mx + "`\n";

md(md)
