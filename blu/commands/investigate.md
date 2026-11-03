---
description: Investigate a TRON address with the evidence standard (profile, counterparties, funding, flows)
argument-hint: <address>
---

Investigate the TRON address $ARGUMENTS.

Load the skills `tron-evidence-standard` and `tron-investigation-playbooks`. Use the `tron-investigator` agent if it is
available; otherwise follow the playbooks yourself.

1. `address_profile`, then `address_counterparties` and `address_transfers` for the largest counterparties.
2. `first_funder`, then `trace_flows` one or two hops from the address.
3. `gas_payers` and `permission_history` when the profile shows resources or keys worth checking.
4. `tx_lookup` on every hash you quote.

Write the report: findings with `query_id` and `block_height`, full hashes and addresses, observation and inference in
separate sentences, a confidence label on each conclusion. Do not use `run_sql` unless a step has no tool.
