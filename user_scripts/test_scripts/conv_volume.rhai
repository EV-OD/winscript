// conv_volume.rhai
// Volume conversions examples
let l = 3.0;
let gal = liters_to_gallons(l);
let l_back = gallons_to_liters(gal);
let ml = 500.0;
let floz = milliliters_to_fluid_ounces(ml);
let ml_back = fluid_ounces_to_milliliters(floz);

let md = "# conv_volume.rhai\n\n"
    + "- liters_to_gallons(3) = `" + gal + "`\n"
    + "- gallons_to_liters(...) = `" + l_back + "`\n"
    + "- milliliters_to_fluid_ounces(500) = `" + floz + "`\n"
    + "- fluid_ounces_to_milliliters(...) = `" + ml_back + "`\n";

md(md)
