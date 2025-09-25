---
title: "timestamp"
description: "Get current system timestamp in milliseconds since Unix epoch"
---

# timestamp Function

Get the current system timestamp in milliseconds since Unix epoch.

## Syntax

```rust
timestamp()
```

## Parameters

No parameters required.

## Return Value

- **Type**: `int`
- **Value**: Milliseconds since Unix epoch (Jan 1, 1970, 00:00:00 UTC)
- **Precision**: Millisecond accuracy
- **Range**: Positive integer, increases with time

## Special Considerations

- Returns Unix timestamp in milliseconds (not seconds)
- Useful for unique IDs and timing operations
- Value always increases (monotonic)
- Platform-independent timing
- Good for measuring elapsed time

## Example

```rust
// Get current timestamp
let now = timestamp();
info("Current time: " + now);

// Create unique identifier
let task_id = "task_" + timestamp();
info("Generated ID: " + task_id);

// Measure operation time
let start_time = timestamp();
// ... perform some operation
let end_time = timestamp();
let duration = end_time - start_time;
info("Operation took: " + duration + " milliseconds");

// Timestamped data
let data = #{
    id: timestamp(),
    content: "Sample data",
    created_at: timestamp()
};
```


