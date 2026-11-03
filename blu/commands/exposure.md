---
description: Check a TRON address for exposure to labelled categories within N hops
argument-hint: <address> [hops]
---

Run an exposure check on $ARGUMENTS (the address, then an optional hop count; default 2).

Load the skills `tron-evidence-standard` and `tron-investigation-playbooks` (exposure check). Use the
`tron-flow-tracer` agent if it is available.

1. `trace_flows` from the address, up to the hop count, with `stop_at_labels` set to the risk categories.
2. `tx_lookup` on every transaction hash of every path you report.
3. Report each path as the addresses in full and the full hash of each hop, with `query_id` and `block_height`.

Label each path Confirmed only when every hop has a verified hash. Say what the trace truncated. Labels are categories
only, with their date.
