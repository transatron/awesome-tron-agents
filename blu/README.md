# BLU for TRON investigations

BLU adds TRON Forensics to Claude: the complete history of TRON behind one connector, with the evidence for every
answer. This plugin bundles the connector with the working method for investigators.

## What is in it

- **Connector**: the `tron` server with the investigation tools (profile, transfers, counterparties, first funder,
  flow tracing, gas payers, permission history, contract callers, decoded calls, transaction lookup, raw SQL with
  guard-rails, export).
- **6 skills**: `tron-evidence-standard`, `tron-schema-reference`, `tron-sql-patterns`,
  `tron-investigation-playbooks`, `tron-docs`, `blu-developer-mode`.
- **3 agents** (Claude Code): `tron-investigator`, `tron-flow-tracer`, `tron-sql-analyst`.
- **2 commands**: `/blu:investigate <address>` and `/blu:exposure <address> [hops]`.

## Install

Setup per surface (Claude Code, claude.ai and Desktop, Codex): `docs/user-docs/setup/` in the product repository.
In Claude Code, add the marketplace and install `blu@transatron-tron-agents`, then sign in from `/mcp`.

## Evidence

Every answer carries the SQL that produced it, the block height and full transaction hashes. The skills make the
agent quote them in full and separate what the data shows from what it suggests.

## Limits and privacy

The beta is free, with daily compute and rate limits; the numbers are in the tool reference and in `search_docs`
"limits". Your queries are private: not shared, not published, not used for training.
