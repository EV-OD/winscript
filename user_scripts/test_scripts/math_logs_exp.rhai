// math_logs_exp.rhai
// Logarithmic and exponential examples (log, ln, log10, log2, exp, exp2)
let v = 10.0;
let ln_v = ln(v);
let log10_v = log10(v);
let log2_v = log2(v);
let exp_v = exp(2.0);
let exp2_v = exp2(3.0);

let md = "# math_logs_exp.rhai\n\n"
    + "- ln(10) = `" + ln_v + "`\n"
    + "- log10(10) = `" + log10_v + "`\n"
    + "- log2(10) = `" + log2_v + "`\n"
    + "- exp(2) = `" + exp_v + "`\n"
    + "- exp2(3) = `" + exp2_v + "`\n";

md(md)
