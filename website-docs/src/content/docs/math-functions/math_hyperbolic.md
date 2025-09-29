---
title: "math_hyperbolic"
description: "Hyperbolic functions (sinh, cosh, tanh)"
---

# math_hyperbolic

Hyperbolic functions are useful in advanced math and certain physics calculations; these helpers expose sinh/cosh/tanh for convenience.

## Example

```rust
// math_hyperbolic.rhai
// Hyperbolic function examples (sinh, cosh, tanh)
let x = 1.0;
let sh = sinh(x);
let ch = cosh(x);
let th = tanh(x);

let md = "# math_hyperbolic.rhai\n\n"
    + "- sinh(1.0) = `" + sh + "`\n"
    + "- cosh(1.0) = `" + ch + "`\n"
    + "- tanh(1.0) = `" + th + "`\n";

md(md)
```
