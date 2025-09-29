// format_float.rhai
// Float formatting examples using format(template, value)
let f = 3.14159;
let small = 0.125;

let p = format("Pi approx: {}", f);
let s = format("Small value: {}", small);

let md = "# format_float.rhai\n\n"
	+ "- Pi approx: `" + p + "`\n"
	+ "- Small value: `" + s + "`\n";

md(md)
