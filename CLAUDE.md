# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

This is a Claude Code plugin providing specialized agents for TRON blockchain development. It follows the plugin structure from [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents).

## Repository Structure

```
.claude-plugin/marketplace.json   # Root plugin manifest
agents/
  .claude-plugin/plugin.json      # Plugin definition listing agents
  tronweb-developer.md            # TronWeb SDK expert agent
  transatron-integrator.md        # Transatron integration expert agent
README.md                         # Installation and usage docs
CLAUDE.md                         # This file
```

## Agent File Format

Each agent is a markdown file with YAML frontmatter:

```yaml
---
name: agent-name
description: "When to invoke this agent"
tools: Read, Write, Edit, Bash, Glob, Grep
model: sonnet
---

[System prompt content]
```

Required frontmatter fields: `name`, `description`, `tools`, `model`.

## Key References

- TronWeb docs: https://tronweb.network/docu/docs/intro/
- Transatron docs: https://docs.transatron.io
