// format_str.rhai
// String formatting examples using format(template, value)
let name = "Rhai";

let greet = format("Hello, {}!", name);
let fragment = format("User: {}", name);
let wrapped = format("Profile -> {}", fragment);

let md = "# format_str.rhai\n\n"
	+ "- Greet: `" + greet + "`\n"
	+ "- Fragment: `" + fragment + "`\n"
	+ "- Wrapped: `" + wrapped + "`\n";

md(md)