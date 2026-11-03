---
name: tron-docs
description: Use when the user asks where TRON's own documentation is - node API reference such as getaccount, protocol proposals (TIPs), java-tron source. Returns links to read; BLU warehouse questions go to search_docs instead.
---

# Where TRON's own documentation lives

For questions about TRON itself (what a node API call takes and returns, what a protocol rule is), answer with a
link and a one-line pointer. These are links to read, not text to copy into an answer. Do not call any tool for
them.

## Links

- Developer portal (guides, concepts, API reference): https://developers.tron.network/
- Full-node HTTP API, an account read: https://developers.tron.network/reference/getaccount
- TRON Improvement Proposals (TIPs): https://github.com/tronprotocol/tips
- java-tron, the reference node implementation: https://github.com/tronprotocol/java-tron

For another API method, start at the developer portal's reference section and name the method.

## Which source for which question

| Question | Go to |
| --- | --- |
| What does node call X take and return? | the API reference at https://developers.tron.network/ |
| Why does the chain behave this way, what changed? | a TIP in https://github.com/tronprotocol/tips |
| Exact consensus or resource rule | the java-tron source |
| What is in this warehouse table, what trap, what limit? | `search_docs` (BLU's own schema and protocol pages) |
| History of an address or contract | the investigation tools, not documentation |

## Rules

- Give the link first. If the user wants more, say which page section to read.
- Say what the link is for, in one sentence, and stop. No long extracts.
- BLU questions (tables, columns, calldata layouts, limits, tools) are answered by `search_docs` and the
  `tron://docs/*` resources. Say that instead of guessing from memory.
- A live node read is a different thing from documentation; see skill `blu-developer-mode`.
