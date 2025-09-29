// conv_pressure.rhai
// Pressure conversions examples
let pa = 101325.0; // atmos pressure in Pa
let psi = pascal_to_psi(pa);
let pa_back = psi_to_pascal(psi);
let bar = 1.0;
let psi_from_bar = bar_to_psi(bar);
let bar_back = psi_to_bar(psi_from_bar);

let md = "# conv_pressure.rhai\n\n"
    + "- pascal_to_psi(101325) = `" + psi + "`\n"
    + "- psi_to_pascal(...) = `" + pa_back + "`\n"
    + "- bar_to_psi(1) = `" + psi_from_bar + "`\n"
    + "- psi_to_bar(...) = `" + bar_back + "`\n";

md(md)
