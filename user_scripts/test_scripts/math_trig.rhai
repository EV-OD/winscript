// math_trig.rhai
// Trigonometric function examples (sin, cos, tan, asin, acos, atan, atan2)
let a = 0.5; // radians for sin/cos/tan
let s = sin(a);
let c = cos(a);
let t = tan(a);
let asin_v = asin(a);
let acos_v = acos(a);
let atan_v = atan(a);
let atan2_v = atan2(1.0, 1.0); // atan2(y, x)

let md = "# math_trig.rhai\n\n"
    + "- sin(0.5) = `" + s + "`\n"
    + "- cos(0.5) = `" + c + "`\n"
    + "- tan(0.5) = `" + t + "`\n"
    + "- asin(0.5) = `" + asin_v + "`\n"
    + "- acos(0.5) = `" + acos_v + "`\n"
    + "- atan(0.5) = `" + atan_v + "`\n"
    + "- atan2(1,1) = `" + atan2_v + "`\n";

md(md)
