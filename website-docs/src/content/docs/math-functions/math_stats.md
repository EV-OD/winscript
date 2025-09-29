---
title: "math_stats"
description: "Statistical helpers (factorial, combination, permutation)"
---

# math_stats

Simple statistical helpers for factorials, combinations and permutations used in combinatorics or reporting tasks.

## Example

```rust
// math_stats.rhai
// Statistical helpers (factorial, combination, permutation)
let f5 = factorial(5);
let comb = combination(5, 2);
let perm = permutation(5, 2);

let md = "# math_stats.rhai\n\n"
    + "- factorial(5) = `" + f5 + "`\n"
    + "- combination(5,2) = `" + comb + "`\n"
    + "- permutation(5,2) = `" + perm + "`\n";

md(md)
```
