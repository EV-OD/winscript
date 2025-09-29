// format_bool.rhai
// Boolean formatting examples using format(template, value)
let enabled = true;
let expired = false;

let s1 = format("Feature enabled: {}", enabled);
let s2 = format("Expired: {}", expired);

let md = "# format_bool.rhai\n\n"
	+ "- Feature enabled: `" + s1 + "`\n"
	+ "- Expired: `" + s2 + "`\n";

md(md)
