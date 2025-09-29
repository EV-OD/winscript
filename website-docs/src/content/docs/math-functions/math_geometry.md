---
title: "math_geometry"
description: "Geometry helpers (circle_area, circle_circumference)"
---

# math_geometry

Common geometry helpers for area and circumference calculations, convenient when scripts need quick geometric computations.

## Example

```rust
// math_geometry.rhai
// Geometry helpers (circle_area, circle_circumference)
let r = 2.5;
let area = circle_area(r);
let circ = circle_circumference(r);

let md = "# math_geometry.rhai\n\n"
    + "- circle_area(2.5) = `" + area + "`\n"
    + "- circle_circumference(2.5) = `" + circ + "`\n";

md(md)
```
