---
title: "math_finance"
description: "Finance helpers (percentage, compound_interest)"
---

# math_finance

Small finance-related helper functions useful for simple percentage and compound-interest calculations in automation scripts.

## Example

```rust
// math_finance.rhai
// Finance helpers (percentage, compound_interest)
let base = 200.0;
let pct = percentage(base, 15.0);
let compound = compound_interest(1000.0, 5.0, 2.0, 12.0);

let md = "# math_finance.rhai\n\n"
    + "- percentage(200,15) = `" + pct + "`\n"
    + "- compound_interest(1000,5,2,12) = `" + compound + "`\n";

md(md)
```
