// math_hyperbolic.rhai
// Hyperbolic function examples (sinh, cosh, tanh)
let x = 1.0;
let sh = sinh(x);
let ch = cosh(x);
let th = tanh(x);

let md = "# math_hyperbolic.rhai\n\n"
    + "- sinh(1.0) = `" + sh + "`\n"
    + "- cosh(1.0) = `" + ch + "`\n"
    + "- tanh(1.0) = `" + th + "`\n";

md(md)
