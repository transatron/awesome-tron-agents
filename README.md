# TRON Agents Plugin for Claude Code

Specialized Claude Code agents for TRON blockchain development. Get expert guidance on TronWeb usage and Transatron integration while building TRON DApps.

## Agents

- [**tronweb-developer**](agents/tronweb-developer.md) — TronWeb SDK expert for building TRON DApps, creating/signing/broadcasting transactions, wallet integration, and TRC20 token operations.
- [**transatron-integrator**](agents/transatron-integrator.md) — Transatron (Transfer Edge) integration expert for TRON transaction fee optimization, fee payment modes, and reducing blockchain operation costs.

## Installation

### As Claude Code Plugin (Recommended)

Add the marketplace, then install the plugin:

```
/plugin marketplace add transatron/awesome-tron-agents
/plugin install awesome-tron-agents
```

Claude Code clones the repo, registers the catalog from `.claude-plugin/marketplace.json`, and copies the agents into its plugin cache. No manual file copying needed.

### Interactive Installer

Clone the repo and run the installer to pick agents and installation scope (global/local):

```bash
git clone https://github.com/transatron/awesome-tron-agents.git
cd awesome-tron-agents
./install-agents.sh
```

### Standalone Installer (no clone required)

```bash
curl -sO https://raw.githubusercontent.com/transatron/awesome-tron-agents/main/install-agents.sh
chmod +x install-agents.sh
./install-agents.sh
```

### Manual

Copy the agent files into your project:

```bash
mkdir -p .claude/agents
cp agents/tronweb-developer.md .claude/agents/
cp agents/transatron-integrator.md .claude/agents/
```

## Usage

Once installed, Claude Code will automatically route TRON-related questions to the appropriate agent. You can also invoke them directly:

```
/agents tronweb-developer
/agents transatron-integrator
```
