---
title: "math_constants"
description: "Mathematical constants (PI, E, TAU, LN_2, LN_10, LOG2_E, LOG10_E, SQRT_2)"
---

# math_constants

These constants are provided so scripts can rely on precise, well-known mathematical values (PI, E, TAU, etc.) without redefining them.

## Example

```rust
// math_constants.rhai
// Mathematical constants (PI, E, TAU, LN_2, LN_10, LOG2_E, LOG10_E, SQRT_2)
let pi = PI();
let e = E();
let tau = TAU();
let ln2 = LN_2();
let ln10 = LN_10();
let log2e = LOG2_E();
let log10e = LOG10_E();
let sqrt2 = SQRT_2();

let md = "# math_constants.rhai\n\n"
    + "- PI = `" + pi + "`\n"
    + "- E = `" + e + "`\n"
    + "- TAU = `" + tau + "`\n"
    + "- LN_2 = `" + ln2 + "`\n"
    + "- LN_10 = `" + ln10 + "`\n"
    + "- LOG2_E = `" + log2e + "`\n"
    + "- LOG10_E = `" + log10e + "`\n"
    + "- SQRT_2 = `" + sqrt2 + "`\n";

md(md)
```
