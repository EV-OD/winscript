// format_int.rhai
// Integer formatting examples using format(template, value)
let n = 7;
let big = 123456;

let s1 = format("Value: {}", n);
let s2 = format("There are {} items in the list.", n);
let s3 = format("Big number: {}", big);

let md = "# format_int.rhai\n\n"
	+ "- Simple integer: `" + s1 + "`\n"
	+ "- Sentence with integer: `" + s2 + "`\n"
	+ "- Big number: `" + s3 + "`\n";

md(md)
