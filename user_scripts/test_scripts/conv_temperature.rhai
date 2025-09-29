// conv_temperature.rhai
// Temperature conversions examples
let c = 25.0;
let f = celsius_to_fahrenheit(c);
let c_back = fahrenheit_to_celsius(f);
let k = celsius_to_kelvin(c);
let c_from_k = kelvin_to_celsius(k);
let f_to_k = fahrenheit_to_kelvin(32.0);
let k_to_f = kelvin_to_fahrenheit(273.15);

let md = "# conv_temperature.rhai\n\n"
    + "- celsius_to_fahrenheit(25) = `" + f + "`\n"
    + "- fahrenheit_to_celsius(...) = `" + c_back + "`\n"
    + "- celsius_to_kelvin(25) = `" + k + "`\n"
    + "- kelvin_to_celsius(...) = `" + c_from_k + "`\n"
    + "- fahrenheit_to_kelvin(32) = `" + f_to_k + "`\n"
    + "- kelvin_to_fahrenheit(273.15) = `" + k_to_f + "`\n";

md(md)
