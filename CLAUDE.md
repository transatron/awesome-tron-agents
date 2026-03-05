# CLAUDE.md

Claude Code plugin — specialized agents for TRON blockchain development. Plugin structure follows [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents).

## How This Repo Works

Each `.md` file in `agents/` is an agent. `agents/.claude-plugin/plugin.json` lists them — if you add or remove an agent, update that array. `.claude-plugin/marketplace.json` at the root is the marketplace manifest (rarely changes).

`local/` contains reference implementations that agents are derived from. Code examples in agents should match these sources. **Never commit `local/` — it's gitignored.**

## Agent Frontmatter Rules

The `description` field is critical — Claude Code uses it as the routing hint to decide which agent to spawn. Write it as a "Use when..." trigger phrase. Bad descriptions mean the agent never gets invoked.

`tools` controls what the agent can actually do. Architect agents (`tron-architect`, `transatron-architect`) deliberately lack Write/Edit/Bash because they advise on architecture but must not write code — they hand off to implementation agents instead.

`model: inherit` means the agent uses whatever model the caller is running. We use this everywhere so the user controls model selection.

## Agent Design Conventions

- Architect agents advise and delegate. Implementation agents write code. This split exists because mixing advice and code in one agent produces worse output for both.
- Each agent lists which other agents to delegate to. Keep these cross-references consistent — if agent A mentions agent B, check that B's description covers what A promises.
- Code examples in agents should be production TypeScript derived from `local/` reference implementations, not invented. When the reference changes, update the agent.
- Transatron docs at https://docs.transatron.io support appending `.md` to sitemap URLs for raw markdown — agents use this for WebFetch.

## Validating Changes

After editing agents, verify:
- YAML frontmatter parses cleanly (name, description, tools, model all present)
- `agents/.claude-plugin/plugin.json` agents array matches actual files in `agents/`
- Cross-references between agents are bidirectional and consistent
- No `local/` paths leaked into agent content

## Key References

- TronWeb: https://tronweb.network/docu/docs/intro/
- Transatron: https://docs.transatron.io
- TRON platform: https://developers.tron.network/docs/
