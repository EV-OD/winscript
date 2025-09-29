// conv_weight.rhai
// Weight conversions examples
let kg = 2.0;
let lbs = kilograms_to_pounds(kg);
let kg_back = pounds_to_kilograms(lbs);
let g = 500.0;
let oz = grams_to_ounces(g);
let g_back = ounces_to_grams(oz);

let md = "# conv_weight.rhai\n\n"
    + "- kilograms_to_pounds(2) = `" + lbs + "`\n"
    + "- pounds_to_kilograms(...) = `" + kg_back + "`\n"
    + "- grams_to_ounces(500) = `" + oz + "`\n"
    + "- ounces_to_grams(...) = `" + g_back + "`\n";

md(md)
