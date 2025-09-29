// conv_speed.rhai
// Speed conversions examples
let kmh = 100.0;
let mph = kmh_to_mph(kmh);
let kmh_back = mph_to_kmh(mph);
let ms = 10.0;
let kmh_from_ms = ms_to_kmh(ms);
let ms_back = kmh_to_ms(36.0);

let md = "# conv_speed.rhai\n\n"
    + "- kmh_to_mph(100) = `" + mph + "`\n"
    + "- mph_to_kmh(...) = `" + kmh_back + "`\n"
    + "- ms_to_kmh(10) = `" + kmh_from_ms + "`\n"
    + "- kmh_to_ms(36) = `" + ms_back + "`\n";

md(md)
