---
name: tron-evidence-standard
description: Load first for any TRON investigation or report. Rules that make an answer defensible - full hashes and addresses, query_id and block height on every figure, observation kept apart from inference, a four-step confidence scale.
---

# Evidence standard

Every answer from the TRON Forensics tools carries evidence: `evidence.query_id`, `evidence.block_height`,
`evidence.sql`, `evidence.tx_hashes` and `evidence.result_sha256`. Your report must keep that chain intact.

## Rules

1. **Cite every figure.** Next to each number or finding give the `query_id` and the `block_height` it was read at.
2. **Never shorten.** Write every transaction hash as 64 hex characters and every address in full Base58 (34
   characters). No ellipsis, no "0x1234…abcd", no "first 8 characters". If you cannot show it in full, say what is
   missing instead of abbreviating.
3. **Observation and inference are separate sentences.** An observation says what the data shows ("T… sent 5,000
   USDT in transaction <full hash>"). An inference says what you conclude from it ("this suggests the same operator").
   Never mix them in one sentence.
4. **Label confidence** on every conclusion with one of: **Confirmed** (an on-chain transaction hash proves it),
   **Probable** (several independent signals agree, no single proof), **Possible** (one signal, plausible), **Lead**
   (worth a look, not yet supported). A claim is Confirmed only with a full hash.
5. **Re-verify before you issue a report.** Check every hash you quote with `tx_lookup`. Replace any hash that fails.
6. **Name the source and date** of every price and every label. Labels are categories only (exchange, scam,
   sanctioned and similar), not entity names.
7. **Live node answers are not evidence of the past.** A result marked `meta.live: true` cannot be replayed; say so
   and use a history tool for anything you must prove.

## Report shape

- Question and scope (addresses, window, block range).
- Findings, each: observation, `query_id`, `block_height`, full hashes.
- Inferences, each with its confidence label.
- Open leads and what would confirm them.
- Reproduction: the SQL from `evidence.sql` for any query you want the reader to rerun.

## Where to look

- Tool guide: `search_docs` with "which tool", or read `tron://docs/tools`.
- Large results: `export` writes the full set to a file; cite the export's `query_id`, not pasted rows.
- Method for each case type: skill `tron-investigation-playbooks`.
