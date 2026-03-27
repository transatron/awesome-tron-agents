# Awesome TRON Agents for Claude Code

Specialized Claude Code agents for TRON blockchain development — architecture guidance, TronWeb SDK patterns, Transatron fee optimization, shielded transactions, and USDT0 cross-chain bridging.

## Agents

### Architecture (advisory — no code)

- [**tron-architect**](agents/tron-architect.md) — TRON platform architecture: resource model, energy/bandwidth economics, fee optimization strategy, smart contract lifecycle planning.
- [**transatron-architect**](agents/transatron-architect.md) — Transatron (Transfer Edge) solutions architecture: integration pattern selection, payment mode decisions, call_value top-up, business trade-offs.

### Implementation (writes code)

- [**tron-developer-tronweb**](agents/tron-developer-tronweb.md) — TronWeb SDK: building/signing/broadcasting transactions, wallet integration (TronLink, WalletConnect, Ledger).
- [**tron-integrator-trc20**](agents/tron-integrator-trc20.md) — TRC-20 tokens: transfer, approve, transferFrom with energy estimation, USDT dynamic penalty handling, operation-specific fallbacks.
- [**tron-integrator-sunswap**](agents/tron-integrator-sunswap.md) — SunSwap DEX swaps: Smart Exchange Router integration, swap path encoding, TRC-20 approve before swaps, energy estimation for swaps.
- [**transatron-integrator**](agents/transatron-integrator.md) — Transatron implementation: fee payment modes (account, instant, coupon, delayed), balance replenishment, programmatic registration.
- [**tron-integrator-shieldedusdt**](agents/tron-integrator-shieldedusdt.md) — Shielded TRC-20 privacy: zk-SNARK proof generation, mint/transfer/burn flows, note scanning.
- [**tron-integrator-usdt0**](agents/tron-integrator-usdt0.md) — USDT0 (LayerZero OFT) cross-chain transfers: quoting fees, building send transactions, call_value handling for bridging to Ethereum/Solana/TON.

## Installation

### As Claude Code Plugin (Recommended)

Add the marketplace, then install the plugin:

```
/plugin marketplace add transatron/awesome-tron-agents
/plugin install awesome-tron-agents
```

Claude Code clones the repo, registers the catalog from `.claude-plugin/marketplace.json`, and copies the agents into its plugin cache.

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

Copy agent files into your Claude Code agents directory:

```bash
mkdir -p .claude/agents
cp agents/*.md .claude/agents/
```

## Quick Start: Sending USDT Transfers

Send a real USDT transfer on TRON with optimized fees — agents handle the code generation.

**Prerequisites:** A TRON wallet with >30 TRX (for registration deposit) and some USDT.

```bash
# 1. Create project and .env
mkdir tron-usdt-test && cd tron-usdt-test
cat > .env << 'EOF'
WALLET_PK=<your-private-key>
RECIPIENT_ADDRESS=<distinct-wallet-address>
REGISTRATION_EMAIL=<your-real-email>
EOF

# 2. Install agents
claude plugin marketplace add transatron/awesome-tron-agents
claude plugin install awesome-tron-agents --scope local

# 3. Let Claude do the rest
claude -p "Register on Transatron using my email, save credentials to .env, \
then create a script that sends 0.01 USDT to RECIPIENT_ADDRESS via Transatron. \
Compare the cost with a regular TRON transfer. Use credentials from .env. \
I prefer a TypeScript stack."
```

> **Note:** The registration email becomes your dashboard login — use a real address, not a placeholder.

## Usage

Once installed, Claude Code automatically routes TRON-related questions to the appropriate agent based on the task. You can also invoke them directly:

```
/agents tron-architect
/agents tron-developer-tronweb
/agents tron-integrator-trc20
/agents tron-integrator-sunswap
/agents transatron-architect
/agents transatron-integrator
/agents tron-integrator-shieldedusdt
/agents tron-integrator-usdt0
```

## Recommended: TRON MCP Server

For the best experience, pair these agents with the [TRON MCP server](https://github.com/transatron/awesome-tron-mcp) — it gives agents direct access to on-chain data (balances, transactions, energy estimation, contract info) without leaving Claude Code.

## References

- [TronWeb SDK](https://tronweb.network/docu/docs/intro/)
- [Transatron](https://docs.transatron.io)
- [TRON Developer Docs](https://developers.tron.network/docs/)
