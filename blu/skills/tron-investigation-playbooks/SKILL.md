---
name: tron-investigation-playbooks
description: Use for a TRON address or contract investigation - first funder, pass-through, gas payers, permission hijack, exposure check, contract study. Gives the tool order for each; follow tron-evidence-standard for the report.
---

# Investigation playbooks

Run the steps in order, one tool per step. Keep every `query_id` and `block_height`. Quote full hashes and addresses
(skill `tron-evidence-standard`). Use `run_sql` only when a step says "no tool answers this".

## Start of any case

1. `address_profile` (up to 50 addresses in one call): contract or wallet, first and last seen, balances, keys.
2. `address_counterparties` for who it deals with, then `address_transfers` for the rows behind a counterparty.

## First funder

`first_funder` -> `tx_lookup` on the activation transaction -> repeat on the funder while it is a plain wallet.
Stop at a labelled address (exchange or similar) and say so.

## Pass-through

`trace_flows` with `collapse_passthrough` on -> `address_transfers` on the hop that matters -> `tx_lookup` on each
hash you will quote. Report what was collapsed.

## Gas payers

`gas_payers` for a window (who pays the fees) -> `tx_gas_payers` for the exact ledger of single transactions ->
`energy_profile` for delegations as such. Funders of burned TRX are an inference; label them so.

## Permission hijack

`permission_history` (owner and active key changes with the transaction that made each) -> `tx_lookup` on every change
-> `address_transfers` for the window after the change. Put the key change and the first outflow side by side.

## Exposure check

`trace_flows` with `stop_at_labels` set to the categories you care about, the hop count the user gave -> `tx_lookup`
on each path's hashes. A path is Confirmed only when every hop has a hash.

## Parallel payments

`detect_parallel_payments` for the pattern; do not re-implement its thresholds. Verify the flagged transactions with
`tx_lookup`.

## Contract study

`contract_callers` (who calls it, which selectors) -> `decode_calls` with the signature for the selector that matters
-> `address_transfers` of the contract itself -> `trace_flows` from the recipients -> `export` for anything large.
If a step needs data no tool returns, `search_docs` for the protocol page and a recipe, then `explain_sql` and
`run_sql`.

## Before you finish

Re-verify every quoted hash with `tx_lookup`. If a question has no tool that can answer it, report it with
`submit_feedback`.

Costs of a typical case are listed in `search_docs` "limits".
