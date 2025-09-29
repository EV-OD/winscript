// conv_area.rhai
// Area conversions examples
let sqm = 10.0;
let sqft = square_meters_to_square_feet(sqm);
let sqm_back = square_feet_to_square_meters(sqft);
let ha = 2.0;
let acres = hectares_to_acres(ha);
let ha_back = acres_to_hectares(acres);

let md = "# conv_area.rhai\n\n"
    + "- square_meters_to_square_feet(10) = `" + sqft + "`\n"
    + "- square_feet_to_square_meters(...) = `" + sqm_back + "`\n"
    + "- hectares_to_acres(2) = `" + acres + "`\n"
    + "- acres_to_hectares(...) = `" + ha_back + "`\n";

md(md)
