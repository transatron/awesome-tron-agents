---
name: tron-schema-reference
description: Use before writing SQL or interpreting a column on the TRON warehouse. Tells you which table holds what and which tool wraps it, and sends every detail to search_docs instead of repeating it here.
---

# Schema reference (thin)

This skill holds no table documentation. The documentation corpus lives behind the server, always current:

- `search_docs` with a table name (for example `trc20_transfer`) returns that table's full page.
- `search_docs` with `datasets` returns the catalogue of tables.
- `search_docs` with a symptom ("negative amount", "timestamp", "wrong result") returns the matching trap.
- Full pages can be read as resources: `tron://docs/gotchas`, `tron://docs/limits`, `tron://docs/tools`.
- `search_docs` needs no sign-in and costs 0 CU.

## Map: what is where

| Question | Look at | Prefer the tool |
| --- | --- | --- |
| Token transfers with a running balance | `trc20_transfer` | `address_transfers`, `balance_at` |
| Contract calls and raw calldata | `trigger_smart_contract` | `contract_callers`, `decode_calls` |
| Native TRX transfers | `transaction` | `address_transfers`, `tx_lookup` |
| Internal transactions | `internal_transaction` | `address_transfers`, `tx_lookup` |
| Address-pair graph and label categories | `graph` schema, `tfm.labels` | `address_counterparties`, `trace_flows` |
| Energy and staking | the energy schema | `energy_profile`, `gas_payers`, `tx_gas_payers` |
| Multisig permission changes | search "permission" | `permission_history` |

Ask `search_docs` for the current column list; do not rely on memory of it.

## Always ask the docs about

- Sign of amounts on the sending side of a transfer table.
- The two timestamp types (a bigint in milliseconds and a naive UTC timestamp).
- Address encoding in the tables and the helper functions that convert it.
- Partition bounds and the per-statement limits (`tron://docs/limits`).

Then follow `tron-sql-patterns` for the rules and `explain_sql` before any wide statement.
