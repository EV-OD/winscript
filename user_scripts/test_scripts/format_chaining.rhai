// format_chaining.rhai
// Chaining multiple single-value format calls to build a composed string
let name = "Alice";
let age = 30;
let name_fragment = format("Name: {}", name);
let age_fragment = format("Age: {}", age);
// Join the pieces using string concatenation
let combined = name_fragment + ", " + age_fragment;

// Another pattern: format a piece then wrap it
let score = 95;
let result_line = format("Result: {}", score);
let summary = format("Summary -> {}", result_line);

let md = "# format_chaining.rhai\n\n"
	+ "- Combined: `" + combined + "`\n"
	+ "- Summary: `" + summary + "`\n";

md(md)
