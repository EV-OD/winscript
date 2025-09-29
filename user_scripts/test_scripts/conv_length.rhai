// conv_length.rhai
// Length conversions examples
let m = 1.0;
let ft = meters_to_feet(m);
let m_back = feet_to_meters(ft);
let inches = meters_to_inches(0.5);
let meters_from_inches = inches_to_meters(12.0);
let km = 5.0;
let miles = kilometers_to_miles(km);
let km_back = miles_to_kilometers(miles);
let cm = 100.0;
let inch_from_cm = centimeters_to_inches(cm);
let cm_back = inches_to_centimeters(inch_from_cm);

let md = "# conv_length.rhai\n\n"
    + "- meters_to_feet(1) = `" + ft + "`\n"
    + "- feet_to_meters(" + ft + ") = `" + m_back + "`\n"
    + "- meters_to_inches(0.5) = `" + inches + "`\n"
    + "- inches_to_meters(12) = `" + meters_from_inches + "`\n"
    + "- kilometers_to_miles(5) = `" + miles + "`\n"
    + "- miles_to_kilometers(miles) = `" + km_back + "`\n"
    + "- centimeters_to_inches(100) = `" + inch_from_cm + "`\n"
    + "- inches_to_centimeters(...) = `" + cm_back + "`\n";

md(md)
