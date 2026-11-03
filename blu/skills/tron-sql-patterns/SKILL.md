---
name: tron-sql-patterns
description: Use before calling run_sql on the TRON warehouse. Rules for bounded, explained, chunked read-only SQL and when to use export or a job instead; details come from search_docs.
---

# SQL patterns

## Decide first

Use a dedicated tool when one answers the question (`address_transfers`, `address_counterparties`, `first_funder`,
`contract_callers`, `decode_calls`, `trace_flows`). They are index-shaped and cost 1-5 CU. Write `run_sql` only when
no tool fits: a custom join, a window, a selector histogram.

## Rules

1. **`explain_sql` first.** It never runs the statement, costs 0 CU, and returns the verdict, the partitions touched,
   the estimated cost and a chunk list when the statement is too wide.
2. **Literal block bounds.** Put `block_number BETWEEN <a> AND <b>` with literal numbers on every partitioned table.
   A bound hidden inside a CTE or a subquery does not prune partitions. Add a time bound next to it on address
   lookups.
3. **Stay inside the limits**: read-only single statement, 120 s, cost 5,000,000, 3 partitions. Exact current values:
   `search_docs` "limits".
4. **Chunk large scans by week.** About 201,600 blocks is one week. The `explain_sql` chunk list gives ready ranges.
5. **Know the traps** before you filter: sign of amounts on the sending side, two timestamp types, boolean
   transaction result, address encoding, rounding needing a numeric cast. Ask `search_docs` "gotchas".
6. **Decode calldata with a tool**: `decode_calls` takes the signature. Layouts per protocol:
   `search_docs` with the selector (4 bytes, hex) or the protocol name.
7. **Keep the evidence**: quote the `query_id`, the `block_height` and the SQL from `evidence.sql`.

## When the result is big

- Over about 200 rows with hashes: do not paste rows into the conversation. Call `export` with the `query_id` and
  work on the file; report the file path and the row count.
- A statement that needs more time or cost than the interactive limits: `submit_job`, then `job_status`, then
  `job_results`.
- Pages: use the opaque `cursor` the tool returns; do not rebuild paging by hand.

## Recipes

`search_docs` with a topic ("full history of a token", "weekly export", "selector histogram", "parallel payments")
returns a validated recipe with bounded SQL. Prefer a recipe over a fresh statement.

## Errors

`E_TOO_EXPENSIVE`, `E_TIMEOUT`, `E_SQL_FORBIDDEN`, `E_RATE`, `E_QUOTA`: the message names the fix. Narrow the block
range, apply the chunk list, or move to a job. Do not retry the same statement unchanged.
