---
title: "format_str"
description: "String formatting examples using format(template, value)"
---

# format_str

String formatting examples using the built-in `format(template, value)` helper.

## Syntax

```rust
format(template, value)
```

`format` replaces `{}` placeholders in `template` with the provided `value` (or values when supported by the runtime). Use it to build readable, composable strings in scripts.

## Example

```rust
// String formatting examples using format(template, value)
let name = "Rhai";

let greet = format("Hello, {}!", name);
let fragment = format("User: {}", name);
let wrapped = format("Profile -> {}", fragment);

let md = "# format_str.rhai\n\n"
    + "- Greet: `" + greet + "`\n"
    + "- Fragment: `" + fragment + "`\n"
    + "- Wrapped: `" + wrapped + "`\n";

// Render the markdown and end with a voiding call so the runner returns ()
render_markdown(md);
```

This example shows simple positional replacement and composition: `wrapped` nests a previously formatted fragment.

## Quick examples

- Single placeholder

```rust
format("Hello, {}!", "Rhai") // -> "Hello, Rhai!"
```