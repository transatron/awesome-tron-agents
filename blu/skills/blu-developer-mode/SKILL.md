---
name: blu-developer-mode
description: Use when deciding between a live node read (state now, simulate a call, estimate energy) and the history tools. Explains what developer-mode tools do, what they cost, and why a live answer is not evidence of the past.
---

# Developer mode: live node reads versus history

Developer mode is a deployment setting. When it is on, extra tools appear in the tool list; when it is off they do
not exist and `search_docs` is the only place that mentions them. Check the tool list before you plan around them.

## Choose

| You need | Use |
| --- | --- |
| State of the chain right now (current block, free energy, chain parameters) | `call_tron_node` |
| The ABI and settings of a contract today | `get_contract` |
| The result of a view function today | `contract_call` |
| What a call or a deployment would cost before you send it | `estimate_energy`, `estimate_contract_deploy` |
| Burn and stake prices for energy and bandwidth | `get_energy_prices` |
| Answers in the shape of the TronGrid v1 API | `trongrid_v1` |
| Transactions of an address with paging | `get_transactions_by_address` |
| Anything about the past that you must prove | the history tools: `address_transfers`, `tx_lookup`, `balance_at`, `energy_profile`, `run_sql` |

## Evidence

A live answer says `meta.live: true`, `meta.replayable: false` and has no stored SQL. It is **not evidence of the
past** and cannot be replayed by `export` or the evidence bundle. Keep the rows and the `result_sha256` if you need
them later, and tell the reader the answer was live. For a past claim go back to a history tool.

## Reading a live answer

- The node leaves out fields at their default: an absent key means zero, false or empty.
- An empty object means no rows (for example an address never activated).
- Large integers arrive as decimal strings.
- A state-changing function, a broadcast or a signing path is refused and nothing is sent.

## Cost

- `call_tron_node` (developer mode): 1 per call, flat for every path: a node call costs 1 CU, under the same daily budget; a failed call costs nothing.
- `get_contract`, `contract_call` (developer mode, Free): 1 per call, flat: a node call costs 1 CU, under the same daily budget; a failed call costs nothing.
- `estimate_energy` (developer mode): 1 per call, also for a revert or a cap hit; a function given by name makes one extra node read (2 account tokens, still 1 CU); at most 4 estimates run at once per gateway instance.

Full path list and error codes: `search_docs` "developer mode", or `tron://docs/developer-mode`.
