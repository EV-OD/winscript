// conv_energy.rhai
// Energy conversions examples
let j = 4184.0; // 1 kcal in joules
let cal = joules_to_calories(j);
let j_back = calories_to_joules(cal);
let kwh = 1.0;
let j_from_kwh = kwh_to_joules(kwh);
let kwh_back = joules_to_kwh(j_from_kwh);

let md = "# conv_energy.rhai\n\n"
    + "- joules_to_calories(4184) = `" + cal + "`\n"
    + "- calories_to_joules(...) = `" + j_back + "`\n"
    + "- kwh_to_joules(1) = `" + j_from_kwh + "`\n"
    + "- joules_to_kwh(...) = `" + kwh_back + "`\n";

md(md)
